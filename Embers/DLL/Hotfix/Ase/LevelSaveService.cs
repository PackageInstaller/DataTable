#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.IO;
using System.Threading.Tasks;
using Cysharp.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Networking;

namespace Ase;

public class LevelSaveService : ILevelSaveService
{
	public class LevelSaveData
	{
		public long SaveTime;

		public Dictionary<int, LevelData> LevelDatas = new Dictionary<int, LevelData>();

		public Dictionary<MapItemData, Action<MapItemData>> MapItemUpdateAction = new Dictionary<MapItemData, Action<MapItemData>>(40);

		public Dictionary<NpcData, Action<NpcData>> NpcUpdateAction = new Dictionary<NpcData, Action<NpcData>>(10);

		public Dictionary<int, List<int>> LevelActiveBonfires = new Dictionary<int, List<int>>(6);

		public Dictionary<int, long> LevelMapMask = new Dictionary<int, long>(6);

		public Dictionary<int, List<int>> OpenTreasure = new Dictionary<int, List<int>>();

		public HashSet<int> TeachGuid;

		public static LevelSaveData CreateDefault(long time)
		{
			return new LevelSaveData
			{
				SaveTime = time
			};
		}
	}

	public class LevelData
	{
		public long LastRefreshTime;

		public int LevelId;

		public int DefaultActiveBornfire;

		public List<int> ActiveCaves;

		public Dictionary<int, NpcData> NpcDatas = new Dictionary<int, NpcData>(10);

		public Dictionary<int, MapItemData> MapItemDatas = new Dictionary<int, MapItemData>(30);

		public Dictionary<int, long> MonsterData = new Dictionary<int, long>(10);

		public Dictionary<int, long> MonsterGroupData = new Dictionary<int, long>(10);

		public Dictionary<int, NormalPlatformData> NormalPlatformDatas = new Dictionary<int, NormalPlatformData>(5);

		public Dictionary<int, int> RockerControls = new Dictionary<int, int>(5);

		public Dictionary<int, MechanismData> MechanismDatas = new Dictionary<int, MechanismData>(5);

		public Dictionary<int, TriggerData> TriggerDatas = new Dictionary<int, TriggerData>(5);

		public long DefaultMapMaskBit;
	}

	public class NpcData
	{
		public bool Active;

		public int IconType;

		public Dictionary<string, MapDataNodeParadoxParameter> ParadoxData;

		public Dictionary<int, string> DialogButtonLockState;

		public List<DialogueChainConfig.DialogueButtonConfig> DialogButtonConfigs;

		public List<int> PrologueIds;
	}

	public class MapItemData : IReference
	{
		public int MapItemId;

		public int Active;

		public int IconType;

		public MapDataNodeState MapDataNodeState;

		public Dictionary<string, MapDataNodeParadoxParameter> ParadoxData;

		public void Clear()
		{
			MapItemId = 0;
			Active = 1;
			IconType = 0;
			MapDataNodeState = MapDataNodeState.Unsummoned;
			ParadoxData.Clear();
		}
	}

	public class MapItemViewData : IReference
	{
		public int Uid;

		public MapItemData Data;

		public Vector3 Position;

		public void Clear()
		{
			Data = null;
			Uid = 0;
			Position = Vector3.zero;
		}
	}

	public class MechanismData
	{
		public int RunState;
	}

	public class TriggerData
	{
		public int ExecuteTime;
	}

	public class AnimationCurveKeyFrame
	{
		public float Time;

		public float Value;

		public float InTangent;

		public float OutTangent;

		public int TangentMode;

		public int WeightedMode;

		public float InWeight;

		public float OutWeight;

		public AnimationCurveKeyFrame()
		{
		}

		public AnimationCurveKeyFrame(float time, float value, float inTangent, float outTangent, int tangentMode, int weightedMode, float inWeight, float outWeight)
		{
			Time = time;
			Value = value;
			InTangent = inTangent;
			OutTangent = outTangent;
			TangentMode = tangentMode;
			WeightedMode = weightedMode;
			InWeight = inWeight;
			OutWeight = outWeight;
		}
	}

	public class PlatformCurveData
	{
		public List<AnimationCurveKeyFrame> AnimationCurveKeyFrames;

		public int PostWrapMode;

		public int PreWrapMode;

		public PlatformCurveData(AnimationCurve curve)
		{
			AnimationCurveKeyFrames = new List<AnimationCurveKeyFrame>(curve.keys.Length);
			for (int i = 0; i < curve.keys.Length; i++)
			{
				AnimationCurveKeyFrames.Add(new AnimationCurveKeyFrame(curve.keys[i].time, curve.keys[i].value, curve.keys[i].inTangent, curve.keys[i].outTangent, curve.keys[i].tangentMode, (int)curve.keys[i].weightedMode, (int)curve.keys[i].inWeight, curve.keys[i].outWeight));
			}
			PostWrapMode = (int)curve.postWrapMode;
			PreWrapMode = (int)curve.preWrapMode;
		}
	}

	public class CommonIntBool
	{
		public int IntValue;

		public bool BoolValue;

		public CommonIntBool()
		{
		}

		public CommonIntBool(int intValue, bool boolValue)
		{
			IntValue = intValue;
			BoolValue = boolValue;
		}
	}

	public class NormalPlatformData
	{
		public bool IsPause;

		public int WrapMode;

		public float ExcuteTime;

		public PlatformCurveData XData;

		public PlatformCurveData YData;

		public PlatformCurveData ZData;

		public Vector3 Pos;

		public Vector3 Angle;

		public Vector3 Scale;

		public NormalPlatformData(bool isPause, float time, AnimationCurve xData, AnimationCurve yData, AnimationCurve zData, int warpMode, Vector3 pos, Vector3 angle, Vector3 scale)
		{
			IsPause = isPause;
			ExcuteTime = time;
			WrapMode = warpMode;
			XData = new PlatformCurveData(xData);
			YData = new PlatformCurveData(yData);
			ZData = new PlatformCurveData(zData);
			Pos = pos;
			Angle = angle;
			Scale = scale;
		}
	}

	public class TaskData
	{
		public int Id;

		public List<TaskPosition> TaskPositionList;
	}

	private string saveFolderName;

	private int[,] MapMaskData = new int[8, 8];

	private int curMapMaskLevelId;

	private long upLoadDataTime;

	private List<int> activeBorn = new List<int>(3);

	private List<MapItemViewData> MapItemViewDatas = new List<MapItemViewData>(300);

	private long userId;

	private DataStorageOss _oss;

	private string LevelDataBucketName = "kiif-leveldatas";

	private long loginTime;

	private LevelSaveData levelSaveData;

	private readonly IMessenger messenger;

	private LevelData currentLevelData;

	private Dictionary<int, MapItemData> noDirtyMapItemDatas = new Dictionary<int, MapItemData>(10);

	private Dictionary<int, MapItemData> noSaveMapItemDatas = new Dictionary<int, MapItemData>(10);

	private Dictionary<int, NpcData> noDirtyNpcDatas = new Dictionary<int, NpcData>(10);

	private ISubscription<RecordClientEventTimeNotify> RecordClientEventTimeNotify;

	private static readonly object _lockObj = new object();

	private bool isSaving;

	private bool isSaveFinish = true;

	public LevelSaveService()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
		RecordClientEventTimeNotify = Singleton<NetworkSystem>.Instance.Subscribe<RecordClientEventTimeNotify>(GetClientEventTime);
		LevelDataBucketName = GameEntry.BuiltinData.GameVersion.level_save_bucket;
	}

	public async UniTask<bool> RequestData()
	{
		RoleViewModel roleData = null;
		string account = string.Empty;
		if (Singleton<NetworkSystem>.Instance.Connected())
		{
			roleData = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
			account = Singleton<ServiceSystem>.Instance.GetService<IAccountService>().Account;
			userId = roleData.Uid;
		}
		if (_oss == null)
		{
			_oss = new DataStorageOss();
		}
		loginTime = TimeHelper.Now();
		GetServerTimeRequest request = GetServerTimeRequest.Create();
		GetServerTimeResponse response = null;
		try
		{
			if (Singleton<NetworkSystem>.Instance.Connected())
			{
				response = await Singleton<NetworkSystem>.Instance.Call<GetServerTimeResponse>(request);
				if (!Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取服务器时间", "获取服务器时间失败"))
				{
					throw new Exception("获取服务器时间错误");
				}
				loginTime = response.TimeStamp * 1000;
			}
			if (roleData != null)
			{
				saveFolderName = account + "/" + roleData.PlayerInfo.Uid + "/Save.es3";
			}
			else
			{
				saveFolderName = "NoAccount/Save.es3";
			}
			if (Singleton<NetworkSystem>.Instance.ServerName.Equals("release"))
			{
				saveFolderName = "Release/" + saveFolderName;
			}
			else if (Singleton<NetworkSystem>.Instance.ServerName.Equals("appreview"))
			{
				saveFolderName = "Appreview/" + saveFolderName;
			}
			else
			{
				saveFolderName = "Develop/" + saveFolderName;
			}
			if (!ES3.FileExists(saveFolderName))
			{
				if (upLoadDataTime == 0L)
				{
					CopyFile(Application.streamingAssetsPath + "/LevelSave/OriginSave.es3", saveFolderName);
					ES3.Save("taskDatas", new Dictionary<int, TaskData>(), saveFolderName);
					ES3.Save("saveTime", TimeHelper.Epoch(), saveFolderName);
				}
				else
				{
					DownLoadLevelData(saveFolderName);
				}
				ES3.Save("UpLoadTime", upLoadDataTime, saveFolderName);
			}
			else
			{
				if (ES3.Load("UpLoadTime", saveFolderName, 0L) != upLoadDataTime && upLoadDataTime != 0L)
				{
					DownLoadLevelData(saveFolderName);
					ES3.Save("UpLoadTime", upLoadDataTime, saveFolderName);
				}
				int obj = ES3.Load<int>("version", saveFolderName);
				if (!0.Equals(obj))
				{
					Dictionary<int, TaskData> value = ES3.Load("taskDatas", new Dictionary<int, TaskData>());
					CopyFile(Application.streamingAssetsPath + "/LevelSave/OriginSave.es3", saveFolderName);
					ES3.Save("taskDatas", value, saveFolderName);
					ES3.Save("saveTime", TimeHelper.Epoch(), saveFolderName);
					ES3.Save("UpLoadTime", upLoadDataTime, saveFolderName);
					ES3.Save("version", 0, saveFolderName);
				}
			}
			await UniTask.WaitUntil(() => ES3.FileExists(saveFolderName));
			if (levelSaveData == null)
			{
				levelSaveData = LevelSaveData.CreateDefault(TimeHelper.Epoch());
			}
			levelSaveData.SaveTime = ES3.Load<long>("saveTime", saveFolderName);
			levelSaveData.TeachGuid = ES3.Load<HashSet<int>>("TeachGuide", saveFolderName);
			if (!(await RequestLevelSaveData()))
			{
				return false;
			}
		}
		catch (Exception)
		{
			return false;
		}
		finally
		{
			request.Dispose();
			response?.Dispose();
		}
		return true;
	}

	public IMessenger GetMessager()
	{
		return messenger;
	}

	public List<int> GetBonfireActiveList(int levelId)
	{
		GetLevelData(levelId);
		if (levelSaveData == null)
		{
			return null;
		}
		activeBorn.Clear();
		if (levelSaveData.LevelActiveBonfires.TryGetValue(levelId, out var value))
		{
			if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value2) && !value.Contains(value2.DefaultActiveBornfire))
			{
				value.Add(value2.DefaultActiveBornfire);
			}
			activeBorn.AddRange(value);
		}
		return activeBorn;
	}

	public void GetMapItemDatas(int levelId, List<MapItemViewData> mapItemDatas)
	{
		if (GetLevelData(levelId) != null)
		{
			mapItemDatas.Clear();
			mapItemDatas.AddRange(MapItemViewDatas);
		}
	}

	public async UniTask<bool> UpdateBonfireMapMaskState(int levelId, int bonfireId, long mapMask = 0L)
	{
		bool isScuess = false;
		if (levelSaveData == null)
		{
			return isScuess;
		}
		levelSaveData.LevelActiveBonfires.TryGetValue(levelId, out var activeBornfires);
		if (activeBornfires == null)
		{
			activeBornfires = new List<int>(6);
			levelSaveData.LevelActiveBonfires.Add(levelId, activeBornfires);
		}
		if ((bonfireId != 0 && activeBornfires != null && !activeBornfires.Contains(bonfireId)) || mapMask != 0L)
		{
			try
			{
				if (Singleton<NetworkSystem>.Instance.Connected())
				{
					C2M_SaveMapDataRequest c2M_SaveMapDataRequest = C2M_SaveMapDataRequest.Create();
					c2M_SaveMapDataRequest.MapId = levelId;
					c2M_SaveMapDataRequest.HuoWenId = bonfireId;
					c2M_SaveMapDataRequest.MiWuId = mapMask;
					M2C_SaveMapDataResponse message = await Singleton<NetworkSystem>.Instance.Call<M2C_SaveMapDataResponse>(c2M_SaveMapDataRequest);
					if (Singleton<NetResponseHandler>.Instance.ValidateResponse(message, "激活火纹回路/迷雾异常", "激活火纹回路/迷雾异常失败", showToast: false))
					{
						if (bonfireId != 0)
						{
							activeBornfires.Add(bonfireId);
							messenger.Publish(new LevelSaveMessage(this, LevelSaveMessageType.BonfireActiveStateChange, levelId, bonfireId));
						}
						isScuess = true;
					}
				}
			}
			catch (TimeoutException)
			{
				Toast.ShowInfo("网络信号弱，请稍后再试");
			}
			catch (Exception ex2)
			{
				Log.Error("激活火纹回路/迷雾异常！" + ex2.Message + " / " + ex2.StackTrace);
			}
		}
		return isScuess;
	}

	public MapItemData GetMapItemDataAndUpdate(int levelId, int uid)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (levelData == null)
		{
			return null;
		}
		MapItemData value = null;
		if (levelData.MapItemDatas.TryGetValue(uid, out value))
		{
			return value;
		}
		if (noDirtyMapItemDatas.TryGetValue(uid, out value))
		{
			noDirtyMapItemDatas.Remove(uid);
			levelData.MapItemDatas.Add(uid, value);
			return value;
		}
		noSaveMapItemDatas.TryGetValue(uid, out value);
		return value;
	}

	public MapItemData GetMapItemData(int levelId, int uid)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (levelData == null)
		{
			return null;
		}
		MapItemData value = null;
		if (levelData.MapItemDatas.TryGetValue(uid, out value))
		{
			return value;
		}
		if (noDirtyMapItemDatas.TryGetValue(uid, out value))
		{
			return value;
		}
		noSaveMapItemDatas.TryGetValue(uid, out value);
		return value;
	}

	public bool GetTreasureIsOpen(int levelId, int mapItemUid)
	{
		if (levelSaveData == null)
		{
			return false;
		}
		if (levelSaveData.OpenTreasure.TryGetValue(levelId, out var value))
		{
			return value.Contains(mapItemUid);
		}
		return false;
	}

	public MapItemData InitMapItemData(int levelId, MapItemNode node, bool isSave)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (levelData == null)
		{
			return null;
		}
		if (levelData.MapItemDatas.TryGetValue(node.Uid, out var value))
		{
			InitMapItemViewData(value, node.Uid, ((Component)(object)node).transform.position);
			return value;
		}
		if ((UnityEngine.Object)(object)node == null)
		{
			return null;
		}
		MapItemData mapItemData = ReferencePool.Acquire<MapItemData>();
		mapItemData.MapItemId = node.mapItemId;
		mapItemData.Active = ((!node.isActive) ? 1 : 0);
		mapItemData.IconType = 1;
		mapItemData.ParadoxData = new Dictionary<string, MapDataNodeParadoxParameter>((node.nodeParadoxMsg != null) ? node.nodeParadoxMsg.Count : 0);
		if (node.nodeParadoxMsg != null)
		{
			foreach (KeyValuePair<string, MapDataNodeParadoxParameter> item in node.nodeParadoxMsg)
			{
				mapItemData.ParadoxData.Add(item.Key, item.Value);
			}
		}
		if (levelSaveData.OpenTreasure.TryGetValue(levelId, out var value2) && value2.Contains(node.Uid))
		{
			mapItemData.IconType = 2;
		}
		if (!isSave)
		{
			noSaveMapItemDatas.Add(node.Uid, mapItemData);
		}
		else
		{
			noDirtyMapItemDatas.Add(node.Uid, mapItemData);
		}
		InitMapItemViewData(mapItemData, node.Uid, ((Component)(object)node).transform.position);
		return mapItemData;
	}

	private void InitMapItemViewData(MapItemData mapItemData, int uid, Vector3 pos)
	{
		MapItemViewData mapItemViewData = ReferencePool.Acquire<MapItemViewData>();
		mapItemViewData.Data = mapItemData;
		mapItemViewData.Position = pos;
		mapItemViewData.Uid = uid;
		MapItemViewDatas.Add(mapItemViewData);
	}

	public void UpdateMapItemDataParadoxData(int levelId, int uid, string key, MapDataNodeParadoxParameter value)
	{
		MapItemData mapItemDataAndUpdate = GetMapItemDataAndUpdate(levelId, uid);
		if (mapItemDataAndUpdate != null)
		{
			if (!mapItemDataAndUpdate.ParadoxData.ContainsKey(key))
			{
				mapItemDataAndUpdate.ParadoxData.Add(key, value);
			}
			else
			{
				mapItemDataAndUpdate.ParadoxData[key] = value;
			}
		}
	}

	public void UpdateMapItemDataParadoxDatas(int levelId, int uid, Dictionary<string, MapDataNodeParadoxParameter> paradoxs)
	{
		MapItemData mapItemDataAndUpdate = GetMapItemDataAndUpdate(levelId, uid);
		if (mapItemDataAndUpdate == null)
		{
			return;
		}
		foreach (KeyValuePair<string, MapDataNodeParadoxParameter> paradox in paradoxs)
		{
			if (!mapItemDataAndUpdate.ParadoxData.ContainsKey(paradox.Key))
			{
				mapItemDataAndUpdate.ParadoxData.Add(paradox.Key, paradox.Value);
			}
			else
			{
				mapItemDataAndUpdate.ParadoxData[paradox.Key] = paradox.Value;
			}
		}
	}

	public void UpdateMapItemDataIconType(int levelId, int uid, int iconType)
	{
		MapItemData mapItemDataAndUpdate = GetMapItemDataAndUpdate(levelId, uid);
		if (mapItemDataAndUpdate == null)
		{
			return;
		}
		mapItemDataAndUpdate.IconType = iconType;
		for (int i = 0; i < MapItemViewDatas.Count; i++)
		{
			if (MapItemViewDatas[i].Data == mapItemDataAndUpdate)
			{
				messenger.Publish(new MapItemIconMessager(this, MapItemViewDatas[i]));
				break;
			}
		}
	}

	public void UpdateMapDataNodeState(int levelId, int uid, MapDataNodeState mapDataNodeState)
	{
		MapItemData mapItemDataAndUpdate = GetMapItemDataAndUpdate(levelId, uid);
		if (mapItemDataAndUpdate != null)
		{
			mapItemDataAndUpdate.MapDataNodeState = mapDataNodeState;
		}
	}

	public void UpdateMapItemActiveState(int levelId, int uid, int active)
	{
		MapItemData mapItemDataAndUpdate = GetMapItemDataAndUpdate(levelId, uid);
		if (mapItemDataAndUpdate != null)
		{
			mapItemDataAndUpdate.Active = active;
		}
	}

	public void ExcuteMapItemUpdateAction(int levelId, int uid)
	{
		MapItemData mapItemData = GetMapItemData(levelId, uid);
		if (mapItemData != null && levelSaveData.MapItemUpdateAction.ContainsKey(mapItemData))
		{
			levelSaveData.MapItemUpdateAction[mapItemData]?.Invoke(mapItemData);
		}
	}

	public void AddMapItemOnUpdateAction(int levelId, MapItemData mapItemData, Action<MapItemData> onUpdateAction)
	{
		if (!levelSaveData.MapItemUpdateAction.ContainsKey(mapItemData))
		{
			levelSaveData.MapItemUpdateAction.Add(mapItemData, onUpdateAction);
		}
	}

	public void RemoveMapItemOnUpdateAction(MapItemData mapItemData)
	{
		if (levelSaveData.MapItemUpdateAction.ContainsKey(mapItemData))
		{
			levelSaveData.MapItemUpdateAction.Remove(mapItemData);
		}
	}

	public NpcData GetNpcDataAndUpdate(int levelId, int uid)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (levelData == null)
		{
			return null;
		}
		if (!levelData.NpcDatas.TryGetValue(uid, out var value))
		{
			if (!noDirtyNpcDatas.TryGetValue(uid, out value))
			{
				return null;
			}
			noDirtyNpcDatas.Remove(uid);
			levelData.NpcDatas.Add(uid, value);
		}
		return value;
	}

	public NpcData GetNpcData(int levelId, int uid)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (levelData == null)
		{
			return null;
		}
		if (!levelData.NpcDatas.TryGetValue(uid, out var value) && !noDirtyNpcDatas.TryGetValue(uid, out value))
		{
			return null;
		}
		return value;
	}

	public NpcData InitNpcData(int levelId, NPCNode node, Dictionary<int, string> dialogButtonLockState, List<int> prologueIds, List<DialogueChainConfig.DialogueButtonConfig> dialogButtonConfigs)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (levelData == null)
		{
			return null;
		}
		if (levelData.NpcDatas.TryGetValue(node.Uid, out var value))
		{
			return value;
		}
		if ((UnityEngine.Object)(object)node == null)
		{
			return null;
		}
		NpcData npcData = new NpcData();
		npcData.Active = node.isActive;
		npcData.IconType = -1;
		npcData.ParadoxData = new Dictionary<string, MapDataNodeParadoxParameter>((node.nodeParadoxMsg != null) ? node.nodeParadoxMsg.Count : 0);
		if (node.nodeParadoxMsg != null)
		{
			foreach (KeyValuePair<string, MapDataNodeParadoxParameter> item in node.nodeParadoxMsg)
			{
				npcData.ParadoxData.Add(item.Key, item.Value);
			}
		}
		npcData.DialogButtonLockState = new Dictionary<int, string>(dialogButtonLockState?.Count ?? 0);
		if (dialogButtonLockState != null)
		{
			foreach (KeyValuePair<int, string> item2 in dialogButtonLockState)
			{
				npcData.DialogButtonLockState.Add(item2.Key, item2.Value);
			}
		}
		npcData.PrologueIds = new List<int>(prologueIds?.Count ?? 0);
		if (prologueIds != null)
		{
			foreach (int prologueId in prologueIds)
			{
				npcData.PrologueIds.Add(prologueId);
			}
		}
		npcData.DialogButtonConfigs = new List<DialogueChainConfig.DialogueButtonConfig>(dialogButtonConfigs?.Count ?? 0);
		if (dialogButtonConfigs != null)
		{
			foreach (DialogueChainConfig.DialogueButtonConfig dialogButtonConfig in dialogButtonConfigs)
			{
				npcData.DialogButtonConfigs.Add(dialogButtonConfig);
			}
		}
		noDirtyNpcDatas.Add(node.Uid, npcData);
		return npcData;
	}

	public void UpdateNpcActiveState(int levelId, int npcNodeUid, bool active)
	{
		NpcData npcDataAndUpdate = GetNpcDataAndUpdate(levelId, npcNodeUid);
		if (npcDataAndUpdate != null)
		{
			npcDataAndUpdate.Active = active;
			if (levelSaveData.NpcUpdateAction.ContainsKey(npcDataAndUpdate))
			{
				levelSaveData.NpcUpdateAction[npcDataAndUpdate]?.Invoke(npcDataAndUpdate);
			}
		}
	}

	public void UpdateNpcDialogPrologue(int levelId, int npcNodeUid, List<int> prologueIds)
	{
		NpcData npcDataAndUpdate = GetNpcDataAndUpdate(levelId, npcNodeUid);
		if (npcDataAndUpdate != null)
		{
			npcDataAndUpdate.PrologueIds = prologueIds;
			if (levelSaveData.NpcUpdateAction.ContainsKey(npcDataAndUpdate))
			{
				levelSaveData.NpcUpdateAction[npcDataAndUpdate]?.Invoke(npcDataAndUpdate);
			}
		}
	}

	public void UpdateDialogueButtonState(int levelId, int npcNodeUid, int buttonId, string state)
	{
		NpcData npcDataAndUpdate = GetNpcDataAndUpdate(levelId, npcNodeUid);
		if (npcDataAndUpdate == null)
		{
			return;
		}
		if (npcDataAndUpdate.DialogButtonLockState.ContainsKey(buttonId))
		{
			if (npcDataAndUpdate.DialogButtonLockState[buttonId] == state)
			{
				return;
			}
			npcDataAndUpdate.DialogButtonLockState[buttonId] = state;
		}
		else
		{
			npcDataAndUpdate.DialogButtonLockState.Add(buttonId, state);
		}
		if (levelSaveData.NpcUpdateAction.ContainsKey(npcDataAndUpdate))
		{
			levelSaveData.NpcUpdateAction[npcDataAndUpdate]?.Invoke(npcDataAndUpdate);
		}
	}

	public void UpdateNpcParadoxData(int levelId, int npcNodeUid, string key, MapDataNodeParadoxParameter value)
	{
		NpcData npcDataAndUpdate = GetNpcDataAndUpdate(levelId, npcNodeUid);
		if (npcDataAndUpdate != null)
		{
			if (!npcDataAndUpdate.ParadoxData.ContainsKey(key))
			{
				npcDataAndUpdate.ParadoxData.Add(key, value);
			}
			else
			{
				npcDataAndUpdate.ParadoxData[key] = value;
			}
			if (levelSaveData.NpcUpdateAction.ContainsKey(npcDataAndUpdate))
			{
				levelSaveData.NpcUpdateAction[npcDataAndUpdate]?.Invoke(npcDataAndUpdate);
			}
		}
	}

	public void UpdateNpcParadoxDatas(int levelId, int uid, Dictionary<string, MapDataNodeParadoxParameter> paradoxs)
	{
		NpcData npcDataAndUpdate = GetNpcDataAndUpdate(levelId, uid);
		if (npcDataAndUpdate == null)
		{
			return;
		}
		foreach (KeyValuePair<string, MapDataNodeParadoxParameter> paradox in paradoxs)
		{
			if (!npcDataAndUpdate.ParadoxData.ContainsKey(paradox.Key))
			{
				npcDataAndUpdate.ParadoxData.Add(paradox.Key, paradox.Value);
			}
			else
			{
				npcDataAndUpdate.ParadoxData[paradox.Key] = paradox.Value;
			}
		}
		if (levelSaveData.NpcUpdateAction.ContainsKey(npcDataAndUpdate))
		{
			levelSaveData.NpcUpdateAction[npcDataAndUpdate]?.Invoke(npcDataAndUpdate);
		}
	}

	public void UpdateNpcData(int levelId, int npcNodeUid, List<DialogueChainConfig.DialogueButtonConfig> dialogButtonGroup)
	{
		NpcData npcDataAndUpdate = GetNpcDataAndUpdate(levelId, npcNodeUid);
		if (npcDataAndUpdate != null)
		{
			npcDataAndUpdate.DialogButtonConfigs = dialogButtonGroup;
			if (levelSaveData.NpcUpdateAction.ContainsKey(npcDataAndUpdate))
			{
				levelSaveData.NpcUpdateAction[npcDataAndUpdate]?.Invoke(npcDataAndUpdate);
			}
		}
	}

	public void ExcuteNpcUpdateAction(int levelId, int uid)
	{
		NpcData npcData = GetNpcData(levelId, uid);
		if (npcData != null && levelSaveData.NpcUpdateAction.ContainsKey(npcData))
		{
			levelSaveData.NpcUpdateAction[npcData]?.Invoke(npcData);
		}
	}

	public void AddNpcDataOnUpdateAction(int levelId, NpcData npcData, Action<NpcData> onUpdateAction)
	{
		if (!levelSaveData.NpcUpdateAction.ContainsKey(npcData))
		{
			levelSaveData.NpcUpdateAction.Add(npcData, onUpdateAction);
		}
	}

	public void RemoveNpcDataOnUpdateAction(NpcData npcData)
	{
		if (levelSaveData.NpcUpdateAction.ContainsKey(npcData))
		{
			levelSaveData.NpcUpdateAction.Remove(npcData);
		}
	}

	public void UpdateMonsterDieTime(int levelId, int uid)
	{
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value))
		{
			if (value.MonsterData.ContainsKey(uid))
			{
				value.MonsterData[uid] = TimeHelper.ClientNowSeconds();
			}
			else
			{
				value.MonsterData.Add(uid, TimeHelper.ClientNowSeconds());
			}
		}
	}

	public long GetMonsterLastDieTime(int levelId, int uid)
	{
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value))
		{
			if (value.MonsterData.ContainsKey(uid))
			{
				return value.MonsterData[uid];
			}
			return 0L;
		}
		return 0L;
	}

	public void UpdateMonsterGroupAllDieTime(int levelId, int uid)
	{
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value))
		{
			if (value.MonsterGroupData.ContainsKey(uid))
			{
				value.MonsterGroupData[uid] = TimeHelper.ClientNowSeconds();
			}
			else
			{
				value.MonsterGroupData.Add(uid, TimeHelper.ClientNowSeconds());
			}
		}
	}

	public long GetMonsterGroupLastAllDieTime(int levelId, int uid)
	{
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value))
		{
			if (value.MonsterGroupData.ContainsKey(uid))
			{
				return value.MonsterGroupData[uid];
			}
			return 0L;
		}
		return 0L;
	}

	public void ChangeAnimationCurveData(AnimationCurve curve, PlatformCurveData platformCurveData)
	{
		if (curve == null)
		{
			return;
		}
		for (int i = 0; i < curve.keys.Length; i++)
		{
			Keyframe keyframe = curve.keys[i];
			if (platformCurveData.AnimationCurveKeyFrames.Count > i)
			{
				platformCurveData.AnimationCurveKeyFrames[i].Time = keyframe.time;
				platformCurveData.AnimationCurveKeyFrames[i].Value = keyframe.value;
				platformCurveData.AnimationCurveKeyFrames[i].InTangent = keyframe.inTangent;
				platformCurveData.AnimationCurveKeyFrames[i].OutTangent = keyframe.outTangent;
				platformCurveData.AnimationCurveKeyFrames[i].TangentMode = keyframe.tangentMode;
				platformCurveData.AnimationCurveKeyFrames[i].WeightedMode = (int)keyframe.weightedMode;
				platformCurveData.AnimationCurveKeyFrames[i].InWeight = keyframe.inWeight;
				platformCurveData.AnimationCurveKeyFrames[i].OutWeight = keyframe.outWeight;
			}
			else
			{
				platformCurveData.AnimationCurveKeyFrames.Add(new AnimationCurveKeyFrame(keyframe.time, keyframe.value, keyframe.inTangent, keyframe.outTangent, keyframe.tangentMode, (int)keyframe.weightedMode, keyframe.inWeight, keyframe.outWeight));
			}
		}
		if (platformCurveData.AnimationCurveKeyFrames.Count > curve.keys.Length)
		{
			platformCurveData.AnimationCurveKeyFrames.RemoveRange(curve.keys.Length, platformCurveData.AnimationCurveKeyFrames.Count - curve.keys.Length);
		}
		platformCurveData.PostWrapMode = (int)curve.postWrapMode;
		platformCurveData.PreWrapMode = (int)curve.preWrapMode;
	}

	public void UpdateNormalPlatformData(int levelId, int platformId, bool isPause, float time, AnimationCurve xCurData, AnimationCurve yCurData, AnimationCurve zCurData, int warpMode, Vector3 pos, Vector3 angle, Vector3 scale)
	{
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value))
		{
			if (value.NormalPlatformDatas.ContainsKey(platformId))
			{
				value.NormalPlatformDatas[platformId].IsPause = isPause;
				value.NormalPlatformDatas[platformId].ExcuteTime = time;
				ChangeAnimationCurveData(xCurData, value.NormalPlatformDatas[platformId].XData);
				ChangeAnimationCurveData(yCurData, value.NormalPlatformDatas[platformId].YData);
				ChangeAnimationCurveData(zCurData, value.NormalPlatformDatas[platformId].ZData);
				value.NormalPlatformDatas[platformId].WrapMode = warpMode;
				value.NormalPlatformDatas[platformId].Pos = pos;
				value.NormalPlatformDatas[platformId].Angle = angle;
				value.NormalPlatformDatas[platformId].Scale = scale;
			}
			else
			{
				value.NormalPlatformDatas.Add(platformId, new NormalPlatformData(isPause, time, xCurData, yCurData, zCurData, warpMode, pos, angle, scale));
			}
		}
	}

	public NormalPlatformData GetNormalPlatformData(int levelId, int platformId)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (levelData != null && levelData.NormalPlatformDatas.ContainsKey(platformId))
		{
			return levelData.NormalPlatformDatas[platformId];
		}
		return null;
	}

	public MechanismData GetMechanismData(int levelId, int uId)
	{
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value) && value.MechanismDatas.ContainsKey(uId))
		{
			return value.MechanismDatas[uId];
		}
		return null;
	}

	public void SetMechanismData(int levelId, int uId, int state)
	{
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value))
		{
			if (value.MechanismDatas.ContainsKey(uId))
			{
				value.MechanismDatas[uId].RunState = state;
				return;
			}
			MechanismData mechanismData = new MechanismData();
			mechanismData.RunState = state;
			value.MechanismDatas.Add(uId, mechanismData);
		}
	}

	public TriggerData GetTriggerData(int levelId, int uId)
	{
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value) && value.TriggerDatas.ContainsKey(uId))
		{
			return value.TriggerDatas[uId];
		}
		return null;
	}

	public void SetTriggerData(int levelId, int uId, int executeTime)
	{
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value))
		{
			if (value.TriggerDatas.ContainsKey(uId))
			{
				value.TriggerDatas[uId].ExecuteTime = executeTime;
				return;
			}
			TriggerData triggerData = new TriggerData();
			triggerData.ExecuteTime = executeTime;
			value.TriggerDatas.Add(uId, triggerData);
		}
	}

	public async UniTask EnterLevelGetSaveData(int levelId)
	{
		LevelData levelData = (currentLevelData = GetLevelData(levelId));
		if (levelData == null)
		{
			levelData = ES3.Load<LevelData>(levelId.ToString(), saveFolderName);
		}
		RefreshMapItemState(levelData);
		currentLevelData = levelData;
	}

	public void QuitLevel()
	{
		currentLevelData = null;
		noDirtyNpcDatas.Clear();
		foreach (MapItemData value in noDirtyMapItemDatas.Values)
		{
			ReferencePool.Release(value);
		}
		noDirtyMapItemDatas.Clear();
		foreach (MapItemData value2 in noSaveMapItemDatas.Values)
		{
			ReferencePool.Release(value2);
		}
		noSaveMapItemDatas.Clear();
		for (int i = 0; i < MapItemViewDatas.Count; i++)
		{
			ReferencePool.Release(MapItemViewDatas[i]);
		}
		MapItemViewDatas.Clear();
	}

	public async UniTask SaveLevelData(int levelId)
	{
		if (isSaving)
		{
			return;
		}
		isSaving = true;
		isSaveFinish = false;
		UniTask.RunOnThreadPool(delegate
		{
			lock (_lockObj)
			{
				isSaveFinish = false;
				isSaving = false;
				try
				{
					ES3.Save("saveTime", loginTime, saveFolderName);
					if (levelSaveData != null && levelSaveData.LevelDatas != null && levelSaveData.LevelDatas.TryGetValue(levelId, out var value) && value != null)
					{
						ES3.Save(levelId.ToString(), value, saveFolderName);
					}
				}
				catch (Exception message)
				{
					Log.Error(message);
				}
				isSaveFinish = true;
				UpLoadLevelSaveData();
			}
		});
	}

	private LevelData GetLevelData(int levelId)
	{
		if (levelSaveData == null)
		{
			return null;
		}
		if (levelSaveData.LevelDatas.TryGetValue(levelId, out var value))
		{
			return value;
		}
		if (!ES3.FileExists(saveFolderName))
		{
			return null;
		}
		if (ES3.KeyExists(levelId.ToString(), saveFolderName))
		{
			value = ES3.Load<LevelData>(levelId.ToString(), saveFolderName);
		}
		if (value == null)
		{
			value = CreateLevelDefaultData(levelId);
		}
		levelSaveData.LevelDatas.Add(levelId, value);
		if (levelSaveData.LevelActiveBonfires.TryGetValue(levelId, out var value2))
		{
			if (!value2.Contains(value.DefaultActiveBornfire))
			{
				value2.Add(value.DefaultActiveBornfire);
			}
		}
		else
		{
			List<int> list = new List<int>(6);
			list.Add(value.DefaultActiveBornfire);
			levelSaveData.LevelActiveBonfires.Add(levelId, list);
		}
		if (!levelSaveData.LevelMapMask.ContainsKey(levelId))
		{
			levelSaveData.LevelMapMask.Add(levelId, value.DefaultMapMaskBit);
		}
		return value;
	}

	private LevelData CreateLevelDefaultData(int levelId)
	{
		LevelData levelData = new LevelData();
		levelData.LevelId = levelId;
		DRLevel dataRow = GameEntry.DataTable.GetDataRow<DRLevel>(levelId);
		if (dataRow != null)
		{
			int defaultActiveBonfire = dataRow.DefaultActiveBonfire;
			if (defaultActiveBonfire != 0)
			{
				levelData.DefaultActiveBornfire = defaultActiveBonfire;
			}
		}
		levelData.ActiveCaves = new List<int>();
		levelData.NpcDatas = new Dictionary<int, NpcData>(10);
		levelData.MapItemDatas = new Dictionary<int, MapItemData>(30);
		levelData.LastRefreshTime = TimeHelper.Epoch();
		DRMap dataRow2 = GameEntry.DataTable.GetDataRow<DRMap>(levelId);
		int index = 1;
		if (dataRow2 != null)
		{
			index = dataRow2.DefaultActiveMapMaskId;
		}
		levelData.DefaultMapMaskBit = TSUtil.SetBitValue(index, 1, levelData.DefaultMapMaskBit);
		return levelData;
	}

	private LevelData GetCurrentLevelData(int levelId)
	{
		if (levelSaveData == null)
		{
			Log.Error("获取当前存档错误，已经退出关卡但是还在获取存档数据");
		}
		if (currentLevelData != null && currentLevelData.LevelId == levelId)
		{
			return currentLevelData;
		}
		levelSaveData.LevelDatas.TryGetValue(levelId, out var value);
		return value;
	}

	public int[,] GetMapMaskData(int levelId)
	{
		if (levelSaveData == null)
		{
			return null;
		}
		if (curMapMaskLevelId != levelId)
		{
			if (levelSaveData.LevelMapMask.TryGetValue(levelId, out var value))
			{
				int length = MapMaskData.GetLength(0);
				int length2 = MapMaskData.GetLength(1);
				for (int i = 0; i < MapMaskData.Length; i++)
				{
					MapMaskData[i / length, i % length2] = TSUtil.GetBitValue(i, value);
				}
				curMapMaskLevelId = levelId;
				return MapMaskData;
			}
			return null;
		}
		return MapMaskData;
	}

	public void UpdateMaskData(int levelId, long value)
	{
		if (!levelSaveData.LevelMapMask.ContainsKey(levelId))
		{
			levelSaveData.LevelMapMask.Add(levelId, value);
		}
		levelSaveData.LevelMapMask[levelId] = value;
		int length = MapMaskData.GetLength(0);
		int length2 = MapMaskData.GetLength(1);
		for (int i = 0; i < MapMaskData.Length; i++)
		{
			MapMaskData[i / length, i % length2] = TSUtil.GetBitValue(i, value);
		}
		curMapMaskLevelId = levelId;
		messenger.Publish(new MapMaskMsg(null, 0));
	}

	public void Dispose()
	{
		upLoadDataTime = 0L;
	}

	public async UniTask ChangeMapMaskData(int levelId, int index, int value)
	{
		if (!levelSaveData.LevelMapMask.TryGetValue(levelId, out var mapMask))
		{
			return;
		}
		mapMask = TSUtil.SetBitValue(index, value, mapMask);
		if (!(await UpdateBonfireMapMaskState(levelId, 0, mapMask)))
		{
			return;
		}
		levelSaveData.LevelMapMask[levelId] = mapMask;
		GetMapMaskData(levelId);
		if (MapMaskData != null)
		{
			int length = MapMaskData.GetLength(0);
			int length2 = MapMaskData.GetLength(1);
			if (length == 0 || length2 == 0)
			{
				return;
			}
			MapMaskData[index / length, index % length2] = value;
		}
		messenger.Publish(new MapMaskMsg(null, index));
	}

	public bool GetMapMaskIndexUnLock(int levelId, int index)
	{
		int num = 0;
		if (levelSaveData == null)
		{
			return false;
		}
		if (levelSaveData.LevelMapMask.TryGetValue(levelId, out var value))
		{
			num = TSUtil.GetBitValue(index, value);
		}
		return num == 1;
	}

	public void UpdateRockerControlValue(int levelId, int rockerId, int rockerValue)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (levelData != null)
		{
			if (levelData.RockerControls.ContainsKey(rockerId))
			{
				levelData.RockerControls[rockerId] = rockerValue;
			}
			else
			{
				levelData.RockerControls.Add(rockerId, rockerValue);
			}
		}
	}

	public int GetRockerControlValue(int levelId, int rockerId)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (levelData != null && levelData.RockerControls.ContainsKey(rockerId))
		{
			return levelData.RockerControls[rockerId];
		}
		return -1;
	}

	public bool GetIsTeachGuide(int guideId)
	{
		if (levelSaveData == null)
		{
			return false;
		}
		return levelSaveData.TeachGuid.Contains(guideId);
	}

	public bool GetFinishTeachGuide(int guideId)
	{
		if (levelSaveData == null)
		{
			return true;
		}
		return levelSaveData.TeachGuid.Contains(guideId);
	}

	public void TeachGuideDataChangeSave(int guideId, bool isAdd)
	{
		if (levelSaveData == null)
		{
			return;
		}
		if (isAdd)
		{
			if (levelSaveData.TeachGuid.Contains(guideId))
			{
				return;
			}
			levelSaveData.TeachGuid.Add(guideId);
		}
		else
		{
			if (!levelSaveData.TeachGuid.Contains(guideId))
			{
				return;
			}
			levelSaveData.TeachGuid.Remove(guideId);
		}
		if (isSaveFinish)
		{
			isSaveFinish = false;
			ES3.Save("TeachGuide", levelSaveData.TeachGuid, saveFolderName);
			isSaveFinish = true;
		}
	}

	public List<int> GetAllTeachGuide()
	{
		return levelSaveData.TeachGuid.ToList();
	}

	public void ActiveCaves(int levelId, int cavesId)
	{
		LevelData levelData = GetCurrentLevelData(levelId);
		if (!levelData.ActiveCaves.Contains(cavesId))
		{
			levelData.ActiveCaves.Add(cavesId);
			messenger.Publish(new LevelSaveMessage(this, LevelSaveMessageType.CavePointActiveStateChange, levelId, cavesId));
		}
	}

	public void GetActiveCaves(int levelId, List<int> cavesId)
	{
		if (cavesId == null)
		{
			return;
		}
		LevelData levelData = GetLevelData(levelId);
		if (levelData != null)
		{
			cavesId.Clear();
			if (levelData.ActiveCaves != null)
			{
				cavesId.AddRange(levelData.ActiveCaves);
			}
		}
	}

	private async Task<bool> RefreshMapItemState(LevelData levelData)
	{
		long num = levelData.LastRefreshTime - (levelData.LastRefreshTime + 28800000) % 86400000;
		if (loginTime - num >= 259200000)
		{
			foreach (MapItemData value in levelData.MapItemDatas.Values)
			{
				DRMapItem dataRow = GameEntry.DataTable.GetDataRow<DRMapItem>(value.MapItemId);
				if (dataRow != null && dataRow.DailyRefresh)
				{
					if (value.ParadoxData.ContainsKey("saveArgsKey"))
					{
						value.ParadoxData["saveArgsKey"].parameter.SetValue(0);
					}
					value.Active = -1;
					value.IconType = 1;
					value.MapDataNodeState = MapDataNodeState.Unsummoned;
				}
			}
			levelData.LastRefreshTime = TimeHelper.Now();
			return true;
		}
		return false;
	}

	private void UpLoadLevelSaveData()
	{
		if (Singleton<NetworkSystem>.Instance.Connected())
		{
			byte[] content = ES3.LoadRawBytes(saveFolderName);
			SyncLevelDataSave(saveFolderName, content);
		}
	}

	public void DownLoadData()
	{
		DownLoadLevelData(saveFolderName);
	}

	public void DownLoadLevelData(string path)
	{
		byte[] bytes = CLZF2.Decompress(_oss.GetObject(path, LevelDataBucketName));
		if (ES3.FileExists(path + ".temp"))
		{
			ES3.DeleteFile(path + ".temp");
		}
		ES3.SaveRaw(bytes, path + ".temp");
		ES3.CopyFile(path + ".temp", path);
		ES3.DeleteFile(path + ".temp");
	}

	private void SyncLevelDataSave(string uploadFileName, byte[] content)
	{
		byte[] data = CLZF2.Compress(content);
		_oss.AsyncPutObject(LevelDataBucketName, uploadFileName, data);
		RecordClientEventTimeClientMessage recordClientEventTimeClientMessage = RecordClientEventTimeClientMessage.Create();
		long value = (recordClientEventTimeClientMessage.RecordTime = TimeHelper.ClientNow());
		recordClientEventTimeClientMessage.EventType = 1;
		recordClientEventTimeClientMessage.UserId = userId;
		if (Singleton<NetworkSystem>.Instance.Connected())
		{
			Singleton<NetworkSystem>.Instance.Call(recordClientEventTimeClientMessage);
			ES3.Save("UpLoadTime", value, uploadFileName);
		}
	}

	private void GetClientEventTime(RecordClientEventTimeNotify notify)
	{
		if (notify == null)
		{
			return;
		}
		for (int i = 0; i < notify.EventTimes.Count; i++)
		{
			if (notify.EventTimes[i].EventType == 1)
			{
				upLoadDataTime = notify.EventTimes[i].Time;
			}
		}
	}

	public void CopyFile(string sourcePath, string destinationPath)
	{
		byte[] bytes = null;
		if (Application.platform == RuntimePlatform.Android)
		{
			UnityWebRequest val = UnityWebRequest.Get(sourcePath);
			try
			{
				val.SendWebRequest();
				while (!val.isDone)
				{
				}
				bytes = val.downloadHandler.data;
			}
			finally
			{
				((IDisposable)val)?.Dispose();
			}
		}
		else
		{
			bytes = File.ReadAllBytes(sourcePath);
		}
		destinationPath = Application.persistentDataPath + "/" + destinationPath;
		string directoryName = System.IO.Path.GetDirectoryName(destinationPath);
		if (!Directory.Exists(directoryName))
		{
			Directory.CreateDirectory(directoryName);
		}
		File.WriteAllBytes(destinationPath, bytes);
	}

	public void DeleteSaveData()
	{
		RoleViewModel roleViewModel = null;
		string empty = string.Empty;
		string filePath = string.Empty;
		roleViewModel = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData();
		empty = Singleton<ServiceSystem>.Instance.GetService<IAccountService>().Account;
		if (roleViewModel != null && roleViewModel.PlayerInfo != null)
		{
			filePath = System.IO.Path.Combine(Application.persistentDataPath, empty, roleViewModel.PlayerInfo.Uid.ToString(), "Save.es3");
		}
		if (ES3.FileExists(filePath))
		{
			ES3.DeleteFile(filePath);
		}
	}

	public bool GetBornfireIsActive(int levelId, int bornfireId)
	{
		if (levelSaveData == null)
		{
			return false;
		}
		if (levelSaveData.LevelActiveBonfires.TryGetValue(levelId, out var value))
		{
			return value.Contains(bornfireId);
		}
		return false;
	}

	private async UniTask<bool> RequestLevelSaveData()
	{
		bool isScuess = false;
		if (Singleton<NetworkSystem>.Instance.Connected())
		{
			C2M_GetMapDataRequest request = C2M_GetMapDataRequest.Create();
			M2C_GetMapDataResponse res = null;
			try
			{
				res = await Singleton<NetworkSystem>.Instance.Call<M2C_GetMapDataResponse>(request);
				if (res.Error == 0)
				{
					if (res.MapData != null && res.MapData.Count > 0)
					{
						for (int i = 0; i < res.MapData.Count; i++)
						{
							PbMapNode pbMapNode = res.MapData[i];
							List<int> list = new List<int>(6);
							if (pbMapNode.HuoWenIdList != null)
							{
								for (int j = 0; j < pbMapNode.HuoWenIdList.Count; j++)
								{
									list.Add((int)pbMapNode.HuoWenIdList[j]);
								}
							}
							List<int> list2 = new List<int>();
							if (pbMapNode.BoxIdList != null)
							{
								list2.AddRange(pbMapNode.BoxIdList);
							}
							if (levelSaveData.OpenTreasure.ContainsKey(pbMapNode.MapId))
							{
								levelSaveData.OpenTreasure[pbMapNode.MapId] = list2;
							}
							else
							{
								levelSaveData.OpenTreasure.Add(pbMapNode.MapId, list2);
							}
							if (levelSaveData.LevelActiveBonfires.ContainsKey(pbMapNode.MapId))
							{
								levelSaveData.LevelActiveBonfires[pbMapNode.MapId] = list;
							}
							else
							{
								levelSaveData.LevelActiveBonfires.Add(pbMapNode.MapId, list);
							}
							if (pbMapNode.MiWuId != 0L)
							{
								if (levelSaveData.LevelMapMask.ContainsKey(pbMapNode.MapId))
								{
									levelSaveData.LevelMapMask[pbMapNode.MapId] = pbMapNode.MiWuId;
								}
								else
								{
									levelSaveData.LevelMapMask.Add(pbMapNode.MapId, pbMapNode.MiWuId);
								}
								if (currentLevelData != null && currentLevelData.LevelId == pbMapNode.MapId)
								{
									UpdateMaskData(pbMapNode.MapId, pbMapNode.MiWuId);
								}
							}
						}
					}
					isScuess = true;
				}
				else
				{
					Log.Error("请求关卡数据异常，错误码" + res.Error);
				}
			}
			catch (TimeoutException)
			{
				Toast.ShowInfo("网络信号弱，请稍后再试");
				isScuess = false;
			}
			catch (Exception ex2)
			{
				Log.Error("请求关卡数据异常！" + ex2.Message + " / " + ex2.StackTrace);
				isScuess = false;
			}
			finally
			{
				request.Dispose();
				res?.Dispose();
			}
		}
		if (currentLevelData != null)
		{
			levelSaveData.LevelActiveBonfires.TryGetValue(currentLevelData.LevelId, out var value);
			if (value == null)
			{
				value = new List<int>(6);
				levelSaveData.LevelActiveBonfires.Add(currentLevelData.LevelId, value);
			}
			if (!value.Contains(currentLevelData.DefaultActiveBornfire))
			{
				value.Add(currentLevelData.DefaultActiveBornfire);
			}
			if (!levelSaveData.LevelMapMask.ContainsKey(currentLevelData.LevelId))
			{
				levelSaveData.LevelMapMask.Add(currentLevelData.LevelId, currentLevelData.DefaultMapMaskBit);
			}
		}
		return isScuess;
	}

	public void OpenTreasureSave(int levelId, int uid)
	{
		if (levelSaveData != null)
		{
			levelSaveData.OpenTreasure.TryGetValue(levelId, out var value);
			if (value == null)
			{
				value = new List<int>(10);
				levelSaveData.OpenTreasure.Add(levelId, value);
			}
			if (!value.Contains(uid))
			{
				value.Add(uid);
			}
		}
	}
}
