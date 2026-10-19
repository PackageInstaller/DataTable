using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class ItemSubmitInteractCondition : ItemSubmitCondition
{
	private bool m_Finished;

	private MissionPointData m_MissionPoint;

	private MissionManager.InteractObject m_InteractObject;

	private LocalizedString m_Description;

	public override bool AllowRepeat => true;

	public override bool ServerVerify => true;

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
		Flow.Blackboard.Set("ItemSubmitCondition", this);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_ItemSubmit, OnItemSubmit);
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			ItemSubmitInteractConditionParam itemSubmitInteractConditionParam = Param as ItemSubmitInteractConditionParam;
			m_InteractObject = Singleton<MissionManager>.instance.RegisterInteractObject(itemSubmitInteractConditionParam.interactId, Flow.Id);
		}
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		Flow.Blackboard.Remove("ItemSubmitCondition");
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_ItemSubmit, OnItemSubmit);
		if (Stage.Data.stageType != MissionStageType.Fail && m_InteractObject != null)
		{
			Singleton<MissionManager>.instance.UnRegisterInteractObject(m_InteractObject);
			m_InteractObject = null;
		}
	}

	public override void OnServerVerifyFailed()
	{
		m_Finished = false;
	}

	protected override void OnTracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			ItemSubmitInteractConditionParam itemSubmitInteractConditionParam = Param as ItemSubmitInteractConditionParam;
			if (itemSubmitInteractConditionParam.showMissionPointIcon || itemSubmitInteractConditionParam.showMissionPointRadius)
			{
				int newPointId = Model<BattleMainMarkModelV2>.Interface.GetNewPointId();
				bool missionPointOverride = itemSubmitInteractConditionParam.missionPointOverride;
				m_MissionPoint = new StateObjectMissionPoint(customPosition: new Vector3(itemSubmitInteractConditionParam.positionX, itemSubmitInteractConditionParam.positionY, itemSubmitInteractConditionParam.positionZ), missionId: Flow.Id, pointId: newPointId, use3DLogic: itemSubmitInteractConditionParam.use3DLogic, area: itemSubmitInteractConditionParam.mapArea, interactObjId: itemSubmitInteractConditionParam.interactId, needEffect: true, custom: missionPointOverride);
				m_MissionPoint.ShowIcon = itemSubmitInteractConditionParam.showMissionPointIcon;
				m_MissionPoint.Radius = itemSubmitInteractConditionParam.missionPointRadius;
				Model<BattleMainMarkModelV2>.Interface.RegisterPoint(m_MissionPoint);
			}
		}
	}

	protected override void OnUntracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			ItemSubmitInteractConditionParam itemSubmitInteractConditionParam = Param as ItemSubmitInteractConditionParam;
			if (itemSubmitInteractConditionParam.showMissionPointIcon || itemSubmitInteractConditionParam.showMissionPointRadius)
			{
				Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(m_MissionPoint);
			}
		}
	}

	private void OnItemSubmit(BaseEventContent obj)
	{
		if (obj is SubmitItem submitItem && submitItem.MissionId == Flow.Id)
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
