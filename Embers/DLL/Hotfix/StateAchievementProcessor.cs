using Ase;

public class StateAchievementProcessor : AchievementProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		base.Processor(observerParams);
		if (observerParams is ObserverChangeStateParams observerChangeStateParams)
		{
			CheckAndSetActionIsSelf(6001, observerChangeStateParams.ChangeEntity);
			ConditionParams.Add(6001, observerChangeStateParams.ChangeEntity?.EntityId ?? 0);
			ConditionParams.Add(6005, observerChangeStateParams.Data?.Id ?? 0);
			TargetParams.Add(8001, 1);
		}
	}
}
