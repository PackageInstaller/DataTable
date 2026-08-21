using Ase;

public class HitAchievementProcessor : AchievementProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		base.Processor(observerParams);
		if (observerParams is ObserverHitParams observerHitParams)
		{
			CheckAndSetActionIsSelf(6001, observerHitParams.AttackEntity);
			ConditionParams.Add(6001, observerHitParams.AttackEntity?.EntityId ?? 0);
			ConditionParams.Add(6003, observerHitParams.HitEntity?.EntityId ?? 0);
			ConditionParams.Add(6002, observerHitParams.SkillId);
			ConditionParams.Add(6006, observerHitParams.WeaknessData?.Level ?? 0);
			ConditionParams.Add(6008, observerHitParams.HitColliderVariableData?.SiteLevel ?? 0);
			ConditionParams.Add(6009, observerHitParams.IsCrit ? 1 : 0);
			TargetParams.Add(8002, observerHitParams.DamageValue);
			if (observerHitParams.IsStruckDown)
			{
				TargetParams.Add(8005, 1);
			}
			if (observerHitParams.IsCrit)
			{
				TargetParams.Add(8006, 1);
			}
			TargetParams.Add(8001, 1);
		}
	}
}
