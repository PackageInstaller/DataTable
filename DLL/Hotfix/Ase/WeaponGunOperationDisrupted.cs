using Ase.Paradox;

namespace Ase;

public class WeaponGunOperationDisrupted : IWeaponGunOperationAction
{
	public IWeaponGunBulletOperaDataBase GetOperationData(WeaponGunOperation operation)
	{
		return operation?.GetOperationDisruptedData();
	}
}
