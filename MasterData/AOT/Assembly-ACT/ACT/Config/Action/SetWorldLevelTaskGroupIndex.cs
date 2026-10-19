using ACT.Battle;
using ACT.Model;
using ACT.UI;
using Fundamental;

namespace ACT.Config.Action;

public class SetWorldLevelTaskGroupIndex : GuideStepAction, IActionUninit
{
	public int index;

	public override void Execute(GuideStepData data)
	{
		Model<WorldLevelModel>.Interface.SetGuideWorldLevelTaskGroupIndex(index);
		if (Singleton<GameState>.instance != null && Singleton<GameState>.instance.InGuiding && !(MonoECS.instance == null) && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_MONOJOURNEYTRACESVIEW, out var ui) && ui.GetUIView() is MonoJourneyTracesView { worldLevelPage: { } worldLevelPage })
		{
			worldLevelPage.TryApplyGuideWorldLevelTaskGroupSelection();
		}
	}

	public void UnInit()
	{
		Model<WorldLevelModel>.Interface.ResetGuideWorldLevelTaskGroupIndex();
		if (Singleton<NewUIManager>.instance.TryGetFirstUIController(UI_TYPE.UI_MONOJOURNEYTRACESVIEW, out var ui) && ui.GetUIView() is MonoJourneyTracesView monoJourneyTracesView && monoJourneyTracesView.GetCurSubControllerType() == JourneyTraceSubController.SelectWorldLevelTaskGroup)
		{
			monoJourneyTracesView.ChangeToGamePadInputState(JourneyTraceSubController.main, needReFocusLayer: true);
		}
	}
}
