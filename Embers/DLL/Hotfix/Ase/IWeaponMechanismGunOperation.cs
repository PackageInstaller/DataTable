namespace Ase;

public interface IWeaponMechanismGunOperation
{
	IWeaponGunBulletCallback WeaponBulletOperationFunc(WeaponMechanismGun weapon, IWeaponGunBulletOperaDataBase dataBase);
}
