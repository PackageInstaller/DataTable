using UnityEngine;

namespace Unity.VisualScripting;

[TypeIcon(typeof(MessageListener))]
[AddComponentMenu("")]
[DisableAnnotation]
[IncludeInSettings(false)]
[Singleton(Name = "VisualScripting GlobalEventListener", Automatic = true, Persistent = true)]
public sealed class GlobalMessageListener : MonoBehaviour, ISingleton
{
	private void OnApplicationFocus(bool focus)
	{
		if (focus)
		{
			EventBus.Trigger("OnApplicationFocus");
		}
		else
		{
			EventBus.Trigger("OnApplicationLostFocus");
		}
	}

	private void OnApplicationPause(bool paused)
	{
		if (paused)
		{
			EventBus.Trigger("OnApplicationPause");
		}
		else
		{
			EventBus.Trigger("OnApplicationResume");
		}
	}

	private void OnApplicationQuit()
	{
		EventBus.Trigger("OnApplicationQuit");
	}

	public static void Require()
	{
		_ = Singleton<GlobalMessageListener>.instance;
	}
}
