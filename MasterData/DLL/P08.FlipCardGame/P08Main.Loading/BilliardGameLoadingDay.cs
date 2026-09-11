using UnityEngine;
using UnityEngine.Playables;

namespace P08Main.Loading;

public class BilliardGameLoadingDay : CustomLoadingBase
{
	private static string UIPath = "Widget/System/Activity_SummerPub/MainPub/DayNightCutSceneLoading_Day";

	private GameObject billiardLoading;

	private PlayableDirector director;

	public static BilliardGameLoadingDay Instance;

	public bool isInit;

	public bool hasLoading;

	public bool isClosed;

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
		return LoadingImpl.BilliardGame_Day;
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
		if (billiardLoading == null)
		{
			billiardLoading = Asset.InstantiateWithoutCache(UIPath, dontDestroy: true);
			billiardLoading.transform.SetParent(GameObject.Find("UICamera_DontDestroy/Canvas").transform, worldPositionStays: false);
			director = billiardLoading.GetComponent<PlayableDirector>();
		}
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_marble_ui_turn02", useStream: false);
		billiardLoading.SetActive(value: true);
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

	public void TimelineFinished()
	{
		Object.Destroy(billiardLoading);
		billiardLoading = null;
		director = null;
		Asset.Unload(UIPath, isDontDestroy: true);
		hasLoading = false;
	}
}
