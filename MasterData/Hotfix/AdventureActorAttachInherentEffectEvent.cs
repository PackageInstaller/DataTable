using System.Collections.Generic;

public class AdventureActorAttachInherentEffectEvent : BaseAdventureEvent
{
	public int actorID;

	public List<AddEffectInfo> effects;

	public static AdventureActorAttachInherentEffectEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorAttachInherentEffectEvent>("ACTOR_ATTACH_INHERENTEFFECT");
	}

	public AdventureActorAttachInherentEffectEvent()
		: base("ACTOR_ATTACH_INHERENTEFFECT")
	{
	}

	public override void Clear()
	{
		if (effects != null)
		{
			effects.Clear();
		}
		effects = null;
		actorID = 0;
	}
}
