using System;
using UnityEngine;

namespace P08.Gamepad;

[Serializable]
public class ButtonParameter
{
	public En_ButtonType m_buttonType;

	public string m_value = string.Empty;

	public bool m_isAxis;

	public ButtonMap GetButtonMap()
	{
		bool num = m_value.EndsWith('P');
		bool flag = m_value.EndsWith('N');
		if (num | flag)
		{
			return new ButtonMap
			{
				m_buttonType = m_buttonType,
				m_listenType = En_ListenType.Axis,
				m_keyCode = KeyCode.None,
				m_name = m_value,
				m_isNegative = flag,
				m_isAxis = m_isAxis
			};
		}
		if (int.TryParse(m_value, out var result))
		{
			return new ButtonMap
			{
				m_buttonType = m_buttonType,
				m_listenType = En_ListenType.KeyCode,
				m_keyCode = (KeyCode)result,
				m_name = m_value,
				m_isNegative = flag,
				m_isAxis = m_isAxis
			};
		}
		return new ButtonMap
		{
			m_buttonType = m_buttonType,
			m_listenType = En_ListenType.None,
			m_keyCode = KeyCode.None,
			m_name = m_value,
			m_isNegative = false,
			m_isAxis = m_isAxis
		};
	}
}
