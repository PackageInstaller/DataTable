using System;
using UnityEngine;
using UnityEngine.Playables;

namespace P08Main.Loading;

public class BaseT0Gameloading : CustomLoadingBase
{
	private string UIPath = "Widget/System/Main_T0SceneGame/108502/108502_SceneLoading";

	private GameObject loading;

	private PlayableDirector director;

	public bool isInit;

	public bool hasLoading;

	public bool isClosed;

	private Action enterCallback;

	public virtual string GetUIPath()
	{
		return UIPath;
	}

	public override LoadingImpl GetEnum()
	{
		return LoadingImpl.SkuldT0_Loading;
	}

	public override void CloseLoadUI()
	{
		director?.Resume();
		isClosed = true;
	}

	public override void Dispose()
	{
		isInit = false;
	}

	public override void InitLoading(object param = null)
	{
		isInit = true;
		hasLoading = false;
		isClosed = false;
	}

	public override void SetUIProgress(float value)
	{
	}

	public override void ShowLoadUI()
	{
		if (loading == null)
		{
			loading = Asset.InstantiateWithoutCache(GetUIPath(), dontDestroy: true);
			loading.transform.SetParent(GameObject.Find("UICamera_DontDestroy/Canvas").transform, worldPositionStays: false);
			director = loading.GetComponent<PlayableDirector>();
		}
		loading.SetActive(value: true);
		director.time = 0.0;
		director.Play();
		hasLoading = true;
		isClosed = false;
	}

	public void PuaseTimeline()
	{
	}

	public void SetEnterCallback(Action callback)
	{
		enterCallback = callback;
	}

	public void EnterLoading()
	{
		if (enterCallback != null)
		{
			enterCallback();
		}
		enterCallback = null;
	}

	public void TimelineFinished()
	{
		NScene currentScene = NScene.GetCurrentScene();
		if (!(currentScene != null) || currentScene.isReady)
		{
			loading.SetActive(value: false);
			hasLoading = false;
		}
	}

	public void ExitT0World()
	{
		UnityEngine.Object.Destroy(loading);
		loading = null;
		director = null;
		Asset.Unload(GetUIPath(), isDontDestroy: true);
		enterCallback = null;
	}
}
