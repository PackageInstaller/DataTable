using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Config;
using ACT.Drama;
using ACT.Event;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Localization;
using UnityEngine.Serialization;

namespace ACT.World.Asset;

[Serializable]
public class NPCPointData : StateWorldAssetData
{
	[SerializeField]
	internal int m_initialStateId;

	public int npcId;

	[FormerlySerializedAs("uiOffest")]
	public Vector3 uiOffset;

	public LocalizedString interactTipString;

	public NPCBehaviourTree npcBehaviourTree;

	[SerializeField]
	private List<NPCStateInfo> npcStates = new List<NPCStateInfo>();

	public bool useCustom;

	public BoxColliderParameters field;

	public override bool isStatic => false;

	public override YooAssetReference addressAssetID => GameLoader.meta?.npcPointReferenceAssetID;

	public override ServiceSaveTag serviceSaveTag => ServiceSaveTag.NPC;

	public override int initialStateId => m_initialStateId;

	private int lastIndex => npcStates.Count - 1;

	public NPCStateInfo GetNPCStateInfoByStateId(int stateId)
	{
		return npcStates.Find((NPCStateInfo x) => x.stateId == stateId);
	}

	public bool CheckNPCStateInfoByStateId(int stateId)
	{
		if (stateId != -1)
		{
			return npcStates.FindIndex((NPCStateInfo x) => x.stateId == stateId) != -1;
		}
		return true;
	}

	public override Occupy GetOccupy(int stateId)
	{
		return new Occupy((Vector3)GetNPCStateInfoByStateId(stateId).pos);
	}

	public override (StateWorldAsset, UniTask) OnLoad(CancellationToken syncInit)
	{
		(StateWorldAsset, UniTask) result = base.OnLoad(syncInit);
		result.Item2.GetAwaiter().OnCompleted(() =>
		{
			AssetInitedEvt evt = Singleton<EventManager>.instance.GetEvt<AssetInitedEvt>();
			evt.swuid = stateWorldAssetUid;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.asset_Inited, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		});
		return result;
	}

	public override void OnRelease()
	{
		base.OnRelease();
	}

	public override bool GetMapLayer(out int layer)
	{
		layer = -1;
		NPCStateInfo nPCStateInfoByStateId = GetNPCStateInfoByStateId(MonoECS.instance.ruleManager.SharedGetState(stateWorldAssetUid));
		if (nPCStateInfoByStateId == null)
		{
			return false;
		}
		layer = nPCStateInfoByStateId.mapLayer;
		return true;
	}
}
