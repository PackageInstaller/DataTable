using ParadoxNotion.Design;

namespace Ase;

[Name("打乱数据", 0)]
public struct GunBulletRandomData : IWeaponGunBulletOperaDataBase
{
	[Name("是否随机子弹类型", 0)]
	public bool isRandomData;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Disrupted;
}
