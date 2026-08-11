namespace Ase.ECS;

public class ParryComponent : BaseComponent
{
	public bool OpenParry;

	private float tempEnergyConmuse;

	private BattleSystem battleSystem;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		battleSystem = mBaseEntity.GetSystem<BattleSystem>();
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (OpenParry)
		{
			tempEnergyConmuse = mBaseEntity.GetProperty("ParryReduceEnergySpeed");
			mBaseEntity.ChangeProperty("Energy", 0f - tempEnergyConmuse);
			battleSystem?.OnEnergyChangeStat(mBaseEntity.Id, EnergyConmuseEnum.Parry, tempEnergyConmuse);
		}
	}

	public bool DamageConsumeEnergy(ref int damage)
	{
		if (OpenParry)
		{
			float num = (float)damage * mBaseEntity.GetProperty("DefenseConsume") / mBaseEntity.GetPropertyMax("Hp");
			if (LockstepData.Instance != null)
			{
				LockstepData.Instance?.WriteAuthorityEntityId(string.Format("护盾消耗能量 {0}  最大生命值   {1}  能量转换系数  {2}", num, mBaseEntity.GetPropertyMax("Hp"), mBaseEntity.GetProperty("DefenseConsume")), mBaseEntity);
			}
			float property = mBaseEntity.GetProperty("Energy");
			if (property >= num)
			{
				mBaseEntity.ChangeProperty("Energy", 0f - num);
				damage = 0;
				battleSystem?.OnEnergyChangeStat(mBaseEntity.Id, EnergyConmuseEnum.Parry, num);
				return true;
			}
			if (property <= 0f)
			{
				return false;
			}
			float property2 = mBaseEntity.GetProperty("DefenseConsume");
			if (property2 <= 0f)
			{
				return false;
			}
			float num2 = property / property2;
			damage = (int)((float)damage - num2);
			mBaseEntity.SetProperty("Energy", 0f);
			battleSystem?.OnEnergyChangeStat(mBaseEntity.Id, EnergyConmuseEnum.Parry, num2);
			return false;
		}
		return false;
	}

	public void SwitchState(bool openValue)
	{
		OpenParry = openValue;
		if (LockstepData.Instance != null)
		{
			LockstepData.Instance?.WriteAuthorityEntityId($"实体护盾状态：{OpenParry}", mBaseEntity);
		}
	}
}
