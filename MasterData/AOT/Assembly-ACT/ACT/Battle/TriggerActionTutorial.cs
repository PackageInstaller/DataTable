using System.Threading;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.Battle;

public class TriggerActionTutorial : TriggerActionBase
{
	public int triggerTutorialId;

	public int triggerTutorialType;

	public override UniTask Invoke(TriggerActionContext context, CancellationToken token)
	{
		if (triggerTutorialType != 1 && triggerTutorialType != 2)
		{
			triggerTutorialType = 1;
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
			return UniTask.CompletedTask;
		}
		if (!Model<TutorialModel>.Interface.CanTriggerTutorial(triggerTutorialId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log("已经触发过这个教程了，不能触发");
			}
			return UniTask.CompletedTask;
		}
		if (CoreUtils.GetData(triggerTutorialId, RuntimeConfigs.data.guideTutorials) == null)
		{
			return UniTask.CompletedTask;
		}
		G.service.TriggerTutorial(triggerTutorialId, (bool b) =>
		{
			if (b)
			{
				switch (triggerTutorialType)
				{
				case 1:
				{
					TriggerGuideTutorial evt = Singleton<EventManager>.instance.GetEvt<TriggerGuideTutorial>();
					evt.triggerTutorialId = triggerTutorialId;
					evt.duration = 5f;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.Trigger_Tutorial, evt);
					Singleton<EventManager>.instance.ReleaseEvt(evt);
					break;
				}
				case 2:
					Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_GUIDEIMAGEVIDEO, new GuideImageVideoViewData
					{
						tutorialId = triggerTutorialId
					});
					break;
				}
			}
		});
		return UniTask.CompletedTask;
	}
}
