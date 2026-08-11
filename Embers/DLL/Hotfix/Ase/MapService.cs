#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using GameFramework;
using UnityEngine;

namespace Ase;

public class MapService : IMapService
{
	private int playerMark = 101;

	private const string PlayerMarkKey = "MapPlayerMark";

	public MapService()
	{
		playerMark = PlayerPrefs.GetInt(GetCacheKey(), playerMark);
	}

	public async Task<bool> RequestOpenMap(int id)
	{
		C2H_OpenMapRequest rst = C2H_OpenMapRequest.Create();
		rst.MapId = id;
		H2C_OpenMapResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_OpenMapResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "开启地图") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "开启地图失败"))
			{
				return true;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	public async Task<bool> RequestMapState(int id)
	{
		C2H_GetMapStatusRequest rst = C2H_GetMapStatusRequest.Create();
		rst.MapId = id;
		H2C_GetMapStatusResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<H2C_GetMapStatusResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取地图开启状态") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取地图开启状态失败"))
			{
				return !response.OpenStatus;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
			return false;
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
			return false;
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return false;
	}

	private string GetCacheKey()
	{
		long valueOrDefault = (Singleton<ServiceSystem>.Instance.GetService<IRoleService>()?.GetRoleData()?.PlayerInfo?.Uid).GetValueOrDefault();
		return string.Format("{0}_{1}", "MapPlayerMark", valueOrDefault);
	}

	public int GetPlayerMark()
	{
		return playerMark;
	}

	public void SetPlayerMark(int levelId)
	{
		PlayerPrefs.SetInt(GetCacheKey(), levelId);
		playerMark = levelId;
	}

	public List<DRMap> GetAllLevelOpened()
	{
		List<DRMap> list = new List<DRMap>();
		DRMap[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRMap>();
		if (allDataRow == null)
		{
			return list;
		}
		DRMap[] array = allDataRow;
		foreach (DRMap dRMap in array)
		{
			if (GetLevelOpenState(dRMap))
			{
				list.Add(dRMap);
			}
		}
		return list;
	}

	public List<DRSectionMap> GetAllSectionOpened()
	{
		List<DRSectionMap> list = new List<DRSectionMap>();
		List<DRMap> allLevelOpened = GetAllLevelOpened();
		if (allLevelOpened == null)
		{
			return list;
		}
		foreach (DRMap drMap in allLevelOpened)
		{
			if (!list.Exists((DRSectionMap p) => p.Id.Equals(drMap.MapId)))
			{
				DRSectionMap dataRow = GameEntry.DataTable.GetDataRow<DRSectionMap>(drMap.MapId);
				if (dataRow != null)
				{
					list.Add(dataRow);
				}
			}
		}
		return list;
	}

	public List<DRWorldMap> GetAllWorldOpened()
	{
		List<DRWorldMap> list = new List<DRWorldMap>();
		List<DRSectionMap> allSectionOpened = GetAllSectionOpened();
		if (allSectionOpened == null)
		{
			return list;
		}
		foreach (DRSectionMap drSectionMap in allSectionOpened)
		{
			if (!list.Exists((DRWorldMap p) => p.Id.Equals(drSectionMap.WorldId)))
			{
				DRWorldMap dataRow = GameEntry.DataTable.GetDataRow<DRWorldMap>(drSectionMap.WorldId);
				if (dataRow != null)
				{
					list.Add(dataRow);
				}
			}
		}
		return list;
	}

	public bool GetLevelOpenState(int id)
	{
		DRMap dataRow = GameEntry.DataTable.GetDataRow<DRMap>(id);
		if (dataRow == null)
		{
			return false;
		}
		return GetLevelOpenState(dataRow);
	}

	public bool GetLevelOpenState(DRMap drMap)
	{
		bool result = false;
		if (drMap.OpenType == 1)
		{
			TaskDataViewModel taskDataViewModel = Singleton<ServiceSystem>.Instance.GetService<ITaskServices>()?.GetCurrentMainTask();
			if (taskDataViewModel == null)
			{
				return result;
			}
			result = taskDataViewModel.CopyOpen > drMap.Open || (taskDataViewModel.CopyOpen == drMap.Open && taskDataViewModel.IsOpenTask);
		}
		return result;
	}

	public bool GetSectionOpenState(int id)
	{
		List<DRMap> allLevelOpened = GetAllLevelOpened();
		if (allLevelOpened == null)
		{
			return false;
		}
		foreach (DRMap item in allLevelOpened)
		{
			if (item.MapId.Equals(id))
			{
				return true;
			}
		}
		return false;
	}

	public bool GetWorldOpenState(int id)
	{
		List<DRSectionMap> allSectionOpened = GetAllSectionOpened();
		if (allSectionOpened == null)
		{
			return false;
		}
		foreach (DRSectionMap item in allSectionOpened)
		{
			if (item.WorldId.Equals(id))
			{
				return true;
			}
		}
		return false;
	}

	public List<DRMap> GetAllLevelInSection(int sectionId)
	{
		List<DRMap> allLevelOpened = GetAllLevelOpened();
		List<DRMap> obj = ((allLevelOpened == null) ? new List<DRMap>() : allLevelOpened.FindAll((DRMap p) => p.MapId.Equals(sectionId)));
		obj.Sort((DRMap a, DRMap b) => a.DisplayPriority.CompareTo(b.DisplayPriority));
		return obj;
	}

	public List<DRSectionMap> GetAllSectionInWorld(int worldId)
	{
		List<DRSectionMap> allSectionOpened = GetAllSectionOpened();
		List<DRSectionMap> obj = ((allSectionOpened == null) ? new List<DRSectionMap>() : allSectionOpened.FindAll((DRSectionMap p) => p.WorldId.Equals(worldId)));
		obj.Sort((DRSectionMap a, DRSectionMap b) => a.DisplayPriority.CompareTo(b.DisplayPriority));
		return obj;
	}

	public int GetLatestLevelInSection(int sectionId)
	{
		int levelId = 0;
		List<DRMap> allLevelInSection = GetAllLevelInSection(sectionId);
		if (allLevelInSection == null)
		{
			return levelId;
		}
		int curPriority = -1;
		allLevelInSection.ForEach(delegate(DRMap p)
		{
			if (p.DisplayPriority > curPriority)
			{
				levelId = p.Id;
				curPriority = p.DisplayPriority;
			}
		});
		return levelId;
	}

	public DRMap GetLevelWithLatestMainTask()
	{
		return null;
	}

	public async Task<(List<PbIdValue>, int)> GetCollectionsForStory(int mapId)
	{
		List<PbIdValue> list = new List<PbIdValue>();
		int collection = 0;
		GetStoryBoxLevelRequest rst = GetStoryBoxLevelRequest.Create();
		rst.MapId = mapId;
		GetStoryBoxLevelResponse response = null;
		try
		{
			response = await Singleton<NetworkSystem>.Instance.Call<GetStoryBoxLevelResponse>(rst);
			if (Singleton<NetResponseHandler>.Instance.ValidateResponse(response, "获取关卡收集度数据") && Singleton<NetResponseHandler>.Instance.ValidateErrorCode(response.Error, "获取关卡收集度数据失败"))
			{
				list = response.OpenCounts;
				collection = response.Collection;
			}
		}
		catch (TimeoutException)
		{
			Toast.ShowInfo("网络信号弱，请稍后再试");
		}
		catch (Exception ex2)
		{
			Log.Error(ex2?.ToString() + ex2.StackTrace);
		}
		finally
		{
			rst.Dispose();
			response?.Dispose();
		}
		return (list, collection);
	}
}
