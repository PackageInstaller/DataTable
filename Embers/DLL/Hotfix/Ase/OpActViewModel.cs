#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using GameFramework;
using GameFramework.Runtime;
using Newtonsoft.Json;
using UnityEngine;

namespace Ase;

public class OpActViewModel : ViewModelBase
{
	private IMessenger messenger;

	private Dictionary<int, ActivityViewModelBase> _activityViewModels = new Dictionary<int, ActivityViewModelBase>();

	private List<int> propChangeActivtiyTypeIds;

	private Dictionary<int, bool> _activityReds = new Dictionary<int, bool>();

	private Dictionary<int, int> acumAmount;

	private Dictionary<int, List<int>> versionReds;

	private Dictionary<int, List<ActivityVersionData>> versionDatas;

	private Dictionary<int, List<ActivityVersionLockData>> versionLockDatas;

	private string SaveKey = "RedPoint_";

	private string systemName = "ActivtiyVersion1";

	public Dictionary<int, ActivityViewModelBase> ActivityViewModels => _activityViewModels;

	public Dictionary<int, List<ActivityVersionData>> VersionDatas => versionDatas;

	public OpActViewModel()
	{
		messenger = Context.GetApplicationContext().GetService<IMessenger>();
	}

	public void InitAllActivityData(List<int> openTypes, List<PbActivityTypeAllData> serviceDataList)
	{
		if (openTypes == null)
		{
			return;
		}
		serviceDataList.RemoveAll((PbActivityTypeAllData p) => p == null);
		foreach (int type in openTypes)
		{
			if (!_activityViewModels.ContainsKey(type))
			{
				List<ActivityTaskData> taskDataList = new List<ActivityTaskData>();
				PbActivityTypeAllData obj = serviceDataList?.Find((PbActivityTypeAllData p) => p.ActivityType == type);
				obj?.Datas.ForEach(delegate(PbActivityTaskData p)
				{
					taskDataList.Add(new ActivityTaskData(p));
				});
				List<ActivityTaskData> ProgressList = new List<ActivityTaskData>();
				obj?.RankData.ForEach(delegate(PbActivityRankStateData p)
				{
					ProgressList.Add(new ActivityTaskData
					{
						Id = p.Id,
						CompleteValue = p.CompeteValue,
						RewardState = p.RewardState,
						GroupId = p.ProgressId
					});
				});
				ActivityViewModelBase activityViewModelBase = OpActivityDefinition.CreateActivityViewModel(type, this, taskDataList, refreshState: false);
				if (activityViewModelBase != null)
				{
					activityViewModelBase.AddProgressTask(ProgressList);
					_activityViewModels.Add(type, activityViewModelBase);
				}
			}
		}
		RefreshAllState(notify: false);
		RefreshTypeAndFinishState(notify: false);
		UpdateReds();
	}

	public void SetActivityData(int typeId, ActivitySingleServerData serviceData)
	{
		if (serviceData == null)
		{
			return;
		}
		List<ActivityTaskData> taskDataList = new List<ActivityTaskData>();
		serviceData.normalData?.Datas?.ForEach(delegate(PbActivityTaskData p)
		{
			taskDataList.Add(new ActivityTaskData(p));
		});
		if (!_activityViewModels.ContainsKey(typeId) || _activityViewModels[typeId] == null)
		{
			_activityViewModels.Remove(typeId);
			ActivityViewModelBase activityViewModelBase = OpActivityDefinition.CreateActivityViewModel(typeId, this, taskDataList, refreshState: true);
			if (activityViewModelBase == null)
			{
				return;
			}
			_activityViewModels.Add(typeId, activityViewModelBase);
		}
		else
		{
			_activityViewModels[typeId].SetServiceTaskData(taskDataList);
		}
		_activityViewModels[typeId]?.UpdateRed();
	}

	public void SetActivityData(int typeId, PbActivityTypeAllData serviceData)
	{
		if (serviceData?.Datas == null)
		{
			return;
		}
		List<ActivityTaskData> taskDataList = new List<ActivityTaskData>();
		serviceData.Datas.ForEach(delegate(PbActivityTaskData p)
		{
			taskDataList.Add(new ActivityTaskData(p));
		});
		if (!_activityViewModels.ContainsKey(typeId) || _activityViewModels[typeId] == null)
		{
			_activityViewModels.Remove(typeId);
			ActivityViewModelBase activityViewModelBase = OpActivityDefinition.CreateActivityViewModel(typeId, this, taskDataList, refreshState: true);
			if (activityViewModelBase == null)
			{
				return;
			}
			_activityViewModels.Add(typeId, activityViewModelBase);
		}
		else
		{
			_activityViewModels[typeId].SetServiceTaskData(taskDataList);
		}
		_activityViewModels[typeId]?.UpdateRed();
	}

	public bool SetTaskRewardGotten(int typeId, int id)
	{
		if (_activityViewModels.TryGetValue(typeId, out var value))
		{
			int num;
			if (value == null)
			{
				num = 0;
			}
			else
			{
				num = (value.OnTaskRewardGot(id) ? 1 : 0);
				if (num != 0)
				{
					value?.UpdateRed();
					messenger.Publish(new OpActivityMessage(this, OpActivityMessageEnum.TaskStateChanged, typeId));
				}
			}
			return (byte)num != 0;
		}
		return false;
	}

	public bool AddActivityOpened(int activityTypeId, List<ActivityTaskData> taskDataList)
	{
		ActivityViewModelBase activityViewModelBase = OpActivityDefinition.CreateActivityViewModel(activityTypeId, this, taskDataList, refreshState: true);
		if (activityViewModelBase == null)
		{
			return false;
		}
		if (_activityViewModels.ContainsKey(activityViewModelBase.ActivityTypeId))
		{
			_activityViewModels[activityViewModelBase.ActivityTypeId] = activityViewModelBase;
		}
		else
		{
			_activityViewModels.Add(activityViewModelBase.ActivityTypeId, activityViewModelBase);
		}
		activityViewModelBase?.UpdateRed();
		messenger.Publish(new OpActivityMessage(this, OpActivityMessageEnum.ActivityOpen, activityTypeId));
		return true;
	}

	public bool RemoveActivityFinished(int activityTypeId)
	{
		if (_activityViewModels.TryGetValue(activityTypeId, out var value))
		{
			value?.Dispose();
			value = null;
		}
		bool num = _activityViewModels.Remove(activityTypeId);
		if (num)
		{
			UpdateReds();
			messenger.Publish(new OpActivityMessage(this, OpActivityMessageEnum.ActivityClose, activityTypeId));
		}
		return num;
	}

	public ActivityViewModelBase GetActivityViewModel(int typeId)
	{
		if (_activityViewModels == null)
		{
			return null;
		}
		if (_activityViewModels.TryGetValue(typeId, out var value))
		{
			return value;
		}
		return null;
	}

	public ActivityTaskData GetActivityTaskData(int typeId, int id)
	{
		if (_activityViewModels == null)
		{
			return null;
		}
		if (!_activityViewModels.ContainsKey(typeId) || _activityViewModels[typeId] == null)
		{
			return null;
		}
		return _activityViewModels[typeId].PbTaskDataList?.Find((ActivityTaskData p) => p.Id == id);
	}

	public void RefreshAllState(bool notify = true)
	{
		if (_activityViewModels == null)
		{
			return;
		}
		foreach (ActivityViewModelBase value in _activityViewModels.Values)
		{
			RefreshTargetState(value, notify);
		}
	}

	public void RefreshTargetState(int typeId)
	{
		if (_activityViewModels != null && _activityViewModels.TryGetValue(typeId, out var value))
		{
			RefreshTargetState(value);
		}
	}

	private void RefreshTargetState(ActivityViewModelBase activityViewModel, bool notify = true)
	{
		if (activityViewModel == null)
		{
			return;
		}
		OpActivityState state = activityViewModel.State;
		OpActivityLockState lockState = activityViewModel.LockState;
		activityViewModel.RefreshState();
		int activityTypeId = activityViewModel.ActivityTypeId;
		OpActivityState state2 = activityViewModel.State;
		OpActivityLockState lockState2 = activityViewModel.LockState;
		if (notify)
		{
			if (state != state2)
			{
				OpActivityMessageEnum type = ((state2 == OpActivityState.On) ? OpActivityMessageEnum.ActivityOn : OpActivityMessageEnum.ActivityOff);
				messenger.Publish(new OpActivityMessage(this, type, activityTypeId));
			}
			if (lockState != lockState2)
			{
				OpActivityMessageEnum type2 = ((lockState2 == OpActivityLockState.Unlock) ? OpActivityMessageEnum.ActivityUnlock : OpActivityMessageEnum.ActivityLock);
				messenger.Publish(new OpActivityMessage(this, type2, activityTypeId));
			}
		}
	}

	public void RefreshTypeAndFinishState(bool notify = true)
	{
		if (_activityViewModels == null)
		{
			return;
		}
		List<int> list = new List<int>();
		List<int> list2 = new List<int>();
		foreach (ActivityViewModelBase value in _activityViewModels.Values)
		{
			int curType = value.CurType;
			bool finished = value.Finished;
			value.RefreshTabType();
			value.RefreshFinishState();
			int curType2 = value.CurType;
			bool finished2 = value.Finished;
			if (curType != curType2)
			{
				list.Add(value.ActivityTypeId);
			}
			if (finished != finished2)
			{
				list2.Add(value.ActivityTypeId);
			}
		}
		if (notify)
		{
			if (list.Count > 0)
			{
				messenger.Publish(new OpActivityMessage(this, OpActivityMessageEnum.ActivityTabTypeChange, list));
			}
			if (list2.Count > 0)
			{
				messenger.Publish(new OpActivityMessage(this, OpActivityMessageEnum.ActivityFinishStateChange, list2));
			}
		}
	}

	public void UpdateActivityTaskProgress(int activityType, int taskId, long completeValue, int rewardState)
	{
		if (_activityViewModels.TryGetValue(activityType, out var value))
		{
			ActivityTaskData activityTaskData = value?.GetTaskData(taskId);
			if (activityTaskData != null)
			{
				activityTaskData.CompleteValue = completeValue;
				activityTaskData.RewardState = rewardState;
			}
			value?.UpdateRed();
			messenger.Publish(new OpActivityMessage(this, OpActivityMessageEnum.TaskStateChanged, activityType));
		}
	}

	public void OnKnapsackChange(PropChangeMessage message)
	{
		if (propChangeActivtiyTypeIds != null && propChangeActivtiyTypeIds.Count != 0)
		{
			for (int i = 0; i < propChangeActivtiyTypeIds.Count; i++)
			{
				GetActivityViewModel(propChangeActivtiyTypeIds[i])?.OnKnapsackChange(message);
			}
		}
	}

	public void AddKnapsackChange(int activtiyTypeId)
	{
		if (propChangeActivtiyTypeIds == null)
		{
			propChangeActivtiyTypeIds = new List<int>();
		}
		propChangeActivtiyTypeIds.Add(activtiyTypeId);
	}

	public void OnTaskRateNotify(ActivityTaskRateNotify notify)
	{
		if (notify != null)
		{
			if (_activityViewModels.TryGetValue(notify.ActivityType, out var value))
			{
				value?.OnTaskRateNotify(notify);
				value?.UpdateRed();
				messenger.Publish(new OpActivityMessage(this, OpActivityMessageEnum.TaskStateChanged, value?.ActivityTypeId));
			}
			RefreshTypeAndFinishState();
		}
	}

	public bool GetRed()
	{
		if (_activityReds == null)
		{
			return false;
		}
		bool result = false;
		foreach (KeyValuePair<int, bool> activityRed in _activityReds)
		{
			ActivityViewModelBase activityViewModel = GetActivityViewModel(activityRed.Key);
			if (activityViewModel != null && activityViewModel.State == OpActivityState.On && activityRed.Value)
			{
				result = true;
				break;
			}
		}
		return result;
	}

	public bool GetTypeRed(int tabType)
	{
		if (_activityReds == null)
		{
			return false;
		}
		bool result = false;
		foreach (KeyValuePair<int, bool> activityRed in _activityReds)
		{
			ActivityViewModelBase activityViewModel = GetActivityViewModel(activityRed.Key);
			if (activityViewModel != null && activityViewModel.CurType == tabType && activityViewModel.State == OpActivityState.On && activityRed.Value)
			{
				result = true;
				break;
			}
		}
		return result;
	}

	public bool GetRed(int activityTypeId)
	{
		if (_activityReds == null)
		{
			return false;
		}
		if (_activityReds.TryGetValue(activityTypeId, out var value))
		{
			return value;
		}
		return false;
	}

	public bool UpdateReds()
	{
		_activityReds.Clear();
		foreach (KeyValuePair<int, ActivityViewModelBase> activityViewModel in _activityViewModels)
		{
			if (activityViewModel.Value.State != OpActivityState.Off)
			{
				bool value = activityViewModel.Value.UpdateRed(notifyParent: false);
				SetActivityRed(activityViewModel.Key, value);
			}
		}
		bool red = GetRed();
		messenger.Publish(new OpActivityMessage(this, OpActivityMessageEnum.RedChange));
		return red;
	}

	private void SetActivityRed(int key, bool value)
	{
		bool flag = Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>().ByActivityTypeGetRedPoint(key);
		value |= flag;
		if (_activityReds.ContainsKey(key))
		{
			_activityReds[key] = value;
		}
		else
		{
			_activityReds.Add(key, value);
		}
	}

	public void OnActivityRedChanged(ActivityViewModelBase activityViewModel)
	{
		if (activityViewModel != null)
		{
			bool num = _activityReds.TryGetValue(activityViewModel.ActivityTypeId, out var value) & value;
			bool flag = Singleton<ServiceSystem>.Instance.GetService<IActivityAchievementService>()?.ByActivityTypeGetRedPoint(activityViewModel.ActivityTypeId) ?? false;
			bool flag2 = activityViewModel.Red | flag;
			if (num != flag2)
			{
				_activityReds[activityViewModel.ActivityTypeId] = flag2;
				messenger.Publish(new OpActivityMessage(this, OpActivityMessageEnum.RedChange));
			}
		}
	}

	public ActivityVersionData GetVersionDataById(int typeId, int id)
	{
		if (versionDatas != null && versionDatas.ContainsKey(typeId) && versionDatas[typeId] != null)
		{
			for (int i = 0; i < versionDatas[typeId].Count; i++)
			{
				if (versionDatas[typeId][i].DrVersionActivity.Id == id)
				{
					return versionDatas[typeId][i];
				}
			}
		}
		return null;
	}

	public void UpdateActivityVersionProgress(int typeId, int activityVersionId, int curStar)
	{
		try
		{
			if (versionDatas != null && versionDatas.ContainsKey(typeId) && versionDatas[typeId] != null)
			{
				if (activityVersionId > 0)
				{
					for (int i = 0; i < versionDatas[typeId].Count; i++)
					{
						if (versionDatas[typeId][i].DrVersionActivity.Id == activityVersionId)
						{
							versionDatas[typeId][i].SetComplete(curStar);
						}
					}
				}
				for (int j = 0; j < versionDatas[typeId].Count; j++)
				{
					if (versionDatas[typeId][j].IsLock)
					{
						versionDatas[typeId][j].CheckLock();
						if (!versionDatas[typeId][j].IsLock)
						{
							versionDatas[typeId][j].SetRed(value: true);
							UpdateVersionRed(typeId, versionDatas[typeId][j].DrVersionActivity.Id, red: true);
						}
					}
				}
			}
			ActivityVersion1ViewModel activityVersion1ViewModel = GetActivityViewModel(typeId) as ActivityVersion1ViewModel;
			if (versionLockDatas != null && versionLockDatas.ContainsKey(typeId) && versionLockDatas[typeId] != null)
			{
				for (int k = 0; k < versionLockDatas[typeId].Count; k++)
				{
					versionLockDatas[typeId][k].CheckLock();
				}
				activityVersion1ViewModel?.OnCheckRankLock();
			}
			activityVersion1ViewModel?.UpdateRed();
		}
		catch (Exception)
		{
		}
	}

	public void UpdateActivityVersionTime(int typeId)
	{
		try
		{
			ActivityVersion1ViewModel activityVersion1ViewModel = GetActivityViewModel(typeId) as ActivityVersion1ViewModel;
			if (versionLockDatas != null && versionLockDatas.ContainsKey(typeId) && versionLockDatas[typeId] != null)
			{
				activityVersion1ViewModel?.OnCheckTimeRankLock();
			}
			activityVersion1ViewModel?.UpdateRed();
		}
		catch (Exception)
		{
		}
	}

	public void SetActivityVersionData(int vaTypeId, List<ActivityVersionData> activityVersionDatas)
	{
		if (versionDatas == null)
		{
			versionDatas = new Dictionary<int, List<ActivityVersionData>>();
		}
		if (versionLockDatas == null)
		{
			versionLockDatas = new Dictionary<int, List<ActivityVersionLockData>>();
		}
		if (!versionDatas.ContainsKey(vaTypeId))
		{
			versionDatas.Add(vaTypeId, activityVersionDatas);
		}
		else
		{
			versionDatas[vaTypeId] = activityVersionDatas;
		}
		if (!versionLockDatas.ContainsKey(vaTypeId))
		{
			List<ActivityVersionLockData> list = new List<ActivityVersionLockData>();
			DRVersionLock[] dataRows = GameEntry.DataTable.GetDataRows((DRVersionLock p) => p.ActivityId == vaTypeId);
			for (int num = 0; num < dataRows.Length; num++)
			{
				ActivityVersionLockData item = ActivityVersionLockData.Create(dataRows[num], vaTypeId);
				list.Add(item);
			}
			versionLockDatas.Add(vaTypeId, list);
		}
		if (!versionDatas.TryGetValue(vaTypeId, out var value) || value == null)
		{
			return;
		}
		for (int num2 = 0; num2 < value.Count; num2++)
		{
			if (value[num2] != null)
			{
				bool isLock = value[num2].IsLock;
				value[num2].CheckLock();
				if (isLock && !value[num2].IsLock && !value[num2].IsComplete)
				{
					value[num2].SetRed(value: true);
					UpdateVersionRed(vaTypeId, value[num2].DrVersionActivity.Id, red: true);
				}
			}
		}
	}

	public List<ActivityVersionData> GetVersionActivityDataList(int typeId)
	{
		if (versionDatas != null && versionDatas.ContainsKey(typeId))
		{
			return versionDatas[typeId];
		}
		return null;
	}

	public List<ActivityVersionLockData> GetVersionLockActivityDataList(int typeId)
	{
		if (versionLockDatas != null && versionLockDatas.ContainsKey(typeId))
		{
			return versionLockDatas[typeId];
		}
		return null;
	}

	public void InitAllActivityVersionData()
	{
		versionReds = GetVersionRedDatas();
		if (versionDatas == null)
		{
			return;
		}
		foreach (KeyValuePair<int, List<ActivityVersionData>> versionData in versionDatas)
		{
			if (versionData.Value == null)
			{
				continue;
			}
			for (int i = 0; i < versionData.Value.Count; i++)
			{
				versionData.Value[i].CheckLock();
			}
			if (versionReds == null || !versionReds.ContainsKey(versionData.Key) || versionReds[versionData.Key] == null)
			{
				for (int j = 0; j < versionData.Value.Count; j++)
				{
					if (!versionData.Value[j].IsLock && !versionData.Value[j].IsComplete)
					{
						UpdateVersionRed(versionData.Key, versionData.Value[j].DrVersionActivity.Id, red: true);
					}
				}
			}
			else if (versionReds.ContainsKey(versionData.Key) && versionReds[versionData.Key] != null)
			{
				List<int> list = versionReds[versionData.Key];
				for (int k = 0; k < versionData.Value.Count; k++)
				{
					if (versionData.Value[k].IsComplete || versionData.Value[k].IsLock)
					{
						list.Remove(versionData.Value[k].DrVersionActivity.Id);
						versionData.Value[k].SetRed(value: false);
					}
					else if (list.Contains(versionData.Value[k].DrVersionActivity.Id))
					{
						versionData.Value[k].SetRed(value: true);
					}
				}
			}
			if (versionReds != null && versionReds.ContainsKey(versionData.Key) && versionReds[versionData.Key] != null && versionReds[versionData.Key].Count > 0)
			{
				GetActivityViewModel(versionData.Key).UpdateRed();
			}
		}
		foreach (KeyValuePair<int, List<ActivityVersionLockData>> versionLockData in versionLockDatas)
		{
			if (versionLockData.Value != null)
			{
				for (int l = 0; l < versionLockData.Value.Count; l++)
				{
					versionLockData.Value[l].CheckLock();
				}
			}
		}
	}

	public void SaveAcumCount(Dictionary<int, int> acumDics)
	{
		acumAmount = new Dictionary<int, int>();
		DRVersionMoney[] allDataRow = GameEntry.DataTable.GetAllDataRow<DRVersionMoney>();
		if (allDataRow == null)
		{
			return;
		}
		for (int i = 0; i < allDataRow.Length; i++)
		{
			acumAmount.Add(allDataRow[i].PropId, 0);
		}
		foreach (KeyValuePair<int, int> acumDic in acumDics)
		{
			if (acumAmount.ContainsKey(acumDic.Key))
			{
				acumAmount[acumDic.Key] = acumDic.Value;
			}
		}
	}

	public int GetAcumCount(int propId)
	{
		if (acumAmount == null)
		{
			return 0;
		}
		if (acumAmount.ContainsKey(propId))
		{
			return acumAmount[propId];
		}
		return 0;
	}

	public int AddAcumCount(int propId, int count)
	{
		if (acumAmount == null)
		{
			return 0;
		}
		if (acumAmount.ContainsKey(propId))
		{
			acumAmount[propId] += count;
			return acumAmount[propId];
		}
		return 0;
	}

	public Dictionary<int, List<int>> GetVersionRedDatas()
	{
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			return JsonConvert.DeserializeObject<Dictionary<int, List<int>>>(PlayerPrefs.GetString(SaveKey + $"{uid}_{systemName}", ""));
		}
		catch (Exception)
		{
			Log.Error("获取红点保存数据失败！" + systemName);
		}
		return null;
	}

	public void SaveVersionRedDatas(Dictionary<int, List<int>> obj)
	{
		string text = null;
		try
		{
			long uid = Singleton<ServiceSystem>.Instance.GetService<IRoleService>().GetRoleData().PlayerInfo.Uid;
			text = ((obj == null) ? "" : JsonConvert.SerializeObject(obj));
			PlayerPrefs.SetString(SaveKey + $"{uid}_{systemName}", text);
		}
		catch (Exception)
		{
			Log.Error("保存红点数据失败！" + systemName);
		}
	}

	public void UpdateVersionRed(int typeId, int actId, bool red)
	{
		if (versionReds == null)
		{
			versionReds = new Dictionary<int, List<int>>();
		}
		if (!versionReds.ContainsKey(typeId))
		{
			versionReds.Add(typeId, new List<int>());
		}
		if (versionReds[typeId] == null)
		{
			versionReds[typeId] = new List<int>();
		}
		if (red && !versionReds[typeId].Contains(actId))
		{
			versionReds[typeId].Add(actId);
		}
		else if (!red)
		{
			versionReds[typeId].Remove(actId);
		}
		SaveVersionRedDatas(versionReds);
	}

	protected override void Dispose(bool disposing)
	{
		if (_activityViewModels != null)
		{
			foreach (ActivityViewModelBase value in _activityViewModels.Values)
			{
				value?.Dispose();
			}
		}
		base.Dispose(disposing);
	}
}
