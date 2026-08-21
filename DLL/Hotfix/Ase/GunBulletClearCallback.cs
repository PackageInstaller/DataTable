using System.Runtime.InteropServices;

namespace Ase;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct GunBulletClearCallback : IWeaponGunBulletCallback, IWeaponGunBulletOperaDataBase
{
	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Clear;
}
