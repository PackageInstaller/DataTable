using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUITextField : DebugGUI
{
	public string label;

	public string text;

	public DebugGUITextField()
	{
	}

	public DebugGUITextField(string label = "", string text = "")
	{
		this.label = label;
		this.text = text;
	}

	public override void Draw()
	{
		GUILayout.BeginHorizontal();
		GUILayout.Label(label);
		text = GUILayout.TextField(text);
		GUILayout.EndHorizontal();
	}
}
