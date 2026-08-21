using Ase;

public class InteractiveAchievementProcessor : AchievementProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		base.Processor(observerParams);
		if (observerParams is ObserverInteractiveParams observerInteractiveParams)
		{
			CheckAndSetActionIsSelf(6001, observerInteractiveParams.InteractiveEntity);
			ConditionParams.Add(6001, observerInteractiveParams.InteractiveEntity?.EntityId ?? 0);
			TargetParams.Add(8001, 1);
		}
	}
}
