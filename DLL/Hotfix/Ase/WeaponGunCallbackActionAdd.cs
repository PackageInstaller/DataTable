using Ase.Paradox;

namespace Ase;

public class WeaponGunCallbackActionAdd : IWeaponGunCallbackAction
{
	public override void GetWeaponGunBulletCallback(WeaponGunOperation operation, IWeaponGunBulletCallback callback)
	{
		operation?.GetAddCallback(callback);
	}
}
