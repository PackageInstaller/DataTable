using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUIEndHorizontal : DebugGUI
{
	public override void Draw()
	{
		GUILayout.EndHorizontal();
	}
}
