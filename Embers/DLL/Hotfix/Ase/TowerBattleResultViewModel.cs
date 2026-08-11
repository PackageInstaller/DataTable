using Cysharp.Threading.Tasks;
using GameFramework.Runtime;

namespace Ase;

public class TowerBattleResultViewModel : OptionBase
{
	private bool showSuccess;

	private SimpleCommand quitCopyCmd;

	private SimpleCommand challengeEndlessCmd;

	private int copyId;

	private int towerNum;

	private int score;

	private bool closeWindow;

	private bool quitCopy;

	private bool showScore;

	public bool ShowSuccess
	{
		get
		{
			return showSuccess;
		}
		private set
		{
			Set(ref showSuccess, value, "ShowSuccess");
		}
	}

	public bool ShowScore
	{
		get
		{
			return showScore;
		}
		private set
		{
			Set(ref showScore, value, "ShowScore");
		}
	}

	public int Score
	{
		get
		{
			return score;
		}
		private set
		{
			Set(ref score, value, "Score");
		}
	}

	public bool CloseWindow => closeWindow;

	public bool QuitCopy => quitCopy;

	public SimpleCommand QuitCopyCmd => quitCopyCmd;

	public SimpleCommand ChallengeEndlessCmd => challengeEndlessCmd;

	public TowerBattleResultViewModel(bool success, int copyId, int towerNum, int score, bool showScore)
	{
		quitCopyCmd = new SimpleCommand(BackActivityView);
		challengeEndlessCmd = new SimpleCommand(ChallengeEndless);
		showSuccess = success;
		this.copyId = copyId;
		this.towerNum = towerNum;
		this.score = score;
		this.showScore = showScore;
	}

	private void BackActivityView()
	{
		closeWindow = true;
		quitCopy = true;
		OpenLoading();
	}

	private void ChallengeEndless()
	{
		closeWindow = true;
		string sceneLoadPath = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetSceneLoadPath();
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().PlayTower(copyId, towerNum, 1, sceneLoadPath, sendTowerBattleData: false);
	}

	private async void OpenLoading()
	{
		string sceneLoadPath = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>().GetSceneLoadPath();
		LoadingBackToMainViewModel loadingBackToMainViewModel = new LoadingBackToMainViewModel(sceneLoadPath, autoUnload: true, "OperatingActivityWindow");
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
	}
}
