using System;
using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class ProductPanel : MonoBehaviour
{
	public LocalizeStringEvent porductionName;

	public ItemUIComponent production;

	public ItemUIComponent[] materials;

	public List<Item> materialLists = new List<Item>();

	public GameObject sliderObj;

	public LimitedSlider slider;

	public TextMeshProUGUI max_Text;

	public TextMeshProUGUI canProdceText;

	public TextMeshProUGUI moneyCount;

	public int produceCount;

	public int canProduceCount;

	public int productId;

	public int perPrice;

	public MonoScrollBagComponent.Param param;

	private void Start()
	{
		slider.minValue = 1f;
		param = default;
		param.allItems.items = new List<Item>();
		param.itemShowType = MonoScrollBagComponent.Param.ItemShowType.Reward;
	}

	public void InitProductPanel(ItemUIComponentBase itemUIComponentBase)
	{
		ItemUIComponent item = itemUIComponentBase as ItemUIComponent;
		canProduceCount = int.MaxValue;
		materialLists.Clear();
		productId = item.item.Id;
		production.OnItemClick = null;
		ItemUIComponent itemUIComponent = production;
		itemUIComponent.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(itemUIComponent.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
		{
			OnItemChosen(item.item);
		}));
		porductionName.StringReference.TableEntryReference = RuntimeConfigs.data.itemDatas[productId].nameLocal;
		perPrice = RuntimeConfigs.data.itemRecipeDatas[productId].moneyNeeded;
		SetCountBtn();
		UpdateSliderAndPanel();
	}

	public void UpdateParam()
	{
		if (param.allItems.items != null)
		{
			param.allItems.items.Clear();
		}
		Item item = new Item();
		item.Id = productId;
		item.Count = produceCount;
		param.allItems.items.Add(item);
	}

	public void UpdateSliderAndPanel()
	{
		List<ItemKv> itemNeeded = RuntimeConfigs.data.itemRecipeDatas[productId].itemNeeded;
		for (int i = 0; i < materials.Length; i++)
		{
			int num = 0;
			if (i >= itemNeeded.Count)
			{
				materials[i].gameObject.SetActive(value: false);
				continue;
			}
			materials[i].gameObject.SetActive(value: true);
			Item itemNeeded2;
			if (G.localPlayer.Inventory.GetItemInfo(itemNeeded[i].id) != null)
			{
				itemNeeded2 = G.localPlayer.Inventory.GetItemInfo(itemNeeded[i].id);
			}
			else
			{
				itemNeeded2 = new Item();
				itemNeeded2.Id = itemNeeded[i].id;
				itemNeeded2.Count = 0;
			}
			if (materialLists.Count == 0)
			{
				materialLists.Add(itemNeeded2);
			}
			num = itemNeeded2.Count;
			materials[i].OnItemClick = null;
			ItemUIComponent obj = materials[i];
			obj.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(obj.OnItemClick, (UnityAction<ItemUIComponentBase>)((ItemUIComponentBase l) =>
			{
				OnItemChosen(itemNeeded2);
			}));
			canProduceCount = Mathf.Min(canProduceCount, num / itemNeeded[i].count);
		}
		if (canProduceCount == 0)
		{
			sliderObj.SetActive(value: false);
			canProdceText.SetText("{0:0}", canProduceCount);
			moneyCount.SetText("{0:0}", 0f);
			return;
		}
		sliderObj.SetActive(value: true);
		if (G.localPlayer.Inventory.GetItemInfo(productId) != null)
		{
			slider.limit = RuntimeConfigs.data.itemDatas[productId].stackLimit - G.localPlayer.Inventory.GetItemInfo(productId).Count;
		}
		else
		{
			slider.limit = RuntimeConfigs.data.itemDatas[productId].stackLimit;
		}
		slider.maxValue = canProduceCount;
		max_Text.SetText("{0:0}", canProduceCount);
		slider.value = 1f;
		moneyCount.SetText("{0:0}", (int)slider.value * perPrice);
	}

	private void OnItemChosen(Item item)
	{
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPDETAIL, item);
	}

	public void SetCountBtn()
	{
		produceCount = (int)slider.value;
		canProdceText.SetText("{0:0}", slider.value);
		moneyCount.SetText("{0:0}", produceCount * perPrice);
	}

	public void AddBtn()
	{
		if (slider.value != slider.maxValue && slider.value != slider.limit)
		{
			slider.value++;
		}
	}

	public void ReduceBtn()
	{
		if (slider.limit != 0f)
		{
			slider.value--;
		}
	}
}
