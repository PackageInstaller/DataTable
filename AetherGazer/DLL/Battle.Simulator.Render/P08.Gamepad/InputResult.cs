using System;
using System.Collections.Generic;
using UnityEngine;

namespace P08.Gamepad;

[Serializable]
public class InputResult
{
	public List<InputValue> m_inputValueList = new List<InputValue>();

	public override string ToString()
	{
		return JsonUtility.ToJson(this);
	}

	public string GetInfo()
	{
		string text = string.Empty;
		foreach (InputValue inputValue in m_inputValueList)
		{
			if (string.IsNullOrEmpty(text))
			{
				text = ((inputValue.m_keyCode == KeyCode.None) ? (text + $"{inputValue.m_axisName}:{inputValue.m_axisValue}") : (text + inputValue.m_keyCode));
				continue;
			}
			text += ", ";
			text = ((inputValue.m_keyCode == KeyCode.None) ? (text + $"{inputValue.m_axisName}:{inputValue.m_axisValue}") : (text + inputValue.m_keyCode));
		}
		return text;
	}
}
