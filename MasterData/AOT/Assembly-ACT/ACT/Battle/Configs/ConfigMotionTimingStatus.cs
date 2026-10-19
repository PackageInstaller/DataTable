namespace ACT.Battle.Configs;

public sealed class ConfigMotionTimingStatus
{
	public bool valid;

	public string invalidReason;

	public int currentTotalFrames;

	public int timingItemCount;

	public int anchoredItemCount;

	public int missingFrameRangeCount;

	public int changedSourceFrameCount;

	public int firstChangedSourceTotalFrames;
}
