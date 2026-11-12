using TrueSync;

public class AdventureActorHpChangedEvent : BaseAdventureEvent
{
	public FDP currentHp;

	public FDP maxHp;

	public bool isCovery;

	public static AdventureActorHpChangedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorHpChangedEvent>("ACTOR_HP_CHANGED");
	}

	public AdventureActorHpChangedEvent()
		: base("ACTOR_HP_CHANGED")
	{
	}

	public override void Clear()
	{
		base.Clear();
		currentHp = 0;
		maxHp = 0;
		isCovery = false;
	}
}
