using System.Collections.Generic;
using ParadoxNotion.Design;

namespace Ase;

public struct GunBulletConsumeCallback : IWeaponGunBulletCallback, IWeaponGunBulletOperaDataBase
{
	[Name("消耗子弹列表", 0)]
	public List<WeaponGunBulletData> list;

	public WeaponGunBulletOperationType OperType => WeaponGunBulletOperationType.Sub;
}
