namespace ACT.Battle.Configs;

public class ModelActiveItem : PerformanceItem
{
	public ActionSetModelActive activeSetModelActive;

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		activeSetModelActive.CheckDo(new ActionMemory(target.entity, target.entity, target));
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
