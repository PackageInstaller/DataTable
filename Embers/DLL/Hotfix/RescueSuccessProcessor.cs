using Ase;

public class RescueSuccessProcessor : AchievementProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		base.Processor(observerParams);
		if (observerParams is ObserverRescueParams observerRescueParams)
		{
			CheckAndSetActionIsSelf(6001, observerRescueParams.Rescue);
			ConditionParams.Add(6001, observerRescueParams.Rescue?.EntityId ?? 0);
			ConditionParams.Add(6003, observerRescueParams.Wounded?.EntityId ?? 0);
			TargetParams.Add(8001, 1);
		}
	}
}
