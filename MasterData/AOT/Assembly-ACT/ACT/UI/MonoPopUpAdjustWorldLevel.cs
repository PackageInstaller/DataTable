using System;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class MonoPopUpAdjustWorldLevel : BaseUIView
{
	public TMP_Text from;

	public TMP_Text to;

	public LocalizeStringEvent hour;

	public LocalizeStringEvent minute;

	public BitMaskSwitcher switcher;

	private int m_Next;

	protected PlayerLevelData m_Data;

	private long m_Interval => RuntimeConfigs.data.game.worldLevelCD * 60000;

	protected override void Init()
	{
		m_Data = RuntimeConfigs.data.playerLevelDatas[SystemUnlockManager.playerLevel];
		m_Next = ((SystemUnlockManager.worldLevel != m_Data.worldLevelMin) ? m_Data.worldLevelMin : m_Data.worldLevelMax);
		ShowFirstPanel();
	}

	private void ShowFirstPanel()
	{
		if (m_Data.worldLevelAdjustable)
		{
			switcher.SetActive((SystemUnlockManager.worldLevel > m_Next) ? 5 : 9);
		}
		else
		{
			switcher.SetActive(1);
		}
		switcher.SetActive(switcher.GetCurrentMask() | 0x40);
	}

	public void OnClick()
	{
		from.SetText("{0:0}", SystemUnlockManager.worldLevel);
		to.SetText("{0:0}", m_Next);
		if (TimeManager.ServerTime.NowTimestamp - SystemUnlockManager.operationTs < m_Interval)
		{
			switcher.SetActive(35);
			UpdateTimeSpan();
		}
		else
		{
			switcher.SetActive(19);
		}
	}

	public void AdjustWorldLevel()
	{
		if (MonoECS.instance.playState != PlayState.UnBattle)
		{
			GameUtility.OpenToolTip(598);
			return;
		}
		G.service.ChangeWorldLevel(m_Next, (bool l, long t) =>
		{
			if (l)
			{
				SystemUnlockManager.operationTs = t;
				if (LuminApplication.LogEnabled)
				{
					Debug.LogWarning($"成功！当前世界等级为{SystemUnlockManager.worldLevel}");
				}
				Close();
				Singleton<NewUIManager>.instance.BackToBattleMain();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogWarning($"失败！当前世界等级为{SystemUnlockManager.worldLevel}");
			}
		});
	}

	public void OnCloseClick()
	{
		if ((switcher.GetCurrentMask() & 2) > 0)
		{
			ShowFirstPanel();
		}
		else
		{
			Close();
		}
	}

	private async void UpdateTimeSpan()
	{
		while (gameObject.activeSelf)
		{
			long num = TimeManager.ServerTime.NowTimestamp - SystemUnlockManager.operationTs;
			TimeSpan timeSpan = TimeManager.GetTimeSpan(m_Interval - num);
			if (timeSpan.TotalSeconds <= 0.0)
			{
				switcher.SetActive(19);
				break;
			}
			hour.StringReference.GetVariable<int>("0").Value = timeSpan.Hours;
			minute.StringReference.GetVariable<int>("0").Value = timeSpan.Minutes;
			await UniTask.Delay(TimeSpan.FromSeconds(timeSpan.Seconds));
		}
	}
}
