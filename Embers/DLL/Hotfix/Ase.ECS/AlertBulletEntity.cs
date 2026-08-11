using System;
using GameFramework;

namespace Ase.ECS;

public class AlertBulletEntity : BaseEntity
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
			SetData("bulletData", bulletData);
			_logicBullet = this.GetSystem<BulletSystem>().CreateAlertBulletLogic(this, bulletData);
			_bulletParentPropertyData = BulletParentPropertyData.Create(parent, bulletData.cfg);
			SetData("bulletParentPropertyData", _bulletParentPropertyData);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance.WriteAuthorityEntityId("创建预警子弹的时间", parent);
			}
		}
	}

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		_logicBullet?.OnAwake();
	}

	public override void OnStart(object data = null)
	{
		base.OnStart(data);
		_logicBullet?.OnStart();
	}

	public override void OnFixedUpdate(WorldUpdateType type, float deltaTime)
	{
		base.OnFixedUpdate(type, deltaTime);
		if (cacheTickUpdate)
		{
			_logicBullet?.OnFixedUpdate(deltaTime);
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId($"预警子弹。子弹位置  ：{base.transform.position}  Rotation ：{base.transform.rotation}    " + $"子弹父实体ConfigId  {parent.EntityId}", this);
			}
		}
	}

	public override void OnFixedUpdateAfter(WorldUpdateType type)
	{
		base.OnFixedUpdateAfter(type);
		if (cacheTickUpdate && _logicBullet == null)
		{
			GetComponent<BulletLifeComponent>().DoShadowEndLife();
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
	}

	public override EntityType GetEntityType()
	{
		return EntityType.BULLET;
	}

	protected override Type[] GetEntityComps()
	{
		return new Type[4]
		{
			typeof(BulletLifeComponent),
			typeof(BulletMoveComponent),
			typeof(BulletTriggerComponent),
			typeof(BulletHitJudgmentComponent)
		};
	}

	public override Type GetEntityView()
	{
		return null;
	}
}
