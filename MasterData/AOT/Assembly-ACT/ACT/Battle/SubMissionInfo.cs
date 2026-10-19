using ACT.Core;
using ACT.Game;
using ACT.Game.Data;

namespace ACT.Battle;

public class SubMissionInfo : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (G.localPlayer.Missions.Find((MissionState x) => x.CompletedSubmissions.ContainsKey(param[0])) != null)
		{
			return true;
		}
		return false;
	}

	public override float GetCompletePercent(int[] param)
	{
		return 1f;
	}

	public override int GetCompleteCount(int[] param)
	{
		return 1;
	}

	public override int GetNeedCount(int[] param)
	{
		return 1;
	}
}
