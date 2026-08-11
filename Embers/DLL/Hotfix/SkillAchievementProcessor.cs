using Ase;

public class SkillAchievementProcessor : AchievementProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		base.Processor(observerParams);
		if (observerParams is ObserverReleaseSkillParams observerReleaseSkillParams)
		{
			CheckAndSetActionIsSelf(6001, observerReleaseSkillParams.ReleaseEntity);
			ConditionParams.Add(6001, observerReleaseSkillParams.ReleaseEntity?.EntityId ?? 0);
			ConditionParams.Add(6002, observerReleaseSkillParams.SkillId);
			ConditionParams.Add(6004, (int)observerReleaseSkillParams.ReleaseSkillType);
			ConditionParams.Add(60041, (int)observerReleaseSkillParams.ExecuteState);
			TargetParams.Add(8001, 1);
		}
	}
}
