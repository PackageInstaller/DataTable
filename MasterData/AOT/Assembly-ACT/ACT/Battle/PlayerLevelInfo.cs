using UnityEngine;

namespace ACT.Battle;

public class PlayerLevelInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		return SystemUnlockManager.playerLevel >= param[0];
	}

	public override float GetCompletePercent(int[] param)
	{
		return Mathf.Min((float)SystemUnlockManager.playerLevel * 1f / (float)param[0], 1f);
	}

	public override int GetCompleteCount(int[] param)
	{
		return SystemUnlockManager.playerLevel;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
