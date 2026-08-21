using ParadoxNotion.Design;

namespace Ase;

[Name("清除数据", 0)]
public struct GunBulletClearData : IWeaponGunBulletOperaDataBase
{
	[Name("子弹类型", 0)]
	public WeaponGunBulletType bulletType;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Clear;
}
