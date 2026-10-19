namespace ACT.Battle.Configs;

public class TimeSlowItem : PerformanceItem
{
	public CanFindTargetsPredicate predicate = new CanFindTargetsPredicate();

	public ActionChangeGlobalSpeed globalSpeed = new ActionChangeGlobalSpeed();

	public override void Fire(FindTargetResult target, FSMRuntimeState runtimeState)
	{
		ActionMemory memory = new ActionMemory(target.entity, target.entity, target);
		if (predicate.Check(memory))
		{
			globalSpeed.CheckDo(memory);
		}
	}

	public override bool CanDoPeriod()
	{
		return false;
	}
}
