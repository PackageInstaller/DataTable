using System;
using ACT.UI;
using ACT.World;
using ACT.World.Asset;
using ACT.World.StateObject;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class StateObjectMissionPoint : MissionPointData, IEquatable<StateObjectMissionPoint>
{
	private CommonInteractUI m_CommonInteractUI;

	protected bool m_Custom;

	protected Vector3 m_CustomPosition;

	public int InteractObjId { get; set; }

	public StateObjectMissionPoint(int missionId, int pointId, bool use3DLogic, MapArea area, int interactObjId, bool needEffect = true, bool custom = false, Vector3 customPosition = default(Vector3))
		: base(missionId, pointId, use3DLogic, area, needEffect)
	{
		InteractObjId = interactObjId;
		m_Custom = custom;
		m_CustomPosition = customPosition;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	public override bool Equals(object obj)
	{
		if (obj is StateObjectMissionPoint other)
		{
			return Equals(other);
		}
		return base.Equals((MissionPointData)obj);
	}

	public override bool Equals(MissionPointData other)
	{
		return Equals((object)other);
	}

	public bool Equals(StateObjectMissionPoint other)
	{
		return InteractObjId == other.InteractObjId;
	}

	public override void Init()
	{
		if (ShowIcon && StateWorldAsset.TryGetWorldAssetBySwid(InteractObjId, out var stateWorldAsset) && !(stateWorldAsset.stateObjectBase is InteractBattleRoom))
		{
			if ((bool)stateWorldAsset.stateObjectBase.CustomUi)
			{
				m_CommonInteractUI = stateWorldAsset.stateObjectBase.CustomUi;
				m_CommonInteractUI.SetMissionTip(MissionId);
			}
			else
			{
				stateWorldAsset.stateObjectBase.TryLoadInteractTip(forceLoad: true);
			}
		}
	}

	public override void UnInit()
	{
		base.UnInit();
		if (ShowIcon)
		{
			if (!m_CommonInteractUI && StateWorldAsset.TryGetWorldAssetBySwid(InteractObjId, out var stateWorldAsset) && (bool)stateWorldAsset.stateObjectBase.CustomUi)
			{
				m_CommonInteractUI = stateWorldAsset.stateObjectBase.CustomUi;
			}
			if ((bool)m_CommonInteractUI)
			{
				m_CommonInteractUI.SetDefaultTip();
				m_CommonInteractUI = null;
			}
		}
	}

	public override Vector3 GetActualPos()
	{
		if (m_Custom)
		{
			return m_CustomPosition;
		}
		if (MonoECS.instance.ruleManager.TryGetWorldStateAsset(InteractObjId, out var asset))
		{
			return asset.stateObjectBase.transform.position;
		}
		return Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(InteractObjId)?.initPos ?? Vector3.zero;
	}
}
