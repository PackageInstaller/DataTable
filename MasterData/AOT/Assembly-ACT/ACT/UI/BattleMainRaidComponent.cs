using System.Collections.Generic;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Utility;
using Bamboo.Chronos;
using Fundamental;
using TMPro;
using UnityEngine;

namespace ACT.UI;

public class BattleMainRaidComponent : MonoBehaviour, IBattleMainComponent
{
	public GameObject Root;

	public TextMeshProUGUI CurrentTime;

	public TextMeshProUGUI Title;

	public List<CommonSubWorldTargetItem> targetItems;

	private int _totalCountDown;

	private Looper _countDownLooper;

	private Looper _currentTimeLooper;

	private StringBuilder _stringBuilder;

	public void Initialize(MonoBattleMainBaseView view)
	{
		if (MonoECS.instance.sceneStatus == SceneStatus.Raid)
		{
			Refresh();
		}
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RaidCollectInfoHide, OnHideRaidCollectInfo);
		if (!_currentTimeLooper.IsValid())
		{
			_currentTimeLooper = UpdateTimer.Default.LoopMs(100, OnUpdateCurrentTime);
		}
		_stringBuilder = new StringBuilder();
	}

	public void UnInitialize()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RaidCollectInfoHide, OnHideRaidCollectInfo);
		if (_countDownLooper.IsValid())
		{
			_countDownLooper.Cancel();
		}
		if (_currentTimeLooper.IsValid())
		{
			_currentTimeLooper.Cancel();
		}
		_stringBuilder = null;
	}

	public void OpenComponent()
	{
	}

	public void CloseComponent()
	{
	}

	public void PushStack()
	{
	}

	public void PopStack()
	{
	}

	private void Refresh()
	{
		if (Model<TeamTeachingModel>.Interface.IsTeamTeachingRaid())
		{
			Root.SetActive(value: false);
			return;
		}
		ACT.Config.Raid data = CoreUtils.GetData(Model<RaidModel>.Interface.CurrentRaidId, RuntimeConfigs.data.raids);
		if (data == null)
		{
			return;
		}
		Root.SetActive(value: true);
		Title.text = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data.raidName);
		List<int> list = new List<int>();
		for (int i = 0; i < data.firstReward.Count; i++)
		{
			list.Add(data.firstReward[i].id);
		}
		for (int j = 0; j < targetItems.Count; j++)
		{
			if (j < list.Count)
			{
				targetItems[j].gameObject.SetActive(value: true);
				targetItems[j].UpdateState(list[j]);
			}
			else
			{
				targetItems[j].gameObject.SetActive(value: false);
			}
		}
		if (data.countDown > 0)
		{
			_totalCountDown = data.countDown;
			if (!_countDownLooper.IsValid())
			{
				_countDownLooper = UpdateTimer.Default.LoopMs(100, OnUpdateCountDown);
			}
		}
	}

	private void OnUpdateCountDown()
	{
		float currentWorldRuntime = Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
		if (Mathf.CeilToInt((float)_totalCountDown - currentWorldRuntime) <= 0)
		{
			if (_countDownLooper.IsValid())
			{
				_countDownLooper.Cancel();
			}
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RaidCountDownEnd, null);
		}
	}

	private void OnUpdateCurrentTime()
	{
		int num = (int)Singleton<GameManager>.instance.worldManager.GetCurrentWorldRuntime();
		int num2 = num / 60;
		int num3 = num % 60;
		_stringBuilder.Clear();
		_stringBuilder.AppendFormat("{0:d2}:{1:d2}", num2, num3);
		CurrentTime.SetText(_stringBuilder);
	}

	public void OnHideRaidCollectInfo(BaseEventContent obj)
	{
		Root.SetActive(value: false);
	}
}
