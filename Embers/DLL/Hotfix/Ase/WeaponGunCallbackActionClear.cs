using Ase.Paradox;

namespace Ase;

public class WeaponGunCallbackActionClear : IWeaponGunCallbackAction
{
	public override void GetWeaponGunBulletCallback(WeaponGunOperation operation, IWeaponGunBulletCallback callback)
	{
		operation.GetClearCallback(callback);
	}
}
