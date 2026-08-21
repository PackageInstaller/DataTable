namespace Ase;

public class WeaponMechanismGunOperationRam : IWeaponMechanismGunOperation
{
	public IWeaponGunBulletCallback WeaponBulletOperationFunc(WeaponMechanismGun weapon, IWeaponGunBulletOperaDataBase dataBase)
	{
		return weapon?.RamBullet(dataBase);
	}
}
