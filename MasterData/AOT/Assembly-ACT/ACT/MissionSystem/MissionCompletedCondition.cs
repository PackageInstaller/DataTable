using System.Collections.Generic;
using ACT.Event;
using ACT.Utility;
using Fundamental;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class MissionCompletedCondition : MissionCondition
{
	private bool m_Tracing;

	private bool m_Finished;

	private LocalizedString m_Description;

	public override bool AllowRepeat => true;

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		MissionCompletedConditionParam missionCompletedConditionParam = Param as MissionCompletedConditionParam;
		MissionData missionData = Singleton<MissionManager>.instance.GetMissionData(missionCompletedConditionParam.missionId);
		if (missionData == null || missionData.Config.MissionBase.isHidden)
		{
			yield break;
		}
		if (Desc != 0)
		{
			if (m_Description == null)
			{
				m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
			}
		}
		else if (m_Description == null)
		{
			m_Description = new LocalizedString("Common", 41000203L);
			m_Description["0"] = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, missionData.Config.MissionNameId);
		}
		yield return new ConditionDescription
		{
			HaveContent = true,
			DescriptionContent = m_Description,
			IconType = missionData.Config.MissionTypeEnum,
			HaveProgress = true,
			Progress = (IsFinished ? 1 : 0),
			TotalProgress = 1
		};
	}

	protected override void OnInMissionWorld()
	{
		if (!IsRepeat && CheckCondition())
		{
			m_Finished = true;
			MarkSuccess();
		}
		else
		{
			Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Success, OnMissionFinished);
		}
	}

	protected override void OnOutMissionWorld()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Success, OnMissionFinished);
	}

	protected override void OnTracing()
	{
		if (Stage.StageType == MissionStageType.Stage)
		{
			MissionCompletedConditionParam missionCompletedConditionParam = Param as MissionCompletedConditionParam;
			Singleton<MissionManager>.instance.AddImplicitTracingMission(missionCompletedConditionParam.missionId);
		}
	}

	protected override void OnUntracing()
	{
		if (Stage.StageType == MissionStageType.Stage)
		{
			MissionCompletedConditionParam missionCompletedConditionParam = Param as MissionCompletedConditionParam;
			Singleton<MissionManager>.instance.RemoveImplicitTracingMission(missionCompletedConditionParam.missionId);
		}
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		MissionCompletedConditionParam missionCompletedConditionParam = Param as MissionCompletedConditionParam;
		if (Singleton<MissionManager>.instance.IsFinished(missionCompletedConditionParam.missionId))
		{
			return true;
		}
		return false;
	}

	private void OnMissionFinished(BaseEventContent obj)
	{
		MissionCompletedConditionParam missionCompletedConditionParam = Param as MissionCompletedConditionParam;
		if (obj is MissionNSuccessEvt missionNSuccessEvt && missionNSuccessEvt.missionId == missionCompletedConditionParam.missionId && InMissionWorld)
		{
			if (IsRepeat)
			{
				m_Finished = true;
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
