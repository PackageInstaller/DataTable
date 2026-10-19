using System;
using ACT.Game.Data;
using UnityEngine.Serialization;

namespace ACT.Game;

[Serializable]
public class LocalWeapon
{
	public int uid;

	public int weaponId;

	public int level;

	public int exp;

	[FormerlySerializedAs("refineLevel")]
	public int refine;

	[FormerlySerializedAs("breakThrou")]
	public int stage;

	public Weapon ToPB()
	{
		return new Weapon
		{
			Uid = uid,
			WeaponId = weaponId,
			Level = level,
			Exp = exp,
			Refine = refine,
			Stage = stage
		};
	}
}
