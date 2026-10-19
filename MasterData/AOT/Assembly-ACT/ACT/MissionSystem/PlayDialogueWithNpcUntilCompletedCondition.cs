using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class PlayDialogueWithNpcUntilCompletedCondition : MissionCondition
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
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Npc_Dialog_Finish, OnNpcDialogFinish);
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Npc_Dialog_Finish, OnNpcDialogFinish);
	}

	protected override void OnTracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			PlayDialogueWithNpcUntilCompletedConditionParam playDialogueWithNpcUntilCompletedConditionParam = Param as PlayDialogueWithNpcUntilCompletedConditionParam;
			if (playDialogueWithNpcUntilCompletedConditionParam.showMissionPointIcon || playDialogueWithNpcUntilCompletedConditionParam.showMissionPointRadius)
			{
				int newPointId = Model<BattleMainMarkModelV2>.Interface.GetNewPointId();
				bool missionPointOverride = playDialogueWithNpcUntilCompletedConditionParam.missionPointOverride;
				m_MissionPoint = new NPCMissionPoint(customPosition: new Vector3(playDialogueWithNpcUntilCompletedConditionParam.positionX, playDialogueWithNpcUntilCompletedConditionParam.positionY, playDialogueWithNpcUntilCompletedConditionParam.positionZ), missionId: Flow.Id, pointId: newPointId, use3DLogic: playDialogueWithNpcUntilCompletedConditionParam.use3DLogic, area: playDialogueWithNpcUntilCompletedConditionParam.mapArea, npcUid: playDialogueWithNpcUntilCompletedConditionParam.npcId, custom: missionPointOverride);
				m_MissionPoint.ShowIcon = playDialogueWithNpcUntilCompletedConditionParam.showMissionPointIcon;
				m_MissionPoint.ShowRadius = playDialogueWithNpcUntilCompletedConditionParam.showMissionPointRadius;
				m_MissionPoint.Radius = playDialogueWithNpcUntilCompletedConditionParam.missionPointRadius;
				Model<BattleMainMarkModelV2>.Interface.RegisterPoint(m_MissionPoint);
			}
		}
	}

	protected override void OnUntracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			PlayDialogueWithNpcUntilCompletedConditionParam playDialogueWithNpcUntilCompletedConditionParam = Param as PlayDialogueWithNpcUntilCompletedConditionParam;
			if (playDialogueWithNpcUntilCompletedConditionParam.showMissionPointIcon || playDialogueWithNpcUntilCompletedConditionParam.showMissionPointRadius)
			{
				Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(m_MissionPoint);
			}
		}
	}

	private void OnNpcDialogFinish(BaseEventContent obj)
	{
		NpcEvent npcEvent = obj as NpcEvent;
		PlayDialogueWithNpcUntilCompletedConditionParam playDialogueWithNpcUntilCompletedConditionParam = Param as PlayDialogueWithNpcUntilCompletedConditionParam;
		if (playDialogueWithNpcUntilCompletedConditionParam.npcId == npcEvent.NpcID && playDialogueWithNpcUntilCompletedConditionParam.storyGroupId == npcEvent.AvgGroupID)
		{
			if (IsRepeat)
			{
				MarkSuccess();
			}
			else if (!m_Finished)
			{
				m_Finished = true;
				MarkSuccess();
			}
		}
	}
}
