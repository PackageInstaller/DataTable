using System;
using UnityEngine;

public static class MainMenuModuleHelper
{
	public static Transform GetMainMenuSceneRoot(string sceneConfigName)
	{
		if (!(ModuleController<MainMenuModuleController>.Instance != null))
		{
			return null;
		}
		return ModuleController<MainMenuModuleController>.Instance.GetMainMenuSceneRoot(sceneConfigName);
	}

	public static void GetActiveScene(string sceneConfigName, Action<bool> callback)
	{
		if (ModuleController<MainMenuModuleController>.Instance != null)
		{
			ModuleController<MainMenuModuleController>.Instance.ActiveScene(sceneConfigName, callback);
		}
	}

	public static void DeActiveScene(string sceneConfigName, Action<bool> callback)
	{
		if (ModuleController<MainMenuModuleController>.Instance != null)
		{
			ModuleController<MainMenuModuleController>.Instance.DeActiveScene(sceneConfigName, callback);
		}
	}
}
