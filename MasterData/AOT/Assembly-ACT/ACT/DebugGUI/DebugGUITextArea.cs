using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUITextArea : DebugGUI
{
	public string label;

	public string text;

	public float height;

	public Vector2 pos;

	public DebugGUITextArea()
	{
	}

	public DebugGUITextArea(string label, string text = "", float height = 100f)
	{
		this.label = label;
		this.text = text;
		this.height = height;
	}

	public override void Draw()
	{
		GUILayout.Label(label);
		pos = GUILayout.BeginScrollView(pos, GUILayout.Height(height));
		GUILayout.TextArea(text);
		GUILayout.EndScrollView();
	}
}
