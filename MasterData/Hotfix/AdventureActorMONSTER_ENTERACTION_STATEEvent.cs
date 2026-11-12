public class AdventureActorMONSTER_ENTERACTION_STATEEvent : BaseAdventureEvent
{
	public int enemyCount;

	public static AdventureActorMONSTER_ENTERACTION_STATEEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorMONSTER_ENTERACTION_STATEEvent>("MONSTER_ENTERACTION_STATE");
	}

	public AdventureActorMONSTER_ENTERACTION_STATEEvent()
		: base("MONSTER_ENTERACTION_STATE")
	{
	}

	public override void Clear()
	{
		enemyCount = 0;
		base.Clear();
	}
}
