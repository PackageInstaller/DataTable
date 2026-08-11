using ParadoxNotion.Design;

namespace Ase;

[Name("获取数据", 0)]
public struct GunBulletGetData : IWeaponGunBulletOperaDataBase
{
	[Name("子弹类型", 0)]
	public WeaponGunBulletType bulletType;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Get;
}
