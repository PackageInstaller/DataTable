using System.Collections.Generic;

namespace Ase;

public class BulletRuntimeConfigData
{
	public List<string> BulletLabel;

	public List<float> DamageRatio;

	public float FixAddition;

	public float AffectTenacity;

	public float FixedAffectTenacity;

	public List<int> AddBuff;

	public List<int> BuffTarget;

	public void InitConfig(DRBullet config)
	{
		if (config != null)
		{
			DamageRatio = new List<float>(config.DamageRatio);
			FixAddition = config.FixAddition;
			AffectTenacity = config.AffectTenacity;
			FixedAffectTenacity = config.FixedAffectTenacity;
			BulletLabel = new List<string>(config.BulletLabel);
			AddBuff = new List<int>(config.AddBuff);
			BuffTarget = new List<int>(config.BuffTarget);
		}
	}

	public BulletRuntimeConfigData Clone()
	{
		return new BulletRuntimeConfigData
		{
			BulletLabel = new List<string>(BulletLabel),
			DamageRatio = new List<float>(DamageRatio),
			FixAddition = FixAddition,
			AffectTenacity = AffectTenacity,
			FixedAffectTenacity = AffectTenacity,
			AddBuff = AddBuff,
			BuffTarget = BuffTarget
		};
	}
}
