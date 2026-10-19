namespace ACT.Battle.Configs;

public abstract class PerformanceItem : TimelineItem
{
	public virtual void Fire(FindTargetResult entity, FSMRuntimeState runtimeState)
	{
	}
}
