using System;
using System.Text;
using PathFinding2D.Runtime.Debugger;
using PathFinding2D.Runtime.Models;
using PathFinding2D.Runtime.Settings;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace PathFinding2D.Runtime;

public class NavigationRuntime : MonoBehaviour
{
	private static NavigationRuntime instance;

	public static NavigationRuntime Instance
	{
		get
		{
			if (instance == null)
			{
				throw new Exception("Please instantiate NavigationRuntime class before use.");
			}
			return instance;
		}
	}

	public static bool IsInstantiated => instance != null;

	public NavigationRuntimeProfile Profile { get; private set; }

	public NavigationDebugger Debugger { get; private set; }

	public NavigationMap Map { get; private set; }

	public NavigationData NavigationData { get; private set; }

	public void LoadMap(NavigationData data)
	{
		NavigationData = data;
		Map = NavigationMap.Create(data, Vector3.zero);
	}

	public void ClearMap()
	{
		NavigationData = null;
		Map = null;
	}

	public static string FormatData(NavigationData data)
	{
		if (data == null)
		{
			return "null";
		}
		int num = ((data.Waypoints != null) ? data.Waypoints.Count : (-1));
		int num2 = ((data.PointLinks != null) ? data.PointLinks.Count : (-1));
		return data.name + " id=" + data.GetInstanceID() + " wp=" + num + " links=" + num2;
	}

	public static void LogSceneSnapshot(string tag)
	{
		StringBuilder stringBuilder = new StringBuilder();
		stringBuilder.Append("[PF2D][").Append(tag).Append("]");
		if (!IsInstantiated)
		{
			stringBuilder.Append(" runtime=not-instantiated");
		}
		else
		{
			stringBuilder.Append(" runtimeData=").Append(FormatData(instance.NavigationData));
			stringBuilder.Append(" mapWp=").Append((instance.Map != null) ? instance.Map.WaypointCount : (-1));
		}
		NavigationDirection[] array = UnityEngine.Object.FindObjectsByType<NavigationDirection>(FindObjectsInactive.Include, FindObjectsSortMode.None);
		stringBuilder.Append(" sceneNavDirCount=").Append(array.Length);
		for (int i = 0; i < array.Length; i++)
		{
			NavigationDirection navigationDirection = array[i];
			if (!(navigationDirection == null))
			{
				stringBuilder.Append(" | [").Append(i).Append("] go=")
					.Append(navigationDirection.gameObject.name)
					.Append(" active=")
					.Append(navigationDirection.gameObject.activeInHierarchy)
					.Append(" scene=")
					.Append(navigationDirection.gameObject.scene.name)
					.Append(" data=")
					.Append(FormatData(navigationDirection.NavigationData));
			}
		}
		stringBuilder.Append(" loadedScenes=");
		for (int j = 0; j < SceneManager.sceneCount; j++)
		{
			Scene sceneAt = SceneManager.GetSceneAt(j);
			if (j > 0)
			{
				stringBuilder.Append(',');
			}
			stringBuilder.Append(sceneAt.name).Append(sceneAt.isLoaded ? "" : "(unloaded)");
		}
	}

	public static void Init(NavigationRuntimeProfile profile)
	{
		GameObject gameObject = new GameObject("Path finding 2D: Runtime Component")
		{
			hideFlags = HideFlags.DontSaveInEditor
		};
		UnityEngine.Object.DontDestroyOnLoad(gameObject);
		instance = gameObject.AddComponent<NavigationRuntime>();
		instance.Profile = profile;
		instance.Debugger = new NavigationDebugger();
	}
}
