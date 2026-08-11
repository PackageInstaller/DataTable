using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class BattleEndViewModel : OptionBase
{
	private Timer timer;

	private int checkTime;

	private bool needLoading;

	private ISubscription<AccounetNotifyMessager> accounetDisconnectSubscription;

	public BattleEndViewModel(bool GetbattleResult)
	{
		needLoading = true;
		CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyData();
		accounetDisconnectSubscription = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<AccounetNotifyMessager>(OnAccountNotify);
		if (copyData.CopyType == 98000 || !GetbattleResult)
		{
			OpenActivityWindow();
		}
		else
		{
			timer = Timer.Register(0.5f, CheckBattleResult, null, isLooped: true, useRealTime: true);
		}
	}

	private void CheckBattleResult()
	{
		if (!needLoading)
		{
			return;
		}
		if (Singleton<ServiceSystem>.Instance?.GetService<IMultiRoomService>()?.GetBattleReward().IsInit == true)
		{
			needLoading = false;
			Success();
			return;
		}
		checkTime++;
		if (checkTime >= 20)
		{
			needLoading = false;
			Fail();
		}
	}

	private async void Success()
	{
		BattleResultViewModel battleResultViewModel = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetBattleResultViewModel();
		if (!battleResultViewModel.IsWin)
		{
			await GameEntry.UI.OpenWindow<BattleResultFailWindow>("BattleEnd/BattleResultFailWindow", "DEFAULT", battleResultViewModel);
		}
		else
		{
			await GameEntry.UI.OpenWindow<BattleResultWinWindow>("BattleEnd/BattleResultWinWindow", "DEFAULT", battleResultViewModel);
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().ClearBattleResult();
		timer?.Cancel();
		timer = null;
	}

	private async void Fail()
	{
		Toast.ShowInfo("获取战斗奖励失败!");
		OpenLoading();
	}

	private void OpenActivityWindow()
	{
		OpenLoading("OperatingActivityWindow");
	}

	private async void OpenLoading(string openWindow = null)
	{
		string sceneLoadPath = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetSceneLoadPath();
		LoadingBackToMainViewModel loadingBackToMainViewModel = new LoadingBackToMainViewModel(sceneLoadPath, autoUnload: true, openWindow);
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Outer);
		loadingBackToMainViewModel.SetRandomLoadingTap(randomLoadingTap);
		(await GameEntry.UI.LoadWindow<LoadingWindow>(AssetUtility.GetUIFormAsset("Loading/LoadingWindow"), "LOADING", loadingBackToMainViewModel)).DoShow();
		await UniTask.WaitUntil(() => loadingBackToMainViewModel.IsLoadingFinish);
		bool loadingSuccess = loadingBackToMainViewModel.LoadingSuccess;
		if (loadingBackToMainViewModel.LoadingSuccess)
		{
			await loadingBackToMainViewModel.CloseLoading();
		}
		Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().SetSceneLoadPath(null);
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
		timer?.Cancel();
		timer = null;
	}

	private async void OnAccountNotify(AccounetNotifyMessager msg)
	{
		string text = null;
		CopyData copyData = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetCopyData();
		if (copyData != null)
		{
			text = ((copyData.CopyMainId != 6 && copyData.CopyMainId != 8) ? ("Copy/" + copyData.SceneName) : Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetSceneLoadPath());
		}
		if (string.IsNullOrEmpty(text))
		{
			text = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetSceneLoadPath();
		}
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().BacktiTitle(text);
	}

	public void Clear()
	{
		if (accounetDisconnectSubscription != null)
		{
			accounetDisconnectSubscription.Dispose();
			accounetDisconnectSubscription = null;
		}
	}

	public override void Close()
	{
		Clear();
		base.Close();
	}
}
