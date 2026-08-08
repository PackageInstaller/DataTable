using UnityEngine;

namespace P08Main.Loading;

public class BilliardGameLoading_Common : CustomLoadingBase
{
	private static string UIPath = "Widget/System/Activity_SummerPub/MainPub/Com/Activity_Loading";

	private GameObject billiardLoading;

	private Animator mAnimator;

	public static BilliardGameLoading_Common Instance;

	public bool isInit;

	public bool hasLoading;

	public bool isClosed;

	public float endTimeDuration = 0.3f;

	public override void CloseLoadUI()
	{
		mAnimator.Play("End");
		int timer = 0;
		timer = FuncTimerManager.inst.CreateFuncTimer(delegate
		{
			FuncTimerManager.inst.RemoveFuncTimer(timer);
			Finished();
		}, endTimeDuration, 1);
		isClosed = true;
	}

	public override void Dispose()
	{
		isInit = false;
	}

	public override LoadingImpl GetEnum()
	{
		return LoadingImpl.BilliardGame_Loading;
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
			mAnimator = billiardLoading.GetComponent<Animator>();
		}
		billiardLoading.SetActive(value: false);
		billiardLoading.SetActive(value: true);
		hasLoading = true;
		isClosed = false;
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_marble_ui_turn_in", useStream: false);
	}

	private void Finished()
	{
		Object.Destroy(billiardLoading);
		billiardLoading = null;
		mAnimator = null;
		Asset.Unload(UIPath, isDontDestroy: true);
		hasLoading = false;
		AudioManager.Instance.Play("effect", "minigame_activity_4_3", "minigame_activity_4_3_marble_ui_turn_out", useStream: false);
	}
}
