using System;
using System.Threading;
using ACT.Event;
using ACT.Model;
using ACT.UI;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class WorldLevelBreakTaskTipAction : MissionAction
{
	protected override UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		try
		{
			OnHudCpEnqueue evt = Singleton<EventManager>.instance.GetEvt<OnHudCpEnqueue>();
			evt.position = UIPosition.Top;
			evt.type = HudComponentType.WorldLevelBreakTaskTips;
			evt.timeOutDuration = 15f;
			evt.priorityInQueue = 2;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_HudUIEnqueue, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
		catch (Exception message)
		{
			Debug.LogError(message);
		}
		return UniTask.CompletedTask;
	}
}
