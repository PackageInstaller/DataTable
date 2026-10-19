using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.MultiPlayer;
using ACT.UI;
using ACT.UI.DataProxy;
using ACT.World;
using ACT.World.Asset;
using Bamboo.Collections;
using Bamboo.ECS;
using Bamboo.Precache;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Runtime.Utility;

namespace ACT.Model;

public class TempleModel : Model<TempleModel>
{
	private const int TempleRobotType = 18;

	private const int DefaultStarCount = 3;

	private int _curChallengeTempleId;

	private StageChallengeTarget _lastChallengeInfo = new StageChallengeTarget();

	public BMap<int, List<TempleData>> areaTempleDatas { get; private set; }

	public BMap<int, Dictionary<int, bool>> areaRewardDatas { get; private set; }

	public BMap<int, int> areaStarCount { get; private set; }

	public int CurChallengeTempleId => _curChallengeTempleId;

	public BMap<int, bool> CurrentReveiveRobot { get; private set; } = BMapPool<int, bool>.Default.Get();

	public System.DateTime StartTime { get; set; }

	public float Duration => GetTimer();

	public void ResetTimer()
	{
		StartTime = System.DateTime.Now;
	}

	public float GetTimer()
	{
		return (float)(System.DateTime.Now - StartTime).TotalSeconds;
	}

	public TempleData GetTempleData(int templeId)
	{
		foreach (KeyValuePair<int, List<TempleData>> areaTempleData in areaTempleDatas)
		{
			TempleData templeData = areaTempleData.Value.FirstOrDefault((TempleData t) => t.templeId == templeId);
			if (templeData != null)
			{
				return templeData;
			}
		}
		return null;
	}

	public TempleData GetCurChallengeTempleData()
	{
		if (_curChallengeTempleId == 0)
		{
			return null;
		}
		return GetTempleData(_curChallengeTempleId);
	}

	public bool IsTempleUnlocked(int templeId)
	{
		return GetTempleData(templeId)?.unLock ?? false;
	}

	public void InitDataByNtf(TempleInfo info)
	{
		_curChallengeTempleId = info.CurChallengeId;
		BindData(info);
	}

	public void UpdateTemple(Temple temple, bool resetData = true)
	{
		if (temple == null)
		{
			if (resetData)
			{
				ResetChallengeProgress();
			}
			_curChallengeTempleId = 0;
			return;
		}
		_curChallengeTempleId = temple.Id;
		TempleData templeData = GetTempleData(temple.Id);
		if (templeData != null)
		{
			ApplyServerDataToTempleData(templeData, temple);
		}
	}

	private void ResetChallengeProgress()
	{
		TempleData curChallengeTempleData = GetCurChallengeTempleData();
		if (curChallengeTempleData == null)
		{
			return;
		}
		foreach (KeyValuePair<int, bool> item in CurrentReveiveRobot)
		{
			if (item.Value && item.Key < curChallengeTempleData.gotStars.Length)
			{
				curChallengeTempleData.gotStars[item.Key] = false;
			}
		}
		CurrentReveiveRobot.Clear();
	}

	public void OnTempleUnlocked(int templeId)
	{
		TempleData templeData = GetTempleData(templeId);
		if (templeData != null)
		{
			templeData.unLock = true;
		}
	}

	public void MarkRobotReceived(int index)
	{
		CurrentReveiveRobot[index] = true;
	}

	public void ClearReceivedRobots()
	{
		CurrentReveiveRobot.Clear();
	}

	public void SetAreaRewardClaimed(int area, int stars)
	{
		if (areaRewardDatas.TryGetValue(area, out var value))
		{
			value[stars] = true;
		}
	}

	protected override void Init()
	{
		areaTempleDatas = BMapPool<int, List<TempleData>>.Default.Get();
		areaRewardDatas = BMapPool<int, Dictionary<int, bool>>.Default.Get();
		areaStarCount = BMapPool<int, int>.Default.Get();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UpdateAreaStarCount, UpdateAreaStartCount);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UpdateAreaRewardState, UpdateTempleRewardState);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.ServiceSave_Refresh, UpdateTempleStateObject);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		PrecacheManager.Instance.Preload(GameLoader.meta.templeUnLockStateTimeline.GUID);
		PrecacheManager.Instance.Preload(GameLoader.meta.templeLockStateTimeline.GUID);
		BindData();
	}

	private void BindData(TempleInfo serverInfo = null)
	{
		areaTempleDatas.Clear();
		areaRewardDatas.Clear();
		areaStarCount.Clear();
		foreach (KeyValuePair<int, InstanceDungeonMap> instanceDungeonMap in RuntimeConfigs.data.instanceDungeonMaps)
		{
			int num = 0;
			areaTempleDatas[instanceDungeonMap.Key] = new List<TempleData>();
			areaRewardDatas[instanceDungeonMap.Key] = new Dictionary<int, bool>();
			int[] instanceList = instanceDungeonMap.Value.instanceList;
			foreach (int templeId in instanceList)
			{
				TempleData templeData = BuildTempleData(templeId, serverInfo);
				areaTempleDatas[instanceDungeonMap.Key].Add(templeData);
				num += templeData.gotStars.Count((bool s) => s);
			}
			areaStarCount[instanceDungeonMap.Key] = num;
		}
		if (serverInfo == null)
		{
			return;
		}
		foreach (KeyValuePair<int, TempleArea> item in serverInfo.AreaInfo)
		{
			if (!areaRewardDatas.ContainsKey(item.Key))
			{
				continue;
			}
			foreach (KeyValuePair<int, bool> takenStarReward in item.Value.TakenStarRewards)
			{
				areaRewardDatas[item.Key][takenStarReward.Key] = takenStarReward.Value;
			}
		}
	}

	private TempleData BuildTempleData(int templeId, TempleInfo serverInfo)
	{
		TempleData templeData = new TempleData
		{
			templeId = templeId,
			gotStars = new bool[3]
		};
		if (RuntimeConfigs.data.instanceDungeons.TryGetValue(templeId, out var value))
		{
			templeData.staticData = value;
		}
		Temple temple = serverInfo?.Temples.GetValueOrDefault(templeId);
		if (temple != null)
		{
			ApplyServerDataToTempleData(templeData, temple);
			templeData.unLock = true;
		}
		return templeData;
	}

	private void ApplyServerDataToTempleData(TempleData templeData, Temple serverTemple)
	{
		templeData.isComplate = serverTemple.Completed;
		templeData.collectTreasureNum = serverTemple.CollectTreasureNum;
		templeData.completeTime = serverTemple.StageMinimumSecs;
		templeData.stageChallengeTarget = serverTemple.Target;
		templeData.isPerfect = serverTemple.Target != null && serverTemple.Target.IsPerfect;
		if (serverTemple.ObtainRobots.Count > 0)
		{
			for (int i = 0; i < serverTemple.ObtainRobots.Count; i++)
			{
				templeData.gotStars[i] = serverTemple.ObtainRobots[i] != 0;
			}
		}
		if (serverTemple.LastTeam != null)
		{
			templeData.lastTeamCharacterIds = new int[serverTemple.LastTeam.CharacterUsage.Count];
			for (int j = 0; j < serverTemple.LastTeam.CharacterUsage.Count; j++)
			{
				templeData.lastTeamCharacterIds[j] = serverTemple.LastTeam.CharacterUsage[j].CharacterId;
			}
			templeData.lastTeamPotionId = serverTemple.LastTeam.EquipPotionId;
		}
		MapField<int, int> selectedBuffs = serverTemple.SelectedBuffs;
		if (selectedBuffs != null && selectedBuffs.Count > 0 && templeData.staticData.type == 1)
		{
			templeData.battleTempleBuffMap = new Dictionary<int, int>(serverTemple.SelectedBuffs);
		}
	}

	protected override void UnInit()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UpdateAreaStarCount, UpdateAreaStartCount);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UpdateAreaRewardState, UpdateTempleRewardState);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.ServiceSave_Refresh, UpdateTempleStateObject);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BattleCharacterChange, OnBattleCharacterChange);
		BMapPool<int, List<TempleData>>.Default.Recycle(areaTempleDatas);
		BMapPool<int, Dictionary<int, bool>>.Default.Recycle(areaRewardDatas);
		BMapPool<int, int>.Default.Recycle(areaStarCount);
	}

	private void UpdateTempleStateObject(BaseEventContent obj)
	{
		if (MonoECS.instance.sceneStatus != SceneStatus.Temple)
		{
			return;
		}
		ServiceStateRefresh serviceStateRefresh = obj as ServiceStateRefresh;
		StateWorldAssetData worldStateAssetDataBySGOID = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(serviceStateRefresh.swid);
		if (worldStateAssetDataBySGOID == null)
		{
			return;
		}
		TempleData curChallengeTempleData = GetCurChallengeTempleData();
		if (curChallengeTempleData == null)
		{
			return;
		}
		int stateObjectType = worldStateAssetDataBySGOID.stateObjectType;
		if (CoreUtils.GetData(CurChallengeTempleId, RuntimeConfigs.data.instanceDungeons).boxType.Contains(stateObjectType))
		{
			if (worldStateAssetDataBySGOID.stateId == 1 && serviceStateRefresh.oldStateId == 0)
			{
				curChallengeTempleData.collectTreasureNum++;
				Singleton<EventManager>.instance.EventDispatch(ClientEvent.TempleInteractRefresh, null);
			}
		}
		else
		{
			if (stateObjectType != 18 || worldStateAssetDataBySGOID.stateId != 2)
			{
				return;
			}
			for (int i = 0; i < curChallengeTempleData.gotStars.Length; i++)
			{
				if (!curChallengeTempleData.gotStars[i])
				{
					curChallengeTempleData.gotStars[i] = true;
					MarkRobotReceived(i);
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.TempleInteractRefresh, null);
					break;
				}
			}
		}
	}

	public void UpdateData(int area, int templeId, bool complete)
	{
		if (areaTempleDatas.ContainsKey(area))
		{
			TempleData templeData = areaTempleDatas[area].FirstOrDefault((TempleData item) => item.templeId == templeId);
			if (templeData != null)
			{
				templeData.isComplate = complete;
			}
		}
	}

	private void UpdateAreaStartCount(BaseEventContent obj)
	{
		if (obj is AddAreaStartCountEvt addAreaStartCountEvt)
		{
			areaStarCount[addAreaStartCountEvt.AreaId] += addAreaStartCountEvt.AddStarCount;
		}
	}

	private void UpdateTempleRewardState(BaseEventContent obj)
	{
		UpdateAreaRewardEvt updateAreaRewardEvt = obj as UpdateAreaRewardEvt;
		if (!areaStarCount.ContainsKey(updateAreaRewardEvt.AreaId))
		{
			return;
		}
		int num = areaStarCount[updateAreaRewardEvt.AreaId] / 3;
		for (int i = 1; i <= num; i++)
		{
			int key = i * 3;
			if (!areaRewardDatas[updateAreaRewardEvt.AreaId].ContainsKey(key))
			{
				areaRewardDatas[updateAreaRewardEvt.AreaId][key] = false;
			}
			string redDotPathByAreaId = GetRedDotPathByAreaId(updateAreaRewardEvt.AreaId);
			if (!areaRewardDatas[updateAreaRewardEvt.AreaId][key])
			{
				if (string.IsNullOrEmpty(redDotPathByAreaId))
				{
					break;
				}
				if (!Singleton<RedDotManager>.instance.IsLeafNodeActive(redDotPathByAreaId))
				{
					Singleton<RedDotManager>.instance.SetLeafNodeActive(redDotPathByAreaId, active: true);
				}
			}
			else
			{
				Singleton<RedDotManager>.instance.SetLeafNodeActive(redDotPathByAreaId, active: false);
			}
		}
	}

	public void RefreshRedPoint()
	{
		foreach (KeyValuePair<int, int> item in areaStarCount)
		{
			int key = item.Key;
			int num = item.Value / 3;
			for (int i = 1; i <= num; i++)
			{
				int key2 = i * 3;
				if (!areaRewardDatas[key].ContainsKey(key2))
				{
					areaRewardDatas[key][key2] = false;
				}
				string redDotPathByAreaId = GetRedDotPathByAreaId(key);
				if (!areaRewardDatas[key][key2])
				{
					if (string.IsNullOrEmpty(redDotPathByAreaId))
					{
						return;
					}
					if (!Singleton<RedDotManager>.instance.IsLeafNodeActive(redDotPathByAreaId))
					{
						Singleton<RedDotManager>.instance.SetLeafNodeActive(redDotPathByAreaId, active: true);
					}
				}
				else
				{
					Singleton<RedDotManager>.instance.SetLeafNodeActive(redDotPathByAreaId, active: false);
				}
			}
		}
	}

	private string GetRedDotPathByAreaId(int areaId)
	{
		return areaId switch
		{
			1001 => RedDotPathDefine.ArsenalTempleReward, 
			1002 => RedDotPathDefine.ArumTempleReward, 
			1003 => RedDotPathDefine.SewerTempleReward, 
			1004 => RedDotPathDefine.TepcTempleReward, 
			1005 => RedDotPathDefine.VoidTempleReward, 
			1006 => RedDotPathDefine.CraterTempleReward, 
			1007 => RedDotPathDefine.WalkureTempleReward, 
			_ => "", 
		};
	}

	public int GetTempleActiveRobotCount(int templeId)
	{
		return GetTempleData(templeId)?.gotStars.Count((bool s) => s) ?? 0;
	}

	public int GetAreaTempleMaxStarCount(int area)
	{
		foreach (InstanceDungeonMap value in RuntimeConfigs.data.instanceDungeonMaps.Values)
		{
			if (value.areaId == area)
			{
				return value.maxStar;
			}
		}
		return 0;
	}

	public int GetCurAreaTempleStarCount(int areaId)
	{
		if (areaStarCount.TryGetValue(areaId, out var value))
		{
			return value;
		}
		return 0;
	}

	public List<int> GetLimitElements(int templeId)
	{
		HashSet<int> hashSet = new HashSet<int>();
		for (int i = 0; i < RuntimeConfigs.data.instanceDungeons[templeId].elementRestrictions.Length; i++)
		{
			int item = RuntimeConfigs.data.instanceDungeons[templeId].elementRestrictions[i];
			hashSet.Add(item);
		}
		return hashSet.ToList();
	}

	public List<ItemUnifierProxy> GetTempleRewardList(TempleData templeData)
	{
		List<ItemUnifierProxy> list = new List<ItemUnifierProxy>();
		foreach (ItemKv item2 in templeData.staticData.reward)
		{
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.id, item2.count);
			list.Add(item);
		}
		return list;
	}

	public List<int> GetLimitElements(TempleData templeData)
	{
		HashSet<int> hashSet = new HashSet<int>();
		for (int i = 0; i < templeData.staticData.elementRestrictions.Length; i++)
		{
			hashSet.Add(templeData.staticData.elementRestrictions[i]);
		}
		return hashSet.ToList();
	}

	public List<int> GetAllMapIds()
	{
		List<int> list = new List<int>();
		foreach (int key in RuntimeConfigs.data.mapAreas.Keys)
		{
			list.Add(key);
		}
		return list;
	}

	public int AllCompletedCount()
	{
		int num = 0;
		foreach (KeyValuePair<int, List<TempleData>> areaTempleData in areaTempleDatas)
		{
			num += Enumerable.Count(areaTempleData.Value, (TempleData data) => data.isComplate);
		}
		return num;
	}

	public async UniTask<int> GetTreasureBoxCount(int templeId)
	{
		if (!RuntimeConfigs.data.instanceDungeons.TryGetValue(templeId, out var value) || value.boxType.Length == 0)
		{
			return 0;
		}
		return GetTempleData(templeId)?.collectTreasureNum ?? 0;
	}

	public async UniTask<int> GetTotalTreasureBoxCount(int templeId)
	{
		if (!RuntimeConfigs.data.instanceDungeons.TryGetValue(templeId, out var instanceDungeon) || instanceDungeon.boxType.Length == 0)
		{
			return 0;
		}
		int boxCount = 0;
		if (MonoECS.instance.sceneStatus == SceneStatus.Temple)
		{
			for (int i = 0; i < instanceDungeon.boxType.Length; i++)
			{
				boxCount += Singleton<GameManager>.instance.worldManager.GetStateWorldAssetNumberByStateObjectType(instanceDungeon.boxType[i]);
			}
		}
		else
		{
			int config = RuntimeConfigs.data.gameWorlds[instanceDungeon.senceid].config;
			ILoadPartitionResult<ConfigWorldPartition_v2> loadPartitionResult = await WorldPartitionSetting.Data.TryLoadPartition(config, isMainWorld: false);
			if (loadPartitionResult.Success)
			{
				foreach (StateWorldAssetDataInfo<StateWorldAssetData> value in loadPartitionResult.Data.GetAllStateWorldAssetDataInPartition().Values)
				{
					for (int j = 0; j < instanceDungeon.boxType.Length; j++)
					{
						if (value.Data.stateObjectType == instanceDungeon.boxType[j])
						{
							boxCount++;
						}
					}
				}
			}
		}
		return boxCount;
	}

	public int[] GetTeamCharacterIds(int templeId)
	{
		int[] array = new int[3];
		TempleData templeData = GetTempleData(templeId);
		if (templeData?.lastTeamCharacterIds != null && templeData.lastTeamCharacterIds.Length != 0)
		{
			for (int i = 0; i < templeData.lastTeamCharacterIds.Length && i < array.Length; i++)
			{
				array[i] = templeData.lastTeamCharacterIds[i];
			}
		}
		else
		{
			RepeatedField<int> characterIds = G.localPlayer.teamInfo.PresetTeams[G.localPlayer.teamInfo.MainTeamIdx].CharacterIds;
			for (int j = 0; j < characterIds.Count && j < array.Length; j++)
			{
				array[j] = characterIds[j];
			}
		}
		for (int k = 0; k < array.Length; k++)
		{
			if (CheckCharacterElementIsLimit(templeId, array[k]))
			{
				array[k] = 0;
			}
		}
		return array;
	}

	public int GetTeamPotionId(int templeId)
	{
		TempleData templeData = GetTempleData(templeId);
		if ((templeData == null || (templeData != null && templeData.lastTeamPotionId == 0)) && Model<BloodBottleModel>.Interface.CurTeamEquipBottle != null)
		{
			return Model<BloodBottleModel>.Interface.CurTeamEquipBottle.id;
		}
		if (templeData != null && templeData.lastTeamPotionId != 0)
		{
			return templeData.lastTeamPotionId;
		}
		return 0;
	}

	public bool CheckCharacterElementIsLimit(int templeId, int characterId)
	{
		if (!RuntimeConfigs.data.entityCharacterDatas.TryGetValue(characterId, out var value))
		{
			return false;
		}
		if (!RuntimeConfigs.data.instanceDungeons.TryGetValue(templeId, out var value2))
		{
			return false;
		}
		for (int i = 0; i < value2.elementRestrictions.Length; i++)
		{
			if (value2.elementRestrictions[i] == value.mannerType)
			{
				return true;
			}
		}
		return false;
	}

	public void RecordChallengeInfo(StageChallengeTarget target)
	{
		_lastChallengeInfo = target;
	}

	public StageChallengeTarget GetChallengeInfo()
	{
		return _lastChallengeInfo;
	}

	public void AddBuffAfterEnterBattleTemple()
	{
		TempleData curChallengeTempleData = GetCurChallengeTempleData();
		if (curChallengeTempleData == null)
		{
			return;
		}
		Dictionary<int, int> battleTempleBuffMap = curChallengeTempleData.battleTempleBuffMap;
		if (battleTempleBuffMap == null || battleTempleBuffMap.Count <= 0 || curChallengeTempleData.staticData.type != 1)
		{
			return;
		}
		foreach (int value in curChallengeTempleData.battleTempleBuffMap.Values)
		{
			ApplyTempleBuffToBattleCharacter(value);
		}
	}

	public void RecordBattleTempleBuffSelection(int roomIndex, int buffId)
	{
		TempleData curTemple = GetCurChallengeTempleData();
		if (curTemple == null)
		{
			return;
		}
		G.service.SyncBattleTempleBuffSelection(roomIndex, buffId, (bool b) =>
		{
			if (b)
			{
				TempleData templeData = curTemple;
				if (templeData.battleTempleBuffMap == null)
				{
					templeData.battleTempleBuffMap = new Dictionary<int, int>();
				}
				curTemple.battleTempleBuffMap[roomIndex] = buffId;
				ApplyTempleBuffToBattleCharacter(buffId);
			}
		});
	}

	public void OpenBuffSelectViewAfterEnterWorld()
	{
		TempleData curChallengeTempleData = GetCurChallengeTempleData();
		if (curChallengeTempleData == null || curChallengeTempleData.staticData?.type != 1)
		{
			return;
		}
		foreach (StateWorldAssetData item in Singleton<GameManager>.instance.worldManager.FetchActiveWorldStateAssetDatas())
		{
			if (item is BattleTempleBuffGiveData battleTempleBuffGiveData && item.stateId == 1)
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEMPLEBUFFSELECT, new TempleBuffSelectViewData
				{
					swid = item.stateWorldAssetUid,
					templeId = _curChallengeTempleId,
					templeRoomIndex = battleTempleBuffGiveData.belongRoomIndex
				});
				break;
			}
		}
	}

	private void OnBattleCharacterChange(BaseEventContent obj)
	{
		TempleData curChallengeTempleData = GetCurChallengeTempleData();
		if (curChallengeTempleData == null)
		{
			return;
		}
		Dictionary<int, int> battleTempleBuffMap = curChallengeTempleData.battleTempleBuffMap;
		if (battleTempleBuffMap == null || battleTempleBuffMap.Count <= 0 || curChallengeTempleData.staticData.type != 1 || !(obj is BattleCharacterChangeEvt { lastEb: var lastEb, newEb: var newEb }))
		{
			return;
		}
		foreach (int value in curChallengeTempleData.battleTempleBuffMap.Values)
		{
			RemoveBattleTempleBuff(lastEb, value);
			ApplyTempleBuffToCharacter(newEb, value);
		}
	}

	public void ApplyBattleTempleBuffToTeam(List<int> buffIds)
	{
		List<Character> curTeamCharacters = CharacterDataHelper.GetCurTeamCharacters();
		if (curTeamCharacters == null || curTeamCharacters.Count <= 0)
		{
			return;
		}
		foreach (Character item in curTeamCharacters)
		{
			if (!EntityHelper.TryGetBattleEntityByCharacter(item, out var entity) || !entity.IsAlive())
			{
				continue;
			}
			CompAbility compAbility = entity.GetCompAbility();
			if (compAbility == null)
			{
				continue;
			}
			foreach (int buffId in buffIds)
			{
				if (buffId != 0)
				{
					SkillDetailData data = CoreUtils.GetData(buffId, RuntimeConfigs.data.skillDetailDatas);
					compAbility.AddAbility(entity, data.abilityName, AbilitySource.Ability, new MPSkill
					{
						id = data.id,
						level = 1
					}, 1);
				}
			}
		}
	}

	private void ApplyTempleBuffToCharacter(Entity eb, int buffId)
	{
		if (!eb.IsValid || !eb.IsAlive())
		{
			return;
		}
		CompAbility compAbility = eb.GetCompAbility();
		if (compAbility != null)
		{
			SkillDetailData data = CoreUtils.GetData(CoreUtils.GetData(buffId, RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas);
			if (data != null && !compAbility.TryGetAbility(data.abilityName, includeAdd: true, out var _))
			{
				compAbility.AddAbility(eb, data.abilityName, AbilitySource.Ability, new MPSkill
				{
					id = data.id,
					level = 1
				}, 1);
			}
		}
	}

	private void ApplyTempleBuffToBattleCharacter(int buffId)
	{
		if (buffId == 0)
		{
			return;
		}
		SkillDetailData data = CoreUtils.GetData(CoreUtils.GetData(buffId, RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas);
		if (data == null)
		{
			return;
		}
		Team teamInfo = TeamInfoExtension.GetTeamInfo();
		int battleEntityIndex = MonoECS.instance.battleEntityIndex;
		CharacterRepository curCharacterRepository = CharacterDataHelper.GetCurCharacterRepository();
		if (teamInfo == null || curCharacterRepository == null)
		{
			return;
		}
		int num = teamInfo.CharacterIds[battleEntityIndex];
		if (num > 0 && CharacterDataHelper.TryGetCharacter(curCharacterRepository, num, out var character) && EntityHelper.TryGetBattleEntityByCharacter(character, out var entity))
		{
			CompAbility compAbility = entity.GetCompAbility();
			if (compAbility != null && !compAbility.TryGetAbility(data.abilityName, includeAdd: true, out var _))
			{
				compAbility.AddAbility(entity, data.abilityName, AbilitySource.Ability, new MPSkill
				{
					id = data.id,
					level = 1
				}, 1);
			}
		}
	}

	private void ApplyBattleTempleBuffToTeam(int buffId)
	{
		if (buffId == 0)
		{
			return;
		}
		SkillDetailData data = CoreUtils.GetData(CoreUtils.GetData(buffId, RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas);
		if (data == null)
		{
			return;
		}
		List<Character> curTeamCharacters = CharacterDataHelper.GetCurTeamCharacters();
		if (curTeamCharacters == null || curTeamCharacters.Count <= 0)
		{
			return;
		}
		foreach (Character item in curTeamCharacters)
		{
			if (EntityHelper.TryGetBattleEntityByCharacter(item, out var entity) && entity.IsAlive())
			{
				CompAbility compAbility = entity.GetCompAbility();
				if (compAbility != null && !compAbility.TryGetAbility(data.abilityName, includeAdd: true, out var _))
				{
					compAbility.AddAbility(entity, data.abilityName, AbilitySource.Ability, new MPSkill
					{
						id = data.id,
						level = 1
					}, 1);
				}
			}
		}
	}

	private void RemoveBattleTempleBuff(Entity eb, int buffId)
	{
		if (buffId == 0 || !eb.IsValid || !eb.IsAlive())
		{
			return;
		}
		SkillDetailData data = CoreUtils.GetData(CoreUtils.GetData(buffId, RuntimeConfigs.data.skillGroupDatas).skillTotalIds[0], RuntimeConfigs.data.skillDetailDatas);
		if (data == null)
		{
			return;
		}
		Team teamInfo = TeamInfoExtension.GetTeamInfo();
		CharacterRepository curCharacterRepository = CharacterDataHelper.GetCurCharacterRepository();
		if (teamInfo != null && curCharacterRepository != null)
		{
			CompAbility compAbility = eb.GetCompAbility();
			if (compAbility != null && compAbility.TryGetAbility(data.abilityName, includeAdd: true, out var _))
			{
				compAbility.RemoveAbility(data.abilityName);
			}
		}
	}

	public void ClearBattleTempleBuffData()
	{
		TempleData templeData = GetTempleData(_curChallengeTempleId);
		if (templeData != null && templeData.staticData.type == 1)
		{
			Dictionary<int, int> battleTempleBuffMap = templeData.battleTempleBuffMap;
			if (battleTempleBuffMap != null && battleTempleBuffMap.Count > 0)
			{
				templeData.battleTempleBuffMap.Clear();
			}
		}
	}
}
