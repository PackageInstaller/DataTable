public class EntityEquipWeaponEvent : NEventBase, IPostToPresentation, IPostToSimulation
{
	public int mWeaponID;

	public int mEntityID;

	public EntityEquipWeaponEvent(int newEntity, int weaponID)
	{
		mEntityID = newEntity;
		mWeaponID = weaponID;
	}

	public override void OnEnterPool()
	{
	}

	public override void Release()
	{
	}
}
