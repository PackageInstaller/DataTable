using System.Collections.Generic;

public class AdventureActorDiedEvent : BaseAdventureEvent
{
	public AdventureActor actor;

	public LogicEntity killer;

	public IList<int> damageTag;

	public DeadType deadType;

	public int uniqueAttackId;

	public static AdventureActorDiedEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorDiedEvent>("ADVENTURE_ACTOR_DIED");
	}

	public AdventureActorDiedEvent()
		: base("ADVENTURE_ACTOR_DIED")
	{
	}

	public override void Clear()
	{
		actor = null;
		killer = null;
		damageTag = null;
		uniqueAttackId = 0;
		deadType = DeadType.None;
	}
}
