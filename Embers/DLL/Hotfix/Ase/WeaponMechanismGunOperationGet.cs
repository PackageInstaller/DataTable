namespace Ase;

public class WeaponMechanismGunOperationGet : IWeaponMechanismGunOperation
{
	public IWeaponGunBulletCallback WeaponBulletOperationFunc(WeaponMechanismGun weapon, IWeaponGunBulletOperaDataBase dataBase)
	{
		return weapon?.GetBullet(dataBase);
	}
}
