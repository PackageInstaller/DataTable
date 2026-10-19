using System.Collections.Generic;
using System.Threading;
using ACT.Battle;
using ACT.Model;
using ACT.Sound;
using ACT.UI.Interface;
using Bamboo.Chronos;
using Cysharp.Threading.Tasks;
using Fundamental;
using Runtime.UI.CommonComponent.CommonTimer;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class BattlePassView : BaseUIView<BattlePassViewInputController>
{
	[SerializeField]
	[Header("奖励子界面")]
	private BattlePassRewardSubPanel _rewardSubPanel;

	[SerializeField]
	[Header("任务子界面")]
	private BattlePassTaskSubPanel _taskSubPanel;

	[SerializeField]
	[Header("页签视图组件")]
	private CommonTabListComponent _tabListComponent;

	[SerializeField]
	[Header("奖励页签")]
	private ITabItem _rewardTab;

	[SerializeField]
	[Header("任务页签")]
	private ITabItem _taskTab;

	[SerializeField]
	[Header("返回按钮")]
	private ActButton _returnBtn;

	[SerializeField]
	[Header("说明按钮")]
	private ActButton _explanBtn;

	[SerializeField]
	[Header("购买等级按钮")]
	private ActButton _buyLevelBtn;

	[SerializeField]
	[Header("购买高级通行证按钮")]
	private ActButton _buyPremiumBtn;

	[SerializeField]
	private CommonTimerComponent _commonTimerComponent;

	[SerializeField]
	private GameObject _levelMaxObj;

	[SerializeField]
	[Header("每级经验组件")]
	private CommonNumberComponent _levelExpNumberComponent;

	[SerializeField]
	[Header("每周经验组件")]
	private CommonNumberComponent _weekExpNumberComponent;

	[SerializeField]
	[Header("更新后等级")]
	private TextMeshProUGUI _curLevelText;

	[SerializeField]
	[Header("更新前等级")]
	private TextMeshProUGUI _lastLevelText;

	[SerializeField]
	[Header("经验条")]
	private Image _expFill;

	[SerializeField]
	[Header("经验条Handle")]
	private RectTransform _expHandle;

	[SerializeField]
	[Header("levelUp的动画")]
	private BetterAnimation _levelUpAnim;

	[SerializeField]
	private AudioEventReference _firstShowAudioEvent;

	[SerializeField]
	private AudioEventReference _showAudioEvent;

	[SerializeField]
	private BetterAnimation _timeAnimation;

	[SerializeField]
	[Header("手柄提示组件")]
	private GamePadTipsComp _gamePadTipsComp;

	private readonly List<GamePadTipsAction> _gamePadTipsActions = new List<GamePadTipsAction>();

	private BattlePassViewSubControllerType _curSubControllerType;

	private const string FirstShow = "FirstShow";

	private const string Show = "Show";

	private const string Hide = "Hide";

	private const string LevelUp = "LevelUp";

	private const string TimeShow = "Timeshow";

	private const int HandleOffset = 2;

	private Delayer _openAnimInputDelayer;

	private bool _openAnimInputPaused;

	public BattlePassViewSubControllerType CurSubControllerType => _curSubControllerType;

	protected override UniTask PlayPopStackAsync(CancellationToken token)
	{
		switch (_tabListComponent.ActiveTab.TabIdentify)
		{
		case 0:
			_rewardSubPanel.OnPopStack();
			break;
		case 1:
			_taskSubPanel.OnPopStack();
			break;
		}
		return base.PlayPopStackAsync(token);
	}

	protected override UniTask PlayPushStackAsync(CancellationToken token)
	{
		switch (_tabListComponent.ActiveTab.TabIdentify)
		{
		case 0:
			_rewardSubPanel.OnPushStack();
			break;
		case 1:
			_taskSubPanel.OnPushStack();
			break;
		}
		return base.PlayPushStackAsync(token);
	}

	private void Awake()
	{
		_returnBtn.OnClick.AddListener(Close);
		_explanBtn.OnClick.AddListener(() =>
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ACTIVITYDESC, new ActivityDescViewData
			{
				titleTextId = 2400,
				titleStringType = "Common",
				descTextId = 2427,
				localizedStringType = "Common",
				iconId = 1044
			});
		});
		_buyLevelBtn.OnClick.AddListener(() =>
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_POPUPBATTLEPASSBUYLEVEL);
		});
		_buyPremiumBtn.OnClick.AddListener(() =>
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_BATTLEPASSBUYPREMIUM);
		});
	}

	private void InterfaceOnPlayTimeShow()
	{
		if (_timeAnimation != null)
		{
			_timeAnimation.GetSequence("Timeshow").Play();
		}
	}

	private void OnBattlePassTabActive(ITabItem tabItem)
	{
		SyncBattlePassSubControllerType(tabItem);
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (type == DeviceInputMode.Gamepad)
		{
			RefreshGamePadTipsStatus(_curSubControllerType);
			ReFocusGamePadSubController(_curSubControllerType);
		}
		else
		{
			RefreshGamePadTipsActive(active: false);
		}
	}

	private void SyncBattlePassSubControllerType(ITabItem tabItem)
	{
		if (tabItem != null)
		{
			ITabContent content = tabItem.Content;
			BattlePassViewSubControllerType battlePassViewSubControllerType = ((content is BattlePassTaskSubPanel) ? BattlePassViewSubControllerType.TaskToggle : ((!(content is BattlePassRewardSubPanel)) ? BattlePassViewSubControllerType.Reward : BattlePassViewSubControllerType.Reward));
			BattlePassViewSubControllerType type = battlePassViewSubControllerType;
			ChangeBattlePassSubControllerType(type);
		}
	}

	private void OnWeekCumulativeExpChangeAction(int curWeekExp)
	{
		UpdateWeekExp(curWeekExp);
	}

	private void OnLevelExpChangeAction(int curLevelExp)
	{
		UpdateLevelExp(curLevelExp);
	}

	private void UpdateWeekExp(int curWeekExp)
	{
		int weekExpLimitation = Model<BattlePassModel>.Interface.WeekExpLimitation;
		_weekExpNumberComponent.UpdateNumber(curWeekExp, weekExpLimitation);
	}

	private void UpdateLevelExp(int curLevelExp)
	{
		int levelUpExp = Model<BattlePassModel>.Interface.LevelUpExp;
		int num = (Model<BattlePassModel>.Interface.IsMaxLevel ? levelUpExp : curLevelExp);
		_levelExpNumberComponent.UpdateNumber(num, levelUpExp);
		float fillAmount = (float)num / (float)levelUpExp;
		_expFill.fillAmount = fillAmount;
		UpdateExpHandlePosition(fillAmount);
	}

	private void UpdateExpHandlePosition(float fillAmount)
	{
		RectTransform rectTransform = _expFill.rectTransform;
		LayoutRebuilder.ForceRebuildLayoutImmediate(rectTransform);
		float x = rectTransform.rect.width * fillAmount + 2f;
		_expHandle.anchoredPosition = new Vector2(x, _expHandle.anchoredPosition.y);
	}

	private void OnLevelUpdateAction(int before, int after)
	{
		_lastLevelText.SetText("{0:0}", before);
		UpdateBuyBtnAndIsMaxObj(after);
		UpdateLevelExp(Model<BattlePassModel>.Interface.CurLevelExp);
		_levelUpAnim.GetSequence("LevelUp").Play();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/BP/Update");
	}

	private void UpdateBuyBtnAndIsMaxObj(int level)
	{
		bool flag = level == Model<BattlePassModel>.Interface.BattlePassLevelMax;
		_levelMaxObj.SetActive(flag);
		_buyLevelBtn.gameObject.SetActive(!flag);
		_curLevelText.SetText("{0:0}", level);
	}

	private void OnDestroy()
	{
		ReleaseOpenAnimationInputPause();
		_returnBtn.OnClick.RemoveAllListeners();
		_explanBtn.OnClick.RemoveAllListeners();
		_buyLevelBtn.OnClick.RemoveAllListeners();
		_buyPremiumBtn.OnClick.RemoveAllListeners();
		RemoveModelListeners();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		AddModelListeners();
	}

	protected override void Init()
	{
		base.Init();
		UpdateBuyBtnAndIsMaxObj(Model<BattlePassModel>.Interface.CurrentLevel);
		UpdateLevelExp(Model<BattlePassModel>.Interface.CurLevelExp);
		UpdateWeekExp(Model<BattlePassModel>.Interface.CurtWeekCumulativeExp);
		_commonTimerComponent.IsCountDown = true;
		_commonTimerComponent.Time = Model<BattlePassModel>.Interface.RoundRemainingTime();
		_tabListComponent.TabItems.Clear();
		_rewardTab.TabIdentify = 0;
		_rewardTab.Content = _rewardSubPanel;
		((_rewardTab as BattlePassTab)?.RedDotItem)?.InitRedDot(RedDotPathDefine.BattlePassRewardTab);
		_tabListComponent.TabItems.Add(_rewardTab);
		_taskTab.TabIdentify = 1;
		_taskTab.Content = _taskSubPanel;
		((_taskTab as BattlePassTab)?.RedDotItem)?.InitRedDot(RedDotPathDefine.BattlePassTaskTab);
		_tabListComponent.TabItems.Add(_taskTab);
		Singleton<RedDotManager>.instance.RefreshUnLockSystemRedDot(1044);
	}

	protected override void ReInit()
	{
		base.ReInit();
		Init();
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		PushOpenAnimInputPause();
		int animatorClipLengthMs;
		if (Model<BattlePassModel>.Interface.NewRedDotExist)
		{
			animatorClipLengthMs = GetAnimatorClipLengthMs("FirstShow");
			betterAnimation.GetSequence("FirstShow").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
		else
		{
			animatorClipLengthMs = GetAnimatorClipLengthMs("Show");
			betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
			{
				OpenEffectFinishNew();
			}).Play();
		}
		ScheduleOpenAnimInputResume(animatorClipLengthMs);
	}

	private void PlayFirstShowSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound(_firstShowAudioEvent, new AudioPlayOptions
		{
			attachTarget = transform
		});
	}

	private void PlayShowSound()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound(_showAudioEvent, new AudioPlayOptions
		{
			attachTarget = transform
		});
	}

	private int GetAnimatorClipLengthMs(string animationName)
	{
		if (betterAnimation == null)
		{
			return 0;
		}
		AnimationBuilder sequence = betterAnimation.GetSequence(animationName);
		if (sequence != null)
		{
			return (int)(sequence.Duration() * 1000f);
		}
		return 0;
	}

	private void PushOpenAnimInputPause()
	{
		if (!_openAnimInputPaused)
		{
			MonoECS.instance.PushPauseAllInput();
			_openAnimInputPaused = true;
		}
	}

	private void PopOpenAnimInputPause()
	{
		if (_openAnimInputPaused)
		{
			MonoECS.instance.PopPauseAllInput();
			_openAnimInputPaused = false;
		}
	}

	private void ScheduleOpenAnimInputResume(int delayMs)
	{
		if (_openAnimInputDelayer.IsValid())
		{
			_openAnimInputDelayer.Cancel();
		}
		if (delayMs <= 0)
		{
			PopOpenAnimInputPause();
		}
		else
		{
			_openAnimInputDelayer = UpdateTimer.Default.DelayMs(delayMs, PopOpenAnimInputPause);
		}
	}

	public void PlayTabAnimationEvent()
	{
		_tabListComponent.ActiveTab = _tabListComponent.TabItems[Mathf.Clamp(0, 0, _tabListComponent.TabItems.Count - 1)];
	}

	public void SwitchBattlePassTab(int offset)
	{
		if (_tabListComponent?.ActiveTab == null || _tabListComponent.TabItems.Count == 0)
		{
			return;
		}
		int num = _tabListComponent.TabItems.IndexOf(_tabListComponent.ActiveTab);
		if (num >= 0)
		{
			int num2 = Mathf.Clamp(num + offset, 0, _tabListComponent.TabItems.Count - 1);
			if (num2 != num)
			{
				_tabListComponent.ActiveTab = _tabListComponent.TabItems[num2];
			}
		}
	}

	public void ChangeBattlePassSubControllerType(BattlePassViewSubControllerType type)
	{
		BattlePassViewSubControllerType curSubControllerType = _curSubControllerType;
		_curSubControllerType = type;
		_rewardSubPanel?.ChangeGamePadSubControllerType(type);
		RefreshTaskControlLayer(curSubControllerType, type);
		RefreshGamePadTipsStatus(type);
	}

	public void HandleBack()
	{
		if (_curSubControllerType == BattlePassViewSubControllerType.PremiumReward)
		{
			ChangeBattlePassSubControllerType(BattlePassViewSubControllerType.Reward);
		}
		else if (_curSubControllerType == BattlePassViewSubControllerType.Task)
		{
			ChangeBattlePassSubControllerType(BattlePassViewSubControllerType.TaskToggle);
		}
		else
		{
			Close();
		}
	}

	public bool GetStageRewardActive()
	{
		return _rewardSubPanel.GetStageRewardActive();
	}

	private void ReFocusGamePadSubController(BattlePassViewSubControllerType type)
	{
		switch (type)
		{
		case BattlePassViewSubControllerType.Reward:
		case BattlePassViewSubControllerType.PremiumReward:
			_rewardSubPanel?.ReFocusGamePadSelection();
			break;
		case BattlePassViewSubControllerType.Task:
		case BattlePassViewSubControllerType.TaskToggle:
			_taskSubPanel?.ReFocusGamePadState(type == BattlePassViewSubControllerType.Task);
			break;
		}
	}

	private void RefreshTaskControlLayer(BattlePassViewSubControllerType lastType, BattlePassViewSubControllerType curType)
	{
		bool num = lastType == BattlePassViewSubControllerType.Task || lastType == BattlePassViewSubControllerType.TaskToggle;
		bool flag = curType == BattlePassViewSubControllerType.Task || curType == BattlePassViewSubControllerType.TaskToggle;
		if (num && !flag)
		{
			_taskSubPanel?.UnFocusAllLayers();
			return;
		}
		switch (curType)
		{
		case BattlePassViewSubControllerType.TaskToggle:
			_taskSubPanel?.ReFocusGamePadState(enterTaskList: false);
			break;
		case BattlePassViewSubControllerType.Task:
			_taskSubPanel?.ReFocusGamePadState(enterTaskList: true);
			break;
		}
	}

	private void RefreshGamePadTipsStatus(BattlePassViewSubControllerType type)
	{
		if (!(_gamePadTipsComp == null))
		{
			_gamePadTipsComp.ClearAllPrompts();
			_gamePadTipsActions.Clear();
			if (type == BattlePassViewSubControllerType.TaskToggle)
			{
				_gamePadTipsActions.Add(new GamePadTipsAction
				{
					inputAction = "UI/Confirm",
					localizeKey = 13,
					localizeTable = "Common"
				});
			}
			_gamePadTipsActions.Add(new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			});
			_gamePadTipsComp.RegisterInputActions(_gamePadTipsActions);
			RefreshGamePadTipsActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		}
	}

	private void RefreshGamePadTipsActive(bool active)
	{
		_gamePadTipsComp?.gameObject.SetActive(active);
	}

	public void SelectRewardRootByGamePad(int offset)
	{
		_rewardSubPanel?.SelectRewardRootByGamePad(offset);
	}

	public void NavigateSelectedRewardCellByGamePad(int direction)
	{
		_rewardSubPanel?.NavigateSelectedRewardCellByGamePad(direction);
	}

	public void JumpToShopByGamePad()
	{
		_rewardSubPanel?.JumpToShopEvent();
	}

	public void NavigateTaskToggleByGamePad(int direction)
	{
		_taskSubPanel?.NavigateToggleByGamePad(direction);
	}

	public void ConfirmTaskToggleByGamePad()
	{
		_taskSubPanel?.ConfirmToggleByGamePad();
		ChangeBattlePassSubControllerType(BattlePassViewSubControllerType.Task);
	}

	public void ConfirmTaskCellByGamePad()
	{
		_taskSubPanel?.ConfirmSelectedTaskCellByGamePad();
	}

	public void MarkBattlePassOpenedEvent()
	{
		Model<BattlePassModel>.Interface.RefreshNewRedDot();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		ReleaseOpenAnimationInputPause();
		RemoveModelListeners();
		base.UnInit();
	}

	private void AddModelListeners()
	{
		Model<BattlePassModel>.Interface.LevelUpdateAction += OnLevelUpdateAction;
		Model<BattlePassModel>.Interface.LevelExpChangeAction += OnLevelExpChangeAction;
		Model<BattlePassModel>.Interface.WeekCumulativeExpChangeAction += OnWeekCumulativeExpChangeAction;
		Model<BattlePassModel>.Interface.RefreshControlLayerAction += OnBattlePassTabActive;
		Model<BattlePassModel>.Interface.PlayTimeShow += InterfaceOnPlayTimeShow;
	}

	private void RemoveModelListeners()
	{
		Model<BattlePassModel>.Interface.LevelUpdateAction -= OnLevelUpdateAction;
		Model<BattlePassModel>.Interface.LevelExpChangeAction -= OnLevelExpChangeAction;
		Model<BattlePassModel>.Interface.WeekCumulativeExpChangeAction -= OnWeekCumulativeExpChangeAction;
		Model<BattlePassModel>.Interface.RefreshControlLayerAction -= OnBattlePassTabActive;
		Model<BattlePassModel>.Interface.PlayTimeShow -= InterfaceOnPlayTimeShow;
	}

	private void ReleaseOpenAnimationInputPause()
	{
		if (_openAnimInputDelayer.IsValid())
		{
			_openAnimInputDelayer.Cancel();
		}
		PopOpenAnimInputPause();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		switch (_tabListComponent.ActiveTab.TabIdentify)
		{
		case 0:
			_rewardSubPanel.OnPushStack();
			break;
		case 1:
			_taskSubPanel.OnPushStack();
			break;
		}
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
			CloseEffectFinishNew();
		}).Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public override void Close()
	{
		base.Close();
	}
}
