using System.Collections.Generic;
using Cysharp.Threading.Tasks;

namespace Ase;

[Trigger("Timeline2新手关引导")]
public class Timeline2LevelGuidanceEventTrigger : TimelineEventTrigger
{
	public List<GuidanceManager.LevelGuidanceStep> levelGuidanceSteps;

	public override string TriggerName => "Timeline-新手关触发器";

	protected override void DoExecute()
	{
		base.DoExecute();
		ExecuteGuidacne();
	}

	private async void ExecuteGuidacne()
	{
		if (levelGuidanceSteps == null || levelGuidanceSteps.Count <= 0)
		{
			return;
		}
		List<GuidanceManager.LevelGuidanceStep>.Enumerator datas = levelGuidanceSteps.GetEnumerator();
		UIGuidanceWindow window = await Singleton<GuidanceManager>.Instance.GetUIGuidancWindow();
		while (datas.MoveNext())
		{
			GuidanceManager.LevelGuidanceStep levelGuidanceStep = datas.Current;
			if (levelGuidanceStep.Check())
			{
				UIGuidanceViewModel uiGuidanceViewModel = new UIGuidanceViewModel(levelGuidanceStep);
				window.BindGuidance(uiGuidanceViewModel);
				await UniTask.WaitUntil(() => uiGuidanceViewModel.IsFinish || !levelGuidanceStep.Check());
				if (!uiGuidanceViewModel.IsFinish)
				{
					executeTime = 1;
					uiGuidanceViewModel.Close();
					break;
				}
				executeTime = 0;
			}
		}
		window.CloseGuidanceWindow();
		datas.Dispose();
	}
}
