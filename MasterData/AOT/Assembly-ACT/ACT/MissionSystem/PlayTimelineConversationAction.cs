using System;
using System.Threading;
using ACT.Drama;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class PlayTimelineConversationAction : MissionAction
{
	protected override async UniTask OnInvoke(IQuestContext context, MissionActionInvokeOptions option, CancellationToken token)
	{
		try
		{
			PlayTimelineConversationActionParam playTimelineConversationActionParam = Param as PlayTimelineConversationActionParam;
			await Singleton<TimelineConversationManager>.instance.PlayTimeline(playTimelineConversationActionParam.timelineId);
		}
		catch (Exception message)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError(message);
			}
		}
	}
}
