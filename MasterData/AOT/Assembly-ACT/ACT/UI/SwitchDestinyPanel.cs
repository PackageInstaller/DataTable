using System;
using System.Text;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Game.Data;
using ACT.RichText;
using ACT.UI.DataProxy;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Bamboo.NumberString;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization;
using UnityEngine.Localization.Components;
using UnityEngine.UI;

namespace ACT.UI;

public class SwitchDestinyPanel : SubUIView<SwitchDestinyPanelSubInputController>
{
	[SerializeField]
	private GameObject activeLight;

	[SerializeField]
	private GameObject desIcon;

	[SerializeField]
	private GameObject sideADesIcon;

	[SerializeField]
	private GameObject sideBDesIcon;

	[SerializeField]
	private GameObject destinyIndexRoot;

	[SerializeField]
	private TextMeshProUGUI destinyIndex;

	[SerializeField]
	private BetterAnimation anim;

	[SerializeField]
	private new LocalizeStringEvent name;

	[SerializeField]
	private TextMeshProUGUI desc;

	[SerializeField]
	private ScrollRect descScrollRect;

	[SerializeField]
	private TextMeshProUGUI descText;

	private const int MinScrollLines = 5;

	[SerializeField]
	private OperateBtnPrompt btnPrompt_A;

	[SerializeField]
	private OperateBtnPrompt btnPrompt_B;

	[SerializeField]
	private OperateBtnPrompt scrollHint;

	[SerializeField]
	private OperateBtnPrompt clickItemCellPrompt;

	[SerializeField]
	private float scrollSpeed = 2f;

	private bool _canScroll;

	private float _scrollInput;

	[SerializeField]
	private ActButton activeBtn;

	[SerializeField]
	private ActButton returnBtn;

	[SerializeField]
	private ActButton closeBtn;

	[SerializeField]
	private LocalizeStringEvent activeBtnText;

	[SerializeField]
	private LocalizeStringEvent cancelBtnText;

	[SerializeField]
	private LocalizeStringEvent costText;

	[SerializeField]
	private ItemUIComponentBase costItem;

	[SerializeField]
	private GameObject commonRoot;

	[SerializeField]
	private GameObject extraRoot;

	[SerializeField]
	private GameObject activeText;

	[SerializeField]
	private GameObject inactiveText;

	[SerializeField]
	private GameObject unActiveCountRoot;

	[SerializeField]
	private GameObject extraDesProgessRoot;

	[SerializeField]
	private TextMeshProUGUI leftText;

	[SerializeField]
	private TextMeshProUGUI rightText;

	[SerializeField]
	private TextMeshProUGUI unActivedText;

	[SerializeField]
	private TextMeshProUGUI activedText;

	[SerializeField]
	private ViewControlRoot _viewControlRoot;

	[SerializeField]
	private ViewControlLayer _viewControlLayer;

	private int _destinyId;

	private bool _active;

	private bool _isCommon;

	private Func<int, bool, bool> _switchAction;

	private Action<int> _hideAction;

	private int _extraDesStage;

	private int _curActivedCount;

	private bool _isHiding;

	private bool _isSwitching;

	public ViewControlRoot ViewControlRoot => _viewControlRoot;

	public ViewControlLayer ViewControlLayer => _viewControlLayer;

	public bool isOpen { get; private set; }

	public ItemUIComponentBase costCell => costItem;

	public void Init(CharacterConstellationData destinyData, bool isActive, bool isCommon, int hasCostItemNum, int curActivedCount, bool isTrialCharacter, Func<int, bool, bool> switchAction, Action<int> hideAction, StringBuilder _sb)
	{
		_destinyId = destinyData.id;
		_active = isActive;
		_isCommon = isCommon;
		_switchAction = switchAction;
		_hideAction = hideAction;
		_extraDesStage = ((!_isCommon) ? destinyData.constellationLevel : 0);
		_curActivedCount = curActivedCount;
		RefreshDestinyDisplay(destinyData.constellationLevel);
		InitBtn(hasCostItemNum, isTrialCharacter);
		InitText(isTrialCharacter);
		if (int.TryParse(destinyData.constellationSkillName[0], out var result))
		{
			SkillDetailMessageData data = CoreUtils.GetData(CoreUtils.GetData(result * 100 + 1, RuntimeConfigs.data.skillGroupLevelDatas).skillDes[0], RuntimeConfigs.data.skillDetailMessageDatas);
			string localizeString = LocalizationUtility.GetLocalizeString("longcommon", data.detailDescLocal, isSmart: false);
			string sourceText = CustomTagParser.ReplaceText(data.skillid, localizeString, 1);
			name.SetEntry(data.nameLocal);
			desc.SetText(sourceText);
		}
		ItemData data2 = CoreUtils.GetData(destinyData.costItemId, RuntimeConfigs.data.itemDatas);
		costText.StringReference.TableEntryReference = (isActive ? LocalizationCommonData.CommonString.CostItem : LocalizationCommonData.CommonString.BackItem);
		commonRoot.SetActive(_isCommon && !isTrialCharacter);
		extraRoot.SetActive(!_isCommon | isTrialCharacter);
		UpdateCostItem(data2, _active, hasCostItemNum);
		Canvas.ForceUpdateCanvases();
		_canScroll = descScrollRect.content.rect.height > descScrollRect.viewport.rect.height;
		descScrollRect.verticalNormalizedPosition = 1f;
		_scrollInput = 0f;
		RefreshBtnPromptVisible();
		if (!isOpen)
		{
			gameObject.SetActive(value: true);
			FocusIn();
			isOpen = true;
			_isHiding = false;
			anim?.GetSequence("Show").Play();
		}
	}

	private void RefreshDestinyDisplay(int constellationLevel)
	{
		activeLight.SetActive(_active);
		destinyIndexRoot.SetActive(_isCommon);
		if (_isCommon)
		{
			destinyIndex.SetText("{0:00}", constellationLevel);
		}
		desIcon.SetActive(_isCommon);
		sideADesIcon.SetActive(!_isCommon && constellationLevel == 7);
		sideBDesIcon.SetActive(!_isCommon && constellationLevel == 8);
	}

	public void UnInit()
	{
		if (!_isHiding)
		{
			if (!_isHiding)
			{
				_isHiding = true;
			}
			isOpen = false;
			_isHiding = false;
			_isSwitching = false;
			FocusOut();
			anim?.GetSequence("Hide").OnComplete((AnimationBuilder _) =>
			{
				gameObject.SetActive(value: false);
			}).Play();
		}
	}

	private void UpdateCostItem(ItemData itemData, bool isActive, int leftCount)
	{
		ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(itemData.id, 1L);
		costItem.SetData(item, leftCount, ItemUIComponentBase.InitType.RewardItem, isActive ? ItemUIComponentBase.ItemCountShowType.OneSide : ItemUIComponentBase.ItemCountShowType.Both);
		costItem.UpdatePerformance();
	}

	private void InitBtn(int hasCostItemNum, bool isTrialCharacter = false)
	{
		closeBtn.SetBtnClick(Hide);
		returnBtn.SetBtnClick(Hide);
		if (!_isCommon | isTrialCharacter)
		{
			activeBtn.gameObject.SetActive(value: false);
			cancelBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Return;
			return;
		}
		activeBtn.SetBtnClick(SwitchState);
		activeBtn.gameObject.SetActive(!isTrialCharacter);
		cancelBtnText.StringReference.TableEntryReference = LocalizationCommonData.CommonString.Cancel;
		activeBtnText.StringReference.TableEntryReference = (_active ? LocalizationCommonData.CommonString.Back : LocalizationCommonData.CommonString.Activate);
		activeBtn.interactable = _active || hasCostItemNum >= 1;
	}

	private void InitText(bool isTrialCharacter = false)
	{
		if (!_isCommon | isTrialCharacter)
		{
			if (!_active)
			{
				leftText.SetText(_curActivedCount.FastToString());
				rightText.SetText((_extraDesStage == 7) ? 3.FastToString() : 6.FastToString());
			}
			unActiveCountRoot.SetActive(value: true);
			extraDesProgessRoot.SetActive(!_active);
			unActivedText.gameObject.SetActive(!_active);
			activedText.gameObject.SetActive(_active);
		}
		else
		{
			activeText.gameObject.SetActive(!_active);
			inactiveText.gameObject.SetActive(_active);
			unActiveCountRoot.SetActive(value: false);
			extraDesProgessRoot.SetActive(value: false);
			unActivedText.gameObject.SetActive(value: false);
			activedText.gameObject.SetActive(value: false);
		}
	}

	private void SwitchState()
	{
		if (!_isSwitching && !_isHiding)
		{
			_isSwitching = true;
			bool flag = !_active;
			if (!_switchAction(_destinyId, flag))
			{
				_isSwitching = false;
				return;
			}
			_active = flag;
			activeLight.SetActive(_active);
			activeBtn.interactable = false;
			_hideAction(_destinyId);
		}
	}

	public void Hide()
	{
		_hideAction(_destinyId);
	}

	protected override void OnFocusIn()
	{
		base.OnFocusIn();
		RefreshBtnPromptVisible();
	}

	public void OnNavigate(Vector2 value)
	{
		if (!(value == Vector2.zero))
		{
			if (!EventSystemHelper.CurrentSelected)
			{
				RefreshSelection();
			}
			AxisEventData axisEventData = new AxisEventData(EventSystemHelper.Shared);
			axisEventData.Reset();
			axisEventData.moveVector = value;
			axisEventData.moveDir = ContinuousNavigateUtility.DetermineMoveDirection(value.x, value.y, 0.6f);
			if (axisEventData.moveDir != MoveDirection.None)
			{
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, axisEventData, ExecuteEvents.moveHandler);
			}
		}
	}

	public void OnConfirm()
	{
		activeBtn?.OnClick?.Invoke();
	}

	public void RefreshSelection()
	{
		ViewControlRoot viewControlRoot = _viewControlRoot;
		if ((object)viewControlRoot != null && !viewControlRoot.ReFocus())
		{
			_viewControlLayer?.Focus();
		}
	}

	public void OnRightStickScroll(Vector2 value)
	{
		_scrollInput = (_canScroll ? value.y : 0f);
	}

	private void Update()
	{
		if (_scrollInput != 0f && _canScroll)
		{
			float verticalNormalizedPosition = descScrollRect.verticalNormalizedPosition;
			verticalNormalizedPosition += _scrollInput * scrollSpeed * Time.unscaledDeltaTime;
			descScrollRect.verticalNormalizedPosition = Mathf.Clamp01(verticalNormalizedPosition);
		}
	}

	public void SetBtnPromptActive(bool activeA, bool activeB)
	{
		btnPrompt_A.SetVisible(activeA);
		btnPrompt_B.SetVisible(activeB);
	}

	private void RefreshBtnPromptVisible()
	{
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		SetBtnPromptActive(flag && _isCommon, flag);
		scrollHint?.SetVisible(_canScroll);
	}

	public void OnDeviceChange(DeviceInputMode mode)
	{
		RefreshBtnPromptVisible();
	}
}
