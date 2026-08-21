public class ProfilerSample
{
	public static bool EnableProfilerSample = true;

	public static bool EnableFormatStringOutput = true;

	public static void BeginSample(string name)
	{
	}

	public static void BeginSample(string formatName, params object[] args)
	{
	}

	public static void EndSample()
	{
	}
}
