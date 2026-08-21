using System.Collections.Generic;
using ParadoxNotion.Design;

namespace Ase;

public struct GunBulletGetCallback : IWeaponGunBulletCallback, IWeaponGunBulletOperaDataBase
{
	[Name("获取子弹列表", 0)]
	public List<WeaponGunBulletData> list;

	public int bulletCount;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Get;
}
