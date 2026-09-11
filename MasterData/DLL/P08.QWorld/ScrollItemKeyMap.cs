using System.Collections.Generic;
using ControllerExSpace;
using LuaInterface;
using P08.Gamepad;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class ScrollItemKeyMap : MonoBehaviour, IPointerEnterHandler, IEventSystemHandler, IPointerClickHandler, IPointerExitHandler, IPointerDownHandler, IPointerUpHandler
{
	private enum SELECTED_STATE_ENUM
	{
		NORMAL,
		SELECT,
		HOVER,
		CLICK
	}

	public bool m_defaultClick;

	private Button m_button;

	private ControllerExCollection m_controllerEx;

	private HIDInputPage m_inputPage;

	private bool m_useAlphaNumKey;

	private bool m_isSelect;

	private bool m_isInit;

	private List<SELECTED_STATE_ENUM> m_selectedStateList;

	private bool m_isInClickArea;

	private int m_index;

	private En_GamepadType m_curGamepadType;

	private void Awake()
	{
		m_controllerEx = GetComponent<ControllerExCollection>();
		m_inputPage = GetComponent<HIDInputPage>();
		m_button = base.gameObject.GetComponent<Button>();
		m_selectedStateList = new List<SELECTED_STATE_ENUM>();
	}

	private void Start()
	{
		NotifyKeyMap();
	}

	[NoToLua]
	public void ChangeSelectedState(bool state, int index, bool useAlphaNumKey)
	{
		m_index = index;
		En_GamepadType gamepadType = GamepadManager.Instance.GetGamepadType();
		m_useAlphaNumKey = useAlphaNumKey;
		if (m_isInit && m_isSelect == state && m_curGamepadType == gamepadType)
		{
			return;
		}
		m_isInit = true;
		if (m_selectedStateList.Contains(SELECTED_STATE_ENUM.SELECT) && !state)
		{
			m_selectedStateList.Remove(SELECTED_STATE_ENUM.SELECT);
		}
		else if ((!m_selectedStateList.Contains(SELECTED_STATE_ENUM.SELECT) & state) && !m_useAlphaNumKey)
		{
			m_selectedStateList.Add(SELECTED_STATE_ENUM.SELECT);
		}
		SetSelectedState();
		if (m_inputPage != null)
		{
			if (useAlphaNumKey)
			{
				m_inputPage.enabled = true;
				m_inputPage?.SetRemapVisibility(visible: true);
				m_inputPage.ReplaceNumButtonType(index);
			}
			else
			{
				m_inputPage.enabled = state;
				m_inputPage?.SetRemapVisibility(state);
				m_inputPage.RevertButtonType();
			}
		}
		if (state && m_defaultClick)
		{
			m_button?.onClick.Invoke();
		}
		m_isSelect = state;
		m_curGamepadType = gamepadType;
		m_inputPage?.RefreshActionUI();
	}

	private void OnEnable()
	{
		NotifyKeyMap();
	}

	private void OnDisable()
	{
		NotifyKeyMap();
		m_selectedStateList.Clear();
		m_selectedStateList.Add((m_index == 0) ? SELECTED_STATE_ENUM.SELECT : SELECTED_STATE_ENUM.NORMAL);
		SetSelectedState();
	}

	private void NotifyKeyMap()
	{
		if (base.transform.parent != null)
		{
			base.transform.parent.GetComponent<ScrollBaseKeyMap>()?.ResetSelectItem();
		}
	}

	public void OnPointerClick(PointerEventData eventData)
	{
		if (base.transform.parent != null)
		{
			base.transform.parent.GetComponent<ScrollBaseKeyMap>()?.PointerIndexItem(m_index);
		}
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		m_selectedStateList.Add(SELECTED_STATE_ENUM.CLICK);
		SetSelectedState();
	}

	public void OnPointerUp(PointerEventData eventData)
	{
		m_selectedStateList.Remove(SELECTED_STATE_ENUM.CLICK);
		SetSelectedState();
		if (base.transform.parent != null)
		{
			base.transform.parent.GetComponent<ScrollBaseKeyMap>()?.ExitPointerIndexItem(m_index);
		}
	}

	public void OnPointerEnter(PointerEventData eventData)
	{
		m_isInClickArea = true;
		m_selectedStateList.Add(SELECTED_STATE_ENUM.HOVER);
		SetSelectedState();
	}

	public void OnPointerExit(PointerEventData eventData)
	{
		m_isInClickArea = false;
		if (base.transform.parent != null)
		{
			base.transform.parent.GetComponent<ScrollBaseKeyMap>()?.ExitPointerIndexItem(m_index);
		}
		m_selectedStateList.Remove(SELECTED_STATE_ENUM.HOVER);
		SetSelectedState();
	}

	private void SetSelectedState()
	{
		if (GamepadManager.Instance.IsInputGamepadType(En_GamepadType.None))
		{
			m_controllerEx?.GetController("selected")?.SetSelectedState("false");
		}
		else if (m_selectedStateList.Contains(SELECTED_STATE_ENUM.CLICK))
		{
			m_controllerEx?.GetController("selected")?.SetSelectedState("click");
		}
		else if (m_selectedStateList.Contains(SELECTED_STATE_ENUM.SELECT))
		{
			if (m_useAlphaNumKey)
			{
				m_controllerEx?.GetController("selected")?.SetSelectedState("false");
			}
			else
			{
				m_controllerEx?.GetController("selected")?.SetSelectedState("true");
			}
		}
		else if (m_selectedStateList.Contains(SELECTED_STATE_ENUM.HOVER))
		{
			m_controllerEx?.GetController("selected")?.SetSelectedState("hover");
		}
		else
		{
			m_controllerEx?.GetController("selected")?.SetSelectedState("false");
		}
	}
}
