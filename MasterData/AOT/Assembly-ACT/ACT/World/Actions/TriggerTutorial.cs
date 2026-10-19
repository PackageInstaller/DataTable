using ACT.Battle.Configs;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model;
using ACT.UI;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.World.Actions;

public class TriggerTutorial : InteractAction
{
	[Tooltip("教程Id")]
	public int triggerTutorialId;

	[Tooltip("触发形式：1，倒计时 2，图文弹窗")]
	public int triggerTutorialType;

	protected override AbilityAuth auth => AbilityAuth.Client;

	protected override UniTask OnInteract(Entity behave, InteractSource interactSource)
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
