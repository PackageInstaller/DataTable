using System.Runtime.InteropServices;

namespace Ase;

[StructLayout(LayoutKind.Sequential, Size = 1)]
public struct GunBulletSetCallback : IWeaponGunBulletCallback, IWeaponGunBulletOperaDataBase
{
	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Set;
}
