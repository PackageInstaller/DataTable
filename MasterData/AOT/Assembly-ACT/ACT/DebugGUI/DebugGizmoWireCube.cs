using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGizmoWireCube : DebugGizmoCube
{
	public override void Draw()
	{
		Gizmos.color = color;
		Gizmos.matrix = Matrix4x4.TRS(bounds.center, quaternion, bounds.size);
		Gizmos.DrawWireCube(Vector3.zero, Vector3.one);
		Gizmos.matrix = Matrix4x4.identity;
	}
}
