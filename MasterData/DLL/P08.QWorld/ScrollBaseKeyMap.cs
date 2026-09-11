using System.Collections.Generic;
using System.Linq;
using P08.Gamepad;
using UnityEngine;

[RequireComponent(typeof(HIDInputPage))]
public class ScrollBaseKeyMap : MonoBehaviour
{
	public En_ButtonType m_scrollUp;

	public En_ButtonType m_scrollDown;

	public En_ButtonType m_mouseScrollUp;

	public En_ButtonType m_mouseScrollDown;

	public bool m_needSaveState;

	private int m_selectIndex;

	private HIDInputPage m_inputPage;

	private bool m_dirty;

	private int m_mouseSelectIndex = -1;

	private List<ScrollItemKeyMap> m_scrollItemList = new List<ScrollItemKeyMap>();

	private Dictionary<En_ButtonType, QWKeyValue> m_cameraKeyValues = new Dictionary<En_ButtonType, QWKeyValue>();

	public bool m_useAlphaNumKey;

	private En_GamepadType m_curGamepadType;

	public int selectIndex
	{
		get
		{
			return m_selectIndex;
		}
		set
		{
			m_selectIndex = value;
		}
	}

	public List<ScrollItemKeyMap> scrollItemList => m_scrollItemList;

	public void Awake()
	{
		AwakeInit();
		HIDInputPage component = GetComponent<HIDInputPage>();
		if (m_scrollUp != En_ButtonType.None)
		{
			m_cameraKeyValues[m_scrollUp] = new QWKeyValue(component, m_scrollUp);
		}
		if (m_scrollDown != En_ButtonType.None)
		{
			m_cameraKeyValues[m_scrollDown] = new QWKeyValue(component, m_scrollDown);
		}
		if (m_mouseScrollUp != En_ButtonType.None)
		{
			m_cameraKeyValues[m_mouseScrollUp] = new QWKeyValue(component, m_mouseScrollUp);
		}
		if (m_mouseScrollDown != En_ButtonType.None)
		{
			m_cameraKeyValues[m_mouseScrollDown] = new QWKeyValue(component, m_mouseScrollDown);
		}
		m_inputPage = component;
	}

	public void OnEnable()
	{
		m_mouseSelectIndex = -1;
		if (!m_needSaveState)
		{
			m_selectIndex = 0;
		}
		RefreshItemList();
		foreach (QWKeyValue value in m_cameraKeyValues.Values)
		{
			value.OnEnable();
		}
	}

	public void OnDisable()
	{
		foreach (QWKeyValue value in m_cameraKeyValues.Values)
		{
			value.OnDisable();
		}
	}

	private void Start()
	{
		m_mouseSelectIndex = -1;
		ResetSelectItem();
	}

	private void Update()
	{
		En_GamepadType gamepadType = GamepadManager.Instance.GetGamepadType();
		if (m_curGamepadType != gamepadType)
		{
			m_curGamepadType = gamepadType;
			m_dirty = true;
		}
		if (m_scrollUp != En_ButtonType.None && m_cameraKeyValues[m_scrollUp].GetKeyDown() && m_mouseSelectIndex == -1)
		{
			SelectPrevItem();
		}
		if (m_scrollDown != En_ButtonType.None && m_cameraKeyValues[m_scrollDown].GetKeyDown() && m_mouseSelectIndex == -1)
		{
			SelectNextItem();
		}
		if (m_mouseScrollUp != En_ButtonType.None && m_cameraKeyValues[m_mouseScrollUp].GetKeyValue() != 0f)
		{
			SelectPrevItem();
		}
		if (m_mouseScrollDown != En_ButtonType.None && m_cameraKeyValues[m_mouseScrollDown].GetKeyValue() != 0f)
		{
			SelectNextItem();
		}
		if (m_dirty)
		{
			if (!m_needSaveState)
			{
				m_selectIndex = 0;
			}
			m_scrollItemList = GetItemList();
			RefreshItemList();
			RefreshInputPage();
			m_dirty = false;
		}
	}

	public void ResetSelectItem()
	{
		m_dirty = true;
	}

	public void SelectIndexItem(int index)
	{
		m_selectIndex = index;
		RefreshItemList();
	}

	public void PointerIndexItem(int index)
	{
		m_mouseSelectIndex = index;
		SelectIndexItem(index);
	}

	public void ExitPointerIndexItem(int index)
	{
		if (m_mouseSelectIndex == index)
		{
			m_mouseSelectIndex = -1;
		}
	}

	public virtual void SelectNextItem()
	{
		if (m_selectIndex < m_scrollItemList.Count - 1)
		{
			m_selectIndex++;
			RefreshItemList();
		}
	}

	public virtual void SelectPrevItem()
	{
		if (m_selectIndex > 0)
		{
			m_selectIndex--;
			RefreshItemList();
		}
	}

	private List<ScrollItemKeyMap> GetItemList()
	{
		return (from t in base.gameObject.GetComponentsInChildren<ScrollItemKeyMap>()
			where t.gameObject.activeSelf && t.transform.parent == base.transform
			select t).ToList();
	}

	public virtual void RefreshItemList()
	{
		for (int i = 0; i < m_scrollItemList.Count; i++)
		{
			m_scrollItemList[i].ChangeSelectedState(i == m_selectIndex, i, m_useAlphaNumKey && GamepadManager.Instance.IsUsingKeyboard());
		}
		AdjustPosition();
	}

	private void RefreshInputPage()
	{
		bool flag = m_scrollItemList.Count > 0;
		if (m_inputPage != null)
		{
			m_inputPage.enabled = flag;
		}
		flag = m_scrollItemList.Count > 1;
		m_inputPage?.SetRemapVisibility(flag && (!m_useAlphaNumKey || !GamepadManager.Instance.IsUsingKeyboard()));
	}

	public virtual void AwakeInit()
	{
	}

	public virtual void AdjustPosition()
	{
	}
}
