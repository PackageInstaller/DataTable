using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/电鬼")]
[DisallowMultipleComponent]
public class LightingGhostEntity : LogicEntity, ISpecialEntity
{
	public enum LightingGhostType
	{
		Normal,
		Strengthen,
		Timid
	}

	public TSVector offset;

	public GameObject fxPrefab;

	public FP visualPositionSmoothFactor = 0.5f;

	public FP smoothDampMaxSpeed = 1000;

	public GameObject triggerFxPrefab;

	public FP triggerDurationTime = 0;

	public LightingGhostType type;

	public FP searchTargetRadius = 5;

	public int hitDamageId;

	public GameObject bulletPrefab;

	private AdventureFXPlayer _fxPlayer;

	private CoroutineNode _triggerLogicCor;

	private const string LightingGhostBulletTag = "LightingGhostBullet";

	private FP visualDampPosVelocityX;

	private FP visualDampPosVelocityY;

	private FP visualDampPosVelocityZ;

	private bool _inTriggerState;

	private List<DeterministicCollider> _searchTarges;

	private List<AdventureActor> _targets;

	private DeterministicShape _searchShape;

	private bool _enableDamageImmunity;

	private TSVector FollowPosition
	{
		get
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (activedPlayerActor != null)
			{
				return activedPlayerActor.tsTransform.Position3D + offset;
			}
			return offset;
		}
	}

	private FP FollowRotation
	{
		get
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (!(activedPlayerActor != null))
			{
				return default;
			}
			return activedPlayerActor.tsTransform.Rotation;
		}
	}

	public AdventureActor Owner => SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;

	public bool InTriggerState => _inTriggerState;

	protected override void OnInit()
	{
		base.OnInit();
		AddOrGetMonoLogicComponent<VisualSmooth>();
	}

	protected override void OnActive()
	{
		base.OnActive();
		tsTransform.transformSyncEnabled = false;
		visualDampPosVelocityX = default;
		visualDampPosVelocityY = default;
		visualDampPosVelocityZ = default;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_IMMUNITY_DAMAGE", OnImmunityDamage);
	}

	public void Setup(AdventureActor _)
	{
		if (fxPrefab != null)
		{
			_fxPlayer = AdventureFXPlayer.PlayFX(fxPrefab, 1f, transform.position, transform.rotation);
		}
		_inTriggerState = false;
		_enableDamageImmunity = false;
		EnableLogicUpdate();
	}

	public void Finish()
	{
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (!InTriggerState)
		{
			if (LogicDeltaTime > 0)
			{
				FP x = TSMath.SmoothDamp(tsTransform.Position3D.x, FollowPosition.x, ref visualDampPosVelocityX, visualPositionSmoothFactor, smoothDampMaxSpeed, LogicDeltaTime);
				FP positionY = TSMath.SmoothDamp(tsTransform.Position3D.y, FollowPosition.y, ref visualDampPosVelocityY, visualPositionSmoothFactor, smoothDampMaxSpeed, LogicDeltaTime);
				FP y = TSMath.SmoothDamp(tsTransform.Position3D.z, FollowPosition.z, ref visualDampPosVelocityZ, visualPositionSmoothFactor, smoothDampMaxSpeed, LogicDeltaTime);
				tsTransform.Position = new TSVector2(x, y);
				tsTransform.PositionY = positionY;
			}
			else
			{
				tsTransform.Position = new TSVector2(FollowPosition.x, FollowPosition.z);
				tsTransform.PositionY = FollowPosition.y;
			}
			tsTransform.Rotation = FollowRotation;
		}
	}

	protected override void OnVisualUpdate()
	{
		base.OnVisualUpdate();
		if (_fxPlayer != null)
		{
			_fxPlayer.transform.position = transform.position;
			_fxPlayer.transform.rotation = transform.rotation;
		}
	}

	public bool TryTrigger()
	{
		if (InTriggerState)
		{
			return false;
		}
		if (_triggerLogicCor != null)
		{
			StopLogicCoroutine(_triggerLogicCor);
		}
		_triggerLogicCor = null;
		switch (type)
		{
		case LightingGhostType.Normal:
		case LightingGhostType.Strengthen:
		{
			LogicEntity logicEntity = Owner.attackTarget ?? GetAttackTarget();
			if (logicEntity == null)
			{
				return false;
			}
			_triggerLogicCor = StartLogicCoroutine(TriggerLogic_Attack(logicEntity));
			break;
		}
		case LightingGhostType.Timid:
			_triggerLogicCor = StartLogicCoroutine(TriggerLogic_Timid());
			break;
		}
		_inTriggerState = true;
		return true;
	}

	protected IEnumerator TriggerLogic_Attack(LogicEntity target)
	{
		if (triggerFxPrefab != null)
		{
			AdventureFXPlayer.PlayFX(triggerFxPrefab, 1f, transform.position, Quaternion.identity);
		}
		long targetId = target.Id;
		TSVector2 targetPosition = target.tsTransform.Position;
		bool lockTarget = true;
		FP durationTime = triggerDurationTime;
		while (durationTime > 0)
		{
			if (target.Id == targetId && !target.IsDead())
			{
				targetPosition = target.tsTransform.Position;
				lockTarget = true;
			}
			else
			{
				lockTarget = false;
			}
			tsTransform.Forward = (targetPosition - tsTransform.Position).normalized;
			durationTime -= LogicDeltaTime;
			yield return null;
		}
		AdventureBulletBase adventureBulletBase = ((!lockTarget) ? Owner.shootBehaviour?.Shoot(bulletPrefab, tsTransform.Position, tsTransform.PositionY, tsTransform.Forward, targetPosition, null, useShootDeviationCalcScatteringRadius: false, default, AimType.Position) : Owner.shootBehaviour?.Shoot(bulletPrefab, tsTransform.Position, tsTransform.PositionY, tsTransform.Forward, null, target, useShootDeviationCalcScatteringRadius: false, default, AimType.Target));
		if (adventureBulletBase != null)
		{
			adventureBulletBase.hitDamageId = hitDamageId;
			adventureBulletBase.hitBox.hitDamageId = hitDamageId;
			adventureBulletBase.bulletTag = string.Format("{0}_{1}", "LightingGhostBullet", Id);
		}
		_fxPlayer?.Stop();
	}

	protected void OnBulletFinish(IEvent evt)
	{
		if (type != LightingGhostType.Normal && type != LightingGhostType.Strengthen)
		{
			return;
		}
		AdventureBulletFinishEvent adventureBulletFinishEvent = evt as AdventureBulletFinishEvent;
		if (adventureBulletFinishEvent.owner is PlayerAdventureActor)
		{
			string b = string.Format("{0}_{1}", "LightingGhostBullet", Id);
			if (string.Equals(adventureBulletFinishEvent.tag, b))
			{
				Finish();
			}
		}
	}

	protected LogicEntity GetAttackTarget()
	{
		_searchShape.shapeType = DeterministicShape.ShapeType.Circle;
		_searchShape.position = Owner.tsTransform.Position;
		_searchShape.radius = searchTargetRadius;
		_searchShape.innerRadius = 0;
		if (_searchTarges == null)
		{
			_searchTarges = new List<DeterministicCollider>(5);
		}
		SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(_searchTarges, _searchShape, 256);
		if (_searchTarges.Count <= 0)
		{
			return null;
		}
		if (_targets == null)
		{
			_targets = new List<AdventureActor>(5);
		}
		else
		{
			_targets.Clear();
		}
		for (int i = 0; i < _searchTarges.Count; i++)
		{
			AdventureActor adventureActor = _searchTarges.get_Item(i).Entity as AdventureActor;
			if (adventureActor is MonsterAdventureActor)
			{
				_targets.Add(adventureActor);
			}
		}
		if (_targets.Count <= 0)
		{
			return null;
		}
		return _targets.get_Item(TSRandom.Range(0, _targets.Count));
	}

	protected IEnumerator TriggerLogic_Timid()
	{
		if (triggerFxPrefab != null)
		{
			AdventureFXPlayer.PlayFX(triggerFxPrefab, 1f, Owner.transform.position, Quaternion.identity).Bind(Owner.gameObject);
		}
		yield return triggerDurationTime;
		_fxPlayer?.Stop();
		Finish();
	}

	protected void OnBeforeHit(IEvent evt)
	{
		if (type == LightingGhostType.Timid && (evt as AdventureActorReceiveDamageBeforeHitEvent).to is PlayerAdventureActor && !_enableDamageImmunity)
		{
			_enableDamageImmunity = true;
			Owner.EnableDamageImmunity();
		}
	}

	protected void OnImmunityDamage(IEvent evt)
	{
		if (type == LightingGhostType.Timid && (evt as AdventureActorImmunityDamageEvent).to is PlayerAdventureActor && _enableDamageImmunity)
		{
			_enableDamageImmunity = false;
			Owner.DisableDamageImmunity();
			TryTrigger();
		}
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BULLET_FINISH", OnBulletFinish);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_RECEIVE_DAMAGE_BEFORE_HIT", OnBeforeHit);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_IMMUNITY_DAMAGE", OnImmunityDamage);
		DisableLogicUpdate();
		tsTransform.transformSyncEnabled = true;
		if (_triggerLogicCor != null)
		{
			StopLogicCoroutine(_triggerLogicCor);
		}
		_triggerLogicCor = null;
		_searchTarges?.Clear();
		_targets?.Clear();
		_enableDamageImmunity = false;
		_fxPlayer?.Stop();
		_fxPlayer = null;
	}
}
