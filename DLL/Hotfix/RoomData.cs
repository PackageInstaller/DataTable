#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.IO;
using Ase;
using Ase.Editors;
using Cysharp.Threading.Tasks;
using GameFramework;
using Newtonsoft.Json;
using UnityEngine;

public class RoomData
{
	public string RoomId;

	public List<VerificationPlayerData> PlayerDataList = new List<VerificationPlayerData>();

	private DataStorageOss _dataStorage;

	private string _lockStepDirectoryPath;

	private string _gameDataDirectoryPath;

	private GameVerificationViewModel _verificationViewModel;

	public float Progress;

	private const string BattlePlayerDataSuffix = "-FightGlobalInfo.txt";

	private const string BattleTickDataSuffix = "-FightFrameDataInfo.txt";

	private GameBackWorld _world;

	private RoomData()
	{
	}

	public static RoomData Create(string roomId, GameVerificationViewModel gameVerificationViewModel, DataStorageOss dataStorage, string lockStepDirectoryPath, string gameDataDirectoryPath)
	{
		return new RoomData
		{
			_verificationViewModel = gameVerificationViewModel,
			RoomId = roomId,
			_dataStorage = dataStorage,
			_gameDataDirectoryPath = gameDataDirectoryPath,
			_lockStepDirectoryPath = lockStepDirectoryPath
		};
	}

	public void DownLoadPlayerFile()
	{
		foreach (VerificationPlayerData playerData in PlayerDataList)
		{
			DownLoadPlayerFile(playerData.DownloadFullPath, playerData.RemoveDownloadFullPath);
		}
	}

	private void DownLoadPlayerFile(string downLoadFullPath, string removeDownLoadPath)
	{
		if (!Directory.Exists(_lockStepDirectoryPath + "/" + RoomId))
		{
			Directory.CreateDirectory(_lockStepDirectoryPath + "/" + RoomId);
		}
		string text = _lockStepDirectoryPath + "/" + RoomId + "/" + downLoadFullPath;
		if (File.Exists(text))
		{
			Debug.Log("文件夹已经下载");
			return;
		}
		_dataStorage.GetObject(removeDownLoadPath, text, "lockstepdata");
		FileStream fileStream = File.Open(text, FileMode.Open);
		byte[] array = new byte[fileStream.Length];
		fileStream.Read(array, 0, array.Length);
		fileStream.Close();
		byte[] array2 = CLZF2.Decompress(array);
		using FileStream fileStream2 = File.Open(text, FileMode.Create);
		fileStream2.Write(array2, 0, array2.Length);
	}

	public void DownloadRoomData()
	{
		if (!Directory.Exists(_gameDataDirectoryPath + "/" + RoomId))
		{
			Directory.CreateDirectory(_gameDataDirectoryPath + "/" + RoomId);
		}
		string downloadFileName = _gameDataDirectoryPath + "/" + RoomId + "/-FightGlobalInfo.txt";
		string objectName = RoomId + "/" + RoomId + "-FightGlobalInfo.txt";
		string downloadFileName2 = _gameDataDirectoryPath + "/" + RoomId + "/-FightFrameDataInfo.txt";
		string objectName2 = RoomId + "/" + RoomId + "-FightFrameDataInfo.txt";
		_dataStorage.GetObject(objectName, downloadFileName, "battle-verification");
		_dataStorage.GetObject(objectName2, downloadFileName2, "battle-verification");
	}

	private List<GlobalBattleFrame> ReadBattleCommandFile(string readPath)
	{
		if (!File.Exists(readPath))
		{
			Debug.Log("读取回放数据错误: 未找到回放数据!");
			return null;
		}
		try
		{
			StreamReader streamReader = new StreamReader(readPath);
			string value = streamReader.ReadToEnd();
			streamReader.Close();
			return JsonConvert.DeserializeObject<List<GlobalBattleFrame>>(value);
		}
		catch (Exception ex)
		{
			Debug.Log("读取回放数据错误 ： " + ex.Message);
			return null;
		}
	}

	private GetBattleFieldUserFightInfoResponse ReadRoomData(string readPath)
	{
		if (!File.Exists(readPath))
		{
			Debug.Log("读取回放玩家数据错误: 未找到回放玩家数据!");
			return null;
		}
		try
		{
			StreamReader streamReader = new StreamReader(readPath);
			string value = streamReader.ReadToEnd();
			streamReader.Close();
			return JsonConvert.DeserializeObject<GetBattleFieldUserFightInfoResponse>(value);
		}
		catch (Exception ex)
		{
			Debug.Log("读取回放玩家数据错误 ： " + ex.Message);
			return null;
		}
	}

	private string GetBattlePlayerFullPath(string roomId)
	{
		return _gameDataDirectoryPath + "/" + roomId + "/-FightGlobalInfo.txt";
	}

	private string GetBattleTickDataFullPath(string roomId)
	{
		return _gameDataDirectoryPath + "/" + roomId + "/-FightFrameDataInfo.txt";
	}

	public string GetSingleBattlePlayerFullPath(string roomId)
	{
		return _lockStepDirectoryPath + "/" + roomId + "/" + roomId + "-FightGlobalInfo.txt";
	}

	public string GetSingleBattleTickDataFullPath(string roomId)
	{
		return _lockStepDirectoryPath + "/" + roomId + "/" + roomId + "-FightFrameDataInfo.txt";
	}

	public SingleCopyFightSyncCheckInfo ReadSinglePlayerFile(string readPath)
	{
		if (!File.Exists(readPath))
		{
			Debug.Log("读取回放玩家数据错误: 未找到回放玩家数据!");
			return null;
		}
		try
		{
			StreamReader streamReader = new StreamReader(readPath);
			string value = streamReader.ReadToEnd();
			streamReader.Close();
			return JsonConvert.DeserializeObject<SingleCopyFightSyncCheckInfo>(value);
		}
		catch (Exception ex)
		{
			Debug.Log("读取回放玩家数据错误 ： " + ex.Message);
			return null;
		}
	}

	public List<TeamMember> CreateHero(SingleCopyFightSyncCheckInfo message, CopyData copyData)
	{
		Dictionary<int, HeroModel> dictionary = new Dictionary<int, HeroModel>();
		for (int i = 0; i < message.roleInfos.Count; i++)
		{
			WeaponData heldWeapon = WeaponData.CreateEmpty();
			PbRoomRoleInfo pbRoomRoleInfo = message.roleInfos[i];
			if (pbRoomRoleInfo.Weapon != null)
			{
				heldWeapon = CreateWeapon(pbRoomRoleInfo.Weapon);
			}
			Dictionary<int, ArmourData> dictionary2 = new Dictionary<int, ArmourData>();
			if (pbRoomRoleInfo.Armours != null)
			{
				foreach (PbEquipBase armour in pbRoomRoleInfo.Armours)
				{
					ArmourData armourData = CreateArmour(armour);
					if (armourData != null)
					{
						dictionary2.Add((int)armourData.ArmourEnum, armourData);
					}
				}
			}
			if (pbRoomRoleInfo.Suitbox != null)
			{
				ArmourData armourData2 = CreateArmour(pbRoomRoleInfo.Suitbox);
				if (armourData2 != null)
				{
					dictionary2.Add((int)armourData2.ArmourEnum, armourData2);
				}
			}
			Dictionary<int, HCTalentData> dictionary3 = new Dictionary<int, HCTalentData>();
			foreach (PbRoleTalent talent in pbRoomRoleInfo.Talents)
			{
				dictionary3.Add(talent.SkillId, HCTalentData.Create(talent.SkillId, talent.SkillLevel, talent.MaxOrderId));
			}
			Dictionary<int, int> dictionary4 = new Dictionary<int, int>();
			for (int j = 0; j < pbRoomRoleInfo.SkillSkinIds.Count; j++)
			{
				dictionary4.Add(pbRoomRoleInfo.SkillSkinIds[j].Id, pbRoomRoleInfo.SkillSkinIds[j].Value);
			}
			HeroModel heroModel = HeroModel.CreateMulti(pbRoomRoleInfo.RoleId, 0, pbRoomRoleInfo.Star, pbRoomRoleInfo.Level, 0L, dictionary4, heldWeapon, dictionary2, dictionary3, pbRoomRoleInfo.SeatLevel);
			heroModel.AddBPData(GetBPCarryings(message.BattleProp));
			heroModel.ResetOuterBuff();
			dictionary.Add(i, heroModel);
			if (message.unionId != 0L)
			{
				heroModel.AddGuildBaseBuff();
			}
			bool isFirst = message.isFirst;
			if (copyData != null && ((copyData.IsNeedFirst && !isFirst) || !copyData.IsNeedFirst))
			{
				heroModel.AddOuterBuff(OuterBuffEnum.CopyFirstAccessBuff, copyData.CopyBuff);
			}
		}
		List<TeamMember> list = new List<TeamMember>();
		for (int k = 0; k < dictionary.Count; k++)
		{
			HeroModel heroModel2 = dictionary[k];
			TeamMember item = TeamMember.CreateMultiRecord(k, message.roomId.ToString(), message.roleInfos[k].RoleId, k == 0, heroModel2, message.userId, message.unionId, message.isFirst, 0, k == 0);
			list.Add(item);
		}
		return list;
	}

	private async UniTask<PreloadBattleData> CheckPreloadGameData(BattleWorldData battleWorldData)
	{
		GamePreload gamePreload = new GamePreload(null);
		PreloadBattleData battleData = new PreloadBattleData();
		if (battleWorldData == null)
		{
			Log.Error("预加载失败：缺少 battleWorldData");
			return null;
		}
		if (battleWorldData.TeamListConfig == null)
		{
			Log.Error("预加载失败：缺少队伍信息！");
			return null;
		}
		List<int> list = new List<int>();
		for (int i = 0; i < battleWorldData.TeamListConfig.Count; i++)
		{
			list.Add(battleWorldData.TeamListConfig[i].Id);
		}
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		for (int j = 0; j < battleWorldData.TeamListConfig.Count; j++)
		{
			PeripheryHeroData peripheryHeroData = battleWorldData.TeamListConfig[j];
			if (peripheryHeroData.PropsData == null)
			{
				continue;
			}
			foreach (BattleProps value2 in peripheryHeroData.PropsData.Values)
			{
				if (value2 != null)
				{
					int num = Math.Max(value2.CarryPropNumber, 1);
					if (dictionary.TryGetValue(value2.Id, out var _))
					{
						dictionary[value2.Id] += num;
					}
					else
					{
						dictionary[value2.Id] = num;
					}
				}
			}
		}
		List<int> list2 = new List<int>();
		list2.Add(battleWorldData.BossId);
		if (battleWorldData is ActivityBattleWorldData activityBattleWorldData)
		{
			for (int k = 0; k < activityBattleWorldData.Monsters.Count; k++)
			{
				list2.Add(activityBattleWorldData.Monsters[k]);
			}
		}
		if (await gamePreload.CheckGameAsset(battleWorldData.TeamListConfig, battleWorldData.CopyId, list2, dictionary, 0, battleData))
		{
			await gamePreload.LoadGameBackAsset(battleData);
			battleWorldData.PreloadBattleData = battleData;
		}
		return battleData;
	}

	public async UniTask<bool> StartVerification()
	{
		SingleCopyFightSyncCheckInfo singleCopyFightSyncCheckInfo = ReadSinglePlayerFile(GetSingleBattlePlayerFullPath(RoomId));
		if (singleCopyFightSyncCheckInfo == null)
		{
			Log.Error("回放 战斗信息为空 GetBattleFieldUserFightInfoResponse");
			return false;
		}
		CopyData copyData = CreateCopyData(singleCopyFightSyncCheckInfo.copyId);
		if (copyData == null)
		{
			Log.Error($"找不到 副本 {singleCopyFightSyncCheckInfo.copyId} 重连失败");
			return false;
		}
		Game.AddSingleton<GameSystem>();
		Game.AddSingleton<OuterSystem>();
		List<TeamMember> list = CreateHero(singleCopyFightSyncCheckInfo, copyData);
		List<PeripheryHeroData> list2 = new List<PeripheryHeroData>();
		for (int i = 0; i < list.Count; i++)
		{
			list2.Add(list[i].GetPeripheryHeroData());
		}
		List<GlobalBattleFrame> globalBattleFrameList = ReadBattleCommandFile(GetSingleBattleTickDataFullPath(RoomId));
		WorldData worldData = GameBackWorldData.CreateGameBackWorldData(0u, copyData.SceneName, copyData.Id, copyData.GetBossId(0), copyData.MapData, copyData.NavMeshId, list2, null, singleCopyFightSyncCheckInfo.seed, 0, globalBattleFrameList);
		worldData.RoomId = singleCopyFightSyncCheckInfo.roomId;
		await CheckPreloadGameData(worldData as GameBackWorldData);
		worldData.WorldId = Singleton<GameSystem>.Instance.GenerateWorldId();
		uint worldId = await Singleton<GameSystem>.Instance.CreateBattleVerificationWorldChannel(WorldType.GameBackSingle, worldData);
		Singleton<GameSystem>.Instance.WorldStart(worldId);
		WorldBase worldBase = Singleton<GameSystem>.Instance.GetWorldChannel(worldId);
		await UniTask.WaitUntil(() => worldBase.BattleSettlement);
		Debug.LogError("战斗结果: " + worldBase.GameBackResult.ToJson());
		return true;
	}

	public CopyData CreateCopyData(int copyId)
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyId);
		if (dataRow == null)
		{
			return null;
		}
		return CopyData.CreateTemp(dataRow);
	}

	public List<TeamMember> CreateHero(GetBattleFieldUserFightInfoResponse message, CopyData copyData, long selfUid, out int selfIndex)
	{
		selfIndex = 0;
		Dictionary<int, HeroModel> dictionary = new Dictionary<int, HeroModel>();
		for (int i = 0; i < message.Users.Count; i++)
		{
			WeaponData heldWeapon = WeaponData.CreateEmpty();
			PbRoomRoleInfo role = message.Users[i].Role;
			if (role.Weapon != null)
			{
				heldWeapon = CreateWeapon(role.Weapon);
			}
			Dictionary<int, ArmourData> dictionary2 = new Dictionary<int, ArmourData>();
			if (role.Armours != null)
			{
				foreach (PbEquipBase armour in role.Armours)
				{
					ArmourData armourData = CreateArmour(armour);
					if (armourData != null)
					{
						dictionary2.Add((int)armourData.ArmourEnum, armourData);
					}
				}
			}
			if (role.Suitbox != null)
			{
				ArmourData armourData2 = CreateArmour(role.Suitbox);
				if (armourData2 != null)
				{
					dictionary2.Add((int)armourData2.ArmourEnum, armourData2);
				}
			}
			Dictionary<int, HCTalentData> dictionary3 = new Dictionary<int, HCTalentData>();
			foreach (PbRoleTalent talent in role.Talents)
			{
				dictionary3.Add(talent.SkillId, HCTalentData.Create(talent.SkillId, talent.SkillLevel, talent.MaxOrderId));
			}
			Dictionary<int, int> dictionary4 = new Dictionary<int, int>();
			for (int j = 0; j < role.SkillSkinIds.Count; j++)
			{
				dictionary4.Add(role.SkillSkinIds[j].Id, role.SkillSkinIds[j].Value);
			}
			HeroModel heroModel = HeroModel.CreateMulti(role.RoleId, 0, role.Star, role.Level, 0L, dictionary4, heldWeapon, dictionary2, dictionary3, role.SeatLevel);
			heroModel.AddBPData(GetBPCarryings(message.Users[i].BattleProp));
			dictionary.Add(i, heroModel);
			if (selfUid == message.Users[i].UserId)
			{
				selfIndex = i;
			}
		}
		foreach (KeyValuePair<int, HeroModel> item2 in dictionary)
		{
			item2.Value.ResetOuterBuff();
		}
		foreach (KeyValuePair<int, HeroModel> item3 in dictionary)
		{
			int key = item3.Key;
			_ = message.Users[key].SeatId;
			_ = message.Users[key].UserBaseInfo.Name;
			long unionId = message.Users[key].UnionId;
			if (unionId != 0L)
			{
				bool flag = false;
				for (int k = 0; k < message.Users.Count; k++)
				{
					if (key != k && message.Users[k].UnionId != 0L && unionId == message.Users[k].UnionId)
					{
						item3.Value.AddGuildTeammateBuff();
						flag = true;
					}
				}
				if (!flag)
				{
					item3.Value.AddGuildBaseBuff();
				}
			}
			bool isFirst = message.Users[key].UserBaseInfo.IsFirst;
			if (copyData != null && ((copyData.IsNeedFirst && !isFirst) || !copyData.IsNeedFirst))
			{
				item3.Value.AddOuterBuff(OuterBuffEnum.CopyFirstAccessBuff, copyData.CopyBuff);
			}
		}
		List<TeamMember> list = new List<TeamMember>();
		foreach (KeyValuePair<int, HeroModel> item4 in dictionary)
		{
			int key2 = item4.Key;
			TeamMember item = TeamMember.CreateMultiRecord(message.Users[key2].SeatId, message.Users[key2].UserBaseInfo.Name, message.Users[key2].UserBaseInfo.Icon, message.Users[key2].SeatId == 1, item4.Value, message.Users[key2].UserId, message.Users[key2].UnionId, message.Users[key2].UserBaseInfo.IsFirst, message.Difficult, message.Users[key2].UserId == selfUid);
			list.Add(item);
		}
		return list;
	}

	public WeaponData CreateWeapon(PbEquipBase weapon)
	{
		return WeaponData.CreateWeaponData(ConvertEquipmentDataBase(weapon));
	}

	public ArmourData CreateArmour(PbEquipBase armour)
	{
		EquipBase equipBase = ConvertEquipmentDataBase(armour);
		if (armour.Type != 2)
		{
			return ArmourData.CreateSuitBox(equipBase);
		}
		return ArmourData.CreateArmourData(equipBase);
	}

	private EquipBase ConvertEquipmentDataBase(PbEquipBase pbEquipBase)
	{
		EquipBase result = new EquipBase
		{
			Type = pbEquipBase.Type,
			EquipId = pbEquipBase.EquipId,
			Uuid = pbEquipBase.Uuid,
			RoleId = pbEquipBase.RoleId,
			Level = pbEquipBase.Level,
			Exp = pbEquipBase.Exp,
			Locked = pbEquipBase.Locked,
			Star = pbEquipBase.Star,
			Refine = pbEquipBase.Refine,
			Rank = pbEquipBase.Rank,
			SubType = pbEquipBase.SubType,
			AttributeBaseList = ConvertAttributeBaseList(pbEquipBase.Attribute),
			EntryBaseList = ConvertEntryBaseList(pbEquipBase.Entries),
			BackUpEntryList = new List<EntryBase>()
		};
		foreach (PbEntryBase cacheEntry in pbEquipBase.CacheEntries)
		{
			EntryBase item = default(EntryBase);
			if (cacheEntry == null)
			{
				item.Id = 0;
			}
			else
			{
				item.Id = cacheEntry.Id;
				item.Level = cacheEntry.Level;
			}
			result.BackUpEntryList.Add(item);
		}
		return result;
	}

	private List<AttributeBase> ConvertAttributeBaseList(List<PbAttributeBase> equipAttributeBase)
	{
		List<AttributeBase> list = new List<AttributeBase>();
		foreach (PbAttributeBase item in equipAttributeBase)
		{
			list.Add(new AttributeBase
			{
				Id = item.Id,
				Value = item.Value
			});
		}
		return list;
	}

	private List<EntryBase> ConvertEntryBaseList(List<PbEntryBase> pbEntryBaseList)
	{
		List<EntryBase> list = new List<EntryBase>();
		foreach (PbEntryBase pbEntryBase in pbEntryBaseList)
		{
			if (pbEntryBase != null)
			{
				list.Add(new EntryBase
				{
					Id = pbEntryBase.Id,
					Level = pbEntryBase.Level
				});
			}
		}
		return list;
	}

	public Dictionary<int, BPData> GetBPCarryings(List<PbRoomBattlePropInfo> battlePropInfos)
	{
		Dictionary<int, BPData> dictionary = new Dictionary<int, BPData>();
		BPData value = null;
		BPData value2 = null;
		if (battlePropInfos.Count >= 1 && battlePropInfos[0].Id != 0)
		{
			value = BPData.Create(GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.TeamId == battlePropInfos[0].Id && p.Lev == battlePropInfos[0].Level), isLock: false, battlePropInfos[0].Count);
		}
		if (battlePropInfos.Count >= 2 && battlePropInfos[1].Id != 0)
		{
			value2 = BPData.Create(GameEntry.DataTable.GetDataRow((DRBattlePropInfo p) => p.TeamId == battlePropInfos[1].Id && p.Lev == battlePropInfos[1].Level), isLock: false, battlePropInfos[1].Count);
		}
		dictionary.Add(1, value);
		dictionary.Add(2, value2);
		return dictionary;
	}

	public void UpdateData()
	{
	}

	public void DelRoomData()
	{
		List<string> list = new List<string>();
		for (int i = 0; i < PlayerDataList.Count; i++)
		{
			list.Add(PlayerDataList[i].RemoveDownloadFullPath);
		}
		_dataStorage.Del("lockstepdata", list);
		_verificationViewModel.DelRoom(RoomId);
	}
}
