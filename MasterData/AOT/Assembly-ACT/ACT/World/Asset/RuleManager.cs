using System;
using System.Collections.Generic;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.EventTrack;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;
using UnityEngine;

namespace ACT.World.Asset;

public class RuleManager : IRuleManager
{
	public const int InvalidState = -1;

	private Dictionary<(ClientEvent, int), List<StateWorldHandler>> eventTransmit = new Dictionary<(ClientEvent, int), List<StateWorldHandler>>();

	public IConfigWorldPartition config { get; private set; }

	public AsyncReactiveProperty<int> parentSwid { get; } = new AsyncReactiveProperty<int>(int.MinValue);

	public RuleManager()
	{
		Singleton<GameManager>.instance.worldManager.RegisterOnWorldChangedCallback(OnSceneChanged);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.asset_Inited, OnChangeParent);
	}

	private void OnSceneChanged(IConfigWorldPartition configWorld)
	{
		if (config != null)
		{
			foreach (InteractRule rule in config.Rules)
			{
				rule.RemoveConfig(this);
			}
			eventTransmit.Clear();
		}
		config = configWorld;
		if (configWorld.Rules != null)
		{
			foreach (InteractRule rule2 in configWorld.Rules)
			{
				rule2.ApplyConfig(this);
			}
		}
		parentSwid.Value = int.MinValue;
	}

	public bool TrySharedGetState(int stateWorldUid, out int state)
	{
		state = -1;
		StateWorldAssetData stateWorldAssetData = GetStateWorldAssetData(stateWorldUid);
		int activeWorldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
		if (stateWorldAssetData == null)
		{
			_ = LuminApplication.LogEnabled;
			return false;
		}
		if (StateWorldAsset.TryGetWorldAssetBySwid(stateWorldUid, out var stateWorldAsset))
		{
			Entity stateEntityRef = stateWorldAsset.stateEntityRef;
			if (stateEntityRef.IsValid && stateEntityRef.TryGetCompStateObject(out CompStateObject component))
			{
				state = component.StateObjectBase.currentStateId;
				return true;
			}
		}
		if (stateWorldAssetData.serviceSave)
		{
			if (CoreUtils.TryGetServiceSaveStateId(activeWorldId, stateWorldUid, out var stateId))
			{
				state = stateId;
				return true;
			}
			return false;
		}
		if (LuminApplication.LogEnabled)
		{
			Debug.LogError("没在可加载范围内，检查地图配置！");
		}
		return false;
	}

	public int SharedGetState(int stateWorldUid)
	{
		if (!TrySharedGetState(stateWorldUid, out var state))
		{
			return -1;
		}
		return state;
	}

	public void SharedChangeState(int stateWorldUid, int stateId)
	{
		int activeWorldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(stateWorldUid);
		if (worldStateAssetDataBySGOID == null)
		{
			_ = LuminApplication.LogEnabled;
			return;
		}
		StateWorldAsset stateWorldAsset;
		if (worldStateAssetDataBySGOID.IsServiceSaveState(stateId))
		{
			G.service.ChangeServiceSaveState(activeWorldId, stateWorldUid, stateId, worldStateAssetDataBySGOID.IsSyncCharacterInfo(stateId) && MonoECS.instance.isStartWorld, Model<MapModel>.HasInstance() ? Model<MapModel>.Interface.GetMapViewRecordParam() : null, null);
			if (Model<MapModel>.HasInstance())
			{
				Model<MapModel>.Interface.ClearAllMapViewRecordParam();
			}
		}
		else if (StateWorldAsset.TryGetWorldAssetBySwid(stateWorldUid, out stateWorldAsset))
		{
			stateWorldAsset.stateEntityRef.GetCompStateObject().EntityChangeState(stateId);
		}
		else if (LuminApplication.LogEnabled)
		{
			Debug.LogError($"世界[{activeWorldId}]修改交互物[{stateWorldUid}]的状态[{stateId}]失败！！！该状态不是可保存状态，且交互物不在加载范围内");
		}
		TrackOnInteractEvt evt = EventTrackSolver.Instance.GetEvt<TrackOnInteractEvt>();
		evt.interactId = stateWorldUid;
		evt.stateCurrent = stateId;
		evt.interactType = worldStateAssetDataBySGOID.stateObjectType;
		if (StateWorldAsset.TryGetWorldAssetBySwid(stateWorldUid, out var stateWorldAsset2) && stateWorldAsset2.stateObjectBase != null)
		{
			evt.objectName = stateWorldAsset2.stateObjectBase.name;
		}
		EventTrackSolver.Instance.Dispatch(evt);
	}

	public void SharedChangeStates(StateChangeInfo[] stateChangeInfos, Action<bool> callback = null)
	{
		int activeWorldId = Singleton<GameManager>.instance.worldManager.ActiveWorldId;
		List<Pb.StateChangeInfo> list = new List<Pb.StateChangeInfo>();
		bool flag = true;
		int[] array = new int[stateChangeInfos.Length];
		for (int i = 0; i < stateChangeInfos.Length; i++)
		{
			StateChangeInfo stateChangeInfo = stateChangeInfos[i];
			if (StateWorldAsset.TryGetWorldAssetBySwid(stateChangeInfo.uid, out var stateWorldAsset))
			{
				array[i] = stateWorldAsset.stateEntityRef.GetCompStateObject().StateId;
			}
			StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(stateChangeInfo.uid);
			StateWorldAsset stateWorldAsset2;
			if (worldStateAssetDataBySGOID == null)
			{
				if (!LuminApplication.LogEnabled)
				{
				}
			}
			else if (worldStateAssetDataBySGOID.IsServiceSaveState(stateChangeInfo.stateId))
			{
				list.Add(new Pb.StateChangeInfo
				{
					Uid = stateChangeInfo.uid,
					StateId = stateChangeInfo.stateId
				});
				flag &= worldStateAssetDataBySGOID.IsSyncCharacterInfo(stateChangeInfo.stateId);
			}
			else if (StateWorldAsset.TryGetWorldAssetBySwid(stateChangeInfo.uid, out stateWorldAsset2))
			{
				stateWorldAsset2.stateEntityRef.GetCompStateObject().EntityChangeState(stateChangeInfo.stateId);
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError($"世界[{activeWorldId}]修改交互物[{stateChangeInfo.uid}]的状态[{stateChangeInfo.stateId}]失败！！！该状态不是可保存状态，且交互物不在加载范围内");
			}
		}
		if (list.Count != 0)
		{
			G.service.ChangeServiceSaveStates(activeWorldId, list, flag && MonoECS.instance.isStartWorld, Model<MapModel>.HasInstance() ? Model<MapModel>.Interface.GetMapViewRecordParam() : null, callback);
			if (Model<MapModel>.HasInstance())
			{
				Model<MapModel>.Interface.ClearAllMapViewRecordParam();
			}
		}
		for (int j = 0; j < stateChangeInfos.Length; j++)
		{
			StateChangeInfo stateChangeInfo2 = stateChangeInfos[j];
			TrackOnInteractEvt evt = EventTrackSolver.Instance.GetEvt<TrackOnInteractEvt>();
			evt.interactId = stateChangeInfo2.uid;
			evt.stateCurrent = stateChangeInfo2.stateId;
			evt.worldId = activeWorldId;
			if (StateWorldAsset.TryGetWorldAssetBySwid(stateChangeInfo2.uid, out var stateWorldAsset3))
			{
				if (stateWorldAsset3.stateObjectBase != null)
				{
					evt.objectName = stateWorldAsset3.stateObjectBase.name;
				}
				evt.interactType = stateWorldAsset3.data.stateObjectType;
			}
			EventTrackSolver.Instance.Dispatch(evt);
		}
	}

	public bool TryGetWorldStateAsset(int stateWorldUid, out StateWorldAsset asset)
	{
		return StateWorldAsset.TryGetWorldAssetBySwid(stateWorldUid, out asset);
	}

	public void AddEventListener(ClientEvent eventId, int swid, StateWorldHandler handle)
	{
		if (!eventTransmit.TryGetValue((eventId, swid), out var value))
		{
			eventTransmit.Add((eventId, swid), new List<StateWorldHandler> { handle });
		}
		else
		{
			value.Add(handle);
		}
	}

	public void RemoveEventListener(ClientEvent eventId, int swid, StateWorldHandler handle)
	{
		if (eventTransmit.TryGetValue((eventId, swid), out var value))
		{
			value.Remove(handle);
		}
	}

	public InteractRuleResult LocalEventDispatch(ClientEvent eventId, LocalStateWorldEvent o)
	{
		bool flag = eventId == ClientEvent.Local_CustomInteractEvent;
		if (eventTransmit.TryGetValue((eventId, o.sourceSwid), out var value))
		{
			for (int i = 0; i < value.Count; i++)
			{
				InteractRuleResult result = value[i](o);
				if (flag && result.isLegal)
				{
					return result;
				}
			}
		}
		return default;
	}

	public int GetInteractAssetState(int uid)
	{
		return GetInteractAssetState(uid, Singleton<GameManager>.instance.worldManager.ActiveWorldId);
	}

	public int GetInteractAssetState(int uid, int world)
	{
		Player localPlayer = G.localPlayer;
		if (localPlayer != null)
		{
			MapField<int, Map> maps = localPlayer.Maps;
			if (maps != null && maps.TryGetValue(world, out var value))
			{
				MapField<int, int> serviceSaveStateIds = value.ServiceSaveStateIds;
				if (serviceSaveStateIds != null && serviceSaveStateIds.TryGetValue(uid, out var value2))
				{
					return value2;
				}
			}
		}
		_ = LuminApplication.LogEnabled;
		return -999;
	}

	public int GetStateWorldAssetNumberByTag(ServiceSaveTag tag)
	{
		return Singleton<GameManager>.instance.worldManager.GetStateWorldAssetNumberByTag(tag);
	}

	public int GetStateWorldAssetInStateNumberByTag(ServiceSaveTag tag, int stateId)
	{
		return Singleton<GameManager>.instance.worldManager.GetStateWorldAssetNumberByTag(tag, stateId);
	}

	public int GetStateWorldAssetNumberByStateObjectType(int stateObjectType, int stateId)
	{
		return Singleton<GameManager>.instance.worldManager.GetStateWorldAssetNumberByStateObjectType(stateObjectType, stateId);
	}

	public StateWorldAssetData GetStateWorldAssetData(int stateWorldUid)
	{
		return Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(stateWorldUid);
	}

	public MapArea GetStateWorldAssetMapArea(int stateWorldUid)
	{
		return GetStateWorldAssetData(stateWorldUid)?.mapArea ?? MapArea.None;
	}

	public MapLayer GetStateWorldAssetMapLayer(int stateWorldUid)
	{
		return (MapLayer)(GetStateWorldAssetData(stateWorldUid)?.mapLayer ?? (-6));
	}

	public Vector3 GetStateWorldAssetInitPos(int stateWorldUid)
	{
		return GetStateWorldAssetData(stateWorldUid)?.initPos ?? Vector3.zero;
	}

	private void OnChangeParent(BaseEventContent obj)
	{
		AssetInitedEvt assetInitedEvt = (AssetInitedEvt)obj;
		parentSwid.Value = assetInitedEvt.swuid;
	}
}
