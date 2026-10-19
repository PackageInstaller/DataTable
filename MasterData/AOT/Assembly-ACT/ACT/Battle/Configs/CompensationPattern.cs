using Bamboo.ECS;

namespace ACT.Battle.Configs;

public class CompensationPattern : TimelineItem
{
	public virtual void CompensationHandle(SystemAbility systemAbility, Entity behave, float duration, FSMRuntimeState rState)
	{
	}

	public virtual void Reset(Entity behave)
	{
	}

	public override bool CanDoPeriod()
	{
		return true;
	}
}
