public class AdventureSWICH_PLAYER_ACTOR : BaseAdventureEvent
{
	public AdventureActor levelActor;

	public static AdventureSWICH_PLAYER_ACTOR Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureSWICH_PLAYER_ACTOR>("ADVENTURE_SWICH_PLAYER_ACTOR");
	}

	public AdventureSWICH_PLAYER_ACTOR()
		: base("ADVENTURE_SWICH_PLAYER_ACTOR")
	{
	}

	public override void Clear()
	{
		levelActor = null;
	}
}
