using System;
using GameFramework;

namespace Ase.ECS;

public class BulletEntity : BaseEntity, IObserverHandler
{
	private BulletParentPropertyData _bulletParentPropertyData;

	private LogicBullet _logicBullet;

	private BulletData bulletData;

	public override bool IsSyncEntity => true;

	public override void OnInit(object data = null)
	{
		base.OnInit(data);
		if (userData == null)
		{
			return;
		}
		bulletData = (BulletData)userData;
		if (bulletData != null)
		{
			SwitchEntityViewLerp(bulletData.ViewIsNeedLerp, bulletData.StableMovementSharpness, bulletData.StableRotationSharpness);
			SetData("bulletData", bulletData);
			_logicBullet = this.GetSystem<BulletSystem>().CreateBulletLogic(this, bulletData);
			_bulletParentPropertyData = BulletParentPropertyData.Create(parent, bulletData.cfg);
			_bulletParentPropertyData.ComputeBaseDamage();
			SetData("bulletParentPropertyData", _bulletParentPropertyData);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"创建子弹的时间 子弹ID : {bulletData.cfg.Id}", parent);
			}
		}
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		_logicBullet?.OnAwake();
		this.GetSystem<BattleObserverSystem>().Attach(BattleObserverEventEnum.ChangeTeam, this);
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_logicBullet?.OnStart();
	}

	public override void OnFixedUpdate(WorldUpdateType type, float deltaTime)
	{
		if (cacheTickUpdate && base.IsNeedUpdateCom)
		{
			_logicBullet?.OnFixedUpdate(deltaTime);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"子弹位置  ：{base.transform.position}  Rotation ：{base.transform.rotation}  子弹的父实体ID {parent.Id}  " + $"子弹父实体ConfigId  {parent.EntityId}", this);
			}
		}
		base.OnFixedUpdate(type, entityDeltaTime);
	}

	public override void OnFixedUpdateAfter(WorldUpdateType type)
	{
		if (cacheTickUpdate && base.IsNeedUpdateCom)
		{
			if (_logicBullet == null)
			{
				DoEntityDead();
			}
			base.OnFixedUpdateAfter(type);
		}
	}

	public override bool IgnoreTimeScale()
	{
		if (bulletData == null || bulletData.cfg == null)
		{
			return false;
		}
		return bulletData.cfg.IgnoreGlobalTimeScale;
	}

	public override void OnPauseBefore()
	{
		base.OnPauseBefore();
		DoEntityDead();
	}

	public override void OnLevelFail()
	{
		base.OnLevelFail();
		DoEntityDead();
	}

	public void OnNotify(IObserverParams param)
	{
		if (param.ObserverEventType == BattleObserverEventEnum.ChangeTeam)
		{
			DoEntityDead();
		}
	}

	public override void OnEntityRelease()
	{
		_logicBullet?.OnDead();
		base.OnEntityRelease();
	}

	public override void OnDispose()
	{
		_logicBullet?.OnDispose();
		if (bulletData != null)
		{
			ReferencePool.Release(bulletData);
		}
		bulletData = null;
		if (_bulletParentPropertyData != null)
		{
			ReferencePool.Release(_bulletParentPropertyData);
			_bulletParentPropertyData = null;
		}
		base.OnDispose();
		this.GetSystem<BattleObserverSystem>().Detach(BattleObserverEventEnum.ChangeTeam, this);
	}

	public override EntityType GetEntityType()
	{
		return EntityType.BULLET;
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[8]
		{
			typeof(BulletLifeComponent),
			typeof(BulletMoveComponent),
			typeof(BulletViewComponent),
			typeof(BulletTriggerComponent),
			typeof(BulletRayComponent),
			typeof(BulletHitJudgmentComponent),
			typeof(BulletDisplayComponent),
			typeof(SoundComponent)
		};
	}

	public override Type GetEntityView()
	{
		return typeof(BulletView);
	}
}
