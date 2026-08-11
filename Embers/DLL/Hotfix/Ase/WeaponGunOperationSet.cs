using Ase.Paradox;

namespace Ase;

public class WeaponGunOperationSet : IWeaponGunOperationAction
{
	public IWeaponGunBulletOperaDataBase GetOperationData(WeaponGunOperation operation)
	{
		return operation?.GetOperationSetData();
	}
}
