using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGizmoSphere : DebugGizmo
{
	public Color color;

	public Vector3 center;

	public float radius;

	public override void Draw()
	{
		Gizmos.color = color;
		Gizmos.DrawSphere(center, radius);
	}
}
