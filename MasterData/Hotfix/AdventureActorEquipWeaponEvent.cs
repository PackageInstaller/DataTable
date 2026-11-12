public class AdventureActorEquipWeaponEvent : BaseAdventureEvent
{
	public AdventureWeapon weapon;

	public static AdventureActorEquipWeaponEvent Generate()
	{
		return ModuleController<AdventureModuleController>.Instance.GenerateEvent<AdventureActorEquipWeaponEvent>("ADVENTURE_ACTOR_EQUIP_WEAPON");
	}

	public AdventureActorEquipWeaponEvent()
		: base("ADVENTURE_ACTOR_EQUIP_WEAPON")
	{
	}

	public override void Clear()
	{
		weapon = null;
	}
}
