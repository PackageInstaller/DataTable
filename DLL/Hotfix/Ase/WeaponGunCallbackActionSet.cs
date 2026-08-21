using Ase.Paradox;

namespace Ase;

public class WeaponGunCallbackActionSet : IWeaponGunCallbackAction
{
	public override void GetWeaponGunBulletCallback(WeaponGunOperation operation, IWeaponGunBulletCallback callback)
	{
		operation?.GetSetCallback(callback);
	}
}
