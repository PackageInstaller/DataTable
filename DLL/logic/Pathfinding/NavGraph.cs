using System;
using System.Collections.Generic;
using Pathfinding.Serialization;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public abstract class NavGraph
{
	public AstarPath active;

	[JsonMember]
	public Pathfinding.Util.Guid guid;

	[JsonMember]
	public uint initialPenalty;

	[JsonMember]
	public bool open;

	public uint graphIndex;

	[JsonMember]
	public string name;

	[JsonMember]
	public bool drawGizmos;

	[JsonMember]
	public bool infoScreenOpen;

	[Obsolete("Use the transform field (only available on some graph types) instead", true)]
	public Matrix4x4 matrix;

	[Obsolete("Use the transform field (only available on some graph types) instead", true)]
	public Matrix4x4 inverseMatrix;

	internal bool exists => active != null;

	public virtual int CountNodes()
	{
		int count = 0;
		GetNodes(delegate
		{
			count++;
		});
		return count;
	}

	public void GetNodes(Func<GraphNode, bool> action)
	{
		bool cont = true;
		GetNodes(delegate(GraphNode node)
		{
			if (cont)
			{
				cont &= action(node);
			}
		});
	}

	public abstract void GetNodes(Action<GraphNode> action);

	[Obsolete("Use the transform field (only available on some graph types) instead", true)]
	public void SetMatrix(Matrix4x4 m)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_000a: Unknown result type (might be due to invalid IL or missing references)
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		matrix = m;
		inverseMatrix = ((Matrix4x4)(ref m)).inverse;
	}

	[Obsolete("Use RelocateNodes(Matrix4x4) instead. To keep the same behavior you can call RelocateNodes(newMatrix * oldMatrix.inverse).")]
	public void RelocateNodes(Matrix4x4 oldMatrix, Matrix4x4 newMatrix)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0004: Unknown result type (might be due to invalid IL or missing references)
		//IL_0009: Unknown result type (might be due to invalid IL or missing references)
		RelocateNodes(newMatrix * ((Matrix4x4)(ref oldMatrix)).inverse);
	}

	public virtual void RelocateNodes(Matrix4x4 deltaMatrix)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		GetNodes(delegate(GraphNode node)
		{
			//IL_000d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0012: Unknown result type (might be due to invalid IL or missing references)
			node.position = (Int3)((Matrix4x4)(ref deltaMatrix)).MultiplyPoint((Vector3)node.position);
		});
	}

	public NNInfoInternal GetNearest(Int3 position)
	{
		return GetNearest(position, NNConstraint.None);
	}

	public NNInfoInternal GetNearest(Int3 position, NNConstraint constraint)
	{
		return GetNearest(position, constraint, null);
	}

	public virtual NNInfoInternal GetNearest(Int3 position, NNConstraint constraint, GraphNode hint)
	{
		long maxDistSqr = ((constraint == null || constraint.constrainDistance) ? AstarPath.active.maxNearestNodeDistanceSqr : long.MaxValue);
		long minDist = long.MaxValue;
		GraphNode minNode = null;
		long minConstDist = long.MaxValue;
		GraphNode minConstNode = null;
		GetNodes(delegate(GraphNode node)
		{
			long sqrMagnitudeLong = (position - node.position).sqrMagnitudeLong;
			if (sqrMagnitudeLong < minDist)
			{
				minDist = sqrMagnitudeLong;
				minNode = node;
			}
			if (sqrMagnitudeLong < minConstDist && sqrMagnitudeLong < maxDistSqr && (constraint == null || constraint.Suitable(node)))
			{
				minConstDist = sqrMagnitudeLong;
				minConstNode = node;
			}
		});
		NNInfoInternal result = new NNInfoInternal(minNode);
		result.constrainedNode = minConstNode;
		if (minConstNode != null)
		{
			result.constClampedPosition = minConstNode.position;
		}
		else if (minNode != null)
		{
			result.constrainedNode = minNode;
			result.constClampedPosition = minNode.position;
		}
		return result;
	}

	public virtual NNInfoInternal GetNearestForce(Int3 position, NNConstraint constraint)
	{
		return GetNearest(position, constraint);
	}

	public virtual void OnDestroy()
	{
		DestroyAllNodesInternal();
	}

	internal virtual void DestroyAllNodesInternal()
	{
		GetNodes(delegate(GraphNode node)
		{
			node.Destroy();
		});
	}

	public void ScanGraph()
	{
		if (AstarPath.OnPreScan != null)
		{
			AstarPath.OnPreScan(AstarPath.active);
		}
		if (AstarPath.OnGraphPreScan != null)
		{
			AstarPath.OnGraphPreScan(this);
		}
		IEnumerator<Progress> enumerator = ScanInternal().GetEnumerator();
		while (enumerator.MoveNext())
		{
		}
		if (AstarPath.OnGraphPostScan != null)
		{
			AstarPath.OnGraphPostScan(this);
		}
		if (AstarPath.OnPostScan != null)
		{
			AstarPath.OnPostScan(AstarPath.active);
		}
	}

	[Obsolete("Please use AstarPath.active.Scan or if you really want this.ScanInternal which has the same functionality as this method had")]
	public void Scan()
	{
		throw new Exception("This method is deprecated. Please use AstarPath.active.Scan or if you really want this.ScanInternal which has the same functionality as this method had.");
	}

	public abstract IEnumerable<Progress> ScanInternal();

	public virtual void SerializeExtraInfo(GraphSerializationContext ctx)
	{
	}

	public virtual void DeserializeExtraInfo(GraphSerializationContext ctx)
	{
	}

	public virtual void PostDeserialization()
	{
	}

	public virtual void DeserializeSettingsCompatibility(GraphSerializationContext ctx)
	{
		guid = new Pathfinding.Util.Guid(ctx.reader.ReadBytes(16));
		initialPenalty = ctx.reader.ReadUInt32();
		open = ctx.reader.ReadBoolean();
		name = ctx.reader.ReadString();
		drawGizmos = ctx.reader.ReadBoolean();
		infoScreenOpen = ctx.reader.ReadBoolean();
	}

	public virtual void OnDrawGizmos(RetainedGizmos gizmos, bool drawNodes)
	{
		if (!drawNodes)
		{
			return;
		}
		RetainedGizmos.Hasher hasher = new RetainedGizmos.Hasher(active);
		GetNodes(delegate(GraphNode node)
		{
			hasher.HashNode(node);
		});
		if (!gizmos.Draw(hasher))
		{
			using GraphGizmoHelper graphGizmoHelper = gizmos.GetGizmoHelper(active, hasher);
			GetNodes((Action<GraphNode>)graphGizmoHelper.DrawConnections);
		}
		if (active.showUnwalkableNodes)
		{
			DrawUnwalkableNodes(active.unwalkableNodeDebugSize);
		}
	}

	protected void DrawUnwalkableNodes(float size)
	{
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		Gizmos.color = AstarColor.UnwalkableNode;
		GetNodes(delegate(GraphNode node)
		{
			//IL_000e: Unknown result type (might be due to invalid IL or missing references)
			//IL_0013: Unknown result type (might be due to invalid IL or missing references)
			//IL_001e: Unknown result type (might be due to invalid IL or missing references)
			if (!node.Walkable)
			{
				Gizmos.DrawCube((Vector3)node.position, Vector3.one * size);
			}
		});
	}

	internal virtual void UnloadGizmoMeshes()
	{
	}

	protected NavGraph()
	{
		//IL_0008: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		drawGizmos = true;
		matrix = Matrix4x4.identity;
		inverseMatrix = Matrix4x4.identity;
		base._002Ector();
	}
}
