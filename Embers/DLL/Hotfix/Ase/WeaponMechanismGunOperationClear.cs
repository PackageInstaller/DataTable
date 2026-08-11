namespace Ase;

public class WeaponMechanismGunOperationClear : IWeaponMechanismGunOperation
{
	public IWeaponGunBulletCallback WeaponBulletOperationFunc(WeaponMechanismGun weapon, IWeaponGunBulletOperaDataBase dataBase)
	{
		return weapon?.ClearBullet(dataBase);
	}
}
