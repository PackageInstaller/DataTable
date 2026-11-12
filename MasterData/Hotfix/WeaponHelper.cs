public static class WeaponHelper
{
	public static bool HasNoDiffDamageFeature(HitBox.FeatureFlag featureFlags)
	{
		return (featureFlags & HitBox.FeatureFlag.NoDiffDamage) == HitBox.FeatureFlag.NoDiffDamage;
	}

	public static bool HasKillFeature(HitBox.FeatureFlag featureFlags)
	{
		return (featureFlags & HitBox.FeatureFlag.Kill) == HitBox.FeatureFlag.Kill;
	}

	public static bool HasChangeAreaFeature(HitBox.FeatureFlag featureFlags)
	{
		return (featureFlags & HitBox.FeatureFlag.ChangeArea) == HitBox.FeatureFlag.ChangeArea;
	}

	public static bool CheckHitable(this HitBox hitBoxContext, LogicEntity logicEntity, LogicEntity logicTarget)
	{
		if (logicTarget == null || hitBoxContext == null)
		{
			return false;
		}
		if (!HasNoDiffDamageFeature(hitBoxContext.featureFlags) && !logicEntity.IsConfrontWith(logicTarget))
		{
			return logicEntity.IsNeutralWith(logicTarget);
		}
		return true;
	}
}
