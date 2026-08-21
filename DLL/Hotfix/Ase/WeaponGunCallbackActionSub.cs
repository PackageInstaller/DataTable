using Ase.Paradox;

namespace Ase;

public class WeaponGunCallbackActionSub : IWeaponGunCallbackAction
{
	public override void GetWeaponGunBulletCallback(WeaponGunOperation operation, IWeaponGunBulletCallback callback)
	{
		operation?.GetSubCallback(callback);
	}
}
