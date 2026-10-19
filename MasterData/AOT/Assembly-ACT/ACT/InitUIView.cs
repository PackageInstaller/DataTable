using ACT.Battle;
using ACT.UI;
using ACT.Utility;
using Fundamental;

namespace ACT;

internal class InitUIView : WorldLoadStepOperation
{
	internal override async void OnStart()
	{
		Singleton<LoadManager>.instance.StartLoading(new LoaderViewData
		{
			TargetSceneStatus = MonoECS.instance.sceneStatus,
			TargetMapArea = GameUtility.GetMainMapArea()
		});
		Singleton<NewUIManager>.instance.ApplyMarkedLifetimePolicies();
		await Singleton<NewUIManager>.instance.PreLoadMarkedUIs();
		State = OptionState.Succeed;
	}

	internal override void OnUpdate()
	{
	}
}
