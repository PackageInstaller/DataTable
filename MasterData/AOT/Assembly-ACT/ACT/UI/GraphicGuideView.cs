using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Model;
using ACT.Utility;
using ACT.ViewControl;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.UI;
using Utility;

namespace ACT.UI;

public class GraphicGuideView : BaseUIView<GraphicGuideViewInputController>
{
	private GraphicGuideViewData m_data;

	public ActToggleGroup toggleGroup;

	public GameObject[] toggles;

	public LoopVerticalScrollRect tutorialCellScrollRect;

	public float tutorialCellShowDuration = 0.02f;

	public TutorialInfo tutorialInfo;

	public TMP_InputField inputField;

	public ActButton searchBtn;

	public ActButton clearInputFieldBtn;

	public int searchLengthLimit;

	public LocalizeStringEvent typeTitleLocalize;

	public GameObject searchBoard;

	public GameObject subTitleSlash;

	public GameObject searchResultTextGo;

	public GameObject latestTriggerTextGo;

	public GameObject unlockNumRoot;

	public TextMeshProUGUI unlockNumText;

	public GameObject noTutorialRoot;

	public TextMeshProUGUI noTutorialText;

	public GameObject allNoTutorialTextRoot;

	public GameObject typeNoTutorialTextRoot;

	[SerializeField]
	private Dictionary<int, List<RedDotItem>> _redDotItems;

	public List<int> typeLocalizeId;

	public ItemUIComponentBase reward;

	public ViewControlRoot viewPortControlRoot;

	public ViewControlLayer viewPortControlLayer;

	public CanvasGroup bottomPromptRoot;

	[SerializeField]
	private float scrollSpeed = 2f;

	public OperateBtnPrompt switchPageUpPrompt;

	public OperateBtnPrompt switchPageDownPrompt;

	public OperateBtnPrompt switchPageLeftPrompt;

	public OperateBtnPrompt switchPageRightPrompt;

	public OperateBtnPrompt triggerInputFieldPrompt;

	public OperateBtnPrompt inputFieldSubmitPrompt;

	public OperateBtnPrompt rightScrollPrompt;

	private bool _initJumpState;

	private const int SEARCHRESULT = 1010;

	private const int SEARCHTEXTISNULL = 2278;

	private TutorialCell _curSelectCell;

	private bool _inputTriggerInputField;

	private bool _rightCanScroll;

	private int _selectToggleIndex;

	private float _rightStickInput;

	private List<TutorialModel.TutorialData> curShowTutorialDataList;

	private int curShowType;

	public const int ShowAll = 0;

	private TutorialModel.TutorialData curShowTutorialData;

	private int curShowIndex = -1;

	private string searchText;

	private string preSearchText;

	private bool _isSearching;

	private bool _isClearSearch;

	public bool inputTriggerInputField => _inputTriggerInputField;

	public bool rightCanScroll => _rightCanScroll;

	public int selectToggleIndex => _selectToggleIndex;

	public List<TutorialModel.TutorialData> CurShowTutorialDataList => curShowTutorialDataList;

	public int CurShowType => curShowType;

	public bool IsShowAll => curShowType == 0;

	public int ShowDataLastIndex
	{
		get
		{
			List<TutorialModel.TutorialData> list = curShowTutorialDataList;
			if (list == null || list.Count <= 0)
			{
				return 0;
			}
			return curShowTutorialDataList.Count - 1;
		}
	}

	public TutorialModel.TutorialData CurShowTutorialData
	{
		get
		{
			return curShowTutorialData;
		}
		set
		{
			curShowTutorialData = value;
		}
	}

	public int CurShowIndex
	{
		get
		{
			return curShowIndex;
		}
		set
		{
			curShowIndex = value;
		}
	}

	public string SearchText => searchText;

	public bool isSearching => _isSearching;

	protected override void AddEventListener()
	{
		inputField.onValueChanged.RemoveAllListeners();
		inputField.onValueChanged.AddListener(OnInputFieldValueChanged);
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
		m_data = uiViewData as GraphicGuideViewData;
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		unlockNumText.SetText("{0:0}", Model<TutorialModel>.Interface.allTutorialCount);
		InitToggleGroupRedDot();
		if (m_data != null && m_data.jumpGuideId != 0)
		{
			GuideTutorial data = CoreUtils.GetData(m_data.jumpGuideId, RuntimeConfigs.data.guideTutorials);
			toggleGroup.SetAllToggleOff();
			int selectIndex = ((data.tutorialType > 2) ? (data.tutorialType - 1) : data.tutorialType);
			toggleGroup.Init(selectIndex);
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
				text = RedDotPathDefine.TutorialUnReadAll;
				break;
			case 1:
				text = RedDotPathDefine.TutorialUnReadBattle;
				break;
			case 2:
				text = RedDotPathDefine.TutorialUnReadSystem;
				break;
			case 3:
				text = RedDotPathDefine.TutorialUnReadExplore;
				break;
			}
			if (string.IsNullOrEmpty(text) || !_redDotItems.TryGetValue(i, out var value))
			{
				continue;
			}
			foreach (RedDotItem item in value)
			{
				item.InitRedDot(text);
			}
		}
	}

	protected override void PlayOpenAnimation()
	{
		base.PlayOpenAnimation();
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Database/Open");
		betterAnimation.GetSequence("Show").OnComplete((AnimationBuilder _) =>
		{
			OpenEffectFinishNew();
		}).Play();
	}

	protected override void OpenEffectCallback()
	{
		base.OpenEffectCallback();
	}

	protected override void UnInit()
	{
		base.UnInit();
		if (Model<TutorialModel>.HasInstance())
		{
			Model<TutorialModel>.Interface.ReadTutorialReq();
		}
		ClearInputField();
		for (int i = 0; i < toggles.Length; i++)
		{
			GameObject gameObject = toggles[i];
			if (!gameObject.gameObject.activeInHierarchy)
			{
				gameObject.gameObject.SetActive(value: true);
			}
		}
		tutorialCellScrollRect.ClearCells();
		_curSelectCell = null;
		_initJumpState = false;
		tutorialInfo.UnInit();
		viewPortControlLayer?.UnFocus();
		toggleGroup.SetAllToggleOff();
		GuideTutorialEvent evt = EventTrackSolver.Instance.GetEvt<GuideTutorialEvent>();
		evt.op = 2;
		evt.type = (int)curShowTutorialData.type;
		evt.tutorialId = curShowTutorialData.id;
		evt.isRednote = false;
		EventTrackSolver.Instance.Dispatch(evt);
	}

	protected override void PlayCloseAnimation()
	{
		base.PlayCloseAnimation();
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

	public void SelectToggle(int index)
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Database/Left_Click");
		int selectedIndex = 0;
		int num = 0;
		_selectToggleIndex = index;
		if (index != 0)
		{
			int num2 = 1;
			foreach (TutorialType value in RuntimeConfigs.data.tutorialTypes.Values)
			{
				if (num2 == index)
				{
					num = value.id;
					break;
				}
				num2++;
			}
		}
		curShowType = num;
		Model<TutorialModel>.Interface.ResortAllTutorial();
		if (_isSearching)
		{
			if (!IsShowAll)
			{
				curShowTutorialDataList = (from tutorialData in Model<TutorialModel>.Interface.GetOneTypeTutorial((TutorialModel.TutorialType)num)
					where LocalizationSettings.StringDatabase.GetLocalizedString(tutorialData.table, tutorialData.localizeId, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null).Contains(searchText)
					select tutorialData).ToList();
			}
			if (curShowTutorialDataList.Count == 0)
			{
				SetHasTutorial(hasTutorial: false);
				return;
			}
		}
		else if (num == 0)
		{
			curShowTutorialDataList = Model<TutorialModel>.Interface.GetAllTutorial();
		}
		else
		{
			curShowTutorialDataList = Model<TutorialModel>.Interface.GetOneTypeTutorial((TutorialModel.TutorialType)num);
		}
		if (!_isSearching)
		{
			typeTitleLocalize.StringReference.TableEntryReference = typeLocalizeId[num];
		}
		if (!_initJumpState)
		{
			_initJumpState = true;
			if (m_data != null && m_data.jumpGuideId != 0)
			{
				selectedIndex = curShowTutorialDataList.FindIndex((TutorialModel.TutorialData i) => i.id == m_data.jumpGuideId);
			}
		}
		else if (_isClearSearch || _isSearching)
		{
			selectedIndex = GetIndexByTutorialData(curShowTutorialData);
		}
		RefreshTutorialCell(selectedIndex);
		if (MonoECS.instance.InputMode != DeviceInputMode.TouchScreen)
		{
			SetBottomPromptRootActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
			if (MonoECS.instance.InputMode == DeviceInputMode.Gamepad)
			{
				RefreshScrollViewSelection();
				RefreshBtnPrompt();
			}
		}
	}

	private void RefreshTutorialCell(int selectedIndex = 0)
	{
		List<TutorialModel.TutorialData> list = curShowTutorialDataList;
		if (list != null && list.Count > 0)
		{
			SetHasTutorial(hasTutorial: true);
			curShowTutorialData = null;
			curShowIndex = -1;
			_curSelectCell = null;
			tutorialCellScrollRect.ClearCells();
			tutorialCellScrollRect.totalCount = curShowTutorialDataList.Count;
			tutorialCellScrollRect.RefillCells();
			SelectTutorialCell(GetTutorialDataByIndex(selectedIndex), fromSelectToggle: true);
			if (_isClearSearch)
			{
				return;
			}
			for (int i = 0; i < tutorialCellScrollRect.Children.Count; i++)
			{
				TutorialCell component = tutorialCellScrollRect.Children[i].GetComponent<TutorialCell>();
				if (component != null)
				{
					component.PlayCustomAnimation((float)component.index * tutorialCellShowDuration);
				}
			}
		}
		else
		{
			tutorialCellScrollRect.totalCount = 0;
			tutorialCellScrollRect.ClearCells();
			SetHasTutorial(hasTutorial: false);
		}
	}

	public void SetCurSelectCell(TutorialCell tutorialCell)
	{
		_curSelectCell = tutorialCell;
	}

	public TutorialModel.TutorialData GetTutorialDataByIndex(int index)
	{
		if (index < 0 || index >= curShowTutorialDataList.Count)
		{
			return null;
		}
		return curShowTutorialDataList[index];
	}

	public TutorialModel.TutorialData GetTutorialDataById(int tutorialId)
	{
		return curShowTutorialDataList.FirstOrDefault((TutorialModel.TutorialData data) => data.id == tutorialId);
	}

	public int GetIndexByTutorialData(TutorialModel.TutorialData data)
	{
		if (curShowTutorialDataList.Contains(data))
		{
			return curShowTutorialDataList.IndexOf(data);
		}
		return 0;
	}

	public TutorialCell GetCurrentSelectedTutorialCell()
	{
		if (!(_curSelectCell != null) || !_curSelectCell.isActiveAndEnabled)
		{
			return GetCurSelectCell(curShowTutorialData);
		}
		return _curSelectCell;
	}

	public void SelectTutorialCell(TutorialModel.TutorialData tutorialData, bool fromSelectToggle = false)
	{
		if (tutorialData != null)
		{
			TutorialCell tutorialCell = tutorialCellScrollRect.GetItem(curShowIndex) as TutorialCell;
			if (tutorialCell != null && tutorialCell.isActiveAndEnabled)
			{
				tutorialCell.PlayOff(fromSelectToggle);
			}
			int indexByTutorialData = GetIndexByTutorialData(tutorialData);
			TutorialCell tutorialCell2 = tutorialCellScrollRect.GetItem(indexByTutorialData) as TutorialCell;
			if (tutorialCell2 != null && tutorialCell2.isActiveAndEnabled)
			{
				tutorialCell2.PlayOn(fromSelectToggle);
				SetCurSelectCell(tutorialCell2);
			}
			else
			{
				SetCurSelectCell(null);
			}
			curShowIndex = indexByTutorialData;
			curShowTutorialData = tutorialData;
			tutorialInfo.Init(tutorialData);
			if (tutorialCell2 == null || !tutorialCell2.isActiveAndEnabled)
			{
				tutorialCellScrollRect.ScrollToCell(indexByTutorialData, 0f);
			}
		}
	}

	public void UpdateCurShowTutorialData(int tutorialId, int readTs)
	{
		TutorialModel.TutorialData tutorialDataById = GetTutorialDataById(tutorialId);
		if (tutorialDataById != null)
		{
			tutorialDataById.FirstReadTs = readTs;
			if (tutorialCellScrollRect.GetItem(curShowTutorialDataList.IndexOf(tutorialDataById)) is TutorialCell tutorialCell)
			{
				tutorialCell.UpdateRedDot();
			}
		}
	}

	public void OnInputFieldValueChanged(string search)
	{
		searchText = search;
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
		switchPageUpPrompt.SetVisible(vis: false);
		switchPageDownPrompt.SetVisible(vis: false);
		triggerInputFieldPrompt.SetVisible(vis: false);
		inputFieldSubmitPrompt.SetVisible(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		clearInputFieldBtn.gameObject.SetActive(value: true);
		searchBtn.gameObject.SetActive(value: false);
		if (searchText != preSearchText)
		{
			curShowTutorialDataList = (from tutorialData in Model<TutorialModel>.Interface.GetAllTutorial()
				where LocalizationSettings.StringDatabase.GetLocalizedString(tutorialData.table, tutorialData.localizeId, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null).Contains(result)
				select tutorialData).ToList();
			preSearchText = searchText;
			typeTitleLocalize.StringReference.TableEntryReference = 1010L;
			Model<TutorialModel>.Interface.GetContainsSearchTextTutorialTypeList(result, out var containsTutorialTypeList);
			if (containsTutorialTypeList.Count == 1)
			{
				toggles.ForEach((GameObject i) =>
				{
					i.gameObject.SetActive(value: false);
				});
				SetHasTutorial(hasTutorial: false);
				UntriggerInputField();
				return;
			}
			if (containsTutorialTypeList.Count > 0)
			{
				for (int num = 0; num < toggles.Length; num++)
				{
					int item = ((num > 1) ? (num + 1) : num);
					toggles[num].gameObject.SetActive(containsTutorialTypeList.Contains(item));
				}
			}
			toggleGroup.SetAllToggleOff();
			toggleGroup.Init();
		}
		UntriggerInputField();
	}

	private void ClearInputFieldEvent()
	{
		ClearInputField();
		_isClearSearch = true;
		for (int i = 0; i < toggles.Length; i++)
		{
			GameObject gameObject = toggles[i];
			if (!gameObject.gameObject.activeInHierarchy)
			{
				gameObject.gameObject.SetActive(value: true);
			}
		}
		toggleGroup.SetAllToggleOff();
		int selectIndex = ((curShowType > 2) ? (curShowType - 1) : curShowType);
		toggleGroup.Init(selectIndex);
		_isClearSearch = false;
		RefreshBtnPrompt();
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

	private void UpdateSubTitle()
	{
		if (!string.IsNullOrEmpty(searchText))
		{
			ShowSubTitleSearchResult();
		}
		else if (curShowType == 0)
		{
			if (curShowTutorialDataList.Any())
			{
				ShowSubTitleLatestTrigger();
			}
			else
			{
				HideSubTitle();
			}
		}
		else
		{
			HideSubTitle();
		}
	}

	private void ShowSubTitleSearchResult()
	{
		subTitleSlash.SetActive(value: true);
		searchResultTextGo.SetActive(value: true);
		searchBoard.SetActive(value: true);
		latestTriggerTextGo.SetActive(value: false);
	}

	private void ShowSubTitleLatestTrigger()
	{
		subTitleSlash.SetActive(value: true);
		searchResultTextGo.SetActive(value: false);
		searchBoard.SetActive(value: true);
		latestTriggerTextGo.SetActive(value: true);
	}

	private void HideSubTitle()
	{
		subTitleSlash.SetActive(value: false);
		searchResultTextGo.SetActive(value: false);
		searchBoard.SetActive(value: false);
		latestTriggerTextGo.SetActive(value: false);
	}

	public void SetHasTutorial(bool hasTutorial)
	{
		tutorialCellScrollRect.gameObject.SetActive(hasTutorial);
		tutorialInfo.gameObject.SetActive(hasTutorial);
		noTutorialRoot.SetActive(!hasTutorial);
		if (hasTutorial)
		{
			return;
		}
		if (!string.IsNullOrEmpty(searchText))
		{
			allNoTutorialTextRoot.SetActive(value: false);
			typeNoTutorialTextRoot.SetActive(value: true);
			if (searchText.Length > searchLengthLimit)
			{
				string text = searchText.Substring(0, 10);
				text += "...";
				noTutorialText.text = text;
			}
			else
			{
				noTutorialText.text = searchText;
			}
		}
		else if (curShowType == 0)
		{
			allNoTutorialTextRoot.SetActive(value: true);
			typeNoTutorialTextRoot.SetActive(value: false);
		}
		else
		{
			allNoTutorialTextRoot.SetActive(value: false);
			typeNoTutorialTextRoot.SetActive(value: true);
			noTutorialText.text = LocalizationSettings.StringDatabase.GetLocalizedString(LocalizationUtility.localizeTableName_Common, typeLocalizeId[curShowType], LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null);
		}
	}

	public void SelectTab(int index)
	{
		if (index >= 0 && index < toggleGroup.ToggleCount)
		{
			ActToggle firstActiveToggle = toggleGroup.GetFirstActiveToggle();
			if (!(firstActiveToggle != null) || firstActiveToggle.Index != index)
			{
				toggleGroup.SetAllToggleOff();
				toggleGroup.Init(index);
			}
		}
	}

	protected override void OnInputDeviceChange(DeviceInputMode type)
	{
		if (UIController.State == UIState.Opened)
		{
			if (type == DeviceInputMode.Gamepad && _inputTriggerInputField)
			{
				inputField?.ActivateInputField();
			}
			if (!_inputTriggerInputField)
			{
				RefreshScrollViewSelection();
			}
			SetBottomPromptRootActive(type == DeviceInputMode.Gamepad);
			RefreshBtnPrompt();
			tutorialInfo.RefreshDescribe();
		}
	}

	public void InputTriggerInputField()
	{
		Singleton<GameManager>.instance.audioManager.PlaySound("event:/UI/Interface/Database/Search");
		if (!_isSearching && !_inputTriggerInputField && !inputField.isFocused)
		{
			switchPageUpPrompt.SetVisible(vis: false);
			switchPageDownPrompt.SetVisible(vis: false);
			triggerInputFieldPrompt.SetVisible(vis: false);
			inputFieldSubmitPrompt.SetVisible(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
			((IOperatePromptIconCollectionProvider)this).UnInitCollection();
			_inputTriggerInputField = true;
			_rightCanScroll = false;
			inputField.ActivateInputField();
			inputField.Select();
			inputField.MoveTextEnd(shift: false);
		}
	}

	public void UntriggerInputField()
	{
		if (!_inputTriggerInputField)
		{
			inputField.DeactivateInputField();
			return;
		}
		_inputTriggerInputField = false;
		inputField.DeactivateInputField();
		RefreshScrollViewSelection();
		((IOperatePromptIconCollectionProvider)this).InitCollection();
		SetBottomPromptRootActive(MonoECS.instance.InputMode == DeviceInputMode.Gamepad);
		RefreshBtnPrompt();
		tutorialInfo.RefreshDescribe();
	}

	public void OnButtonNorthClick()
	{
		if (_inputTriggerInputField || _isSearching)
		{
			if (_isSearching)
			{
				ClearInputFieldEvent();
			}
			else
			{
				OnSearchSubmit(searchText);
			}
		}
	}

	public void OnRightStickScroll(Vector2 value)
	{
		_rightStickInput = (_rightCanScroll ? value.y : 0f);
	}

	private void Update()
	{
		ExecuteRightStickScroll();
	}

	private void ExecuteRightStickScroll()
	{
		if (_rightCanScroll)
		{
			float num = tutorialInfo.scrollRect?.verticalNormalizedPosition ?? 0f;
			num += _rightStickInput * scrollSpeed * Time.unscaledDeltaTime;
			if (tutorialInfo != null && tutorialInfo.scrollRect != null)
			{
				tutorialInfo.scrollRect.verticalNormalizedPosition = Mathf.Clamp01(num);
			}
		}
	}

	public void RefreshBtnPrompt()
	{
		bool flag = MonoECS.instance.InputMode == DeviceInputMode.Gamepad;
		int activeToggleCount = toggleGroup.GetActiveToggleCount();
		switchPageUpPrompt.SetVisible(!_inputTriggerInputField && activeToggleCount > 1);
		switchPageDownPrompt.SetVisible(!_inputTriggerInputField && activeToggleCount > 1);
		UpdateRightScrollPromptActive();
		int curInfoIndex = tutorialInfo.curInfoIndex;
		int lastInfoIndex = tutorialInfo.lastInfoIndex;
		SetTutorialInfoBtnPromptActive(curInfoIndex, lastInfoIndex);
		triggerInputFieldPrompt.SetVisible(!_inputTriggerInputField && !_isSearching);
		inputFieldSubmitPrompt.SetVisible(flag && (_inputTriggerInputField || _isSearching));
	}

	public void SetTutorialInfoBtnPromptActive(int curIndex, int LastIndex)
	{
		switchPageLeftPrompt.SetVisible(!_inputTriggerInputField && curIndex > 0);
		switchPageRightPrompt.SetVisible(!_inputTriggerInputField && curIndex < LastIndex);
	}

	private void SetBottomPromptRootActive(bool active)
	{
		bottomPromptRoot.alpha = (active ? 1 : 0);
	}

	public void RefreshScrollViewSelection()
	{
		GetCurSelectCell(curShowTutorialData);
		if (viewPortControlLayer != null)
		{
			viewPortControlLayer.DefaultSelect = _curSelectCell?.cellSelectable;
			viewPortControlLayer.UnFocus();
		}
		ViewControlRoot viewControlRoot = viewPortControlRoot;
		if ((object)viewControlRoot != null && !viewControlRoot.ReFocus())
		{
			viewPortControlLayer?.Focus();
		}
	}

	private TutorialCell GetCurSelectCell(TutorialModel.TutorialData curSelectData)
	{
		if (curSelectData == null)
		{
			SetCurSelectCell(null);
			return null;
		}
		int indexByTutorialData = GetIndexByTutorialData(curSelectData);
		TutorialCell tutorialCell = tutorialCellScrollRect.GetItem(indexByTutorialData) as TutorialCell;
		SetCurSelectCell(tutorialCell);
		return tutorialCell;
	}

	public void UpdateRightScrollPromptActive()
	{
		Canvas.ForceUpdateCanvases();
		List<TutorialModel.TutorialData> list = curShowTutorialDataList;
		_rightCanScroll = list != null && list.Count > 0 && tutorialInfo.scrollRect.content.rect.height > tutorialInfo.scrollRect.viewport.rect.height;
		rightScrollPrompt.SetVisible(!_inputTriggerInputField && _rightCanScroll);
	}
}
