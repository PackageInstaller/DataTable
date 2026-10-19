using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.UI.DataProxy;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class BookLevelRewardItem : MonoBehaviour
{
	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private LocalizeStringEvent lvNum;

	[SerializeField]
	public ActButton btn;

	[SerializeField]
	public ActButton select;

	[SerializeField]
	private GameObject rootDes;

	[SerializeField]
	private RectTransform tarHeightDes;

	[SerializeField]
	private LocalizeStringEvent des;

	[SerializeField]
	private TextMeshProUGUI textDes;

	[SerializeField]
	private GameObject lockedRoot;

	[SerializeField]
	public GameObject unLockRoot;

	[SerializeField]
	private List<LiteItemUIComponent> rewards;

	[SerializeField]
	private List<BookLevelInfo> levelInfos;

	[SerializeField]
	private PublicToggle activeToggle;

	[SerializeField]
	public GameObject received;

	[SerializeField]
	public Transform content;

	[SerializeField]
	public CanvasGroup btnPromptCanvasGroup;

	[SerializeField]
	public GameObject btnPrompt_item;

	[SerializeField]
	public GameObject btnPrompt_confirm;

	private bool desActive;

	public void Init(BookLevelModel model)
	{
		ChapterIndex data = CoreUtils.GetData(model.Id, RuntimeConfigs.data.chapterIndexs);
		lvNum.StringReference.TableEntryReference = data.name;
		bool flag = false;
		if (model.Unlock)
		{
			if (G.localPlayer.SystemGuideChapter.TryGetValue(model.Id, out var value))
			{
				flag = value;
			}
			lockedRoot.gameObject.SetActive(value: false);
			unLockRoot.gameObject.SetActive(!flag);
			btn.Interactable(!flag);
			received.gameObject.SetActive(flag);
		}
		else
		{
			lockedRoot.gameObject.SetActive(value: true);
			unLockRoot.gameObject.SetActive(value: false);
			received.gameObject.SetActive(value: false);
		}
		rootDes.SetActive(desActive);
		activeToggle.isOn = desActive;
		_ = desActive;
		if (!RuntimeConfigs.data.collections.ContainsKey(model.RewardId))
		{
			foreach (LiteItemUIComponent reward in rewards)
			{
				reward.gameObject.SetActive(value: false);
			}
			return;
		}
		Collection data2 = CoreUtils.GetData(model.RewardId, RuntimeConfigs.data.collections);
		int num = data2.certain.Count - rewards.Count;
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				LiteItemUIComponent item = UnityEngine.Object.Instantiate(rewards[0], rewards[0].transform.parent, worldPositionStays: false);
				rewards.Add(item);
			}
		}
		data2.certain.Sort((ItemKv a, ItemKv b) =>
		{
			ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get<Item>(a.id, a.count);
			ItemUnifierProxy itemUnifierProxy2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(b.id, b.count);
			return (itemUnifierProxy2.Quality.CompareTo(itemUnifierProxy.Quality) == 0) ? itemUnifierProxy2.Id.CompareTo(itemUnifierProxy.Id) : itemUnifierProxy2.Quality.CompareTo(itemUnifierProxy.Quality);
		});
		for (int num2 = 0; num2 < rewards.Count; num2++)
		{
			if (num2 < data2.certain.Count)
			{
				rewards[num2].gameObject.SetActive(value: true);
				ItemUnifierProxy item2 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(data2.certain[num2].id, data2.certain[num2].count);
				rewards[num2].SetData(item2, long.MinValue, (!flag) ? ItemUIComponentBase.InitType.RewardItem : ItemUIComponentBase.InitType.RewardItemReceived, ItemUIComponentBase.ItemCountShowType.OneSide);
				rewards[num2].UpdatePerformance();
				rewards[num2].showDetailPanel = true;
			}
			else
			{
				rewards[num2].gameObject.SetActive(value: false);
			}
		}
	}

	private void InitLevelInfos(string desc)
	{
		string[] array = desc.Split(new string[1] { "<br>" }, StringSplitOptions.RemoveEmptyEntries);
		if (array.Length < 1)
		{
			foreach (BookLevelInfo levelInfo in levelInfos)
			{
				levelInfo.gameObject.SetActive(value: false);
			}
			return;
		}
		int num = array.Length - levelInfos.Count;
		if (num > 0)
		{
			for (int i = 0; i < num; i++)
			{
				BookLevelInfo item = UnityEngine.Object.Instantiate(levelInfos[0], levelInfos[0].transform.parent, worldPositionStays: false);
				levelInfos.Add(item);
			}
		}
		for (int j = 0; j < levelInfos.Count; j++)
		{
			if (j < array.Length)
			{
				levelInfos[j].gameObject.SetActive(value: true);
				levelInfos[j].Init(array[j]);
			}
			else
			{
				levelInfos[j].gameObject.SetActive(value: false);
			}
		}
	}

	public void PlayEnterAnimation(bool isSelect)
	{
		animation.GetSequence(isSelect ? "ShowSelected" : "ShowNormal").Play();
	}

	public void PlayScrollToAnimation(bool isSelect)
	{
		animation.GetSequence(isSelect ? "SelectedEnter" : "SelectedOut").Play().Complete();
	}

	public void PlaySwitchSelectAnimation(bool isSelect)
	{
		animation.GetSequence(isSelect ? "SelectedEnter" : "SelectedOut").Play();
	}
}
