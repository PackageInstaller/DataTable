public class AgentActionEquipWeapon : AgentAction
{
	public int WeaponId;

	public AgentActionEquipWeapon()
		: base(AgentActionFactory.E_Type.EquipWeapon)
	{
	}
}
