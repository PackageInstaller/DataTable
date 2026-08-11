using Ase.Paradox;

namespace Ase;

public abstract class IWeaponGunCallbackAction
{
	public abstract void GetWeaponGunBulletCallback(WeaponGunOperation operation, IWeaponGunBulletCallback callback);
}
