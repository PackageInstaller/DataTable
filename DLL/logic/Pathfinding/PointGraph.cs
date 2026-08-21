using System;
using System.Collections.Generic;
using Pathfinding.Serialization;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

[JsonOptIn]
public class PointGraph : NavGraph, IUpdatableGraph
{
	[JsonMember]
	public Transform root;

	[JsonMember]
	public string searchTag;

	[JsonMember]
	public float maxDistance;

	[JsonMember]
	public Vector3 limits;

	[JsonMember]
	public bool raycast = true;

	[JsonMember]
	public bool use2DPhysics;

	[JsonMember]
	public bool thickRaycast;

	[JsonMember]
	public float thickRaycastRadius = 1f;

	[JsonMember]
	public bool recursive = true;

	[JsonMember]
	public LayerMask mask;

	[JsonMember]
	public bool optimizeForSparseGraph;

	private PointKDTree lookupTree = new PointKDTree();

	public PointNode[] nodes;

	public int nodeCount { get; protected set; }

	public override int CountNodes()
	{
		return nodeCount;
	}

	public override void GetNodes(Action<GraphNode> action)
	{
		if (nodes != null)
		{
			int num = nodeCount;
			for (int i = 0; i < num; i++)
			{
				action(nodes[i]);
			}
		}
	}

	public override NNInfoInternal GetNearest(Int3 position, NNConstraint constraint, GraphNode hint)
	{
		return GetNearestForce(position, null);
	}

	public override NNInfoInternal GetNearestForce(Int3 position, NNConstraint constraint)
	{
		if (nodes == null)
		{
			return default(NNInfoInternal);
		}
		if (optimizeForSparseGraph)
		{
			return new NNInfoInternal(lookupTree.GetNearest(position, constraint));
		}
		float num = ((constraint == null || constraint.constrainDistance) ? ((float)AstarPath.active.maxNearestNodeDistanceSqr) : float.PositiveInfinity);
		NNInfoInternal result = new NNInfoInternal(null);
		long num2 = long.MaxValue;
		long num3 = long.MaxValue;
		for (int i = 0; i < nodeCount; i++)
		{
			PointNode pointNode = nodes[i];
			long sqrMagnitudeLong = (position - pointNode.position).sqrMagnitudeLong;
			if (sqrMagnitudeLong < num2)
			{
				num2 = sqrMagnitudeLong;
				result.node = pointNode;
			}
			if (sqrMagnitudeLong < num3 && (float)sqrMagnitudeLong < num && (constraint == null || constraint.Suitable(pointNode)))
			{
				num3 = sqrMagnitudeLong;
				result.constrainedNode = pointNode;
			}
		}
		result.UpdateInfo();
		return result;
	}

	public PointNode AddNode(Int3 position)
	{
		return AddNode(new PointNode(active), position);
	}

	public T AddNode<T>(T node, Int3 position) where T : PointNode
	{
		if (nodes == null || nodeCount == nodes.Length)
		{
			PointNode[] array = new PointNode[(nodes != null) ? Math.Max(nodes.Length + 4, nodes.Length * 2) : 4];
			for (int i = 0; i < nodeCount; i++)
			{
				array[i] = nodes[i];
			}
			nodes = array;
		}
		node.SetPosition(position);
		node.GraphIndex = graphIndex;
		node.Walkable = true;
		nodes[nodeCount] = node;
		nodeCount++;
		AddToLookup(node);
		return node;
	}

	protected static int CountChildren(Transform tr)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0017: Expected O, but got Unknown
		int num = 0;
		foreach (Transform item in tr)
		{
			Transform tr2 = item;
			num++;
			num += CountChildren(tr2);
		}
		return num;
	}

	protected void AddChildren(ref int c, Transform tr)
	{
		//IL_000f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Expected O, but got Unknown
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		foreach (Transform item in tr)
		{
			Transform val = item;
			nodes[c].SetPosition((Int3)val.position);
			nodes[c].Walkable = true;
			nodes[c].gameObject = ((Component)val).gameObject;
			c++;
			AddChildren(ref c, val);
		}
	}

	public void RebuildNodeLookup()
	{
		if (!optimizeForSparseGraph || nodes == null)
		{
			lookupTree = new PointKDTree();
			return;
		}
		PointKDTree pointKDTree = lookupTree;
		GraphNode[] array = nodes;
		pointKDTree.Rebuild(array, 0, nodeCount);
	}

	private void AddToLookup(PointNode node)
	{
		lookupTree.Add(node);
	}

	public override IEnumerable<Progress> ScanInternal()
	{
		yield return new Progress(0f, "Searching for GameObjects");
		if ((Object)(object)root == (Object)null)
		{
			GameObject[] gos = ((searchTag != null) ? GameObject.FindGameObjectsWithTag(searchTag) : null);
			if (gos == null)
			{
				nodes = new PointNode[0];
				nodeCount = 0;
				yield break;
			}
			yield return new Progress(0.1f, "Creating nodes");
			nodes = new PointNode[gos.Length];
			nodeCount = nodes.Length;
			for (int i = 0; i < nodes.Length; i++)
			{
				nodes[i] = new PointNode(active);
			}
			for (int j = 0; j < gos.Length; j++)
			{
				nodes[j].SetPosition((Int3)gos[j].transform.position);
				nodes[j].Walkable = true;
				nodes[j].gameObject = gos[j].gameObject;
			}
		}
		else if (!recursive)
		{
			nodes = new PointNode[root.childCount];
			nodeCount = nodes.Length;
			for (int k = 0; k < nodes.Length; k++)
			{
				nodes[k] = new PointNode(active);
			}
			int num = 0;
			foreach (Transform item in root)
			{
				Transform val = item;
				nodes[num].SetPosition((Int3)val.position);
				nodes[num].Walkable = true;
				nodes[num].gameObject = ((Component)val).gameObject;
				num++;
			}
		}
		else
		{
			nodes = new PointNode[CountChildren(root)];
			nodeCount = nodes.Length;
			for (int l = 0; l < nodes.Length; l++)
			{
				nodes[l] = new PointNode(active);
			}
			int c = 0;
			AddChildren(ref c, root);
		}
		if (optimizeForSparseGraph)
		{
			yield return new Progress(0.15f, "Building node lookup");
			RebuildNodeLookup();
		}
		if (!(maxDistance >= 0f))
		{
			yield break;
		}
		List<Connection> connections = new List<Connection>();
		List<GraphNode> candidateConnections = new List<GraphNode>();
		long maxPossibleSqrRange;
		if (maxDistance == 0f && (limits.x == 0f || limits.y == 0f || limits.z == 0f))
		{
			maxPossibleSqrRange = long.MaxValue;
		}
		else
		{
			maxPossibleSqrRange = (long)(Mathf.Max(limits.x, Mathf.Max(limits.y, Mathf.Max(limits.z, maxDistance))) * 1000f) + 1;
			maxPossibleSqrRange *= maxPossibleSqrRange;
		}
		for (int m = 0; m < nodes.Length; m++)
		{
			if (m % 512 == 0)
			{
				yield return new Progress(Mathf.Lerp(0.15f, 1f, (float)m / (float)nodes.Length), "Connecting nodes");
			}
			connections.Clear();
			PointNode pointNode = nodes[m];
			if (optimizeForSparseGraph)
			{
				candidateConnections.Clear();
				lookupTree.GetInRange(pointNode.position, maxPossibleSqrRange, candidateConnections);
				for (int n = 0; n < candidateConnections.Count; n++)
				{
					PointNode pointNode2 = candidateConnections[n] as PointNode;
					if (pointNode2 != pointNode && IsValidConnection(pointNode, pointNode2, out var dist))
					{
						connections.Add(new Connection
						{
							node = pointNode2,
							cost = (uint)Mathf.RoundToInt(dist * 1000f)
						});
					}
				}
			}
			else
			{
				for (int num2 = 0; num2 < nodes.Length; num2++)
				{
					if (m != num2)
					{
						PointNode pointNode3 = nodes[num2];
						if (IsValidConnection(pointNode, pointNode3, out var dist2))
						{
							connections.Add(new Connection
							{
								node = pointNode3,
								cost = (uint)Mathf.RoundToInt(dist2 * 1000f)
							});
						}
					}
				}
			}
			pointNode.connections = connections.ToArray();
		}
	}

	public virtual bool IsValidConnection(GraphNode a, GraphNode b, out float dist)
	{
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_0076: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fa: Unknown result type (might be due to invalid IL or missing references)
		//IL_0108: Unknown result type (might be due to invalid IL or missing references)
		//IL_010d: Unknown result type (might be due to invalid IL or missing references)
		//IL_010e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0257: Unknown result type (might be due to invalid IL or missing references)
		//IL_0262: Unknown result type (might be due to invalid IL or missing references)
		//IL_0268: Unknown result type (might be due to invalid IL or missing references)
		//IL_0217: Unknown result type (might be due to invalid IL or missing references)
		//IL_0221: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a3: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_01b8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01be: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0132: Unknown result type (might be due to invalid IL or missing references)
		//IL_013f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0144: Unknown result type (might be due to invalid IL or missing references)
		//IL_014c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0156: Unknown result type (might be due to invalid IL or missing references)
		//IL_027f: Unknown result type (might be due to invalid IL or missing references)
		//IL_028a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0290: Unknown result type (might be due to invalid IL or missing references)
		//IL_0232: Unknown result type (might be due to invalid IL or missing references)
		//IL_023c: Unknown result type (might be due to invalid IL or missing references)
		//IL_01da: Unknown result type (might be due to invalid IL or missing references)
		//IL_01df: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0164: Unknown result type (might be due to invalid IL or missing references)
		//IL_0169: Unknown result type (might be due to invalid IL or missing references)
		//IL_0176: Unknown result type (might be due to invalid IL or missing references)
		//IL_017b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0183: Unknown result type (might be due to invalid IL or missing references)
		//IL_018d: Unknown result type (might be due to invalid IL or missing references)
		dist = 0f;
		if (!a.Walkable || !b.Walkable)
		{
			return false;
		}
		Vector3 val = (Vector3)(b.position - a.position);
		if ((!Mathf.Approximately(limits.x, 0f) && Mathf.Abs(val.x) > limits.x) || (!Mathf.Approximately(limits.y, 0f) && Mathf.Abs(val.y) > limits.y) || (!Mathf.Approximately(limits.z, 0f) && Mathf.Abs(val.z) > limits.z))
		{
			return false;
		}
		dist = ((Vector3)(ref val)).magnitude;
		if (maxDistance == 0f || dist < maxDistance)
		{
			if (raycast)
			{
				Ray val2 = default(Ray);
				((Ray)(ref val2))._002Ector((Vector3)a.position, val);
				Ray val3 = default(Ray);
				((Ray)(ref val3))._002Ector((Vector3)b.position, -val);
				if (use2DPhysics)
				{
					if (thickRaycast)
					{
						if (!RaycastHit2D.op_Implicit(Physics2D.CircleCast(Vector2.op_Implicit(((Ray)(ref val2)).origin), thickRaycastRadius, Vector2.op_Implicit(((Ray)(ref val2)).direction), dist, LayerMask.op_Implicit(mask))))
						{
							return !RaycastHit2D.op_Implicit(Physics2D.CircleCast(Vector2.op_Implicit(((Ray)(ref val3)).origin), thickRaycastRadius, Vector2.op_Implicit(((Ray)(ref val3)).direction), dist, LayerMask.op_Implicit(mask)));
						}
						return false;
					}
					if (!RaycastHit2D.op_Implicit(Physics2D.Linecast(Vector2.op_Implicit((Vector3)a.position), Vector2.op_Implicit((Vector3)b.position), LayerMask.op_Implicit(mask))))
					{
						return !RaycastHit2D.op_Implicit(Physics2D.Linecast(Vector2.op_Implicit((Vector3)b.position), Vector2.op_Implicit((Vector3)a.position), LayerMask.op_Implicit(mask)));
					}
					return false;
				}
				if (thickRaycast)
				{
					if (!Physics.SphereCast(val2, thickRaycastRadius, dist, LayerMask.op_Implicit(mask)))
					{
						return !Physics.SphereCast(val3, thickRaycastRadius, dist, LayerMask.op_Implicit(mask));
					}
					return false;
				}
				if (!Physics.Linecast((Vector3)a.position, (Vector3)b.position, LayerMask.op_Implicit(mask)))
				{
					return !Physics.Linecast((Vector3)b.position, (Vector3)a.position, LayerMask.op_Implicit(mask));
				}
				return false;
			}
			return true;
		}
		return false;
	}

	public GraphUpdateThreading CanUpdateAsync(GraphUpdateObject o)
	{
		return GraphUpdateThreading.UnityThread;
	}

	public void UpdateAreaInit(GraphUpdateObject o)
	{
	}

	public void UpdateAreaPost(GraphUpdateObject o)
	{
	}

	public void UpdateArea(GraphUpdateObject guo)
	{
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		//IL_0066: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d2: Unknown result type (might be due to invalid IL or missing references)
		if (nodes == null)
		{
			return;
		}
		for (int i = 0; i < nodeCount; i++)
		{
			if (((Bounds)(ref guo.bounds)).Contains((Vector3)nodes[i].position))
			{
				guo.WillUpdateNode(nodes[i]);
				guo.Apply(nodes[i]);
			}
		}
		if (!guo.updatePhysics)
		{
			return;
		}
		Bounds bounds = guo.bounds;
		if (thickRaycast)
		{
			((Bounds)(ref bounds)).Expand(thickRaycastRadius * 2f);
		}
		List<Connection> list = ListPool<Connection>.Claim();
		for (int j = 0; j < nodeCount; j++)
		{
			PointNode pointNode = nodes[j];
			Vector3 a = (Vector3)pointNode.position;
			List<Connection> list2 = null;
			for (int k = 0; k < nodeCount; k++)
			{
				if (k == j)
				{
					continue;
				}
				Vector3 b = (Vector3)nodes[k].position;
				if (!VectorMath.SegmentIntersectsBounds(bounds, a, b))
				{
					continue;
				}
				PointNode pointNode2 = nodes[k];
				bool flag = pointNode.ContainsConnection(pointNode2);
				bool flag2 = IsValidConnection(pointNode, pointNode2, out var dist);
				if (!flag & flag2)
				{
					if (list2 == null)
					{
						list.Clear();
						list2 = list;
						list2.AddRange(pointNode.connections);
					}
					uint cost = (uint)Mathf.RoundToInt(dist * 1000f);
					list2.Add(new Connection
					{
						node = pointNode2,
						cost = cost
					});
				}
				else
				{
					if (!flag || flag2)
					{
						continue;
					}
					if (list2 == null)
					{
						list.Clear();
						list2 = list;
						list2.AddRange(pointNode.connections);
					}
					for (int l = 0; l < list2.Count; l++)
					{
						if (list2[l].node == pointNode2)
						{
							list2.RemoveAt(l);
							break;
						}
					}
				}
			}
			if (list2 != null)
			{
				pointNode.connections = list2.ToArray();
			}
		}
		ListPool<Connection>.Release(list);
	}

	public override void PostDeserialization()
	{
		RebuildNodeLookup();
	}

	public override void RelocateNodes(Matrix4x4 deltaMatrix)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		base.RelocateNodes(deltaMatrix);
		RebuildNodeLookup();
	}

	public override void DeserializeSettingsCompatibility(GraphSerializationContext ctx)
	{
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b8: Unknown result type (might be due to invalid IL or missing references)
		base.DeserializeSettingsCompatibility(ctx);
		Object obj = ctx.DeserializeUnityObject();
		root = (Transform)(object)((obj is Transform) ? obj : null);
		searchTag = ctx.reader.ReadString();
		maxDistance = ctx.reader.ReadSingle();
		limits = ctx.DeserializeVector3();
		raycast = ctx.reader.ReadBoolean();
		use2DPhysics = ctx.reader.ReadBoolean();
		thickRaycast = ctx.reader.ReadBoolean();
		thickRaycastRadius = ctx.reader.ReadSingle();
		recursive = ctx.reader.ReadBoolean();
		ctx.reader.ReadBoolean();
		mask = LayerMask.op_Implicit(ctx.reader.ReadInt32());
		optimizeForSparseGraph = ctx.reader.ReadBoolean();
		ctx.reader.ReadBoolean();
	}

	public override void SerializeExtraInfo(GraphSerializationContext ctx)
	{
		if (nodes == null)
		{
			ctx.writer.Write(-1);
		}
		ctx.writer.Write(nodeCount);
		for (int i = 0; i < nodeCount; i++)
		{
			if (nodes[i] == null)
			{
				ctx.writer.Write(-1);
				continue;
			}
			ctx.writer.Write(0);
			nodes[i].SerializeNode(ctx);
		}
	}

	public override void DeserializeExtraInfo(GraphSerializationContext ctx)
	{
		int num = ctx.reader.ReadInt32();
		if (num == -1)
		{
			nodes = null;
			return;
		}
		nodes = new PointNode[num];
		nodeCount = num;
		for (int i = 0; i < nodes.Length; i++)
		{
			if (ctx.reader.ReadInt32() != -1)
			{
				nodes[i] = new PointNode(active);
				nodes[i].DeserializeNode(ctx);
			}
		}
	}
}
