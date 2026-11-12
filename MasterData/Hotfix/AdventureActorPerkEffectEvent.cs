using System.Collections.Generic;

public class AdventureActorPerkEffectEvent : BaseAdventureEvent
{
	public bool isAdd;

	public int perkId;

	public bool shareCD;

	public bool shareTakeEffectLimit;

	public List<AddEffectByActor> effectsByActors;

	public static AdventureActorPerkEffectEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorPerkEffectEvent>("ACTOR_PERK_EFFECT");
	}

	public AdventureActorPerkEffectEvent()
		: base("ACTOR_PERK_EFFECT")
	{
	}

	public override void Clear()
	{
		effectsByActors?.Clear();
		effectsByActors = null;
	}
}
