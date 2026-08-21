using Cysharp.Threading.Tasks;

namespace Ase;

[Trigger("怪物组2完成新手关触发器")]
public class Monster2FinishLevelGuideEventTrigger : MonsterGroupEventTrigger
{
	public int storyId;

	public override string TriggerName => "怪物组-完成新手关触发器";

	protected override async void DoExecute()
	{
		base.DoExecute();
		string sceneLoadPath = sceneSystem.GetWorld().SceneLoadPath;
		await Singleton<Story>.Instance.PlayStory(sceneSystem.GetWorld().Id, storyId);
		BlackScreen blackScreen = await BlackScreen.Show("TIMELINE");
		await UniTask.WaitForSeconds(1);
		await sceneSystem.CloseStreamer();
		sceneSystem.ExitLevelDataReport();
		Singleton<GameSystem>.Instance.DestroyWorldChannel(sceneSystem.GetWorld());
		Game.RemoveSingleton<GameSystem>();
		Game.RemoveSingleton<MathTriggerSystem>();
		await UniTask.WaitForSeconds(1);
		LoadingGuideLevelViewModel loading = LoadingGuideLevelViewModel.CreateGuideSecondStep(sceneLoadPath);
		DRLoadingTips randomLoadingTap = await Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().PrepareLoading(GameProcessType.Story);
		loading.SetRandomLoadingTap(randomLoadingTap);
		LoadingWindow obj = await GameEntry.UI.LoadWindow<LoadingWindow>(AssetUtility.GetUIFormAsset("Loading/LoadingWindow"), "LOADING", loading);
		blackScreen.Dispose();
		obj.DoShow(ignoreAnimation: true);
		await UniTask.WaitUntil(() => loading.IsLoadingFinish);
		bool loadingSuccess = loading.LoadingSuccess;
		if (loading.LoadingSuccess)
		{
			await loading.CloseLoading();
		}
		Singleton<ServiceSystem>.Instance.GetService<ILoadingService>().LoadingEnd(loadingSuccess);
	}
}
