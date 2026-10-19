namespace ACT;

public class StageProgressData
{
	public string StageName { get; set; }

	public float Percent { get; set; }

	public long CurrentBytes { get; set; }

	public long TotalBytes { get; set; }

	public long SpeedBytesPerSecond { get; set; }

	public int CurrentCount { get; set; }

	public int TotalCount { get; set; }

	public bool IsActive { get; set; }

	public StageProgressData(string stageName)
	{
		StageName = stageName;
	}

	public void Reset()
	{
		Percent = 0f;
		CurrentBytes = 0L;
		TotalBytes = 0L;
		SpeedBytesPerSecond = 0L;
		CurrentCount = 0;
		TotalCount = 0;
		IsActive = false;
	}
}
