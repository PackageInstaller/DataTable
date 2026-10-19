using System;
using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUIToggle : DebugGUI
{
	public string text;

	public bool value;

	public Action<bool> action;

	public DebugGUIToggle()
	{
	}

	public DebugGUIToggle(string text = "", Action<bool> action = null)
	{
		this.text = text;
		this.action = action;
	}

	public override void Draw()
	{
		bool flag = GUILayout.Toggle(value, text);
		if (flag != value)
		{
			action?.Invoke(flag);
			value = flag;
		}
	}
}
