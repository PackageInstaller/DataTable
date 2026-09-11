using UnityEngine;

namespace Pathfinding.RVO;

[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_r_v_o_1_1_r_v_o_square_obstacle.php")]
[AddComponentMenu("Pathfinding/Local Avoidance/Square Obstacle")]
public class RVOSquareObstacle : RVOObstacle
{
	public float height;

	public Vector2 size;

	public Vector2 center;

	protected override bool StaticObstacle => false;

	protected override bool ExecuteInEditor => true;

	protected override bool LocalCoordinates => true;

	protected override float Height => height;

	protected override bool AreGizmosDirty()
	{
		return false;
	}

	protected override void CreateObstacles()
	{
		//IL_005e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0079: Unknown result type (might be due to invalid IL or missing references)
		//IL_007e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0094: Unknown result type (might be due to invalid IL or missing references)
		//IL_0099: Unknown result type (might be due to invalid IL or missing references)
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ec: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fe: Unknown result type (might be due to invalid IL or missing references)
		//IL_011e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0123: Unknown result type (might be due to invalid IL or missing references)
		//IL_0128: Unknown result type (might be due to invalid IL or missing references)
		//IL_0148: Unknown result type (might be due to invalid IL or missing references)
		size.x = Mathf.Abs(size.x);
		size.y = Mathf.Abs(size.y);
		height = Mathf.Abs(height);
		Vector3[] array = (Vector3[])(object)new Vector3[4]
		{
			new Vector3(1f, 0f, -1f),
			new Vector3(1f, 0f, 1f),
			new Vector3(-1f, 0f, 1f),
			new Vector3(-1f, 0f, -1f)
		};
		for (int i = 0; i < array.Length; i++)
		{
			((Vector3)(ref array[i])).Scale(new Vector3(size.x * 0.5f, 0f, size.y * 0.5f));
			ref Vector3 reference = ref array[i];
			reference += new Vector3(center.x, 0f, center.y);
		}
		Int3[] array2 = new Int3[array.Length];
		for (int j = 0; j < array.Length; j++)
		{
			array2[j] = (Int3)array[j];
		}
		AddObstacle(array2, (Int)height);
	}

	public RVOSquareObstacle()
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		height = 1f;
		size = Vector2.op_Implicit(Vector3.one);
		center = Vector2.op_Implicit(Vector3.zero);
		base._002Ector();
	}
}
