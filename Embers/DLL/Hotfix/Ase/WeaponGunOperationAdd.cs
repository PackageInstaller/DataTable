using Ase.Paradox;

namespace Ase;

public class WeaponGunOperationAdd : IWeaponGunOperationAction
{
	public IWeaponGunBulletOperaDataBase GetOperationData(WeaponGunOperation operation)
	{
		return operation?.GetOperationAddData();
	}
}
