public class AdventureActorPersonalPerkUpdateEvent : BaseAdventureEvent
{
	public int actorDataId;

	public int perkId;

	public bool isNew;

	public int oldLevel;

	public int newLevel;

	public static AdventureActorPersonalPerkUpdateEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorPersonalPerkUpdateEvent>("ACTOR_PERSONAL_PERK_UPDATE");
	}

	public AdventureActorPersonalPerkUpdateEvent()
		: base("ACTOR_PERSONAL_PERK_UPDATE")
	{
	}

	public override void Clear()
	{
		actorDataId = 0;
		perkId = 0;
		isNew = false;
		oldLevel = 0;
		newLevel = 0;
	}
}
