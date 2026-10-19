using System;
using System.Collections.Generic;
using UnityEngine;

namespace ACT.Config;

[Serializable]
[CreateAssetMenu]
public class ButtonBindingPathConfig : ScriptableObject
{
	[Serializable]
	public class ButtonBindingPaths
	{
		public string Key;

		public List<ButtonBindingPath> InputBindingPaths = new List<ButtonBindingPath>();
	}

	[Serializable]
	public class ButtonBindingPath
	{
		[SerializeField]
		private ButtonBindingSolution m_Solution;

		[SerializeField]
		private string m_InputActionPath;

		[SerializeField]
		private int m_InputBindingIndex;

		public string InputActionPath => m_InputActionPath;

		public ButtonBindingSolution Solution => m_Solution;

		public int InputBindingIndex => m_InputBindingIndex;
	}

	public enum ButtonBindingSolution
	{
		Keyboard1 = 1,
		Keyboard2,
		Gamepad
	}

	[SerializeField]
	private List<ButtonBindingPaths> m_ButtonBindingPaths = new List<ButtonBindingPaths>();

	private Dictionary<string, ButtonBindingPaths> m_ButtonBindingPathsDict;

	public ButtonBindingPath GetButtonBindingPath(string key, ButtonBindingSolution solution)
	{
		if (m_ButtonBindingPathsDict == null)
		{
			m_ButtonBindingPathsDict = new Dictionary<string, ButtonBindingPaths>();
			foreach (ButtonBindingPaths buttonBindingPath in m_ButtonBindingPaths)
			{
				m_ButtonBindingPathsDict[buttonBindingPath.Key] = buttonBindingPath;
			}
		}
		if (string.IsNullOrEmpty(key))
		{
			return null;
		}
		if (!m_ButtonBindingPathsDict.TryGetValue(key, out var value))
		{
			return null;
		}
		foreach (ButtonBindingPath inputBindingPath in value.InputBindingPaths)
		{
			if (inputBindingPath.Solution == solution)
			{
				return inputBindingPath;
			}
		}
		return null;
	}
}
