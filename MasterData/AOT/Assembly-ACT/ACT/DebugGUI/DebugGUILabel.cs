using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUILabel : DebugGUI
{
	public string label;

	public DebugGUILabel()
	{
	}

	public DebugGUILabel(string label)
	{
		this.label = label;
	}

	public override void Draw()
	{
		GUILayout.Label(label);
	}
}
