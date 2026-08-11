using System.Collections.Generic;
using ParadoxNotion.Design;

namespace Ase;

public struct GunBulletRandomCallback : IWeaponGunBulletCallback, IWeaponGunBulletOperaDataBase
{
	[Name("随机子弹列表", 0)]
	public List<WeaponGunBulletData> list;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Disrupted;
}
