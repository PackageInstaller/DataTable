using System;
using ACT.Game;

namespace ACT.Battle;

[Obsolete("登陆天数改到CountData里了")]
public class LoginDays : PreconditionInfo
{
	public override bool IsComplete(int[] param)
	{
		if (param.Length == 0)
		{
			return false;
		}
		int key = 1;
		if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(key, out var value))
		{
			return value >= param[0];
		}
		return false;
	}

	public override int GetCompleteCount(int[] param)
	{
		int key = 1;
		if (G.localPlayer.Achievements.Info.CountDatas.TryGetValue(key, out var value))
		{
			return value;
		}
		return 0;
	}

	public override int GetNeedCount(int[] param)
	{
		return param[0];
	}
}
