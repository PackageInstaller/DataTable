namespace Ase;

public class WeaponMechanismGunOperationHeroHeatMax : IWeaponMechanismGunOperation
{
	public IWeaponGunBulletCallback WeaponBulletOperationFunc(WeaponMechanismGun weapon, IWeaponGunBulletOperaDataBase dataBase)
	{
		return weapon?.SetHeroHeatMax(dataBase);
	}
}
