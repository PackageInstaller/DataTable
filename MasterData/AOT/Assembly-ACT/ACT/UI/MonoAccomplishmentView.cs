using System.Collections.Generic;
using ACT.Battle;
using ACT.Event;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace ACT.UI;

public class MonoAccomplishmentView : BaseUIView<AccomplishmentViewInputController>
{
	private MonoAccomplishmentViewData m_data;

	[SerializeField]
	private LoopHorizontalScrollRect labelScrollRect;

	[SerializeField]
	private TextMeshProUGUI _countText;

	[SerializeField]
	private LoopHorizontalScrollRect _degreeOfRarityScrollRect;

	[SerializeField]
	private LoopVerticalScrollRect _recentAchievementsScrollRect;

	[SerializeField]
	private GameObject _recentAchievementsRoot;

	[SerializeField]
	private GameObject _emptyRoot;

	[SerializeField]
	private ActButton _buttonPickUp;

	public Dictionary<AccomplishmentViewControllerType, ViewControlLayer> ViewControlLayers;

	[Tooltip("prompBoard节点")]
	public GameObject prompBoard;

	[Tooltip("A键")]
	public OperateBtnPrompt operateBtnPromptA;

	[Tooltip("B键")]
	public OperateBtnPrompt operateBtnPromptB;

	public OperateBtnPrompt operateBtnPromptY;

	private const int LocalizeIDA = 774;

	private const int LocalizeIDB = 606;

	private const float SafeAreaScaleMinOffset = 84f;

	private const float SafeAreaScaleMaxOffset = 144f;

	private const float SafeAreaScaleAtMaxOffset = 0.95f;

	private AccomplishmentModel _model;

	private List<int> _recentAchievementIds = new List<int>();

	private int _selectedMainLabelIndex;

	private int _selectedRecentAchievementIndex;

	private bool _gamepadPromptInited;

	private bool _hasPlayedInitialListShowAnimations;

	private AccomplishmentViewControllerType _currentControllerType;

	public int SelectedDetailMainId { get; private set; }

	public int SelectedDetailGroupId { get; private set; }

	protected override void Init()
	{
		base.Init();
		m_data = uiViewData as MonoAccomplishmentViewData;
		_model = Model<AccomplishmentModel>.Interface;
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.UI_AccomplishmentRefresh, OnModelDataChanged);
		MonoECS.instance.onInputModeChange.AddListener(OnInputModeChanged);
		EnsurePickUpPromptReference();
		InitGamepadPromptBindings();
		SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder").AddApplyListener(OnUIBorderOffsetChanged);
		ApplySafeAreaScale();
		if (labelScrollRect != null)
		{
			labelScrollRect.OnItemShow.RemoveListener(OnMainLabelShow);
			labelScrollRect.OnItemShow.AddListener(OnMainLabelShow);
		}
		if (_degreeOfRarityScrollRect != null)
		{
			_degreeOfRarityScrollRect.OnItemShow.RemoveListener(OnRarityShow);
			_degreeOfRarityScrollRect.OnItemShow.AddListener(OnRarityShow);
		}
		if (_recentAchievementsScrollRect != null)
		{
			_recentAchievementsScrollRect.OnItemShow.RemoveListener(OnRecentShow);
			_recentAchievementsScrollRect.OnItemShow.AddListener(OnRecentShow);
		}
		_hasPlayedInitialListShowAnimations = false;
		RefreshMainPage();
		_hasPlayedInitialListShowAnimations = true;
		RefreshGamepadState();
		RefreshPickUpBtnState();
		_buttonPickUp.SetBtnClick(OneKeyPickUp);
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Achive/Open");
	}

	protected override void UnInit()
	{
		base.UnInit();
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.UI_AccomplishmentRefresh, OnModelDataChanged);
		MonoECS.instance.onInputModeChange.RemoveListener(OnInputModeChanged);
		SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder").RemoveApplyListener(OnUIBorderOffsetChanged);
		labelScrollRect?.OnItemShow.RemoveListener(OnMainLabelShow);
		_degreeOfRarityScrollRect?.OnItemShow.RemoveListener(OnRarityShow);
		_recentAchievementsScrollRect?.OnItemShow.RemoveListener(OnRecentShow);
		_recentAchievementIds.Clear();
		ClearGamepadSelection();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		RefreshGamepadState();
	}

	private void OnInputModeChanged(DeviceInputMode mode)
	{
		RefreshGamepadState();
	}

	private void OnModelDataChanged(BaseEventContent obj)
	{
		RefreshAllVisible();
	}

	private void OnMainLabelShow(ILoopScrollDataSource src)
	{
		if (!(src is LoopScrollBaseItem loopScrollBaseItem))
		{
			return;
		}
		loopScrollBaseItem.ScrollCellIndex(loopScrollBaseItem.index);
		if (loopScrollBaseItem is AccomplishmentLabel accomplishmentLabel)
		{
			if (!_hasPlayedInitialListShowAnimations)
			{
				accomplishmentLabel.PlayShowAnimation((float)loopScrollBaseItem.index * 0.02f);
			}
			accomplishmentLabel.SetGamepadSelected(IsGamepadActive() && _currentControllerType == AccomplishmentViewControllerType.AccomplishmentMainList && loopScrollBaseItem.index == _selectedMainLabelIndex);
		}
	}

	private void OnRarityShow(ILoopScrollDataSource src)
	{
		if (src is LoopScrollBaseItem loopScrollBaseItem)
		{
			loopScrollBaseItem.ScrollCellIndex(loopScrollBaseItem.index);
		}
	}

	private void OnRecentShow(ILoopScrollDataSource src)
	{
		if (!(src is LoopScrollBaseItem loopScrollBaseItem))
		{
			return;
		}
		loopScrollBaseItem.ScrollCellIndex(loopScrollBaseItem.index);
		if (loopScrollBaseItem is RecentAchievementsItem recentAchievementsItem)
		{
			if (!_hasPlayedInitialListShowAnimations)
			{
				recentAchievementsItem.PlayShowAnimation((float)loopScrollBaseItem.index * 0.02f);
			}
			recentAchievementsItem.SetGamepadSelected(IsGamepadActive() && _currentControllerType == AccomplishmentViewControllerType.RecentAchievementsList && loopScrollBaseItem.index == _selectedRecentAchievementIndex);
		}
	}

	public void RequestClaimAllInSelectedGroup()
	{
		if (_model != null && SelectedDetailGroupId != 0)
		{
			ClaimAllAsync().Forget();
		}
	}

	private async UniTaskVoid ClaimAllAsync()
	{
		await _model.ClaimAllInCurrentGroupAsync(SelectedDetailGroupId);
		RefreshAllVisible();
	}

	private void RefreshMainPage()
	{
		if (_model != null)
		{
			if (labelScrollRect != null)
			{
				labelScrollRect.totalCount = _model.OrderedMainIds.Count;
				labelScrollRect.RefillCells();
			}
			if (_countText != null)
			{
				_countText.text = _model.GetTotalReachedCount().ToString();
			}
			if (_degreeOfRarityScrollRect != null)
			{
				_degreeOfRarityScrollRect.totalCount = 3;
				_degreeOfRarityScrollRect.RefillCells();
			}
			_recentAchievementIds = _model.GetRecentReachedContentIds();
			bool flag = _recentAchievementIds.Count > 0;
			if (_recentAchievementsRoot != null)
			{
				_recentAchievementsRoot.SetActive(flag);
			}
			if (_emptyRoot != null)
			{
				_emptyRoot.SetActive(!flag);
			}
			if (_recentAchievementsScrollRect != null)
			{
				_recentAchievementsScrollRect.totalCount = _recentAchievementIds.Count;
				_recentAchievementsScrollRect.RefillCells();
			}
			ClampGamepadSelection();
			RefreshGamepadSelectionVisual();
		}
	}

	private void RefreshAllVisible()
	{
		RefreshMainPage();
		RefreshPickUpBtnState();
	}

	public void OnControllerActivate()
	{
		ChangeControllerType(AccomplishmentViewControllerType.AccomplishmentMainList);
		SelectMainLabel(0);
		RefreshGamepadState();
	}

	public void ExecuteNavigate(MoveDirection direction)
	{
		if (!IsGamepadActive())
		{
			return;
		}
		if (_currentControllerType == AccomplishmentViewControllerType.AccomplishmentMainList)
		{
			switch (direction)
			{
			case MoveDirection.Left:
				SelectMainLabel(_selectedMainLabelIndex - 1);
				break;
			case MoveDirection.Right:
			{
				int mainLabelCount = GetMainLabelCount();
				if (_selectedMainLabelIndex >= mainLabelCount - 1)
				{
					if (GetRecentAchievementCount() > 0)
					{
						ChangeControllerType(AccomplishmentViewControllerType.RecentAchievementsList);
						SelectRecentAchievement(0);
					}
				}
				else
				{
					SelectMainLabel(_selectedMainLabelIndex + 1);
				}
				break;
			}
			}
		}
		else if (_currentControllerType == AccomplishmentViewControllerType.RecentAchievementsList)
		{
			switch (direction)
			{
			case MoveDirection.Left:
				ChangeControllerType(AccomplishmentViewControllerType.AccomplishmentMainList);
				SelectMainLabel(GetMainLabelCount() - 1);
				break;
			case MoveDirection.Up:
				SelectRecentAchievement(_selectedRecentAchievementIndex - 1);
				break;
			case MoveDirection.Down:
				SelectRecentAchievement(_selectedRecentAchievementIndex + 1);
				break;
			}
		}
	}

	public void HandleGamepadConfirm()
	{
		if (IsGamepadActive())
		{
			if (_currentControllerType == AccomplishmentViewControllerType.AccomplishmentMainList)
			{
				OpenAccomplishmentDetailByMainIndex(_selectedMainLabelIndex);
			}
			else if (_currentControllerType == AccomplishmentViewControllerType.RecentAchievementsList)
			{
				OpenAccomplishmentDetailByRecentIndex(_selectedRecentAchievementIndex);
			}
		}
	}

	public void HandleGamepadOneKeyPickUp()
	{
		if (IsGamepadActive() && CanOneKeyPickUp())
		{
			OneKeyPickUp();
		}
	}

	private void ChangeControllerType(AccomplishmentViewControllerType controllerType)
	{
		if (controllerType == AccomplishmentViewControllerType.RecentAchievementsList && GetRecentAchievementCount() <= 0)
		{
			controllerType = AccomplishmentViewControllerType.AccomplishmentMainList;
		}
		_currentControllerType = controllerType;
		GetController()?.ChangeControllerType(controllerType);
		if (ViewControlLayers != null && ViewControlLayers.TryGetValue(controllerType, out var value))
		{
			value?.Focus();
		}
		RefreshGamepadSelectionVisual();
	}

	private void SelectMainLabel(int index)
	{
		_selectedMainLabelIndex = Mathf.Clamp(index, 0, Mathf.Max(0, GetMainLabelCount() - 1));
		RefreshGamepadSelectionVisual();
	}

	private void SelectRecentAchievement(int index)
	{
		_selectedRecentAchievementIndex = Mathf.Clamp(index, 0, Mathf.Max(0, GetRecentAchievementCount() - 1));
		RefreshGamepadSelectionVisual();
	}

	private void OpenAccomplishmentDetailByMainIndex(int mainIndex)
	{
		int mainIdByIndex = GetMainIdByIndex(mainIndex);
		if (mainIdByIndex != 0)
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONOACCOMPLISHMENTDETAILS, new MonoAccomplishmentDetailsViewData
			{
				TypeId = mainIdByIndex
			});
		}
	}

	private void OpenAccomplishmentDetailByRecentIndex(int recentIndex)
	{
		if (_model != null && TryGetRecentAchievementContentId(recentIndex, out var contentId) && _model.TryGetContent(contentId, out var content))
		{
			Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_MONOACCOMPLISHMENTDETAILS, new MonoAccomplishmentDetailsViewData
			{
				TypeId = _model.GetMainIdForContent(contentId),
				GroupId = content.groupID
			});
		}
	}

	private void ClampGamepadSelection()
	{
		_selectedMainLabelIndex = Mathf.Clamp(_selectedMainLabelIndex, 0, Mathf.Max(0, GetMainLabelCount() - 1));
		_selectedRecentAchievementIndex = Mathf.Clamp(_selectedRecentAchievementIndex, 0, Mathf.Max(0, GetRecentAchievementCount() - 1));
		if (_currentControllerType == AccomplishmentViewControllerType.RecentAchievementsList && GetRecentAchievementCount() <= 0)
		{
			ChangeControllerType(AccomplishmentViewControllerType.AccomplishmentMainList);
		}
	}

	private void RefreshGamepadSelectionVisual()
	{
		bool flag = IsGamepadActive();
		if (labelScrollRect != null)
		{
			for (int i = labelScrollRect.ItemIndexStart; i < labelScrollRect.ItemIndexEnd; i++)
			{
				if (labelScrollRect.GetItem(i) is AccomplishmentLabel accomplishmentLabel)
				{
					accomplishmentLabel.SetGamepadSelected(flag && _currentControllerType == AccomplishmentViewControllerType.AccomplishmentMainList && accomplishmentLabel.index == _selectedMainLabelIndex);
				}
			}
		}
		if (!(_recentAchievementsScrollRect != null))
		{
			return;
		}
		for (int j = _recentAchievementsScrollRect.ItemIndexStart; j < _recentAchievementsScrollRect.ItemIndexEnd; j++)
		{
			if (_recentAchievementsScrollRect.GetItem(j) is RecentAchievementsItem recentAchievementsItem)
			{
				recentAchievementsItem.SetGamepadSelected(flag && _currentControllerType == AccomplishmentViewControllerType.RecentAchievementsList && recentAchievementsItem.index == _selectedRecentAchievementIndex);
			}
		}
	}

	private void ClearGamepadSelection()
	{
		if (labelScrollRect != null)
		{
			for (int i = labelScrollRect.ItemIndexStart; i < labelScrollRect.ItemIndexEnd; i++)
			{
				if (labelScrollRect.GetItem(i) is AccomplishmentLabel accomplishmentLabel)
				{
					accomplishmentLabel.SetGamepadSelected(isActive: false);
				}
			}
		}
		if (!(_recentAchievementsScrollRect != null))
		{
			return;
		}
		for (int j = _recentAchievementsScrollRect.ItemIndexStart; j < _recentAchievementsScrollRect.ItemIndexEnd; j++)
		{
			if (_recentAchievementsScrollRect.GetItem(j) is RecentAchievementsItem recentAchievementsItem)
			{
				recentAchievementsItem.SetGamepadSelected(isActive: false);
			}
		}
	}

	private void RefreshGamepadState()
	{
		bool flag = IsGamepadActive();
		prompBoard?.SetActive(flag);
		operateBtnPromptA?.SetVisible(flag);
		operateBtnPromptB?.SetVisible(flag);
		if (flag)
		{
			operateBtnPromptA?.RefreshIcon();
			operateBtnPromptB?.RefreshIcon();
			ClampGamepadSelection();
			RefreshGamepadSelectionVisual();
		}
		else
		{
			ClearGamepadSelection();
		}
		RefreshPickUpPromptState();
	}

	private void EnsurePickUpPromptReference()
	{
		if (operateBtnPromptY != null || prompBoard == null)
		{
			return;
		}
		OperateBtnPrompt[] componentsInChildren = prompBoard.GetComponentsInChildren<OperateBtnPrompt>(includeInactive: true);
		foreach (OperateBtnPrompt operateBtnPrompt in componentsInChildren)
		{
			if (!(operateBtnPrompt == null) && !(operateBtnPrompt == operateBtnPromptA) && !(operateBtnPrompt == operateBtnPromptB))
			{
				operateBtnPromptY = operateBtnPrompt;
				break;
			}
		}
	}

	private void InitGamepadPromptBindings()
	{
		if (!_gamepadPromptInited)
		{
			_gamepadPromptInited = true;
			operateBtnPromptA?.SetBindingAction("UI/Confirm");
			operateBtnPromptB?.SetBindingAction("UI/Back");
			operateBtnPromptY?.SetBindingAction("UI/UISpecial1");
			operateBtnPromptA?.SetLocalizeString(774);
			operateBtnPromptB?.SetLocalizeString(606);
			operateBtnPromptY?.SetLocalizeString(0);
		}
	}

	private void OnUIBorderOffsetChanged(float value)
	{
		ApplySafeAreaScale();
	}

	private void ApplySafeAreaScale()
	{
		if (!MonoECS.instance.ispc)
		{
			float safeAreaScale = GetSafeAreaScale(SettingsManager.Instance.RuntimeSettings.GetSettingFloat("Other.UIBorder").GetValue());
			ApplyScaleToScroll(labelScrollRect, safeAreaScale);
			ApplyScaleToScroll(_degreeOfRarityScrollRect, safeAreaScale);
		}
	}

	private static float GetSafeAreaScale(float borderOffset)
	{
		return Mathf.Lerp(1f, 0.95f, Mathf.InverseLerp(84f, 144f, borderOffset));
	}

	private static void ApplyScaleToScroll(LoopHorizontalScrollRect scroll, float scale)
	{
		if (!(scroll == null))
		{
			scroll.transform.localScale = new Vector3(scale, scale, 1f);
		}
	}

	private bool IsGamepadActive()
	{
		return MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
	}

	private int GetMainLabelCount()
	{
		return (_model?.OrderedMainIds?.Count).GetValueOrDefault();
	}

	private int GetMainIdByIndex(int mainIndex)
	{
		if (_model?.OrderedMainIds == null || mainIndex < 0 || mainIndex >= _model.OrderedMainIds.Count)
		{
			return 0;
		}
		return _model.OrderedMainIds[mainIndex];
	}

	private int GetRecentAchievementCount()
	{
		if (_model != null)
		{
			return _recentAchievementIds.Count;
		}
		return 0;
	}

	public bool TryGetRecentAchievementContentId(int index, out int contentId)
	{
		if (index >= 0 && index < _recentAchievementIds.Count)
		{
			contentId = _recentAchievementIds[index];
			return true;
		}
		contentId = 0;
		return false;
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
		{
		}).Play();
	}

	private void RefreshPickUpBtnState()
	{
		if (!(_buttonPickUp == null))
		{
			bool active = Model<AccomplishmentModel>.Interface.IsShowPickUpBtn();
			_buttonPickUp.gameObject.SetActive(active);
			RefreshPickUpPromptState();
		}
	}

	private void RefreshPickUpPromptState()
	{
		bool flag = IsGamepadActive() && CanOneKeyPickUp();
		operateBtnPromptY?.SetVisible(flag);
		if (flag)
		{
			operateBtnPromptY?.RefreshIcon();
		}
	}

	private bool CanOneKeyPickUp()
	{
		if (_buttonPickUp != null && _buttonPickUp.gameObject.activeInHierarchy)
		{
			return _buttonPickUp.IsInteractable();
		}
		return false;
	}

	private void OneKeyPickUp()
	{
		OneKeyPickUpAsync().Forget();
	}

	private async UniTaskVoid OneKeyPickUpAsync()
	{
		await Model<AccomplishmentModel>.Interface.ClaimAllInCurrentGroupAsync(0);
		RefreshPickUpBtnState();
	}
}
