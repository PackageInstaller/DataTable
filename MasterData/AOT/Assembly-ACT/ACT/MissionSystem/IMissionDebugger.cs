using System;

namespace ACT.MissionSystem;

public interface IMissionDebugger
{
	void Log(string message);

	void LogWarning(string message);

	void LogError(string message);

	void LogError(Exception exception);

	void LogException(Exception exception);
}
