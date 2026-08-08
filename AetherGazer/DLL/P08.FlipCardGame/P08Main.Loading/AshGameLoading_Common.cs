using UnityEngine;

namespace P08Main.Loading;

public class AshGameLoading_Common : CustomLoadingBase
{
	private static string UIPath = "Widget/System/Activity_EkChuah/EkChuah_BattleUI/EkChuah_BattleCutScenesUI";

	private GameObject ashLoading;

	private Animator anim;

	public static AshGameLoading_Common Instance;

	public bool isInit;

	public bool hasLoading;

	public bool isClosed;

	public float endTimeDuration = 1.3f;

	public override void CloseLoadUI()
	{
		int timer = 0;
		anim.Play("out", 0, 0f);
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
		return LoadingImpl.AshGame_Loading;
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
		if (ashLoading == null)
		{
			ashLoading = Asset.InstantiateWithoutCache(UIPath, dontDestroy: true);
			ashLoading.transform.SetParent(GameObject.Find("UICamera_DontDestroy/Canvas").transform, worldPositionStays: false);
			anim = ashLoading.GetComponent<Animator>();
		}
		ashLoading.SetActive(value: false);
		ashLoading.SetActive(value: true);
		anim.Play("in", 0, 0f);
		hasLoading = true;
		isClosed = false;
	}

	private void Finished()
	{
		Object.Destroy(ashLoading);
		ashLoading = null;
		Asset.Unload(UIPath, isDontDestroy: true);
		hasLoading = false;
	}
}
