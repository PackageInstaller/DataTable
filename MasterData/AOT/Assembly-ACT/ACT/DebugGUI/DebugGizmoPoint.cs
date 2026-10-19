using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGizmoPoint : DebugGizmo
{
	public Color color;

	public Vector3 pos;

	public override void Draw()
	{
		if (color.a > 0f)
		{
			Gizmos.DrawIcon(pos, "锚点", allowScaling: true, color);
		}
	}
}
