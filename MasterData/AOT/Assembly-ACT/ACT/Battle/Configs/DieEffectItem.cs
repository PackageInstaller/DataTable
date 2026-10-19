namespace ACT.Battle.Configs;

public class DieEffectItem : PerformanceItem
{
	public ActionFireDieEffect dieEffect = new ActionFireDieEffect();

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		dieEffect.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
