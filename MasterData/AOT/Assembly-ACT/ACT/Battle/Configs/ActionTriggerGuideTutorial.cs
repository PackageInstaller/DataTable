using ACT.Core;
using ACT.Game;
using ACT.Model;
using ACT.UI;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class ActionTriggerGuideTutorial : ConfigAction
{
	public enum TutorialType
	{
		timer,
		window
	}

	public int triggerTutorialId;

	public TutorialType triggerTutorialType;

	public override void Do(ActionMemory memory)
	{
		if (triggerTutorialType != TutorialType.timer && triggerTutorialType != TutorialType.window)
		{
			triggerTutorialType = TutorialType.timer;
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("教程触发方式类型没填或者填了非法的值！！！！，先改成倒计时触发，检查交互物事件配置！！！");
			}
		}
		if (!Model<TutorialModel>.HasInstance())
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("tutorialModel没初始化");
			}
		}
		else if (!Model<TutorialModel>.Interface.CanTriggerTutorial(triggerTutorialId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("已经触发过这个教程了，不能触发");
			}
		}
		else
		{
			if (CoreUtils.GetData(triggerTutorialId, RuntimeConfigs.data.guideTutorials) == null)
			{
				return;
			}
			G.service.TriggerTutorial(triggerTutorialId, (bool b) =>
			{
				if (b)
				{
					switch (triggerTutorialType)
					{
					case TutorialType.timer:
					{
						TutorialComponentData data = new TutorialComponentData
						{
							TutorialId = triggerTutorialId,
							CdTime = 5f
						};
						Model<BattleMainModel>.Interface.HudPositionUIEnqueue(UIPosition.LowerMiddle, HudComponentType.TutorialTimerTip, data, 15f, 1, ignorePriorityRule: false, clearQueueByCpTypeBeforeEnter: false, new Vector2(0f, 74f));
						break;
					}
					case TutorialType.window:
						Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
						{
							tutorialId = triggerTutorialId
						});
						break;
					}
				}
			});
		}
	}
}
