public class AdventureMonsterTargetChangedEvent : BaseAdventureEvent
{
	public LogicEntity newTarget;

	public static AdventureMonsterTargetChangedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureMonsterTargetChangedEvent>("MONSTER_TARGET_CHANGED");
	}

	public AdventureMonsterTargetChangedEvent()
		: base("MONSTER_TARGET_CHANGED")
	{
	}

	public override void Clear()
	{
		base.Clear();
		newTarget = null;
	}
}
