public class AdventurePlayerActorStatusUpdate : BaseAdventureEvent
{
	public bool isRankUp;

	public static AdventurePlayerActorStatusUpdate Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePlayerActorStatusUpdate>("ADVENTURE_PLAYER_ACTOR_STATUS_UPDATE");
	}

	public AdventurePlayerActorStatusUpdate()
		: base("ADVENTURE_PLAYER_ACTOR_STATUS_UPDATE")
	{
	}

	public override void Clear()
	{
		isRankUp = false;
	}
}
