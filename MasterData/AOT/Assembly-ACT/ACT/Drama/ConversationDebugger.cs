using System;

namespace ACT.Drama;

public class ConversationDebugger : IConversationDebugger
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
