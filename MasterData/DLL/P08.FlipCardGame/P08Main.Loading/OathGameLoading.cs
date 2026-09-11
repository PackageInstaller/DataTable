using System;
using UnityEngine;
using UnityEngine.Playables;

namespace P08Main.Loading;

public class OathGameLoading : CustomLoadingBase
{
	private static string UIPath = "Widget/System/Hero_Oath/OathCommon/HeroOathTransitionUI";

	private GameObject OathLoading;

	private PlayableDirector director;

	public static OathGameLoading Instance;

	public bool isInit;

	public bool hasLoading;

	public bool isClosed;

	private Action enterCallback;

	private Action finishCallback;

	public override void CloseLoadUI()
	{
		director.Resume();
		isClosed = true;
	}

	public override void Dispose()
	{
		isInit = false;
	}

	public override LoadingImpl GetEnum()
	{
		return LoadingImpl.Oath_Loading;
	}

	public override void InitLoading(object param = null)
	{
		Instance = this;
		isInit = true;
		hasLoading = false;
		isClosed = false;
	}

	public override void SetUIProgress(float value)
	{
	}

	public override void ShowLoadUI()
	{
		if (OathLoading == null)
		{
			OathLoading = Asset.InstantiateWithoutCache(UIPath, dontDestroy: true);
			OathLoading.transform.SetParent(GameObject.Find("UICamera_DontDestroy/Canvas").transform, worldPositionStays: false);
			director = OathLoading.GetComponent<PlayableDirector>();
		}
		OathLoading.SetActive(value: true);
		director.time = 0.0;
		director.Play();
		hasLoading = true;
		isClosed = false;
	}

	public void PuaseTimeline()
	{
		if (!isClosed)
		{
			director.Pause();
		}
	}

	public void SetEnterCallback(Action callback)
	{
		enterCallback = callback;
	}

	public void SetFinishCallback(Action callback)
	{
		finishCallback = callback;
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
		OathLoading.SetActive(value: false);
		hasLoading = false;
		if (finishCallback != null)
		{
			finishCallback();
		}
		finishCallback = null;
	}

	public void ExitWorld()
	{
		UnityEngine.Object.Destroy(OathLoading);
		OathLoading = null;
		director = null;
		Asset.Unload(UIPath, isDontDestroy: true);
		enterCallback = null;
		finishCallback = null;
	}
}
