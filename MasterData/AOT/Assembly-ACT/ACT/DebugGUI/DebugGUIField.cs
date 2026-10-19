using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUIField : DebugGUI
{
	public string label;

	public string text;

	public DebugGUIField()
	{
	}

	public DebugGUIField(string label, string text = "")
	{
		this.label = label;
		this.text = text;
	}

	public override void Draw()
	{
		GUILayout.BeginHorizontal();
		GUILayout.Label(label);
		GUILayout.Label(text);
		GUILayout.EndHorizontal();
	}
}
