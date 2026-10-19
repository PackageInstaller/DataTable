using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Model;
using ACT.Utility;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class EnterAreaCondition : MissionCondition
{
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
		EnterAreaConditionParam enterAreaConditionParam = Param as EnterAreaConditionParam;
		m_Helper = new GameObject($"EnterAreaConditionHelper:{Id}").AddComponent<AreaConditionHelper>();
		m_Helper.transform.SetParent(Flow.Env.transform, worldPositionStays: true);
		m_Helper.transform.position = new Vector3(enterAreaConditionParam.positionX, enterAreaConditionParam.positionY, enterAreaConditionParam.positionZ) + new Vector3(enterAreaConditionParam.offsetX, enterAreaConditionParam.offsetY, enterAreaConditionParam.offsetZ);
		m_Helper.SetInitInArea(b: false);
		UpdateHelper();
		switch (enterAreaConditionParam.areaType)
		{
		case EnterAreaConditionParam.AreaType.Sphere:
		{
			SphereCollider sphereCollider = m_Helper.gameObject.AddComponent<SphereCollider>();
			sphereCollider.radius = enterAreaConditionParam.radius;
			sphereCollider.isTrigger = true;
			break;
		}
		case EnterAreaConditionParam.AreaType.Box:
		{
			BoxCollider boxCollider = m_Helper.gameObject.AddComponent<BoxCollider>();
			boxCollider.size = new Vector3(enterAreaConditionParam.sizeX, enterAreaConditionParam.sizeY, enterAreaConditionParam.sizeZ);
			boxCollider.center = Vector3.zero;
			boxCollider.isTrigger = true;
			break;
		}
		}
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
		if (m_Helper != null)
		{
			Object.Destroy(m_Helper.gameObject);
			m_Helper = null;
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
		if ((bool)m_Helper && MonoECS.instance.mainEntity.GetCompTransform() != null)
		{
			EnterAreaConditionParam enterAreaConditionParam = Param as EnterAreaConditionParam;
			int activeMapId = Singleton<GameManager>.instance.worldManager.ActiveMapId;
			m_Helper.gameObject.SetActive(activeMapId == (int)enterAreaConditionParam.mapArea);
		}
	}

	protected override void OnTracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			EnterAreaConditionParam enterAreaConditionParam = Param as EnterAreaConditionParam;
			if (enterAreaConditionParam.showMissionPointIcon || enterAreaConditionParam.showMissionPointRadius)
			{
				Vector3 fixedPos = new Vector3(enterAreaConditionParam.positionX, enterAreaConditionParam.positionY, enterAreaConditionParam.positionZ);
				int newPointId = Model<BattleMainMarkModelV2>.Interface.GetNewPointId();
				m_MissionPoint = new FixedAreaMissionPoint(Flow.Id, newPointId, enterAreaConditionParam.use3DLogic, enterAreaConditionParam.mapArea, fixedPos);
				m_MissionPoint.ShowIcon = enterAreaConditionParam.showMissionPointIcon;
				m_MissionPoint.ShowRadius = enterAreaConditionParam.showMissionPointRadius;
				m_MissionPoint.Radius = enterAreaConditionParam.missionPointRadius;
				Model<BattleMainMarkModelV2>.Interface.RegisterPoint(m_MissionPoint);
			}
		}
	}

	protected override void OnUntracing()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			EnterAreaConditionParam enterAreaConditionParam = Param as EnterAreaConditionParam;
			if (enterAreaConditionParam.showMissionPointIcon || enterAreaConditionParam.showMissionPointRadius)
			{
				Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(m_MissionPoint);
			}
		}
	}
}
