using System;

[Serializable]
public sealed class SummerRaceBattleStageResolved
{
	public string stageId = string.Empty;

	public string mode = string.Empty;

	public int sortOrder;

	public bool isMainline;

	public SummerRaceBattleStageResolved Clone()
	{
		return (SummerRaceBattleStageResolved)MemberwiseClone();
	}
}
