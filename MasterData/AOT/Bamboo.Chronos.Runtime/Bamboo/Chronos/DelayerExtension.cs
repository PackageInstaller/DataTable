namespace Bamboo.Chronos;

public static class DelayerExtension
{
	public static bool IsValid(this in Delayer delayer)
	{
		return delayer.EventDelay?.IsValid(delayer.Index, delayer.Version) ?? false;
	}

	public static void Cancel(this in Delayer delayer)
	{
		delayer.EventDelay?.Cancel(delayer.Index, delayer.Version);
	}

	public static void Pause(this in Delayer delayer)
	{
		delayer.EventDelay?.Pause(delayer.Index, delayer.Version);
	}

	public static void Resume(this in Delayer delayer)
	{
		delayer.EventDelay?.Resume(delayer.Index, delayer.Version);
	}
}
