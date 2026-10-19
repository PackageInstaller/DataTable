namespace Bamboo.Chronos;

public static class LooperExtension
{
	public static bool IsValid(this in Looper looper)
	{
		return looper.EventLoop?.IsValid(looper.Index, looper.Version) ?? false;
	}

	public static void Cancel(this in Looper looper)
	{
		looper.EventLoop?.Cancel(looper.Index, looper.Version);
	}

	public static void Pause(this in Looper looper)
	{
		looper.EventLoop?.Pause(looper.Index, looper.Version);
	}

	public static void Resume(this in Looper looper)
	{
		looper.EventLoop?.Resume(looper.Index, looper.Version);
	}
}
