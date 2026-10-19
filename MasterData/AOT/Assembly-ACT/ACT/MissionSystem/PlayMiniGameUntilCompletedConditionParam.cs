using System;
using ACT.Config;

namespace ACT.MissionSystem;

[Serializable]
public class PlayMiniGameUntilCompletedConditionParam
{
	public MissionMiniGameType miniGameType;

	public int miniGameId;

	public SeparateSegmentConfigs.Difficulty difficulty;

	public string failureSignal;

	public string successSignal;

	private bool IsConnectionMiniGame()
	{
		return miniGameType == MissionMiniGameType.Connection;
	}
}
