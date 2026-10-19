using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class PlayTimelineWithNpcUntilCompletedCondition : MissionCondition
{
	private bool m_Finished;

	private MissionPointData m_MissionPoint;

	private LocalizedString m_Description;

	public override bool AllowRepeat => true;

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		if (m_MissionPoint != null)
		{
			if (m_Description == null)
			{
				m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
			}
			yield return new ConditionDescription
			{
				HaveContent = (Desc != 0),
				DescriptionContent = m_Description,
				HaveMissionPoint = true,
				MissionPointId = m_MissionPoint.PointId
			};
		}
	}

	protected override void OnInMissionWorld()
	{
		m_Finished = false;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Npc_Timeline_Finish, OnNpcTimelineFinish);
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Npc_Timeline_Finish, OnNpcTimelineFinish);
	}

	protected override void OnTracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			PlayTimelineWithNpcUntilCompletedConditionParam playTimelineWithNpcUntilCompletedConditionParam = Param as PlayTimelineWithNpcUntilCompletedConditionParam;
			if (playTimelineWithNpcUntilCompletedConditionParam.showMissionPointIcon || playTimelineWithNpcUntilCompletedConditionParam.showMissionPointRadius)
			{
				int newPointId = Model<BattleMainMarkModelV2>.Interface.GetNewPointId();
				bool missionPointOverride = playTimelineWithNpcUntilCompletedConditionParam.missionPointOverride;
				m_MissionPoint = new NPCMissionPoint(customPosition: new Vector3(playTimelineWithNpcUntilCompletedConditionParam.positionX, playTimelineWithNpcUntilCompletedConditionParam.positionY, playTimelineWithNpcUntilCompletedConditionParam.positionZ), missionId: Flow.Id, pointId: newPointId, use3DLogic: playTimelineWithNpcUntilCompletedConditionParam.use3DLogic, area: playTimelineWithNpcUntilCompletedConditionParam.mapArea, npcUid: playTimelineWithNpcUntilCompletedConditionParam.npcId, custom: missionPointOverride);
				m_MissionPoint.ShowIcon = playTimelineWithNpcUntilCompletedConditionParam.showMissionPointIcon;
				m_MissionPoint.ShowRadius = playTimelineWithNpcUntilCompletedConditionParam.showMissionPointRadius;
				m_MissionPoint.Radius = playTimelineWithNpcUntilCompletedConditionParam.missionPointRadius;
				Model<BattleMainMarkModelV2>.Interface.RegisterPoint(m_MissionPoint);
			}
		}
	}

	protected override void OnUntracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			PlayTimelineWithNpcUntilCompletedConditionParam playTimelineWithNpcUntilCompletedConditionParam = Param as PlayTimelineWithNpcUntilCompletedConditionParam;
			if (playTimelineWithNpcUntilCompletedConditionParam.showMissionPointIcon || playTimelineWithNpcUntilCompletedConditionParam.showMissionPointRadius)
			{
				Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(m_MissionPoint);
			}
		}
	}

	private void OnNpcTimelineFinish(BaseEventContent obj)
	{
		NpcEvent npcEvent = obj as NpcEvent;
		PlayTimelineWithNpcUntilCompletedConditionParam playTimelineWithNpcUntilCompletedConditionParam = Param as PlayTimelineWithNpcUntilCompletedConditionParam;
		if (playTimelineWithNpcUntilCompletedConditionParam.npcId == npcEvent.NpcID && playTimelineWithNpcUntilCompletedConditionParam.timelineId == npcEvent.AvgGroupID && (IsRepeat || !m_Finished))
		{
			m_Finished = true;
			MarkSuccess();
		}
	}
}
