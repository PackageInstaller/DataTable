using System.Collections.Generic;
using ACT.LocalizationExtension;
using ACT.UI.InputController;
using ACT.Utility;
using Cysharp.Threading.Tasks;
using UnityEngine;
using UnityEngine.EventSystems;

namespace ACT.UI;

public class SortSettingView : BaseUIView<SortSettingViewInputController>
{
	[SerializeField]
	private LocalizeTMP_Dropdown dropdown;

	public GamePadTipsComp gamePadGroup;

	private Dictionary<string, GamePadTipsAction> _allInputPrompt;

	private List<GamePadTipsAction> _tipsActions;

	private bool m_IsDropdownExpanded;

	private GameObject m_LastHighlightedOption;

	private void Awake()
	{
		dropdown.onValueChanged.AddListener(OnDropdownValueChanged);
	}

	protected override void OnUnityDestroy()
	{
		dropdown.onValueChanged.RemoveListener(OnDropdownValueChanged);
	}

	public override async UniTask PreInit()
	{
		await base.PreInit();
	}

	protected override void Init()
	{
		base.Init();
		dropdown.value = ServerPlayerPrefs.GetInt("Equip_SortSetting");
		m_IsDropdownExpanded = false;
		m_LastHighlightedOption = null;
		OnGamePadInit();
		ReBindBtnPrompt();
	}

	protected override void UnInit()
	{
		ClearDropdownOptionHighlight();
		m_IsDropdownExpanded = false;
		m_LastHighlightedOption = null;
		base.UnInit();
		ServerPlayerPrefs.Save();
	}

	private void OnDropdownValueChanged(int value)
	{
		ServerPlayerPrefs.SetInt("Equip_SortSetting", value);
		m_IsDropdownExpanded = false;
		ClearDropdownOptionHighlight();
	}

	public void OnGamePadBack()
	{
		Close();
	}

	public void OnGamePadConfirm()
	{
		if (!EventSystemHelper.Available || dropdown == null)
		{
			return;
		}
		if (!m_IsDropdownExpanded)
		{
			EventSystemHelper.SetSelectedGameObject(dropdown.gameObject);
			ExecuteEvents.Execute(dropdown.gameObject, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
			m_IsDropdownExpanded = true;
			RefreshDropdownOptionHighlight();
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (currentSelected != null)
		{
			ExecuteEvents.Execute(currentSelected, new BaseEventData(EventSystemHelper.Shared), (ISubmitHandler handler, BaseEventData data) =>
			{
				handler?.OnSubmit(data);
			});
			m_IsDropdownExpanded = false;
			ClearDropdownOptionHighlight();
		}
	}

	public void OnNavigate(Vector2 value)
	{
		if (m_IsDropdownExpanded && EventSystemHelper.Available && !(EventSystemHelper.CurrentSelected == null) && !(value == Vector2.zero))
		{
			MoveDirection moveDir = ((!(Mathf.Abs(value.y) >= Mathf.Abs(value.x))) ? ((value.x >= 0f) ? MoveDirection.Right : MoveDirection.Left) : ((value.y >= 0f) ? MoveDirection.Up : MoveDirection.Down));
			AxisEventData eventData = new AxisEventData(EventSystemHelper.Shared)
			{
				moveDir = moveDir
			};
			ExecuteEvents.Execute(EventSystemHelper.CurrentSelected, eventData, (IMoveHandler handler, BaseEventData data) =>
			{
				handler?.OnMove((AxisEventData)data);
			});
			RefreshDropdownOptionHighlight();
		}
	}

	private void RefreshDropdownOptionHighlight()
	{
		if (EventSystemHelper.CurrentSelected == null)
		{
			return;
		}
		GameObject currentSelected = EventSystemHelper.CurrentSelected;
		if (m_LastHighlightedOption != null && m_LastHighlightedOption != currentSelected)
		{
			ExecuteEvents.Execute(m_LastHighlightedOption, new PointerEventData(EventSystemHelper.Shared), (IDeselectHandler handler, BaseEventData data) =>
			{
				handler?.OnDeselect((PointerEventData)data);
			});
		}
		ExecuteEvents.Execute(currentSelected, new PointerEventData(EventSystemHelper.Shared), (ISelectHandler handler, BaseEventData data) =>
		{
			handler?.OnSelect((PointerEventData)data);
		});
		m_LastHighlightedOption = currentSelected;
	}

	private void ClearDropdownOptionHighlight()
	{
		if (!(m_LastHighlightedOption == null) && EventSystemHelper.Available)
		{
			ExecuteEvents.Execute(m_LastHighlightedOption, new PointerEventData(EventSystemHelper.Shared), (IPointerExitHandler handler, BaseEventData data) =>
			{
				handler?.OnPointerExit((PointerEventData)data);
			});
			m_LastHighlightedOption = null;
		}
	}

	private void OnGamePadInit()
	{
		_allInputPrompt = new Dictionary<string, GamePadTipsAction>
		{
			["UI/Confirm"] = new GamePadTipsAction
			{
				inputAction = "UI/Confirm",
				localizeKey = 13,
				localizeTable = "Common"
			},
			["UI/Back"] = new GamePadTipsAction
			{
				inputAction = "UI/Back",
				localizeKey = 606,
				localizeTable = "Common"
			}
		};
	}

	private void ReBindBtnPrompt()
	{
		if (!(gamePadGroup == null) && _allInputPrompt != null)
		{
			List<GamePadTipsAction> tipsActions = _tipsActions;
			if (tipsActions == null || tipsActions.Count <= 0)
			{
				_tipsActions = new List<GamePadTipsAction>();
			}
			gamePadGroup.ClearAllPrompts();
			_tipsActions.Clear();
			_tipsActions.Add(_allInputPrompt["UI/Confirm"]);
			_tipsActions.Add(_allInputPrompt["UI/Back"]);
			gamePadGroup.RegisterInputActions(_tipsActions);
		}
	}
}
