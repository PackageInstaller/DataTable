using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class TemplesCompletedCondition : MissionCondition
{
	private List<MissionPointData> m_MissionPoints = new List<MissionPointData>();

	private LocalizedString m_Description;

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		if (m_MissionPoints.Count > 0)
		{
			if (m_Description == null)
			{
				m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
			}
			yield return new ConditionDescription
			{
				HaveContent = (Desc != 0),
				DescriptionContent = m_Description,
				HaveMissionPoint = (m_MissionPoints[0] != null),
				MissionPointId = ((m_MissionPoints[0] != null) ? m_MissionPoints[0].PointId : 0)
			};
		}
	}

	protected override async void OnInMissionWorld()
	{
		if (IsRepeat)
		{
			do
			{
				if (CheckCondition())
				{
					MarkSuccess();
				}
				await UniTask.Yield();
			}
			while (InMissionWorld);
			return;
		}
		do
		{
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	protected override void OnTracing()
	{
		if (Stage.Data.stageType == MissionStageType.Fail)
		{
			return;
		}
		TemplesCompletedConditionParam templesCompletedConditionParam = Param as TemplesCompletedConditionParam;
		if (!templesCompletedConditionParam.showMissionPointIcon && !templesCompletedConditionParam.showMissionPointRadius)
		{
			return;
		}
		foreach (int interactObject in templesCompletedConditionParam.interactObjects)
		{
			int newPointId = Model<BattleMainMarkModelV2>.Interface.GetNewPointId();
			bool missionPointOverride = templesCompletedConditionParam.missionPointOverride;
			StateObjectMissionPoint stateObjectMissionPoint = new StateObjectMissionPoint(customPosition: new Vector3(templesCompletedConditionParam.positionX, templesCompletedConditionParam.positionY, templesCompletedConditionParam.positionZ), missionId: Flow.Id, pointId: newPointId, use3DLogic: templesCompletedConditionParam.use3DLogic, area: templesCompletedConditionParam.mapArea, interactObjId: interactObject, needEffect: false, custom: missionPointOverride);
			stateObjectMissionPoint.ShowIcon = templesCompletedConditionParam.showMissionPointIcon;
			stateObjectMissionPoint.ShowRadius = templesCompletedConditionParam.showMissionPointRadius;
			stateObjectMissionPoint.Radius = templesCompletedConditionParam.missionPointRadius;
			m_MissionPoints.Add(stateObjectMissionPoint);
			Model<BattleMainMarkModelV2>.Interface.RegisterPoint(stateObjectMissionPoint);
		}
	}

	protected override void OnUntracing()
	{
		if (Stage.Data.stageType == MissionStageType.Fail)
		{
			return;
		}
		foreach (MissionPointData missionPoint in m_MissionPoints)
		{
			Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(missionPoint);
		}
		m_MissionPoints.Clear();
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		TemplesCompletedConditionParam templesCompletedConditionParam = Param as TemplesCompletedConditionParam;
		for (int i = 0; i < templesCompletedConditionParam.templeIds.Count; i++)
		{
			int templeId = templesCompletedConditionParam.templeIds[i];
			TempleData templeData = Model<TempleModel>.Interface.GetTempleData(templeId);
			if (templeData == null)
			{
				return false;
			}
			if (!templeData.isComplate)
			{
				return false;
			}
		}
		return true;
	}
}
