using System.Collections.Generic;
using System.Linq;
using ACT.Utility;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace ACT.UI;

public class ActToggleGroup : UIBehaviour
{
	private List<ActToggle> m_Toggles = new List<ActToggle>();

	[SerializeField]
	private float m_ClickInterval;

	private float m_LastClickTime;

	private bool _isProcessingClick;

	private ActToggle _lastClickedToggle;

	[SerializeField]
	private bool _dontResetIndexOnUnRegister;

	public float ClickInterval => m_ClickInterval;

	public int ToggleCount => m_Toggles.Count;

	protected ActToggleGroup()
	{
	}

	public void SetClickInterval(float interval)
	{
		m_ClickInterval = Mathf.Max(0f, interval);
	}

	public bool CanClick()
	{
		if (m_ClickInterval <= 0f)
		{
			return true;
		}
		float unscaledTime = Time.unscaledTime;
		if (unscaledTime - m_LastClickTime >= m_ClickInterval)
		{
			m_LastClickTime = unscaledTime;
			return true;
		}
		return false;
	}

	public void Init(int selectIndex = 0)
	{
		for (int i = 0; i < m_Toggles.Count; i++)
		{
			if (selectIndex != i)
			{
				m_Toggles[i].OnGroupInit(this, i, isOn: false);
			}
		}
		if (selectIndex >= 0 && selectIndex < m_Toggles.Count)
		{
			m_Toggles[selectIndex].OnGroupInit(this, selectIndex, isOn: true);
		}
	}

	public void Init(int selectIndex, float clickInterval)
	{
		SetClickInterval(clickInterval);
		Init(selectIndex);
	}

	public void SetToggleOn(ActToggle toggle)
	{
		if (CanClick())
		{
			SetToggleOnInternal(toggle, ignoreClickInterval: true);
		}
	}

	public void SetToggleOn(int index)
	{
		if (CanClick() && index < m_Toggles.Count && index >= 0)
		{
			ActToggle toggle = m_Toggles[index];
			SetToggleOnInternal(toggle, ignoreClickInterval: true);
		}
	}

	private void SetToggleOnInternal(ActToggle toggle, bool ignoreClickInterval)
	{
		if (toggle == null || !m_Toggles.Contains(toggle) || (_lastClickedToggle == toggle && _isProcessingClick) || (!ignoreClickInterval && !CanClick()))
		{
			return;
		}
		_isProcessingClick = true;
		_lastClickedToggle = toggle;
		try
		{
			foreach (ActToggle toggle2 in m_Toggles)
			{
				if (toggle2 != toggle && toggle2.IsOn)
				{
					toggle2.SetIsOnFromGroup(val: false);
				}
			}
			toggle.SetIsOnFromGroup(val: true);
		}
		finally
		{
			_isProcessingClick = false;
			_lastClickedToggle = null;
		}
	}

	public void SetToggleOnCall(int index, UnityAction<int> call)
	{
		if (index >= m_Toggles.Count)
		{
			return;
		}
		ActToggle actToggle = m_Toggles[index];
		if (call != null)
		{
			actToggle.onToggleOn.AddListener(() =>
			{
				call(index);
			});
		}
	}

	public void SetToggleRemoveOnCall(int index)
	{
		if (index < m_Toggles.Count)
		{
			m_Toggles[index].onToggleOn.RemoveAllListeners();
		}
	}

	public void SetAllToggleOff(bool ignoreClickInterval = false)
	{
		if (!ignoreClickInterval && !CanClick())
		{
			return;
		}
		_isProcessingClick = true;
		try
		{
			foreach (ActToggle toggle in m_Toggles)
			{
				if (toggle.IsOn)
				{
					toggle.SetIsOnFromGroup(val: false);
				}
			}
		}
		finally
		{
			_isProcessingClick = false;
		}
	}

	public void UnregisterToggle(ActToggle toggle)
	{
		if (!_dontResetIndexOnUnRegister && m_Toggles.Contains(toggle))
		{
			m_Toggles.Remove(toggle);
			for (int i = 0; i < m_Toggles.Count; i++)
			{
				m_Toggles[i].ResetIndex(i);
			}
		}
	}

	public int RegisterToggle(ActToggle toggle)
	{
		if (!m_Toggles.Contains(toggle))
		{
			m_Toggles.Add(toggle);
			return m_Toggles.IndexOf(toggle);
		}
		if (_dontResetIndexOnUnRegister)
		{
			return toggle.Index;
		}
		return -1;
	}

	public bool AnyTogglesOn()
	{
		return m_Toggles.Find((ActToggle x) => x.IsOn) != null;
	}

	public IEnumerable<ActToggle> ActiveToggles()
	{
		return m_Toggles.Where((ActToggle x) => x.IsOn);
	}

	public ActToggle GetFirstActiveToggle()
	{
		IEnumerable<ActToggle> source = ActiveToggles();
		if (source.Count() <= 0)
		{
			return null;
		}
		return source.First();
	}

	public int GetFirstActiveToggleIndex()
	{
		ActToggle firstActiveToggle = GetFirstActiveToggle();
		if (firstActiveToggle != null)
		{
			for (int i = 0; i < m_Toggles.Count; i++)
			{
				if (firstActiveToggle == m_Toggles[i])
				{
					return i;
				}
			}
		}
		return -1;
	}

	public ActToggle GetToggleByIndex(int index)
	{
		if (index > m_Toggles.GetLastIndex())
		{
			return null;
		}
		return m_Toggles[index];
	}

	public void PlayAllToggleAnim(bool isOn = false, string animName = "NormalShow")
	{
	}

	public void SetToggleActive(int index)
	{
		for (int i = 0; i < m_Toggles.Count; i++)
		{
			m_Toggles[i].gameObject.SetActive(i == index);
		}
	}

	public int GetActiveToggleCount()
	{
		return Enumerable.Count(m_Toggles, (ActToggle x) => x != null && x.gameObject.activeSelf);
	}
}
