using System;
using System.Collections.Generic;
using System.Linq;
using UnityEngine.EventSystems;

namespace UnityEngine.UI;

[AddComponentMenu("UI/Toggle Group", 31)]
[DisallowMultipleComponent]
public class ToggleGroup : UIBehaviour
{
	[SerializeField]
	private bool m_AllowSwitchOff;

	protected List<Toggle> m_Toggles = new List<Toggle>();

	public bool allowSwitchOff
	{
		get
		{
			return m_AllowSwitchOff;
		}
		set
		{
			m_AllowSwitchOff = value;
		}
	}

	protected ToggleGroup()
	{
	}

	protected override void Start()
	{
		EnsureValidState();
		base.Start();
	}

	protected override void OnEnable()
	{
		EnsureValidState();
		base.OnEnable();
	}

	private void ValidateToggleIsInGroup(Toggle toggle)
	{
		if (toggle == null || !m_Toggles.Contains(toggle))
		{
			throw new ArgumentException(string.Format("Toggle {0} is not part of ToggleGroup {1}", new object[2] { toggle, this }));
		}
	}

	public void NotifyToggleOn(Toggle toggle, bool sendCallback = true)
	{
		ValidateToggleIsInGroup(toggle);
		for (int i = 0; i < m_Toggles.Count; i++)
		{
			if (!(m_Toggles[i] == toggle))
			{
				if (sendCallback)
				{
					m_Toggles[i].isOn = false;
				}
				else
				{
					m_Toggles[i].SetIsOnWithoutNotify(value: false);
				}
			}
		}
	}

	public void UnregisterToggle(Toggle toggle)
	{
		if (m_Toggles.Contains(toggle))
		{
			m_Toggles.Remove(toggle);
		}
	}

	public void RegisterToggle(Toggle toggle)
	{
		if (!m_Toggles.Contains(toggle))
		{
			m_Toggles.Add(toggle);
		}
	}

	public void EnsureValidState()
	{
		if (!allowSwitchOff && !AnyTogglesOn() && m_Toggles.Count != 0)
		{
			m_Toggles[0].isOn = true;
			NotifyToggleOn(m_Toggles[0]);
		}
		IEnumerable<Toggle> enumerable = ActiveToggles();
		if (enumerable.Count() <= 1)
		{
			return;
		}
		Toggle firstActiveToggle = GetFirstActiveToggle();
		foreach (Toggle item in enumerable)
		{
			if (!(item == firstActiveToggle))
			{
				item.isOn = false;
			}
		}
	}

	public bool AnyTogglesOn()
	{
		return m_Toggles.Find((Toggle x) => x.isOn) != null;
	}

	public IEnumerable<Toggle> ActiveToggles()
	{
		return m_Toggles.Where((Toggle x) => x.isOn);
	}

	public Toggle GetFirstActiveToggle()
	{
		IEnumerable<Toggle> source = ActiveToggles();
		if (source.Count() <= 0)
		{
			return null;
		}
		return source.First();
	}

	public void SetAllTogglesOff(bool sendCallback = true)
	{
		bool flag = m_AllowSwitchOff;
		m_AllowSwitchOff = true;
		if (sendCallback)
		{
			for (int i = 0; i < m_Toggles.Count; i++)
			{
				m_Toggles[i].isOn = false;
			}
		}
		else
		{
			for (int j = 0; j < m_Toggles.Count; j++)
			{
				m_Toggles[j].SetIsOnWithoutNotify(value: false);
			}
		}
		m_AllowSwitchOff = flag;
	}
}
