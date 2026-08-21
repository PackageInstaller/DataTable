namespace Ase.Paradox;

public class WeaknessParamProcessor : BattleEventParamProcessor
{
	public override void Processor(IObserverParams observerParams)
	{
		if (observerParams is ObserverAttackBossWeakParams observerAttackBossWeakParams)
		{
			base.Processor(observerAttackBossWeakParams);
			ConditionParams[6006] = EventTreeConditionParams.Create(observerAttackBossWeakParams?.weaknessLevel ?? 0);
		}
	}
}
