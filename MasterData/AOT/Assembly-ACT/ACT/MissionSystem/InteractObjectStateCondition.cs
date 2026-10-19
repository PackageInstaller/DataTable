using System.Collections.Generic;
using ACT.Battle;
using ACT.Battle.Configs;
using ACT.Model;
using ACT.Utility;
using ACT.World.Asset;
using ACT.World.StateObject;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;

namespace ACT.MissionSystem;

public class InteractObjectStateCondition : MissionCondition
{
	private sealed class TrackedMissionPoint
	{
		public readonly int swid;

		public readonly int targetState;

		public readonly bool canTrackMonster;

		public MissionPointData missionPoint;

		public TrackedMissionPoint(int swid, int targetState, MissionPointData missionPoint, bool canTrackMonster)
		{
			this.swid = swid;
			this.targetState = targetState;
			this.missionPoint = missionPoint;
			this.canTrackMonster = canTrackMonster;
		}
	}

	private readonly List<TrackedMissionPoint> m_MissionPoints = new List<TrackedMissionPoint>();

	private readonly List<MissionManager.InteractObject> m_InteractObjects = new List<MissionManager.InteractObject>();

	private bool m_IsTracing;

	private LocalizedString m_Description;

	public override IEnumerable<ConditionDescription> GetDescriptions()
	{
		MissionPointData missionPointData = ((m_MissionPoints.Count > 0) ? m_MissionPoints[0].missionPoint : null);
		if (Desc != 0 || missionPointData != null)
		{
			if (m_Description == null)
			{
				m_Description = new LocalizedString(LocalizationUtility.localizeTableName_shortcommon, Desc);
			}
			yield return new ConditionDescription
			{
				HaveContent = (Desc != 0),
				DescriptionContent = m_Description,
				HaveMissionPoint = (missionPointData != null),
				MissionPointId = (missionPointData?.PointId ?? 0)
			};
		}
	}

	protected override async void OnInMissionWorld()
	{
		if (Stage.Data.stageType != MissionStageType.Fail)
		{
			foreach (InteractObjectStateConditionParam.InteractObjectState interactObjectState in (Param as InteractObjectStateConditionParam).interactObjectStates)
			{
				MissionManager.InteractObject item = Singleton<MissionManager>.instance.RegisterInteractObject(interactObjectState.swid, Flow.Id);
				m_InteractObjects.Add(item);
			}
		}
		do
		{
			if (m_IsTracing)
			{
				UpdateMonsterTrackingPoints();
			}
			if (CheckCondition())
			{
				MarkSuccess();
				break;
			}
			await UniTask.Yield();
		}
		while (InMissionWorld);
	}

	protected override void OnOutMissionWorld()
	{
		if (Stage.Data.stageType == MissionStageType.Fail)
		{
			return;
		}
		foreach (MissionManager.InteractObject interactObject in m_InteractObjects)
		{
			Singleton<MissionManager>.instance.UnRegisterInteractObject(interactObject);
		}
		m_InteractObjects.Clear();
	}

	protected override void OnTracing()
	{
		m_IsTracing = true;
		if (Stage.Data.stageType == MissionStageType.Fail)
		{
			return;
		}
		InteractObjectStateConditionParam interactObjectStateConditionParam = Param as InteractObjectStateConditionParam;
		if (!interactObjectStateConditionParam.showMissionPointIcon && !interactObjectStateConditionParam.showMissionPointRadius)
		{
			return;
		}
		foreach (InteractObjectStateConditionParam.InteractObjectState interactObjectState in interactObjectStateConditionParam.interactObjectStates)
		{
			if (!IsTargetStateSatisfied(interactObjectState.swid, interactObjectState.state))
			{
				int newPointId = Model<BattleMainMarkModelV2>.Interface.GetNewPointId();
				MissionPointData missionPoint = CreateMissionPoint(interactObjectState.swid, newPointId, interactObjectStateConditionParam);
				RegisterMissionPoint(interactObjectState.swid, interactObjectState.state, missionPoint, !interactObjectStateConditionParam.missionPointOverride);
			}
		}
	}

	protected override void OnUntracing()
	{
		m_IsTracing = false;
		if (Stage.Data.stageType == MissionStageType.Fail)
		{
			return;
		}
		foreach (TrackedMissionPoint missionPoint in m_MissionPoints)
		{
			Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(missionPoint.missionPoint);
		}
		m_MissionPoints.Clear();
	}

	public override bool PreCheckCondition()
	{
		return CheckCondition();
	}

	private bool CheckCondition()
	{
		if (!MonoECS.instance)
		{
			return false;
		}
		if (MonoECS.instance.ruleManager == null)
		{
			return false;
		}
		InteractObjectStateConditionParam obj = Param as InteractObjectStateConditionParam;
		RuleManager ruleManager = MonoECS.instance.ruleManager;
		foreach (InteractObjectStateConditionParam.InteractObjectState interactObjectState in obj.interactObjectStates)
		{
			if (!ruleManager.TrySharedGetState(interactObjectState.swid, out var state) || state != interactObjectState.state)
			{
				return false;
			}
		}
		return true;
	}

	private static bool IsTargetStateSatisfied(int swid, int targetState)
	{
		RuleManager ruleManager = (MonoECS.instance ? MonoECS.instance.ruleManager : null);
		if (ruleManager != null && ruleManager.TrySharedGetState(swid, out var state))
		{
			return state == targetState;
		}
		return false;
	}

	private void UpdateMonsterTrackingPoints()
	{
		InteractObjectStateConditionParam param = Param as InteractObjectStateConditionParam;
		for (int num = m_MissionPoints.Count - 1; num >= 0; num--)
		{
			TrackedMissionPoint trackedMissionPoint = m_MissionPoints[num];
			Entity monster;
			if (IsTargetStateSatisfied(trackedMissionPoint.swid, trackedMissionPoint.targetState))
			{
				RemoveMissionPointAt(num);
			}
			else if (trackedMissionPoint.missionPoint is MonsterEntityMissionPoint monsterEntityMissionPoint)
			{
				if (!monsterEntityMissionPoint.IsMonsterAlive)
				{
					ReplaceMissionPoint(trackedMissionPoint, CreateMissionPoint(trackedMissionPoint.swid, trackedMissionPoint.missionPoint.PointId, param));
				}
			}
			else if (trackedMissionPoint.canTrackMonster && TryGetSpawnedMonster(trackedMissionPoint.swid, out monster))
			{
				ReplaceMissionPoint(trackedMissionPoint, CreateMonsterMissionPoint(trackedMissionPoint.missionPoint, monster));
			}
		}
	}

	private static void ReplaceMissionPoint(TrackedMissionPoint trackedPoint, MissionPointData missionPoint)
	{
		Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(trackedPoint.missionPoint);
		trackedPoint.missionPoint = missionPoint;
		Model<BattleMainMarkModelV2>.Interface.RegisterPoint(missionPoint);
	}

	private void RemoveMissionPointAt(int index)
	{
		Model<BattleMainMarkModelV2>.Interface.UnregisterPoint(m_MissionPoints[index].missionPoint);
		m_MissionPoints.RemoveAt(index);
	}

	private MissionPointData CreateMissionPoint(int swid, int pointId, InteractObjectStateConditionParam param)
	{
		if (!param.missionPointOverride && TryGetSpawnedMonster(swid, out var monster))
		{
			MonsterEntityMissionPoint monsterEntityMissionPoint = new MonsterEntityMissionPoint(Flow.Id, pointId, param.use3DLogic, param.mapArea, monster, needEffect: false);
			ApplyMissionPointSettings(monsterEntityMissionPoint, param);
			return monsterEntityMissionPoint;
		}
		Vector3 customPosition = new Vector3(param.positionX, param.positionY, param.positionZ);
		StateObjectMissionPoint stateObjectMissionPoint = param.pointType switch
		{
			InteractObjectStateConditionParam.MissionPointType.Normal => new StateObjectMissionPoint(Flow.Id, pointId, param.use3DLogic, param.mapArea, swid, needEffect: false, param.missionPointOverride, customPosition), 
			InteractObjectStateConditionParam.MissionPointType.Chase => new ChaseMissionPoint(Flow.Id, pointId, param.use3DLogic, param.mapArea, swid, needEffect: false, param.missionPointOverride, customPosition), 
			_ => null, 
		};
		ApplyMissionPointSettings(stateObjectMissionPoint, param);
		return stateObjectMissionPoint;
	}

	private static void ApplyMissionPointSettings(MissionPointData missionPoint, InteractObjectStateConditionParam param)
	{
		missionPoint.ShowIcon = param.showMissionPointIcon;
		missionPoint.ShowRadius = param.showMissionPointRadius;
		missionPoint.Radius = param.missionPointRadius;
	}

	private void RegisterMissionPoint(int swid, int targetState, MissionPointData missionPoint, bool canTrackMonster)
	{
		m_MissionPoints.Add(new TrackedMissionPoint(swid, targetState, missionPoint, canTrackMonster));
		Model<BattleMainMarkModelV2>.Interface.RegisterPoint(missionPoint);
	}

	private static MissionPointData CreateMonsterMissionPoint(MissionPointData replacedPoint, Entity monster)
	{
		return new MonsterEntityMissionPoint(replacedPoint.MissionId, replacedPoint.PointId, replacedPoint.Use3DLogic, replacedPoint.MapArea, monster, replacedPoint.NeedEffect)
		{
			ShowIcon = replacedPoint.ShowIcon,
			ShowRadius = replacedPoint.ShowRadius,
			Radius = replacedPoint.Radius
		};
	}

	private static bool TryGetSpawnedMonster(int swid, out Entity monster)
	{
		monster = default;
		MonoECS instance = MonoECS.instance;
		if (!instance)
		{
			return false;
		}
		RuleManager ruleManager = instance.ruleManager;
		if (ruleManager == null)
		{
			return false;
		}
		if (!ruleManager.TryGetWorldStateAsset(swid, out var asset))
		{
			return false;
		}
		if (asset == null)
		{
			return false;
		}
		if (asset.stateObjectBase is InteractWorldMonsterPoint { MonsterEntity: var monsterEntity })
		{
			if (monsterEntity.IsValid && monsterEntity.IsAlive() && monsterEntity.IsLogicAvailable())
			{
				Entity entity = (monster = monsterEntity);
				return entity.IsValid;
			}
			return false;
		}
		if (asset.stateObjectBase is InteractMonster { MonsterEntity: var monsterEntity2 })
		{
			if (monsterEntity2.IsValid && monsterEntity2.IsAlive() && monsterEntity2.IsLogicAvailable())
			{
				Entity entity = (monster = monsterEntity2);
				return entity.IsValid;
			}
			return false;
		}
		return false;
	}
}
