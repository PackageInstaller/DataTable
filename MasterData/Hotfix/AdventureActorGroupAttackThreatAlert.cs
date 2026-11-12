public class AdventureActorGroupAttackThreatAlert : BaseAdventureEvent
{
	public static AdventureActorGroupAttackThreatAlert Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorGroupAttackThreatAlert>("ADVENTURE_ACTOR_GROUP_ATTACK_THREAT_ALERT");
	}

	public AdventureActorGroupAttackThreatAlert()
		: base("ADVENTURE_ACTOR_GROUP_ATTACK_THREAT_ALERT")
	{
	}

	public override void Clear()
	{
	}
}
