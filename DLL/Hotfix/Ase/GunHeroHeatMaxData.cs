using ParadoxNotion.Design;

namespace Ase;

[Name("灵能最大值数据", 0)]
public struct GunHeroHeatMaxData : IWeaponGunBulletOperaDataBase
{
	[Name("是否随机子弹类型", 0)]
	public int value;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.SetHeroHeatMax;
}
