using Ase;

public class TreatmentProcessor : AchievementProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		base.Processor(observerParams);
		if (observerParams is ObserverRecoverParams observerRecoverParams)
		{
			CheckAndSetActionIsSelf(6001, observerRecoverParams.DoctorEntity);
			CheckAndSetActionIsSelf(6003, observerRecoverParams.CureEntity);
			ConditionParams.Add(6001, observerRecoverParams.DoctorEntity?.EntityId ?? 0);
			ConditionParams.Add(6003, observerRecoverParams.CureEntity?.EntityId ?? 0);
			ConditionParams.Add(6002, observerRecoverParams.SkillId);
			TargetParams.Add(8003, observerRecoverParams.Recover);
		}
	}
}
