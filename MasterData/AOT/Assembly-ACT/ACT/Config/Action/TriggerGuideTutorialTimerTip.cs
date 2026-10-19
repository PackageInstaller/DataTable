using ACT.Event;
using ACT.Game;
using ACT.Model;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.Config.Action;

public class TriggerGuideTutorialTimerTip : GuideStepAction
{
	public int tutorialId;

	public override void Execute(GuideStepData data)
	{
		if (tutorialId == 0 && LuminApplication.LogEnabled)
		{
			Debug.LogError("没配教程ID，查配置");
		}
		new TutorialComponentData
		{
			TutorialId = tutorialId,
			CdTime = 5f
		};
		G.service.TriggerTutorial(tutorialId, (bool b) =>
		{
			if (b)
			{
				TriggerGuideTutorial evt = Singleton<EventManager>.instance.GetEvt<TriggerGuideTutorial>();
				evt.triggerTutorialId = tutorialId;
				evt.duration = 5f;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Trigger_Tutorial, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		});
	}
}
