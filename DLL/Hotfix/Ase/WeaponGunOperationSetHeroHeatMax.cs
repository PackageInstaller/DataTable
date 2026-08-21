using Ase.Paradox;

namespace Ase;

public class WeaponGunOperationSetHeroHeatMax : IWeaponGunOperationAction
{
	public IWeaponGunBulletOperaDataBase GetOperationData(WeaponGunOperation operation)
	{
		return operation?.GetOperationDisruptedData();
	}
}
