using System.Collections.Generic;

namespace Ase.ECS;

public class BulletLifeComponent : BaseComponent
{
	protected BulletData _bulletData;

	private BulletLifeTypeEnum _lifeTypeEnum;

	private float _maxLifeTime = 600f;

	private float _remainingLifeTime;

	private float _totalLifeTime;

	public float LifeTime => _totalLifeTime - _remainingLifeTime;

	public float TotalLifeTime => _totalLifeTime;

	public override void OnAwake(object data = null)
	{
		_bulletData = GetData<BulletData>("bulletData");
		_lifeTypeEnum = _bulletData.cfg.BulletLifeTypeEnum;
		_remainingLifeTime = GetBulletLifeTime();
		if (_remainingLifeTime <= 0f || _remainingLifeTime > _maxLifeTime)
		{
			_remainingLifeTime = _maxLifeTime;
		}
		_totalLifeTime = _remainingLifeTime;
	}

	protected virtual float GetBulletLifeTime()
	{
		if (mBaseEntity is AlertBulletEntity)
		{
			return _bulletData.alert_lifeTime;
		}
		return _bulletData.cfg.Duration;
	}

	public void DoUpdateLife(float deltaTime)
	{
		if (!mBaseEntity.IsSurvival || (_lifeTypeEnum != BulletLifeTypeEnum.Time && _lifeTypeEnum != BulletLifeTypeEnum.TriggerCount))
		{
			return;
		}
		_remainingLifeTime -= deltaTime;
		if (_remainingLifeTime <= 0f)
		{
			float bulletLifeTime = GetBulletLifeTime();
			if (bulletLifeTime <= 0f || bulletLifeTime > _maxLifeTime)
			{
				_remainingLifeTime = _maxLifeTime;
				return;
			}
			mBaseEntity.GetComponent<BulletDisplayComponent>()?.OnDisplay("EndTime");
			mBaseEntity.DoEntityDead();
		}
	}

	public void DoHandleZeroTriggerCount()
	{
		if (_lifeTypeEnum == BulletLifeTypeEnum.TriggerCount)
		{
			mBaseEntity.DoEntityDead();
		}
	}

	private void CreateBulletAfterDestroy()
	{
		if (mBaseEntity != null && mBaseEntity.EntityData != null && _bulletData != null && _bulletData.cfg != null && _bulletData.cfg.CreateAfterDestroy != null && mBaseEntity.GetSystem<BulletSystem>() != null)
		{
			for (int i = 0; i < _bulletData.cfg.CreateAfterDestroy.Count; i++)
			{
				mBaseEntity.GetSystem<BulletSystem>().CreateBulletEntity(mBaseEntity.Parent, _bulletData.cfg.CreateAfterDestroy[i], mBaseEntity.transform.position, mBaseEntity.transform.eulerAngles, mBaseEntity.EntityData.currentTickCreate, null, mBaseEntity.ViewNeedLerp, mBaseEntity.ViewMovementSharpness, mBaseEntity.ViewRotationSharpness);
			}
		}
	}

	public void DoEndLife()
	{
		CreateBulletAfterDestroy();
		AddPropertyOnDead();
	}

	private void AddPropertyOnDead()
	{
		BulletHitJudgmentComponent component = mBaseEntity.GetComponent<BulletHitJudgmentComponent>();
		if (component == null || component.IsHitEntity())
		{
			return;
		}
		List<List<string>> missProperty = _bulletData.cfg.MissProperty;
		if (missProperty.IsNullOrEmpty())
		{
			return;
		}
		List<string> list = new List<string>();
		HeroEntity heroEntity = mBaseEntity.Parent as HeroEntity;
		for (int i = 0; i < missProperty.Count; i++)
		{
			List<string> list2 = missProperty[i];
			if (list2.Count == 3 && list2[0] == "Weapon")
			{
				float value = Utility.Convert.StringToFloat(list2[2]);
				heroEntity?.BattleHeroData?.WeaponMechanismBase?.AddWeaponValueByDamageProgress(null, list2[1], value);
			}
			else if (list2.Count == 2)
			{
				list.AddRange(list2);
			}
		}
		HandlePropertyAddition(list);
	}

	protected void HandlePropertyAddition(List<string> propertyList)
	{
		PropertyAdditionData[] array = BattleFormulaUtility.PropertyStringListToAddition(propertyList);
		if (array != null)
		{
			HandlePropertyAddition(array);
		}
	}

	private void HandlePropertyAddition(PropertyAdditionData[] additions)
	{
		float num = 0f;
		BaseEntity parent = mBaseEntity.Parent;
		if (parent == null)
		{
			return;
		}
		foreach (PropertyAdditionData propertyAdditionData in additions)
		{
			if (propertyAdditionData.propertyKey == "Energy")
			{
				num += CalcEnergyPropertyAddition(parent, propertyAdditionData);
			}
			else
			{
				parent.SetProperty(propertyAdditionData);
			}
		}
		if (num != 0f)
		{
			mBaseEntity.GetSystem<BattleSystem>().OnEnergyChangeStat(parent.Id, EnergyRecoverEnum.Bullet, num);
		}
	}

	private float CalcEnergyPropertyAddition(BaseEntity entity, PropertyAdditionData addition)
	{
		float property = entity.GetProperty("NormalAttackEnergyAmend");
		float property2 = entity.GetProperty("WeaknessEnergyAmend");
		addition.value *= 1f + property + property2;
		float property3 = entity.GetProperty(addition.propertyKey);
		entity.SetProperty(addition);
		return entity.GetProperty(addition.propertyKey) - property3;
	}

	public void DoShadowEndLife()
	{
		mBaseEntity.DoEntityDead();
	}

	public override void OnDispose()
	{
		_bulletData = null;
	}
}
