using System.Collections.Generic;

namespace ACT.Battle;

public struct DefenseStateSnapshot
{
	public DefenseStateFlags Flags;

	public HashSet<int> DynamicTagIds;

	public bool Invincible => Flags.HasFlag(DefenseStateFlags.Invincible);

	public bool TrueInvincible => Flags.HasFlag(DefenseStateFlags.TrueInvincible);

	public bool BlockThrow => Flags.HasFlag(DefenseStateFlags.BlockThrow);

	public void AddDynamicTagId(int tagId)
	{
		if (tagId != 0)
		{
			if (DynamicTagIds == null)
			{
				DynamicTagIds = new HashSet<int>();
			}
			DynamicTagIds.Add(tagId);
		}
	}

	public bool HasDynamicTagId(int tagId)
	{
		if (DynamicTagIds != null)
		{
			return DynamicTagIds.Contains(tagId);
		}
		return false;
	}
}
