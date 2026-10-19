using System;
using ACT.Game.Data;
using ACT.Model;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.ViewControl;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.UI;

namespace ACT.UI;

public class BattlePassRewardItem : LoopScrollBaseItem
{
	[SerializeField]
	private CanvasGroup _canvasGroup;

	[SerializeField]
	private BetterAnimation _animation;

	[SerializeField]
	[Header("免费奖励ItemCell")]
	private ItemUIComponentBase[] _fressRewardItemCells;

	[SerializeField]
	[Header("高级通行证ItemCell")]
	private ItemUIComponentBase[] _premiumRewardItemCells;

	[SerializeField]
	private TextMeshProUGUI _levelText;

	[SerializeField]
	private GameObject _canReceive;

	[SerializeField]
	[Header("第一个表示小于当前等级，第二个表示当前等级，第三个表示大于当前等级")]
	private GameObject[] _backBord;

	[SerializeField]
	[Header("第一个表示小于当前等级，第二个表示当前等级，第三个表示大于当前等级")]
	private Color[] _levelColors;

	[SerializeField]
	private OperateBtnPrompt _selectPremiumRewardPrompt;

	[SerializeField]
	private OperateBtnPrompt _selectGetRewardPrompt;

	[SerializeField]
	[Header("手柄输入Layer")]
	private ViewControlLayer _viewControlLayer;

	private const string DefaultName = "BattlePassRewardItem";

	private const string ShowAnimation = "show";

	private const string HideAnimation = "Hide";

	private BattlePassModel _battlePassModel;

	private int _rewardLevel;

	private bool _isGamePadSelected;

	private const int SelectLocalizeKey = 774;

	private const int ClaimLocalizeKey = 13;

	private bool IsStageReward
	{
		get
		{
			if (_backBord != null)
			{
				return _backBord.Length == 0;
			}
			return true;
		}
	}

	public override void ScrollCellIndex(int idx)
	{
		base.ScrollCellIndex(idx);
		_animation.GetSequence("show").Complete();
	}

	public void GotoShow()
	{
		_animation.GetSequence("show").Goto(0f);
	}

	public void PlayAnimation()
	{
		if (_animation != null)
		{
			_animation.GetSequence("show").Play();
		}
	}

	private void OnItemClick(ItemUIComponentBase item)
	{
		BattlePassRewardUIComponent battlePassRewardUIComponent = item as BattlePassRewardUIComponent;
		if (battlePassRewardUIComponent == null)
		{
			return;
		}
		if (Array.IndexOf(_fressRewardItemCells, item) >= 0)
		{
			if (_battlePassModel.GetFreeReward(_rewardLevel).CanClaim)
			{
				_battlePassModel.ClaimRewards(_rewardLevel, isPremium: false);
			}
			else
			{
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, battlePassRewardUIComponent.ItemUnifier);
			}
		}
		else if (_battlePassModel.GetPremiumReward(_rewardLevel).CanClaim)
		{
			_battlePassModel.ClaimRewards(_rewardLevel, isPremium: true);
		}
		else
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPITEMDETAIL, battlePassRewardUIComponent.ItemUnifier);
		}
	}

	public void Init(int rewardIndex)
	{
		_canvasGroup.alpha = 1f;
		_battlePassModel = Model<BattlePassModel>.Interface;
		_rewardLevel = rewardIndex + 1;
		_levelText.SetText("{0:0}", _rewardLevel);
		int currentLevel = _battlePassModel.CurrentLevel;
		GameObject[] backBord = _backBord;
		if (backBord != null && backBord.Length == 3)
		{
			for (int i = 0; i < _backBord.Length; i++)
			{
				bool active = i switch
				{
					0 => _rewardLevel < currentLevel, 
					1 => _rewardLevel == currentLevel, 
					2 => _rewardLevel > currentLevel, 
					_ => false, 
				};
				_backBord[i].SetActive(active);
			}
		}
		Color[] levelColors = _levelColors;
		if (levelColors != null && levelColors.Length == 3)
		{
			int num = ((_rewardLevel >= currentLevel) ? ((_rewardLevel == currentLevel) ? 1 : 2) : 0);
			_levelText.color = _levelColors[num];
		}
		if (_battlePassModel.AllFreeRewardsDic.TryGetValue(_rewardLevel, out var value))
		{
			ItemUIComponentBase[] fressRewardItemCells = _fressRewardItemCells;
			for (int j = 0; j < fressRewardItemCells.Length; j++)
			{
				bool flag = j < value.RewardItems.Count;
				if (flag)
				{
					int item = value.RewardItems[j].itemId;
					int item2 = value.RewardItems[j].count;
					ItemUnifierProxy item3 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item, item2);
					BattlePassRewardUIComponent battlePassRewardUIComponent = fressRewardItemCells[j] as BattlePassRewardUIComponent;
					if (battlePassRewardUIComponent != null)
					{
						battlePassRewardUIComponent.SetData(item3, long.MinValue, value.IsClaimed ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
						battlePassRewardUIComponent.IsLock = value.IsLocked;
						battlePassRewardUIComponent.CanClaim = value.CanClaim;
						battlePassRewardUIComponent.UpdatePerformance();
						battlePassRewardUIComponent.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Remove(battlePassRewardUIComponent.OnItemClick, new UnityAction<ItemUIComponentBase>(OnItemClick));
						battlePassRewardUIComponent.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(battlePassRewardUIComponent.OnItemClick, new UnityAction<ItemUIComponentBase>(OnItemClick));
					}
				}
				fressRewardItemCells[j].gameObject.SetActive(flag);
			}
		}
		else
		{
			Debug.LogError($"通行证等级->{_rewardLevel}的免费奖励等级不在所有免费奖励字典中？？？");
		}
		if (_battlePassModel.AllPremiumRewardsDic.TryGetValue(_rewardLevel, out var value2))
		{
			ItemUIComponentBase[] premiumRewardItemCells = _premiumRewardItemCells;
			for (int k = 0; k < premiumRewardItemCells.Length; k++)
			{
				bool flag2 = k < value2.RewardItems.Count;
				if (flag2)
				{
					int item4 = value2.RewardItems[k].itemId;
					int item5 = value2.RewardItems[k].count;
					ItemUnifierProxy item6 = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item4, item5);
					BattlePassRewardUIComponent battlePassRewardUIComponent2 = premiumRewardItemCells[k] as BattlePassRewardUIComponent;
					if (battlePassRewardUIComponent2 != null)
					{
						battlePassRewardUIComponent2.SetData(item6, long.MinValue, value2.IsClaimed ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
						battlePassRewardUIComponent2.IsLock = value2.IsLocked;
						battlePassRewardUIComponent2.CanClaim = value2.CanClaim;
						battlePassRewardUIComponent2.UpdatePerformance();
						battlePassRewardUIComponent2.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Remove(battlePassRewardUIComponent2.OnItemClick, new UnityAction<ItemUIComponentBase>(OnItemClick));
						battlePassRewardUIComponent2.OnItemClick = (UnityAction<ItemUIComponentBase>)Delegate.Combine(battlePassRewardUIComponent2.OnItemClick, new UnityAction<ItemUIComponentBase>(OnItemClick));
					}
				}
				premiumRewardItemCells[k].gameObject.SetActive(flag2);
			}
		}
		else
		{
			Debug.LogError($"通行证等级->{_rewardLevel}的付费奖励等级不在所有付费奖励字典中？？？");
		}
		RefreshCanReceive();
		RefreshGamePadPromptStatus();
	}

	public void SetGamePadSelected(bool selected, bool isPremiumRewardSelected)
	{
		_isGamePadSelected = selected;
		_selectPremiumRewardPrompt?.SetVisible(IsStageReward && !isPremiumRewardSelected);
		RefreshSelectGetRewardPrompt(selected ? GetCurrentOrDefaultRewardCell() : null);
	}

	public void SelectDefaultRewardCell()
	{
		SelectRewardCell(GetCurrentOrDefaultRewardCell());
	}

	public ACT.ViewControl.SelectableEx GetDefaultRewardSelectableEx()
	{
		return GetCurrentOrDefaultRewardCell()?.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
	}

	public void FocusGamePadLayer()
	{
		GetGamePadLayer()?.Focus();
	}

	public void UnFocusGamePadLayer()
	{
		GetGamePadLayer()?.UnFocus();
	}

	public void SelectRewardCellByGamePadPosition(bool isPremiumReward, int index)
	{
		ItemUIComponentBase[] itemCells = (isPremiumReward ? _premiumRewardItemCells : _fressRewardItemCells);
		SelectRewardCell(GetActiveCellAt(itemCells, index));
	}

	public bool TryGetCurrentRewardCellGamePadPosition(out bool isPremiumReward, out int index)
	{
		isPremiumReward = false;
		index = 0;
		ItemUIComponentBase currentRewardCell = GetCurrentRewardCell();
		if (currentRewardCell == null)
		{
			return false;
		}
		int num = Array.IndexOf(_fressRewardItemCells, currentRewardCell);
		if (num >= 0)
		{
			isPremiumReward = false;
			index = num;
			return true;
		}
		int num2 = Array.IndexOf(_premiumRewardItemCells, currentRewardCell);
		if (num2 >= 0)
		{
			isPremiumReward = true;
			index = num2;
			return true;
		}
		return false;
	}

	public void NavigateRewardCellVertical(int direction)
	{
		ItemUIComponentBase currentRewardCell = GetCurrentRewardCell();
		if (currentRewardCell == null)
		{
			SelectDefaultRewardCell();
			return;
		}
		int num = Array.IndexOf(_fressRewardItemCells, currentRewardCell);
		if (num >= 0)
		{
			if (direction > 0)
			{
				SelectRewardCell(GetActiveCellAt(_premiumRewardItemCells, num));
			}
			return;
		}
		int num2 = Array.IndexOf(_premiumRewardItemCells, currentRewardCell);
		if (num2 >= 0)
		{
			if (direction > 0)
			{
				SelectRewardCell(GetNextActiveCell(_premiumRewardItemCells, num2));
			}
			else if (direction < 0)
			{
				SelectRewardCell(GetPreviousActiveCell(_premiumRewardItemCells, num2) ?? GetActiveCellAt(_fressRewardItemCells, num2));
			}
		}
	}

	private void RefreshGamePadPromptStatus()
	{
		_selectPremiumRewardPrompt?.SetVisible(IsStageReward && !_isGamePadSelected);
		RefreshSelectGetRewardPrompt(_isGamePadSelected ? GetCurrentOrDefaultRewardCell() : null);
	}

	private void SelectRewardCell(ItemUIComponentBase itemCell)
	{
		if (!(itemCell == null))
		{
			RefreshGamePadLayerDefaultSelect(itemCell);
			if (!EventSystemHelper.Shared.alreadySelecting)
			{
				EventSystemHelper.SetSelectedGameObject(itemCell.gameObject);
			}
			RefreshSelectGetRewardPrompt(itemCell);
		}
	}

	private void RefreshGamePadLayerDefaultSelect(ItemUIComponentBase itemCell)
	{
		ACT.ViewControl.SelectableEx selectableEx = ((itemCell != null) ? itemCell.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true) : null);
		ViewControlLayer gamePadLayer = GetGamePadLayer();
		if (gamePadLayer != null && selectableEx != null)
		{
			gamePadLayer.SetDefaultSelect(selectableEx);
		}
	}

	private ViewControlLayer GetGamePadLayer()
	{
		if (!(_viewControlLayer != null))
		{
			return GetComponent<ViewControlLayer>();
		}
		return _viewControlLayer;
	}

	private ItemUIComponentBase GetCurrentRewardCell()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected == null)
		{
			return null;
		}
		ItemUIComponentBase itemUIComponentBase = currentSelected.GetComponent<ItemUIComponentBase>() ?? currentSelected.GetComponentInParent<ItemUIComponentBase>();
		if (itemUIComponentBase == null)
		{
			return null;
		}
		if (Array.IndexOf(_fressRewardItemCells, itemUIComponentBase) >= 0 || Array.IndexOf(_premiumRewardItemCells, itemUIComponentBase) >= 0)
		{
			return itemUIComponentBase;
		}
		return null;
	}

	private ItemUIComponentBase GetCurrentOrDefaultRewardCell()
	{
		ItemUIComponentBase currentRewardCell = GetCurrentRewardCell();
		if (currentRewardCell != null)
		{
			return currentRewardCell;
		}
		return GetFirstActiveCell(_fressRewardItemCells) ?? GetFirstActiveCell(_premiumRewardItemCells);
	}

	private static ItemUIComponentBase GetFirstActiveCell(ItemUIComponentBase[] itemCells)
	{
		if (itemCells == null)
		{
			return null;
		}
		foreach (ItemUIComponentBase itemUIComponentBase in itemCells)
		{
			if (itemUIComponentBase != null && itemUIComponentBase.gameObject.activeInHierarchy)
			{
				return itemUIComponentBase;
			}
		}
		return null;
	}

	private static ItemUIComponentBase GetActiveCellAt(ItemUIComponentBase[] itemCells, int index)
	{
		if (itemCells == null || itemCells.Length == 0)
		{
			return null;
		}
		for (int num = Mathf.Clamp(index, 0, itemCells.Length - 1); num >= 0; num--)
		{
			if (itemCells[num] != null && itemCells[num].gameObject.activeInHierarchy)
			{
				return itemCells[num];
			}
		}
		return GetFirstActiveCell(itemCells);
	}

	private static ItemUIComponentBase GetNextActiveCell(ItemUIComponentBase[] itemCells, int index)
	{
		if (itemCells == null)
		{
			return null;
		}
		for (int i = index + 1; i < itemCells.Length; i++)
		{
			if (itemCells[i] != null && itemCells[i].gameObject.activeInHierarchy)
			{
				return itemCells[i];
			}
		}
		return null;
	}

	private static ItemUIComponentBase GetPreviousActiveCell(ItemUIComponentBase[] itemCells, int index)
	{
		if (itemCells == null)
		{
			return null;
		}
		for (int num = index - 1; num >= 0; num--)
		{
			if (itemCells[num] != null && itemCells[num].gameObject.activeInHierarchy)
			{
				return itemCells[num];
			}
		}
		return null;
	}

	private void RefreshCanReceive()
	{
		if (!(_canReceive == null))
		{
			BattlePassReward freeReward = _battlePassModel.GetFreeReward(_rewardLevel);
			BattlePassReward premiumReward = _battlePassModel.GetPremiumReward(_rewardLevel);
			bool active = (freeReward != null && freeReward.CanClaim) || (premiumReward?.CanClaim ?? false);
			_canReceive.SetActive(active);
		}
	}

	private void RefreshSelectGetRewardPrompt(ItemUIComponentBase itemCell)
	{
		if (!(_selectGetRewardPrompt == null))
		{
			if (!(itemCell is BattlePassRewardUIComponent battlePassRewardUIComponent))
			{
				_selectGetRewardPrompt.SetVisible(vis: false);
				return;
			}
			_selectGetRewardPrompt.SetLocalizeString(battlePassRewardUIComponent.CanClaim ? 13 : 774);
			_selectGetRewardPrompt.SetVisible(vis: true);
		}
	}
}
