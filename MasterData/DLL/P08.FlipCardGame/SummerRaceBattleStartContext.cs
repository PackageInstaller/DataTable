using System;

[Serializable]
public sealed class SummerRaceBattleStartContext
{
	public string mode = string.Empty;

	public string stageId = string.Empty;

	public string source = string.Empty;

	public SummerRaceBattleStartBuildContext build = new SummerRaceBattleStartBuildContext();
}
