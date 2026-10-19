using UnityEngine;

namespace Unity.VisualScripting;

[Singleton(Name = "VisualScripting SavedVariablesSerializer", Automatic = true, Persistent = true)]
[IncludeInSettings(false)]
[DisableAnnotation]
[AddComponentMenu("")]
public class VariablesSaver : MonoBehaviour, ISingleton
{
	public static VariablesSaver instance => Singleton<VariablesSaver>.instance;

	private void Awake()
	{
		Singleton<VariablesSaver>.Awake(this);
	}

	private void OnDestroy()
	{
		Singleton<VariablesSaver>.OnDestroy(this);
	}

	private void OnApplicationQuit()
	{
		SavedVariables.OnExitPlayMode();
		ApplicationVariables.OnExitPlayMode();
	}

	private void OnApplicationPause(bool isPaused)
	{
		if (isPaused)
		{
			SavedVariables.OnExitPlayMode();
			ApplicationVariables.OnExitPlayMode();
		}
	}

	public static void Instantiate()
	{
		Singleton<VariablesSaver>.Instantiate();
	}
}
