public class AdventurePlayerActorRevive_FakeMode : BaseAdventureEvent
{
	public long id;

	public int dataId;

	public string actorName;

	public int hitDamageId;

	public static AdventurePlayerActorRevive_FakeMode Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventurePlayerActorRevive_FakeMode>("PLAYER_ACTOR_REVIVE_FAKEMODE");
	}

	public AdventurePlayerActorRevive_FakeMode()
		: base("PLAYER_ACTOR_REVIVE_FAKEMODE")
	{
	}

	public override void Clear()
	{
	}
}
