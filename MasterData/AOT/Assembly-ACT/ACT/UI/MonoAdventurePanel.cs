using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoAdventurePanel : BaseUIView
{
	public LoopScrollRect loopScrollRect;

	public ScrollViewSelector selector;

	public GameObject condition;

	public GameObject task;

	public GameObject reward;

	public GameObject message;

	public LocalizeStringEvent taskText;

	public ItemUIComponent rewardItem;

	public LayoutGroup rewardGridLayout;

	public List<ItemUIComponent> rewards;

	public GameObject rewardContent;

	public VerticalLayoutGroup detailedVerticalLayout;

	public Button confirmBtn;

	public LocalizeStringEvent levelInfo;

	[Header("各种按钮")]
	public BitMaskSwitcher maskSwitcher;

	private int m_Selected;

	private void Start()
	{
		rewards = ListPool<ItemUIComponent>.Get();
	}

	protected override void Init()
	{
		base.Init();
	}

	protected override void OpenEffectCallback()
	{
		loopScrollRect.totalCount = Singleton<SystemUnlockManager>.instance.missionLevels.Count;
		loopScrollRect.RefillCells();
		SetPanel(Mathf.Max(2, SystemUnlockManager.playerLevel));
		selector.ScrollToSelected(Mathf.Max(0, Singleton<SystemUnlockManager>.instance.missionLevels.IndexOf(SystemUnlockManager.playerLevel)));
		selector.SelectAreaUpdate();
	}

	protected override void AddEventListener()
	{
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_Adventure_Refresh, Refresh);
	}

	protected override void RemoveEventListener()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_Adventure_Refresh, Refresh);
	}

	private void Refresh(BaseEventContent obj)
	{
		selector.selected.UpdateCell();
	}

	protected override void UnInit()
	{
		base.UnInit();
		rewardItem.UnLoadSprite();
		foreach (ItemUIComponent reward in rewards)
		{
			reward.UnLoadSprite();
		}
		selector.Stop();
	}

	protected override void OnUnityDestroy()
	{
		ListPool<ItemUIComponent>.Release(rewards);
	}

	public void SetPanel(int index, bool isLock = false)
	{
		m_Selected = index;
		PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[index];
		Collection collection = RuntimeConfigs.data.collections[playerLevelData.rewardId];
		bool flag = index <= SystemUnlockManager.playerLevel + 6;
		if (flag)
		{
			condition.SetActive(value: true);
			if (isLock)
			{
				task.SetActive(value: true);
				taskText.gameObject.SetActive(value: true);
				reward.gameObject.SetActive(value: false);
				rewardContent.SetActive(value: false);
				rewardGridLayout.gameObject.SetActive(value: false);
				message.SetActive(value: true);
				MissionBase missionBase = RuntimeConfigs.data.missionBases[playerLevelData.preconditionParam[0].count];
				taskText.StringReference.TableEntryReference = missionBase.contentDesc;
				levelInfo.StringReference.GetVariable<int>("0").Value = GetLevelMax();
				levelInfo.RefreshString();
				if (SystemUnlockManager.playerLevel < index)
				{
					maskSwitcher.SetActive(596);
				}
				else
				{
					maskSwitcher.SetActive(680);
				}
				return;
			}
			task.SetActive(value: false);
			taskText.gameObject.SetActive(value: false);
			reward.gameObject.SetActive(value: true);
			rewardContent.SetActive(value: true);
			rewardGridLayout.gameObject.SetActive(value: true);
			message.SetActive(value: false);
			confirmBtn.onClick.RemoveAllListeners();
			if (G.localPlayer.TakeRewardLevels.Contains(index))
			{
				maskSwitcher.SetActive(514);
			}
			else if (SystemUnlockManager.playerLevel < index)
			{
				maskSwitcher.SetActive(516);
			}
			else
			{
				maskSwitcher.SetActive(513);
			}
		}
		else
		{
			maskSwitcher.SetActive(260);
		}
		for (int i = 0; (i < Mathf.Max(collection.certain.Count, rewards.Count)) & flag; i++)
		{
			if (i >= rewards.Count)
			{
				rewards.Add(Object.Instantiate(rewardItem, rewardGridLayout.transform));
			}
			else
			{
				rewards[i].gameObject.SetActive(value: true);
			}
			if (i >= collection.certain.Count)
			{
				rewards[i].gameObject.SetActive(value: false);
				continue;
			}
			Item item = new Item
			{
				Id = collection.certain[i].id,
				Count = collection.certain[i].count
			};
			rewards[i].RewardItemInit(item);
		}
		detailedVerticalLayout.SetLayoutVertical();
	}

	public void OpenMissionPanel()
	{
		int count = RuntimeConfigs.data.playerLevelDatas[m_Selected].preconditionParam[0].count;
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TASK, new TaskViewV3Data
		{
			missionId = count
		});
	}

	public void GetLevelRewards()
	{
		G.service.AchievePlayeLevelAward(m_Selected, (RepeatedField<Item> isOpen) =>
		{
			G.localPlayer.TakeRewardLevels.Add(m_Selected);
			PlayerLevelData playerLevelData = RuntimeConfigs.data.playerLevelDatas[m_Selected];
			Collection collection = RuntimeConfigs.data.collections[playerLevelData.rewardId];
			List<Item> items = ListPool<Item>.Get();
			foreach (ItemKv item2 in collection.certain)
			{
				Item item = new Item
				{
					Id = item2.id,
					Count = item2.count
				};
				items.Add(item);
			}
			GameUtility.OpenPopReward(GameUtility.ToUniversalItems(items), notSort: false, () =>
			{
				items.Clear();
				ListPool<Item>.Release(items);
			});
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.UI_Adventure_Refresh, null);
		});
	}

	private int GetLevelMax()
	{
		for (int i = m_Selected + 1; i < RuntimeConfigs.data.playerLevelDatas.Count; i++)
		{
			if (RuntimeConfigs.data.playerLevelDatas[i].preconditionParam.Find((ItemKv x) => 1 == x.id) != null)
			{
				return i;
			}
		}
		return RuntimeConfigs.data.playerLevelDatas.Count;
	}
}
