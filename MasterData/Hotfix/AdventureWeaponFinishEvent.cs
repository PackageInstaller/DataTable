public class AdventureWeaponFinishEvent : BaseAdventureEvent
{
	public LogicEntity owner;

	public string weaponTag;

	public static AdventureWeaponFinishEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureWeaponFinishEvent>("WEAPON_FINISH");
	}

	public AdventureWeaponFinishEvent()
		: base("WEAPON_FINISH")
	{
	}

	public override void Clear()
	{
		base.Clear();
		owner = null;
		weaponTag = null;
	}
}
