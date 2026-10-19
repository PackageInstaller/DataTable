using System.Collections.Generic;
using ACT.Event;
using ACT.Utility;
using Fundamental;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class KCMissionCondition : MissionCondition
{
	private bool m_Finished;

	private readonly Dictionary<int, LocalizedString> m_Descriptions = new Dictionary<int, LocalizedString>();

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		if (!TryGetParam(out var param) || param.missions.Count == 0)
		{
			yield break;
		}
		for (int i = 0; i < param.missions.Count; i++)
		{
			int missionId = param.missions[i];
			MissionData missionData = Singleton<MissionManager>.instance.GetMissionData(missionId);
			if (missionData != null)
			{
				yield return new ConditionDescription
				{
					HaveContent = true,
					DescriptionContent = GetDescription(missionData, missionId),
					IconType = missionData.Config.MissionTypeEnum,
					HaveProgress = true,
					Progress = (Singleton<MissionManager>.instance.IsFinished(missionId) ? 1 : 0),
					TotalProgress = 1
				};
			}
		}
	}

	private LocalizedString GetDescription(MissionData missionData, int missionId)
	{
		if (!m_Descriptions.TryGetValue(missionId, out var value))
		{
			value = ((Desc == 0) ? new LocalizedString("Common", 41000203L) : new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc));
			value["0"] = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, missionData.Config.MissionNameId);
			m_Descriptions[missionId] = value;
		}
		return value;
	}

	protected override void OnInMissionWorld()
	{
		m_Finished = false;
		if (TryGetParam(out var param))
		{
			int finishedMissionCount = GetFinishedMissionCount(param);
			if (CheckCondition(param, finishedMissionCount))
			{
				m_Finished = true;
				UpdateState(finishedMissionCount, success: true);
			}
			else
			{
				Singleton<EventManager>.instance.AddEventListener(ClientEvent.MissionN_Success, OnMissionSuccess);
			}
		}
	}

	protected override void OnOutMissionWorld()
	{
		m_Finished = false;
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MissionN_Success, OnMissionSuccess);
	}

	protected override void OnTracing()
	{
		if (Stage.StageType == MissionStageType.Stage && TryGetParam(out var param))
		{
			for (int i = 0; i < param.missions.Count; i++)
			{
				Singleton<MissionManager>.instance.AddImplicitTracingMission(param.missions[i]);
			}
		}
	}

	protected override void OnUntracing()
	{
		if (Stage.StageType == MissionStageType.Stage && TryGetParam(out var param))
		{
			for (int i = 0; i < param.missions.Count; i++)
			{
				Singleton<MissionManager>.instance.RemoveImplicitTracingMission(param.missions[i]);
			}
		}
	}

	private void OnMissionSuccess(BaseEventContent obj)
	{
		if (TryGetParam(out var param) && obj is MissionNSuccessEvt missionNSuccessEvt && param.missions.Contains(missionNSuccessEvt.missionId) && InMissionWorld)
		{
			int finishedMissionCount = GetFinishedMissionCount(param);
			if (CheckCondition(param, finishedMissionCount) && !m_Finished)
			{
				m_Finished = true;
				UpdateState(finishedMissionCount, success: true);
			}
			else
			{
				UpdateState(finishedMissionCount, success: false);
			}
		}
	}

	private bool CheckCondition(KCMissionsConditionParam param, int progress)
	{
		return progress >= param.missions.Count;
	}

	private int GetFinishedMissionCount(KCMissionsConditionParam param)
	{
		int num = 0;
		for (int i = 0; i < param.missions.Count; i++)
		{
			int missionId = param.missions[i];
			if (Singleton<MissionManager>.instance.IsFinished(missionId))
			{
				num++;
			}
		}
		return num;
	}

	private bool TryGetParam(out KCMissionsConditionParam param)
	{
		param = Param as KCMissionsConditionParam;
		return param?.missions != null;
	}
}
