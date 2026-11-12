using TrueSync;

public class AdventureActorEnergyChangeEvent : BaseAdventureEvent
{
	public AdventureActor actor;

	public int skillId;

	public FDP totalEnergy;

	public FDP currentEnergy;

	public bool isReset;

	public static AdventureActorEnergyChangeEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorEnergyChangeEvent>("ACTOR_ENERGY_CHANGE");
	}

	public AdventureActorEnergyChangeEvent()
		: base("ACTOR_ENERGY_CHANGE")
	{
	}

	public override void Clear()
	{
		actor = null;
		skillId = 0;
		totalEnergy = FDP.Zero;
		currentEnergy = FDP.Zero;
		isReset = false;
	}
}
