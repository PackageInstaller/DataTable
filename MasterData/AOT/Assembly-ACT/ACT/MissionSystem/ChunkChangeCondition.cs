using System.Collections.Generic;
using ACT.Battle.Configs;
using ACT.Model;
using ACT.Utility;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public sealed class ChunkChangeCondition : MissionCondition
{
	private WorldManager m_WorldManager;

	private bool m_IsConditionSatisfied;

	private MissionPointData m_MissionPoint;

	private LocalizedString m_Description;

	public override bool AllowRepeat => true;

	private ChunkChangeConditionParam ParamData => Param as ChunkChangeConditionParam;

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
		m_WorldManager = Singleton<GameManager>.instance?.worldManager;
		if (m_WorldManager != null)
		{
			m_WorldManager.RegisterOnChunkChangedCallback(OnChunkChanged);
		}
	}

	protected override void OnOutMissionWorld()
	{
		StopListenChunkChanged();
	}

	protected override void OnDeactivate()
	{
		StopListenChunkChanged();
	}

	protected override void OnTracing()
	{
		ChunkChangeConditionParam chunkChangeConditionParam = Param as ChunkChangeConditionParam;
		if (Stage.Data.stageType != MissionStageType.Fail && chunkChangeConditionParam.TriggerType == ChunkTriggerType.Enter && (chunkChangeConditionParam.showMissionPointIcon || chunkChangeConditionParam.showMissionPointRadius))
		{
			Vector3 fixedPos = new Vector3(chunkChangeConditionParam.positionX, chunkChangeConditionParam.positionY, chunkChangeConditionParam.positionZ);
			int newPointId = Model<BattleMainMarkModelV2>.Interface.GetNewPointId();
			m_MissionPoint = new FixedAreaMissionPoint(Flow.Id, newPointId, chunkChangeConditionParam.use3DLogic, chunkChangeConditionParam.mapArea, fixedPos);
			m_MissionPoint.ShowIcon = chunkChangeConditionParam.showMissionPointIcon;
			m_MissionPoint.ShowRadius = chunkChangeConditionParam.showMissionPointRadius;
			m_MissionPoint.Radius = chunkChangeConditionParam.missionPointRadius;
			Model<BattleMainMarkModelV2>.Interface.RegisterPoint(m_MissionPoint);
		}
	}

	protected override void OnUntracing()
	{
		ChunkChangeConditionParam chunkChangeConditionParam = Param as ChunkChangeConditionParam;
		if (Stage.Data.stageType != MissionStageType.Fail && chunkChangeConditionParam.TriggerType == ChunkTriggerType.Enter && (chunkChangeConditionParam.showMissionPointIcon || chunkChangeConditionParam.showMissionPointRadius))
		{
			Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(m_MissionPoint);
		}
	}

	private void OnChunkChanged(int newChunkId, int oldChunkId)
	{
		bool flag = CheckCondition(newChunkId, oldChunkId);
		if (!m_IsConditionSatisfied & flag)
		{
			MarkSuccess();
		}
		m_IsConditionSatisfied = flag;
	}

	private void StopListenChunkChanged()
	{
		if (m_WorldManager != null)
		{
			m_WorldManager.UnregisterOnChunkChangedCallback(OnChunkChanged);
			m_WorldManager = null;
		}
	}

	private bool CheckCondition(int newChunkId, int oldChunkId)
	{
		return ParamData.TriggerType switch
		{
			ChunkTriggerType.Enter => newChunkId == ParamData.ChunkId, 
			ChunkTriggerType.Exit => oldChunkId == ParamData.ChunkId, 
			_ => false, 
		};
	}
}
