namespace Ase.Paradox;

public class ReleaseSkillParamProcessor : BattleEventParamProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		if (observerParams is ObserverReleaseSkillParams observerReleaseSkillParams)
		{
			base.Processor(observerReleaseSkillParams);
			ConditionParams[6002] = EventTreeConditionParams.Create(observerReleaseSkillParams.SkillId);
			ConditionParams[6004] = EventTreeConditionParams.Create((float)observerReleaseSkillParams.ReleaseSkillType);
		}
	}
}
