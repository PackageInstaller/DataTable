using System;
using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUIButton : DebugGUI
{
	public string text;

	public Action action;

	public DebugGUIButton()
	{
	}

	public DebugGUIButton(string text = "", Action action = null)
	{
		this.text = text;
		this.action = action;
	}

	public override void Draw()
	{
		if (GUILayout.Button(text) && action != null)
		{
			action();
		}
	}
}
