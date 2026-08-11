namespace Ase;

public class WeaponMechanismGunOperationSet : IWeaponMechanismGunOperation
{
	public IWeaponGunBulletCallback WeaponBulletOperationFunc(WeaponMechanismGun weapon, IWeaponGunBulletOperaDataBase dataBase)
	{
		return weapon?.SetBullet(dataBase);
	}
}
