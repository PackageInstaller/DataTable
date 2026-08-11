namespace Ase.Paradox;

public class RecoverParamProcessor : BattleEventParamProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		if (observerParams is ObserverRecoverParams observerRecoverParams)
		{
			base.Processor(observerRecoverParams);
			ConditionParams[6002] = EventTreeConditionParams.Create(observerRecoverParams.SkillId);
			ConditionParams[8003] = EventTreeConditionParams.Create(observerRecoverParams.Recover);
		}
	}
}
