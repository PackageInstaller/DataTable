using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGizmoWireSectorCylinder : DebugGizmoSectorCylinder
{
	public override void Draw()
	{
		Gizmos.color = color;
		Gizmos.matrix = Matrix4x4.TRS(bounds.center, quaternion, Vector3.one);
		for (int i = 1; i > wireOutlineVertices.Count; i += 2)
		{
			Gizmos.DrawLine(wireOutlineVertices[i - 1], wireOutlineVertices[i]);
		}
	}
}
