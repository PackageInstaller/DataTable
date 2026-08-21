using System;
using System.Collections.Generic;
using System.Runtime.CompilerServices;
using Pathfinding.Serialization;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

[JsonOptIn]
public class GridGraph : NavGraph, IUpdatableGraph, ITransformedGraph, IRaycastableGraph
{
	public class TextureData
	{
		public enum ChannelUse
		{
			None,
			Penalty,
			Position,
			WalkablePenalty
		}

		public bool enabled;

		public Texture2D source;

		public float[] factors = new float[3];

		public ChannelUse[] channels = new ChannelUse[3];

		private Color32[] data;

		public void Initialize()
		{
			//IL_0038: Expected O, but got Unknown
			if (!enabled || !((Object)(object)source != (Object)null))
			{
				return;
			}
			for (int i = 0; i < channels.Length; i++)
			{
				if (channels[i] != ChannelUse.None)
				{
					try
					{
						data = source.GetPixels32();
						break;
					}
					catch (UnityException ex)
					{
						UnityException ex2 = ex;
						Debug.LogWarning((object)((object)ex2).ToString());
						data = null;
						break;
					}
				}
			}
		}

		public void Apply(GridNode node, int x, int z)
		{
			//IL_004d: Unknown result type (might be due to invalid IL or missing references)
			//IL_0052: Unknown result type (might be due to invalid IL or missing references)
			//IL_0061: Unknown result type (might be due to invalid IL or missing references)
			//IL_008a: Unknown result type (might be due to invalid IL or missing references)
			//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
			if (enabled && data != null && x < ((Texture)source).width && z < ((Texture)source).height)
			{
				Color32 val = data[z * ((Texture)source).width + x];
				if (channels[0] != ChannelUse.None)
				{
					ApplyChannel(node, x, z, val.r, channels[0], factors[0]);
				}
				if (channels[1] != ChannelUse.None)
				{
					ApplyChannel(node, x, z, val.g, channels[1], factors[1]);
				}
				if (channels[2] != ChannelUse.None)
				{
					ApplyChannel(node, x, z, val.b, channels[2], factors[2]);
				}
				node.WalkableErosion = node.Walkable;
			}
		}

		private void ApplyChannel(GridNode node, int x, int z, int value, ChannelUse channelUse, float factor)
		{
			switch (channelUse)
			{
			case ChannelUse.Penalty:
				node.Penalty += (uint)Mathf.RoundToInt((float)value * factor);
				break;
			case ChannelUse.Position:
				node.position = GridNode.GetGridGraph(node.GraphIndex).GraphPointToWorld(x, z, value);
				break;
			case ChannelUse.WalkablePenalty:
				if (value == 0)
				{
					node.Walkable = false;
				}
				else
				{
					node.Penalty += (uint)Mathf.RoundToInt((float)(value - 1) * factor);
				}
				break;
			}
		}
	}

	public int width;

	public int depth;

	[JsonMember]
	public float aspectRatio;

	[JsonMember]
	public float isometricAngle;

	[JsonMember]
	public bool uniformEdgeCosts;

	[JsonMember]
	public Vector3 rotation;

	[JsonMember]
	public Vector3 center;

	[JsonMember]
	public Vector2 unclampedSize;

	[JsonMember]
	public float nodeSize;

	[JsonMember]
	public GraphCollision collision;

	[JsonMember]
	public float maxClimb;

	[JsonMember]
	public float maxSlope;

	[JsonMember]
	public int erodeIterations;

	[JsonMember]
	public bool erosionUseTags;

	[JsonMember]
	public int erosionFirstTag;

	[JsonMember]
	public bool autoLinkGrids;

	[JsonMember]
	public float autoLinkDistLimit;

	[JsonMember]
	public NumNeighbours neighbours;

	[JsonMember]
	public bool cutCorners;

	[JsonMember]
	public float penaltyPositionOffset;

	[JsonMember]
	public bool penaltyPosition;

	[JsonMember]
	public float penaltyPositionFactor;

	[JsonMember]
	public bool penaltyAngle;

	[JsonMember]
	public float penaltyAngleFactor;

	[JsonMember]
	public float penaltyAnglePower;

	[JsonMember]
	public bool useJumpPointSearch;

	[JsonMember]
	public bool showMeshOutline;

	[JsonMember]
	public bool showNodeConnections;

	[JsonMember]
	public bool showMeshSurface;

	[JsonMember]
	public TextureData textureData;

	[CompilerGenerated]
	private Vector2 _003Csize_003Ek__BackingField;

	[NonSerialized]
	public readonly int[] neighbourOffsets;

	[NonSerialized]
	public readonly uint[] neighbourCosts;

	[NonSerialized]
	public readonly int[] neighbourXOffsets;

	[NonSerialized]
	public readonly int[] neighbourZOffsets;

	internal static readonly int[] hexagonNeighbourIndices = new int[6] { -9981, -9980, -9979, -9978, -9977, -9976 };

	public const int getNearestForceOverlap = 2;

	public GridNode[] nodes;

	public virtual bool uniformWidthDepthGrid => true;

	public virtual int LayerCount => 1;

	public bool useRaycastNormal => Math.Abs(90f - maxSlope) > float.Epsilon;

	public Vector2 size
	{
		[CompilerGenerated]
		get
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			return _003Csize_003Ek__BackingField;
		}
		[CompilerGenerated]
		protected set
		{
			//IL_0001: Unknown result type (might be due to invalid IL or missing references)
			//IL_0002: Unknown result type (might be due to invalid IL or missing references)
			_003Csize_003Ek__BackingField = value;
		}
	}

	public GraphTransform transform { get; private set; }

	public int Width
	{
		get
		{
			return width;
		}
		set
		{
			width = value;
		}
	}

	public int Depth
	{
		get
		{
			return depth;
		}
		set
		{
			depth = value;
		}
	}

	public override void OnDestroy()
	{
		base.OnDestroy();
		RemoveGridGraphFromStatic();
	}

	internal override void DestroyAllNodesInternal()
	{
		GetNodes(delegate(GraphNode node)
		{
			(node as GridNodeBase).ClearCustomConnections(alsoReverse: true);
			node.ClearConnections(alsoReverse: false);
			node.Destroy();
		});
	}

	private void RemoveGridGraphFromStatic()
	{
		GridNode.SetGridGraph(AstarPath.active.data.GetGraphIndex(this), null);
	}

	public override int CountNodes()
	{
		return nodes.Length;
	}

	public override void GetNodes(Action<GraphNode> action)
	{
		if (nodes != null)
		{
			for (int i = 0; i < nodes.Length; i++)
			{
				action(nodes[i]);
			}
		}
	}

	public GridGraph()
	{
		//IL_00c7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e8: Unknown result type (might be due to invalid IL or missing references)
		aspectRatio = 1f;
		nodeSize = 1f;
		maxClimb = 0.4f;
		maxSlope = 90f;
		erosionFirstTag = 1;
		autoLinkDistLimit = 10f;
		neighbours = NumNeighbours.Eight;
		cutCorners = true;
		penaltyPositionFactor = 1f;
		penaltyAngleFactor = 100f;
		penaltyAnglePower = 1f;
		showMeshOutline = true;
		showMeshSurface = true;
		textureData = new TextureData();
		neighbourOffsets = new int[8];
		neighbourCosts = new uint[8];
		neighbourXOffsets = new int[8];
		neighbourZOffsets = new int[8];
		base._002Ector();
		unclampedSize = new Vector2(10f, 10f);
		nodeSize = 1f;
		collision = new GraphCollision();
		transform = new GraphTransform(Matrix4x4.identity);
	}

	public override void RelocateNodes(Matrix4x4 deltaMatrix)
	{
		throw new Exception("This method cannot be used for Grid Graphs. Please use the other overload of RelocateNodes instead");
	}

	public void RelocateNodes(Vector3 center, Quaternion rotation, float nodeSize, float aspectRatio = 1f, float isometricAngle = 0f)
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0028: Unknown result type (might be due to invalid IL or missing references)
		GraphTransform previousTransform = transform;
		this.center = center;
		this.rotation = ((Quaternion)(ref rotation)).eulerAngles;
		this.aspectRatio = aspectRatio;
		this.isometricAngle = isometricAngle;
		SetDimensions(width, depth, nodeSize);
		GetNodes(delegate(GraphNode node)
		{
			//IL_0013: Unknown result type (might be due to invalid IL or missing references)
			//IL_0018: Unknown result type (might be due to invalid IL or missing references)
			GridNodeBase gridNodeBase = node as GridNodeBase;
			float y = previousTransform.InverseTransform((Vector3)node.position).y;
			node.position = GraphPointToWorld(gridNodeBase.XCoordinateInGrid, gridNodeBase.ZCoordinateInGrid, y);
		});
	}

	public Int3 GraphPointToWorld(int x, int z, float height)
	{
		//IL_0017: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		return (Int3)transform.Transform(new Vector3((float)x + 0.5f, height, (float)z + 0.5f));
	}

	public uint GetConnectionCost(int dir)
	{
		return neighbourCosts[dir];
	}

	public GridNode GetNodeConnection(GridNode node, int dir)
	{
		if (!node.HasConnectionInDirection(dir))
		{
			return null;
		}
		if (!node.EdgeNode)
		{
			return nodes[node.NodeInGridIndex + neighbourOffsets[dir]];
		}
		int nodeInGridIndex = node.NodeInGridIndex;
		int num = nodeInGridIndex / Width;
		int x = nodeInGridIndex - num * Width;
		return GetNodeConnection(nodeInGridIndex, x, num, dir);
	}

	public bool HasNodeConnection(GridNode node, int dir)
	{
		if (!node.HasConnectionInDirection(dir))
		{
			return false;
		}
		if (!node.EdgeNode)
		{
			return true;
		}
		int nodeInGridIndex = node.NodeInGridIndex;
		int num = nodeInGridIndex / Width;
		int x = nodeInGridIndex - num * Width;
		return HasNodeConnection(nodeInGridIndex, x, num, dir);
	}

	public void SetNodeConnection(GridNode node, int dir, bool value)
	{
		int nodeInGridIndex = node.NodeInGridIndex;
		int num = nodeInGridIndex / Width;
		int x = nodeInGridIndex - num * Width;
		SetNodeConnection(nodeInGridIndex, x, num, dir, value);
	}

	private GridNode GetNodeConnection(int index, int x, int z, int dir)
	{
		if (!nodes[index].HasConnectionInDirection(dir))
		{
			return null;
		}
		int num = x + neighbourXOffsets[dir];
		if (num < 0 || num >= Width)
		{
			return null;
		}
		int num2 = z + neighbourZOffsets[dir];
		if (num2 < 0 || num2 >= Depth)
		{
			return null;
		}
		int num3 = index + neighbourOffsets[dir];
		return nodes[num3];
	}

	public void SetNodeConnection(int index, int x, int z, int dir, bool value)
	{
		nodes[index].SetConnectionInternal(dir, value);
	}

	public bool HasNodeConnection(int index, int x, int z, int dir)
	{
		if (!nodes[index].HasConnectionInDirection(dir))
		{
			return false;
		}
		int num = x + neighbourXOffsets[dir];
		if (num < 0 || num >= Width)
		{
			return false;
		}
		int num2 = z + neighbourZOffsets[dir];
		if (num2 < 0 || num2 >= Depth)
		{
			return false;
		}
		return true;
	}

	public void SetDimensions(int width, int depth, float nodeSize)
	{
		//IL_0005: Unknown result type (might be due to invalid IL or missing references)
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		unclampedSize = new Vector2((float)width, (float)depth) * nodeSize;
		this.nodeSize = nodeSize;
		UpdateTransform();
	}

	[Obsolete("Use SetDimensions instead")]
	public void UpdateSizeFromWidthDepth()
	{
		SetDimensions(width, depth, nodeSize);
	}

	[Obsolete("This method has been renamed to UpdateTransform")]
	public void GenerateMatrix()
	{
		UpdateTransform();
	}

	public void UpdateTransform()
	{
		CalculateDimensions(out width, out depth, out nodeSize);
		transform = CalculateTransform();
	}

	public GraphTransform CalculateTransform()
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_0025: Unknown result type (might be due to invalid IL or missing references)
		//IL_002a: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0050: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_005b: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0070: Unknown result type (might be due to invalid IL or missing references)
		//IL_0075: Unknown result type (might be due to invalid IL or missing references)
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		//IL_0085: Unknown result type (might be due to invalid IL or missing references)
		//IL_0087: Unknown result type (might be due to invalid IL or missing references)
		//IL_008d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0092: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ac: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fa: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_0105: Unknown result type (might be due to invalid IL or missing references)
		//IL_010a: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		CalculateDimensions(out var num, out var num2, out var num3);
		Matrix4x4 val = Matrix4x4.TRS(Vector3.zero, Quaternion.Euler(0f, 45f, 0f), Vector3.one);
		val = Matrix4x4.Scale(new Vector3(Mathf.Cos(MathF.PI / 180f * isometricAngle), 1f, 1f)) * val;
		val = Matrix4x4.TRS(Vector3.zero, Quaternion.Euler(0f, -45f, 0f), Vector3.one) * val;
		Matrix4x4 val2 = Matrix4x4.TRS(center, Quaternion.Euler(rotation), new Vector3(aspectRatio, 1f, 1f)) * val;
		Matrix4x4 val3 = Matrix4x4.TRS(((Matrix4x4)(ref val2)).MultiplyPoint3x4(-new Vector3((float)num * num3, 0f, (float)num2 * num3) * 0.5f), Quaternion.Euler(rotation), new Vector3(num3 * aspectRatio, 1f, num3)) * val;
		return new GraphTransform(val3);
	}

	private void CalculateDimensions(out int width, out int depth, out float nodeSize)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0053: Unknown result type (might be due to invalid IL or missing references)
		//IL_0067: Unknown result type (might be due to invalid IL or missing references)
		//IL_0071: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		//IL_009c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00cd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00db: Unknown result type (might be due to invalid IL or missing references)
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0119: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_0135: Unknown result type (might be due to invalid IL or missing references)
		Vector2 val = unclampedSize;
		val.x *= Mathf.Sign(val.x);
		val.y *= Mathf.Sign(val.y);
		nodeSize = Mathf.Max(this.nodeSize, val.x / 1024f);
		nodeSize = Mathf.Max(this.nodeSize, val.y / 1024f);
		val.x = ((val.x < nodeSize) ? nodeSize : val.x);
		val.y = ((val.y < nodeSize) ? nodeSize : val.y);
		size = val;
		width = Mathf.FloorToInt(size.x / nodeSize);
		depth = Mathf.FloorToInt(size.y / nodeSize);
		if (Mathf.Approximately(size.x / nodeSize, (float)Mathf.CeilToInt(size.x / nodeSize)))
		{
			width = Mathf.CeilToInt(size.x / nodeSize);
		}
		if (Mathf.Approximately(size.y / nodeSize, (float)Mathf.CeilToInt(size.y / nodeSize)))
		{
			depth = Mathf.CeilToInt(size.y / nodeSize);
		}
	}

	public override NNInfoInternal GetNearest(Int3 position, NNConstraint constraint, GraphNode hint)
	{
		//IL_00a6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_0105: Unknown result type (might be due to invalid IL or missing references)
		//IL_010a: Unknown result type (might be due to invalid IL or missing references)
		if (nodes == null || depth * width != nodes.Length)
		{
			return default(NNInfoInternal);
		}
		position = transform.InverseTransform(position);
		int x = position.x;
		int z = position.z;
		int num = Mathf.Clamp(x / 1000, 0, width - 1);
		int num2 = Mathf.Clamp(z / 1000, 0, depth - 1);
		NNInfoInternal result = new NNInfoInternal(nodes[num2 * width + num]);
		float y = transform.InverseTransform((Vector3)nodes[num2 * width + num].position).y;
		Int3 @int = new Int3(Mathf.Clamp(x, num * 1000, num * 1000 + 1000), (int)(y * 1000f), Mathf.Clamp(z, num2 * 1000, num2 * 1000 + 1000));
		result.clampedPosition = (Int3)transform.Transform((Vector3)@int);
		return result;
	}

	public override NNInfoInternal GetNearestForce(Int3 position, NNConstraint constraint)
	{
		//IL_00e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e7: Unknown result type (might be due to invalid IL or missing references)
		//IL_0139: Unknown result type (might be due to invalid IL or missing references)
		//IL_013e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0294: Unknown result type (might be due to invalid IL or missing references)
		//IL_0299: Unknown result type (might be due to invalid IL or missing references)
		//IL_02c0: Unknown result type (might be due to invalid IL or missing references)
		//IL_02c5: Unknown result type (might be due to invalid IL or missing references)
		//IL_03ba: Unknown result type (might be due to invalid IL or missing references)
		//IL_03bf: Unknown result type (might be due to invalid IL or missing references)
		//IL_03e6: Unknown result type (might be due to invalid IL or missing references)
		//IL_03eb: Unknown result type (might be due to invalid IL or missing references)
		//IL_04ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_04f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_051b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0520: Unknown result type (might be due to invalid IL or missing references)
		//IL_0627: Unknown result type (might be due to invalid IL or missing references)
		//IL_062c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0653: Unknown result type (might be due to invalid IL or missing references)
		//IL_0658: Unknown result type (might be due to invalid IL or missing references)
		if (nodes == null || depth * width != nodes.Length)
		{
			return default(NNInfoInternal);
		}
		Int3 @int = position;
		position = transform.InverseTransform(position);
		int x = position.x;
		int z = position.z;
		int num = Mathf.Clamp(x / 1000, 0, width - 1);
		int num2 = Mathf.Clamp(z / 1000, 0, depth - 1);
		GridNode gridNode = nodes[num + num2 * width];
		GridNode gridNode2 = null;
		long num3 = long.MaxValue;
		int num4 = 2;
		Int3 clampedPosition = Int3.zero;
		NNInfoInternal result = new NNInfoInternal(null);
		if (constraint == null || constraint.Suitable(gridNode))
		{
			gridNode2 = gridNode;
			num3 = (gridNode2.position - @int).sqrMagnitudeLong;
			int y = ((Int3)transform.InverseTransform((Vector3)gridNode.position)).y;
			clampedPosition = (Int3)transform.Transform(new Vector3((float)Mathf.Clamp(x, num * 1000, num * 1000 + 1000), (float)y, (float)Mathf.Clamp(z, num2 * 1000, num2 * 1000 + 1000)));
		}
		if (gridNode2 != null)
		{
			result.node = gridNode2;
			result.clampedPosition = clampedPosition;
			if (num4 == 0)
			{
				return result;
			}
			num4--;
		}
		float num5 = ((constraint == null || constraint.constrainDistance) ? ((float)AstarPath.active.maxNearestNodeDistance) : float.PositiveInfinity);
		float num6 = num5 * num5;
		int num7 = 1;
		while (true)
		{
			if (nodeSize * (float)num7 > num5)
			{
				result.node = gridNode2;
				result.clampedPosition = clampedPosition;
				return result;
			}
			bool flag = false;
			int num8 = num2 + num7;
			int num9 = num8 * width;
			int i;
			for (i = num - num7; i <= num + num7; i++)
			{
				if (i < 0 || num8 < 0 || i >= width || num8 >= depth)
				{
					continue;
				}
				flag = true;
				if (constraint == null || constraint.Suitable(nodes[i + num9]))
				{
					long sqrMagnitudeLong = (nodes[i + num9].position - @int).sqrMagnitudeLong;
					if (sqrMagnitudeLong < num3 && (float)sqrMagnitudeLong < num6)
					{
						num3 = sqrMagnitudeLong;
						gridNode2 = nodes[i + num9];
						clampedPosition = (Int3)transform.Transform(new Vector3((float)Mathf.Clamp(x, i * 1000, i * 1000 + 1000), transform.InverseTransform((Vector3)gridNode2.position).y, (float)Mathf.Clamp(z, num8 * 1000, num8 * 1000 + 1000)));
					}
				}
			}
			num8 = num2 - num7;
			num9 = num8 * width;
			for (i = num - num7; i <= num + num7; i++)
			{
				if (i < 0 || num8 < 0 || i >= width || num8 >= depth)
				{
					continue;
				}
				flag = true;
				if (constraint == null || constraint.Suitable(nodes[i + num9]))
				{
					long sqrMagnitudeLong2 = (nodes[i + num9].position - @int).sqrMagnitudeLong;
					if (sqrMagnitudeLong2 < num3 && (float)sqrMagnitudeLong2 < num6)
					{
						num3 = sqrMagnitudeLong2;
						gridNode2 = nodes[i + num9];
						clampedPosition = (Int3)transform.Transform(new Vector3((float)Mathf.Clamp(x, i * 1000, i * 1000 + 1000), transform.InverseTransform((Vector3)gridNode2.position).y, (float)Mathf.Clamp(z, num8 * 1000, num8 * 1000 + 1000)));
					}
				}
			}
			i = num - num7;
			for (num8 = num2 - num7 + 1; num8 <= num2 + num7 - 1; num8++)
			{
				if (i < 0 || num8 < 0 || i >= width || num8 >= depth)
				{
					continue;
				}
				flag = true;
				if (constraint == null || constraint.Suitable(nodes[i + num8 * width]))
				{
					long sqrMagnitudeLong3 = (nodes[i + num8 * width].position - @int).sqrMagnitudeLong;
					if (sqrMagnitudeLong3 < num3 && (float)sqrMagnitudeLong3 < num6)
					{
						num3 = sqrMagnitudeLong3;
						gridNode2 = nodes[i + num8 * width];
						clampedPosition = (Int3)transform.Transform(new Vector3((float)Mathf.Clamp(x, i * 1000, i * 1000 + 1000), transform.InverseTransform((Vector3)gridNode2.position).y, (float)Mathf.Clamp(z, num8 * 1000, num8 * 1000 + 1000)));
					}
				}
			}
			i = num + num7;
			for (num8 = num2 - num7 + 1; num8 <= num2 + num7 - 1; num8++)
			{
				if (i < 0 || num8 < 0 || i >= width || num8 >= depth)
				{
					continue;
				}
				flag = true;
				if (constraint == null || constraint.Suitable(nodes[i + num8 * width]))
				{
					long sqrMagnitudeLong4 = (nodes[i + num8 * width].position - @int).sqrMagnitudeLong;
					if (sqrMagnitudeLong4 < num3 && (float)sqrMagnitudeLong4 < num6)
					{
						num3 = sqrMagnitudeLong4;
						gridNode2 = nodes[i + num8 * width];
						clampedPosition = (Int3)transform.Transform(new Vector3((float)Mathf.Clamp(x, i * 1000, i * 1000 + 1000), transform.InverseTransform((Vector3)gridNode2.position).y, (float)Mathf.Clamp(z, num8 * 1000, num8 * 1000 + 1000)));
					}
				}
			}
			if (gridNode2 != null)
			{
				if (num4 == 0)
				{
					result.node = gridNode2;
					result.clampedPosition = clampedPosition;
					return result;
				}
				num4--;
			}
			if (!flag)
			{
				break;
			}
			num7++;
		}
		result.node = gridNode2;
		result.clampedPosition = clampedPosition;
		return result;
	}

	public virtual void SetUpOffsetsAndCosts()
	{
		neighbourOffsets[0] = -width;
		neighbourOffsets[1] = 1;
		neighbourOffsets[2] = width;
		neighbourOffsets[3] = -1;
		neighbourOffsets[4] = -width + 1;
		neighbourOffsets[5] = width + 1;
		neighbourOffsets[6] = width - 1;
		neighbourOffsets[7] = -width - 1;
		uint num = (uint)Mathf.RoundToInt(nodeSize * 1000f);
		uint num2 = (uniformEdgeCosts ? num : ((uint)Mathf.RoundToInt(nodeSize * Mathf.Sqrt(2f) * 1000f)));
		neighbourCosts[0] = num;
		neighbourCosts[1] = num;
		neighbourCosts[2] = num;
		neighbourCosts[3] = num;
		neighbourCosts[4] = num2;
		neighbourCosts[5] = num2;
		neighbourCosts[6] = num2;
		neighbourCosts[7] = num2;
		neighbourXOffsets[0] = 0;
		neighbourXOffsets[1] = 1;
		neighbourXOffsets[2] = 0;
		neighbourXOffsets[3] = -1;
		neighbourXOffsets[4] = 1;
		neighbourXOffsets[5] = 1;
		neighbourXOffsets[6] = -1;
		neighbourXOffsets[7] = -1;
		neighbourZOffsets[0] = -1;
		neighbourZOffsets[1] = 0;
		neighbourZOffsets[2] = 1;
		neighbourZOffsets[3] = 0;
		neighbourZOffsets[4] = -1;
		neighbourZOffsets[5] = 1;
		neighbourZOffsets[6] = 1;
		neighbourZOffsets[7] = -1;
	}

	public override IEnumerable<Progress> ScanInternal()
	{
		AstarPath.OnPostScan = (OnScanDelegate)Delegate.Combine(AstarPath.OnPostScan, new OnScanDelegate(OnPostScan));
		if (nodeSize <= 0f)
		{
			yield break;
		}
		UpdateTransform();
		if (width > 1024 || depth > 1024)
		{
			Debug.LogError((object)"One of the grid's sides is longer than 1024 nodes");
			yield break;
		}
		if (useJumpPointSearch)
		{
			Debug.LogError((object)"Trying to use Jump Point Search, but support for it is not enabled. Please enable it in the inspector (Grid Graph settings).");
		}
		SetUpOffsetsAndCosts();
		GridNode.SetGridGraph((int)graphIndex, this);
		yield return new Progress(0.05f, "Creating nodes");
		nodes = new GridNode[width * depth];
		for (int i = 0; i < depth; i++)
		{
			for (int j = 0; j < width; j++)
			{
				int num = i * width + j;
				GridNode gridNode = (nodes[num] = new GridNode(active));
				gridNode.GraphIndex = graphIndex;
				gridNode.NodeInGridIndex = num;
			}
		}
		if (collision == null)
		{
			collision = new GraphCollision();
		}
		collision.Initialize(transform, nodeSize);
		textureData.Initialize();
		int progressCounter = 0;
		for (int z = 0; z < depth; z++)
		{
			if (progressCounter >= 1000)
			{
				progressCounter = 0;
				yield return new Progress(Mathf.Lerp(0.1f, 0.7f, (float)z / (float)depth), "Calculating positions");
			}
			progressCounter += width;
			for (int k = 0; k < width; k++)
			{
				RecalculateCell(k, z);
				textureData.Apply(nodes[z * width + k], k, z);
			}
		}
		progressCounter = 0;
		for (int z = 0; z < depth; z++)
		{
			if (progressCounter >= 1000)
			{
				progressCounter = 0;
				yield return new Progress(Mathf.Lerp(0.7f, 0.9f, (float)z / (float)depth), "Calculating connections");
			}
			progressCounter += width;
			for (int l = 0; l < width; l++)
			{
				CalculateConnections(l, z);
			}
		}
		yield return new Progress(0.95f, "Calculating erosion");
		ErodeWalkableArea();
	}

	[Obsolete("Use RecalculateCell instead which works both for grid graphs and layered grid graphs")]
	public virtual void UpdateNodePositionCollision(GridNode node, int x, int z, bool resetPenalty = true)
	{
		RecalculateCell(x, z, resetPenalty, resetTags: false);
	}

	public virtual void RecalculateCell(int x, int z, bool resetPenalties = true, bool resetTags = true)
	{
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_003a: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0041: Unknown result type (might be due to invalid IL or missing references)
		//IL_0151: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c2: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e4: Unknown result type (might be due to invalid IL or missing references)
		GridNode gridNode = nodes[z * width + x];
		gridNode.position = GraphPointToWorld(x, z, 0f);
		Vector3 val = collision.CheckHeight((Vector3)gridNode.position, out var hit, out var walkable);
		gridNode.position = (Int3)val;
		if (resetPenalties)
		{
			gridNode.Penalty = initialPenalty;
			if (penaltyPosition)
			{
				gridNode.Penalty += (uint)Mathf.RoundToInt(((float)gridNode.position.y - penaltyPositionOffset) * penaltyPositionFactor);
			}
		}
		if (resetTags)
		{
			gridNode.Tag = 0u;
		}
		if (walkable && useRaycastNormal && collision.heightCheck && ((RaycastHit)(ref hit)).normal != Vector3.zero)
		{
			Vector3 normal = ((RaycastHit)(ref hit)).normal;
			float num = Vector3.Dot(((Vector3)(ref normal)).normalized, collision.up);
			if (penaltyAngle & resetPenalties)
			{
				gridNode.Penalty += (uint)Mathf.RoundToInt((1f - Mathf.Pow(num, penaltyAnglePower)) * penaltyAngleFactor);
			}
			float num2 = Mathf.Cos(maxSlope * (MathF.PI / 180f));
			if (num < num2)
			{
				walkable = false;
			}
		}
		gridNode.Walkable = walkable && collision.Check((Vector3)gridNode.position);
		gridNode.WalkableErosion = gridNode.Walkable;
	}

	protected virtual bool ErosionAnyFalseConnections(GraphNode baseNode)
	{
		GridNode node = baseNode as GridNode;
		if (neighbours == NumNeighbours.Six)
		{
			for (int i = 0; i < 6; i++)
			{
				if (!HasNodeConnection(node, hexagonNeighbourIndices[i]))
				{
					return true;
				}
			}
		}
		else
		{
			for (int j = 0; j < 4; j++)
			{
				if (!HasNodeConnection(node, j))
				{
					return true;
				}
			}
		}
		return false;
	}

	private void ErodeNode(GraphNode node)
	{
		if (node.Walkable && ErosionAnyFalseConnections(node))
		{
			node.Walkable = false;
		}
	}

	private void ErodeNodeWithTagsInit(GraphNode node)
	{
		if (node.Walkable && ErosionAnyFalseConnections(node))
		{
			node.Tag = (uint)erosionFirstTag;
		}
		else
		{
			node.Tag = 0u;
		}
	}

	private void ErodeNodeWithTags(GraphNode node, int iteration)
	{
		GridNodeBase gridNodeBase = node as GridNodeBase;
		if (!gridNodeBase.Walkable || gridNodeBase.Tag < erosionFirstTag || gridNodeBase.Tag >= erosionFirstTag + iteration)
		{
			return;
		}
		if (neighbours == NumNeighbours.Six)
		{
			for (int i = 0; i < 6; i++)
			{
				GridNodeBase neighbourAlongDirection = gridNodeBase.GetNeighbourAlongDirection(hexagonNeighbourIndices[i]);
				if (neighbourAlongDirection != null)
				{
					uint tag = neighbourAlongDirection.Tag;
					if (tag > erosionFirstTag + iteration || tag < erosionFirstTag)
					{
						neighbourAlongDirection.Tag = (uint)(erosionFirstTag + iteration);
					}
				}
			}
			return;
		}
		for (int j = 0; j < 4; j++)
		{
			GridNodeBase neighbourAlongDirection2 = gridNodeBase.GetNeighbourAlongDirection(j);
			if (neighbourAlongDirection2 != null)
			{
				uint tag2 = neighbourAlongDirection2.Tag;
				if (tag2 > erosionFirstTag + iteration || tag2 < erosionFirstTag)
				{
					neighbourAlongDirection2.Tag = (uint)(erosionFirstTag + iteration);
				}
			}
		}
	}

	public virtual void ErodeWalkableArea()
	{
		ErodeWalkableArea(0, 0, Width, Depth);
	}

	public void ErodeWalkableArea(int xmin, int zmin, int xmax, int zmax)
	{
		if (erosionUseTags)
		{
			if (erodeIterations + erosionFirstTag > 31)
			{
				Debug.LogError((object)("Too few tags available for " + erodeIterations + " erode iterations and starting with tag " + erosionFirstTag + " (erodeIterations+erosionFirstTag > 31)"));
				return;
			}
			if (erosionFirstTag <= 0)
			{
				Debug.LogError((object)"First erosion tag must be greater or equal to 1");
				return;
			}
		}
		if (erodeIterations == 0)
		{
			return;
		}
		IntRect rect = new IntRect(xmin, zmin, xmax - 1, zmax - 1);
		List<GraphNode> nodesInRegion = GetNodesInRegion(rect);
		int count = nodesInRegion.Count;
		for (int i = 0; i < erodeIterations; i++)
		{
			if (erosionUseTags)
			{
				if (i == 0)
				{
					for (int j = 0; j < count; j++)
					{
						ErodeNodeWithTagsInit(nodesInRegion[j]);
					}
				}
				else
				{
					for (int k = 0; k < count; k++)
					{
						ErodeNodeWithTags(nodesInRegion[k], i);
					}
				}
			}
			else
			{
				for (int l = 0; l < count; l++)
				{
					ErodeNode(nodesInRegion[l]);
				}
				for (int m = 0; m < count; m++)
				{
					CalculateConnections(nodesInRegion[m] as GridNodeBase);
				}
			}
		}
		ListPool<GraphNode>.Release(nodesInRegion);
	}

	public virtual bool IsValidConnection(GridNodeBase node1, GridNodeBase node2)
	{
		//IL_0063: Unknown result type (might be due to invalid IL or missing references)
		//IL_0068: Unknown result type (might be due to invalid IL or missing references)
		//IL_006f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0074: Unknown result type (might be due to invalid IL or missing references)
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_007c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0081: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0083: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_008a: Unknown result type (might be due to invalid IL or missing references)
		if (!node1.Walkable || !node2.Walkable)
		{
			return false;
		}
		if (maxClimb <= 0f)
		{
			return true;
		}
		if (transform.onlyTranslational)
		{
			return (float)Math.Abs(node1.position.y - node2.position.y) <= maxClimb * 1000f;
		}
		Vector3 val = (Vector3)node1.position;
		Vector3 val2 = (Vector3)node2.position;
		Vector3 val3 = transform.WorldUpAtGraphPosition(val);
		return Math.Abs(Vector3.Dot(val3, val) - Vector3.Dot(val3, val2)) <= maxClimb;
	}

	[Obsolete("Use the instance function instead")]
	public static void CalculateConnections(GridNode node)
	{
		(AstarData.GetGraph(node) as GridGraph).CalculateConnections((GridNodeBase)node);
	}

	public virtual void CalculateConnections(GridNodeBase node)
	{
		int nodeInGridIndex = node.NodeInGridIndex;
		int x = nodeInGridIndex % width;
		int z = nodeInGridIndex / width;
		CalculateConnections(x, z);
	}

	[Obsolete("CalculateConnections no longer takes a node array, it just uses the one on the graph")]
	public virtual void CalculateConnections(GridNode[] nodes, int x, int z, GridNode node)
	{
		CalculateConnections(x, z);
	}

	[Obsolete("Use CalculateConnections(x,z) or CalculateConnections(node) instead")]
	public virtual void CalculateConnections(int x, int z, GridNode node)
	{
		CalculateConnections(x, z);
	}

	public virtual void CalculateConnections(int x, int z)
	{
		GridNode gridNode = nodes[z * width + x];
		if (!gridNode.Walkable)
		{
			gridNode.ResetConnectionsInternal();
			return;
		}
		int nodeInGridIndex = gridNode.NodeInGridIndex;
		if (neighbours == NumNeighbours.Four || neighbours == NumNeighbours.Eight)
		{
			int num = 0;
			for (int i = 0; i < 4; i++)
			{
				int num2 = x + neighbourXOffsets[i];
				int num3 = z + neighbourZOffsets[i];
				if ((num2 >= 0) & (num3 >= 0) & (num2 < width) & (num3 < depth))
				{
					GridNode node = nodes[nodeInGridIndex + neighbourOffsets[i]];
					if (IsValidConnection(gridNode, node))
					{
						num |= 1 << i;
					}
				}
			}
			int num4 = 0;
			if (neighbours == NumNeighbours.Eight)
			{
				if (cutCorners)
				{
					for (int j = 0; j < 4; j++)
					{
						if ((((num >> j) | (num >> j + 1) | (num >> j + 1 - 4)) & 1) == 0)
						{
							continue;
						}
						int num5 = j + 4;
						int num6 = x + neighbourXOffsets[num5];
						int num7 = z + neighbourZOffsets[num5];
						if ((num6 >= 0) & (num7 >= 0) & (num6 < width) & (num7 < depth))
						{
							GridNode node2 = nodes[nodeInGridIndex + neighbourOffsets[num5]];
							if (IsValidConnection(gridNode, node2))
							{
								num4 |= 1 << num5;
							}
						}
					}
				}
				else
				{
					for (int k = 0; k < 4; k++)
					{
						if (((num >> k) & 1) != 0 && (((num >> k + 1) | (num >> k + 1 - 4)) & 1) != 0)
						{
							GridNode node3 = nodes[nodeInGridIndex + neighbourOffsets[k + 4]];
							if (IsValidConnection(gridNode, node3))
							{
								num4 |= 1 << k + 4;
							}
						}
					}
				}
			}
			gridNode.SetAllConnectionInternal(num | num4);
			return;
		}
		gridNode.ResetConnectionsInternal();
		for (int l = 0; l < hexagonNeighbourIndices.Length; l++)
		{
			int num8 = hexagonNeighbourIndices[l];
			int num9 = x + neighbourXOffsets[num8];
			int num10 = z + neighbourZOffsets[num8];
			if ((num9 >= 0) & (num10 >= 0) & (num9 < width) & (num10 < depth))
			{
				GridNode node4 = nodes[nodeInGridIndex + neighbourOffsets[num8]];
				gridNode.SetConnectionInternal(num8, IsValidConnection(gridNode, node4));
			}
		}
	}

	public void OnPostScan(AstarPath script)
	{
		AstarPath.OnPostScan = (OnScanDelegate)Delegate.Remove(AstarPath.OnPostScan, new OnScanDelegate(OnPostScan));
		if (!autoLinkGrids || autoLinkDistLimit <= 0f)
		{
			return;
		}
		throw new NotSupportedException();
	}

	public override void OnDrawGizmos(RetainedGizmos gizmos, bool drawNodes)
	{
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0023: Unknown result type (might be due to invalid IL or missing references)
		//IL_0031: Unknown result type (might be due to invalid IL or missing references)
		//IL_004b: Unknown result type (might be due to invalid IL or missing references)
		//IL_004d: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_0109: Unknown result type (might be due to invalid IL or missing references)
		//IL_0135: Unknown result type (might be due to invalid IL or missing references)
		//IL_013a: Unknown result type (might be due to invalid IL or missing references)
		//IL_014b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0150: Unknown result type (might be due to invalid IL or missing references)
		//IL_0155: Unknown result type (might be due to invalid IL or missing references)
		using (GraphGizmoHelper graphGizmoHelper = gizmos.GetSingleFrameGizmoHelper(active))
		{
			CalculateDimensions(out var num, out var num2, out var _);
			Bounds bounds = default(Bounds);
			((Bounds)(ref bounds)).SetMinMax(Vector3.zero, new Vector3((float)num, 0f, (float)num2));
			GraphTransform graphTransform = CalculateTransform();
			graphGizmoHelper.builder.DrawWireCube(graphTransform, bounds, Color.white);
			int num4 = ((nodes != null) ? nodes.Length : (-1));
			if (this is LayerGridGraph)
			{
				num4 = (((this as LayerGridGraph).nodes != null) ? (this as LayerGridGraph).nodes.Length : (-1));
			}
			if (drawNodes && width * depth * LayerCount != num4)
			{
				Color color = default(Color);
				((Color)(ref color))._002Ector(1f, 1f, 1f, 0.2f);
				for (int i = 0; i < num2; i++)
				{
					graphGizmoHelper.builder.DrawLine(graphTransform.Transform(new Vector3(0f, 0f, (float)i)), graphTransform.Transform(new Vector3((float)num, 0f, (float)i)), color);
				}
				for (int j = 0; j < num; j++)
				{
					graphGizmoHelper.builder.DrawLine(graphTransform.Transform(new Vector3((float)j, 0f, 0f)), graphTransform.Transform(new Vector3((float)j, 0f, (float)num2)), color);
				}
			}
		}
		if (!drawNodes)
		{
			return;
		}
		GridNodeBase[] array = ArrayPool<GridNodeBase>.ClaimWithExactLength(1024 * LayerCount);
		for (int num5 = width / 32; num5 >= 0; num5--)
		{
			for (int num6 = depth / 32; num6 >= 0; num6--)
			{
				int nodesInRegion = GetNodesInRegion(new IntRect(num5 * 32, num6 * 32, (num5 + 1) * 32 - 1, (num6 + 1) * 32 - 1), array);
				RetainedGizmos.Hasher hasher = new RetainedGizmos.Hasher(active);
				hasher.AddHash(showMeshOutline ? 1 : 0);
				hasher.AddHash(showMeshSurface ? 1 : 0);
				hasher.AddHash(showNodeConnections ? 1 : 0);
				for (int k = 0; k < nodesInRegion; k++)
				{
					hasher.HashNode(array[k]);
				}
				if (!gizmos.Draw(hasher))
				{
					using GraphGizmoHelper graphGizmoHelper2 = gizmos.GetGizmoHelper(active, hasher);
					if (showNodeConnections)
					{
						for (int l = 0; l < nodesInRegion; l++)
						{
							if (array[l].Walkable)
							{
								graphGizmoHelper2.DrawConnections(array[l]);
							}
						}
					}
					if (showMeshSurface || showMeshOutline)
					{
						CreateNavmeshSurfaceVisualization(array, nodesInRegion, graphGizmoHelper2);
					}
				}
			}
		}
		ArrayPool<GridNodeBase>.Release(ref array, allowNonPowerOfTwo: true);
		if (active.showUnwalkableNodes)
		{
			DrawUnwalkableNodes(nodeSize * 0.3f);
		}
	}

	private void CreateNavmeshSurfaceVisualization(GridNodeBase[] nodes, int nodeCount, GraphGizmoHelper helper)
	{
		//IL_009a: Unknown result type (might be due to invalid IL or missing references)
		//IL_009f: Unknown result type (might be due to invalid IL or missing references)
		//IL_00a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_0336: Unknown result type (might be due to invalid IL or missing references)
		//IL_033b: Unknown result type (might be due to invalid IL or missing references)
		//IL_034c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0351: Unknown result type (might be due to invalid IL or missing references)
		//IL_02b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_02b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_02c7: Unknown result type (might be due to invalid IL or missing references)
		//IL_02cc: Unknown result type (might be due to invalid IL or missing references)
		//IL_02dd: Unknown result type (might be due to invalid IL or missing references)
		//IL_02e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_02f2: Unknown result type (might be due to invalid IL or missing references)
		//IL_02f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_0309: Unknown result type (might be due to invalid IL or missing references)
		//IL_030e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0320: Unknown result type (might be due to invalid IL or missing references)
		//IL_0325: Unknown result type (might be due to invalid IL or missing references)
		//IL_0199: Unknown result type (might be due to invalid IL or missing references)
		//IL_019e: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c4: Unknown result type (might be due to invalid IL or missing references)
		//IL_01c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_01f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_0362: Unknown result type (might be due to invalid IL or missing references)
		//IL_0364: Unknown result type (might be due to invalid IL or missing references)
		//IL_021a: Unknown result type (might be due to invalid IL or missing references)
		//IL_021f: Unknown result type (might be due to invalid IL or missing references)
		//IL_03b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_03c8: Unknown result type (might be due to invalid IL or missing references)
		//IL_03d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_03d1: Unknown result type (might be due to invalid IL or missing references)
		//IL_0274: Unknown result type (might be due to invalid IL or missing references)
		//IL_0276: Unknown result type (might be due to invalid IL or missing references)
		//IL_027b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0284: Unknown result type (might be due to invalid IL or missing references)
		//IL_0286: Unknown result type (might be due to invalid IL or missing references)
		int num = 0;
		for (int i = 0; i < nodeCount; i++)
		{
			if (nodes[i].Walkable)
			{
				num++;
			}
		}
		int[] array = ((neighbours == NumNeighbours.Six) ? hexagonNeighbourIndices : new int[4] { -9985, -9984, -9983, -9982 });
		float num2 = ((neighbours == NumNeighbours.Six) ? 0.333333f : 0.5f);
		int num3 = array.Length - 2;
		int num4 = 3 * num3;
		Vector3[] array2 = ArrayPool<Vector3>.Claim(num * num4);
		Color[] array3 = ArrayPool<Color>.Claim(num * num4);
		int num5 = 0;
		Vector3 p = default(Vector3);
		for (int j = 0; j < nodeCount; j++)
		{
			GridNodeBase gridNodeBase = nodes[j];
			if (!gridNodeBase.Walkable)
			{
				continue;
			}
			Color val = helper.NodeColor(gridNodeBase);
			if (val.a <= 0.001f)
			{
				continue;
			}
			for (int k = 0; k < array.Length; k++)
			{
				int num6 = array[k];
				int num7 = array[(k + 1) % array.Length];
				GridNodeBase gridNodeBase2 = null;
				GridNodeBase neighbourAlongDirection = gridNodeBase.GetNeighbourAlongDirection(num6);
				if (neighbourAlongDirection != null && neighbours != NumNeighbours.Six)
				{
					gridNodeBase2 = neighbourAlongDirection.GetNeighbourAlongDirection(num7);
				}
				GridNodeBase neighbourAlongDirection2 = gridNodeBase.GetNeighbourAlongDirection(num7);
				if (neighbourAlongDirection2 != null && gridNodeBase2 == null && neighbours != NumNeighbours.Six)
				{
					gridNodeBase2 = neighbourAlongDirection2.GetNeighbourAlongDirection(num6);
				}
				((Vector3)(ref p))._002Ector((float)gridNodeBase.XCoordinateInGrid + 0.5f, 0f, (float)gridNodeBase.ZCoordinateInGrid + 0.5f);
				p.x += (float)(neighbourXOffsets[num6] + neighbourXOffsets[num7]) * num2;
				p.z += (float)(neighbourZOffsets[num6] + neighbourZOffsets[num7]) * num2;
				p.y += transform.InverseTransform((Vector3)gridNodeBase.position).y;
				if (neighbourAlongDirection != null)
				{
					p.y += transform.InverseTransform((Vector3)neighbourAlongDirection.position).y;
				}
				if (neighbourAlongDirection2 != null)
				{
					p.y += transform.InverseTransform((Vector3)neighbourAlongDirection2.position).y;
				}
				if (gridNodeBase2 != null)
				{
					p.y += transform.InverseTransform((Vector3)gridNodeBase2.position).y;
				}
				p.y /= 1f + ((neighbourAlongDirection != null) ? 1f : 0f) + ((neighbourAlongDirection2 != null) ? 1f : 0f) + ((gridNodeBase2 != null) ? 1f : 0f);
				p = (array2[num5 + k] = transform.Transform(p));
			}
			if (neighbours == NumNeighbours.Six)
			{
				array2[num5 + 6] = array2[num5];
				array2[num5 + 7] = array2[num5 + 2];
				array2[num5 + 8] = array2[num5 + 3];
				array2[num5 + 9] = array2[num5];
				array2[num5 + 10] = array2[num5 + 3];
				array2[num5 + 11] = array2[num5 + 5];
			}
			else
			{
				array2[num5 + 4] = array2[num5];
				array2[num5 + 5] = array2[num5 + 2];
			}
			for (int l = 0; l < num4; l++)
			{
				array3[num5 + l] = val;
			}
			for (int m = 0; m < array.Length; m++)
			{
				GridNodeBase neighbourAlongDirection3 = gridNodeBase.GetNeighbourAlongDirection(array[(m + 1) % array.Length]);
				if (neighbourAlongDirection3 == null || (showMeshOutline && gridNodeBase.NodeInGridIndex < neighbourAlongDirection3.NodeInGridIndex))
				{
					helper.builder.DrawLine(array2[num5 + m], array2[num5 + (m + 1) % array.Length], (neighbourAlongDirection3 == null) ? Color.black : val);
				}
			}
			num5 += num4;
		}
		if (showMeshSurface)
		{
			helper.DrawTriangles(array2, array3, num5 * num3 / num4);
		}
		ArrayPool<Vector3>.Release(ref array2);
		ArrayPool<Color>.Release(ref array3);
	}

	protected IntRect GetRectFromBounds(Bounds bounds)
	{
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0010: Unknown result type (might be due to invalid IL or missing references)
		//IL_0015: Unknown result type (might be due to invalid IL or missing references)
		//IL_0018: Unknown result type (might be due to invalid IL or missing references)
		//IL_001d: Unknown result type (might be due to invalid IL or missing references)
		//IL_001e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0030: Unknown result type (might be due to invalid IL or missing references)
		//IL_0042: Unknown result type (might be due to invalid IL or missing references)
		//IL_0055: Unknown result type (might be due to invalid IL or missing references)
		bounds = transform.InverseTransform(bounds);
		Vector3 min = ((Bounds)(ref bounds)).min;
		Vector3 max = ((Bounds)(ref bounds)).max;
		int xmin = Mathf.RoundToInt(min.x - 0.5f);
		int xmax = Mathf.RoundToInt(max.x - 0.5f);
		int ymin = Mathf.RoundToInt(min.z - 0.5f);
		int ymax = Mathf.RoundToInt(max.z - 0.5f);
		IntRect a = new IntRect(xmin, ymin, xmax, ymax);
		IntRect b = new IntRect(0, 0, width - 1, depth - 1);
		return IntRect.Intersection(a, b);
	}

	[Obsolete("This method has been renamed to GetNodesInRegion", true)]
	public List<GraphNode> GetNodesInArea(Bounds bounds)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return GetNodesInRegion(bounds);
	}

	[Obsolete("This method has been renamed to GetNodesInRegion", true)]
	public List<GraphNode> GetNodesInArea(GraphUpdateShape shape)
	{
		return GetNodesInRegion(shape);
	}

	[Obsolete("This method has been renamed to GetNodesInRegion", true)]
	public List<GraphNode> GetNodesInArea(Bounds bounds, GraphUpdateShape shape)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return GetNodesInRegion(bounds, shape);
	}

	public virtual GridNodeBase GetNode(int x, int z)
	{
		if (x < 0 || z < 0 || x >= width || z >= depth)
		{
			return null;
		}
		return nodes[x + z * width];
	}

	public List<GraphNode> GetNodesInRegion(Bounds bounds)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		return GetNodesInRegion(bounds, null);
	}

	public List<GraphNode> GetNodesInRegion(GraphUpdateShape shape)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		return GetNodesInRegion(shape.GetBounds(), shape);
	}

	protected virtual List<GraphNode> GetNodesInRegion(Bounds bounds, GraphUpdateShape shape)
	{
		//IL_0001: Unknown result type (might be due to invalid IL or missing references)
		//IL_007d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0094: Unknown result type (might be due to invalid IL or missing references)
		IntRect rectFromBounds = GetRectFromBounds(bounds);
		if (nodes == null || !rectFromBounds.IsValid() || nodes.Length != width * depth)
		{
			return ListPool<GraphNode>.Claim();
		}
		List<GraphNode> list = ListPool<GraphNode>.Claim(rectFromBounds.Width * rectFromBounds.Height);
		for (int i = rectFromBounds.xmin; i <= rectFromBounds.xmax; i++)
		{
			for (int j = rectFromBounds.ymin; j <= rectFromBounds.ymax; j++)
			{
				int num = j * width + i;
				GraphNode graphNode = nodes[num];
				if (((Bounds)(ref bounds)).Contains((Vector3)graphNode.position) && (shape == null || shape.Contains((Vector3)graphNode.position)))
				{
					list.Add(graphNode);
				}
			}
		}
		return list;
	}

	public virtual List<GraphNode> GetNodesInRegion(IntRect rect)
	{
		rect = IntRect.Intersection(b: new IntRect(0, 0, width - 1, depth - 1), a: rect);
		if (nodes == null || !rect.IsValid() || nodes.Length != width * depth)
		{
			return ListPool<GraphNode>.Claim(0);
		}
		List<GraphNode> list = ListPool<GraphNode>.Claim(rect.Width * rect.Height);
		for (int i = rect.ymin; i <= rect.ymax; i++)
		{
			int num = i * Width;
			for (int j = rect.xmin; j <= rect.xmax; j++)
			{
				list.Add(nodes[num + j]);
			}
		}
		return list;
	}

	public virtual int GetNodesInRegion(IntRect rect, GridNodeBase[] buffer)
	{
		rect = IntRect.Intersection(b: new IntRect(0, 0, width - 1, depth - 1), a: rect);
		if (nodes == null || !rect.IsValid() || nodes.Length != width * depth)
		{
			return 0;
		}
		if (buffer.Length < rect.Width * rect.Height)
		{
			throw new ArgumentException("Buffer is too small");
		}
		int num = 0;
		int num2 = rect.ymin;
		while (num2 <= rect.ymax)
		{
			Array.Copy(nodes, num2 * Width + rect.xmin, buffer, num, rect.Width);
			num2++;
			num += rect.Width;
		}
		return num;
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

	protected void CalculateAffectedRegions(GraphUpdateObject o, out IntRect originalRect, out IntRect affectRect, out IntRect physicsRect, out bool willChangeWalkability, out int erosion)
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0014: Unknown result type (might be due to invalid IL or missing references)
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_001c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0021: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		//IL_0034: Unknown result type (might be due to invalid IL or missing references)
		//IL_0047: Unknown result type (might be due to invalid IL or missing references)
		//IL_005a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0110: Unknown result type (might be due to invalid IL or missing references)
		//IL_0112: Unknown result type (might be due to invalid IL or missing references)
		//IL_0113: Unknown result type (might be due to invalid IL or missing references)
		//IL_011a: Unknown result type (might be due to invalid IL or missing references)
		//IL_011f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0124: Unknown result type (might be due to invalid IL or missing references)
		//IL_0125: Unknown result type (might be due to invalid IL or missing references)
		//IL_0126: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0132: Unknown result type (might be due to invalid IL or missing references)
		//IL_0137: Unknown result type (might be due to invalid IL or missing references)
		//IL_013a: Unknown result type (might be due to invalid IL or missing references)
		//IL_014b: Unknown result type (might be due to invalid IL or missing references)
		//IL_015c: Unknown result type (might be due to invalid IL or missing references)
		//IL_016d: Unknown result type (might be due to invalid IL or missing references)
		Bounds val = transform.InverseTransform(o.bounds);
		Vector3 min = ((Bounds)(ref val)).min;
		Vector3 max = ((Bounds)(ref val)).max;
		int xmin = Mathf.RoundToInt(min.x - 0.5f);
		int xmax = Mathf.RoundToInt(max.x - 0.5f);
		int ymin = Mathf.RoundToInt(min.z - 0.5f);
		int ymax = Mathf.RoundToInt(max.z - 0.5f);
		originalRect = new IntRect(xmin, ymin, xmax, ymax);
		affectRect = originalRect;
		physicsRect = originalRect;
		erosion = (o.updateErosion ? erodeIterations : 0);
		willChangeWalkability = o.updatePhysics || o.modifyWalkability;
		if (o.updatePhysics && !o.modifyWalkability && collision.collisionCheck)
		{
			Vector3 val2 = new Vector3(collision.diameter, 0f, collision.diameter) * 0.5f;
			min -= val2 * 1.02f;
			max += val2 * 1.02f;
			physicsRect = new IntRect(Mathf.RoundToInt(min.x - 0.5f), Mathf.RoundToInt(min.z - 0.5f), Mathf.RoundToInt(max.x - 0.5f), Mathf.RoundToInt(max.z - 0.5f));
			affectRect = IntRect.Union(physicsRect, affectRect);
		}
		if (willChangeWalkability || erosion > 0)
		{
			affectRect = affectRect.Expand(erosion + 1);
		}
	}

	public void UpdateArea(GraphUpdateObject o)
	{
		//IL_01b7: Unknown result type (might be due to invalid IL or missing references)
		//IL_0186: Unknown result type (might be due to invalid IL or missing references)
		if (nodes == null || nodes.Length != width * depth)
		{
			Debug.LogWarning((object)"The Grid Graph is not scanned, cannot update area");
			return;
		}
		CalculateAffectedRegions(o, out var originalRect, out var affectRect, out var physicsRect, out var willChangeWalkability, out var erosion);
		IntRect b = new IntRect(0, 0, width - 1, depth - 1);
		IntRect intRect = IntRect.Intersection(affectRect, b);
		for (int i = intRect.xmin; i <= intRect.xmax; i++)
		{
			for (int j = intRect.ymin; j <= intRect.ymax; j++)
			{
				o.WillUpdateNode(nodes[j * width + i]);
			}
		}
		if (o.updatePhysics && !o.modifyWalkability)
		{
			collision.Initialize(transform, nodeSize);
			intRect = IntRect.Intersection(physicsRect, b);
			for (int k = intRect.xmin; k <= intRect.xmax; k++)
			{
				for (int l = intRect.ymin; l <= intRect.ymax; l++)
				{
					RecalculateCell(k, l, o.resetPenaltyOnPhysics, resetTags: false);
				}
			}
		}
		intRect = IntRect.Intersection(originalRect, b);
		for (int m = intRect.xmin; m <= intRect.xmax; m++)
		{
			for (int n = intRect.ymin; n <= intRect.ymax; n++)
			{
				int num = n * width + m;
				GridNode gridNode = nodes[num];
				if (willChangeWalkability)
				{
					gridNode.Walkable = gridNode.WalkableErosion;
					if (((Bounds)(ref o.bounds)).Contains((Vector3)gridNode.position))
					{
						o.Apply(gridNode);
					}
					gridNode.WalkableErosion = gridNode.Walkable;
				}
				else if (((Bounds)(ref o.bounds)).Contains((Vector3)gridNode.position))
				{
					o.Apply(gridNode);
				}
			}
		}
		if (willChangeWalkability && erosion == 0)
		{
			intRect = IntRect.Intersection(affectRect, b);
			for (int num2 = intRect.xmin; num2 <= intRect.xmax; num2++)
			{
				for (int num3 = intRect.ymin; num3 <= intRect.ymax; num3++)
				{
					CalculateConnections(num2, num3);
				}
			}
		}
		else
		{
			if (!willChangeWalkability || erosion <= 0)
			{
				return;
			}
			IntRect a = IntRect.Union(originalRect, physicsRect).Expand(erosion);
			IntRect a2 = a.Expand(erosion);
			a = IntRect.Intersection(a, b);
			a2 = IntRect.Intersection(a2, b);
			for (int num4 = a2.xmin; num4 <= a2.xmax; num4++)
			{
				for (int num5 = a2.ymin; num5 <= a2.ymax; num5++)
				{
					int num6 = num5 * width + num4;
					GridNode gridNode2 = nodes[num6];
					bool walkable = gridNode2.Walkable;
					gridNode2.Walkable = gridNode2.WalkableErosion;
					if (!a.Contains(num4, num5))
					{
						gridNode2.TmpWalkable = walkable;
					}
				}
			}
			for (int num7 = a2.xmin; num7 <= a2.xmax; num7++)
			{
				for (int num8 = a2.ymin; num8 <= a2.ymax; num8++)
				{
					CalculateConnections(num7, num8);
				}
			}
			ErodeWalkableArea(a2.xmin, a2.ymin, a2.xmax + 1, a2.ymax + 1);
			for (int num9 = a2.xmin; num9 <= a2.xmax; num9++)
			{
				for (int num10 = a2.ymin; num10 <= a2.ymax; num10++)
				{
					if (!a.Contains(num9, num10))
					{
						int num11 = num10 * width + num9;
						GridNode gridNode3 = nodes[num11];
						gridNode3.Walkable = gridNode3.TmpWalkable;
					}
				}
			}
			for (int num12 = a2.xmin; num12 <= a2.xmax; num12++)
			{
				for (int num13 = a2.ymin; num13 <= a2.ymax; num13++)
				{
					CalculateConnections(num12, num13);
				}
			}
		}
	}

	public bool Linecast(Int3 from, Int3 to)
	{
		GraphHitInfo hit;
		return Linecast(from, to, null, out hit);
	}

	public bool Linecast(Int3 from, Int3 to, GraphNode hint)
	{
		GraphHitInfo hit;
		return Linecast(from, to, hint, out hit);
	}

	public bool Linecast(Int3 from, Int3 to, GraphNode hint, out GraphHitInfo hit)
	{
		return Linecast(from, to, hint, out hit, null);
	}

	protected static float CrossMagnitude(Vector2 a, Vector2 b)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_0006: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		return a.x * b.y - b.x * a.y;
	}

	protected bool ClipLineSegmentToBounds(Vector3 a, Vector3 b, out Vector3 outA, out Vector3 outB)
	{
		//IL_0000: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d9: Unknown result type (might be due to invalid IL or missing references)
		//IL_00dc: Unknown result type (might be due to invalid IL or missing references)
		//IL_00e1: Unknown result type (might be due to invalid IL or missing references)
		//IL_000d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0101: Unknown result type (might be due to invalid IL or missing references)
		//IL_0102: Unknown result type (might be due to invalid IL or missing references)
		//IL_0103: Unknown result type (might be due to invalid IL or missing references)
		//IL_0104: Unknown result type (might be due to invalid IL or missing references)
		//IL_0107: Unknown result type (might be due to invalid IL or missing references)
		//IL_010c: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ed: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ee: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_012c: Unknown result type (might be due to invalid IL or missing references)
		//IL_012d: Unknown result type (might be due to invalid IL or missing references)
		//IL_012e: Unknown result type (might be due to invalid IL or missing references)
		//IL_012f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0132: Unknown result type (might be due to invalid IL or missing references)
		//IL_0137: Unknown result type (might be due to invalid IL or missing references)
		//IL_0118: Unknown result type (might be due to invalid IL or missing references)
		//IL_0119: Unknown result type (might be due to invalid IL or missing references)
		//IL_011a: Unknown result type (might be due to invalid IL or missing references)
		//IL_00fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ff: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f7: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0029: Unknown result type (might be due to invalid IL or missing references)
		//IL_0157: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		//IL_0159: Unknown result type (might be due to invalid IL or missing references)
		//IL_015a: Unknown result type (might be due to invalid IL or missing references)
		//IL_015d: Unknown result type (might be due to invalid IL or missing references)
		//IL_0162: Unknown result type (might be due to invalid IL or missing references)
		//IL_0143: Unknown result type (might be due to invalid IL or missing references)
		//IL_0144: Unknown result type (might be due to invalid IL or missing references)
		//IL_0145: Unknown result type (might be due to invalid IL or missing references)
		//IL_0128: Unknown result type (might be due to invalid IL or missing references)
		//IL_012a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0122: Unknown result type (might be due to invalid IL or missing references)
		//IL_0124: Unknown result type (might be due to invalid IL or missing references)
		//IL_0038: Unknown result type (might be due to invalid IL or missing references)
		//IL_016e: Unknown result type (might be due to invalid IL or missing references)
		//IL_016f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0170: Unknown result type (might be due to invalid IL or missing references)
		//IL_0153: Unknown result type (might be due to invalid IL or missing references)
		//IL_0155: Unknown result type (might be due to invalid IL or missing references)
		//IL_014d: Unknown result type (might be due to invalid IL or missing references)
		//IL_014f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0045: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a0: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a1: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_0187: Unknown result type (might be due to invalid IL or missing references)
		//IL_018c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0193: Unknown result type (might be due to invalid IL or missing references)
		//IL_0198: Unknown result type (might be due to invalid IL or missing references)
		//IL_017e: Unknown result type (might be due to invalid IL or missing references)
		//IL_0180: Unknown result type (might be due to invalid IL or missing references)
		//IL_0178: Unknown result type (might be due to invalid IL or missing references)
		//IL_017a: Unknown result type (might be due to invalid IL or missing references)
		//IL_0052: Unknown result type (might be due to invalid IL or missing references)
		//IL_0061: Unknown result type (might be due to invalid IL or missing references)
		if (a.x < 0f || a.z < 0f || a.x > (float)width || a.z > (float)depth || b.x < 0f || b.z < 0f || b.x > (float)width || b.z > (float)depth)
		{
			Vector3 val = default(Vector3);
			((Vector3)(ref val))._002Ector(0f, 0f, 0f);
			Vector3 val2 = default(Vector3);
			((Vector3)(ref val2))._002Ector(0f, 0f, (float)depth);
			Vector3 val3 = default(Vector3);
			((Vector3)(ref val3))._002Ector((float)width, 0f, (float)depth);
			Vector3 val4 = default(Vector3);
			((Vector3)(ref val4))._002Ector((float)width, 0f, 0f);
			int num = 0;
			Vector3 val5 = VectorMath.SegmentIntersectionPointXZ(a, b, val, val2, out var intersects);
			if (intersects)
			{
				num++;
				if (!VectorMath.RightOrColinearXZ(val, val2, a))
				{
					a = val5;
				}
				else
				{
					b = val5;
				}
			}
			val5 = VectorMath.SegmentIntersectionPointXZ(a, b, val2, val3, out intersects);
			if (intersects)
			{
				num++;
				if (!VectorMath.RightOrColinearXZ(val2, val3, a))
				{
					a = val5;
				}
				else
				{
					b = val5;
				}
			}
			val5 = VectorMath.SegmentIntersectionPointXZ(a, b, val3, val4, out intersects);
			if (intersects)
			{
				num++;
				if (!VectorMath.RightOrColinearXZ(val3, val4, a))
				{
					a = val5;
				}
				else
				{
					b = val5;
				}
			}
			val5 = VectorMath.SegmentIntersectionPointXZ(a, b, val4, val, out intersects);
			if (intersects)
			{
				num++;
				if (!VectorMath.RightOrColinearXZ(val4, val, a))
				{
					a = val5;
				}
				else
				{
					b = val5;
				}
			}
			if (num == 0)
			{
				outA = Vector3.zero;
				outB = Vector3.zero;
				return false;
			}
		}
		outA = a;
		outB = b;
		return true;
	}

	protected bool ClipLineSegmentToBounds(Int3 a, Int3 b, out Int3 outA, out Int3 outB)
	{
		if (a.x < 0 || a.z < 0 || a.x > width || a.z > depth || b.x < 0 || b.z < 0 || b.x > width || b.z > depth)
		{
			Int3 @int = new Int3(0, 0, 0);
			Int3 int2 = new Int3(0, 0, depth * 1000);
			Int3 int3 = new Int3(width * 1000, 0, depth * 1000);
			Int3 int4 = new Int3(width * 1000, 0, 0);
			int num = 0;
			Int3 int5 = VectorMath.SegmentIntersectionPointXZ(a, b, @int, int2, out var intersects);
			if (intersects)
			{
				num++;
				if (!VectorMath.RightOrColinearXZ(@int, int2, a))
				{
					a = int5;
				}
				else
				{
					b = int5;
				}
			}
			int5 = VectorMath.SegmentIntersectionPointXZ(a, b, int2, int3, out intersects);
			if (intersects)
			{
				num++;
				if (!VectorMath.RightOrColinearXZ(int2, int3, a))
				{
					a = int5;
				}
				else
				{
					b = int5;
				}
			}
			int5 = VectorMath.SegmentIntersectionPointXZ(a, b, int3, int4, out intersects);
			if (intersects)
			{
				num++;
				if (!VectorMath.RightOrColinearXZ(int3, int4, a))
				{
					a = int5;
				}
				else
				{
					b = int5;
				}
			}
			int5 = VectorMath.SegmentIntersectionPointXZ(a, b, int4, @int, out intersects);
			if (intersects)
			{
				num++;
				if (!VectorMath.RightOrColinearXZ(int4, @int, a))
				{
					a = int5;
				}
				else
				{
					b = int5;
				}
			}
			if (num == 0)
			{
				outA = Int3.zero;
				outB = Int3.zero;
				return false;
			}
		}
		outA = a;
		outB = b;
		return true;
	}

	public bool Linecast(Int3 from, Int3 to, GraphNode hint, out GraphHitInfo hit, List<GraphNode> trace)
	{
		//IL_010b: Unknown result type (might be due to invalid IL or missing references)
		//IL_010d: Unknown result type (might be due to invalid IL or missing references)
		//IL_010f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0114: Unknown result type (might be due to invalid IL or missing references)
		//IL_0118: Unknown result type (might be due to invalid IL or missing references)
		//IL_0124: Unknown result type (might be due to invalid IL or missing references)
		//IL_0135: Unknown result type (might be due to invalid IL or missing references)
		//IL_0137: Unknown result type (might be due to invalid IL or missing references)
		//IL_0146: Unknown result type (might be due to invalid IL or missing references)
		//IL_0158: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a5: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01a9: Unknown result type (might be due to invalid IL or missing references)
		//IL_01ab: Unknown result type (might be due to invalid IL or missing references)
		//IL_01e7: Unknown result type (might be due to invalid IL or missing references)
		//IL_01fd: Unknown result type (might be due to invalid IL or missing references)
		//IL_0207: Unknown result type (might be due to invalid IL or missing references)
		//IL_020c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0211: Unknown result type (might be due to invalid IL or missing references)
		//IL_0242: Unknown result type (might be due to invalid IL or missing references)
		//IL_0244: Unknown result type (might be due to invalid IL or missing references)
		//IL_0246: Unknown result type (might be due to invalid IL or missing references)
		//IL_0248: Unknown result type (might be due to invalid IL or missing references)
		//IL_024d: Unknown result type (might be due to invalid IL or missing references)
		//IL_024f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0251: Unknown result type (might be due to invalid IL or missing references)
		//IL_0256: Unknown result type (might be due to invalid IL or missing references)
		//IL_0265: Unknown result type (might be due to invalid IL or missing references)
		//IL_026a: Unknown result type (might be due to invalid IL or missing references)
		//IL_026f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0273: Unknown result type (might be due to invalid IL or missing references)
		//IL_0280: Unknown result type (might be due to invalid IL or missing references)
		//IL_0287: Unknown result type (might be due to invalid IL or missing references)
		//IL_029b: Unknown result type (might be due to invalid IL or missing references)
		//IL_02a8: Unknown result type (might be due to invalid IL or missing references)
		//IL_02af: Unknown result type (might be due to invalid IL or missing references)
		//IL_02c9: Unknown result type (might be due to invalid IL or missing references)
		//IL_02e2: Unknown result type (might be due to invalid IL or missing references)
		//IL_02fb: Unknown result type (might be due to invalid IL or missing references)
		//IL_0307: Unknown result type (might be due to invalid IL or missing references)
		//IL_030e: Unknown result type (might be due to invalid IL or missing references)
		hit = default(GraphHitInfo);
		hit.origin = from;
		Int3 outA = transform.InverseTransform(from);
		Int3 outB = transform.InverseTransform(to);
		if (!ClipLineSegmentToBounds(outA, outB, out outA, out outB))
		{
			return false;
		}
		GridNodeBase gridNodeBase = GetNearest(transform.Transform(outA), NNConstraint.None).node as GridNodeBase;
		GridNodeBase gridNodeBase2 = GetNearest(transform.Transform(outB), NNConstraint.None).node as GridNodeBase;
		if (!gridNodeBase.Walkable)
		{
			hit.node = gridNodeBase;
			hit.point = transform.Transform(outA);
			hit.tangentOrigin = hit.point;
			return true;
		}
		Vector2 val = default(Vector2);
		((Vector2)(ref val))._002Ector((float)outA.x - 0.5f, (float)outA.z - 0.5f);
		Vector2 val2 = default(Vector2);
		((Vector2)(ref val2))._002Ector((float)outB.x - 0.5f, (float)outB.z - 0.5f);
		if (gridNodeBase == null || gridNodeBase2 == null)
		{
			hit.node = null;
			hit.point = from;
			return true;
		}
		Vector2 val3 = val2 - val;
		Vector2 b = default(Vector2);
		((Vector2)(ref b))._002Ector(Mathf.Sign(val3.x), Mathf.Sign(val3.y));
		float num = CrossMagnitude(val3, b) * 0.5f;
		int num2 = ((!(val3.y >= 0f)) ? 3 : 0) ^ ((!(val3.x >= 0f)) ? 1 : 0);
		int num3 = (num2 + 1) & 3;
		int num4 = (num2 + 2) & 3;
		GridNodeBase gridNodeBase3 = gridNodeBase;
		Vector2 val4 = default(Vector2);
		Vector2 val6 = default(Vector2);
		Vector3 val9 = default(Vector3);
		Vector3 val10 = default(Vector3);
		while (gridNodeBase3.NodeInGridIndex != gridNodeBase2.NodeInGridIndex)
		{
			trace?.Add(gridNodeBase3);
			((Vector2)(ref val4))._002Ector((float)gridNodeBase3.XCoordinateInGrid, (float)gridNodeBase3.ZCoordinateInGrid);
			float num5 = CrossMagnitude(val3, val4 - val);
			float num6 = num5 + num;
			int num7 = ((num6 < 0f) ? num4 : num3);
			GridNodeBase neighbourAlongDirection = gridNodeBase3.GetNeighbourAlongDirection(num7);
			if (neighbourAlongDirection != null)
			{
				gridNodeBase3 = neighbourAlongDirection;
				continue;
			}
			Vector2 val5 = val4 + new Vector2((float)neighbourXOffsets[num7], (float)neighbourZOffsets[num7]) * 0.5f;
			if (neighbourXOffsets[num7] == 0)
			{
				((Vector2)(ref val6))._002Ector(1f, 0f);
			}
			else
			{
				((Vector2)(ref val6))._002Ector(0f, 1f);
			}
			Vector2 val7 = VectorMath.LineIntersectionPoint(val5, val5 + val6, val, val2);
			Vector3 val8 = transform.InverseTransform((Vector3)gridNodeBase3.position);
			((Vector3)(ref val9))._002Ector(val7.x + 0.5f, val8.y, val7.y + 0.5f);
			((Vector3)(ref val10))._002Ector(val5.x + 0.5f, val8.y, val5.y + 0.5f);
			hit.point = transform.Transform((Int3)val9);
			hit.tangentOrigin = transform.Transform((Int3)val10);
			hit.tangent = transform.TransformVector((Int3)new Vector3(val6.x, 0f, val6.y));
			hit.node = gridNodeBase3;
			return true;
		}
		trace?.Add(gridNodeBase3);
		if (gridNodeBase3 == gridNodeBase2)
		{
			return false;
		}
		hit.point = gridNodeBase3.position;
		hit.tangentOrigin = hit.point;
		return true;
	}

	public bool SnappedLinecast(Int3 from, Int3 to, GraphNode hint, out GraphHitInfo hit)
	{
		return Linecast(GetNearest(from, NNConstraint.None).node.position, GetNearest(to, NNConstraint.None).node.position, hint, out hit);
	}

	public bool CheckConnection(GridNode node, int dir)
	{
		if (neighbours == NumNeighbours.Eight || neighbours == NumNeighbours.Six || dir < 4)
		{
			return HasNodeConnection(node, dir);
		}
		int num = (dir - 4 - 1) & 3;
		int num2 = (dir - 4 + 1) & 3;
		if (!HasNodeConnection(node, num) || !HasNodeConnection(node, num2))
		{
			return false;
		}
		GridNode gridNode = nodes[node.NodeInGridIndex + neighbourOffsets[num]];
		GridNode gridNode2 = nodes[node.NodeInGridIndex + neighbourOffsets[num2]];
		if (!gridNode.Walkable || !gridNode2.Walkable)
		{
			return false;
		}
		if (!HasNodeConnection(gridNode2, num) || !HasNodeConnection(gridNode, num2))
		{
			return false;
		}
		return true;
	}

	public override void SerializeExtraInfo(GraphSerializationContext ctx)
	{
		if (nodes == null)
		{
			ctx.writer.Write(-1);
			return;
		}
		ctx.writer.Write(nodes.Length);
		for (int i = 0; i < nodes.Length; i++)
		{
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
		nodes = new GridNode[num];
		for (int i = 0; i < nodes.Length; i++)
		{
			nodes[i] = new GridNode(active);
			nodes[i].DeserializeNode(ctx);
		}
	}

	public override void DeserializeSettingsCompatibility(GraphSerializationContext ctx)
	{
		//IL_001a: Unknown result type (might be due to invalid IL or missing references)
		//IL_001f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0026: Unknown result type (might be due to invalid IL or missing references)
		//IL_002b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0032: Unknown result type (might be due to invalid IL or missing references)
		//IL_0037: Unknown result type (might be due to invalid IL or missing references)
		//IL_003c: Unknown result type (might be due to invalid IL or missing references)
		base.DeserializeSettingsCompatibility(ctx);
		aspectRatio = ctx.reader.ReadSingle();
		rotation = ctx.DeserializeVector3();
		center = ctx.DeserializeVector3();
		unclampedSize = Vector2.op_Implicit(ctx.DeserializeVector3());
		nodeSize = ctx.reader.ReadSingle();
		collision.DeserializeSettingsCompatibility(ctx);
		maxClimb = ctx.reader.ReadSingle();
		ctx.reader.ReadInt32();
		maxSlope = ctx.reader.ReadSingle();
		erodeIterations = ctx.reader.ReadInt32();
		erosionUseTags = ctx.reader.ReadBoolean();
		erosionFirstTag = ctx.reader.ReadInt32();
		autoLinkGrids = ctx.reader.ReadBoolean();
		neighbours = (NumNeighbours)ctx.reader.ReadInt32();
		cutCorners = ctx.reader.ReadBoolean();
		penaltyPosition = ctx.reader.ReadBoolean();
		penaltyPositionFactor = ctx.reader.ReadSingle();
		penaltyAngle = ctx.reader.ReadBoolean();
		penaltyAngleFactor = ctx.reader.ReadSingle();
		penaltyAnglePower = ctx.reader.ReadSingle();
		isometricAngle = ctx.reader.ReadSingle();
		uniformEdgeCosts = ctx.reader.ReadBoolean();
		useJumpPointSearch = ctx.reader.ReadBoolean();
	}

	public override void PostDeserialization()
	{
		UpdateTransform();
		SetUpOffsetsAndCosts();
		GridNode.SetGridGraph((int)graphIndex, this);
		if (nodes == null || nodes.Length == 0)
		{
			return;
		}
		if (width * depth != nodes.Length)
		{
			Debug.LogError((object)"Node data did not match with bounds data. Probably a change to the bounds/width/depth data was made after scanning the graph just prior to saving it. Nodes will be discarded");
			nodes = new GridNode[0];
			return;
		}
		for (int i = 0; i < depth; i++)
		{
			for (int j = 0; j < width; j++)
			{
				GridNode gridNode = nodes[i * width + j];
				if (gridNode == null)
				{
					Debug.LogError((object)"Deserialization Error : Couldn't cast the node to the appropriate type - GridGenerator");
					return;
				}
				gridNode.NodeInGridIndex = i * width + j;
			}
		}
	}
}
