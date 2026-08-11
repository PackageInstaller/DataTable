using Ase.Paradox;

namespace Ase;

public class WeaponGunOperationGet : IWeaponGunOperationAction
{
	public IWeaponGunBulletOperaDataBase GetOperationData(WeaponGunOperation operation)
	{
		return operation?.GetOperationGetData();
	}
}
