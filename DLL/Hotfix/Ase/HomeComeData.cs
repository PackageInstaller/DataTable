using System;
using System.Collections.Generic;

namespace Ase;

public class HomeComeData
{
	private HashSet<int> signedIds = new HashSet<int>();

	private HashSet<int> taskClaimedIds = new HashSet<int>();

	private Dictionary<int, HomeComeTaskProgressData> taskProgressDict = new Dictionary<int, HomeComeTaskProgressData>();

	public bool IsInReturn { get; private set; }

	public long ReturnStartTime { get; private set; }

	public bool GiftClaimed { get; private set; }

	public int SignDays { get; private set; }

	public IReadOnlyCollection<int> SignedIds => signedIds;

	public IReadOnlyCollection<int> TaskClaimedIds => taskClaimedIds;

	public IReadOnlyDictionary<int, HomeComeTaskProgressData> TaskProgressDict => taskProgressDict;

	public void ResetFromInfo(GetHomeComeInfoResponse response)
	{
		if (response == null)
		{
			return;
		}
		IsInReturn = response.IsInReturn;
		ReturnStartTime = response.ReturnStartTime;
		GiftClaimed = response.GiftClaimed;
		SignDays = response.SignDays;
		signedIds.Clear();
		if (response.SignedIds != null)
		{
			for (int i = 0; i < response.SignedIds.Count; i++)
			{
				signedIds.Add(response.SignedIds[i]);
			}
		}
		taskClaimedIds.Clear();
		if (response.TaskClaimed != null)
		{
			for (int j = 0; j < response.TaskClaimed.Count; j++)
			{
				taskClaimedIds.Add(response.TaskClaimed[j]);
			}
		}
		taskProgressDict.Clear();
		UpdateTaskProgress(response.TaskProgress);
	}

	public void SetOpenState(bool isInReturn)
	{
		IsInReturn = isInReturn;
	}

	public void UpdateTaskProgress(List<PbHomeComeTaskProgress> taskProgressList)
	{
		if (taskProgressList == null)
		{
			return;
		}
		for (int i = 0; i < taskProgressList.Count; i++)
		{
			PbHomeComeTaskProgress pbHomeComeTaskProgress = taskProgressList[i];
			if (pbHomeComeTaskProgress != null)
			{
				if (!taskProgressDict.TryGetValue(pbHomeComeTaskProgress.Id, out var value))
				{
					value = new HomeComeTaskProgressData();
					taskProgressDict.Add(pbHomeComeTaskProgress.Id, value);
				}
				value.Update(pbHomeComeTaskProgress);
			}
		}
	}

	public void MarkGiftClaimed()
	{
		GiftClaimed = true;
	}

	public void MarkSignClaimed(int signId)
	{
		if (signId > 0)
		{
			signedIds.Add(signId);
		}
	}

	public void MarkTaskClaimed(int taskId)
	{
		if (taskId > 0)
		{
			taskClaimedIds.Add(taskId);
		}
	}

	public bool IsSignClaimed(int signId)
	{
		return signedIds.Contains(signId);
	}

	public bool IsTaskClaimed(int taskId)
	{
		return taskClaimedIds.Contains(taskId);
	}

	public bool TryGetTaskProgress(int taskId, out HomeComeTaskProgressData data)
	{
		return taskProgressDict.TryGetValue(taskId, out data);
	}

	public int GetCanClaimTaskCount()
	{
		int num = 0;
		foreach (KeyValuePair<int, HomeComeTaskProgressData> item in taskProgressDict)
		{
			if (item.Value != null && item.Value.CanClaim(taskClaimedIds))
			{
				num++;
			}
		}
		return num;
	}

	public bool HasGiftRedPoint()
	{
		if (IsInReturn)
		{
			return !GiftClaimed;
		}
		return false;
	}

	public bool HasSignRedPoint()
	{
		if (!IsInReturn || SignDays <= 0)
		{
			return false;
		}
		for (int i = 1; i <= SignDays; i++)
		{
			if (!signedIds.Contains(i))
			{
				return true;
			}
		}
		return false;
	}

	public bool HasTaskRedPoint()
	{
		if (!IsInReturn)
		{
			return false;
		}
		foreach (KeyValuePair<int, HomeComeTaskProgressData> item in taskProgressDict)
		{
			if (item.Value != null && item.Value.CanClaim(taskClaimedIds))
			{
				return true;
			}
		}
		return false;
	}

	public bool HasAnyRedPoint()
	{
		if (!HasGiftRedPoint() && !HasSignRedPoint())
		{
			return HasTaskRedPoint();
		}
		return true;
	}

	public long GetLeftSeconds(long serverTime, int durationDays)
	{
		if (!IsInReturn || ReturnStartTime <= 0 || serverTime <= 0)
		{
			return 0L;
		}
		long num = ReturnStartTime + (long)Math.Max(1, durationDays) * 86400L - serverTime;
		if (num <= 0)
		{
			return 0L;
		}
		return num;
	}
}
