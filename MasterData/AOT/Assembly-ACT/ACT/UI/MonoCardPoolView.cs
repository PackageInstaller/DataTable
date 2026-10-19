using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using Bamboo.Chronos;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoCardPoolView : BaseUIView
{
	public struct CardPoolData
	{
		public CardPool cardPool;

		public CardPoolComponent cardPoolComponent;
	}

	public PublicToggleGroup toggles;

	public GameObject togglePrefab;

	public Dictionary<int, CardPoolData> cardPoolData = new Dictionary<int, CardPoolData>();

	public LocalizeStringEvent cardPoolName;

	public TextMeshProUGUI cardPoolTime;

	public TextMeshProUGUI cardPoolTimeDesc;

	public CostItemComponent[] costItems;

	public BImage fiveStarShow;

	public LocalizeStringEvent fiveStarShowName;

	public BImage[] fourstar;

	public TextMeshProUGUI consume;

	public TextMeshProUGUI limitMax;

	public int limitMaxId = 81;

	public int notEnoughId = 81;

	private bool m_Init;

	private int m_CurCardPoolID = -1;

	private Looper loopMs;

	protected override void Init()
	{
		base.Init();
		if (consume != null)
		{
			consume.SetText("{0:0}", RuntimeConfigs.data.game.cardpoolDrawMax - G.localPlayer.DailyData.GachaNum);
		}
		if (limitMax != null)
		{
			limitMax.SetText("{0:0}", RuntimeConfigs.data.game.cardpoolDrawMax);
		}
		ImageAssetStation station = GetComponentInParent<IBaseUIView>().Station;
		bool flag = true;
		foreach (KeyValuePair<int, CardPool> cardPool in RuntimeConfigs.data.cardPools)
		{
			if (GameUtility.DataTimeInRange(cardPool.Value.poolStartTs, cardPool.Value.poolEndTs))
			{
				CardPoolComponent component = UnityEngine.Object.Instantiate(togglePrefab, toggles.transform).GetComponent<CardPoolComponent>();
				PublicToggle toggle = component.toggle;
				toggle.group = toggles;
				toggle.onValueChanged.AddListener((bool _) =>
				{
					OnChangeValue(cardPool.Value.id);
				});
				station.LoadImage(113, cardPool.Value.btnIconSelected, component.selected);
				station.LoadImage(113, cardPool.Value.btnIconNormal, component.normal);
				cardPoolData[cardPool.Value.id] = new CardPoolData
				{
					cardPool = cardPool.Value,
					cardPoolComponent = component
				};
				if (flag)
				{
					toggle.isOn = true;
					m_CurCardPoolID = cardPool.Value.id;
					OnChangeValue(m_CurCardPoolID);
				}
				flag = false;
			}
		}
		m_Init = true;
		if (loopMs.IsValid())
		{
			return;
		}
		loopMs = UpdateTimer.Default.LoopMs(1, () =>
		{
			if (m_Init)
			{
				long num = cardPoolData[m_CurCardPoolID].cardPool.poolEndTs - TimeManager.ServerTime.NowTimestamp;
				if (num > 100000000000L)
				{
					if (!cardPoolTimeDesc.gameObject.activeSelf)
					{
						cardPoolTimeDesc.gameObject.SetActive(value: true);
					}
					if (cardPoolTime.gameObject.activeSelf)
					{
						cardPoolTime.gameObject.SetActive(value: false);
					}
				}
				else
				{
					if (cardPoolTimeDesc.gameObject.activeSelf)
					{
						cardPoolTimeDesc.gameObject.SetActive(value: false);
					}
					if (!cardPoolTime.gameObject.activeSelf)
					{
						cardPoolTime.gameObject.SetActive(value: true);
					}
					cardPoolTime.text = TimeManager.TimeSpanToString(TimeSpan.FromMilliseconds((num > 0) ? num : 0), ETimeSpanFormatType.Type_DHM_Ch);
				}
			}
		});
	}

	protected override void UnInit()
	{
		base.UnInit();
		loopMs.Cancel();
		DataReset();
	}

	public void OnChangeValue(int id)
	{
		if (cardPoolData[id].cardPoolComponent.toggle.isOn)
		{
			OnBtnChange(id);
		}
	}

	private void OnBtnChange(int id)
	{
		if (id != m_CurCardPoolID)
		{
			m_CurCardPoolID = id;
			UpdateCardPoolPage();
		}
	}

	private void UpdateCardPoolPage()
	{
		CardPoolData cardPoolData = this.cardPoolData[m_CurCardPoolID];
		cardPoolName.StringReference.TableEntryReference = cardPoolData.cardPool.name;
		GetComponentInParent<IBaseUIView>().Station.LoadImage(113, cardPoolData.cardPool.fiveStarShowAddress, fiveStarShow);
		for (int i = 0; i < fourstar.Length; i++)
		{
			Station.LoadSprite(GameLoader.meta.cardPoolHalfBodyAssetID, cardPoolData.cardPool.fourStarShowAddress[i], fourstar[i]);
		}
		fiveStarShowName.StringReference.TableEntryReference = cardPoolData.cardPool.fiveStarShow;
		int num = 0;
		CostItemComponent[] array = costItems;
		foreach (CostItemComponent costItemComponent in array)
		{
			costItemComponent.gameObject.SetActive(value: false);
			if (num < RuntimeConfigs.data.cardPools[m_CurCardPoolID].showPrice.Length)
			{
				costItemComponent.gameObject.SetActive(value: true);
			}
			num++;
		}
		RefreshItemView();
	}

	public void OnceCall()
	{
		DrawCard(1);
	}

	public void TenCall()
	{
		DrawCard(10);
	}

	public void DrawCard(int num)
	{
		if (G.localPlayer.DailyData.GachaNum + num > RuntimeConfigs.data.game.cardpoolDrawMax)
		{
			GameUtility.OpenToolTip(limitMaxId);
		}
		else if (Check(num))
		{
			G.service.DrawCard(m_CurCardPoolID, num, (bool success, RepeatedField<Item> items) =>
			{
				if (success)
				{
					List<Item> list = new List<Item>(items.Count);
					list.AddRange(items);
					foreach (Item item in items)
					{
						_ = item;
					}
					if (num > 1)
					{
						GameUtility.OpenPopReward(GameUtility.ToUniversalItems(list));
					}
					else
					{
						GameUtility.OpenPopReward(GameUtility.ToUniversalItems(list));
					}
					RefreshItemView();
					G.localPlayer.DailyData.GachaNum += num;
					if (consume != null)
					{
						consume.SetText("{0:0}", G.localPlayer.DailyData.GachaNum);
					}
				}
			});
		}
		else
		{
			GameUtility.OpenToolTip(notEnoughId);
		}
	}

	public void DataReset()
	{
		foreach (KeyValuePair<int, CardPoolData> cardPoolDatum in cardPoolData)
		{
			cardPoolDatum.Value.cardPoolComponent.UnLoad();
			UnityEngine.Object.Destroy(cardPoolDatum.Value.cardPoolComponent.gameObject);
		}
		for (int i = 0; i < fourstar.Length; i++)
		{
			fourstar[i].UnLoad();
		}
		int num = 0;
		CostItemComponent[] array = costItems;
		for (int j = 0; j < array.Length; j++)
		{
			_ = array[j];
			num++;
		}
		cardPoolData.Clear();
		m_CurCardPoolID = -1;
		m_Init = false;
	}

	public bool Check(int count)
	{
		List<ItemKv> poolPrice = cardPoolData[m_CurCardPoolID].cardPool.poolPrice;
		for (int i = 0; i < poolPrice.Count; i++)
		{
			if (RuntimeConfigs.data.itemDatas[poolPrice[i].id].type == 999)
			{
				if (G.detailUserInfo.Attributes.ContainsKey(poolPrice[i].id) && G.detailUserInfo.Attributes[poolPrice[i].id] >= poolPrice[i].count * count)
				{
					return true;
				}
				continue;
			}
			Item itemInfo = G.localPlayer.Inventory.GetItemInfo(poolPrice[i].id);
			if (itemInfo != null && itemInfo.Count >= poolPrice[i].count * count)
			{
				return true;
			}
		}
		return false;
	}

	public async void RefreshItemView()
	{
		int num = 0;
		CostItemComponent[] array = costItems;
		for (int i = 0; i < array.Length; i++)
		{
			_ = array[i];
			if (num < RuntimeConfigs.data.cardPools[m_CurCardPoolID].showPrice.Length)
			{
				int num2 = RuntimeConfigs.data.cardPools[m_CurCardPoolID].showPrice[num];
				if (RuntimeConfigs.data.itemDatas[num2].type == 999 && G.detailUserInfo.Attributes.ContainsKey(num2))
				{
					costItems[num].priceText.text = G.detailUserInfo.Attributes[num2].ToString();
				}
				else if (RuntimeConfigs.data.itemDatas[num2].type != 999 && G.localPlayer.Inventory.GetItemInfo(num2) != null)
				{
					costItems[num].priceText.SetText("{0:0}", G.localPlayer.Inventory.GetItemInfo(num2).Count);
				}
				else
				{
					costItems[num].priceText.text = "0";
				}
			}
			num++;
		}
		await UniTask.Yield(PlayerLoopTiming.LastPostLateUpdate);
		LayoutRebuilder.ForceRebuildLayoutImmediate((RectTransform)transform);
	}

	public async void OpenRuleWin()
	{
		await Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_CARDPOOLDETAIL, new CardPoolDetailView.CardPoolData
		{
			cardPool = cardPoolData[m_CurCardPoolID].cardPool
		});
	}
}
