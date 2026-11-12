public class AdventureActorReceiveDirectEvent : BaseAdventureEvent
{
	public long fromId;

	public LogicEntity from;

	public LogicEntity to;

	public long damage;

	public long damageToShieldAndHp;

	public long damageToHp;

	public static AdventureActorReceiveDirectEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorReceiveDirectEvent>("ADVENTURE_ACTOR_RECEIVE_DIRECT");
	}

	public AdventureActorReceiveDirectEvent()
		: base("ADVENTURE_ACTOR_RECEIVE_DIRECT")
	{
	}

	public override void Clear()
	{
		fromId = 0L;
		from = null;
		to = null;
		damage = 0L;
		damageToShieldAndHp = 0L;
		damageToHp = 0L;
	}
}
