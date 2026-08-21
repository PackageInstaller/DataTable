namespace Ase;

public class CopyType3CurrentData
{
	public CopyType3Mode Mode { get; }

	public int CopyType { get; }

	public int Score { get; }

	public int RewardCount { get; }

	public long CopyEndTime { get; }

	public CopyType3CurrentData(CopyType3Mode mode, int copyType, int score, int rewardCount, long copyEndTime)
	{
		Mode = mode;
		CopyType = copyType;
		Score = score;
		RewardCount = rewardCount;
		CopyEndTime = copyEndTime;
	}
}
