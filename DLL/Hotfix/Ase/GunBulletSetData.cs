using ParadoxNotion.Design;

namespace Ase;

[Name("设置数据", 0)]
public struct GunBulletSetData : IWeaponGunBulletOperaDataBase
{
	[Name("子弹类型", 0)]
	public WeaponGunBulletType bulletTypeTo;

	[Name("子弹索引", 0)]
	public int index;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Set;
}
