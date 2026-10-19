using System;

namespace ACT.MultiPlayer;

public struct MPWeapon : IEquatable<MPWeapon>
{
	public int uid;

	public int id;

	public byte level;

	public byte refine;

	public byte stage;

	public int breakType;

	public MPWeapon(int Uid, int WeaponId, byte sourceLevel, byte sourceRefine, byte sourceStage, int breakType)
	{
		this = default;
		uid = Uid;
		id = WeaponId;
		level = sourceLevel;
		refine = sourceRefine;
		stage = sourceStage;
		this.breakType = breakType;
	}

	public bool Equals(MPWeapon other)
	{
		if (id == other.id && level == other.level && refine == other.refine && stage == other.stage)
		{
			return uid == other.uid;
		}
		return false;
	}
}
