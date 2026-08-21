using ParadoxNotion.Design;

namespace Ase;

[Name("消耗数据", 0)]
public struct GunBulletConsumeData : IWeaponGunBulletOperaDataBase
{
	[Name("子弹类型", 0)]
	public WeaponGunBulletType bulletType;

	[Name("子弹数量", 0)]
	public int count;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Sub;
}
