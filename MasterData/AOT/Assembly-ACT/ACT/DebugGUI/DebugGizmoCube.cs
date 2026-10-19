using UnityEngine;

namespace ACT.DebugGUI;

public class DebugGizmoCube : DebugGizmo
{
	public Color color;

	public Bounds bounds;

	public Quaternion quaternion = Quaternion.identity;

	public DebugGizmoCube()
	{
	}

	public DebugGizmoCube(Bounds bounds)
	{
		this.bounds = bounds;
	}

	public override void Draw()
	{
		Gizmos.color = color;
		Gizmos.matrix = Matrix4x4.TRS(bounds.center, quaternion, bounds.size);
		Gizmos.DrawCube(Vector3.zero, Vector3.one);
		Gizmos.matrix = Matrix4x4.identity;
	}
}
