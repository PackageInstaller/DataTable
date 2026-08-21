using Ase.Paradox;

namespace Ase;

public class WeaponGunOperationClear : IWeaponGunOperationAction
{
	public IWeaponGunBulletOperaDataBase GetOperationData(WeaponGunOperation operation)
	{
		return operation?.GetOperationClearData();
	}
}
