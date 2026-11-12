public class DirectDamageKillEvent : BaseAdventureEvent
{
	public string tag;

	public static DirectDamageKillEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<DirectDamageKillEvent>("DIRECT_DAMAGE_KILL");
	}

	public DirectDamageKillEvent()
		: base("DIRECT_DAMAGE_KILL")
	{
	}

	public override void Clear()
	{
		base.Clear();
		tag = "";
	}
}
