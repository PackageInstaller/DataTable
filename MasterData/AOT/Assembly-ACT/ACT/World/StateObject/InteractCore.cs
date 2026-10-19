using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Utility;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Cysharp.Threading.Tasks.Linq;
using UnityEngine;

namespace ACT.World.StateObject;

public class InteractCore : StateObjectBase
{
	public Alliance alliance = Alliance.Enemy;

	public string[] abilities;

	public int attackAbleId = 2;

	public float time;

	public float speed;

	private AssetLoadHandle[] m_Handles;

	private InteractCoreData m_Data;

	private Entity attackEntity;

	private Vector3 size;

	private int m_InitStateId;

	private IDisposable syncAttackablePositionDisposable;

	private bool m_DoNext;

	public override bool serviceSave => true;

	private MonoECS m_Ecs => MonoECS.instance;

	public override void InitStateObject(int stateId)
	{
		if (!(entity.GetCompStateObject()?.StateWorldAssetData is InteractCoreData data))
		{
			return;
		}
		m_Data = data;
		speed = m_Data.speed;
		time = m_Data.delayTime;
		List<Vector3> pos = m_Data.pos;
		Vector3 scale = m_Data.scale;
		int length = m_Data.length;
		size.x = scale.x * (float)length;
		size.y = scale.y * (float)length;
		size.z = scale.z * (float)length;
		m_Handles = new AssetLoadHandle[pos.Count];
		m_InitStateId = stateId;
		for (int i = 0; i < pos.Count; i++)
		{
			int num = i;
			if (num == 0)
			{
				m_Handles[num] = AssetStationManager.BattleStation.InstantiateAsync(m_Data.headPrefabAssetID, transform);
			}
			else
			{
				m_Handles[num] = AssetStationManager.BattleStation.InstantiateAsync(m_Data.bodyPrefabAssetID, transform);
			}
		}
		base.InitStateObject(stateId);
	}

	private void Completed(GameObject obj)
	{
		Vector3 zero = Vector3.zero;
		int indexOfHandles = GetIndexOfHandles(obj);
		zero.x = m_Data.pos[indexOfHandles].x * m_Data.scale.x * (float)m_Data.length;
		zero.y = m_Data.pos[indexOfHandles].y * m_Data.scale.y * (float)m_Data.length;
		zero.z = m_Data.pos[indexOfHandles].z * m_Data.scale.z * (float)m_Data.length;
		Vector3 position = zero + transform.position;
		obj.transform.position = position;
		obj.transform.localScale = m_Data.scale;
		if (indexOfHandles == 0)
		{
			CoSpawnAttackEntity(m_Ecs, m_Data, m_Handles[indexOfHandles].AsGameObject().transform).Forget();
			obj.transform.GetComponentInChildren<Animator>().SetInteger("state", m_InitStateId);
		}
		else
		{
			obj.gameObject.GetComponentInChildren<Animator>().SetInteger("state", m_InitStateId);
			obj.gameObject.GetComponentInChildren<BoxCollider>().enabled = m_InitStateId == 0;
		}
	}

	private int GetIndexOfHandles(GameObject obj)
	{
		for (int i = 0; i < m_Handles.Length; i++)
		{
			if (m_Handles[i].Equals(obj))
			{
				return i;
			}
		}
		return -1;
	}

	private async UniTask CoSpawnAttackEntity(MonoECS monoEcs, InteractCoreData data, Transform parent)
	{
		attackEntity = GameManager.entities.factory.CreateAttackEntity();
		Entity eb = attackEntity;
		monoEcs.SpawnAttackInteractObject(attackEntity, attackAbleId, data.trapType, data.defenceTowerType, parent.position, alliance, size, data.initRotate);
		eb.GetCompStateObject().StateWorldAssetData = data;
		CompAbility compAbility = eb.GetCompAbility();
		if (abilities != null)
		{
			compAbility.AddAbilities(abilities, AbilitySource.Ability);
		}
		compAbility.damageableHited = (Action<Entity>)Delegate.Combine(compAbility.damageableHited, new Action<Entity>(OnHited));
		syncAttackablePositionDisposable = UniTaskAsyncEnumerable.EveryUpdate(PlayerLoopTiming.FixedUpdate).Subscribe((AsyncUnit _) =>
		{
			if (attackEntity.IsValid)
			{
				eb.GetRootTransform().position = parent.position;
			}
		});
	}

	private void OnHited(Entity attacker)
	{
		int num = m_Handles.Length - 1;
		if (currentStateId == 0 && attackEntity.IsValid && attackEntity.IsLogicAvailable() && m_Handles[num].AsGameObject().GetComponent<Animator>().GetCurrentAnimatorStateInfo(0)
			.IsName("active"))
		{
			HideDither().Forget();
			m_Handles[0].AsGameObject().GetComponentInChildren<Animator>().SetInteger("state", 1);
		}
		if (currentStateId == 1 && attackEntity.IsValid && attackEntity.IsLogicAvailable() && m_Handles[1].AsGameObject().GetComponent<Animator>().GetCurrentAnimatorStateInfo(0)
			.IsName("newNone"))
		{
			DoChangeCollider().Forget();
			ShowDither().Forget();
			m_Handles[0].AsGameObject().GetComponentInChildren<Animator>().SetInteger("state", 0);
		}
	}

	private async UniTask ShowDither()
	{
		for (int i = 1; i < m_Handles.Length; i++)
		{
			m_Handles[i].AsGameObject().GetComponentInChildren<Animator>().SetInteger("state", 0);
			await UniTask.Delay(TimeSpan.FromSeconds(time));
		}
		NetEnterState(0).Forget();
	}

	private async UniTask HideDither()
	{
		for (int i = m_Handles.Length - 1; i > 0; i--)
		{
			m_Handles[i].AsGameObject().GetComponentInChildren<Animator>().SetInteger("state", 1);
			m_Handles[i].AsGameObject().GetComponentInChildren<BoxCollider>().enabled = false;
			await UniTask.Delay(TimeSpan.FromSeconds(time));
		}
		NetEnterState(1).Forget();
	}

	private async UniTask DoChangeCollider()
	{
		for (int i = 1; i < m_Handles.Length; i++)
		{
			ChangeCollider(i);
			await UniTask.WaitUntil(() => m_DoNext);
		}
	}

	private async UniTask ChangeCollider(int index)
	{
		GameObject gameObject = m_Handles[index].AsGameObject();
		BoxCollider c = gameObject.GetComponentInChildren<BoxCollider>();
		c.enabled = true;
		m_DoNext = false;
		Vector3 position = m_Handles[index - 1].AsGameObject().transform.position;
		c.transform.TransformPoint(c.center);
		Vector3 center = position;
		while (true)
		{
			Vector3 position2 = c.transform.position;
			Vector3 vector = InterpolationUtility.FixedLerp(center, position2, speed * Time.fixedDeltaTime, out var _);
			center = vector;
			Vector3 center2 = c.transform.InverseTransformPoint(center);
			c.center = center2;
			if (c.transform.InverseTransformPoint(center).isZero())
			{
				break;
			}
			await UniTask.Yield(PlayerLoopTiming.FixedUpdate);
		}
		m_DoNext = true;
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
	}

	protected override void HandleInitState(int stateId)
	{
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return true;
	}

	public override void ReleaseStateObject()
	{
		for (int i = 0; i < m_Handles.Length; i++)
		{
			if (m_Handles[i].IsValid)
			{
				AssetStationManager.BattleStation.ReleaseInstance(m_Handles[i]);
			}
		}
		MonoECS.instance.TryRemoveBehave(attackEntity);
		syncAttackablePositionDisposable.Dispose();
	}

	public void OnDestroy()
	{
		syncAttackablePositionDisposable.Dispose();
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (stateId >= 0)
		{
			return stateId <= 1;
		}
		return false;
	}

	protected override void HandleEnterInteract()
	{
	}

	protected override void HandleExitInteract()
	{
	}

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}
}
