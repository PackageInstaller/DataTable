using System.Collections.Generic;
using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器特性/追踪目标")]
public class WeaponFeatureTraceTarget : WeaponFeature
{
	[Space]
	public bool iActive = true;

	public bool iResetTraceStartTime;

	public FP traceRotateSpeed = 60f;

	public FP traceRange = 20f;

	public FP traceStartTime = 5f;

	public FP traceDuration = 5f;

	public FP tracePauseRange = 0f;

	public bool traceWhenSpawn;

	public bool traceWhenDie;

	protected FP _elapsedTime;

	protected LogicEntity _target;

	protected List<DeterministicCollider> _hitTargets;

	private FP _traceStartTime;

	public override void OnActive()
	{
		base.OnActive();
		_traceStartTime = traceStartTime;
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_elapsedTime = 0f;
		_target = null;
	}

	public override void OnUpdate()
	{
		if (!iActive)
		{
			return;
		}
		_elapsedTime += attachedWeapon.LogicDeltaTime;
		if (!(_elapsedTime > traceStartTime + traceDuration) && _elapsedTime > _traceStartTime)
		{
			if (attachedWeapon.aimType == AimType.Position)
			{
				TSVector2 to = TSVector2.Normalize(attachedWeapon.targetPosition - attachedWeapon.tsTransform.Position);
				attachedWeapon.velocityDirection = TrueSyncExtensions.RotateTowards(attachedWeapon.velocityDirection, to, traceRotateSpeed * attachedWeapon.LogicDeltaTime);
			}
			else
			{
				GetTarget();
				if (_target != null)
				{
					TSVector2 to2 = TSVector2.Normalize(_target.tsTransform.Position - attachedWeapon.tsTransform.Position);
					attachedWeapon.velocityDirection = TrueSyncExtensions.RotateTowards(attachedWeapon.velocityDirection, to2, traceRotateSpeed * attachedWeapon.LogicDeltaTime);
				}
				if (_target != null && tracePauseRange > 0)
				{
					attachedWeapon.isPauseMove = attachedWeapon.DistanceWithRadius(_target) <= tracePauseRange;
				}
			}
		}
		if (!iResetTraceStartTime)
		{
			return;
		}
		if (_target == null)
		{
			GetTarget();
		}
		if (!(_target == null))
		{
			TSVector2 origin = attachedWeapon.tsTransform.Position;
			TSVector2 direction = attachedWeapon.velocityDirection;
			if (SceneSingleton<DeterministicCollisionManager>.Instance.SphereCast(ref origin, ref direction, out var hitInfo, attachedWeapon.velocitySpeed * attachedWeapon.LogicDeltaTime, attachedWeapon.dtCollider.Radius, 256) && hitInfo.collider.Entity.Id == _target.Id)
			{
				_traceStartTime = _elapsedTime + traceStartTime;
			}
		}
	}

	private void GetTarget()
	{
		if (attachedWeapon.aimType == AimType.Position)
		{
			return;
		}
		ActorHealthInfo actorHealthInfo = ((_target == null) ? null : _target.GetLogicComponent<ActorHealthInfo>());
		if (_target == null || !actorHealthInfo.isAlive)
		{
			actorHealthInfo = ((attachedWeapon.target == null) ? null : attachedWeapon.target.GetLogicComponent<ActorHealthInfo>());
			if (attachedWeapon.target != null && actorHealthInfo.isAlive)
			{
				_target = attachedWeapon.target;
			}
			else
			{
				if (_hitTargets == null)
				{
					_hitTargets = new List<DeterministicCollider>();
				}
				if (SceneSingleton<DeterministicCollisionManager>.Instance.CheckCircleOverlap(traceRange, attachedWeapon.tsTransform.Position, _hitTargets, 256))
				{
					LogicEntity owner = attachedWeapon.owner;
					FP fP = FP.MaxValue;
					LogicEntity target = null;
					for (int i = 0; i < _hitTargets.Count; i++)
					{
						if (_hitTargets.get_Item(i).Entity is AdventureActor adventureActor && !(owner == null) && owner.IsConfrontWith(adventureActor) && CheckEntitySearchable(adventureActor) && (traceWhenSpawn || adventureActor.state != ActorState.Spawn) && (traceWhenDie || adventureActor.state != ActorState.Death))
						{
							FP fP2 = attachedWeapon.DistanceWithRadius(adventureActor);
							if (!(fP2 >= fP))
							{
								fP = fP2;
								target = adventureActor;
							}
						}
					}
					_target = target;
				}
			}
		}
		MonsterAdventureActor monsterAdventureActor = attachedWeapon.owner as MonsterAdventureActor;
		if (monsterAdventureActor != null && monsterAdventureActor.monsterTarget != null)
		{
			_target = monsterAdventureActor.monsterTarget;
		}
	}
}
