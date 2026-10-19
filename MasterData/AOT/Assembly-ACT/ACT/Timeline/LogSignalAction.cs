using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Playables;

namespace ACT.Timeline;

public class LogSignalAction : ISignalAction
{
	public string message;

	public UniTask Invoke(INotificationReceiver receiver)
	{
		if (LuminApplication.LogEnabled)
		{
			Debug.Log("Signal Action " + message);
		}
		return UniTask.CompletedTask;
	}
}
