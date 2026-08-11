using System.Runtime.InteropServices;

namespace Ase;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct GunHeroHeatMaxCallBack : IWeaponGunBulletCallback, IWeaponGunBulletOperaDataBase
{
	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.SetHeroHeatMax;
}
