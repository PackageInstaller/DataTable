using Ase.Paradox;

namespace Ase;

public interface IWeaponGunOperationAction
{
	IWeaponGunBulletOperaDataBase GetOperationData(WeaponGunOperation operation);
}
