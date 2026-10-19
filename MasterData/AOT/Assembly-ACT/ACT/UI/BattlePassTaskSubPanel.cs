using ACT.Battle;
using ACT.Model;
using ACT.UI.InputController;
using ACT.UI.Interface;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Runtime.UI.CommonComponent.CommonTimer;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace ACT.UI;

public class BattlePassTaskSubPanel : BaseTabContent<BattlePassTaskSubController>
{
	[SerializeField]
	private ActToggleGroup _actToggleGroup;

	[SerializeField]
	private LoopVerticalScrollRect _taskScrollRect;

	[SerializeField]
	private float _rewardShowDelayTime = 0.05f;

	[SerializeField]
	private ActButton _claimAllTaskExpBtn;

	[SerializeField]
	private CommonTimerComponent _weeklyTaskTime;

	[SerializeField]
	private CommonTimerComponent _roundTaskTime;

	[SerializeField]
	private RedDotItem _dailyTaskRedDot;

	[SerializeField]
	private RedDotItem _roundTaskRedDot;

	[SerializeField]
	private TextMeshProUGUI _dailyTaskText;

	[SerializeField]
	private TextMeshProUGUI _roundTaskText;

	[SerializeField]
	private Color _normalColor;

	[SerializeField]
	private Color _selectColor;

	[SerializeField]
	private GameObject _dailyTaskNormal;

	[SerializeField]
	private GameObject _dailyTaskSelected;

	[SerializeField]
	private GameObject _dailyTaskSelectedGamePadHandle;

	[SerializeField]
	private GameObject _roundTaskNormal;

	[SerializeField]
	private GameObject _roundTaskSelected;

	[SerializeField]
	private GameObject _roundTaskSelectedGamePadHandle;

	[SerializeField]
	[Header("Toggle选择输入Layer")]
	private ViewControlLayer _toggleViewControlLayer;

	[SerializeField]
	[Header("任务列表输入Layer")]
	private ViewControlLayer _taskListViewControlLayer;

	private int _toggleIndex;

	private int _gamePadToggleIndex;

	private bool _isGamePadInTaskList;

	public bool IsGamePadInTaskList => _isGamePadInTaskList;

	public void NavigateToggleByGamePad(int direction)
	{
		int num = Mathf.Clamp(_gamePadToggleIndex + direction, 0, _actToggleGroup.ToggleCount - 1);
		if (num != _gamePadToggleIndex)
		{
			_gamePadToggleIndex = num;
			_actToggleGroup.Init(_gamePadToggleIndex);
			RefreshGamePadToggleHandles();
		}
	}

	public void ConfirmToggleByGamePad()
	{
		if (_toggleIndex != _gamePadToggleIndex)
		{
			_actToggleGroup.Init(_gamePadToggleIndex);
		}
		_isGamePadInTaskList = true;
		RefreshGamePadToggleHandles();
		FocusTaskListLayer();
	}

	public void ExitTaskListByGamePad()
	{
		_isGamePadInTaskList = false;
		RefreshGamePadToggleHandles();
		FocusToggleLayer();
	}

	public void ReFocusGamePadState(bool enterTaskList)
	{
		_gamePadToggleIndex = _toggleIndex;
		_isGamePadInTaskList = enterTaskList;
		RefreshGamePadToggleHandles();
		if (enterTaskList)
		{
			FocusTaskListLayer();
		}
		else
		{
			FocusToggleLayer();
		}
	}

	public void UnFocusAllLayers()
	{
		_toggleViewControlLayer?.UnFocus();
		_taskListViewControlLayer?.UnFocus();
		RefreshGamePadToggleHandles();
	}

	public void ConfirmSelectedTaskCellByGamePad()
	{
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (!(currentSelected == null))
		{
			currentSelected.GetComponentInParent<BattlePassTaskCell>()?.ConfirmByGamePad();
		}
	}

	private void FocusToggleLayer()
	{
		_taskListViewControlLayer?.UnFocus();
		_toggleViewControlLayer?.Focus();
	}

	private void FocusTaskListLayer()
	{
		_toggleViewControlLayer?.UnFocus();
		if (!(_taskListViewControlLayer == null))
		{
			ACT.ViewControl.SelectableEx componentInChildren = _taskListViewControlLayer.GetComponentInChildren<ACT.ViewControl.SelectableEx>(includeInactive: true);
			if (componentInChildren != null)
			{
				_taskListViewControlLayer.SetDefaultSelect(componentInChildren);
			}
			_taskListViewControlLayer.Focus();
		}
	}

	private void RefreshGamePadToggleHandles()
	{
		bool flag = !_isGamePadInTaskList && MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		_dailyTaskSelectedGamePadHandle?.SetActive(flag && _gamePadToggleIndex == 0);
		_roundTaskSelectedGamePadHandle?.SetActive(flag && _gamePadToggleIndex == 1);
	}

	private void OnTaskShow(ILoopScrollDataSource iLoopDataSource)
	{
		if (iLoopDataSource is BattlePassTaskCell battlePassTaskCell)
		{
			battlePassTaskCell.OnInit(iLoopDataSource.GetIndex(), (_toggleIndex != 0) ? BattlePassTaskType.Round : BattlePassTaskType.Daily);
		}
	}

	private void OnToggleOn(int toggleIndex)
	{
		_toggleIndex = toggleIndex;
		OnInitTaskScroll();
		if (toggleIndex == 0)
		{
			_dailyTaskText.color = _selectColor;
			_roundTaskText.color = _normalColor;
			_dailyTaskNormal.SetActive(value: false);
			_dailyTaskSelected.SetActive(value: true);
			_roundTaskNormal.SetActive(value: true);
			_roundTaskSelected.SetActive(value: false);
		}
		else
		{
			_dailyTaskText.color = _normalColor;
			_roundTaskText.color = _selectColor;
			_dailyTaskNormal.SetActive(value: true);
			_dailyTaskSelected.SetActive(value: false);
			_roundTaskNormal.SetActive(value: false);
			_roundTaskSelected.SetActive(value: true);
		}
	}

	private void OnInitTaskScroll()
	{
		if (gameObject.activeInHierarchy)
		{
			if (_toggleIndex == 0)
			{
				_taskScrollRect.ClearCells();
				_taskScrollRect.totalCount = Model<BattlePassModel>.Interface.DailyTaskCount;
				_taskScrollRect.ScrollToCell(0, 0f);
			}
			else
			{
				_taskScrollRect.ClearCells();
				_taskScrollRect.totalCount = Model<BattlePassModel>.Interface.RoundTaskCount;
				_taskScrollRect.ScrollToCell(0, 0f);
			}
			PlayRewardAnimation().Forget();
		}
	}

	private async UniTask PlayRewardAnimation()
	{
		MonoECS.instance.PushPauseAllInput();
		for (int i = 0; i < _taskScrollRect.Children.Count; i++)
		{
			_taskScrollRect.Children[i].GetComponent<BattlePassTaskCell>().GotoShow();
		}
		for (int j = 0; j < _taskScrollRect.Children.Count; j++)
		{
			_taskScrollRect.Children[j].GetComponent<BattlePassTaskCell>().PlayAnimation();
			await UniTask.Delay((int)_rewardShowDelayTime * 1000);
		}
		MonoECS.instance.PopPauseAllInput();
	}

	protected override void OnTabActive(ITabItem tabItem)
	{
		base.OnTabActive(tabItem);
		OnRefresh();
		FocusIn();
	}

	private void OnRefresh()
	{
		Model<BattlePassModel>.Interface.PlayTimeShowAnimation();
		_weeklyTaskTime.IsCountDown = true;
		_weeklyTaskTime.Time = Model<BattlePassModel>.Interface.WeeklyRemainedTime();
		_roundTaskTime.IsCountDown = true;
		_roundTaskTime.Time = Model<BattlePassModel>.Interface.RoundRemainingTime();
		Model<BattlePassModel>.Interface.RefreshAllTaskStatus();
		_taskScrollRect.OnItemShow.RemoveAllListeners();
		_taskScrollRect.OnItemShow.AddListener(OnTaskShow);
		for (int i = 0; i < _actToggleGroup.ToggleCount; i++)
		{
			int index = i;
			ActToggle toggleByIndex = _actToggleGroup.GetToggleByIndex(i);
			toggleByIndex.onToggleOn.RemoveAllListeners();
			toggleByIndex.onToggleOn.AddListener(() =>
			{
				OnToggleOn(index);
			});
		}
		_actToggleGroup.Init(_toggleIndex);
		_dailyTaskRedDot?.InitRedDot(RedDotPathDefine.BattlePassDailyTask);
		_roundTaskRedDot?.InitRedDot(RedDotPathDefine.BattlePassRoundTask);
		RefreshClaimAllBtn();
		Model<BattlePassModel>.Interface.RefreshControlLayer(Tab);
	}

	protected override void OnTabDeActive(ITabItem tabItem)
	{
		gameObject.SetActive(value: false);
		FocusOut();
	}

	public override void OnPopStack()
	{
		gameObject.SetActive(value: true);
		base.OnPopStack();
		OnRefresh();
		ReFocusGamePadState(enterTaskList: false);
	}

	public override void OnPushStack()
	{
		gameObject.SetActive(value: false);
		UnFocusAllLayers();
	}

	private void Awake()
	{
		_claimAllTaskExpBtn.OnClick.AddListener(ClaimAllTaskExpEvt);
		Model<BattlePassModel>.Interface.TaskListUpdateAction += OnTaskListUpdateAction;
	}

	private void OnTaskListUpdateAction()
	{
		OnInitTaskScroll();
		RefreshClaimAllBtn();
	}

	private void RefreshClaimAllBtn()
	{
		bool active = Model<BattlePassModel>.Interface.HasClaimableDailyTask() || Model<BattlePassModel>.Interface.HasClaimableRoundTask();
		_claimAllTaskExpBtn.gameObject.SetActive(active);
	}

	private void ClaimAllTaskExpEvt()
	{
		Model<BattlePassModel>.Interface.ClaimTasks(0, 0, null);
	}

	protected override void OnUnityDestroy()
	{
		_claimAllTaskExpBtn.OnClick.RemoveAllListeners();
		Model<BattlePassModel>.Interface.TaskListUpdateAction -= OnTaskListUpdateAction;
	}
}
