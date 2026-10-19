using System;
using UnityEngine.SceneManagement;

namespace Unity.VisualScripting;

public static class ReferenceCollector
{
	public static event Action onSceneUnloaded;

	internal static void Initialize()
	{
		SceneManager.sceneUnloaded += (Scene scene) =>
		{
			onSceneUnloaded?.Invoke();
		};
	}
}
