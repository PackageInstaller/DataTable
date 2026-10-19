using System.Collections.Generic;
using System.Linq;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;

namespace ACT.UI;

public class MonoProductionTableView : BaseUIView
{
	private MonoScrollBagComponent.Param scrollBagParam;

	public MonoScrollBagComponent scrollBag;

	public PublicToggleGroup toggles;

	public ProductPanel productPanel;

	private List<Item> chipList;

	private List<Item> materialList;

	private List<Item> otherList;

	private List<Item> adequateList;

	private List<Item> inadequateList;

	private int curPageIndex = -1;

	private bool refresh;

	private int adequateCount;

	private void Start()
	{
		scrollBagParam.onSelectItem = productPanel.InitProductPanel;
		scrollBagParam.itemShowType = MonoScrollBagComponent.Param.ItemShowType.None;
		LoadTable();
		adequateList = new List<Item>();
		inadequateList = new List<Item>();
	}

	private void LoadTable()
	{
		chipList = new List<Item>();
		materialList = new List<Item>();
		otherList = new List<Item>();
		scrollBagParam.allItems.items = new List<Item>();
		foreach (KeyValuePair<int, ItemRecipeData> itemRecipeData in RuntimeConfigs.data.itemRecipeDatas)
		{
			int key = itemRecipeData.Key;
			Item item;
			if (G.localPlayer.Inventory.GetItemInfo(key) != null)
			{
				item = G.localPlayer.Inventory.GetItemInfo(key);
			}
			else
			{
				item = new Item();
				item.Id = key;
				item.Count = 0;
			}
			switch (itemRecipeData.Value.recipeType)
			{
			case 1:
				chipList.Add(item);
				break;
			case 2:
				materialList.Add(item);
				break;
			case 3:
				otherList.Add(item);
				break;
			}
		}
	}

	protected override void Init()
	{
		base.Init();
		toggles.toggles[0].isOn = true;
		OnChangeValue(0);
	}

	public void OnChangeValue(int index)
	{
		if (toggles.toggles[index].isOn)
		{
			OnBtnPageChange(index);
		}
	}

	protected override void UnInit()
	{
		base.UnInit();
		scrollBag.ReleaseAllItemPrefab();
	}

	private void OnBtnPageChange(int index)
	{
		if (index != curPageIndex || refresh)
		{
			refresh = false;
			ParamClear();
			UpdateData(index);
			scrollBagParam.toGrayNum = adequateCount;
			scrollBag.Init(scrollBagParam, 0);
			curPageIndex = index;
		}
	}

	private void UpdateData(int index)
	{
		List<Item> list = new List<Item>();
		switch (index)
		{
		case 0:
			list = chipList;
			break;
		case 1:
			list = materialList;
			break;
		case 2:
			list = otherList;
			break;
		}
		foreach (Item item in list)
		{
			if (RuntimeConfigs.data.itemRecipeDatas[item.Id].repeatable || item.Count <= 0)
			{
				if (isEnoughMaterial(item))
				{
					adequateList.Add(item);
				}
				else
				{
					inadequateList.Add(item);
				}
			}
		}
		adequateCount = adequateList.Count;
		scrollBagParam.allItems.items = adequateList.Concat(inadequateList).ToList();
	}

	private bool isEnoughMaterial(Item item)
	{
		foreach (ItemKv item2 in RuntimeConfigs.data.itemRecipeDatas[item.Id].itemNeeded)
		{
			if (G.localPlayer.Inventory.GetItemInfo(item2.id) == null)
			{
				return false;
			}
			if (G.localPlayer.Inventory.GetItemInfo(item2.id).Count < item2.count)
			{
				return false;
			}
		}
		return true;
	}

	private void ParamClear()
	{
		if (adequateList != null)
		{
			adequateList.Clear();
		}
		if (inadequateList != null)
		{
			inadequateList.Clear();
		}
	}

	public void MakeProductBtn()
	{
		if (!(ToolTip.Instance != null) || !ToolTip.Instance.isRun)
		{
			if (productPanel.canProduceCount == 0)
			{
				GameUtility.OpenToolTip(81);
			}
			else if (productPanel.slider.limit == 0f)
			{
				GameUtility.OpenToolTip(241);
			}
			else if (!G.detailUserInfo.Attributes.ContainsKey(2) || productPanel.produceCount * productPanel.perPrice > G.detailUserInfo.Attributes[2])
			{
				GameUtility.OpenToolTip(81);
			}
			else
			{
				SendProductMessage();
			}
		}
	}

	public void SendProductMessage()
	{
		productPanel.UpdateParam();
		G.service.MakingProducts(productPanel.productId, productPanel.produceCount, () =>
		{
			GameUtility.OpenPopReward(GameUtility.ToUniversalItems(productPanel.param.allItems.items));
			if (productPanel.produceCount == productPanel.canProduceCount)
			{
				UpdateView();
			}
			else
			{
				productPanel.UpdateSliderAndPanel();
			}
		});
	}

	private void UpdateView()
	{
		refresh = true;
		UpdateData(curPageIndex);
		toggles.toggles[curPageIndex].isOn = true;
		OnChangeValue(curPageIndex);
	}
}
