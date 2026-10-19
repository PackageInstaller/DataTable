using System;
using ACT.Drama;
using Fundamental;
using UnityEngine;

namespace ACT.MissionSystem;

public class PlayTimelineUntilCompletedCondition : MissionCondition
{
	protected override async void OnInMissionWorld()
	{
		try
		{
			PlayTimelineUntilCompletedConditionParam playTimelineUntilCompletedConditionParam = Param as PlayTimelineUntilCompletedConditionParam;
			PlayTimelineConfig playTimelineConfig = new PlayTimelineConfig
			{
				BlackScreenLoading = playTimelineUntilCompletedConditionParam.blackScreenIn,
				FadeInTime = playTimelineUntilCompletedConditionParam.blackScreenInTime
			};
			TimelineConversationManager instance = Singleton<TimelineConversationManager>.instance;
			int timelineId = playTimelineUntilCompletedConditionParam.timelineId;
			PlayTimelineConfig config = playTimelineConfig;
			if (await instance.PlayTimeline(timelineId, default, config))
			{
				MarkSuccess();
			}
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
