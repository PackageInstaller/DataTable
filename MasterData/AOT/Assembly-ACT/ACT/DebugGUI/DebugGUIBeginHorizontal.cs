using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGUIBeginHorizontal : DebugGUI
{
	public override void Draw()
	{
		GUILayout.BeginHorizontal();
	}
}
