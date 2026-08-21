using System.Collections;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.SceneManagement;

public sealed class SummerRaceSceneLoader : NScene
{
	private const string LevelPath = "Levels/SummerRaceFight";

	private const string SceneName = "SummerRaceFight";

	private const bool TraceSceneLoadLog = true;

	private static void TraceLog(string message)
	{
		SummerRaceRuntimeLog.Log(message);
	}

	public override IEnumerator OnLoadCoroutine()
	{
		TraceLog("[SummerRace][SceneLoader] OnLoadCoroutine begin. levelPath=Levels/SummerRaceFight");
		yield return null;
		AssetBundleLoadOperation operation = Asset.LoadLevelAsync("Levels/SummerRaceFight", isAddtive: true);
		while (!operation.IsDone())
		{
			yield return null;
		}
		Scene sceneByName = SceneManager.GetSceneByName("SummerRaceFight");
		if (sceneByName.IsValid() && sceneByName.isLoaded)
		{
			SceneManager.SetActiveScene(sceneByName);
		}
		TraceLog("[SummerRace][SceneLoader] Scene load completed. activeScene=" + SceneManager.GetActiveScene().name);
		Camera main = Camera.main;
		if (main != null && main.GetComponent<PhysicsRaycaster>() == null)
		{
			main.gameObject.AddComponent<PhysicsRaycaster>();
		}
		yield return null;
	}

	public override void OnSceneReady()
	{
		TraceLog("[SummerRace][SceneLoader] OnSceneReady");
		SummerRaceLuaBridge.NotifySceneReady();
	}

	public static bool UnloadBattleLevel()
	{
		Scene sceneByName = SceneManager.GetSceneByName("SummerRaceFight");
		if (sceneByName.IsValid() && sceneByName.isLoaded)
		{
			TraceLog("[SummerRace][SceneLoader] Unload additive scene. scene=SummerRaceFight");
			SceneManager.UnloadSceneAsync(sceneByName);
			return true;
		}
		return false;
	}

	public override void OnSceneExit(NScene nextScene)
	{
		base.OnSceneExit(nextScene);
		Time.timeScale = 1f;
		UnloadBattleLevel();
		bool num = nextScene is SummerRaceSceneLoader;
		if (!num)
		{
			SummerRaceFightManager.ClearPendingLaunchConfig();
		}
		SummerRaceLuaBridge.NotifySceneExit(num);
	}

	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI();
	}

	public override void CloseLoadUI()
	{
		LoadingUIManager.inst.CloseLoadUI();
	}

	private void LateUpdate()
	{
		LoadingUIManager.inst.SetUIProgress(Progress);
	}
}
