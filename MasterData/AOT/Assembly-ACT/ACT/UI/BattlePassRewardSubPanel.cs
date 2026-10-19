using System;
using System.Linq;
using ACT.Battle;
using ACT.Core;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.UI.Interface;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class BattlePassRewardSubPanel : BaseTabContent<BattlePassRewardSubController>
{
	[SerializeField]
	private LoopHorizontalScrollRect _rewardScrollRect;

	[SerializeField]
	[Header("每阶段丰厚奖励")]
	private BattlePassRewardItem _stageRewardItem;

	private BattlePassModel _battlePassModel;

	[SerializeField]
	private float _rewardShowDelayTime = 0.01f;

	[SerializeField]
	private ActButton _getAllRewardsBtn;

	[SerializeField]
	private ActButton _BattlePassShop;

	[SerializeField]
	[Header("高级通行证锁定")]
	private CanvasGroup _premiumLock;

	private BattlePassRewardItem _currentGamePadRewardItem;

	private BattlePassViewSubControllerType _gamePadSubControllerType;

	private bool _lastSelectedPremiumReward;

	private int _lastSelectedRewardCellIndex;

	private void Awake()
	{
		Model<BattlePassModel>.Interface.LevelUpdateAction += OnLevelUpdateAction;
		Model<BattlePassModel>.Interface.GetRewardsAction += GetRewardsAction;
		Model<BattlePassModel>.Interface.PayLevelChangeAction += OnPayLevelChangeAction;
		_getAllRewardsBtn.OnClick.AddListener(() =>
		{
			Model<BattlePassModel>.Interface.ClaimRewards(0, isPremium: true);
		});
		_BattlePassShop.gameObject.SetActive(value: true);
		_BattlePassShop.OnClick.AddListener(JumpToShopEvent);
		_rewardScrollRect.totalCount = Model<BattlePassModel>.Interface.BattlePassLevelMax;
		_rewardScrollRect.OnItemShow.AddListener(OnRewardShow);
		_rewardScrollRect.OnItemCenterReachBound.AddListener(OnItemCenterReachBound);
	}

	public void JumpToShopEvent()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Button_Click");
		RuntimeJumpData runTimeJumpData = ItemJumpHelper.GetRunTimeJumpData(CoreUtils.GetData(_battlePassModel.CurBattlePassId, RuntimeConfigs.data.battlePasss).shopJump);
		JumpResult result = Model<JumpModel>.Interface.CanJump(runTimeJumpData);
		JumpResult.JumpShowType showType = result.ShowType;
		if (showType == JumpResult.JumpShowType.Forbidden || showType == JumpResult.JumpShowType.Hide)
		{
			GameUtility.OpenJumpResultTips(result);
		}
		else
		{
			Model<JumpModel>.Interface.JumpTo(runTimeJumpData);
		}
		result.Release();
	}

	private void OnPayLevelChangeAction()
	{
		OnRefresh(Model<BattlePassModel>.Interface.CurrentLevel);
	}

	private void OnItemCenterReachBound(ILoopScrollDataSource dataSource, LoopScrollRectBase.ReachBoundDirection dir, bool centerInside)
	{
		if (dataSource is BattlePassRewardItem battlePassRewardItem && dir == LoopScrollRectBase.ReachBoundDirection.Right)
		{
			UpdateStageRewardItem(centerInside ? battlePassRewardItem.index : (battlePassRewardItem.index - 1));
		}
	}

	private void OnLevelUpdateAction(int before, int after)
	{
		OnRefresh(after);
	}

	private void GetRewardsAction(bool success, RepeatedField<UniversalItem> rewardItems, bool isPremium)
	{
		if (success)
		{
			_getAllRewardsBtn.gameObject.SetActive(_battlePassModel.HasUnclaimedRewards());
			_rewardScrollRect.RefreshCells();
			UpdateStageRewardByRightBound();
			GameUtility.OpenPopReward(rewardItems);
		}
	}

	protected override void OnUnityDestroy()
	{
		Model<BattlePassModel>.Interface.LevelUpdateAction -= OnLevelUpdateAction;
		Model<BattlePassModel>.Interface.GetRewardsAction -= GetRewardsAction;
		Model<BattlePassModel>.Interface.PayLevelChangeAction -= OnPayLevelChangeAction;
		_getAllRewardsBtn.OnClick.RemoveAllListeners();
		_BattlePassShop.OnClick.RemoveAllListeners();
		_rewardScrollRect.OnItemShow.RemoveAllListeners();
		_rewardScrollRect.OnItemCenterReachBound.RemoveAllListeners();
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		OnRefresh(Model<BattlePassModel>.Interface.CurrentLevel);
		FocusIn();
	}

	public override void OnPopStack()
	{
		gameObject.SetActive(value: true);
		base.OnPopStack();
		OnRefresh(Model<BattlePassModel>.Interface.CurrentLevel);
	}

	public override void OnPushStack()
	{
		gameObject.SetActive(value: false);
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		gameObject.SetActive(value: false);
		FocusOut();
	}

	private async void OnRefresh(int curLevel)
	{
		_battlePassModel = Model<BattlePassModel>.Interface;
		_battlePassModel.PlayTimeShowAnimation();
		_premiumLock.alpha = ((_battlePassModel.BattlePassPayLevel == BattlePassPayLevel.BattlePassPayNull) ? 1f : 0f);
		_getAllRewardsBtn.gameObject.SetActive(_battlePassModel.HasUnclaimedRewards());
		if (_currentGamePadRewardItem != null)
		{
			_currentGamePadRewardItem.SetGamePadSelected(selected: false, isPremiumRewardSelected: false);
			_currentGamePadRewardItem = null;
		}
		_lastSelectedPremiumReward = false;
		_rewardScrollRect.ScrollToCellWithinTime((curLevel > 5) ? (curLevel - 6) : 0, 0f);
		UpdateStageRewardByRightBound();
		await PlayRewardAnimation();
		_battlePassModel.RefreshControlLayer(Tab);
	}

	public void ChangeGamePadSubControllerType(BattlePassViewSubControllerType type)
	{
		UnFocusCurrentRewardItemLayer();
		_gamePadSubControllerType = type;
		RefreshGamePadSelection();
	}

	public bool GetStageRewardActive()
	{
		return _stageRewardItem.gameObject.activeInHierarchy;
	}

	public void ReFocusGamePadSelection()
	{
		BattlePassViewSubControllerType gamePadSubControllerType = _gamePadSubControllerType;
		if (gamePadSubControllerType == BattlePassViewSubControllerType.Reward || gamePadSubControllerType == BattlePassViewSubControllerType.PremiumReward)
		{
			RefreshGamePadSelection();
		}
	}

	public void SelectRewardRootByGamePad(int offset)
	{
		if (_gamePadSubControllerType != BattlePassViewSubControllerType.Reward || _rewardScrollRect.totalCount <= 0)
		{
			return;
		}
		int currentGamePadRewardItemIndex = GetCurrentGamePadRewardItemIndex();
		if (currentGamePadRewardItemIndex >= 0)
		{
			CacheCurrentRewardCellPosition();
			int num = Mathf.Clamp(currentGamePadRewardItemIndex + offset, 0, _rewardScrollRect.totalCount - 1);
			if (num != currentGamePadRewardItemIndex)
			{
				SelectGamePadRewardItemByIndex(num);
				UpdateStageRewardByRightBound();
			}
		}
	}

	public void NavigateSelectedRewardCellByGamePad(int direction)
	{
		BattlePassRewardItem battlePassRewardItem = ((_gamePadSubControllerType == BattlePassViewSubControllerType.PremiumReward) ? _stageRewardItem : _currentGamePadRewardItem);
		if (!(battlePassRewardItem == null))
		{
			battlePassRewardItem.NavigateRewardCellVertical(direction);
			CacheCurrentRewardCellPosition();
		}
	}

	private void RefreshGamePadSelection()
	{
		if (_gamePadSubControllerType == BattlePassViewSubControllerType.PremiumReward)
		{
			_currentGamePadRewardItem?.SetGamePadSelected(selected: false, isPremiumRewardSelected: true);
			_currentGamePadRewardItem?.UnFocusGamePadLayer();
			if (_stageRewardItem != null && _stageRewardItem.gameObject.activeInHierarchy)
			{
				_stageRewardItem.SetGamePadSelected(selected: true, isPremiumRewardSelected: true);
				_stageRewardItem.SelectRewardCellByGamePadPosition(_lastSelectedPremiumReward, _lastSelectedRewardCellIndex);
				_stageRewardItem.FocusGamePadLayer();
			}
			return;
		}
		_stageRewardItem?.SetGamePadSelected(selected: false, isPremiumRewardSelected: false);
		_stageRewardItem?.UnFocusGamePadLayer();
		if (_gamePadSubControllerType != BattlePassViewSubControllerType.Reward)
		{
			_currentGamePadRewardItem?.SetGamePadSelected(selected: false, isPremiumRewardSelected: false);
			_currentGamePadRewardItem?.UnFocusGamePadLayer();
			return;
		}
		if (_currentGamePadRewardItem == null || !_currentGamePadRewardItem.gameObject.activeInHierarchy)
		{
			_currentGamePadRewardItem = _rewardScrollRect.Children.Select((RectTransform child) => (!(child != null)) ? null : child.GetComponent<BattlePassRewardItem>()).FirstOrDefault((BattlePassRewardItem item) => item != null && item.gameObject.activeInHierarchy && item.index == ((_battlePassModel.CurrentLevel > 0) ? (_battlePassModel.CurrentLevel - 1) : 0));
		}
		if (_currentGamePadRewardItem != null)
		{
			SelectGamePadRewardItem(_currentGamePadRewardItem);
		}
	}

	private void SelectGamePadRewardItem(BattlePassRewardItem rewardItem)
	{
		if (!(rewardItem == null))
		{
			_currentGamePadRewardItem?.SetGamePadSelected(selected: false, isPremiumRewardSelected: false);
			_currentGamePadRewardItem?.UnFocusGamePadLayer();
			_currentGamePadRewardItem = rewardItem;
			_currentGamePadRewardItem.SetGamePadSelected(selected: true, isPremiumRewardSelected: false);
			_currentGamePadRewardItem.SelectRewardCellByGamePadPosition(_lastSelectedPremiumReward, _lastSelectedRewardCellIndex);
			_currentGamePadRewardItem.FocusGamePadLayer();
		}
	}

	private int GetCurrentGamePadRewardItemIndex()
	{
		if (_currentGamePadRewardItem != null && _currentGamePadRewardItem.gameObject.activeInHierarchy)
		{
			return _currentGamePadRewardItem.index;
		}
		BattlePassRewardItem battlePassRewardItem = _rewardScrollRect.Children.Select((RectTransform child) => (!(child != null)) ? null : child.GetComponent<BattlePassRewardItem>()).FirstOrDefault((BattlePassRewardItem item) => item != null && item.gameObject.activeInHierarchy);
		if (!(battlePassRewardItem != null))
		{
			return -1;
		}
		return battlePassRewardItem.index;
	}

	private void SelectGamePadRewardItemByIndex(int index)
	{
		TrySelectGamePadRewardItemByIndex(index);
	}

	private bool TrySelectGamePadRewardItemByIndex(int index)
	{
		if (!(_rewardScrollRect.GetItem(index) is BattlePassRewardItem battlePassRewardItem) || !battlePassRewardItem.gameObject.activeInHierarchy)
		{
			return false;
		}
		SelectGamePadRewardItem(battlePassRewardItem);
		return true;
	}

	private void UnFocusCurrentRewardItemLayer()
	{
		if (_gamePadSubControllerType == BattlePassViewSubControllerType.PremiumReward)
		{
			_stageRewardItem?.UnFocusGamePadLayer();
		}
		else
		{
			_currentGamePadRewardItem?.UnFocusGamePadLayer();
		}
	}

	public ACT.ViewControl.SelectableEx GetDefaultSelectableEx(BattlePassViewSubControllerType type)
	{
		if (type != BattlePassViewSubControllerType.PremiumReward)
		{
			if (!(_currentGamePadRewardItem != null) || !_currentGamePadRewardItem.gameObject.activeInHierarchy)
			{
				return null;
			}
			return _currentGamePadRewardItem.GetDefaultRewardSelectableEx();
		}
		if (!(_stageRewardItem != null) || !_stageRewardItem.gameObject.activeInHierarchy)
		{
			return null;
		}
		return _stageRewardItem.GetDefaultRewardSelectableEx();
	}

	private void CacheCurrentRewardCellPosition()
	{
		BattlePassRewardItem battlePassRewardItem = ((_gamePadSubControllerType == BattlePassViewSubControllerType.PremiumReward) ? _stageRewardItem : _currentGamePadRewardItem);
		if (!(battlePassRewardItem == null) && battlePassRewardItem.TryGetCurrentRewardCellGamePadPosition(out var isPremiumReward, out var index))
		{
			_lastSelectedPremiumReward = isPremiumReward;
			_lastSelectedRewardCellIndex = index;
		}
	}

	private void UpdateStageRewardByRightBound()
	{
		if (_rewardScrollRect.TryGetRightBoundCenterItem(out var item, out var centerInside) && item is BattlePassRewardItem battlePassRewardItem)
		{
			UpdateStageRewardItem(centerInside ? battlePassRewardItem.index : (battlePassRewardItem.index - 1));
		}
	}

	private void UpdateStageRewardItem(int level)
	{
		int stageLastLevel = _battlePassModel.GetStageLastLevel(level);
		if (level >= stageLastLevel)
		{
			_stageRewardItem.gameObject.SetActive(value: false);
			return;
		}
		_stageRewardItem.gameObject.SetActive(value: true);
		_stageRewardItem.Init(stageLastLevel - 1);
		_stageRewardItem.SetGamePadSelected(_gamePadSubControllerType == BattlePassViewSubControllerType.PremiumReward, _gamePadSubControllerType == BattlePassViewSubControllerType.PremiumReward);
	}

	private void OnRewardShow(ILoopScrollDataSource iLoopDataSource)
	{
		if (iLoopDataSource is BattlePassRewardItem battlePassRewardItem)
		{
			battlePassRewardItem.Init(battlePassRewardItem.index);
		}
	}

	private async UniTask PlayRewardAnimation()
	{
		MonoECS.instance.PushPauseAllInput();
		for (int i = 0; i < _rewardScrollRect.Children.Count; i++)
		{
			_rewardScrollRect.Children[i].GetComponent<BattlePassRewardItem>().GotoShow();
		}
		for (int j = 0; j < _rewardScrollRect.Children.Count; j++)
		{
			_rewardScrollRect.Children[j].GetComponent<BattlePassRewardItem>().PlayAnimation();
			await UniTask.Delay(TimeSpan.FromSeconds(_rewardShowDelayTime));
		}
		MonoECS.instance.PopPauseAllInput();
	}
}
