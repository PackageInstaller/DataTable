using System;
using ACT.Battle;
using ACT.World.Actions;
using ACT.World.Asset;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using UnityEngine;

namespace ACT.World.StateObject;

[AddComponentMenu("ACT/StateObject/InteractLaser")]
public class InteractLaser : StateObjectBase
{
	[NonSerialized]
	public bool isStartTp;

	[NonSerialized]
	public Vector3 targetPos;

	private Vector3 startPosition;

	private Vector3 startRotate;

	private float time;

	[NonSerialized]
	public Entity laserEntity;

	public LaserData data { get; private set; }

	public override bool serviceSave => true;

	public override void Interact(int entryIndex, Entity eb, InteractAction.InteractSource interactSource)
	{
	}

	protected override void HandleEnterInteract()
	{
	}

	public override void InitStateObject(int stateId)
	{
		MonoECS instance = MonoECS.instance;
		if (entity.GetCompStateObject()?.StateWorldAssetData is LaserData laserData)
		{
			data = laserData;
			CoSpawnLaser(instance, laserData).Forget();
			base.InitStateObject(stateId);
		}
	}

	public override void ReleaseStateObject()
	{
		base.ReleaseStateObject();
		ReleaseAttackEntity().Forget();
	}

	private async UniTaskVoid ReleaseAttackEntity()
	{
		if (!laserEntity.IsValid)
		{
			return;
		}
		if (laserEntity.CanRemove())
		{
			MonoECS.instance.TryRemoveBehave(laserEntity);
			return;
		}
		await UniTask.WaitUntil(() => laserEntity.CanRemove(), PlayerLoopTiming.FixedUpdate);
		MonoECS.instance.TryRemoveBehave(laserEntity);
	}

	protected override void HandleInitState(int stateId)
	{
		if (currentStateId != 0)
		{
			_ = 1;
		}
		else
		{
			AddAbility();
		}
	}

	protected override bool NeedWaitTransition(int fromStateId, int toStateId)
	{
		return false;
	}

	private async UniTaskVoid CoSpawnLaser(MonoECS m_ECS, LaserData data)
	{
		laserEntity = GameManager.entities.factory.CreatLaserEntity();
		m_ECS.SpawnAttackInteractObject(laserEntity, data.id, data.trapType, data.defenceTowerType, transform.position, Alliance.Netural, Vector3.one, Quaternion.identity);
		laserEntity.GetCompStateObject().StateWorldAssetData = data;
		laserEntity.AddComponent<CompFollow>().FollowTarget = transform;
	}

	private void AddAbility()
	{
		laserEntity.GetCompAbility().AddAbilities(data.abilities, AbilitySource.Ability);
	}

	private void RemoveAbility()
	{
		CompAbility compAbility = laserEntity.GetCompAbility();
		for (int i = 0; i < data.abilities.Length; i++)
		{
			compAbility.RemoveAbility(data.abilities[i]);
		}
	}

	private void Start()
	{
		startPosition = transform.localPosition;
		startRotate = transform.eulerAngles;
	}

	private void FixedUpdate()
	{
		if (data != null && laserEntity.IsValid)
		{
			SystemTime timeSystem = GameManager.timeSystem;
			if (data.isMove)
			{
				time += timeSystem.globalSpeed * Time.fixedDeltaTime;
				float f = time % data.interval / data.interval * MathF.PI * 2f;
				Vector3 vector = Vector3.Scale(data.direction, new Vector3(Mathf.Sin(f), Mathf.Sin(f), Mathf.Cos(f))) * data.length;
				transform.localPosition = startPosition + vector;
				laserEntity.GetRootTransform().position = transform.localPosition;
			}
			if (data.isRotate)
			{
				time += timeSystem.globalSpeed * Time.fixedDeltaTime;
				float num = Mathf.Sin(time % data.interval / data.interval * MathF.PI * 2f);
				Vector3 vector2 = data.rotateAngle * num;
				transform.eulerAngles = startRotate + vector2;
				laserEntity.GetRootTransform().eulerAngles = transform.eulerAngles;
			}
		}
	}

	protected override void HandleUninitState(int stateId)
	{
		base.HandleUninitState(stateId);
		if (currentStateId != 0)
		{
			_ = 1;
		}
		else
		{
			RemoveAbility();
		}
	}

	protected override void HandleExitInteract()
	{
	}

	public override bool CheckStateIdValid(int stateId)
	{
		if (0 <= stateId)
		{
			return stateId <= 1;
		}
		return false;
	}
}
