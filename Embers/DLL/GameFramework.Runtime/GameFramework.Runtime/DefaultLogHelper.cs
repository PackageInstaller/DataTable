using UnityEngine;

namespace GameFramework.Runtime;

public class DefaultLogHelper : GameFrameworkLog.ILogHelper
{
	public void Log(GameFrameworkLogLevel level, object message)
	{
		switch (level)
		{
		case GameFrameworkLogLevel.Debug:
			Debug.Log(Utility.Text.Format("<color=#888888>{0}</color>", message));
			break;
		case GameFrameworkLogLevel.Info:
			Debug.Log(message.ToString());
			break;
		case GameFrameworkLogLevel.Warning:
			Debug.LogWarning(message.ToString());
			break;
		case GameFrameworkLogLevel.Error:
			Debug.LogError(message.ToString());
			break;
		default:
			throw new GameFrameworkException(message.ToString());
		}
	}

	public void Dismiss()
	{
	}
}
