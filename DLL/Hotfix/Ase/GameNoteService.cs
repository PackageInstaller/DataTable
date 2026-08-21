using System;
using System.Collections.Generic;
using Cysharp.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class GameNoteService : IGameNoteService
{
	private List<long> timelineList;

	private List<long> branchTimelineList;

	private List<long> activityTimelineList;

	private List<long> monsterList;

	private List<long> collectionList;

	private Dictionary<int, Dictionary<string, bool>> heroRedPointDic;

	private Dictionary<string, RedPointSave> timelineRedPointDic;

	private Dictionary<string, RedPointSave> branchTimelineRedPointDic;

	private Dictionary<string, RedPointSave> versionTimelineRedPointDic;

	private Dictionary<string, RedPointSave> monsterRedPointDic;

	private Dictionary<string, RedPointSave> collectionRedPointDic;

	private Dictionary<string, RedPointSave> mapRedPointDic;

	private Dictionary<string, RedPointSave> cgRedPointDic;

	private Action<bool> gameNoteAction;

	private string keyName;

	public GameNoteService()
	{
		Init();
	}

	private void Init()
	{
		if (timelineRedPointDic == null)
		{
			timelineRedPointDic = new Dictionary<string, RedPointSave>();
		}
		if (branchTimelineRedPointDic == null)
		{
			branchTimelineRedPointDic = new Dictionary<string, RedPointSave>();
		}
		if (versionTimelineRedPointDic == null)
		{
			versionTimelineRedPointDic = new Dictionary<string, RedPointSave>();
		}
		if (monsterRedPointDic == null)
		{
			monsterRedPointDic = new Dictionary<string, RedPointSave>();
		}
		if (collectionRedPointDic == null)
		{
			collectionRedPointDic = new Dictionary<string, RedPointSave>();
		}
		if (mapRedPointDic == null)
		{
			mapRedPointDic = new Dictionary<string, RedPointSave>();
		}
		if (cgRedPointDic == null)
		{
			cgRedPointDic = new Dictionary<string, RedPointSave>();
		}
		if (heroRedPointDic == null)
		{
			heroRedPointDic = new Dictionary<int, Dictionary<string, bool>>();
		}
	}

	public async UniTask<bool> RequestGameNoteData()
	{
		Init();
		GetHandbookInfoRequest request = GetHandbookInfoRequest.Create();
		GetHandbookInfoResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetHandbookInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "图鉴", "获取图鉴信息失败"))
			{
				long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
				keyName = $"{uid}_GameNoteRedPoint";
				foreach (PbHandBookInfos handBookInfo in response.HandBookInfos)
				{
					switch (handBookInfo.Type)
					{
					case 1:
						timelineList = handBookInfo.UnlockIds;
						break;
					case 2:
						branchTimelineList = handBookInfo.UnlockIds;
						break;
					case 3:
						activityTimelineList = handBookInfo.UnlockIds;
						break;
					case 4:
						monsterList = handBookInfo.UnlockIds;
						break;
					case 5:
						collectionList = handBookInfo.UnlockIds;
						break;
					}
				}
				LoadLocalRedPointData();
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (GameFrameworkException)
		{
			return false;
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
		return false;
	}

	public async UniTask<bool> RequestGameNoteData(int type)
	{
		GetHandbookInfoRequest request = GetHandbookInfoRequest.Create();
		GetHandbookInfoResponse response = null;
		request.type = type;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetHandbookInfoResponse>(request);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "图鉴", "获取图鉴信息失败"))
			{
				long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
				keyName = $"{uid}_GameNoteRedPoint";
				foreach (PbHandBookInfos handBookInfo in response.HandBookInfos)
				{
					if (handBookInfo.Type == 5)
					{
						collectionList = handBookInfo.UnlockIds;
					}
				}
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (GameFrameworkException)
		{
			return false;
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
		return false;
	}

	public List<long> GetTimelineList()
	{
		return timelineList;
	}

	public List<long> GetBranchTimelineList()
	{
		return branchTimelineList;
	}

	public List<long> GetActivityTimelineList()
	{
		return activityTimelineList;
	}

	public List<long> GetMonsterList()
	{
		return monsterList;
	}

	public List<long> GetCollection()
	{
		return collectionList;
	}

	private void LoadLocalRedPointData()
	{
		DRTimeLineNote[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRTimeLineNote>();
		DRBranchTimeLineNote[] allDataRow2 = GameEntry.DataTable.GetAllDataRow<DRBranchTimeLineNote>();
		DRVersionTimeLineNote[] allDataRow3 = GameEntry.DataTable.GetAllDataRow<DRVersionTimeLineNote>();
		List<int> list = new List<int>();
		DRTimeLineNote[] array = allDataRow;
		foreach (DRTimeLineNote dRTimeLineNote in array)
		{
			if (UiConvert.BitwiseConvert.Bitwise(timelineList, dRTimeLineNote.Id - 1))
			{
				LoadRedPoint(1, dRTimeLineNote.Id);
				list.Add(dRTimeLineNote.TimeLineId);
			}
		}
		DRBranchTimeLineNote[] array2 = allDataRow2;
		foreach (DRBranchTimeLineNote dRBranchTimeLineNote in array2)
		{
			if (UiConvert.BitwiseConvert.Bitwise(branchTimelineList, dRBranchTimeLineNote.Id - 1))
			{
				LoadRedPoint(2, dRBranchTimeLineNote.Id);
				list.Add(dRBranchTimeLineNote.TimeLineId);
			}
		}
		DRVersionTimeLineNote[] array3 = allDataRow3;
		foreach (DRVersionTimeLineNote dRVersionTimeLineNote in array3)
		{
			if (UiConvert.BitwiseConvert.Bitwise(activityTimelineList, dRVersionTimeLineNote.Id - 1))
			{
				LoadRedPoint(3, dRVersionTimeLineNote.Id);
				list.Add(dRVersionTimeLineNote.TimeLineId);
			}
		}
		DRCGNote[] allDataRow4 = GameEntry.DataTable.GetAllDataRow<DRCGNote>();
		foreach (DRCGNote drCGNote in allDataRow4)
		{
			if (list.FindAll((int n) => n.Equals(drCGNote.OpenNum)).Count != 0)
			{
				LoadRedPoint(7, drCGNote.Id);
			}
		}
		foreach (HeroModel item in Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetAllHeroData().Values.ToList())
		{
			HeroFeelingChange(item.Id, item.FeelingLevel);
		}
		DRMonsterNote[] allDataRow5 = GameEntry.DataTable.GetAllDataRow<DRMonsterNote>();
		foreach (DRMonsterNote drMonster in allDataRow5)
		{
			if (monsterList != null && monsterList.Find((long n) => n.Equals(drMonster.Id)) > 0)
			{
				LoadRedPoint(4, drMonster.Id);
			}
		}
		DRCollectionNote[] allDataRow6 = GameEntry.DataTable.GetAllDataRow<DRCollectionNote>();
		foreach (DRCollectionNote dRCollectionNote in allDataRow6)
		{
			int checkId = dRCollectionNote.CollcetionId;
			if (dRCollectionNote.Type == 2)
			{
				LoadRedPoint(5, checkId);
			}
			else if (collectionList != null && collectionList.Find((long n) => n.Equals(checkId)) > 0)
			{
				LoadRedPoint(5, checkId);
			}
		}
		DRMapNote[] allDataRow7 = GameEntry.DataTable.GetAllDataRow<DRMapNote>();
		long maxCopyOpenIndex = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().MaxCopyOpenIndex;
		DRMapNote[] array4 = allDataRow7;
		foreach (DRMapNote drMapNote in array4)
		{
			if (drMapNote.MapOpen > maxCopyOpenIndex)
			{
				continue;
			}
			DRSceneryNote[] dataRows = GameEntry.DataTable.GetDataRows((DRSceneryNote p) => p.MapId == drMapNote.Id);
			foreach (DRSceneryNote drSceneryNote in dataRows)
			{
				if (drSceneryNote.OpenType != 1 || maxCopyOpenIndex < drSceneryNote.OpenNum)
				{
					continue;
				}
				LoadRedPoint(6, drSceneryNote.Id);
				DRNPCNote[] dataRows2 = GameEntry.DataTable.GetDataRows((DRNPCNote p) => p.SceneryId == drSceneryNote.Id);
				foreach (DRNPCNote dRNPCNote in dataRows2)
				{
					if (dRNPCNote.OpenType == 1 && maxCopyOpenIndex >= dRNPCNote.OpenNum)
					{
						LoadRedPoint(6, dRNPCNote.NpcId);
					}
				}
			}
		}
		foreach (RedPointSave value in timelineRedPointDic.Values)
		{
			if (value.isNew)
			{
				gameNoteAction?.Invoke(obj: true);
				return;
			}
		}
		foreach (RedPointSave value2 in branchTimelineRedPointDic.Values)
		{
			if (value2.isNew)
			{
				gameNoteAction?.Invoke(obj: true);
				return;
			}
		}
		foreach (RedPointSave value3 in versionTimelineRedPointDic.Values)
		{
			if (value3.isNew)
			{
				gameNoteAction?.Invoke(obj: true);
				return;
			}
		}
		foreach (RedPointSave value4 in monsterRedPointDic.Values)
		{
			if (value4.isNew)
			{
				gameNoteAction?.Invoke(obj: true);
				return;
			}
		}
		foreach (RedPointSave value5 in collectionRedPointDic.Values)
		{
			if (value5.isNew)
			{
				gameNoteAction?.Invoke(obj: true);
				return;
			}
		}
		foreach (RedPointSave value6 in mapRedPointDic.Values)
		{
			if (value6.isNew)
			{
				gameNoteAction?.Invoke(obj: true);
				return;
			}
		}
		foreach (RedPointSave value7 in cgRedPointDic.Values)
		{
			if (value7.isNew)
			{
				gameNoteAction?.Invoke(obj: true);
				return;
			}
		}
		foreach (Dictionary<string, bool> value8 in heroRedPointDic.Values)
		{
			foreach (bool value9 in value8.Values)
			{
				if (value9)
				{
					gameNoteAction?.Invoke(obj: true);
					return;
				}
			}
		}
	}

	private void LoadRedPoint(int type, int id)
	{
		string key = $"{keyName}_{type}_{id}";
		RedPointSave value = CreateRedPoint(type, id);
		switch (type)
		{
		case 1:
			timelineRedPointDic[key] = value;
			break;
		case 2:
			branchTimelineRedPointDic[key] = value;
			break;
		case 3:
			versionTimelineRedPointDic[key] = value;
			break;
		case 4:
			monsterRedPointDic[key] = value;
			break;
		case 5:
			collectionRedPointDic[key] = value;
			break;
		case 6:
			mapRedPointDic[key] = value;
			break;
		case 7:
			cgRedPointDic[key] = value;
			break;
		}
	}

	private RedPointSave CreateRedPoint(int type, int id)
	{
		RedPointSave obj = new RedPointSave
		{
			keyId = id,
			param1 = type
		};
		bool isNew = PlayerPrefs.GetInt($"{keyName}_{type}_{id}", 0) == 0;
		obj.isNew = isNew;
		return obj;
	}

	public void SaveRedPoint(int type, int id)
	{
		string key = $"{keyName}_{type}_{id}";
		PlayerPrefs.SetInt(key, 1);
		if (GetRedPointService(type).ContainsKey(key))
		{
			RedPointSave redPointSave = GetRedPointService(type)[key];
			redPointSave.isNew = false;
			GetRedPointService(type)[key] = redPointSave;
		}
	}

	public Dictionary<string, RedPointSave> GetRedPointService(int type)
	{
		return type switch
		{
			1 => timelineRedPointDic, 
			2 => branchTimelineRedPointDic, 
			3 => versionTimelineRedPointDic, 
			4 => monsterRedPointDic, 
			5 => collectionRedPointDic, 
			6 => mapRedPointDic, 
			7 => cgRedPointDic, 
			_ => timelineRedPointDic, 
		};
	}

	private void LoadHeroRedPoint(int heroId, int tabIndex, int id, Dictionary<string, bool> heroTabDic)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		string key = $"{uid}_{heroId}_{tabIndex}_{id}";
		bool value = PlayerPrefs.GetInt(key, 0) == 0;
		heroTabDic.TryAdd(key, value);
	}

	public bool LoadHeroRedPoint(int heroId, int tabIndex, int id)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		string key = $"{uid}_{heroId}_{tabIndex}_{id}";
		bool flag = PlayerPrefs.GetInt(key, 0) == 0;
		if (!heroRedPointDic.ContainsKey(heroId))
		{
			heroRedPointDic.Add(heroId, new Dictionary<string, bool>());
		}
		heroRedPointDic[heroId].TryAdd(key, flag);
		return flag;
	}

	public void SaveHeroRedPoint(int heroId, int tabIndex, int id)
	{
		long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().Uid;
		string key = $"{uid}_{heroId}_{tabIndex}_{id}";
		PlayerPrefs.SetInt(key, 1);
		if (heroRedPointDic.ContainsKey(heroId) && heroRedPointDic[heroId].ContainsKey(key))
		{
			heroRedPointDic[heroId][key] = false;
		}
	}

	public void SaveHeroRedPoint(int heroId)
	{
		if (!heroRedPointDic.TryGetValue(heroId, out var value))
		{
			return;
		}
		foreach (string item in value.Keys.ToList())
		{
			PlayerPrefs.SetInt(item, 1);
			heroRedPointDic[heroId][item] = false;
		}
	}

	private void HeroFeelingChange(int heroId, int feelingLevel)
	{
		Dictionary<string, bool> dictionary = new Dictionary<string, bool>();
		DRHeroTag[] dataRows = GameEntry.DataTable.GetDataRows((DRHeroTag p) => p.HeroId == heroId);
		foreach (DRHeroTag dRHeroTag in dataRows)
		{
			if (dRHeroTag.OpenType == 2)
			{
				if (dRHeroTag.OpenNum <= feelingLevel)
				{
					LoadHeroRedPoint(heroId, 0, dRHeroTag.Id, dictionary);
				}
			}
			else
			{
				LoadHeroRedPoint(heroId, 0, dRHeroTag.Id, dictionary);
			}
		}
		DRHeroStory[] dataRows2 = GameEntry.DataTable.GetDataRows((DRHeroStory p) => p.HeroId == heroId);
		foreach (DRHeroStory dRHeroStory in dataRows2)
		{
			if (dRHeroStory.OpenType == 2)
			{
				if (dRHeroStory.OpenNum <= feelingLevel)
				{
					LoadHeroRedPoint(heroId, 2, dRHeroStory.Id, dictionary);
				}
			}
			else
			{
				LoadHeroRedPoint(heroId, 2, dRHeroStory.Id, dictionary);
			}
		}
		DRHeroTreasure[] dataRows3 = GameEntry.DataTable.GetDataRows((DRHeroTreasure p) => p.HeroId == heroId);
		foreach (DRHeroTreasure dRHeroTreasure in dataRows3)
		{
			if (dRHeroTreasure.OpenType == 2)
			{
				if (dRHeroTreasure.OpenNum <= feelingLevel)
				{
					LoadHeroRedPoint(heroId, 6, dRHeroTreasure.Id, dictionary);
				}
			}
			else
			{
				LoadHeroRedPoint(heroId, 6, dRHeroTreasure.Id, dictionary);
			}
		}
		DRHeroDetails[] dataRows4 = GameEntry.DataTable.GetDataRows((DRHeroDetails p) => p.HeroId == heroId);
		foreach (DRHeroDetails dRHeroDetails in dataRows4)
		{
			if (dRHeroDetails.OpenType == 2)
			{
				if (dRHeroDetails.OpenNum <= feelingLevel)
				{
					LoadHeroRedPoint(heroId, 1, dRHeroDetails.Id, dictionary);
				}
			}
			else
			{
				LoadHeroRedPoint(heroId, 1, dRHeroDetails.Id, dictionary);
			}
		}
		DRHeroCG[] dataRows5 = GameEntry.DataTable.GetDataRows((DRHeroCG p) => p.HeroId == heroId);
		_ = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.CharacterIndex;
		DRHeroCG[] array = dataRows5;
		foreach (DRHeroCG dRHeroCG in array)
		{
			DRCGNote drcgNote = GameEntry.DataTable.GetDataRow<DRCGNote>(dRHeroCG.CGId);
			if (drcgNote == null)
			{
				continue;
			}
			DRTimeLineNote dataRow = GameEntry.DataTable.GetDataRow((DRTimeLineNote p) => p.TimeLineId == drcgNote.OpenNum);
			if (dataRow == null || UiConvert.BitwiseConvert.Bitwise(timelineList, dataRow.Id - 1))
			{
				DRBranchTimeLineNote dataRow2 = GameEntry.DataTable.GetDataRow((DRBranchTimeLineNote p) => p.TimeLineId == drcgNote.OpenNum);
				if (dataRow2 == null || UiConvert.BitwiseConvert.Bitwise(branchTimelineList, dataRow2.Id - 1) || UiConvert.BitwiseConvert.Bitwise(activityTimelineList, dataRow2.Id - 1))
				{
					LoadHeroRedPoint(heroId, 5, drcgNote.Id, dictionary);
				}
			}
		}
		heroRedPointDic[heroId] = dictionary;
	}

	public void AddRedPointAction(Action<bool> action)
	{
		gameNoteAction = action;
	}

	public Dictionary<int, Dictionary<string, bool>> GetHeroRedPoint()
	{
		return heroRedPointDic;
	}
}
