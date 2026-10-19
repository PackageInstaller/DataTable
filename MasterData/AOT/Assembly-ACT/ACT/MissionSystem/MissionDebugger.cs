using System;

namespace ACT.MissionSystem;

public class MissionDebugger : IMissionDebugger
{
	public void Log(string message)
	{
		_ = LuminApplication.LogEnabled;
	}

	public void LogWarning(string message)
	{
		_ = LuminApplication.LogEnabled;
	}

	public void LogError(string message)
	{
		_ = LuminApplication.LogEnabled;
	}

	public void LogError(Exception exception)
	{
		_ = LuminApplication.LogEnabled;
	}

	public void LogException(Exception exception)
	{
		_ = LuminApplication.LogEnabled;
	}
}
