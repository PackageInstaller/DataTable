using Ase.Paradox;

namespace Ase;

public class WeaponGunCallbackActionSetHeroHeatMax : IWeaponGunCallbackAction
{
	public override void GetWeaponGunBulletCallback(WeaponGunOperation operation, IWeaponGunBulletCallback callback)
	{
		operation?.GetHeroHeatMaxCallback(callback);
	}
}
