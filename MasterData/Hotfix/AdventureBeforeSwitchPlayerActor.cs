public class AdventureBeforeSwitchPlayerActor : BaseAdventureEvent
{
	public AdventureActor enterActor;

	public static AdventureBeforeSwitchPlayerActor Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureBeforeSwitchPlayerActor>("ADVENTURE_BEFORE_SWICH_PLAYER_ACTOR");
	}

	public AdventureBeforeSwitchPlayerActor()
		: base("ADVENTURE_BEFORE_SWICH_PLAYER_ACTOR")
	{
	}

	public override void Clear()
	{
		enterActor = null;
	}
}
