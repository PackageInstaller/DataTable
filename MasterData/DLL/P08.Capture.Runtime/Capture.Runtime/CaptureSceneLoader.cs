using System.Collections;
using Cinemachine;
using UnityEngine;
using UnityEngine.SceneManagement;

namespace Capture.Runtime;

public class CaptureSceneLoader : NScene
{
	public CaptureGameDataForExchange sceneCtx;

	private GameModeLoaderBase m_currSceneLoader;

	protected bool initialized;

	protected bool isInLoading = true;

	public override void ShowLoadUI()
	{
		LoadingUIManager.inst.ShowLoadUI();
	}

	protected void SetUIProgress(float value)
	{
		if (isInLoading)
		{
			LoadingUIManager.inst.SetUIProgress(value);
		}
	}

	public override void CloseLoadUI()
	{
		isInLoading = false;
		LoadingUIManager.inst.CloseLoadUI();
	}

	public override void OnSceneEnter()
	{
		initialized = false;
		isInLoading = true;
		sceneCtx.LoadStageCfg();
	}

	public override void OnSceneExit(NScene nextScene)
	{
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
		Asset.Initialize();
		if (Camera.main.gameObject.GetComponent<CinemachineBrain>() == null)
		{
			Camera.main.gameObject.AddComponent<CinemachineBrain>();
		}
		AssetBundleLoadOperation ops = Asset.LoadLevelAsync(CaptureHelper.CaptureScene, isAddtive: true);
		while (!ops.IsDone())
		{
			yield return null;
		}
		scenePath = "Assets/ABResources/" + CaptureHelper.CaptureScene + ".unity";
		Scene sceneByPath = SceneManager.GetSceneByPath(scenePath);
		if (sceneByPath.IsValid())
		{
			SceneManager.SetActiveScene(sceneByPath);
		}
		yield return null;
		if (sceneCtx.m_stageData.mode == CaptureGameMode.Single)
		{
			m_currSceneLoader = new SingleModeLoader();
		}
		else if (sceneCtx.m_stageData.mode == CaptureGameMode.Multiple)
		{
			m_currSceneLoader = new MultipleModeLoader();
		}
		IEnumerator it = m_currSceneLoader.Load();
		while (it.MoveNext())
		{
			yield return new WaitForEndOfFrame();
		}
		AssetBundleLoadOperation ops2 = Asset.LoadLevelAsync("Levels/" + sceneCtx.m_stageData.baseScenePath, isAddtive: true);
		while (!ops2.IsDone())
		{
			yield return null;
		}
	}

	public override void OnSceneLoaded()
	{
		base.OnSceneLoaded();
	}
}
