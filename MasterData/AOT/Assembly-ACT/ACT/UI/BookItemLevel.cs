using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using Bamboo.ImageCenter;
using Fundamental;
using UnityEngine;

namespace ACT.UI;

public class BookItemLevel : MonoBehaviour
{
	[SerializeField]
	private BetterAnimation animation;

	[SerializeField]
	private BImage image;

	[SerializeField]
	public ActButton btn;

	[SerializeField]
	private GameObject[] completedRoot;

	[SerializeField]
	private GameObject[] lockedRoot;

	[SerializeField]
	private RedDotItem rewardRedDot;

	[SerializeField]
	private LiteItemUIComponent itemCell;

	[SerializeField]
	private GameObject receivedGo;

	[SerializeField]
	private CanvasGroup canvasGroup;

	private Material materialInstance;

	private int id;

	public void Init(int key, ImageAssetStation station, bool unlock, bool canPlayAnimation)
	{
		id = key;
		materialInstance = new Material(image.icon.material);
		materialInstance.SetFloat("_DeSaturate", unlock ? 0f : 1f);
		image.icon.material = materialInstance;
		SystemGuideData systemGuideData = RuntimeConfigs.data.systemGuideDatas[key];
		if (systemGuideData.condition.Length != 0)
		{
			List<ItemKv> certain = CoreUtils.GetData(systemGuideData.condition[0], RuntimeConfigs.data.collections).certain;
			if (certain.Count > 0)
			{
				Item item = new Item();
				item.Id = certain[0].id;
				item.Count = 0;
				itemCell.Station = station;
				itemCell.SetData(item, 0L, ItemUIComponentBase.InitType.RewardItem);
				itemCell.UpdatePerformance();
			}
		}
		GameObject[] array = completedRoot;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(unlock);
		}
		array = lockedRoot;
		for (int i = 0; i < array.Length; i++)
		{
			array[i].SetActive(!unlock);
		}
		if (G.localPlayer.SystemGuideChapter.TryGetValue(systemGuideData.chapter, out var value))
		{
			receivedGo.SetActive(value);
		}
		else
		{
			receivedGo.SetActive(value: false);
		}
		if (unlock)
		{
			string systemGuideChapterReward = RedDotPathDefine.SystemGuideChapterReward;
			rewardRedDot.fullPath = systemGuideChapterReward.Split("|").ToList();
			rewardRedDot.BindTrieNode();
			rewardRedDot.UpdateDisplay();
			Model<PlayerModel>.Interface.RefreshChapterRewardRedDot();
		}
		else
		{
			rewardRedDot.transform.gameObject.SetActive(value: false);
		}
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_JourneyTracesTabRefresh, RefreshStatus);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_JourneyTracesTabRefresh, RefreshStatus);
		canvasGroup.alpha = 1f;
		if (canPlayAnimation)
		{
			PlayEnterAnimation();
		}
	}

	private void RefreshStatus(BaseEventContent baseEventContent)
	{
		SystemGuideData systemGuideData = RuntimeConfigs.data.systemGuideDatas[id];
		if (systemGuideData == null)
		{
			if (G.localPlayer.SystemGuideChapter.TryGetValue(systemGuideData.chapter, out var value))
			{
				receivedGo.SetActive(value);
			}
			else
			{
				receivedGo.SetActive(value: false);
			}
		}
	}

	public void PlayEnterAnimation()
	{
		animation?.GetSequence("Show").Play();
	}

	protected void OnDestroy()
	{
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_JourneyTracesTabRefresh, RefreshStatus);
	}
}
