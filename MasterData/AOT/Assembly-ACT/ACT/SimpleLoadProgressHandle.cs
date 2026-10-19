using Fundamental;

namespace ACT;

public class SimpleLoadProgressHandle : ILoadProgressHandle
{
	public float Progress { get; set; } = 1f;

	public bool IsDone => Progress >= 1f;

	public bool CouldDispose
	{
		get
		{
			if (IsDone)
			{
				return Singleton<LoadManager>.instance.DisplayPercent >= 1f;
			}
			return false;
		}
	}

	public void Dispose()
	{
		Progress = 0f;
	}
}
