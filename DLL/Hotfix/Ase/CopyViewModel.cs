#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Pool;

namespace Ase;

public class CopyViewModel : ViewModelBase
{
	private List<CopyEntryData> copyEntryData;

	private ISubscription<SOOpenNotifyMessager> subscription_SONotify;

	private int copyPermitLevel;

	private int copyType3CurId;

	private long copyType3CurTimeLeft;

	private readonly Dictionary<CopyType3Mode, CopyType3CurrentData> type3ModeDatas = new Dictionary<CopyType3Mode, CopyType3CurrentData>();

	private List<CopyMainData> mainDataList = new List<CopyMainData>();

	private List<CopyPermitData> permitDataList = new List<CopyPermitData>();

	private Dictionary<int, CopyData> copyDatas = new Dictionary<int, CopyData>();

	private Dictionary<int, TowerTalentViewModel> towerTalentData = new Dictionary<int, TowerTalentViewModel>(24);

	private TowerRogueData towerRogueData = new TowerRogueData();

	private int t3Score;

	private int t3ConsumeCount;

	private bool isInitCopyMain1;

	private bool isInitCopyMain2;

	private bool isInitCopyMain3;

	private bool isInitCopyMain4;

	private bool isInitCopyMain5;

	private Dictionary<int, int> accessCopys;

	private HashSet<int> accessCopyIds;

	public Action type3RefreshAction;

	public Action<long> typeRefreshAction;

	private Action<bool> permitAction;

	private Dictionary<int, CopyType4TeamConfig> teamConfigs;

	private Dictionary<int, Dictionary<int, bool>> t4RewardState;

	private Dictionary<int, int> t4StarCount;

	private int t4Zone = 1;

	private List<CopyType4TeamConfig> type4ReturnCopy;

	private Dictionary<int, bool> t5RewardState;

	private Dictionary<int, int> t5CopySelectSave;

	private int t5Zone = 601;

	private long t5Score;

	private Dictionary<int, CopyType5Team> type5TeamConfigs;

	private Timer copyTimer;

	private int interval = 2;

	private long serverTime = -1L;

	private Dictionary<int, CopyRedData> copyRedDataDics;

	private List<CopyRedData> redDatas;

	private Dictionary<int, int> sortDatas;

	private CopyUnlockSaveData saveData;

	private Dictionary<int, CopyData> activityTryCopys;

	private Dictionary<int, List<CopyData>> activityVersionCopys;

	private Dictionary<int, List<CopyData>> activityChallengeCopys;

	private Dictionary<int, CopyData> activityEquipCopys;

	private DRTowerTalent[] drTowerTalents;

	private int towerCopyType = -1;

	public Dictionary<int, CopyType5Team> Type5TeamConfigs => type5TeamConfigs;

	public List<CopyPermitData> PermitDataList => permitDataList;

	public List<CopyMainData> MainDataList => mainDataList;

	public long CopyType3CurTimeLeft => copyType3CurTimeLeft;

	public int CopyType3CurId => copyType3CurId;

	public int T3ConsumeCount
	{
		get
		{
			return t3ConsumeCount;
		}
		private set
		{
			t3ConsumeCount = value;
		}
	}

	public int CopyPermitLevel => copyPermitLevel;

	public int T3Score => t3Score;

	public int T5Zone => GetT5Zone();

	public Dictionary<int, bool> T5RewardState => t5RewardState;

	public bool IsInitCopyMain5 => isInitCopyMain5;

	public bool IsInitCopyMain1 => isInitCopyMain1;

	public List<CopyEntryData> CopyEntryDatas => copyEntryData;

	public Dictionary<int, int> SortDatas => GetSortDatas();

	public Dictionary<int, TowerTalentViewModel> TowerTalentViewModels => towerTalentData;

	public int TowerCopyType => towerCopyType;

	public CopyViewModel()
	{
		copyEntryData = new List<CopyEntryData>();
		copyEntryData.Add(new CopyEntryData(1, red: false));
		copyEntryData.Add(new CopyEntryData(2, red: false));
		copyEntryData.Add(new CopyEntryData(0, red: false));
		subscription_SONotify = Context.GetApplicationContext().GetService<IMessenger>().Subscribe<SOOpenNotifyMessager>(OnSystemOpen);
		Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.AddDailyUpdateAction(OnDailyUpdated);
	}

	private void OnDailyUpdated()
	{
		try
		{
			long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>()?.GetCurServerTime() ?? 0;
			if (mainDataList == null)
			{
				return;
			}
			for (int i = 0; i < mainDataList.Count; i++)
			{
				foreach (KeyValuePair<int, CopyTypeData> item in mainDataList[i].CopyTypeOpenDic)
				{
					item.Value.UpdateServerTime(curServerTime);
				}
			}
		}
		catch (Exception)
		{
		}
	}

	private void OnSystemOpen(SOOpenNotifyMessager messager)
	{
		if (messager.serviceId == 70019 && messager.state)
		{
			GetCopyMainById(1).SetLock(isSystemOpen: true);
		}
		if (messager.serviceId == 70010 && messager.state)
		{
			GetCopyMainById(2).SetLock(isSystemOpen: true);
		}
		if (messager.serviceId == 70016 && messager.state)
		{
			GetCopyMainById(3).SetLock(isSystemOpen: true);
		}
		if (messager.serviceId == 70017 && messager.state)
		{
			GetCopyMainById(4).SetLock(isSystemOpen: true);
		}
		if (messager.serviceId == 70018 && messager.state)
		{
			GetCopyMainById(5).SetLock(isSystemOpen: true);
		}
	}

	public int GetServiceId(CopyMainData mainData)
	{
		return mainData.MainId switch
		{
			1 => 70019, 
			2 => 70010, 
			3 => 70016, 
			4 => 70017, 
			5 => 70018, 
			_ => 0, 
		};
	}

	public void UpdateAccessCopys(int permitLevel, Dictionary<int, int> accessCopys, HashSet<int> accessCopyIds = null)
	{
		try
		{
			if (this.accessCopys != null)
			{
				return;
			}
			copyPermitLevel = permitLevel;
			this.accessCopys = accessCopys;
			this.accessCopyIds = accessCopyIds;
			long curServerTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
			int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
			long maxCopyOpenIndex = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().MaxCopyOpenIndex;
			DRCopyMain[] mainCopies = GameEntry.DataTable.GetAllDataRow<DRCopyMain>();
			int i;
			for (i = 0; i < mainCopies.Length; i++)
			{
				DRCopyType[] dataRows = GameEntry.DataTable.GetDataRows((DRCopyType p) => p.MainCopyId == mainCopies[i].Id);
				Dictionary<int, CopyTypeData> dictionary = new Dictionary<int, CopyTypeData>();
				int num = 0;
				if (mainCopies[i].Id == 2)
				{
					for (int num2 = 0; num2 < dataRows.Length; num2++)
					{
						if (accessCopys.ContainsKey(dataRows[num2].Id))
						{
							num = Mathf.Max(accessCopys[dataRows[num2].Id], num);
						}
					}
				}
				for (int num3 = 0; num3 < dataRows.Length; num3++)
				{
					if (dataRows[num3].MainCopyId == 7 || dataRows[num3].MainCopyId == 8)
					{
						continue;
					}
					CopyTypeData typeData = CopyTypeData.Create(dataRows[num3], level, permitLevel, maxCopyOpenIndex, curServerTime);
					dictionary.Add(dataRows[num3].Id, typeData);
					int num4 = 0;
					if (mainCopies[i].Id == 2)
					{
						num4 = num;
					}
					else if (accessCopys.ContainsKey(dataRows[num3].Id))
					{
						num4 = accessCopys[dataRows[num3].Id];
					}
					List<CopyData> list = new List<CopyData>();
					DRCopy[] dataRows2 = GameEntry.DataTable.GetDataRows((DRCopy p) => p.CopyType == typeData.CopyTypeId);
					for (int num5 = 0; num5 < dataRows2.Length; num5++)
					{
						bool isAccess = false;
						if (dataRows[num3].MainCopyId == 6)
						{
							if (this.accessCopyIds != null && this.accessCopyIds.Count > 0)
							{
								isAccess = this.accessCopyIds.Contains(dataRows2[num5].Id);
							}
						}
						else
						{
							isAccess = num4 >= dataRows2[num5].CopyRank;
						}
						CopyData copyData = CopyData.Create(dataRows2[num5], mainCopies[i].Id, permitLevel, level, maxCopyOpenIndex, typeData.MaxRewardCount, isAccess);
						list.Add(copyData);
						if (!copyDatas.ContainsKey(copyData.Id))
						{
							copyDatas.Add(copyData.Id, copyData);
							if (copyData.CopyMainId == 2)
							{
								copyData.UpdatePreviousOpen(num4 + 1);
							}
						}
						else
						{
							Log.Error($"重复的副本Id！【{copyData.Id}】");
						}
					}
					typeData.AddCopyData(list, num4 + 1);
				}
				CopyMainData item = CopyMainData.Create(mainCopies[i], dictionary);
				mainDataList.Add(item);
			}
			UpdateActivityAccessCopys(accessCopys, level, maxCopyOpenIndex);
			LoadPlayUnlockEffect();
		}
		catch (Exception ex)
		{
			Log.Error("加载副本数据发生异常 " + ex.Message + " / " + ex.StackTrace);
		}
	}

	private void UpdateActivityAccessCopys(Dictionary<int, int> access, int playerLevel, long copyOpenIndex)
	{
		if (towerCopyType <= 0 || copyDatas == null || copyDatas.Count == 0)
		{
			return;
		}
		int maxOpenRankPass = 0;
		if (access != null && access.ContainsKey(towerCopyType))
		{
			maxOpenRankPass = access[towerCopyType];
		}
		for (int i = 0; i < copyDatas.Count; i++)
		{
			if (copyDatas[i].CopyType == towerCopyType)
			{
				copyDatas[i].UpdatePlayerLevel(playerLevel);
				copyDatas[i].UpdateTaskProgress(copyOpenIndex);
				copyDatas[i].UpdatePreviousOpen(maxOpenRankPass, forceCheck: true);
			}
		}
	}

	public void InitCopyMain1()
	{
		if (!isInitCopyMain1)
		{
			isInitCopyMain1 = true;
			InitCopyMainRed(1);
		}
	}

	public void InitCopyMain2()
	{
		if (!isInitCopyMain2)
		{
			isInitCopyMain2 = true;
			InitCopyMainRed(2);
		}
	}

	public void InitCopyMain3(int score, int t3ConsumeCount)
	{
		if (!isInitCopyMain3)
		{
			isInitCopyMain3 = true;
			InitCopyMainRed(3);
			t3Score = score;
			this.t3ConsumeCount = t3ConsumeCount;
		}
	}

	public void InitCopyMain4()
	{
		if (!isInitCopyMain4)
		{
			isInitCopyMain4 = true;
			CheckAllType4UnLock();
		}
	}

	public void InitCopyMain5()
	{
		if (!isInitCopyMain5)
		{
			isInitCopyMain5 = true;
		}
	}

	public void SetType3Params(List<CopyType3CurrentData> currentDatas)
	{
		type3ModeDatas.Clear();
		if (currentDatas != null)
		{
			for (int i = 0; i < currentDatas.Count; i++)
			{
				CopyType3CurrentData copyType3CurrentData = currentDatas[i];
				type3ModeDatas[copyType3CurrentData.Mode] = new CopyType3CurrentData(copyType3CurrentData.Mode, copyType3CurrentData.CopyType, copyType3CurrentData.Score, copyType3CurrentData.RewardCount, copyType3CurrentData.CopyEndTime);
			}
		}
		CopyType3CurrentData type3CurrentData = GetType3CurrentData(CopyType3Mode.Multi);
		copyType3CurId = type3CurrentData?.CopyType ?? 0;
		copyType3CurTimeLeft = type3CurrentData?.CopyEndTime ?? 0;
		t3Score = type3CurrentData?.Score ?? 0;
		T3ConsumeCount = type3CurrentData?.RewardCount ?? 0;
		_ = DateTimeOffset.FromUnixTimeSeconds(copyType3CurTimeLeft).LocalDateTime;
	}

	public List<CopyData> GetType3CopyDatas()
	{
		if (copyType3CurId != 0)
		{
			for (int i = 0; i < mainDataList.Count; i++)
			{
				if (mainDataList[i].MainId != 3)
				{
					continue;
				}
				foreach (KeyValuePair<int, CopyTypeData> item in mainDataList[i].CopyTypeOpenDic)
				{
					if (item.Value.CopyTypeId == copyType3CurId)
					{
						return item.Value.CopyDataList;
					}
				}
			}
		}
		return null;
	}

	public List<CopyData> GetType3ModeCopyDatas(CopyType3Mode mode)
	{
		if (mode == CopyType3Mode.Multi)
		{
			return GetType3CopyDatas();
		}
		return GetCopyDatasByCopyTypeId(GetType3ModeCopyType(mode));
	}

	private List<CopyData> GetCopyDatasByCopyTypeId(int copyTypeId)
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].MainId != 3)
			{
				continue;
			}
			foreach (KeyValuePair<int, CopyTypeData> item in mainDataList[i].CopyTypeOpenDic)
			{
				if (item.Value.CopyTypeId == copyTypeId)
				{
					return item.Value.CopyDataList;
				}
			}
		}
		return null;
	}

	private async Task CheckType3TimeLeft(long curTime)
	{
		if (copyType3CurTimeLeft > 0 && copyType3CurTimeLeft - curTime <= 0)
		{
			await Singleton<ServiceSystem>.Instance.GetService<ICopyService>().RefreshType3Param();
		}
		type3RefreshAction?.Invoke();
	}

	public long GetType3TimeLeft()
	{
		return copyType3CurTimeLeft - GetCurTime();
	}

	private async Task CheckTypeTimeLeft(long curTime)
	{
		typeRefreshAction?.Invoke(curTime);
	}

	public bool CheckTypeOpen(CopyTypeData copyTypeData)
	{
		if (copyTypeData.StartTime == 0L && copyTypeData.EndTime == 0L)
		{
			return true;
		}
		long curTime = GetCurTime();
		if (curTime >= copyTypeData.StartTime && curTime < copyTypeData.EndTime)
		{
			return true;
		}
		return false;
	}

	public CopyTypeData GetCopyType4ByZone(int zone)
	{
		try
		{
			foreach (KeyValuePair<int, CopyTypeData> item in GetCopyMainById(4).CopyTypeOpenDic)
			{
				if (item.Value.Zone == zone)
				{
					return item.Value;
				}
			}
		}
		catch (Exception)
		{
		}
		return null;
	}

	private int GetT5Zone()
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].MainId != 5)
			{
				continue;
			}
			foreach (CopyTypeData value in mainDataList[i].CopyTypeOpenDic.Values)
			{
				if (CheckTypeOpen(value))
				{
					t5Zone = value.Zone;
					return t5Zone;
				}
			}
		}
		return 0;
	}

	public void CopyType3RefreshCount()
	{
		T3ConsumeCount = t3ConsumeCount + 1;
		if (type3ModeDatas.TryGetValue(CopyType3Mode.Multi, out var value))
		{
			type3ModeDatas[CopyType3Mode.Multi] = new CopyType3CurrentData(CopyType3Mode.Multi, value.CopyType, value.Score, T3ConsumeCount, value.CopyEndTime);
		}
	}

	public void RefreshCopyAccess(int copyId, int star, int score, bool isSingle)
	{
		if (copyDatas.ContainsKey(copyId))
		{
			copyDatas[copyId].CopyAccess(star);
			if (copyDatas[copyId].CopyMainId == 1 || copyDatas[copyId].CopyMainId == 2)
			{
				CheckType1_2UnLock(copyDatas[copyId]);
			}
			if (copyDatas[copyId].CopyMainId == 4)
			{
				CheckType4UnLock(copyDatas[copyId]);
			}
			SetCopyTypeScore(copyDatas[copyId].CopyType, score);
			if (copyDatas[copyId].CopyMainId == 3 && !isSingle)
			{
				if (copyDatas[copyId].CopyType == copyType3CurId)
				{
					t3Score = Math.Max(score, t3Score);
				}
				else
				{
					t3Score = score;
				}
			}
			if (copyDatas[copyId].CopyMainId == 7)
			{
				CompleteVersionCopy(copyDatas[copyId]);
			}
			if (copyDatas[copyId].CopyType != towerCopyType)
			{
				return;
			}
			int num = copyDatas[copyId].CopyRank + 1;
			if (accessCopys.ContainsKey(towerCopyType))
			{
				if (num <= accessCopys[towerCopyType])
				{
					return;
				}
				accessCopys[towerCopyType] = num;
			}
			else
			{
				accessCopys.Add(towerCopyType, num);
			}
			{
				foreach (CopyData value in copyDatas.Values)
				{
					if (value.CopyType == towerCopyType)
					{
						value.UpdatePreviousOpen(num, forceCheck: true);
					}
				}
				return;
			}
		}
		if (activityTryCopys != null)
		{
			activityTryCopys.ContainsKey(copyId);
		}
	}

	private void CheckType4UnLock(CopyData copyData)
	{
		int num = copyData.CopyRank + 1;
		List<CopyData> list = new List<CopyData>();
		foreach (CopyMainData mainData in mainDataList)
		{
			if (mainData.MainId != 4)
			{
				continue;
			}
			foreach (CopyData copyData2 in mainData.CopyTypeOpenDic[copyData.CopyType].CopyDataList)
			{
				if (copyData2.Id != copyData.Id && copyData2.CopyRank == copyData.CopyRank && (!copyData2.IsAccessed || copyData2.IsLock))
				{
					return;
				}
				if (copyData2.Id != copyData.Id && copyData2.CopyRank == num && (!copyData2.IsAccessed || copyData2.IsLock))
				{
					list.Add(copyData2);
				}
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			list[i].UpdateType4UnLock();
		}
		CheckCopyType4ZoneOpen(copyData);
	}

	private void CheckAllType4UnLock()
	{
		foreach (CopyMainData mainData in mainDataList)
		{
			if (mainData.MainId != 4)
			{
				continue;
			}
			foreach (CopyTypeData value in mainData.CopyTypeOpenDic.Values)
			{
				Dictionary<int, bool> dictionary = new Dictionary<int, bool>();
				dictionary.Add(0, value: true);
				for (int i = 0; i < value.CopyDataList.Count; i++)
				{
					CopyData copyData = value.CopyDataList[i];
					if (dictionary.ContainsKey(copyData.CopyRank - 1) && dictionary[copyData.CopyRank - 1])
					{
						copyData.UpdateType4UnLock();
					}
					if (copyData.StarMax > 0 || copyData.StarMax < 0)
					{
						if ((!dictionary.ContainsKey(copyData.CopyRank) || !dictionary[copyData.CopyRank]) && !dictionary.ContainsKey(copyData.CopyRank))
						{
							dictionary.Add(copyData.CopyRank, value: true);
						}
					}
					else if (copyData.StarMax == 0 && dictionary.ContainsKey(copyData.CopyRank))
					{
						dictionary[copyData.CopyRank] = false;
					}
				}
			}
		}
	}

	public void InitPermitData(List<PermitTaskData> permitServerDatas)
	{
		permitDataList.Clear();
		DRPermit permit = GameEntry.DataTable.GetDataRow((DRPermit p) => p.Id == copyPermitLevel);
		if (permit == null)
		{
			return;
		}
		int i;
		for (i = 0; i < permit.Task.Count; i++)
		{
			DRPermitTask dataRow = GameEntry.DataTable.GetDataRow((DRPermitTask p) => p.Id == permit.Task[i]);
			bool flag = false;
			for (int num = 0; num < permitServerDatas.Count; num++)
			{
				if (permitServerDatas[num].taskId == permit.Task[i])
				{
					permitDataList.Add(CopyPermitData.Create(dataRow, permitServerDatas[num].taskVal));
					flag = true;
				}
			}
			if (!flag)
			{
				permitDataList.Add(CopyPermitData.Create(dataRow, 0));
			}
		}
	}

	public void RefreshPermitData(int permitLevel, List<PermitTaskData> permitServerDatas)
	{
		bool flag = copyPermitLevel != permitLevel;
		copyPermitLevel = permitLevel;
		if (!flag)
		{
			for (int i = 0; i < permitDataList.Count; i++)
			{
				for (int j = 0; j < permitServerDatas.Count; j++)
				{
					if (permitDataList[i].Id == permitServerDatas[j].taskId)
					{
						permitDataList[i].UpdateProgress(permitServerDatas[j].taskVal);
						break;
					}
				}
			}
		}
		else
		{
			permitDataList.Clear();
			DRPermit permit = GameEntry.DataTable.GetDataRow((DRPermit p) => p.Id == copyPermitLevel);
			if (permit == null)
			{
				return;
			}
			int i2;
			for (i2 = 0; i2 < permit.Task.Count; i2++)
			{
				DRPermitTask dataRow = GameEntry.DataTable.GetDataRow((DRPermitTask p) => p.Id == permit.Task[i2]);
				bool flag2 = false;
				for (int num = 0; num < permitServerDatas.Count; num++)
				{
					if (permitServerDatas[num].taskId == permit.Task[i2])
					{
						permitDataList.Add(CopyPermitData.Create(dataRow, permitServerDatas[num].taskVal));
						flag2 = true;
					}
				}
				if (!flag2)
				{
					permitDataList.Add(CopyPermitData.Create(dataRow, 0));
				}
			}
		}
		permitAction?.Invoke(flag);
	}

	public void RemovePermitRefreshListener(Action<bool> action)
	{
		permitAction = (Action<bool>)Delegate.Remove(permitAction, action);
	}

	public void AddPermitRefreshListener(Action<bool> action)
	{
		permitAction = (Action<bool>)Delegate.Combine(permitAction, action);
	}

	public CopyData GetCopyById(int copyId)
	{
		if (copyDatas.ContainsKey(copyId))
		{
			return copyDatas[copyId];
		}
		return null;
	}

	public CopyTypeData GetCopyTypeById(int copyTypeId)
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].CopyTypeOpenDic.ContainsKey(copyTypeId))
			{
				return mainDataList[i].CopyTypeOpenDic[copyTypeId];
			}
		}
		return null;
	}

	public CopyTypeData GetCopyTypeById(int copyMainId, int copyTypeId)
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (copyMainId == mainDataList[i].MainId && mainDataList[i].CopyTypeOpenDic.ContainsKey(copyTypeId))
			{
				return mainDataList[i].CopyTypeOpenDic[copyTypeId];
			}
		}
		return null;
	}

	public CopyMainData GetCopyMainById(int copyMainId)
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].MainId == copyMainId)
			{
				return mainDataList[i];
			}
		}
		return null;
	}

	public void UpdatePlayerLevel(int playerLevel)
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			foreach (CopyTypeData value in mainDataList[i].CopyTypeOpenDic.Values)
			{
				value.UpdatePlayerLevel(playerLevel);
				for (int j = 0; j < value.CopyDataList.Count; j++)
				{
					if (value.CopyDataList[j].IsLevelLock)
					{
						value.CopyDataList[j].UpdatePlayerLevel(playerLevel);
					}
				}
			}
		}
		UpdatePlayerLevelChallengeCopy(playerLevel);
	}

	public void UpdatePerimitLevel(int permitLevel)
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			foreach (CopyTypeData value in mainDataList[i].CopyTypeOpenDic.Values)
			{
				value.UpdatePermitLevel(permitLevel);
				for (int j = 0; j < value.CopyDataList.Count; j++)
				{
					if (value.CopyDataList[j].IsPermitLock)
					{
						value.CopyDataList[j].UpdatePermitLevel(permitLevel);
					}
				}
			}
			mainDataList[i].CheckMainCopyOpen();
		}
	}

	public void UpdateMaxCopyIdx(long maxCopyOpenIndex)
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			foreach (CopyTypeData value in mainDataList[i].CopyTypeOpenDic.Values)
			{
				value.UpdateTaskProgress(maxCopyOpenIndex);
				for (int j = 0; j < value.CopyDataList.Count; j++)
				{
					if (value.CopyDataList[j].IsTaskLock)
					{
						value.CopyDataList[j].UpdateTaskProgress(maxCopyOpenIndex);
					}
				}
			}
			mainDataList[i].CheckMainCopyOpen();
		}
		UpdateMaxCopyIdxChallengeCopy(maxCopyOpenIndex);
	}

	public CopyType4TeamConfig GetTeamConfig(int copyId)
	{
		if (teamConfigs != null && teamConfigs.ContainsKey(copyId))
		{
			return teamConfigs[copyId];
		}
		return null;
	}

	public bool HasTeamConfig(int copyId)
	{
		if (teamConfigs != null && teamConfigs.ContainsKey(copyId))
		{
			return true;
		}
		return false;
	}

	public void SaveCarringBPs(int copyId, int bpId1, int bpId2)
	{
		if (teamConfigs == null)
		{
			teamConfigs = new Dictionary<int, CopyType4TeamConfig>();
		}
		if (teamConfigs.ContainsKey(copyId))
		{
			teamConfigs[copyId].SaveCarringBPs(bpId1, bpId2);
		}
	}

	public void AddCopyConfig(List<CopyType4TeamConfig> settings)
	{
		if (teamConfigs == null)
		{
			teamConfigs = new Dictionary<int, CopyType4TeamConfig>();
		}
		for (int i = 0; i < settings.Count; i++)
		{
			if (teamConfigs.ContainsKey(settings[i].CopyId))
			{
				teamConfigs[settings[i].CopyId] = null;
				teamConfigs.Remove(settings[i].CopyId);
			}
			teamConfigs.Add(settings[i].CopyId, settings[i]);
		}
	}

	public void RemoveCopyConfig(List<int> copys)
	{
		if (teamConfigs == null)
		{
			teamConfigs = new Dictionary<int, CopyType4TeamConfig>();
		}
		for (int i = 0; i < copys.Count; i++)
		{
			if (teamConfigs.ContainsKey(copys[i]))
			{
				teamConfigs[copys[i]].Clear();
				teamConfigs.Remove(copys[i]);
			}
		}
	}

	public bool GetReward4State(int zone, int index)
	{
		if (t4RewardState == null)
		{
			t4RewardState = new Dictionary<int, Dictionary<int, bool>>();
		}
		if (t4RewardState.ContainsKey(zone) && t4RewardState[zone].ContainsKey(index))
		{
			return t4RewardState[zone][index];
		}
		return false;
	}

	public void SetReward4State(int zone, int index, bool get)
	{
		if (t4RewardState == null)
		{
			t4RewardState = new Dictionary<int, Dictionary<int, bool>>();
		}
		if (!t4RewardState.ContainsKey(zone))
		{
			t4RewardState.Add(zone, new Dictionary<int, bool>());
		}
		if (!t4RewardState[zone].ContainsKey(index))
		{
			t4RewardState[zone].Add(index, get);
		}
		else
		{
			t4RewardState[zone][index] = get;
		}
	}

	public int GetZoneStartMax(int zone)
	{
		if (t4StarCount == null)
		{
			t4StarCount = new Dictionary<int, int>();
		}
		if (t4StarCount.ContainsKey(zone))
		{
			return t4StarCount[zone];
		}
		return 0;
	}

	public void SetReward4State(int zone, int zoneIndex, int rewardNum)
	{
		if (t4RewardState == null)
		{
			t4RewardState = new Dictionary<int, Dictionary<int, bool>>();
		}
		if (!t4RewardState.ContainsKey(zone))
		{
			t4RewardState.Add(zone, new Dictionary<int, bool>());
		}
		string text = Convert.ToString(rewardNum, 2);
		for (int i = 0; i < text.Length; i++)
		{
			int key = text.Length - i + 31 * zoneIndex;
			bool value = text[i].Equals('1');
			if (t4RewardState[zone].ContainsKey(key))
			{
				t4RewardState[zone][key] = value;
			}
			else
			{
				t4RewardState[zone].Add(key, value);
			}
		}
	}

	public void SetStarInfo4State(int zone, int starCount)
	{
		if (t4StarCount == null)
		{
			t4StarCount = new Dictionary<int, int>();
		}
		t4StarCount[zone] = starCount;
	}

	public List<CopyData> GetZoneAllCopyByCopyId(int copyId)
	{
		if (!copyDatas.ContainsKey(copyId))
		{
			return null;
		}
		int copyType = copyDatas[copyId].CopyType;
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].CopyTypeOpenDic.ContainsKey(copyType))
			{
				return mainDataList[i].CopyTypeOpenDic[copyType].CopyDataList;
			}
		}
		return null;
	}

	public List<CopyTypeData> GetType5ZoneAllCopyType(int zone)
	{
		List<CopyTypeData> list = new List<CopyTypeData>();
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].MainId != 5)
			{
				continue;
			}
			foreach (KeyValuePair<int, CopyTypeData> item in mainDataList[i].CopyTypeOpenDic)
			{
				if (item.Value.Zone == zone)
				{
					list.Add(item.Value);
				}
			}
		}
		return list;
	}

	public List<CopyData> GetRankOpenCopy()
	{
		List<CopyData> list = new List<CopyData>();
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].MainId != 3 && mainDataList[i].MainId != 5)
			{
				continue;
			}
			foreach (CopyTypeData value in mainDataList[i].CopyTypeOpenDic.Values)
			{
				if (value.IsLock || !CheckTypeOpen(value))
				{
					continue;
				}
				for (int j = 0; j < value.CopyDataList.Count; j++)
				{
					if (!value.CopyDataList[j].IsLock)
					{
						list.Add(value.CopyDataList[j]);
					}
				}
			}
		}
		return list;
	}

	public int GetCopyType4StarByZone(int zone)
	{
		int num = 0;
		try
		{
			List<CopyTypeData> type4OpenCopy = GetType4OpenCopy();
			if (type4OpenCopy == null || type4OpenCopy.Count == 0)
			{
				return 0;
			}
			for (int i = 0; i < type4OpenCopy.Count; i++)
			{
				CopyTypeData copyTypeData = type4OpenCopy[i];
				if (copyTypeData == null || copyTypeData.Zone != zone || copyTypeData.CopyDataList == null)
				{
					continue;
				}
				for (int j = 0; j < copyTypeData.CopyDataList.Count; j++)
				{
					CopyData copyData = copyTypeData.CopyDataList[j];
					if (copyData != null)
					{
						num += copyData.StarMax;
					}
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error($"计算深渊区域星星数量异常 zone:{zone} {ex.Message} / {ex.StackTrace}");
		}
		return num;
	}

	public List<CopyTypeData> GetType4OpenCopy()
	{
		List<CopyTypeData> list = new List<CopyTypeData>();
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].MainId != 4)
			{
				continue;
			}
			foreach (KeyValuePair<int, CopyTypeData> item in mainDataList[i].CopyTypeOpenDic)
			{
				if (CheckTypeOpen(item.Value))
				{
					list.Add(item.Value);
				}
			}
		}
		return list;
	}

	public void SetCopyType4ZoneOpen(int zone)
	{
		t4Zone = zone;
	}

	public void CheckCopyType4ZoneOpen(CopyData copyData)
	{
		CopyTypeData copyTypeById = GetCopyTypeById(copyData.CopyType);
		if (copyTypeById.Zone != t4Zone)
		{
			return;
		}
		if (copyTypeById.Zone == t4Zone)
		{
			for (int i = 0; i < copyTypeById.CopyDataList.Count; i++)
			{
				if (!copyTypeById.CopyDataList[i].IsAccessed)
				{
					return;
				}
			}
		}
		t4Zone++;
	}

	public int GetCopyType4ZoneOpen()
	{
		return t4Zone;
	}

	public void SetType4ReturnCopy(List<CopyData> nextCopyDatas, int curId1, int curId2)
	{
		type4ReturnCopy = new List<CopyType4TeamConfig>();
		if (curId1 != 0 && teamConfigs.ContainsKey(curId1) && nextCopyDatas != null && nextCopyDatas.Count > 0)
		{
			type4ReturnCopy.Add(new CopyType4TeamConfig(nextCopyDatas[0].Id, teamConfigs[curId1].HeroList, teamConfigs[curId1].BpList));
		}
		if (curId2 != 0 && teamConfigs.ContainsKey(curId2) && nextCopyDatas != null && nextCopyDatas.Count > 1)
		{
			type4ReturnCopy.Add(new CopyType4TeamConfig(nextCopyDatas[1].Id, teamConfigs[curId2].HeroList, teamConfigs[curId2].BpList));
		}
	}

	public List<CopyType4TeamConfig> GetType4ReturnCopy()
	{
		return type4ReturnCopy;
	}

	public CopyType4RecordData GetType4RecordData()
	{
		CopyMainData copyMainById = GetCopyMainById(4);
		CopyTypeData copyTypeData = null;
		long curTime = GetCurTime();
		foreach (CopyTypeData value in copyMainById.CopyTypeOpenDic.Values)
		{
			if (value.EndTime != 0L && value.EndTime <= curTime)
			{
				if (copyTypeData == null)
				{
					copyTypeData = value;
				}
				else if (curTime - value.EndTime < curTime - copyTypeData.EndTime)
				{
					copyTypeData = value;
				}
			}
		}
		int type4RecordFlag = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetType4RecordFlag();
		int num = 0;
		int num2 = 0;
		int num3 = -1;
		if (copyTypeData != null)
		{
			if (type4RecordFlag == copyTypeData.CopyTypeId)
			{
				return null;
			}
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveType4RecordFlag(copyTypeData.CopyTypeId);
			for (int i = 0; i < copyTypeData.CopyDataList.Count; i++)
			{
				num2 += copyTypeData.CopyDataList[i].StarConfigMax;
				if (copyTypeData.CopyDataList[i].StarMax > 0)
				{
					num += copyTypeData.CopyDataList[i].StarMax;
				}
				if (copyTypeData.CopyDataList[i].StarMax > 0)
				{
					num3 = i;
				}
			}
		}
		if (copyTypeData == null || num3 == -1)
		{
			return null;
		}
		return new CopyType4RecordData
		{
			typeData = copyTypeData,
			copyAccessIndex = num3,
			starGet = num,
			starAll = num2
		};
	}

	public void SetType5TotalScore(long score)
	{
		t5Score = score;
	}

	public long GetType5TotalScore()
	{
		return t5Score;
	}

	public void InitT5CopySelect()
	{
		t5CopySelectSave = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetType5CopySelects();
		if (t5CopySelectSave == null)
		{
			t5CopySelectSave = new Dictionary<int, int>();
		}
	}

	public int GetT5CopySelect(int typeId)
	{
		if (t5CopySelectSave == null)
		{
			InitT5CopySelect();
		}
		if (t5CopySelectSave.ContainsKey(typeId))
		{
			return t5CopySelectSave[typeId];
		}
		return 0;
	}

	public void SaveT5CopySelect(int typeId, int copyId)
	{
		if (t5CopySelectSave == null)
		{
			InitT5CopySelect();
		}
		if (t5CopySelectSave.ContainsKey(typeId))
		{
			t5CopySelectSave[typeId] = copyId;
		}
		else
		{
			t5CopySelectSave.Add(typeId, copyId);
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveType5CopySelects(t5CopySelectSave);
	}

	public bool GetReward5State(int id)
	{
		if (t5RewardState == null)
		{
			t5RewardState = new Dictionary<int, bool>();
		}
		if (t5RewardState.ContainsKey(id))
		{
			return t5RewardState[id];
		}
		return false;
	}

	public void SetReward5State(int id, bool get)
	{
		if (t5RewardState == null)
		{
			t5RewardState = new Dictionary<int, bool>();
		}
		if (!t5RewardState.ContainsKey(id))
		{
			t5RewardState.Add(id, get);
		}
		else
		{
			t5RewardState[id] = get;
		}
	}

	public void SetReward5State(List<int> ids)
	{
		if (t5RewardState == null)
		{
			t5RewardState = new Dictionary<int, bool>();
		}
		for (int i = 0; i < ids.Count; i++)
		{
			string text = Convert.ToString(ids[i], 2);
			for (int j = 0; j < text.Length; j++)
			{
				bool value = text[j].Equals('1');
				int key = text.Length - j + i * 32;
				if (t5RewardState.ContainsKey(key))
				{
					t5RewardState[key] = value;
				}
				else
				{
					t5RewardState.Add(key, value);
				}
			}
		}
	}

	public void ClearReward5State()
	{
		if (t5RewardState != null)
		{
			t5RewardState.Clear();
		}
	}

	public void SetCopyTypeScore(int copyType, int score)
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (mainDataList[i].CopyTypeOpenDic.ContainsKey(copyType))
			{
				mainDataList[i].CopyTypeOpenDic[copyType].SetCurScore(score);
				List<CopyData> copyDataList = mainDataList[i].CopyTypeOpenDic[copyType].CopyDataList;
				for (int j = 0; j < copyDataList.Count; j++)
				{
					copyDataList[j].SetCurScore(score);
				}
				break;
			}
		}
	}

	public CopyType5Team GetType5TeamConfig(int type)
	{
		if (type5TeamConfigs.ContainsKey(type))
		{
			return type5TeamConfigs[type];
		}
		return null;
	}

	public void SetType5TeamConfigFromServer(CopyType5Team teamConfig)
	{
		SetTeamConfig(teamConfig);
	}

	public void SetType5TeamConfig(CopyType5Team teamConfig)
	{
		SetTeamConfig(teamConfig);
	}

	public void SaveType5TeamConfigLocal(CopyType5Team teamConfig)
	{
		SetTeamConfig(teamConfig);
		SaveType5TeamConfigLocal();
	}

	public void SaveType5TeamConfigLocal()
	{
		if (type5TeamConfigs.ContainsKey(0))
		{
			type5TeamConfigs.Remove(0);
		}
		List<CopyType5TeamConfig> list = new List<CopyType5TeamConfig>();
		foreach (KeyValuePair<int, CopyType5Team> type5TeamConfig in type5TeamConfigs)
		{
			list.Add(type5TeamConfig.Value.Config);
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveType5Teams(list);
	}

	private void SetTeamConfig(CopyType5TeamConfig teamConfig)
	{
		if (type5TeamConfigs == null)
		{
			type5TeamConfigs = new Dictionary<int, CopyType5Team>();
		}
		int copyType = teamConfig.copyType;
		if (!type5TeamConfigs.ContainsKey(copyType))
		{
			CopyTypeData copyTypeById = GetCopyTypeById(5, copyType);
			type5TeamConfigs.Add(copyType, CopyType5Team.CreateEmpty(copyType, copyTypeById.EndTime));
		}
		type5TeamConfigs[copyType].SetConfig(teamConfig);
	}

	private void SetTeamConfig(CopyType5Team teamConfig)
	{
		if (type5TeamConfigs == null)
		{
			type5TeamConfigs = new Dictionary<int, CopyType5Team>();
		}
		if (type5TeamConfigs.ContainsKey(teamConfig.CopyType))
		{
			type5TeamConfigs[teamConfig.CopyType] = teamConfig;
		}
		else
		{
			type5TeamConfigs.Add(teamConfig.CopyType, teamConfig);
		}
	}

	public void LoadT5LocalTeam()
	{
		List<CopyType5TeamConfig> type5Teams = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetType5Teams();
		if (type5TeamConfigs == null)
		{
			type5TeamConfigs = new Dictionary<int, CopyType5Team>();
		}
		if (type5Teams == null || type5Teams.Count == 0)
		{
			return;
		}
		long curTime = GetCurTime();
		for (int i = 0; i < type5Teams.Count; i++)
		{
			if (type5Teams[i].endTime > curTime)
			{
				SetTeamConfig(type5Teams[i]);
			}
		}
	}

	public CopyData GetTrainCopy(int copyType)
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			if (!mainDataList[i].CopyTypeOpenDic.ContainsKey(copyType))
			{
				continue;
			}
			List<CopyData> copyDataList = mainDataList[i].CopyTypeOpenDic[copyType].CopyDataList;
			int num = 0;
			int num2 = -1;
			for (int j = 0; j < copyDataList.Count; j++)
			{
				if (num < copyDataList[j].Id)
				{
					num = copyDataList[j].Id;
					num2 = j;
				}
			}
			if (num2 != -1)
			{
				return copyDataList[num2];
			}
			return null;
		}
		return null;
	}

	public bool HasType3OpenCopy()
	{
		if (type3ModeDatas != null)
		{
			return type3ModeDatas.Count > 0;
		}
		return false;
	}

	public int GetType3ModeCopyType(CopyType3Mode mode)
	{
		return GetType3CurrentData(mode)?.CopyType ?? 0;
	}

	public int GetType3ModeScore(CopyType3Mode mode)
	{
		return GetType3CurrentData(mode)?.Score ?? 0;
	}

	public int GetType3ModeRewardCount(CopyType3Mode mode)
	{
		return GetType3CurrentData(mode)?.RewardCount ?? 0;
	}

	public long GetType3ModeTimeLeft(CopyType3Mode mode)
	{
		CopyType3CurrentData type3CurrentData = GetType3CurrentData(mode);
		if (type3CurrentData == null)
		{
			return 0L;
		}
		return type3CurrentData.CopyEndTime - GetCurTime();
	}

	public void CheckType2TimeLock()
	{
		if (serverTime == -1)
		{
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().UpdateRealisticTime();
		}
		CheckType2TimeLock(GetCurTime());
		typeRefreshAction = (Action<long>)Delegate.Combine(typeRefreshAction, new Action<long>(CheckType2TimeLock));
	}

	private void CheckType2TimeLock(long serverTime)
	{
		CopyMainData copyMainById = GetCopyMainById(2);
		if (copyMainById == null)
		{
			return;
		}
		foreach (CopyTypeData value in copyMainById.CopyTypeOpenDic.Values)
		{
			value.UpdateServerTime(serverTime);
		}
	}

	public void CloseCheckType2TimeLock()
	{
		typeRefreshAction = (Action<long>)Delegate.Remove(typeRefreshAction, new Action<long>(CheckType2TimeLock));
	}

	public bool RegisterTimer(long serverTime)
	{
		if (serverTime == 0L && this.serverTime == -1)
		{
			return false;
		}
		if (serverTime == 0L)
		{
			return true;
		}
		this.serverTime = serverTime;
		if (copyTimer == null)
		{
			copyTimer = Timer.Register(interval, delegate
			{
				CheckTimeLeft();
			}, null, isLooped: true);
		}
		return true;
	}

	private void CheckTimeLeft()
	{
		long curTime = GetCurTime();
		CheckType3TimeLeft(curTime);
		CheckTypeTimeLeft(curTime);
	}

	public long GetCurTime()
	{
		try
		{
			serverTime = Singleton<ServiceSystem>.Instance.GetService<ITimeService>().GetCurServerTime();
			return serverTime;
		}
		catch (Exception)
		{
			RemoveTimer();
		}
		return -1L;
	}

	public void RemoveTimer()
	{
		serverTime = -1L;
		copyTimer?.Cancel();
		copyTimer = null;
	}

	public void SetServerTime(long goldServerTime)
	{
		serverTime = goldServerTime;
		copyType3CurId = 0;
		copyType3CurTimeLeft = goldServerTime + 86400;
		type3RefreshAction?.Invoke();
		LogServerTime();
	}

	private CopyType3CurrentData GetType3CurrentData(CopyType3Mode mode)
	{
		if (type3ModeDatas.TryGetValue(mode, out var value))
		{
			return value;
		}
		return null;
	}

	public void LogServerTime()
	{
		long curTime = GetCurTime();
		_ = DateTimeOffset.FromUnixTimeSeconds(curTime).LocalDateTime;
		_ = DateTimeOffset.FromUnixTimeSeconds(curTime).LocalDateTime;
	}

	public void SaveAllRedData(List<CopyRedData> redDatas)
	{
		if (copyRedDataDics != null)
		{
			return;
		}
		copyRedDataDics = new Dictionary<int, CopyRedData>();
		this.redDatas = redDatas;
		if (redDatas != null)
		{
			for (int i = 0; i < redDatas.Count; i++)
			{
				copyRedDataDics.Add(redDatas[i].copyId, redDatas[i]);
			}
		}
	}

	private void InitCopyMainRed(int mainId)
	{
		bool flag = false;
		List<int> list = new List<int>();
		foreach (CopyRedData value in copyRedDataDics.Values)
		{
			if (value.copyMainId != mainId)
			{
				continue;
			}
			flag = true;
			if (value.copyId != 0)
			{
				CopyData copyById = GetCopyById(value.copyId);
				if (copyById == null)
				{
					list.Add(value.copyId);
				}
				else if (copyById.CopyType == copyType3CurId)
				{
					copyById.SetRed(value.isRed);
				}
			}
		}
		for (int i = 0; i < list.Count; i++)
		{
			copyRedDataDics.Remove(list[i]);
		}
		if (flag)
		{
			CopyMainData copyMainById = GetCopyMainById(mainId);
			bool flag2 = false;
			foreach (KeyValuePair<int, CopyTypeData> item in copyMainById.CopyTypeOpenDic)
			{
				bool flag3 = false;
				for (int j = 0; j < item.Value.CopyDataList.Count; j++)
				{
					if (item.Value.CopyDataList[j].HasNew)
					{
						flag3 = true;
						break;
					}
				}
				item.Value.SetRed(flag3 && !item.Value.IsLock && item.Value.CopyTypeId == copyType3CurId);
				flag2 = flag2 || item.Value.HasNew;
			}
			copyMainById.SetRed(flag2 && !copyMainById.IsLock);
			UpdateCopySelectRed();
			return;
		}
		for (int k = 0; k < mainDataList.Count; k++)
		{
			bool flag4 = false;
			if (mainDataList[k].IsLock)
			{
				continue;
			}
			if ((mainDataList[k].MainId == 1 && mainId == 1) || (mainDataList[k].MainId == 2 && mainId == 2))
			{
				foreach (CopyTypeData value2 in mainDataList[k].CopyTypeOpenDic.Values)
				{
					if (value2.IsLock)
					{
						continue;
					}
					bool flag5 = false;
					int copyType1_2CopyMaxOpenRank = GetCopyType1_2CopyMaxOpenRank(value2);
					for (int l = 0; l < value2.CopyDataList.Count; l++)
					{
						if (!value2.CopyDataList[l].IsLock && value2.CopyDataList[l].CopyRank <= copyType1_2CopyMaxOpenRank)
						{
							CopyData copyData = value2.CopyDataList[l];
							if (!copyRedDataDics.ContainsKey(copyData.Id))
							{
								copyRedDataDics.Add(copyData.Id, new CopyRedData
								{
									copyId = copyData.Id,
									copyMainId = copyData.CopyMainId,
									copyTypeId = copyData.CopyType,
									isRed = true
								});
							}
							flag5 = true;
							copyData.SetRed(hasNew: true);
						}
					}
					flag4 = flag5 | flag4;
					value2.SetRed(flag5);
				}
				mainDataList[k].SetRed(flag4);
			}
			else
			{
				if (mainDataList[k].MainId != 3 || mainId != 3)
				{
					continue;
				}
				if (mainDataList[k].CopyTypeOpenDic.ContainsKey(copyType3CurId))
				{
					bool flag6 = false;
					for (int m = 0; m < mainDataList[k].CopyTypeOpenDic[copyType3CurId].CopyDataList.Count; m++)
					{
						CopyData copyData2 = mainDataList[k].CopyTypeOpenDic[copyType3CurId].CopyDataList[m];
						if (!copyData2.IsLock)
						{
							if (!copyRedDataDics.ContainsKey(copyData2.Id))
							{
								copyRedDataDics.Add(copyData2.Id, new CopyRedData
								{
									copyId = copyData2.Id,
									copyMainId = copyData2.CopyMainId,
									copyTypeId = copyData2.CopyType,
									isRed = true
								});
							}
							copyData2.SetRed(hasNew: true);
							flag6 = true;
						}
					}
					flag4 = flag6 | flag4;
					mainDataList[k].CopyTypeOpenDic[copyType3CurId].SetRed(flag6);
				}
				mainDataList[k].SetRed(flag4);
			}
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveCopyRedDatas(copyRedDataDics.Values.ToList());
		UpdateCopySelectRed();
	}

	public void UpdateSingleCopyRed(int copyId, bool isRed)
	{
		CopyData copyById = GetCopyById(copyId);
		UpdateSingleCopyRed(copyById, isRed);
	}

	public void UpdateSingleCopyRed(CopyData copyData, bool isRed)
	{
		if (copyData.CopyMainId != 1 && copyData.CopyMainId != 2 && copyData.CopyMainId != 3)
		{
			return;
		}
		if (copyRedDataDics.ContainsKey(copyData.Id))
		{
			if (isRed && !copyRedDataDics[copyData.Id].isRed)
			{
				copyData.SetRed(hasNew: false);
				return;
			}
			if (copyRedDataDics[copyData.Id].isRed && !isRed)
			{
				copyRedDataDics[copyData.Id].SetRed(isRed: false);
				copyData.SetRed(hasNew: false);
			}
		}
		else if (isRed)
		{
			copyData.SetRed(hasNew: true);
			copyRedDataDics.Add(copyData.Id, new CopyRedData
			{
				copyId = copyData.Id,
				copyMainId = copyData.CopyMainId,
				copyTypeId = copyData.CopyType,
				isRed = true
			});
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveCopyRedDatas(copyRedDataDics.Values.ToList());
		CopyTypeData copyTypeById = GetCopyTypeById(copyData.CopyType);
		UpdateSingleCopyTypeRed(copyTypeById);
	}

	public void UpdateSingleCopyTypeRed(CopyTypeData copyTypeData)
	{
		if (copyTypeData.IsLock)
		{
			copyTypeData.SetRed(hasNew: false);
		}
		else
		{
			bool flag = false;
			for (int i = 0; i < copyTypeData.CopyDataList.Count; i++)
			{
				flag = copyTypeData.CopyDataList[i].HasNew;
				if (flag)
				{
					break;
				}
			}
			copyTypeData.SetRed(flag);
		}
		CopyMainData copyMainById = GetCopyMainById(copyTypeData.CopyMainId);
		bool flag2 = false;
		foreach (KeyValuePair<int, CopyTypeData> item in copyMainById.CopyTypeOpenDic)
		{
			if (item.Value.HasNew)
			{
				flag2 = true;
				break;
			}
		}
		copyMainById.SetRed(flag2);
		if (flag2)
		{
			for (int j = 0; j < copyEntryData.Count; j++)
			{
				if ((copyMainById.MainId == 1 || copyMainById.MainId == 2) && copyEntryData[j].EntryType == 1)
				{
					copyEntryData[j].SetRed(red: true);
				}
				else if (copyMainById.MainId == 3 && copyEntryData[j].EntryType == 2)
				{
					copyEntryData[j].SetRed(red: true);
				}
				else if ((copyMainById.MainId == 1 || copyMainById.MainId == 2 || copyMainById.MainId == 3) && copyEntryData[j].EntryType == 0)
				{
					copyEntryData[j].SetRed(red: true);
				}
			}
		}
		else
		{
			UpdateCopySelectRed();
		}
	}

	public void CancelAllCopyTypeRed(CopyTypeData copyTypeData)
	{
		for (int i = 0; i < copyTypeData.CopyDataList.Count; i++)
		{
			copyTypeData.CopyDataList[i].SetRed(hasNew: false);
			UpdateRedDics(copyTypeData.CopyDataList[i].Id, isRed: false);
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveCopyRedDatas(copyRedDataDics.Values.ToList());
		copyTypeData.SetRed(hasNew: false);
		CopyMainData copyMainById = GetCopyMainById(copyTypeData.CopyMainId);
		if (copyMainById != null)
		{
			bool red = false;
			foreach (CopyTypeData value in copyMainById.CopyTypeOpenDic.Values)
			{
				if (value.HasNew)
				{
					red = true;
					break;
				}
			}
			copyMainById.SetRed(red);
		}
		UpdateCopySelectRed();
	}

	public void CancelAllCopyTypeRed(int copyTypeId)
	{
		CopyTypeData copyTypeById = GetCopyTypeById(copyTypeId);
		if (copyTypeById.HasNew)
		{
			CancelAllCopyTypeRed(copyTypeById);
		}
	}

	public void UpdateAllCopyRed()
	{
		try
		{
			Dictionary<int, bool> dictionary = new Dictionary<int, bool>();
			Dictionary<int, bool> dictionary2 = new Dictionary<int, bool>();
			foreach (KeyValuePair<int, CopyData> copyData in copyDatas)
			{
				if (!copyData.Value.HasNew || copyData.Value.IsLock)
				{
					continue;
				}
				int key = copyData.Key;
				if (copyRedDataDics.ContainsKey(key))
				{
					if ((copyData.Value.CopyMainId != 3 || copyData.Value.CopyType == copyType3CurId) && !copyRedDataDics[key].isRed)
					{
						copyData.Value.SetRed(hasNew: false);
					}
					continue;
				}
				copyRedDataDics.Add(key, new CopyRedData
				{
					copyId = key,
					copyMainId = copyData.Value.CopyMainId,
					copyTypeId = copyData.Value.CopyType,
					isRed = true
				});
				if (!dictionary2.ContainsKey(copyData.Value.CopyType))
				{
					dictionary2.Add(copyData.Value.CopyType, value: true);
				}
				if (!dictionary.ContainsKey(copyData.Value.CopyMainId))
				{
					dictionary.Add(copyData.Value.CopyMainId, value: true);
				}
			}
			Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveCopyRedDatas(copyRedDataDics.Values.ToList());
			foreach (KeyValuePair<int, bool> item in dictionary2)
			{
				GetCopyTypeById(item.Key).SetRed(hasNew: true);
			}
			foreach (KeyValuePair<int, bool> item2 in dictionary)
			{
				GetCopyMainById(item2.Key)?.SetRed(hasNew: true);
			}
			UpdateCopySelectRed();
		}
		catch (Exception)
		{
		}
	}

	private void UpdateCopySelectRed()
	{
		try
		{
			bool red = false;
			for (int i = 0; i < copyEntryData.Count; i++)
			{
				if (copyEntryData[i].EntryType == 1)
				{
					CopyMainData copyMainById = GetCopyMainById(1);
					if (copyMainById == null || !copyMainById.HasNew)
					{
						CopyMainData copyMainById2 = GetCopyMainById(2);
						if (copyMainById2 == null || !copyMainById2.HasNew)
						{
							copyEntryData[i].SetRed(red: false);
							continue;
						}
					}
					copyEntryData[i].SetRed(red: true);
					red = true;
				}
				else if (copyEntryData[i].EntryType == 2)
				{
					CopyMainData copyMainById3 = GetCopyMainById(3);
					if (copyMainById3 != null && copyMainById3.HasNew)
					{
						copyEntryData[i].SetRed(red: true);
						red = true;
					}
					else
					{
						copyEntryData[i].SetRed(red: false);
					}
				}
				else if (copyEntryData[i].EntryType == 0)
				{
					copyEntryData[i].SetRed(red);
				}
			}
		}
		catch (Exception ex)
		{
			Log.Error("更新副本选择红点 " + ex.Message + " / " + ex.StackTrace);
		}
	}

	public void UpdateRedDics(int copyId, bool isRed)
	{
		if (copyRedDataDics == null)
		{
			copyRedDataDics = new Dictionary<int, CopyRedData>();
		}
		if (copyRedDataDics.ContainsKey(copyId))
		{
			copyRedDataDics[copyId].SetRed(isRed);
			return;
		}
		CopyData copyById = GetCopyById(copyId);
		if ((copyById != null) & isRed)
		{
			copyRedDataDics.Add(copyId, new CopyRedData
			{
				copyId = copyId,
				copyMainId = copyById.CopyMainId,
				copyTypeId = copyById.CopyType,
				isRed = true
			});
		}
	}

	public int GetCopyType1_2CopyMaxOpenRank(CopyData copyData)
	{
		CopyTypeData copyTypeById = GetCopyTypeById(copyData.CopyType);
		return GetCopyType1_2CopyMaxOpenRank(copyTypeById);
	}

	public int GetCopyType1_2CopyMaxOpenRank(CopyTypeData copyType)
	{
		int num = 1;
		if (copyType.CopyMainId == 1)
		{
			for (int i = 0; i < copyType.CopyDataList.Count; i++)
			{
				if (!copyType.CopyDataList[i].IsLock && copyType.CopyDataList[i].IsAccessed)
				{
					num = Math.Max(copyType.CopyDataList[i].CopyRank + 1, num);
				}
			}
		}
		else if (copyType.CopyMainId == 2)
		{
			foreach (CopyTypeData value in GetCopyMainById(2).CopyTypeOpenDic.Values)
			{
				if (value.IsLock)
				{
					continue;
				}
				for (int j = 0; j < value.CopyDataList.Count; j++)
				{
					if (!value.CopyDataList[j].IsLock && value.CopyDataList[j].IsAccessed)
					{
						num = Math.Max(value.CopyDataList[j].CopyRank + 1, num);
					}
				}
			}
		}
		return num;
	}

	private void CheckType1_2UnLock(CopyData copyData)
	{
		CopyTypeData copyTypeById = GetCopyTypeById(copyData.CopyType);
		int copyType1_2CopyMaxOpenRank = GetCopyType1_2CopyMaxOpenRank(copyTypeById);
		for (int i = 0; i < copyTypeById.CopyDataList.Count; i++)
		{
			if (copyTypeById.CopyDataList[i].CopyRank <= copyType1_2CopyMaxOpenRank && !copyTypeById.CopyDataList[i].IsLock && !copyTypeById.CopyDataList[i].IsAccessed && !copyTypeById.CopyDataList[i].HasNew)
			{
				UpdateSingleCopyRed(copyTypeById.CopyDataList[i], isRed: true);
			}
		}
		if (copyData.CopyMainId != 2)
		{
			return;
		}
		foreach (CopyTypeData value in GetCopyMainById(2).CopyTypeOpenDic.Values)
		{
			value.UpdateAccessCopy(copyType1_2CopyMaxOpenRank);
			for (int j = 0; j < value.CopyDataList.Count; j++)
			{
				value.CopyDataList[j].UpdatePreviousOpen(copyType1_2CopyMaxOpenRank);
				if (value.CopyDataList[j].CopyRank <= copyType1_2CopyMaxOpenRank && !value.CopyDataList[j].IsLock && !value.CopyDataList[j].IsAccessed && !value.CopyDataList[j].HasNew)
				{
					UpdateSingleCopyRed(value.CopyDataList[j], isRed: true);
				}
			}
		}
	}

	public void LogCopyRed(bool logAll)
	{
		foreach (KeyValuePair<int, CopyRedData> copyRedDataDic in copyRedDataDics)
		{
			if (!logAll)
			{
				_ = copyRedDataDic.Value.isRed;
			}
		}
	}

	private Dictionary<int, int> GetSortDatas()
	{
		if (sortDatas != null)
		{
			return sortDatas;
		}
		sortDatas = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyType1SortDatas();
		return sortDatas;
	}

	public void SaveSortDatas(int copyType, int sort)
	{
		if (sortDatas == null)
		{
			sortDatas = GetSortDatas();
		}
		if (sortDatas.ContainsKey(copyType))
		{
			sortDatas[copyType] = sort;
		}
		else
		{
			sortDatas.Add(copyType, sort);
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveCopyType1SortDatas(sortDatas);
	}

	public int GetSortId(int copyType)
	{
		if (sortDatas == null)
		{
			sortDatas = GetSortDatas();
		}
		if (sortDatas.ContainsKey(copyType))
		{
			return sortDatas[copyType];
		}
		return 0;
	}

	public void ResetCopy1Material()
	{
		if (sortDatas != null)
		{
			sortDatas.Clear();
		}
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveCopyType1SortDatas(sortDatas);
	}

	public void AddEnterCopyTDA(CopyEnterInfoData copyEnterInfoData)
	{
		try
		{
			Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
			dictionary.Add("instance_type", copyEnterInfoData.CopyData.CopyType);
			dictionary.Add("instance_id", copyEnterInfoData.CopyData.Id);
			dictionary.Add("is_match", copyEnterInfoData.IsMatch);
			dictionary.Add("is_single", copyEnterInfoData.IsSingle);
			dictionary.Add("instance_uid", $"{copyEnterInfoData.CheckCode}");
			dictionary.Add("match_time", copyEnterInfoData.MatchTime);
			dictionary.Add("material_id", copyEnterInfoData.MaterialId);
			Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetailsNew(copyEnterInfoData.TeamMembers, dictionary);
			AddAutoFightData(copyEnterInfoData, dictionary);
			if (copyEnterInfoData.IsCampaignBattle || copyEnterInfoData.CopyData.CopyMainId == 91)
			{
				AddCampaignBattleStartTDA(copyEnterInfoData, dictionary);
				dictionary.Clear();
				CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
			}
			else
			{
				TDAHandler.Instance.SendUserEvent("instance_start", dictionary);
				dictionary.Clear();
				CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
		}
	}

	private void AddCampaignBattleStartTDA(CopyEnterInfoData copyEnterInfoData, Dictionary<string, object> allSub)
	{
		CampaignTeamRoomContext campaignTeamRoomContext = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>()?.GetCampaignTeamRoomContext();
		CampaignServiceData.WorldBossInfo worldBossInfo = null;
		CampaignServiceData.DetailInfo detailInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetDetailInfo();
		if (campaignTeamRoomContext != null && detailInfo?.WorldBossInfos != null)
		{
			for (int i = 0; i < detailInfo.WorldBossInfos.Count; i++)
			{
				CampaignServiceData.WorldBossInfo worldBossInfo2 = detailInfo.WorldBossInfos[i];
				if (worldBossInfo2 != null && worldBossInfo2.PlayId == campaignTeamRoomContext.PlayId)
				{
					worldBossInfo = worldBossInfo2;
					break;
				}
			}
		}
		allSub.Add("battle_hero_detail", Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetails(copyEnterInfoData.TeamMembers));
		MultiRoomViewModel multiRoomViewModel = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>()?.GetMultiRoomViewModel();
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyEnterInfoData.CopyData.Id);
		bool flag = multiRoomViewModel?.IsCaptain ?? true;
		allSub.Add("campaign_id", campaignTeamRoomContext?.PlayId);
		allSub.Add("campaign_type", (campaignTeamRoomContext != null) ? campaignTeamRoomContext.AreaType.ToString() : string.Empty);
		allSub.Add("monstergroup_area", worldBossInfo?.PointId ?? campaignTeamRoomContext?.PointId ?? 0);
		allSub.Add("monstergroup_uid", copyEnterInfoData.CopyData.Id);
		allSub.Add("asset_id", (dataRow != null && dataRow.CostId > 0) ? $"{dataRow.CostId}" : string.Empty);
		allSub.Add("hp_left_before", worldBossInfo?.BossHP ?? 0);
		allSub.Add("number_left_before", worldBossInfo?.Times ?? 0);
		allSub.Add("is_boss_initiator", flag);
		Dictionary<string, object> dictionary = new Dictionary<string, object>();
		dictionary.Add("id", dataRow?.CostId ?? 0);
		dictionary.Add("num", dataRow?.CostNum ?? 0);
		dictionary.Add("type", dataRow?.CostType ?? 0);
		allSub.Add("cost_detail", dictionary);
		TDAHandler.Instance.SendUserEvent("campaignbattle_start", allSub);
	}

	private void AddAutoFightData(CopyEnterInfoData copyEnterInfoData, Dictionary<string, object> allSub)
	{
		bool flag = false;
		bool flag2 = GameEntry.Setting.GetBool("自动战斗时使用战斗道具");
		bool flag3 = GameEntry.Setting.GetBool("沿用自动战斗设置");
		DRCopyType dataRow = GameEntry.DataTable.GetDataRow<DRCopyType>(copyEnterInfoData.CopyData.CopyType);
		switch ((!copyEnterInfoData.IsSingle) ? dataRow.CoopAuto : dataRow.SoloAuto)
		{
		case 2:
			flag = true;
			break;
		case 0:
			flag = false;
			break;
		case 1:
			if (flag3)
			{
				flag = PlayerPrefs.GetInt("AutoFightState", 0) == 1;
			}
			break;
		}
		allSub.Add("is_SoloAuto", flag);
		allSub.Add("is_AutoItem", flag2);
		allSub.Add("is_InheritAutoStatus", flag3);
	}

	public void AddExitCopyTDA(CopyEnterInfoData copyEnterInfoData, float duration, int skilledMonsterId, int score, Dictionary<int, BattleRecordPointInfo> recordPointInfos, int star, AutoFightStatistics autoFightStatistics, long rankScore, long totalDamage)
	{
		try
		{
			Dictionary<string, object> dictionary = CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Get();
			dictionary.Add("instance_type", copyEnterInfoData.CopyData.CopyType);
			dictionary.Add("instance_id", copyEnterInfoData.CopyData.Id);
			dictionary.Add("instance_uid", $"{copyEnterInfoData.CheckCode}");
			dictionary.Add("material_id", copyEnterInfoData.MaterialId);
			dictionary.Add("is_match", copyEnterInfoData.IsMatch);
			dictionary.Add("is_single", copyEnterInfoData.IsSingle);
			dictionary.Add("match_time", copyEnterInfoData.MatchTime);
			Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetailsNew(copyEnterInfoData.TeamMembers, dictionary);
			dictionary.Add("reason", $"{skilledMonsterId}");
			dictionary.Add("duration", duration);
			dictionary.Add("battle_point", score);
			dictionary.Add("rank_point", rankScore);
			dictionary.Add("battle_star", star);
			List<Dictionary<string, object>> list = new List<Dictionary<string, object>>();
			List<Dictionary<string, object>> list2 = new List<Dictionary<string, object>>();
			dictionary.Add("skill_detail", list);
			dictionary.Add("battle_ecord", list2);
			dictionary.Add("is_SoloAuto", autoFightStatistics.AutoFightState);
			dictionary.Add("is_AutoItem", autoFightStatistics.OpenUseProp);
			dictionary.Add("is_InheritAutoStatus", autoFightStatistics.UseLastAutoFightState);
			dictionary.Add("AutoBattleCount", autoFightStatistics.OpenCount);
			dictionary.Add("ChangeAutoDelay", autoFightStatistics.AutoFightTimer);
			dictionary.Add("ChangeAutoDelay_starttime", autoFightStatistics.OpenAutoFightTime);
			dictionary.Add("ChangeAutoDelay_endtime", autoFightStatistics.CloseAutoFightTime);
			dictionary.Add("is_Autobattle", autoFightStatistics.TimerOutAutoOpen);
			if (recordPointInfos != null)
			{
				foreach (KeyValuePair<int, BattleRecordPointInfo> recordPointInfo in recordPointInfos)
				{
					int index = 0;
					for (int i = 0; i < copyEnterInfoData.TeamMembers.Count; i++)
					{
						if (copyEnterInfoData.TeamMembers[i].MemberId == recordPointInfo.Key)
						{
							index = i;
							break;
						}
					}
					Dictionary<string, object> dictionary2 = new Dictionary<string, object>();
					List<Dictionary<string, float>> list3 = new List<Dictionary<string, float>>();
					foreach (KeyValuePair<int, Dictionary<string, float>> item in recordPointInfo.Value.skill_detaill)
					{
						list3.Add(item.Value);
					}
					dictionary2.Add("player_id", copyEnterInfoData.TeamMembers[index].uid);
					dictionary2.Add("id", copyEnterInfoData.TeamMembers[index].HeroModel.Id);
					dictionary2.Add("skill", list3);
					list.Add(dictionary2);
					Dictionary<string, object> dictionary3 = new Dictionary<string, object>();
					dictionary3.Add("player_id", copyEnterInfoData.TeamMembers[index].uid);
					dictionary3.Add("id", copyEnterInfoData.TeamMembers[index].HeroModel.Id);
					dictionary3.Add("ecord", recordPointInfo.Value.recordPointDic);
					list2.Add(dictionary3);
				}
			}
			if (copyEnterInfoData.IsCampaignBattle || copyEnterInfoData.CopyData.CopyMainId == 91)
			{
				AddCampaignBattleEndTDA(copyEnterInfoData, dictionary, totalDamage);
				dictionary.Clear();
				CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
			}
			else
			{
				TDAHandler.Instance.SendUserEvent("instance_finish", dictionary);
				dictionary.Clear();
				CollectionPool<Dictionary<string, object>, KeyValuePair<string, object>>.Release(dictionary);
			}
		}
		catch (Exception ex)
		{
			Log.Error(ex.Message + " / " + ex.StackTrace);
		}
	}

	public void AddCampaignBattleEndTDA(CopyEnterInfoData copyEnterInfoData, Dictionary<string, object> allSub, long totalDamage)
	{
		CampaignTeamRoomContext campaignTeamRoomContext = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>()?.GetCampaignTeamRoomContext();
		CampaignServiceData.WorldBossInfo worldBossInfo = null;
		CampaignServiceData.DetailInfo detailInfo = Singleton<ServiceSystem>.Instance.GetService<ICampaignService>()?.GetDetailInfo();
		if (campaignTeamRoomContext != null && detailInfo?.WorldBossInfos != null)
		{
			for (int i = 0; i < detailInfo.WorldBossInfos.Count; i++)
			{
				CampaignServiceData.WorldBossInfo worldBossInfo2 = detailInfo.WorldBossInfos[i];
				if (worldBossInfo2 != null && worldBossInfo2.PlayId == campaignTeamRoomContext.PlayId)
				{
					worldBossInfo = worldBossInfo2;
					break;
				}
			}
		}
		allSub.Add("battle_hero_detail", Singleton<ServiceSystem>.Instance.GetService<IHeroService>().GetHeroDetails(copyEnterInfoData.TeamMembers));
		MultiRoomViewModel multiRoomViewModel = Singleton<ServiceSystem>.Instance.GetService<IMultiRoomService>()?.GetMultiRoomViewModel();
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(copyEnterInfoData.CopyData.Id);
		bool flag = multiRoomViewModel?.IsCaptain ?? true;
		allSub.Add("campaign_id", campaignTeamRoomContext?.PlayId);
		allSub.Add("campaign_type", (campaignTeamRoomContext != null) ? campaignTeamRoomContext.AreaType.ToString() : string.Empty);
		allSub.Add("monstergroup_area", worldBossInfo?.PointId ?? campaignTeamRoomContext?.PointId ?? 0);
		allSub.Add("monstergroup_uid", copyEnterInfoData.CopyData.Id);
		allSub.Add("asset_id", (dataRow != null && dataRow.CostId > 0) ? $"{dataRow.CostId}" : string.Empty);
		allSub.Add("hp_left_before", worldBossInfo?.BossHP ?? 0);
		allSub.Add("number_left_before", worldBossInfo?.Times ?? 0);
		allSub.Add("is_boss_initiator", flag);
		long num = (worldBossInfo?.BossHP ?? 0) - totalDamage;
		long num2 = (worldBossInfo?.Times ?? 0) - 1;
		allSub.Add("hp_left_after", (num >= 0) ? num : 0);
		allSub.Add("number_left_after", (num2 >= 0) ? num2 : 0);
		Dictionary<string, object> dictionary = new Dictionary<string, object>();
		dictionary.Add("id", dataRow?.CostId ?? 0);
		dictionary.Add("num", dataRow?.CostNum ?? 0);
		dictionary.Add("type", dataRow?.CostType ?? 0);
		allSub.Add("cost_detail", dictionary);
		TDAHandler.Instance.SendUserEvent("campaignbattle_end", allSub);
	}

	public void PlayUnlockEffect(CopyMainData data)
	{
		data.PlayUnlockEffect();
		SavePlayUnlockEffect(0, data.MainId);
	}

	public void PlayUnlockEffect(CopyTypeData data)
	{
		data.PlayUnlockEffect();
		SavePlayUnlockEffect(1, data.CopyTypeId);
	}

	public void PlayUnlockEffect(CopyData data)
	{
		data.PlayUnlockEffect();
		SavePlayUnlockEffect(2, data.Id);
	}

	private void SavePlayUnlockEffect(int type, int id)
	{
		saveData.SaveEffectPlay(type, id);
	}

	public void SaveEffectPlay()
	{
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveCopyUnlockSaveData(saveData);
	}

	private void LoadPlayUnlockEffect()
	{
		saveData = Singleton<ServiceSystem>.Instance.GetService<ICopyService>().GetCopyUnlockSaveData();
		for (int i = 0; i < mainDataList.Count; i++)
		{
			mainDataList[i].SetPlayUnlockEffect(saveData.GetEffectPlay(0, mainDataList[i].MainId));
			foreach (CopyTypeData value in mainDataList[i].CopyTypeOpenDic.Values)
			{
				value.SetPlayUnlockEffect(saveData.GetEffectPlay(1, value.CopyTypeId));
				for (int j = 0; j < value.CopyDataList.Count; j++)
				{
					value.CopyDataList[j].SetPlayUnlockEffect(saveData.GetEffectPlay(2, value.CopyDataList[j].Id));
				}
			}
		}
	}

	public void ResetCopyPlayUnlockEffect()
	{
		for (int i = 0; i < mainDataList.Count; i++)
		{
			mainDataList[i].ResetPlayUnlockEffect();
			foreach (CopyTypeData value in mainDataList[i].CopyTypeOpenDic.Values)
			{
				value.ResetPlayUnlockEffect();
				for (int j = 0; j < value.CopyDataList.Count; j++)
				{
					value.CopyDataList[j].ResetPlayUnlockEffect();
				}
			}
		}
		saveData.Clear();
		Singleton<ServiceSystem>.Instance.GetService<ICopyService>().SaveCopyUnlockSaveData(saveData);
	}

	public int GetLastSelectCopyId(CopyTypeData itemVmData)
	{
		try
		{
			if (saveData == null)
			{
				saveData = Singleton<ServiceSystem>.Instance?.GetService<ICopyService>()?.GetCopyUnlockSaveData();
			}
			return saveData.GetLastSelectCopyId(itemVmData.CopyTypeId);
		}
		catch (Exception ex)
		{
			Log.Error("保存副本数据发生异常！ " + ex.Message + " / " + ex.StackTrace);
		}
		return 0;
	}

	public void SaveLastSelectCopyId(CopyData itemVmData)
	{
		try
		{
			if (saveData == null)
			{
				saveData = Singleton<ServiceSystem>.Instance?.GetService<ICopyService>()?.GetCopyUnlockSaveData();
			}
			saveData.SaveLastSelectCopyId(itemVmData.CopyType, itemVmData.Id);
			Singleton<ServiceSystem>.Instance?.GetService<ICopyService>()?.SaveCopyUnlockSaveData(saveData);
		}
		catch (Exception ex)
		{
			Log.Error("保存副本数据发生异常！ " + ex.Message + " / " + ex.StackTrace);
		}
	}

	public void LoadActivityCopys()
	{
		if (activityTryCopys != null)
		{
			return;
		}
		DRActivityTry[] activityTrys = GameEntry.DataTable.GetAllDataRow<DRActivityTry>();
		activityTryCopys = new Dictionary<int, CopyData>();
		int i;
		for (i = 0; i < activityTrys.Length; i++)
		{
			CopyData copyData = null;
			DRCopy dataRow = GameEntry.DataTable.GetDataRow((DRCopy p) => p.Id == activityTrys[i].ActivityCopyId);
			if (dataRow != null)
			{
				copyData = CopyData.CreateActivityCopy(activityTrys[i], dataRow);
				if (!activityTryCopys.ContainsKey(copyData.Id))
				{
					activityTryCopys.Add(copyData.Id, copyData);
				}
			}
		}
	}

	public void LoadActivityVersionCopys(int activtityTypeId)
	{
		if (activityVersionCopys == null)
		{
			activityVersionCopys = new Dictionary<int, List<CopyData>>();
		}
		if (!activityVersionCopys.ContainsKey(activtityTypeId))
		{
			activityVersionCopys.Add(activtityTypeId, new List<CopyData>());
		}
		DRVersionActivity[] versionActivities = GameEntry.DataTable.GetDataRows((DRVersionActivity p) => p.Type == 2);
		int i;
		for (i = 0; i < versionActivities.Length; i++)
		{
			DRCopy dataRow = GameEntry.DataTable.GetDataRow((DRCopy p) => p.Id == versionActivities[i].Content);
			if (dataRow != null)
			{
				CopyData copyData = CopyData.CreateActivityCopy(versionActivities[i], dataRow);
				activityVersionCopys[activtityTypeId].Add(copyData);
				if (!copyDatas.ContainsKey(dataRow.Id))
				{
					copyDatas.Add(dataRow.Id, copyData);
				}
			}
		}
	}

	private void CompleteVersionCopy(CopyData copyData)
	{
		Singleton<ServiceSystem>.Instance.GetService<IOpActivityService>().GetActivityVm().UpdateActivityVersionProgress(copyData.ActivityTypeId, copyData.ActivityId, copyData.StarCur);
	}

	public CopyData GetActivityCopyById(int copyId)
	{
		if (activityTryCopys == null)
		{
			return null;
		}
		if (activityTryCopys.ContainsKey(copyId))
		{
			return activityTryCopys[copyId];
		}
		return null;
	}

	public CopyData GetActivityCopyByIdFromCopy(DRActivityTry activityTry, int activityCopyId)
	{
		DRCopy dataRow = GameEntry.DataTable.GetDataRow<DRCopy>(activityCopyId);
		if (dataRow != null)
		{
			return CopyData.CreateActivityCopy(activityTry, dataRow);
		}
		return null;
	}

	public void LoadActivityChallengeCopys(DRChallengeCopy[] challengeCopies, int activtityTypeId)
	{
		if (activityChallengeCopys == null)
		{
			activityChallengeCopys = new Dictionary<int, List<CopyData>>();
		}
		if (!activityChallengeCopys.ContainsKey(activtityTypeId))
		{
			activityChallengeCopys.Add(activtityTypeId, new List<CopyData>());
		}
		int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
		long maxCopyOpenIndex = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().MaxCopyOpenIndex;
		int i;
		for (i = 0; i < challengeCopies.Length; i++)
		{
			DRCopy dataRow = GameEntry.DataTable.GetDataRow((DRCopy p) => p.Id == challengeCopies[i].RefreshType);
			if (dataRow != null)
			{
				CopyData copyData = null;
				if (copyDatas.ContainsKey(dataRow.Id))
				{
					copyData = copyDatas[dataRow.Id];
					copyData.RefreshActivityChallenge(challengeCopies[i], activtityTypeId);
				}
				else
				{
					copyData = CopyData.CreateActivityChallengeCopy(dataRow, challengeCopies[i], activtityTypeId, level, maxCopyOpenIndex);
					copyDatas.Add(dataRow.Id, copyData);
				}
				activityChallengeCopys[activtityTypeId].Add(copyData);
			}
		}
	}

	public CopyData GetActivityChallengeCopyById(int activityTypeId, int copyId)
	{
		if (activityChallengeCopys == null)
		{
			return null;
		}
		if (activityChallengeCopys.ContainsKey(activityTypeId))
		{
			for (int i = 0; i < activityChallengeCopys[activityTypeId].Count; i++)
			{
				if (activityChallengeCopys[activityTypeId][i].Id == copyId)
				{
					return activityChallengeCopys[activityTypeId][i];
				}
			}
		}
		return null;
	}

	private void UpdatePlayerLevelChallengeCopy(int playerLevel)
	{
		if (activityChallengeCopys == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<CopyData>> activityChallengeCopy in activityChallengeCopys)
		{
			if (activityChallengeCopy.Value != null && activityChallengeCopy.Value.Count > 0)
			{
				for (int i = 0; i < activityChallengeCopy.Value.Count; i++)
				{
					activityChallengeCopy.Value[i].UpdatePlayerLevel(playerLevel);
				}
			}
		}
	}

	private void UpdateMaxCopyIdxChallengeCopy(long maxCopyOpenIndex)
	{
		if (activityChallengeCopys == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<CopyData>> activityChallengeCopy in activityChallengeCopys)
		{
			if (activityChallengeCopy.Value != null && activityChallengeCopy.Value.Count > 0)
			{
				for (int i = 0; i < activityChallengeCopy.Value.Count; i++)
				{
					activityChallengeCopy.Value[i].UpdateTaskProgress(maxCopyOpenIndex);
				}
			}
		}
	}

	public void LoadActivityEquipCopys(List<DRCopyKit> copyKits, int activityTypeId)
	{
		if (activityEquipCopys == null)
		{
			activityEquipCopys = new Dictionary<int, CopyData>();
		}
		int level = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Level;
		int i;
		for (i = 0; i < copyKits.Count; i++)
		{
			DRCopy dataRow = GameEntry.DataTable.GetDataRow((DRCopy p) => p.Id == copyKits[i].Id);
			if (dataRow != null)
			{
				CopyData copyData = null;
				if (copyDatas.ContainsKey(dataRow.Id))
				{
					copyData = copyDatas[dataRow.Id];
					copyData.RefreshActivityEquip(copyKits[i], activityTypeId);
				}
				else
				{
					copyData = CopyData.CreateActivityEquipCopy(dataRow, copyKits[i], activityTypeId, level);
					copyDatas.Add(dataRow.Id, copyData);
				}
				if (activityEquipCopys.ContainsKey(dataRow.Id))
				{
					activityEquipCopys[dataRow.Id] = copyData;
				}
				else
				{
					activityEquipCopys.Add(dataRow.Id, copyData);
				}
			}
		}
	}

	public CopyData GetActivityEquipCopyById(int copyId)
	{
		if (activityEquipCopys == null)
		{
			return null;
		}
		if (activityEquipCopys.ContainsKey(copyId))
		{
			return activityEquipCopys[copyId];
		}
		return null;
	}

	public void InitTowerTalentData()
	{
		drTowerTalents = GameEntry.DataTable.GetAllDataRow<DRTowerTalent>();
	}

	public void ResetTowerTalentViewModel()
	{
		foreach (TowerTalentViewModel value in towerTalentData.Values)
		{
			value.TalntLevel = 0;
			value.CanUpLevel = false;
			value.UnLock = false;
			value.UnLockTalent = null;
			value.UnLockOrder = null;
			value.UnLockNum = 0;
		}
	}

	public void GetDefaultUnLockTowerTalent()
	{
		int num = 0;
		int num2 = 0;
		DRTowerTalent[] array = drTowerTalents;
		foreach (DRTowerTalent dRTowerTalent in array)
		{
			towerTalentData.TryGetValue(dRTowerTalent.Talent, out var value);
			if (value == null)
			{
				value = new TowerTalentViewModel(dRTowerTalent.Type, dRTowerTalent.Talent, dRTowerTalent.Icon, dRTowerTalent.Tag);
				value.TalntLevel = 0;
				value.UnLock = false;
				towerTalentData.Add(dRTowerTalent.Talent, value);
			}
			if (dRTowerTalent.Order == 1)
			{
				if (dRTowerTalent.UnlockTalent == null || dRTowerTalent.UnlockTalent.Count <= 0)
				{
					value.UnLock = true;
					if (num != dRTowerTalent.NeedId)
					{
						num = dRTowerTalent.NeedId;
						num2 = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(dRTowerTalent.NeedId, emptyCreate: true)?.Amount ?? 0;
					}
					if (num2 >= dRTowerTalent.NeedNum)
					{
						value.CanUpLevel = true;
					}
				}
				else
				{
					value.UnLockTalent = dRTowerTalent.UnlockTalent;
					value.UnLockOrder = dRTowerTalent.UnlockOrder;
					value.UnLockNum = dRTowerTalent.UnlockNum;
				}
			}
			if (value.MaxLevel < dRTowerTalent.Order)
			{
				value.MaxLevel = dRTowerTalent.Order;
			}
		}
	}

	public void SetTowerTalentLevel(int talentId, int talentLevel, bool playEffect)
	{
		if (towerTalentData.TryGetValue(talentId, out var value))
		{
			if (playEffect)
			{
				value.PlayUpLevelEffect();
			}
			value.TalntLevel = talentLevel;
			value.UnLock = true;
			if (value.MaxLevel == talentLevel)
			{
				value.UnLockNum = 0;
				value.UnLockOrder = null;
				value.UnLockTalent = null;
				value.CanUpLevel = false;
				return;
			}
			DRTowerTalent[] array = drTowerTalents;
			foreach (DRTowerTalent dRTowerTalent in array)
			{
				if (dRTowerTalent.Talent == talentId && dRTowerTalent.Order == talentLevel + 1 && dRTowerTalent.UnlockOrder.Count > 0)
				{
					value.UnLock = false;
					value.UnLockNum = dRTowerTalent.UnlockNum;
					value.UnLockOrder = dRTowerTalent.UnlockOrder;
					value.UnLockTalent = dRTowerTalent.UnlockTalent;
				}
			}
		}
		else
		{
			Log.Error("爬塔天赋有异常");
		}
	}

	public void UpdateTowerTalentCanUp()
	{
		foreach (KeyValuePair<int, TowerTalentViewModel> towerTalentDatum in towerTalentData)
		{
			if (towerTalentDatum.Value.UnLock)
			{
				UpdateTalentCanUpLevel(towerTalentDatum.Key, towerTalentDatum.Value);
			}
		}
		UpTalentRedPoint(broadcastMessage: true);
	}

	public void UpdateTowerTalentUnLockLevel()
	{
		foreach (KeyValuePair<int, TowerTalentViewModel> towerTalentDatum in towerTalentData)
		{
			if (towerTalentDatum.Value.UnLock)
			{
				UpdateTalentCanUpLevel(towerTalentDatum.Key, towerTalentDatum.Value);
				continue;
			}
			towerTalentDatum.Value.CanUpLevel = false;
			if (towerTalentDatum.Value.UnLockTalent == null)
			{
				continue;
			}
			int num = towerTalentDatum.Value.UnLockNum;
			if (num == 0)
			{
				num = towerTalentDatum.Value.UnLockTalent.Count;
			}
			for (int i = 0; i < towerTalentDatum.Value.UnLockTalent.Count; i++)
			{
				int key = towerTalentDatum.Value.UnLockTalent[i];
				int num2 = towerTalentDatum.Value.UnLockOrder[i];
				if (towerTalentData[key].TalntLevel >= num2)
				{
					num--;
					if (num <= 0)
					{
						towerTalentDatum.Value.UnLock = true;
						UpdateTalentCanUpLevel(towerTalentDatum.Key, towerTalentDatum.Value);
						break;
					}
				}
				else if (num == 0)
				{
					break;
				}
			}
		}
		UpTalentRedPoint(broadcastMessage: true);
	}

	public bool UpTalentRedPoint(bool broadcastMessage)
	{
		foreach (TowerTalentViewModel value in towerTalentData.Values)
		{
			if (value.CanUpLevel)
			{
				if (broadcastMessage)
				{
					Context.GetApplicationContext().GetService<IMessenger>().Publish(new ClimbTowerActivityMessager(this, true, null));
				}
				return true;
			}
		}
		if (broadcastMessage)
		{
			Context.GetApplicationContext().GetService<IMessenger>().Publish(new ClimbTowerActivityMessager(this, false, null));
		}
		return false;
	}

	public void UpdateTalentCanUpLevel(int talentId, TowerTalentViewModel towerTalentData)
	{
		if (towerTalentData.TalntLevel == towerTalentData.MaxLevel || !towerTalentData.UnLock)
		{
			towerTalentData.CanUpLevel = false;
			return;
		}
		DRTowerTalent[] array = drTowerTalents;
		foreach (DRTowerTalent dRTowerTalent in array)
		{
			if (dRTowerTalent.Talent == talentId && dRTowerTalent.Order == towerTalentData.TalntLevel + 1)
			{
				int num = 0;
				num = Singleton<ServiceSystem>.Instance.GetService<IKnapsackService>().GetKnapsackViewModel().GetProp(dRTowerTalent.NeedId, emptyCreate: true)?.Amount ?? 0;
				towerTalentData.CanUpLevel = num >= dRTowerTalent.NeedNum;
				break;
			}
		}
	}

	public List<int> GetTowerTalentBuff()
	{
		List<int> list = new List<int>(10);
		DRTowerTalent[] array = drTowerTalents;
		foreach (DRTowerTalent dRTowerTalent in array)
		{
			towerTalentData.TryGetValue(dRTowerTalent.Talent, out var value);
			if (value.TalntLevel == dRTowerTalent.Order)
			{
				list.Add(dRTowerTalent.BattleBuffId);
			}
		}
		return list;
	}

	public List<int> GetTowerRogueBuff()
	{
		List<int> list = new List<int>(6);
		if (towerRogueData == null)
		{
			return list;
		}
		list.AddRange(towerRogueData.RogueBuffs);
		return list;
	}

	public int GetTowerRogueRefreshCount()
	{
		if (towerRogueData == null)
		{
			return 0;
		}
		return towerRogueData.RefreshCount;
	}

	public void SetTowerBuffData(List<int> selectBuffs, int refreshCount, int roleId, int teamId, List<int> battlePropIds, int maxLayer, int endlessIndex)
	{
		towerRogueData.RefreshCount = refreshCount;
		towerRogueData.RogueBuffs.Clear();
		if (selectBuffs != null)
		{
			towerRogueData.RogueBuffs.AddRange(selectBuffs);
		}
		towerRogueData.RefreshCount = refreshCount;
		SetTowerBattleData(roleId, teamId, battlePropIds);
		towerRogueData.MaxLayer = maxLayer;
		towerRogueData.EndlessLayer = endlessIndex;
	}

	public void SetTowerBattleData(int roleId, int teamId, List<int> battlePropIds)
	{
		towerRogueData.RoleId = roleId;
		towerRogueData.TryTeamId = teamId;
		towerRogueData.BattlePropIds.Clear();
		if (battlePropIds != null)
		{
			towerRogueData.BattlePropIds.AddRange(battlePropIds);
		}
	}

	public int GetCurChallengeTowerLayer()
	{
		if (towerRogueData == null)
		{
			return 0;
		}
		return towerRogueData.MaxLayer;
	}

	public int GetTowerEndlessLayer()
	{
		if (towerRogueData == null)
		{
			return 0;
		}
		return towerRogueData.EndlessLayer;
	}

	public void UpdateBuffData(List<int> selectBuffs, int refreshCount, int towerNum, int endless)
	{
		towerRogueData.RefreshCount = refreshCount;
		towerRogueData.RogueBuffs.Clear();
		towerRogueData.RogueBuffs.AddRange(selectBuffs);
		towerRogueData.MaxLayer = towerNum;
		towerRogueData.EndlessLayer = endless;
	}

	public void GetTowerBattleData(out int roleId, out int teamSetId, List<int> propIds)
	{
		roleId = towerRogueData.RoleId;
		teamSetId = towerRogueData.TryTeamId;
		propIds.Clear();
		propIds.AddRange(towerRogueData.BattlePropIds);
	}

	public void ClearTowerBuffData()
	{
		towerRogueData.RogueBuffs.Clear();
		towerRogueData.RefreshCount = 0;
		towerRogueData.BattlePropIds.Clear();
		towerRogueData.TryTeamId = 0;
		towerRogueData.RoleId = 0;
		towerRogueData.MaxLayer = 0;
		towerRogueData.EndlessLayer = 0;
	}

	public void AddActivityTowerCopyData(int copyId, CopyData copyData)
	{
		towerCopyType = copyData.CopyType;
		if (!copyDatas.ContainsKey(copyId))
		{
			copyDatas.Add(copyId, copyData);
			int maxOpenRankPass = 1;
			if (accessCopys != null && accessCopys.ContainsKey(copyData.CopyType))
			{
				maxOpenRankPass = accessCopys[copyData.CopyType];
			}
			copyData.UpdatePreviousOpen(maxOpenRankPass, forceCheck: true);
		}
	}

	public int GetTowerMaxLayerCopyId()
	{
		return GameEntry.DataTable.GetDataRow((DRCopy x) => x.CopyType == towerCopyType && x.CopyRank == towerRogueData.MaxLayer)?.Id ?? 0;
	}

	public int GetNextLayerCopyId()
	{
		return GameEntry.DataTable.GetDataRow((DRCopy x) => x.CopyType == towerCopyType && x.CopyRank == towerRogueData.MaxLayer + 1)?.Id ?? 0;
	}

	public (bool, GAECopyShowTypeEnum) CheckGuildCopy(CopyData copyData)
	{
		bool item = false;
		GAECopyShowTypeEnum item2 = GAECopyShowTypeEnum.Normal;
		if (copyData.CopyMainId == Constant.ConstantConfig.GuildCopyType)
		{
			item = true;
			DRGuildCopy dataRow = GameEntry.DataTable.GetDataRow((DRGuildCopy p) => p.GuildCopyId == copyData.Id);
			if (dataRow != null && dataRow.CopyType == 2)
			{
				item2 = GAECopyShowTypeEnum.Final;
			}
		}
		return (item, item2);
	}

	public void AddGuildCopy(CopyData copyData)
	{
		if (copyDatas == null)
		{
			copyDatas = new Dictionary<int, CopyData>();
		}
		if (copyDatas.ContainsKey(copyData.Id))
		{
			copyDatas[copyData.Id] = copyData;
		}
		else
		{
			copyDatas.Add(copyData.Id, copyData);
		}
	}
}
