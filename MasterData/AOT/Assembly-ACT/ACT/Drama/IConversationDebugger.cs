using System;

namespace ACT.Drama;

public interface IConversationDebugger
{
	void Log(string message);

	void LogWarning(string message);

	void LogError(string message);

	void LogError(Exception exception);

	void LogException(Exception exception);
}
