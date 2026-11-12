using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/飞行道具/飞盾")]
[DisallowMultipleComponent]
public class AdventureFlyShield : AdventureWeapon
{
	private enum State
	{
		Begin,
		Rebound,
		ComeBack,
		End
	}

	[Space]
	public GameObject fx;

	public GameObject trailFx;

	public bool syncScale = true;

	public FP positionY = 1;

	public FP maxBeginTime = 2;

	public FP moveSpeed = 10;

	public FP triggerRadius = 1;

	public int reboundTime;

	public FP searchRadius = 10;

	public GameObject hittedEffectPrefab;

	public bool isHittedEffectScale = true;

	public bool effectIgnoreTimeScale = true;

	public FP damageImmuneDuration;

	private AdventureFXPlayer _fxPlayer;

	private AdventureFXPlayer _trailFxPlayer;

	private DeterministicShape _deterministicShape;

	private FP _moveTime;

	private State _state;

	private AdventureActor _attackTarget;

	private int _reboundTime;

	private readonly List<DeterministicCollider> _targetList = new List<DeterministicCollider>(10);

	private readonly HashSet<long> _attackedMap = new HashSet<long>(10);

	private AdventureActor lastTarget;

	public override bool isShootableWeapon => true;

	protected override void OnInit()
	{
		base.OnInit();
		_state = State.End;
		_deterministicShape.shapeType = DeterministicShape.ShapeType.Circle;
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		velocitySpeed = moveSpeed;
		_targetList.Clear();
		_attackedMap.Clear();
		tsTransform.PositionY = _owner.tsTransform.PositionY + this.positionY;
		_moveTime = 0;
		_reboundTime = 0;
		_state = State.Begin;
		_attackTarget = target as AdventureActor;
		lastTarget = _attackTarget;
		FP fP = 1;
		if (syncScale && owner is AdventureActor adventureActor)
		{
			fP = adventureActor.actorScaleInfo.modelScale;
		}
		if (fx != null)
		{
			_fxPlayer = AdventureFXPlayer.PlayFX(fx, 1f, transform.position, transform.rotation, fP.AsFloat());
			_fxPlayer.Bind(gameObject);
			_fxPlayer.ownerActor = owner as AdventureActor;
			_fxPlayer.syncNode = transform;
		}
		if (trailFx != null)
		{
			_trailFxPlayer = AdventureFXPlayer.PlayFX(trailFx, 1f, transform.position, transform.rotation, fP.AsFloat());
			_trailFxPlayer.Bind(gameObject);
			_trailFxPlayer.ownerActor = owner as AdventureActor;
			_trailFxPlayer.syncNode = transform;
		}
	}

	public override void Finish(bool cancel = false, bool catched = false, bool ignorFinishFX = false)
	{
		FlyShieldComeBackEvent flyShieldComeBackEvent = FlyShieldComeBackEvent.Generate();
		flyShieldComeBackEvent.sender = this;
		flyShieldComeBackEvent.owner = owner as AdventureActor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(flyShieldComeBackEvent);
		base.Finish(cancel, catched, ignorFinishFX);
	}

	protected override void OnLogicUpdate()
	{
		if (_state == State.End)
		{
			Finish();
			return;
		}
		_moveTime += LogicDeltaTime;
		switch (_state)
		{
		case State.Begin:
			_state = BeginStateUpdate();
			break;
		case State.Rebound:
			_state = ReboundStateUpdate();
			break;
		case State.ComeBack:
			_state = ComeBackStateUpdate();
			break;
		}
	}

	private State BeginStateUpdate()
	{
		velocityDirection = tsTransform.Forward;
		tsTransform.Position += velocity * LogicDeltaTime;
		_targetList.Clear();
		if (_attackTarget == null)
		{
			_deterministicShape.position = tsTransform.Position;
			_deterministicShape.rotation = tsTransform.Rotation;
			_deterministicShape.radius = triggerRadius;
			SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(_targetList, _deterministicShape, 256);
			if (_targetList.Count > 0)
			{
				for (int i = 0; i < _targetList.Count; i++)
				{
					AdventureActor adventureActor = _targetList.get_Item(i).Entity as AdventureActor;
					if (CanTrigger(adventureActor))
					{
						_attackTarget = adventureActor;
						SendHitEvent(_attackTarget);
						Hit();
						if (reboundTime <= 0)
						{
							return State.ComeBack;
						}
						_attackTarget = GetReboundTarget();
						if (!(_attackTarget != null))
						{
							return State.ComeBack;
						}
						return State.Rebound;
					}
				}
			}
			else if (_moveTime >= maxBeginTime)
			{
				return State.ComeBack;
			}
			return State.Begin;
		}
		if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor != null && _attackTarget.Id == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id)
		{
			_reboundTime--;
		}
		return State.Rebound;
	}

	private State ReboundStateUpdate()
	{
		if (_attackTarget == null || !_attackTarget.actorHealthInfo.isAlive)
		{
			return State.ComeBack;
		}
		velocityDirection = (_attackTarget.tsTransform.Position - tsTransform.Position).normalized;
		tsTransform.Position += velocity * LogicDeltaTime;
		tsTransform.Forward = velocityDirection;
		if (_attackTarget.DistanceWithRadius(this) <= 0)
		{
			_reboundTime++;
			SendHitEvent(_attackTarget);
			Hit();
			if (_reboundTime >= reboundTime)
			{
				return State.ComeBack;
			}
			_attackTarget = GetReboundTarget();
		}
		return State.Rebound;
	}

	protected void Hit()
	{
		if (!(_attackTarget == null))
		{
			DeterministicRaycastHit raycastHit = new DeterministicRaycastHit
			{
				isValid = false
			};
			_hitBox.HitSingleTarget(SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), _attackTarget.dtCollider, out var _, out var _, ref raycastHit, hittedEffectPrefab, isHittedEffectScale, damageImmuneDuration, 1, effectIgnoreTimeScale);
			_attackedMap.Add(_attackTarget.Id);
		}
	}

	private State ComeBackStateUpdate()
	{
		AdventureActor adventureActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
		if (adventureActor != null)
		{
			FP fP = TSVector2.Distance(adventureActor.tsTransform.Position, tsTransform.Position);
			if (fP < 0.1)
			{
				AdventureActor adventureActor2 = ReSearchTarget();
				if (adventureActor2 != null)
				{
					_attackTarget = adventureActor2;
					return State.Rebound;
				}
				_reboundTime = 0;
				if (lastTarget != adventureActor)
				{
					SendHitEvent(adventureActor);
				}
				return State.End;
			}
			if (fP / moveSpeed <= LogicDeltaTime)
			{
				AdventureActor adventureActor3 = ReSearchTarget();
				if (adventureActor3 != null)
				{
					_attackTarget = adventureActor3;
					return State.Rebound;
				}
				_reboundTime = 0;
				if (lastTarget != adventureActor)
				{
					SendHitEvent(adventureActor);
				}
				tsTransform.Position = adventureActor.tsTransform.Position;
				return State.End;
			}
			velocityDirection = (adventureActor.tsTransform.Position - tsTransform.Position).normalized;
			tsTransform.Position += velocity * LogicDeltaTime;
			tsTransform.Forward = velocityDirection;
			return State.ComeBack;
		}
		Finish();
		return State.End;
	}

	private AdventureActor ReSearchTarget()
	{
		if (_reboundTime >= reboundTime)
		{
			return null;
		}
		return GetReboundTarget();
	}

	protected AdventureActor GetReboundTarget()
	{
		_targetList.Clear();
		_deterministicShape.position = tsTransform.Position;
		_deterministicShape.rotation = tsTransform.Rotation;
		_deterministicShape.radius = searchRadius;
		SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(_targetList, _deterministicShape, 256);
		int num = -1;
		FP fP = 1000000;
		for (int i = 0; i < _targetList.Count; i++)
		{
			AdventureActor adventureActor = _targetList.get_Item(i).Entity as AdventureActor;
			if (CanTrigger(adventureActor) && _attackTarget != null && adventureActor.Id != _attackTarget.Id)
			{
				FP fP2 = adventureActor.DistanceWithRadius(this);
				if (_attackedMap.Contains(adventureActor.Id))
				{
					fP2 += (FP)100;
				}
				if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor != null && adventureActor.Id == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id)
				{
					fP2 += (FP)(reboundTime * 100);
				}
				if (fP2 < fP)
				{
					fP = fP2;
					num = i;
				}
			}
		}
		if (num >= 0)
		{
			lastTarget = _targetList.get_Item(num).Entity as AdventureActor;
			return lastTarget;
		}
		return null;
	}

	private bool CanTrigger(AdventureActor target)
	{
		if (target == null)
		{
			return false;
		}
		if (target is DestructibleStateSingle || target is TrapAdventureActor)
		{
			return false;
		}
		if (target.IsSearchedImmunity())
		{
			return false;
		}
		if (target.IsDead())
		{
			return false;
		}
		if (SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor != null && target.Id == SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.Id && target.Id != owner.Id)
		{
			return true;
		}
		return _owner.IsConfrontWith(target);
	}

	protected void SendHitEvent(AdventureActor target)
	{
		FlyShieldHitEvent flyShieldHitEvent = FlyShieldHitEvent.Generate();
		flyShieldHitEvent.sender = this;
		flyShieldHitEvent.owner = owner as AdventureActor;
		flyShieldHitEvent.target = target;
		flyShieldHitEvent.reboundTime = _reboundTime - 1;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(flyShieldHitEvent);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		_fxPlayer?.Stop();
		_fxPlayer = null;
		_trailFxPlayer?.Stop();
		_trailFxPlayer = null;
		_state = State.End;
		_moveTime = 0;
		_reboundTime = 0;
		_attackTarget = null;
		_targetList.Clear();
		_attackedMap.Clear();
	}

	public override bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale = true, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		if (!actor.GetLogicComponent<ActorHealthInfo>().isAlive)
		{
			return true;
		}
		(damaged, _, _) = (actor as AdventureActor).Damage(_owner, uniqueAttackId, onceAttackTargetCount, hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
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
		return true;
	}
}
