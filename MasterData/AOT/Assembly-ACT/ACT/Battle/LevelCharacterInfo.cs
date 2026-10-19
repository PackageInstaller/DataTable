using UnityEngine;

namespace ACT.Battle;

public class LevelCharacterInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		return false;
	}

	public override float GetCompletePercent(int[] param)
	{
		return Mathf.Min(0f, 1f);
	}

	public override int GetCompleteCount(int[] param)
	{
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[1];
	}
}
