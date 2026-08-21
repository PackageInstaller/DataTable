namespace Ase;

public class WeaponMechanismGunOperationConsume : IWeaponMechanismGunOperation
{
	public IWeaponGunBulletCallback WeaponBulletOperationFunc(WeaponMechanismGun weapon, IWeaponGunBulletOperaDataBase dataBase)
	{
		return weapon?.ConsumeBullet(dataBase);
	}
}
