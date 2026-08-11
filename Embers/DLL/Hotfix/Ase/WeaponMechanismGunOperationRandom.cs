namespace Ase;

public class WeaponMechanismGunOperationRandom : IWeaponMechanismGunOperation
{
	public IWeaponGunBulletCallback WeaponBulletOperationFunc(WeaponMechanismGun weapon, IWeaponGunBulletOperaDataBase dataBase)
	{
		return weapon?.RandomBullet(dataBase);
	}
}
