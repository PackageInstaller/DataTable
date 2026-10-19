using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Model;
using ACT.UI.InputController;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.UI;

namespace ACT.UI;

public class TextLibraryView : BaseUIView<TextLibraryViewInputController>
{
	public ActButton backBtn;

	public List<GameObject> toggles;

	public ActToggleGroup toggleGroup;

	public ScrollRect cellScrollRect;

	public TextLibraryRoot rootPrefab;

	public TextLibraryInfo textLibraryInfo;

	public SoftMask softMask;

	public TMP_InputField inputField;

	public ActButton searchBtn;

	public ActButton clearInputFieldBtn;

	public int searchLengthLimit;

	public LocalizeStringEvent typeTitleLocalize;

	public GameObject noTextLibraryRoot;

	public TextMeshProUGUI noTextLibraryText;

	public GameObject typeNoTextLibraryTextRoot;

	[SerializeField]
	private Dictionary<int, List<RedDotItem>> _toggleRedDotItems;

	private const int NORMALSEARCHTITLE = 38;

	private const int SEARCHRESULT = 1010;

	private const int SEARCHTEXTISNULL = 2278;

	private const int CLOSEROOT = 115;

	private const int OPENROOT = 2595;

	public ViewControlRoot viewPortControlRoot;

	public ViewControlLayer viewPortControlLayer;

	[Header("手柄按键提示")]
	public OperateBtnPrompt triggerInputFieldPrompt;

	[Header("手柄按键提示")]
	public OperateBtnPrompt gamePadLBPrompt;

	[Header("手柄按键提示")]
	public OperateBtnPrompt gamePadRBPrompt;

	[Header("手柄按键提示")]
	public OperateBtnPrompt confirmPrompt_A;

	[Header("手柄按键提示")]
	public OperateBtnPrompt searchConfirmPrompt_Y;

	[Header("手柄按键提示")]
	public OperateBtnPrompt rightStickPrompt;

	[Header("手柄按键提示")]
	public CanvasGroup bottomPromptRoot;

	[SerializeField]
	private float scrollSpeed = 2f;

	private bool _canScroll;

	private float _rightStickInput;

	private string searchText;

	private string preSearchText;

	private bool _isSearching;

	private bool _isInputFieldTriggered;

	private bool _initJumpState;

	private List<TextLibrary> _curShowTextLibraryGroupDatas;

	private List<TextLibraryRoot> _curShowRootCells;

	private TextLibrary _curSelectedGroup;

	private TextLibraryMain _curSelectedMain;

	private int _curSelectedContentId;

	private TextLibraryData _curSelectedContent;

	private TextLibraryViewData m_data;

	private bool _layoutDirty;

	public float softMaskScopeV { get; private set; }

	public string SearchText => searchText;

	public bool isSearching => _isSearching;

	public TextLibraryCell curSelectedCell { get; private set; }

	public TextLibraryData curSelectedContent
	{
		get
		{
			return _curSelectedContent;
		}
		set
		{
			_curSelectedContent = value;
		}
	}

	public int curSelectedTabIndex { get; private set; } = -1;

	private int selectGroupIndex => _curShowTextLibraryGroupDatas.IndexOf(_curSelectedGroup);

	protected override void AddEventListener()
	{
		backBtn.SetBtnClick(Close);
		inputField.onValueChanged.RemoveAllListeners();
		inputField.onValueChanged.AddListener(OnInputFieldValueChanged);
		inputField.onDeselect.RemoveAllListeners();
		inputField.onDeselect.AddListener(OnInputFieldDeselect);
		searchBtn.SetBtnClick(() =>
		{
			OnSearchSubmit(searchText);
		});
		clearInputFieldBtn.SetBtnClick(ClearInputFieldEvent);
		base.AddEventListener();
	}

	protected override void RemoveEventListener()
	{
		base.RemoveEventListener();
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
		m_data = uiViewData as TextLibraryViewData;
		_curShowTextLibraryGroupDatas = ListPool<TextLibrary>.Get();
		_curShowRootCells = ListPool<TextLibraryRoot>.Get();
		softMaskScopeV = softMask?.scopeV ?? 0f;
	}

	protected override void Init()
	{
		base.Init();
		InitToggleGroupRedDot();
		if (m_data != null && m_data.targetJumpTextDataId != 0)
		{
			int textLibraryType = Model<TextLibraryModel>.Interface.GetTextLibraryType(m_data.targetJumpTextDataId);
			SelectTab(textLibraryType - 1);
		}
		else
		{
			toggleGroup.Init();
		}
	}

	private void InitToggleGroupRedDot()
	{
		for (int i = 0; i < toggleGroup.ToggleCount; i++)
		{
			string text = "";
			switch (i)
			{
			case 0:
				text = RedDotPathDefine.TextLibrary;
				break;
			case 1:
				text = RedDotPathDefine.ViewPort;
				break;
			}
			if (string.IsNullOrEmpty(text) || !_toggleRedDotItems.TryGetValue(i, out var value))
			{
				continue;
			}
			foreach (RedDotItem item in value)
			{
				item.InitRedDot(text, RedDotType.New);
			}
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		betterAnimation.GetSequence("Show").OnAnimationPlay((AnimationBuilder _) =>
		{
			Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Common/Window_Mini_Open");
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		textLibraryInfo?.UnInit();
		toggleGroup.SetAllToggleOff();
		ListPool<TextLibrary>.Release(_curShowTextLibraryGroupDatas);
		ClearInputField();
		ClearRootCells();
		_curSelectedContent = null;
		_curSelectedContentId = 0;
		_curSelectedGroup = null;
		_curSelectedMain = null;
		curSelectedTabIndex = -1;
		_initJumpState = false;
		_rightStickInput = 0f;
		curSelectedCell = null;
		viewPortControlLayer?.UnFocus();
		ListPool<TextLibraryRoot>.Release(_curShowRootCells);
		Model<TextLibraryModel>.Interface.SetTextLibraryIsRead();
		Model<TextLibraryModel>.Interface.SyncTextLibrariesGroupState();
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
		betterAnimation.GetSequence("Hide").Play();
	}

	protected override void CloseEffectCallback()
	{
		base.CloseEffectCallback();
	}

	public void OnSelectToggle(int libraryTypeId)
	{
		curSelectedTabIndex = libraryTypeId - 1;
		_curShowTextLibraryGroupDatas.Clear();
		if (_isSearching)
		{
			_curShowTextLibraryGroupDatas = (from i in Model<TextLibraryModel>.Interface.GetTextLibraryGroupsByType(libraryTypeId)
				where Model<TextLibraryModel>.Interface.GroupContainsSearchTraget(i.id, searchText)
				select i).ToList();
		}
		else
		{
			typeTitleLocalize.StringReference.TableEntryReference = 38L;
			_curShowTextLibraryGroupDatas = Model<TextLibraryModel>.Interface.GetTextLibraryGroupsByType(libraryTypeId);
		}
		_curSelectedMain = CoreUtils.GetData(libraryTypeId, RuntimeConfigs.data.textLibraryMains);
		if (_curShowTextLibraryGroupDatas.Count == 0)
		{
			SetHasTextLibrary(hasTextLibrary: false);
			return;
		}
		RefreshTextLibraryByType();
		SetBottomPromptRootActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad || MonoECS.instance.InputMode == DeviceInputMode.KeyboardAndMouse)
		{
			RefreshScrollViewSelection();
			_canScroll = MonoECS.instance.InputMode == DeviceInputMode.Gamepad && textLibraryInfo.scrollView.content.rect.height > textLibraryInfo.scrollView.viewport.rect.height;
		}
	}

	private void RefreshTextLibraryByType()
	{
		List<TextLibrary> curShowTextLibraryGroupDatas = _curShowTextLibraryGroupDatas;
		if (curShowTextLibraryGroupDatas == null || curShowTextLibraryGroupDatas.Count <= 0)
		{
			return;
		}
		SetHasTextLibrary(hasTextLibrary: true);
		_curShowTextLibraryGroupDatas.Sort((TextLibrary x, TextLibrary y) => x.id - y.id);
		int num = 0;
		_curSelectedContentId = 0;
		if (!_initJumpState)
		{
			_initJumpState = true;
			if (m_data != null && m_data.targetJumpTextDataId != 0)
			{
				num = _curShowTextLibraryGroupDatas.FindIndex((TextLibrary i) => i.content.Contains(m_data.targetJumpTextDataId));
				_curSelectedContentId = m_data.targetJumpTextDataId;
				_curSelectedGroup = _curShowTextLibraryGroupDatas[num];
			}
			else
			{
				_curSelectedGroup = _curShowTextLibraryGroupDatas[0];
			}
		}
		else
		{
			_curSelectedGroup = _curShowTextLibraryGroupDatas[0];
		}
		BuildRootCells(num);
	}

	private void BuildRootCells(int selectCellRootIndex)
	{
		ClearRootCells();
		RectTransform rectTransform = ((cellScrollRect != null) ? cellScrollRect.content : null);
		if (!(rectTransform == null) && !(rootPrefab == null))
		{
			for (int i = 0; i < _curShowTextLibraryGroupDatas.Count; i++)
			{
				TextLibraryRoot textLibraryRoot = Object.Instantiate(rootPrefab, rectTransform);
				textLibraryRoot.parentView = this;
				textLibraryRoot.index = i;
				textLibraryRoot.gameObject.SetActive(value: true);
				_curShowRootCells.Add(textLibraryRoot);
				RefreshRootCell(textLibraryRoot, i);
			}
			if (selectCellRootIndex >= 0 && _curShowRootCells.Count > selectCellRootIndex)
			{
				ScrollTargetContentId(_curSelectedContentId, _curShowRootCells[selectCellRootIndex]);
			}
			else
			{
				MarkLayoutDirty();
			}
		}
	}

	private void RefreshRootCell(TextLibraryRoot rootCell, int index)
	{
		TextLibrary textLibrary = _curShowTextLibraryGroupDatas[index];
		List<TextLibraryData> list = ((!_isSearching) ? Model<TextLibraryModel>.Interface.GetTextLibraryDataListByGroupId(textLibrary.id).ToList() : (from i in Model<TextLibraryModel>.Interface.GetTextLibraryDataListByGroupId(textLibrary.id)
			where Model<TextLibraryModel>.Interface.TextLibraryDatasContainsSearchTraget(i, searchText)
			select i).ToList());
		list.Sort((TextLibraryData x, TextLibraryData y) => x.contentId - y.contentId);
		if (selectGroupIndex == index)
		{
			if (_curSelectedContentId == 0)
			{
				_curSelectedContent = list.FirstOrDefault();
				_curSelectedContentId = _curSelectedContent?.contentId ?? 0;
			}
			else
			{
				_curSelectedContent = list.FirstOrDefault((TextLibraryData i) => i.contentId == _curSelectedContentId);
			}
		}
		TextLibraryRootData param = new TextLibraryRootData
		{
			tableData = textLibrary,
			curShowTextLibraryCellDatas = list
		};
		rootCell.Init(param);
	}

	private void ScrollTargetContentId(int contentId, TextLibraryRoot rootCell)
	{
		if (cellScrollRect == null)
		{
			return;
		}
		RectTransform content = cellScrollRect.content;
		if (!(content == null))
		{
			if (rootCell != null && !rootCell.cellRootIsOpen)
			{
				Model<TextLibraryModel>.Interface.groupState[rootCell.curGroupData.tableData.id] = false;
				rootCell.SetCellRootState(active: true);
			}
			LayoutRebuilder.ForceRebuildLayoutImmediate(content);
			RectTransform rectTransform = ((rootCell != null) ? rootCell.GetCellRectByContentId(contentId) : null);
			if (!(rectTransform == null))
			{
				ScrollTargetRectCentered(rectTransform);
			}
		}
	}

	private void ScrollTargetRectCentered(RectTransform itemRect)
	{
		if (itemRect == null || cellScrollRect == null)
		{
			return;
		}
		RectTransform content = cellScrollRect.content;
		if (!(content == null))
		{
			Canvas.ForceUpdateCanvases();
			RectTransform viewport = GetViewport();
			if (!(viewport == null))
			{
				float height = content.rect.height;
				float height2 = viewport.rect.height;
				float value = GetItemContentCenterY(itemRect) - height2 * 0.5f;
				value = Mathf.Clamp(value, 0f, Mathf.Max(0f, height - height2));
				Vector2 anchoredPosition = content.anchoredPosition;
				anchoredPosition.y = value;
				content.anchoredPosition = anchoredPosition;
			}
		}
	}

	public float GetItemContentCenterY(RectTransform item)
	{
		if (cellScrollRect == null || cellScrollRect.content == null || item == null)
		{
			return 0f;
		}
		return 0f - RectTransformUtility.CalculateRelativeRectTransformBounds(cellScrollRect.content, item).center.y;
	}

	public float GetItemViewportTopY(RectTransform item)
	{
		RectTransform viewport = GetViewport();
		if (viewport == null || item == null)
		{
			return 0f;
		}
		return RectTransformUtility.CalculateRelativeRectTransformBounds(viewport, item).max.y;
	}

	private RectTransform GetViewport()
	{
		if (!(cellScrollRect != null) || !(cellScrollRect.viewport != null))
		{
			if (!(cellScrollRect != null))
			{
				return null;
			}
			return cellScrollRect.GetComponent<RectTransform>();
		}
		return cellScrollRect.viewport;
	}

	private void ClearRootCells()
	{
		if (_curShowRootCells == null || _curShowRootCells.Count == 0)
		{
			return;
		}
		for (int num = _curShowRootCells.Count - 1; num >= 0; num--)
		{
			if (_curShowRootCells[num] != null)
			{
				Object.Destroy(_curShowRootCells[num].gameObject);
			}
		}
		_curShowRootCells.Clear();
	}

	public void RefreshScrollLayout(RectTransform anchorItem, float anchorViewportY)
	{
		if (cellScrollRect == null || cellScrollRect.content == null)
		{
			return;
		}
		RectTransform content = cellScrollRect.content;
		LayoutRebuilder.ForceRebuildLayoutImmediate(content);
		Canvas.ForceUpdateCanvases();
		_layoutDirty = false;
		if (!(anchorItem == null))
		{
			RectTransform viewport = GetViewport();
			if (!(viewport == null))
			{
				float num = GetItemViewportTopY(anchorItem) - anchorViewportY;
				Vector2 anchoredPosition = content.anchoredPosition;
				anchoredPosition.y += num;
				anchoredPosition.y = Mathf.Clamp(anchoredPosition.y, 0f, Mathf.Max(0f, content.rect.height - viewport.rect.height));
				content.anchoredPosition = anchoredPosition;
			}
		}
	}

	private void LateUpdate()
	{
		EnsureLayoutUpdated();
	}

	private void MarkLayoutDirty()
	{
		_layoutDirty = true;
	}

	private void EnsureLayoutUpdated()
	{
		if (_layoutDirty)
		{
			RefreshScrollLayout(null, 0f);
		}
	}

	public void SetSelectedCell(TextLibraryCell cell)
	{
		if (!(cell == null))
		{
			if (curSelectedCell != null && curSelectedCell != cell && curSelectedCell.isSelected)
			{
				curSelectedCell.SetSelectedState(active: false);
			}
			curSelectedCell = cell;
			MarkLayoutDirty();
		}
	}

	private void ClearInputFieldEvent()
	{
		ClearInputField();
		if (_isSearching)
		{
			_isSearching = false;
		}
		for (int i = 0; i < toggles.Count; i++)
		{
			GameObject gameObject = toggles[i];
			if (!gameObject.gameObject.activeInHierarchy)
			{
				gameObject.gameObject.SetActive(value: true);
			}
		}
		curSelectedTabIndex = -1;
		toggleGroup.SetAllToggleOff();
		toggleGroup.Init(_curSelectedMain.id - 1);
		RefreshOperatePromptState();
	}

	private void ClearInputField()
	{
		_isSearching = false;
		inputField.DeactivateInputField();
		inputField.interactable = true;
		inputField.text = string.Empty;
		searchText = string.Empty;
		preSearchText = string.Empty;
		clearInputFieldBtn.gameObject.SetActive(value: false);
		searchBtn.gameObject.SetActive(value: true);
	}

	private void OnInputFieldValueChanged(string arg0)
	{
		searchText = arg0;
	}

	private void OnInputFieldDeselect(string _)
	{
	}

	private void OnSearchSubmit(string result)
	{
		if (string.IsNullOrEmpty(result))
		{
			GameUtility.OpenToolTip(2278);
			return;
		}
		_isSearching = true;
		inputField.interactable = false;
		clearInputFieldBtn.gameObject.SetActive(value: true);
		searchBtn.gameObject.SetActive(value: false);
		if (result != preSearchText)
		{
			preSearchText = result;
			typeTitleLocalize.StringReference.TableEntryReference = 1010L;
			Model<TextLibraryModel>.Interface.GetMatchSearchTextLibraryTypeIds(result, out var result2);
			if (result2.Count == 0)
			{
				toggles.ForEach((GameObject i) =>
				{
					i.gameObject.SetActive(value: false);
				});
				SetHasTextLibrary(hasTextLibrary: false);
				UntriggerInputField();
				return;
			}
			for (int num = 0; num < toggles.Count; num++)
			{
				bool active = result2.Contains(num + 1);
				toggles[num].gameObject.SetActive(active);
			}
			toggleGroup.SetAllToggleOff();
			toggleGroup.Init(result2[0] - 1);
		}
		UntriggerInputField();
	}

	public void SetHasTextLibrary(bool hasTextLibrary)
	{
		if (cellScrollRect != null)
		{
			cellScrollRect.gameObject.SetActive(hasTextLibrary);
		}
		textLibraryInfo.gameObject.SetActive(hasTextLibrary);
		noTextLibraryRoot.SetActive(!hasTextLibrary);
		if (hasTextLibrary)
		{
			return;
		}
		if (!string.IsNullOrEmpty(searchText))
		{
			typeNoTextLibraryTextRoot.SetActive(value: true);
			if (searchText.Length > searchLengthLimit)
			{
				string text = searchText.Substring(0, 10);
				text += "...";
				noTextLibraryText.text = text;
			}
			else
			{
				noTextLibraryText.text = searchText;
			}
		}
		else
		{
			typeNoTextLibraryTextRoot.SetActive(value: true);
			noTextLibraryText.text = LocalizationSettings.StringDatabase.GetLocalizedString("shortcommon", _curSelectedMain.name, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null);
		}
	}

	public override void Close()
	{
		LibraryContentEvent evt = EventTrackSolver.Instance.GetEvt<LibraryContentEvent>();
		evt.contentId = 0;
		evt.libraryId = 0;
		evt.mainId = 0;
		evt.isRednote = false;
		evt.op = 2;
		EventTrackSolver.Instance.Dispatch(evt);
		base.Close();
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		base.OnInputDeviceChange(type);
		if (!_isInputFieldTriggered)
		{
			RefreshScrollViewSelection();
		}
		if (type == DeviceInputMode.Gamepad)
		{
			_canScroll = textLibraryInfo.scrollView.content.rect.height > textLibraryInfo.scrollView.viewport.rect.height;
			SetBottomPromptRootActive(active: true);
		}
		else
		{
			SetBottomPromptRootActive(active: false);
			_canScroll = false;
		}
		RefreshOperatePromptState();
	}

	public void SelectTab(int index)
	{
		if (curSelectedTabIndex != index)
		{
			toggleGroup.SetToggleOn(index);
		}
	}

	public void RefreshScrollViewSelection()
	{
		viewPortControlLayer.DefaultSelect = ((curSelectedCell != null) ? curSelectedCell.selectableEx : null);
		ViewControlRoot viewControlRoot = viewPortControlRoot;
		if ((object)viewControlRoot != null && !viewControlRoot.ReFocus())
		{
			viewPortControlLayer?.Focus();
		}
		RefreshSelectionArrowState();
	}

	private void Update()
	{
		ExecuteRightStickScroll();
	}

	public void OnRightStickScroll(Vector2 value)
	{
		_rightStickInput = (_canScroll ? value.y : 0f);
	}

	private void RefreshRightStickScrollState()
	{
		if (textLibraryInfo == null || textLibraryInfo.scrollView == null)
		{
			_canScroll = false;
			return;
		}
		Canvas.ForceUpdateCanvases();
		ScrollRect scrollView = textLibraryInfo.scrollView;
		_canScroll = !_isInputFieldTriggered && MonoECS.instance.InputMode == DeviceInputMode.Gamepad && scrollView.content != null && scrollView.viewport != null && scrollView.content.rect.height > scrollView.viewport.rect.height;
	}

	private void ExecuteRightStickScroll()
	{
		if (_canScroll)
		{
			float valueOrDefault = (textLibraryInfo?.scrollView?.verticalNormalizedPosition).GetValueOrDefault();
			valueOrDefault += _rightStickInput * scrollSpeed * Time.unscaledDeltaTime;
			if (textLibraryInfo != null && textLibraryInfo.scrollView != null)
			{
				textLibraryInfo.scrollView.verticalNormalizedPosition = Mathf.Clamp01(valueOrDefault);
			}
		}
	}

	public void StopNavigate()
	{
		GetController()?.StopNavigate();
		viewPortControlLayer?.UnFocus();
	}

	private void InputSubmitSearch()
	{
		searchBtn.OnClick?.Invoke();
	}

	private void InputClearSearch()
	{
		clearInputFieldBtn.OnClick?.Invoke();
	}

	public void OnButtonNorthClick()
	{
		if (_isInputFieldTriggered || _isSearching)
		{
			if (searchBtn.gameObject.activeInHierarchy)
			{
				InputSubmitSearch();
			}
			else
			{
				InputClearSearch();
			}
		}
	}

	public bool IsInputFieldTriggered()
	{
		return _isInputFieldTriggered;
	}

	private void RefreshInputFieldSearchButtonState()
	{
		bool flag = _isSearching && !string.IsNullOrEmpty(searchText);
		clearInputFieldBtn.gameObject.SetActive(flag);
		searchBtn.gameObject.SetActive(!flag);
	}

	private void RefreshSelectionArrowState()
	{
	}

	private void RefreshGamepadPromptState()
	{
		triggerInputFieldPrompt.SetVisible(!_isInputFieldTriggered && !_isSearching);
		searchConfirmPrompt_Y.SetVisible(_isInputFieldTriggered || _isSearching);
		int activeToggleCount = toggleGroup.GetActiveToggleCount();
		gamePadLBPrompt.SetVisible(!_isInputFieldTriggered && !inputField.isFocused && activeToggleCount > 1);
		gamePadRBPrompt.SetVisible(!_isInputFieldTriggered && !inputField.isFocused && activeToggleCount > 1);
		bool visible = !_isInputFieldTriggered && !_isSearching && _canScroll;
		rightStickPrompt.SetVisible(visible);
		RefreshConfirmPromptState(CanShowConfirmPrompt());
	}

	public void RefreshConfirmPromptState(bool active)
	{
		confirmPrompt_A.SetVisible(active && !_isInputFieldTriggered && !_isSearching);
		RefreshConfirmPromptText();
	}

	private bool CanShowConfirmPrompt()
	{
		return EventSystemHelper.CurrentSelected?.GetComponent<TextLibraryCell>() == null;
	}

	private void RefreshConfirmPromptText()
	{
		TextLibraryRoot textLibraryRoot = EventSystemHelper.CurrentSelected?.GetComponentInParent<TextLibraryRoot>();
		if (textLibraryRoot != null)
		{
			RefreshConfirmPromptText(textLibraryRoot.cellRootIsOpen);
		}
	}

	public void RefreshConfirmPromptText(bool cellRootIsOpen)
	{
		confirmPrompt_A.SetPromptDes(LocalizeTable.Common, cellRootIsOpen ? 115 : 2595);
	}

	public void RefreshOperatePromptState()
	{
		RefreshRightStickScrollState();
		RefreshGamepadPromptState();
		RefreshSelectionArrowState();
	}

	public void TriggerInputField()
	{
		if (!(inputField == null) && !_isInputFieldTriggered)
		{
			_isInputFieldTriggered = true;
			_rightStickInput = 0f;
			_canScroll = false;
			StopNavigate();
			RefreshGamepadPromptState();
			((IOperatePromptIconCollectionProvider)this).UnInitCollection();
			RefreshInputFieldSearchButtonState();
			inputField.ActivateInputField();
			inputField.Select();
			inputField.MoveTextEnd(shift: false);
		}
	}

	public void UntriggerInputField()
	{
		if (!(inputField == null))
		{
			if (!_isInputFieldTriggered)
			{
				inputField.DeactivateInputField();
				return;
			}
			_isInputFieldTriggered = false;
			inputField.DeactivateInputField();
			RefreshScrollViewSelection();
			((IOperatePromptIconCollectionProvider)this).InitCollection();
			RefreshOperatePromptState();
		}
	}

	private void SetBottomPromptRootActive(bool active)
	{
		bottomPromptRoot.alpha = (active ? 1 : 0);
	}

	public void OnInputConfirm()
	{
		if ((bool)EventSystemHelper.CurrentSelected)
		{
			ACT.ViewControl.SelectableEx component = EventSystemHelper.CurrentSelected.GetComponent<ACT.ViewControl.SelectableEx>();
			if (component != null && component.Selectable.interactable)
			{
				ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, new BaseEventData(EventSystemHelper.Shared), ExecuteEvents.submitHandler);
			}
		}
		else
		{
			RefreshScrollViewSelection();
		}
	}
}
