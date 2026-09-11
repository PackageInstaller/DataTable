using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace RogueCard;

public class RogueCardShopUI : RogueCardStateUIBase
{
	[Header("绑定UI")]
	public GameObject itemObj;

	public Transform itemContentTrs;

	public GameObject packageObj;

	public Transform packageContentTrs;

	public Button buyBtn;

	public Button refreshBtn;

	public Button buyBtnGray;

	public Button completeBtn;

	public Text refreshCostNum;

	[Header("刷新保护")]
	[SerializeField]
	private float shopRefreshLockDuration = 0.8f;

	private List<RogueCardShopItemUI> itemUIList;

	private List<RogueCardShopItemUI> packageUIList;

	public GameObject soldOutItemGo;

	public GameObject soldOutPacGo;

	public GameObject refreshGo;

	public override void Init()
	{
		if (itemUIList != null)
		{
			for (int num = itemUIList.Count - 1; num >= 0; num--)
			{
				Object.Destroy(itemUIList[num].gameObject);
			}
		}
		if (packageUIList != null)
		{
			for (int num2 = packageUIList.Count - 1; num2 >= 0; num2--)
			{
				Object.Destroy(packageUIList[num2].gameObject);
			}
		}
		itemUIList = new List<RogueCardShopItemUI>();
		packageUIList = new List<RogueCardShopItemUI>();
		AddBtnListener(buyBtn, delegate
		{
			RogueCardGameMain.Instance.BuyShopItem();
		});
		AddBtnListener(buyBtnGray, delegate
		{
			LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_CHOOSE_ONE");
		});
		AddBtnListener(completeBtn, delegate
		{
			if (!RogueCardGameMain.Instance.guideSystem.CheckScorePause(24404))
			{
				RogueCardGameMain.Instance.EndShop();
			}
		});
		AddBtnListener(refreshBtn, delegate
		{
			RogueCardGameMain.Instance.GetInputLock("ShopRefresh", base.gameObject, shopRefreshLockDuration);
			if (RogueCardGameMain.Instance.RefreshShopItem())
			{
				for (int i = 0; i < itemUIList.Count; i++)
				{
					itemUIList[i].mainAni.Play("UI_Com_JokerPropsitem_chongzhi");
				}
			}
		});
	}

	public override void OnEnter()
	{
		base.OnEnter();
	}

	public override void OnExit()
	{
		base.OnExit();
		if (itemUIList != null)
		{
			foreach (RogueCardShopItemUI itemUI in itemUIList)
			{
				if (itemUI != null)
				{
					Object.Destroy(itemUI.gameObject);
				}
			}
			itemUIList.Clear();
		}
		if (packageUIList == null)
		{
			return;
		}
		foreach (RogueCardShopItemUI packageUI in packageUIList)
		{
			if (packageUI != null)
			{
				Object.Destroy(packageUI.gameObject);
			}
		}
		packageUIList.Clear();
	}

	public override void RefreshUI()
	{
		if (RogueCardGameMain.GameContext.stageID == 101 || (RogueCardGameMain.GameContext.stageID == 102 && RogueCardGameMain.GameContext.curRound == 1))
		{
			refreshGo.SetActive(value: false);
		}
		else
		{
			refreshGo.SetActive(value: true);
		}
		soldOutItemGo.SetActive(value: false);
		soldOutPacGo.SetActive(value: false);
		if (RogueCardGameMain.Instance.saveSystem.saveLock)
		{
			return;
		}
		RogueCardShopData shopData = RogueCardGameMain.Instance.gameContext.shopData;
		if (shopData.selectIndex < 0)
		{
			buyBtn.gameObject.SetActive(value: false);
			buyBtnGray.gameObject.SetActive(value: true);
		}
		else
		{
			buyBtn.gameObject.SetActive(value: true);
			buyBtnGray.gameObject.SetActive(value: false);
		}
		foreach (RogueCardShopItemUI itemUI in itemUIList)
		{
			itemUI.Show(isShow: false);
		}
		foreach (RogueCardShopItemUI packageUI in packageUIList)
		{
			packageUI.Show(isShow: false);
		}
		for (int i = 0; i < shopData.shopItemDataList.Count; i++)
		{
			if (itemUIList.Count <= i)
			{
				GameObject gameObject = Object.Instantiate(itemObj, itemContentTrs);
				itemUIList.Add(gameObject.GetComponent<RogueCardShopItemUI>());
				itemUIList[i].BindBtn(delegate(int index)
				{
					RogueCardGameMain.Instance.gameContext.shopData.SelectItem(index);
				});
			}
			itemUIList[i].Show(isShow: true);
			itemUIList[i].SetData(shopData.shopItemDataList[i]);
			itemUIList[i].index = shopData.shopItemDataList[i].index;
		}
		if (shopData.shopItemDataList.Count == 0)
		{
			soldOutItemGo.SetActive(value: true);
		}
		for (int num = 0; num < shopData.shopPackageDataList.Count; num++)
		{
			if (packageUIList.Count <= num)
			{
				GameObject gameObject2 = Object.Instantiate(packageObj, packageContentTrs);
				packageUIList.Add(gameObject2.GetComponent<RogueCardShopItemUI>());
				packageUIList[num].BindBtn(delegate(int index)
				{
					RogueCardGameMain.Instance.gameContext.shopData.SelectItem(index);
				});
			}
			packageUIList[num].Show(isShow: true);
			packageUIList[num].SetData(shopData.shopPackageDataList[num]);
			packageUIList[num].index = shopData.shopPackageDataList[num].index;
		}
		if (shopData.shopPackageDataList.Count == 0)
		{
			soldOutPacGo.SetActive(value: true);
		}
		int selectIndex = RogueCardGameMain.Instance.gameContext.shopData.selectIndex;
		foreach (RogueCardShopItemUI itemUI2 in itemUIList)
		{
			if (itemUI2.index == selectIndex)
			{
				itemUI2.SetSelected(isSelect: true);
			}
			else
			{
				itemUI2.SetSelected(isSelect: false);
			}
		}
		foreach (RogueCardShopItemUI packageUI2 in packageUIList)
		{
			if (packageUI2.index == selectIndex)
			{
				packageUI2.SetSelected(isSelect: true);
			}
			else
			{
				packageUI2.SetSelected(isSelect: false);
			}
		}
		refreshCostNum.text = RogueCardGameMain.GameContext.shopData.curRefreshCost.ToString();
		if (RogueCardGameMain.GameContext.shopData.curRefreshCost > RogueCardGameMain.GameContext.gold)
		{
			refreshCostNum.color = Color.red;
		}
		else
		{
			refreshCostNum.SetColor(Color.white);
		}
	}
}
