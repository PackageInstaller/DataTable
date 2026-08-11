using GameFramework;

namespace Ase.ECS;

public abstract class LogicBullet : IReference
{
	protected BaseEntity bullet;

	protected BulletData _bulletData;

	private BulletRangeTypeEnum _rangeTypeEnum;

	public BulletRangeTypeEnum RangeTypeEnum => _rangeTypeEnum;

	public virtual void OnInit(object data)
	{
		bullet = (BaseEntity)data;
		_bulletData = bullet.GetData<BulletData>("bulletData");
		_rangeTypeEnum = _bulletData.cfg.BulletRangeTypeEnum;
	}

	public virtual void OnAwake()
	{
	}

	public virtual void OnStart()
	{
	}

	public virtual void OnUpdate(float deltaTime)
	{
	}

	public virtual void OnFixedUpdate(float deltaTime)
	{
	}

	public virtual void OnDead()
	{
	}

	public abstract void OnDispose();

	public void Clear()
	{
		bullet = null;
		_bulletData = null;
	}

	protected abstract void OnClear();
}
