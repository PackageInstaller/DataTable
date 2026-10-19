using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class CommonSubWorldEntranceTarget : MonoBehaviour
{
	[SerializeField]
	private List<CommonSubWorldEntranceTargetItem> _items;

	public void RefreshUI(List<int> taskIds, StageChallengeTarget stageChallengeTarget, Func<int, int> progressProvider = null, bool preferMissionDescription = false)
	{
		if (taskIds == null)
		{
			taskIds = new List<int>();
		}
		bool value = default;
		for (int i = 0; i < _items.Count; i++)
		{
			if (i < taskIds.Count)
			{
				_items[i].gameObject.SetActive(value: true);
				int num = taskIds[i];
				bool flag = (stageChallengeTarget?.TargetReward != null && stageChallengeTarget.TargetReward.TryGetValue(num, out value)) & value;
				int progress = progressProvider?.Invoke(num) ?? GetProgress(num);
				_items[i].RefreshUI(i, num, flag, progress, flag, preferMissionDescription);
			}
			else
			{
				_items[i].gameObject.SetActive(value: false);
			}
		}
	}

	public void RefreshSingle(int targetId, bool isComplete)
	{
		for (int i = 0; i < _items.Count; i++)
		{
			bool flag = i == 0;
			_items[i].gameObject.SetActive(flag);
			if (flag)
			{
				_items[i].RefreshUI(i, targetId, isComplete, -1, isComplete);
			}
		}
	}

	private int GetProgress(int rulesId)
	{
		Rules data = CoreUtils.GetData(rulesId, RuntimeConfigs.data.ruless);
		if (data == null)
		{
			return -1;
		}
		if (data.rulesId == 4)
		{
			if (data.param[0] == 3)
			{
				TempleEntranceView templeEntranceView = Singleton<NewUIManager>.instance.GetTopActivePanel().GetUIView() as TempleEntranceView;
				if (templeEntranceView != null)
				{
					TempleData templeData = templeEntranceView.GetTempleData();
					return Model<TempleModel>.Interface.GetTempleActiveRobotCount(templeData.templeId);
				}
				return 0;
			}
			MonoRaidView monoRaidView = Singleton<NewUIManager>.instance.GetTopActivePanel().GetUIView() as MonoRaidView;
			return Model<RaidModel>.Interface.GetRaidInfo(monoRaidView.curSelectRaidId)?.MaximumScore ?? 0;
		}
		return -1;
	}
}
