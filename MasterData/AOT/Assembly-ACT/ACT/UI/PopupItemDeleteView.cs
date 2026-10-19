using System.Collections.Generic;
using ACT.Config;
using ACT.Core;
using ACT.Game;
using ACT.Game.Data;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class PopupItemDeleteView : BaseUIView
{
	private PopupItemDeleteViewData m_data;

	private MonoInventoryView bagView;

	private List<OperationItem> itemList;

	private List<Item> rewards;

	public LoopHorizontalScrollRect deleteRect;

	public LoopHorizontalScrollRect RewardRect;

	public LayoutElement deleItemLayoutElement;

	public LayoutElement rewardItemLayoutElement;

	public HorizontalLayoutGroup delelayoutGroup;

	public HorizontalLayoutGroup rewardlayoutGroup;

	private int itemType;

	protected override void AddEventListener()
	{
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		m_data = uiViewData as PopupItemDeleteViewData;
		bagView = Singleton<NewUIManager>.instance.FindUIViewByUIType(UI_TYPE.UI_BAGPANEL) as MonoInventoryView;
		itemList = new List<OperationItem>();
		rewards = new List<Item>();
		CalculateRewardsAndDeleteItems();
		Open();
		ReSize(isDeleScrollRect: true, itemList.Count);
		ReSize(isDeleScrollRect: false, rewards.Count);
		base.Init();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		rewards.Clear();
		itemList.Clear();
		base.UnInit();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}

	private void ReSize(bool isDeleScrollRect, int itemsCount)
	{
		LoopHorizontalScrollRect loopHorizontalScrollRect = (isDeleScrollRect ? deleteRect : RewardRect);
		float x = ((RectTransform)loopHorizontalScrollRect.transform).sizeDelta.x;
		float num = (isDeleScrollRect ? ((float)itemsCount * deleItemLayoutElement.preferredWidth + (float)(itemsCount - 1) * delelayoutGroup.spacing) : ((float)itemsCount * rewardItemLayoutElement.preferredWidth + (float)(itemsCount - 1) * rewardlayoutGroup.spacing));
		loopHorizontalScrollRect.viewport.sizeDelta = new Vector2(Mathf.Min(num, x), loopHorizontalScrollRect.viewport.sizeDelta.y);
		if (num > x)
		{
			loopHorizontalScrollRect.movementType = LoopScrollRectBase.MovementType.Clamped;
		}
		else
		{
			loopHorizontalScrollRect.movementType = LoopScrollRectBase.MovementType.Elastic;
		}
	}

	public void Open()
	{
		deleteRect.totalCount = itemList.Count;
		RewardRect.totalCount = rewards.Count;
		deleteRect.RefillCells();
		RewardRect.RefillCells();
	}

	public void CalculateRewardsAndDeleteItems()
	{
		switch (m_data.itemType)
		{
		case 1:
			itemType = 3;
			{
				foreach (Weapon weapon in m_data.deleteItems.weapons)
				{
					foreach (ItemKv item in CoreUtils.GetData(weapon.WeaponId, RuntimeConfigs.data.itemDatas).deleteCompensate)
					{
						GetReward(item);
					}
					itemList.Add(new OperationItem
					{
						Index = weapon.Uid,
						Count = 1
					});
				}
				return;
			}
		case 2:
			itemType = 4;
			{
				foreach (Chip chip in m_data.deleteItems.chips)
				{
					foreach (ItemKv item2 in CoreUtils.GetData(chip.Id, RuntimeConfigs.data.itemDatas).deleteCompensate)
					{
						GetReward(item2);
					}
					itemList.Add(new OperationItem
					{
						Index = chip.Uid,
						Count = 1
					});
				}
				return;
			}
		}
		foreach (Item item3 in m_data.deleteItems.items)
		{
			foreach (ItemKv item4 in CoreUtils.GetData(item3.Id, RuntimeConfigs.data.itemDatas).deleteCompensate)
			{
				for (int i = 0; i < item3.Count; i++)
				{
					GetReward(item4);
				}
			}
			itemList.Add(new OperationItem
			{
				Index = item3.Id,
				Count = item3.Count
			});
		}
	}

	private void GetReward(ItemKv reward)
	{
		if (rewards.Count == 0)
		{
			rewards.Add(new Item
			{
				Id = reward.id,
				Count = reward.count
			});
			return;
		}
		foreach (Item reward2 in rewards)
		{
			if (reward2.Id == reward.id)
			{
				reward2.Count += reward.count;
				continue;
			}
			rewards.Add(new Item
			{
				Id = reward.id,
				Count = reward.count
			});
		}
	}

	public void DeleteItems(int itemType, List<OperationItem> items)
	{
		G.service.DeleteItems(itemType, items, (bool isSuccess) =>
		{
			_ = bagView != null;
			GameUtility.OpenPopReward(GameUtility.ToUniversalItems(rewards), notSort: false, () =>
			{
				rewards?.Clear();
			});
		});
	}

	public void ConfirmBtn()
	{
		DeleteItems(itemType, itemList);
		Close();
	}

	public void RefreshDeleteCellContent(ItemUIComponent cell, int index)
	{
		cell.showDetailPanel = false;
		switch (m_data.itemType)
		{
		case 1:
			cell.BagWeaponInit(m_data.deleteItems.weapons[index]);
			break;
		case 2:
			cell.BagChipInit(m_data.deleteItems.chips[index]);
			break;
		default:
			cell.NoneItemInit(m_data.deleteItems.items[index]);
			break;
		}
	}

	public void RefreshRewardCellContent(ItemUIComponent cell, int index)
	{
		cell.showDetailPanel = false;
		cell.RewardItemInit(rewards[index]);
	}
}
