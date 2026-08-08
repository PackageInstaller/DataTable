using System;
using System.Collections.Generic;
using UnityEngine;

namespace Pathfinding.RVO;

public abstract class RVOObstacle : VersionedMonoBehaviour
{
	public enum ObstacleVertexWinding
	{
		KeepOut,
		KeepIn
	}

	public ObstacleVertexWinding obstacleMode;

	public RVOLayer layer = RVOLayer.DefaultObstacle;

	protected Simulator sim;

	private List<ObstacleVertex> addedObstacles;

	private List<Int3[]> sourceObstacles;

	private bool gizmoDrawing;

	private List<Vector3[]> gizmoVerts;

	private ObstacleVertexWinding _obstacleMode;

	private Matrix4x4 prevUpdateMatrix;

	protected abstract bool ExecuteInEditor { get; }

	protected abstract bool LocalCoordinates { get; }

	protected abstract bool StaticObstacle { get; }

	protected abstract float Height { get; }

	protected abstract void CreateObstacles();

	protected abstract bool AreGizmosDirty();

	protected virtual Matrix4x4 GetMatrix()
	{
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		if (!LocalCoordinates)
		{
			return Matrix4x4.identity;
		}
		return ((Component)this).transform.localToWorldMatrix;
	}

	public void OnDisable()
	{
		if (addedObstacles != null)
		{
			if (sim == null)
			{
				throw new Exception("This should not happen! Make sure you are not overriding the OnEnable function");
			}
			for (int i = 0; i < addedObstacles.Count; i++)
			{
				sim.RemoveObstacle(addedObstacles[i]);
			}
		}
	}

	public void OnEnable()
	{
		if (addedObstacles == null)
		{
			return;
		}
		if (sim == null)
		{
			throw new Exception("This should not happen! Make sure you are not overriding the OnDisable function");
		}
		for (int i = 0; i < addedObstacles.Count; i++)
		{
			ObstacleVertex obstacleVertex = addedObstacles[i];
			ObstacleVertex obstacleVertex2 = obstacleVertex;
			do
			{
				obstacleVertex.layer = layer;
				obstacleVertex = obstacleVertex.next;
			}
			while (obstacleVertex != obstacleVertex2);
			sim.AddObstacle(addedObstacles[i]);
		}
	}

	public void Start()
	{
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		addedObstacles = new List<ObstacleVertex>();
		sourceObstacles = new List<Int3[]>();
		prevUpdateMatrix = GetMatrix();
		CreateObstacles();
	}

	public void Update()
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		Matrix4x4 matrix = GetMatrix();
		if (matrix != prevUpdateMatrix)
		{
			for (int i = 0; i < addedObstacles.Count; i++)
			{
				sim.UpdateObstacle(addedObstacles[i], sourceObstacles[i], matrix);
			}
			prevUpdateMatrix = matrix;
		}
	}

	protected void FindSimulator()
	{
		if ((Object)(object)RVOSimulator.active == (Object)null)
		{
			throw new InvalidOperationException("No RVOSimulator could be found in the scene. Please add one to any GameObject");
		}
		sim = RVOSimulator.active.GetSimulator();
	}

	protected void AddObstacle(Int3[] vertices, Int height)
	{
		if (vertices == null)
		{
			throw new ArgumentNullException("Vertices Must Not Be Null");
		}
		if (height < 0)
		{
			throw new ArgumentOutOfRangeException("Height must be non-negative");
		}
		if (vertices.Length < 2)
		{
			throw new ArgumentException("An obstacle must have at least two vertices");
		}
		if (sim == null)
		{
			FindSimulator();
		}
		if (gizmoDrawing)
		{
			Vector3[] array = (Vector3[])(object)new Vector3[vertices.Length];
			WindCorrectly(vertices);
			Array.Copy(vertices, array, vertices.Length);
			gizmoVerts.Add(array);
		}
		else if (vertices.Length == 2)
		{
			AddObstacleInternal(vertices, height);
		}
		else
		{
			WindCorrectly(vertices);
			AddObstacleInternal(vertices, height);
		}
	}

	private void AddObstacleInternal(Int3[] vertices, Int height)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		addedObstacles.Add(sim.AddObstacle(vertices, height, GetMatrix(), layer));
		sourceObstacles.Add(vertices);
	}

	private void WindCorrectly(Int3[] vertices)
	{
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		//IL_000e: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0069: Unknown result type (might be due to invalid IL or missing references)
		//IL_006e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		int num = 0;
		Int obj = Int.MaxValue;
		Matrix4x4 matrix = GetMatrix();
		for (int i = 0; i < vertices.Length; i++)
		{
			Int obj2 = ((Int3)((Matrix4x4)(ref matrix)).MultiplyPoint3x4((Vector3)vertices[i])).x;
			if (obj2 < obj)
			{
				num = i;
				obj = obj2;
			}
		}
		Int3 a = (Int3)((Matrix4x4)(ref matrix)).MultiplyPoint3x4((Vector3)vertices[(num - 1 + vertices.Length) % vertices.Length]);
		Int3 b = (Int3)((Matrix4x4)(ref matrix)).MultiplyPoint3x4((Vector3)vertices[num]);
		Int3 c = (Int3)((Matrix4x4)(ref matrix)).MultiplyPoint3x4((Vector3)vertices[(num + 1) % vertices.Length]);
		MovementPlane movementPlane = ((sim != null) ? sim.movementPlane : (Object.op_Implicit((Object)(object)RVOSimulator.active) ? RVOSimulator.active.movementPlane : MovementPlane.XZ));
		if (movementPlane == MovementPlane.XY)
		{
			a.z = a.y;
			b.z = b.y;
			c.z = c.y;
		}
		if (VectorMath.IsClockwiseXZ(a, b, c) != (obstacleMode == ObstacleVertexWinding.KeepIn))
		{
			Array.Reverse((Array)vertices);
		}
	}
}
