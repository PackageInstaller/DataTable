using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using UnityEngine.Localization.Components;

namespace ACT.UI;

public class CardPoolDetailView : BaseUIView
{
	public class CardPoolData : UIViewData
	{
		public CardPool cardPool;
	}

	public CardPoolData data;

	public LocalizeStringEvent cardPoolName;

	public LocalizeStringEvent cardPoolRule;

	public List<CardPoolDetailComponent> fiveUPItem;

	public List<CardPoolDetailComponent> fourUPItem;

	public List<CardPoolDetailComponent> fiveCharacterList;

	public List<CardPoolDetailComponent> fourCharacterList;

	public List<CardPoolDetailComponent> threeCharacterList;

	public List<CardPoolDetailComponent> fiveWeaponList;

	public List<CardPoolDetailComponent> fourWeaponList;

	public List<CardPoolDetailComponent> threeWeaponList;

	protected override void Init()
	{
		base.Init();
		data = (CardPoolData)uiViewData;
		cardPoolName.StringReference.TableEntryReference = data.cardPool.name;
		SetUPItem(data.cardPool.rulePopupFiveItem, fiveUPItem);
		SetUPItem(data.cardPool.rulePopupFourItem, fourUPItem);
		cardPoolRule.StringReference.TableEntryReference = data.cardPool.rulePupupDesc;
		SetItemList();
	}

	private void SetItemList()
	{
		if (fiveCharacterList != null)
		{
			List<Maybe> itemList = RuntimeConfigs.data.rewards[data.cardPool.fiveStarRewardID].dropItem.FindAll(FindCharacter);
			SetList(itemList, fiveCharacterList);
		}
		if (fiveWeaponList != null)
		{
			List<Maybe> itemList2 = RuntimeConfigs.data.rewards[data.cardPool.fiveStarRewardID].dropItem.FindAll(FindWeapen);
			SetList(itemList2, fiveWeaponList);
		}
		if (fourCharacterList != null)
		{
			List<Maybe> itemList3 = RuntimeConfigs.data.rewards[data.cardPool.fourStarRewardID].dropItem.FindAll(FindCharacter);
			SetList(itemList3, fourCharacterList);
		}
		if (fourWeaponList != null)
		{
			List<Maybe> itemList4 = RuntimeConfigs.data.rewards[data.cardPool.fourStarRewardID].dropItem.FindAll(FindWeapen);
			SetList(itemList4, fourWeaponList);
		}
		if (threeCharacterList != null)
		{
			List<Maybe> itemList5 = RuntimeConfigs.data.rewards[data.cardPool.threeStarRewardID].dropItem.FindAll(FindCharacter);
			SetList(itemList5, threeCharacterList);
		}
		if (threeWeaponList != null)
		{
			List<Maybe> itemList6 = RuntimeConfigs.data.rewards[data.cardPool.threeStarRewardID].dropItem.FindAll(FindWeapen);
			SetList(itemList6, threeWeaponList);
		}
	}

	private void SetList(List<Maybe> itemList, List<CardPoolDetailComponent> targetList)
	{
		for (int i = 0; i < targetList.Count; i++)
		{
			bool active = false;
			if (i < itemList.Count)
			{
				active = true;
				targetList[i].itemName.StringReference.TableEntryReference = RuntimeConfigs.data.itemDatas[itemList[i].id].nameLocal;
			}
			targetList[i].gameObject.SetActive(active);
		}
	}

	private void SetUPItem(int[] upList, List<CardPoolDetailComponent> targetList)
	{
		for (int i = 0; i < targetList.Count; i++)
		{
			bool active = false;
			if (i < upList.Length)
			{
				active = true;
				targetList[i].Init(RuntimeConfigs.data.entityDatas[upList[i]].nameLocal);
			}
			targetList[i].gameObject.SetActive(active);
		}
	}

	public bool FindCharacter(Maybe item)
	{
		return RuntimeConfigs.data.itemDatas[item.id].type == 5;
	}

	public bool FindWeapen(Maybe item)
	{
		return RuntimeConfigs.data.itemDatas[item.id].type == 3;
	}

	protected override void UnInit()
	{
		base.UnInit();
	}
}
