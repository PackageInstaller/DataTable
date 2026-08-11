using Ase.Paradox;

namespace Ase;

public class WeaponGunOperationSub : IWeaponGunOperationAction
{
	public IWeaponGunBulletOperaDataBase GetOperationData(WeaponGunOperation operation)
	{
		return operation?.GetOperationSubData();
	}
}
