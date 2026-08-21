using Ase;

public class BuffAchievementProcessor : AchievementProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		base.Processor(observerParams);
		if (observerParams is ObserverExcuteBuffParams observerExcuteBuffParams)
		{
			CheckAndSetActionIsSelf(6001, observerExcuteBuffParams.FormEntity);
			ConditionParams.Add(6001, observerExcuteBuffParams.FormEntity?.EntityId ?? 0);
			ConditionParams.Add(6003, observerExcuteBuffParams.OwnerEntity?.EntityId ?? 0);
			ConditionParams.Add(6007, observerExcuteBuffParams.ExcuteBuff?.BuffId ?? 0);
			TargetParams.Add(8001, 1);
		}
	}
}
