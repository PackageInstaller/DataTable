using GameFramework;
using JahroConsole;

namespace Ase;

public class JahroLogHelper : GameFrameworkLog.ILogHelper
{
	public void Log(GameFrameworkLogLevel level, object message)
	{
		switch (level)
		{
		case GameFrameworkLogLevel.Debug:
			Jahro.LogDebug(Utility.Text.Format("<color=#888888>{0}</color>", message.ToString()));
			break;
		case GameFrameworkLogLevel.Info:
			Jahro.LogDebug(message.ToString());
			break;
		case GameFrameworkLogLevel.Warning:
			Jahro.LogWarning(message.ToString());
			break;
		case GameFrameworkLogLevel.Error:
			Jahro.LogError(message.ToString());
			break;
		case GameFrameworkLogLevel.Fatal:
			Jahro.LogError(message.ToString());
			break;
		default:
			throw new GameFrameworkException(message.ToString());
		}
	}

	public void Dismiss()
	{
	}
}
