public class AdventureWeaponBornEvent : BaseAdventureEvent
{
	public LogicEntity owner;

	public string weaponTag;

	public static AdventureWeaponBornEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureWeaponBornEvent>("WEAPON_BORN");
	}

	public AdventureWeaponBornEvent()
		: base("WEAPON_BORN")
	{
	}

	public override void Clear()
	{
		base.Clear();
		owner = null;
		weaponTag = null;
	}
}
