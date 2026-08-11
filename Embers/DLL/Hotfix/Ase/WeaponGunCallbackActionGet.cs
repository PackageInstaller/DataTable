using Ase.Paradox;

namespace Ase;

public class WeaponGunCallbackActionGet : IWeaponGunCallbackAction
{
	public override void GetWeaponGunBulletCallback(WeaponGunOperation operation, IWeaponGunBulletCallback callback)
	{
		operation?.GetGetCallback(callback);
	}
}
