using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Model;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class EnterFixedAreaCondition : MissionCondition
{
	private bool m_Finished;

	private AreaConditionHelper m_Helper;

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

	protected override async void OnInMissionWorld()
	{
		EnterFixedAreaConditionParam enterFixedAreaConditionParam = Param as EnterFixedAreaConditionParam;
		Transform transform = Flow.Env.transform.Find(enterFixedAreaConditionParam.areaName);
		if (transform == null)
		{
			return;
		}
		GameObject gameObject = Object.Instantiate(transform.gameObject, Flow.Env.transform);
		gameObject.name = $"EnterFixedAreaConditionHelper:{Id}";
		Collider[] componentsInChildren = gameObject.GetComponentsInChildren<Collider>();
		for (int i = 0; i < componentsInChildren.Length; i++)
		{
			componentsInChildren[i].isTrigger = true;
		}
		gameObject.SetActive(value: false);
		m_Helper = gameObject.AddComponent<AreaConditionHelper>();
		m_Helper.SetInitInArea(b: false);
		UpdateHelperEveryFrame().Forget();
		if (IsRepeat)
		{
			do
			{
				if (!CheckCondition())
				{
					await UniTask.Yield();
					continue;
				}
				MonoECS.instance.SyncGameInfos();
				MarkSuccess();
				while (InMissionWorld && CheckCondition())
				{
					await UniTask.Yield();
				}
			}
			while (InMissionWorld);
			return;
		}
		do
		{
			if (CheckCondition())
			{
				MonoECS.instance.SyncGameInfos();
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	protected override void OnOutMissionWorld()
	{
		if ((bool)m_Helper)
		{
			Object.Destroy(m_Helper.gameObject);
			m_Helper = null;
		}
	}

	protected override void OnTracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			EnterFixedAreaConditionParam enterFixedAreaConditionParam = Param as EnterFixedAreaConditionParam;
			if (enterFixedAreaConditionParam.showMissionPointIcon || enterFixedAreaConditionParam.showMissionPointRadius)
			{
				Vector3 position = m_Helper.transform.position;
				int newPointId = Model<BattleMainMarkModelV2>.Interface.GetNewPointId();
				m_MissionPoint = new FixedAreaMissionPoint(Flow.Id, newPointId, enterFixedAreaConditionParam.use3DLogic, enterFixedAreaConditionParam.mapArea, position);
				m_MissionPoint.ShowIcon = enterFixedAreaConditionParam.showMissionPointIcon;
				m_MissionPoint.ShowRadius = enterFixedAreaConditionParam.showMissionPointRadius;
				m_MissionPoint.Radius = enterFixedAreaConditionParam.missionPointRadius;
				Model<BattleMainMarkModelV2>.Interface.RegisterPoint(m_MissionPoint);
			}
		}
	}

	protected override void OnUntracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			EnterFixedAreaConditionParam enterFixedAreaConditionParam = Param as EnterFixedAreaConditionParam;
			if (enterFixedAreaConditionParam.showMissionPointIcon || enterFixedAreaConditionParam.showMissionPointRadius)
			{
				Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(m_MissionPoint);
			}
		}
	}

	private bool CheckCondition()
	{
		if ((bool)m_Helper && m_Helper.InArea)
		{
			return true;
		}
		return false;
	}

	private async UniTaskVoid UpdateHelperEveryFrame()
	{
		while (InMissionWorld)
		{
			UpdateHelper();
			await UniTask.Yield(PlayerLoopTiming.EarlyUpdate);
		}
	}

	private void UpdateHelper()
	{
		if ((bool)m_Helper)
		{
			int activeMapId = Singleton<GameManager>.instance.worldManager.ActiveMapId;
			EnterFixedAreaConditionParam enterFixedAreaConditionParam = Param as EnterFixedAreaConditionParam;
			m_Helper.gameObject.SetActive(activeMapId == (int)enterFixedAreaConditionParam.mapArea);
		}
	}
}
