using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/飞行道具/风刃")]
[DisallowMultipleComponent]
public class AdventureWindBlade : AdventureWeapon
{
	private enum Stage
	{
		None,
		Begin,
		Attack,
		End
	}

	public GameObject fx;

	public FP speed = 5f;

	public FP searchTargetTime = 5f;

	public FP searchRadius = 1f;

	public bool reboundToPlayer;

	public int reboundCount = 3;

	public FP endStageTime = 1f;

	public GameObject hittedEffectPrefab;

	public bool isHittedEffectScale = true;

	public bool effectIgnoreTimeScale = true;

	public FP damageImmuneDuration;

	public bool forbidddenHitS;

	private const int _hitLayer = 256;

	private DeterministicShape _searchShape;

	private List<DeterministicCollider> _targetList;

	private List<long> _targetListID;

	private AdventureFXPlayer _fxPlayer;

	private AdventureActor _target;

	private Stage _stage;

	private FP _searchTargetTime;

	private int _attackCount;

	private FP _endStageTime;

	public override bool isShootableWeapon => true;

	protected override void OnInit()
	{
		base.OnInit();
		_searchShape.shapeType = DeterministicShape.ShapeType.Circle;
		_searchShape.radius = searchRadius;
		_targetList = new List<DeterministicCollider>(10);
		if (forbidddenHitS)
		{
			_targetListID = new List<long>(10);
		}
	}

	public override void Setup(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP), AimType aimType = AimType.Default)
	{
		base.Setup(owner, position, positionY, direction, target, targetPosition, targetPositionY, aimType);
		velocitySpeed = speed;
		velocityDirection = tsTransform.Forward;
		tsTransform.PositionY = owner.tsTransform.PositionY + 1;
		_searchTargetTime = 0;
		_attackCount = 0;
		_endStageTime = 0;
		_targetList?.Clear();
		_targetListID?.Clear();
		_target = null;
		if (fx != null)
		{
			_fxPlayer = AdventureFXPlayer.PlayFX(fx, (float)logicTimeScale, transform.position, transform.rotation);
		}
		_stage = Stage.Begin;
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		switch (_stage)
		{
		case Stage.Begin:
			BeginStateUpdate();
			break;
		case Stage.Attack:
			AttackStageUpdate();
			break;
		case Stage.End:
			EndStageUpdate();
			break;
		}
	}

	private void BeginStateUpdate()
	{
		if (_stage != Stage.Begin)
		{
			return;
		}
		if (_target == null)
		{
			velocityDirection = tsTransform.Forward;
			_target = SearchTarget();
			MarkTargetId(_target);
			_searchTargetTime += LogicDeltaTime;
			if (_searchTargetTime > searchTargetTime)
			{
				Finish();
				return;
			}
		}
		else
		{
			velocityDirection = (_target.tsTransform.Position - tsTransform.Position).normalized;
			_stage = Stage.Attack;
		}
		tsTransform.Position += velocity * LogicDeltaTime;
		tsTransform.Forward = velocityDirection;
	}

	private void AttackStageUpdate()
	{
		if (_stage != Stage.Attack)
		{
			return;
		}
		if (_attackCount - 1 < reboundCount)
		{
			if (_target == null || _target.IsDead())
			{
				velocityDirection = tsTransform.Forward;
				_stage = Stage.End;
			}
			else
			{
				bool flag = true;
				if (_target is PlayerAdventureActor)
				{
					_target = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;
					MarkTargetId(_target);
					flag = false;
				}
				velocityDirection = (_target.tsTransform.Position - tsTransform.Position).normalized;
				if (_target.DistanceWithRadius(this) <= 0)
				{
					if (flag)
					{
						DeterministicRaycastHit raycastHit = new DeterministicRaycastHit
						{
							isValid = false
						};
						_hitBox.HitSingleTarget(uniqueAttackId, _target.dtCollider, out var _, out var _, ref raycastHit, hittedEffectPrefab, isHittedEffectScale: true, damageImmuneDuration, 1, effectIgnoreTimeScale);
					}
					_attackCount++;
					if (reboundCount > 0)
					{
						Rebound();
					}
				}
			}
			tsTransform.Position += velocity * LogicDeltaTime;
			tsTransform.Forward = velocityDirection;
		}
		else
		{
			_target = null;
			Finish();
		}
	}

	private void MarkTargetId(AdventureActor _target)
	{
		if (forbidddenHitS && !(_target == null) && !_targetListID.Contains(_target.Id))
		{
			_targetListID.Add(_target.Id);
		}
	}

	private void Rebound()
	{
		WindBladeReboundEvent windBladeReboundEvent = WindBladeReboundEvent.Generate();
		windBladeReboundEvent.sender = this;
		windBladeReboundEvent.owner = owner as AdventureActor;
		windBladeReboundEvent.windBlade = this;
		windBladeReboundEvent.reboundTime = _attackCount;
		windBladeReboundEvent.reboundWithPlayer = _target is PlayerAdventureActor;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(windBladeReboundEvent);
		_target = SearchTarget();
		MarkTargetId(_target);
	}

	private void EndStageUpdate()
	{
		velocityDirection = tsTransform.Forward;
		tsTransform.Position += velocity * LogicDeltaTime;
		tsTransform.Forward = velocityDirection;
		_endStageTime += LogicDeltaTime;
		if (_endStageTime > endStageTime)
		{
			Finish();
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

	private AdventureActor SearchTarget()
	{
		_searchShape.radius = searchRadius;
		_searchShape.position = tsTransform.Position;
		SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(_targetList, _searchShape, 256);
		_targetList.RemoveAll((DeterministicCollider collider) => CheckRemoveTarget(collider));
		if (_targetList.Count > 0)
		{
			return _targetList.get_Item(TSRandom.Range(0, _targetList.Count)).Entity as AdventureActor;
		}
		return null;
	}

	private bool CheckRemoveTarget(DeterministicCollider collider)
	{
		if (forbidddenHitS && _targetListID.Contains(collider.Entity.Id))
		{
			return true;
		}
		if (collider.Entity is DestructibleStateSingle || collider.Entity is TrapAdventureActor)
		{
			return true;
		}
		if (collider.Entity.IsSearchedImmunity())
		{
			return true;
		}
		if (collider.Entity.IsDead())
		{
			return true;
		}
		if (_attackCount <= 0)
		{
			return _owner.IsFriendlyWith(collider.Entity);
		}
		if (reboundToPlayer)
		{
			if (_target is PlayerAdventureActor)
			{
				if (!_owner.IsFriendlyWith(collider.Entity))
				{
					if (_target != null)
					{
						return collider.Entity.Id == _target.Id;
					}
					return false;
				}
				return true;
			}
			if (_target != null)
			{
				return collider.Entity.Id == _target.Id;
			}
			return false;
		}
		if (!_owner.IsFriendlyWith(collider.Entity))
		{
			if (_target != null)
			{
				return collider.Entity.Id == _target.Id;
			}
			return false;
		}
		return true;
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		_fxPlayer?.Stop();
		_fxPlayer = null;
		_stage = Stage.None;
		_owner = null;
		_searchTargetTime = 0;
		_attackCount = 0;
		_endStageTime = 0;
		_targetList?.Clear();
		_target = null;
	}

	public override bool OnHitActor(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity actor, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		AdventureActor adventureActor = actor as AdventureActor;
		if (!adventureActor.actorHealthInfo.isAlive)
		{
			return true;
		}
		_hitBox.hitDamageId = hitDamageId;
		(bool, long, bool) tuple = adventureActor.Damage(_owner, uniqueAttackId, onceAttackTargetCount, _hitBox.hitDamageId, hurtEffectPrefab, hitBox, isHittedEffectScale, showHud: true, effectIgnoreTimeScale);
		damaged = tuple.Item1;
		long item = tuple.Item2;
		SpecialEntityAfterDamageEvent specialEntityAfterDamageEvent = SpecialEntityAfterDamageEvent.Generate();
		specialEntityAfterDamageEvent.sender = this;
		specialEntityAfterDamageEvent.owner = owner;
		specialEntityAfterDamageEvent.damaged = damaged;
		specialEntityAfterDamageEvent.damage = item;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(specialEntityAfterDamageEvent);
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

	public override bool OnHitDestructibleObstacle(HitBox hitBox, int uniqueAttackId, int onceAttackTargetCount, LogicEntity entity, ref DeterministicRaycastHit raycastHit, out bool damaged, GameObject hurtEffectPrefab, bool isHittedEffectScale, bool effectIgnoreTimeScale = true)
	{
		damaged = false;
		return true;
	}
}
