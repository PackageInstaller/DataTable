using Ase.Paradox;

namespace Ase;

public class WeaponGunCallbackActionDisrupted : IWeaponGunCallbackAction
{
	public override void GetWeaponGunBulletCallback(WeaponGunOperation operation, IWeaponGunBulletCallback callback)
	{
		operation?.GetDisruptedCallback(callback);
	}
}
