using System;
using System.Collections;
using P08Main.Loading;
using UnityEngine;

namespace T0World;

public class T0WorldSceneLoader : NScene
{
	public int characterID;

	public string t0SceneName;

	public int t0SceneID;

	public bool todayFirstEnter;

	public Transform T0EntityContent;

	public T0WorldPlayer player;

	public override float ShowLoadUIDuration()
	{
		return 1.5f;
	}

	public override float EndLoadUIDuration()
	{
		return 0.5f;
	}

	public override float CloseLoadUIDuration()
	{
		return 0.5f;
	}

	public override void ShowLoadUI()
	{
		CustomLoadingManager.inst.ShowLoadUI(T0WorldCreator.GetLoadingType());
	}

	protected virtual void SetUIProgress(float value)
	{
	}

	public override void CloseLoadUI()
	{
		CustomLoadingManager.inst.CloseLoadUI(T0WorldCreator.GetLoadingType());
	}

	public override IEnumerator OnSceneReadyCoroutine()
	{
		yield return null;
	}

	public override void OnSceneEnter()
	{
		Application.lowMemory += Application_lowMemory;
		ClearAudioCache();
	}

	private void Application_lowMemory()
	{
		OnLowMemory();
		Resources.UnloadUnusedAssets();
	}

	protected virtual void OnLowMemory()
	{
	}

	public override void OnSceneReady()
	{
		base.OnSceneReady();
	}

	public override void OnSceneLoaded()
	{
		try
		{
			SetUIProgress(100f);
		}
		catch (Exception ex)
		{
			Debug.Log(ex.Message);
		}
	}

	public override void OnSceneExit(NScene nextScene)
	{
		Application.lowMemory -= Application_lowMemory;
		ClearAudioCache();
		if (T0WorldCreator.GetLoadingInst() != null)
		{
			T0WorldCreator.GetLoadingInst().ExitT0World();
		}
	}

	protected void ClearAudioCache()
	{
		AudioManager.Instance.RemoveUsedSheetList("music");
		AudioManager.Instance.RemoveUsedSheetList("voice");
		AudioManager.Instance.RemoveUsedSheetList("effect");
	}

	public override IEnumerator OnLoadCoroutine()
	{
		yield return null;
	}
}
