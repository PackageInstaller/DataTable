using System.Threading;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Model;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class TriggerCountdownTutorialAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		TriggerCountdownTutorialActionParam param = Param as TriggerCountdownTutorialActionParam;
		if (param == null)
		{
			Debug.LogError("倒计时教程行为参数为空");
			return UniTask.CompletedTask;
		}
		if (!Model<TutorialModel>.HasInstance())
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("TutorialModel 未初始化，无法触发倒计时教程");
			}
			return UniTask.CompletedTask;
		}
		if (!Model<TutorialModel>.Interface.CanTriggerTutorial(param.tutorialId))
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.Log($"倒计时教程已触发或不可触发：{param.tutorialId}");
			}
			return UniTask.CompletedTask;
		}
		if (CoreUtils.GetData(param.tutorialId, RuntimeConfigs.data.guideTutorials) == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"guideTutorials 表中不存在教程：{param.tutorialId}");
			}
			return UniTask.CompletedTask;
		}
		G.service.TriggerTutorial(param.tutorialId, (bool success) =>
		{
			if (success)
			{
				TriggerGuideTutorial evt = Singleton<EventManager>.instance.GetEvt<TriggerGuideTutorial>();
				evt.triggerTutorialId = param.tutorialId;
				evt.duration = Mathf.Max(0f, param.duration);
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.Trigger_Tutorial, evt);
				Singleton<EventManager>.instance.ReleaseEvt(evt);
			}
		});
		return UniTask.CompletedTask;
	}
}
