using System.Threading;
using ACT.Battle;
using ACT.Sound;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.AssetField;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/interactDamageArea")]
public class InteractDamageArea : StateObjectBase
{
	private DamageAreaData m_Data;

	private AssetLoadHandle m_Handle;

	private static readonly int STATEID = Animator.StringToHash("state");

	private Entity m_AttackEntity;

	private Animator m_Animator;

	private int m_Index;

	private bool m_init;

	private bool m_AnimatorInit;

	private int m_BehaveId;

	private CancellationTokenSource m_TokenSource;

	private float m_RunTimer;

	public override bool serviceSave => true;

	public override void InitStateObject(int stateId)
	{
		if (entity.GetCompStateObject()?.StateWorldAssetData is DamageAreaData data)
		{
			m_Data = data;
			m_TokenSource = new CancellationTokenSource();
			m_Handle = AssetStationManager.BattleStation.InstantiateAsync(m_Data.planePrefabAssetID, transform);
			m_Handle.Completed += Completed;
			CoSpawnAttackEntity().Forget();
			m_Index = m_Data.initIndex;
			m_BehaveId = m_Data.states[m_Index].stateId;
			base.InitStateObject(stateId);
		}
	}

	private async UniTaskVoid CoSpawnAttackEntity()
	{
		m_AttackEntity = GameManager.entities.factory.CreateMechanismTrapEntity();
		Entity eb = m_AttackEntity;
		eb.GetCompStateObject().StateWorldAssetData = m_Data;
		await MonoECS.instance.CoServerSpawnTrapAttack(eb, m_Data.attackId, m_Data.trapType, m_Data.defenceTowerType, m_Data.alliance, transform.position, transform.rotation, Vector3.one, m_Data.attackEntityWrapAssetID);
		if (!m_TokenSource.IsCancellationRequested)
		{
			MonoWeaponPart[] monoWeaponParts = eb.GetMono().GetWeaponPart("attackField").monoWeaponParts;
			foreach (MonoWeaponPart monoWeaponPart in monoWeaponParts)
			{
				m_Data.field.CopyTo(monoWeaponPart.myCollider as BoxCollider);
			}
			m_init = true;
		}
	}

	private void Completed(AssetLoadHandle handle)
	{
		GameObject gameObject = handle.AsGameObject();
		Transform transform = gameObject.transform;
		Vector3 center = m_Data.field.center;
		Vector3 size = m_Data.field.size;
		center.z += size.z / 2f;
		float x = size.x * 0.1f;
		float z = size.y * 0.1f;
		Vector3 localScale = new Vector3(x, 1f, z);
		transform.position = center + base.transform.position;
		transform.localScale = localScale;
		m_Animator = gameObject.transform.GetComponentInChildren<Animator>();
		m_Animator.SetInteger(STATEID, m_BehaveId);
		m_AnimatorInit = true;
	}

	public override void ReleaseStateObject()
	{
		m_TokenSource.Cancel();
		m_TokenSource.Dispose();
		if (AssetLoadHandleExtensions.IsValid(m_Handle))
		{
			m_Handle.Completed -= Completed;
			AssetStationManager.BattleStation.ReleaseInstance(m_Handle);
		}
		ReleaseAttackEntity().Forget();
		base.ReleaseStateObject();
	}

	private async UniTaskVoid ReleaseAttackEntity()
	{
		if (!m_AttackEntity.IsValid)
		{
			return;
		}
		if (m_AttackEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(m_AttackEntity);
			return;
		}
		await UniTask.WaitUntil(() => m_AttackEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(m_AttackEntity);
	}

	protected override void HandleInitState(int stateId)
	{
		if (stateId == -1)
		{
			gameObject.SetActive(value: false);
			CompAbility compAbility = m_AttackEntity.GetCompAbility();
			for (int i = 0; i < m_Data.abilities.Length; i++)
			{
				compAbility.RemoveAbility(m_Data.abilities[i]);
			}
			m_RunTimer = 0f;
		}
		else
		{
			gameObject.SetActive(value: true);
			SetState(m_BehaveId);
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return true;
	}

	public override bool CheckStateIdValid(int stateId)
	{
		return true;
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

	private void FixedUpdate()
	{
		if (!m_init || m_Data.states.Length == 0 || currentStateId == -1 || !(m_RunTimer > 0f))
		{
			return;
		}
		m_RunTimer -= entity.GetCompTime().fixedDeltaTime;
		if (m_RunTimer < 0f)
		{
			m_Index++;
			if (m_Index > m_Data.states.Length - 1)
			{
				m_Index = 0;
			}
			int stateId = m_Data.states[m_Index].stateId;
			ChangeBehaveState(stateId);
		}
	}

	private void ChangeBehaveState(int targetState)
	{
		if (targetState == m_BehaveId)
		{
			return;
		}
		CompAbility compAbility = m_AttackEntity.GetCompAbility();
		if (m_BehaveId == 2)
		{
			for (int i = 0; i < m_Data.abilities.Length; i++)
			{
				compAbility.RemoveAbility(m_Data.abilities[i]);
			}
		}
		m_BehaveId = targetState;
		SetState(m_BehaveId);
	}

	private void SetState(int targetState)
	{
		RunState(targetState);
		if (m_Animator != null && m_AnimatorInit)
		{
			m_Animator.SetInteger(STATEID, targetState);
		}
		Singleton<GameManager>.instance.audioManager.PlaySound(m_Data.states[m_Index].audioSound, new AudioPlayOptions
		{
			attachTarget = transform
		});
		if (targetState == 2)
		{
			m_AttackEntity.GetCompAbility().AddAbilities(m_Data.abilities, AbilitySource.Ability);
		}
	}

	private void RunState(int stateId)
	{
		AreaState[] states = m_Data.states;
		foreach (AreaState areaState in states)
		{
			if (areaState.stateId == stateId)
			{
				m_RunTimer = areaState.runTime;
				break;
			}
		}
	}
}
