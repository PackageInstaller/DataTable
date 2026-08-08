using Entitas;

public class EntityActionWeaponEquip : IComponent, IComponentReset
{
	public EntityActionStatus mStatus;

	public int mWantEquipWeaponID = -1;

	public int mEquipDuring;

	public void Reset(Entity entity)
	{
		mStatus = EntityActionStatus.E_ACTIVE;
		mEquipDuring = 0;
		mWantEquipWeaponID = -1;
	}
}
