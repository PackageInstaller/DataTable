using System;
using UnityEngine;

namespace P08.Gamepad;

[Serializable]
public class InputValue
{
	public En_ListenType m_listenType;

	public KeyCode m_keyCode;

	public string m_axisName = string.Empty;

	public int m_axisNameHash = -1;

	public float m_axisValue;

	public bool m_isKeyUp;

	public bool m_isKeyDown;

	public bool m_isKeyHeld;

	public bool isValid
	{
		get
		{
			if (!m_isKeyDown && !m_isKeyHeld)
			{
				return m_isKeyUp;
			}
			return true;
		}
	}

	public override bool Equals(object obj)
	{
		if (obj == null)
		{
			return false;
		}
		if (!(obj is InputValue inputValue))
		{
			return false;
		}
		if (inputValue.m_listenType == m_listenType && inputValue.m_keyCode == m_keyCode && inputValue.m_axisName == m_axisName && inputValue.m_axisValue == m_axisValue && inputValue.m_isKeyUp == m_isKeyUp && inputValue.m_isKeyDown == m_isKeyDown)
		{
			return inputValue.m_isKeyHeld == m_isKeyHeld;
		}
		return false;
	}

	public override int GetHashCode()
	{
		return base.GetHashCode();
	}

	internal void LostFocus()
	{
		m_isKeyUp = m_isKeyDown || m_isKeyHeld;
		m_isKeyDown = false;
		m_isKeyHeld = false;
		m_axisValue = 0f;
	}
}
