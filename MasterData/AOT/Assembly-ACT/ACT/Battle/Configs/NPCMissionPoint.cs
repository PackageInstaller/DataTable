using System;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.UI;
using ACT.World;
using Bamboo.ECS;
using Fundamental;
using UnityEngine;

namespace ACT.Battle.Configs;

public class NPCMissionPoint : MissionPointData, IEquatable<NPCMissionPoint>
{
	private CommonInteractUI m_CommonInteractUI;

	private bool m_Custom;

	private Vector3 m_CustomPosition;

	public int NpcUid { get; private set; }

	public NPCMissionPoint(int missionId, int pointId, bool use3DLogic, MapArea area, int npcUid, bool custom = false, Vector3 customPosition = default(Vector3))
		: base(missionId, pointId, use3DLogic, area, needEffect: false)
	{
		NpcUid = npcUid;
	}

	public override bool Equals(object obj)
	{
		if (obj is NPCMissionPoint other)
		{
			return Equals(other);
		}
		return base.Equals((MissionPointData)obj);
	}

	public override bool Equals(MissionPointData other)
	{
		return Equals((object)other);
	}

	public bool Equals(NPCMissionPoint other)
	{
		return NpcUid == other.NpcUid;
	}

	public override void Init()
	{
		if (ShowIcon && TryGetCommonInteractUI(out m_CommonInteractUI))
		{
			m_CommonInteractUI.SetMissionTip(MissionId);
		}
	}

	public override void UnInit()
	{
		base.UnInit();
		if (!ShowIcon)
		{
			m_CommonInteractUI = null;
			return;
		}
		TryGetCommonInteractUI(out var commonInteractUI);
		if ((bool)commonInteractUI)
		{
			commonInteractUI.SetDefaultTip();
		}
		if ((bool)m_CommonInteractUI && m_CommonInteractUI != commonInteractUI)
		{
			m_CommonInteractUI.SetDefaultTip();
		}
		m_CommonInteractUI = null;
	}

	private bool TryGetCommonInteractUI(out CommonInteractUI commonInteractUI)
	{
		if (TryGetCommonInteractUIFromEntity(GetInstantiatedNpcEntity(), out commonInteractUI))
		{
			return true;
		}
		return TryGetCommonInteractUIFromEntity(GetNpcEntranceEntity(), out commonInteractUI);
	}

	private Entity GetInstantiatedNpcEntity()
	{
		if (Singleton<RuntimeNpcManager>.instance == null || !Singleton<RuntimeNpcManager>.instance.InstantiatedNpcDictionary.TryGetValue(NpcUid, out var value))
		{
			return default;
		}
		return value;
	}

	private Entity GetNpcEntranceEntity()
	{
		if (Singleton<RuntimeNpcManager>.instance?.AllNpcDataDic == null)
		{
			return default;
		}
		if (!Singleton<RuntimeNpcManager>.instance.AllNpcDataDic.TryGetValue(NpcUid, out var value) || value == null)
		{
			return default;
		}
		return value.EntityReference;
	}

	private static bool TryGetCommonInteractUIFromEntity(Entity entityReference, out CommonInteractUI commonInteractUI)
	{
		commonInteractUI = null;
		if (!entityReference.IsValid || !entityReference.TryGetCompInteract(out CompInteract component) || !component.CommonInteractTip)
		{
			return false;
		}
		commonInteractUI = component.CommonInteractTip;
		return true;
	}

	public override Vector3 GetActualPos()
	{
		if (m_Custom)
		{
			return m_CustomPosition;
		}
		return Singleton<RuntimeNpcManager>.instance.GetNpcPosition(NpcUid);
	}
}
