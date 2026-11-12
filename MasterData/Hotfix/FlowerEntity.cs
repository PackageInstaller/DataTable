using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/特殊实体/花瓣")]
[DisallowMultipleComponent]
public class FlowerEntity : LogicEntity, ISpecialEntity
{
	public Animator _animator;

	public FP bornTime = 0.6f;

	public FP shootDeltaTime = 0.6f;

	public FP visualPositionSmoothFactor = 0.5f;

	public FP smoothDampMaxSpeed = 1000;

	public GameObject[] bulletPrefabs;

	public List<string> animationNames = new List<string> { "Attack1", "Attack2", "Attack3", "Attack4", "Attack5", "Attack6" };

	private CoroutineNode _triggerLogicCor;

	private Vector3 offset;

	private bool _inTriggerState;

	private FP visualDampPosVelocityX;

	private FP visualDampPosVelocityY;

	private FP visualDampPosVelocityZ;

	private int animState;

	private int HitId;

	private AdventureActor _actor;

	private FP waitTime;

	private LogicEntity _target;

	public AdventureActor Owner => SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor as AdventureActor;

	public bool InTriggerState => _inTriggerState;

	private Vector3 FollowPosition
	{
		get
		{
			if (Owner != null)
			{
				return Owner.transform.TransformPoint(offset);
			}
			return offset;
		}
	}

	private FP FollowRotation
	{
		get
		{
			if (!(Owner != null))
			{
				return default;
			}
			return Owner.tsTransform.Rotation;
		}
	}

	protected override void OnInit()
	{
		base.OnInit();
		HitId = 0;
		AddOrGetMonoLogicComponent<VisualSmooth>();
	}

	protected override void OnActive()
	{
		base.OnActive();
		tsTransform.transformSyncEnabled = false;
		visualDampPosVelocityX = default;
		visualDampPosVelocityY = default;
		visualDampPosVelocityZ = default;
	}

	public void Setup(AdventureActor _)
	{
		_inTriggerState = false;
		EnableLogicUpdate();
	}

	public void Finish()
	{
		SceneSingleton<SpecialEntityManager>.Instance.Despawn(transform);
	}

	protected override void OnLogicUpdate()
	{
		base.OnLogicUpdate();
		if (InTriggerState)
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
			if (Owner != null && _target != null)
			{
				tsTransform.Forward = (_target.tsTransform.Position - tsTransform.Position).normalized;
			}
			else
			{
				tsTransform.Rotation = FollowRotation;
			}
		}
	}

	public void SetHitdamageID(int _hitId)
	{
		HitId = _hitId;
	}

	public bool OnTrigger(TSVector offsetPos, AdventureActor actor)
	{
		_actor = actor;
		offset = new Vector3((float)offsetPos.x, (float)offsetPos.y, (float)offsetPos.z);
		Vector3 vector = Owner.transform.TransformPoint(offset);
		tsTransform.Position = new TSVector2(vector.x, vector.z);
		tsTransform.PositionY = vector.y;
		if (InTriggerState)
		{
			return false;
		}
		if (_animator == null)
		{
			return false;
		}
		if (_triggerLogicCor != null)
		{
			StopLogicCoroutine(_triggerLogicCor);
		}
		_triggerLogicCor = null;
		_triggerLogicCor = StartLogicCoroutine(TriggerLogic_Attack());
		_inTriggerState = true;
		return true;
	}

	protected LogicEntity GetAttackTarget()
	{
		if (Owner.attackTarget != null)
		{
			return Owner.attackTarget;
		}
		return ILRuntimeAPI.GetTargetNearByRange(Owner, 15);
	}

	private GameObject GetBullet(int index)
	{
		GameObject gameObject = null;
		if (bulletPrefabs != null && bulletPrefabs.Length != 0)
		{
			gameObject = ((index < bulletPrefabs.Length) ? bulletPrefabs[index] : bulletPrefabs[0]);
		}
		if (gameObject != null)
		{
			AdventureWeapon component = gameObject.GetComponent<AdventureWeapon>();
			if (component != null && HitId > 0)
			{
				component.hitDamageId = HitId;
			}
		}
		return gameObject;
	}

	protected IEnumerator TriggerLogic_Attack()
	{
		waitTime = bornTime;
		while (waitTime > 0)
		{
			waitTime -= Owner.LogicDeltaTime;
			yield return null;
		}
		for (animState = 0; animState < animationNames.Count; animState++)
		{
			_animator.Play(animationNames.get_Item(animState));
			_target = GetAttackTarget();
			if (_target != null)
			{
				ShootBehaviour shootBehaviour = _actor.shootBehaviour;
				if (shootBehaviour != null)
				{
					GameObject bullet = GetBullet(animState);
					TSVector2? position = tsTransform.Position;
					FP? positionY = tsTransform.PositionY;
					TSVector2? targetPosition = _target.tsTransform.Position;
					LogicEntity target = _target;
					shootBehaviour.Shoot(bullet, position, positionY, null, targetPosition, target, useShootDeviationCalcScatteringRadius: false, default, AimType.Target);
				}
			}
			else
			{
				_actor.shootBehaviour?.Shoot(GetBullet(animState), tsTransform.Position, tsTransform.PositionY, tsTransform.Forward, null, null, useShootDeviationCalcScatteringRadius: false, default, AimType.Default, null, targetNullUseActorTarget: false);
			}
			if (animState < animationNames.Count)
			{
				waitTime = shootDeltaTime;
				while (waitTime > 0)
				{
					waitTime -= Owner.LogicDeltaTime;
					yield return null;
				}
			}
			else
			{
				yield return null;
			}
		}
		Finish();
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		DisableLogicUpdate();
		tsTransform.transformSyncEnabled = true;
		if (_triggerLogicCor != null)
		{
			StopLogicCoroutine(_triggerLogicCor);
		}
		_triggerLogicCor = null;
	}
}
