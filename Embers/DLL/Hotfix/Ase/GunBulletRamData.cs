using ParadoxNotion.Design;

namespace Ase;

[Name("添加数据", 0)]
public struct GunBulletRamData : IWeaponGunBulletOperaDataBase
{
	[Name("子弹类型", 0)]
	public WeaponGunBulletType bulletType;

	[Name("子弹索引", 0)]
	public int index;

	[Name("子弹数量", 0)]
	public int count;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Add;
}
