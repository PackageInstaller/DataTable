using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/飞行道具/回旋镖")]
[DisallowMultipleComponent]
public class AdventureBoomerang : AdventureWeapon
{
	protected enum State
	{
		Begin,
		ComeBack,
		CatchFailed,
		End
	}

	public string customTag;

	public GameObject fx;

	public bool syncScale = true;

	public FP positionY = 1;

	public FP speed = 1;

	public FP maxBeginStageTime = 1;

	public bool canWhirl = true;

	public bool clearHitRecordWhenWhirl = true;

	public bool followPlayer = true;

	public bool canCatch = true;

	public FP catchRadius = 1;

	public FP maxCatchFailedStageTime = 1;

	public GameObject hittedEffectPrefab;

	public bool isHittedEffectScale = true;

	public bool effectIgnoreTimeScale = true;

	public FP damageImmuneDuration;

	private AdventureFXPlayer _fxPlayer;

	private State _state;

	private bool _catchSuccess;

	private FP _beginStageTime;

	private FP _catchFailedStageTime;

	private AdventureActor CatchRefActor
	{
		get
		{
			AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance?.activedPlayerActor as AdventureActor;
			if (!(adventureActor != null))
			{
				return _owner as AdventureActor;
			}
			return adventureActor;
		}
	}

	public override bool isShootableWeapon => true;

	protected override void OnInit()
	{
		base.OnInit();
		if (_hitBox == null)
		{
			_hitBox = HitBox.Setup(gameObject, this, this);
			_hitBox.hitDamageId = hitDamageId;
			_hitBox.featureFlags = hitFlags;
			_hitBox.featureData = hitFeatureData;
			_hitBox.hurtAnimType = hurtAnimType;
		}
		_state = State.End;
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		if (!(owner is AdventureActor adventureActor))
		{
			return;
		}
		velocitySpeed = speed;
		tsTransform.PositionY = _owner.tsTransform.PositionY + this.positionY;
		if (fx != null)
		{
			FP fP = 1;
			if (syncScale && adventureActor.actorScaleInfo != null)
			{
				fP = adventureActor.actorScaleInfo.modelScale;
			}
			_fxPlayer = AdventureFXPlayer.PlayFX(fx, (float)logicTimeScale, transform.position, transform.rotation, (float)fP);
		}
		_state = State.Begin;
		_catchSuccess = false;
		_beginStageTime = 0;
		_catchFailedStageTime = 0;
	}

	public override void Finish(bool cancel = false, bool catched = false, bool ignorFinishFX = false)
	{
		BoomerangFinishEvent boomerangFinishEvent = BoomerangFinishEvent.Generate();
		boomerangFinishEvent.sender = this;
		boomerangFinishEvent.owner = owner as AdventureActor;
		boomerangFinishEvent.position = tsTransform.Position;
		boomerangFinishEvent.tag = customTag;
		boomerangFinishEvent.catchSucess = _catchSuccess;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(boomerangFinishEvent);
		base.Finish(cancel, catched, ignorFinishFX);
	}

	protected override void OnLogicUpdate()
	{
		if (_state != State.End)
		{
			switch (_state)
			{
			case State.Begin:
				BeginStageUpdate();
				break;
			case State.ComeBack:
				ComeBackStageUpdate();
				break;
			case State.CatchFailed:
				CatchFailedStageUpdate();
				break;
			}
			if (_state == State.End)
			{
				Finish();
			}
		}
	}

	protected override void OnVisualUpdate()
	{
		if (_fxPlayer != null)
		{
			_fxPlayer.transform.position = transform.position;
			_fxPlayer.transform.rotation = transform.rotation;
		}
	}

	private void BeginStageUpdate()
	{
		tsTransform.Position += velocity * LogicDeltaTime;
		Hit();
		if (_beginStageTime < maxBeginStageTime)
		{
			_beginStageTime += LogicDeltaTime;
		}
		else if (canWhirl)
		{
			AdventureActor catchRefActor = CatchRefActor;
			if (followPlayer && catchRefActor != null)
			{
				velocityDirection = (catchRefActor.tsTransform.Position - tsTransform.Position).normalized;
				tsTransform.Forward = velocityDirection;
			}
			else
			{
				velocityDirection = tsTransform.Back;
				tsTransform.Forward = velocityDirection;
			}
			if (clearHitRecordWhenWhirl)
			{
				_hitedActors.Clear();
			}
			_state = State.ComeBack;
		}
		else
		{
			_state = State.End;
		}
	}

	private void ComeBackStageUpdate()
	{
		tsTransform.Position += velocity * LogicDeltaTime;
		Hit();
		AdventureActor catchRefActor = CatchRefActor;
		if (followPlayer && catchRefActor != null)
		{
			velocityDirection = (catchRefActor.tsTransform.Position - tsTransform.Position).normalized;
			tsTransform.Forward = velocityDirection;
		}
		else
		{
			velocityDirection = tsTransform.Forward;
		}
		if (canCatch && catchRefActor != null)
		{
			if (TSVector2.DistanceSquared(tsTransform.Position, catchRefActor.tsTransform.Position) < catchRadius * catchRadius)
			{
				if (catchRefActor != _owner)
				{
					_state = State.CatchFailed;
					return;
				}
				velocityDirection = TSVector2.zero;
				_catchSuccess = true;
				_state = State.End;
			}
		}
		else
		{
			_state = State.CatchFailed;
		}
	}

	private void CatchFailedStageUpdate()
	{
		tsTransform.Position += velocity * LogicDeltaTime;
		Hit();
		if (_catchFailedStageTime < maxCatchFailedStageTime)
		{
			_catchFailedStageTime += LogicDeltaTime;
		}
		else
		{
			_state = State.End;
		}
	}

	private void Hit()
	{
		_hitBox.CircleAreaHit(dtCollider.Radius, 0, tsTransform.Position, out var _, out var _, uniqueAttackId, hittedEffectPrefab, isHittedEffectScale, -5, damageImmuneDuration, randomHit: false, effectIgnoreTimeScale);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		_fxPlayer?.Stop();
		_fxPlayer = null;
		_state = State.End;
		_catchSuccess = false;
		_beginStageTime = 0;
		_catchFailedStageTime = 0;
	}

	public override bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!(actor is AdventureActor adventureActor))
		{
			return false;
		}
		if (!adventureActor.actorHealthInfo.isAlive)
		{
			return true;
		}
		(damaged, _, _) = adventureActor.Damage(_owner, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}

	public override bool OnHitShield(HitBox hitBox, AdventureWeapon shield, ref DeterministicRaycastHit raycastHit)
	{
		return true;
	}

	public override bool OnHitObstacle(HitBox hitBox, AdventureObstacle obstacle, ref DeterministicRaycastHit raycastHit)
	{
		return true;
	}

	public override bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!(actor is AdventureActor adventureActor))
		{
			return false;
		}
		if (!adventureActor.CurrentStepCanbeHurt())
		{
			return true;
		}
		(damaged, _, _) = adventureActor.Damage(this, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		return true;
	}
}
