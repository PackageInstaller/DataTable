using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

public class GraphUpdateObject
{
	public Bounds bounds;

	public bool requiresFloodFill;

	public bool updatePhysics;

	public bool resetPenaltyOnPhysics;

	public bool updateErosion;

	public NNConstraint nnConstraint;

	public int addPenalty;

	public bool modifyWalkability;

	public bool setWalkability;

	public bool modifyTag;

	public int setTag;

	public bool trackChangedNodes;

	public List<GraphNode> changedNodes;

	private List<uint> backupData;

	private List<Int3> backupPositionData;

	public GraphUpdateShape shape;

	public virtual void WillUpdateNode(GraphNode node)
	{
		if (trackChangedNodes && node != null)
		{
			if (changedNodes == null)
			{
				changedNodes = ListPool<GraphNode>.Claim();
				backupData = ListPool<uint>.Claim();
				backupPositionData = ListPool<Int3>.Claim();
			}
			changedNodes.Add(node);
			backupPositionData.Add(node.position);
			backupData.Add(node.Penalty);
			backupData.Add(node.Flags);
			if (node is GridNode gridNode)
			{
				backupData.Add(gridNode.InternalGridFlags);
			}
		}
	}

	public virtual void RevertFromBackup()
	{
		if (trackChangedNodes)
		{
			if (changedNodes == null)
			{
				return;
			}
			int num = 0;
			for (int i = 0; i < changedNodes.Count; i++)
			{
				changedNodes[i].Penalty = backupData[num];
				num++;
				changedNodes[i].Flags = backupData[num];
				num++;
				if (changedNodes[i] is GridNode gridNode)
				{
					gridNode.InternalGridFlags = (ushort)backupData[num];
					num++;
				}
				changedNodes[i].position = backupPositionData[i];
			}
			ListPool<GraphNode>.Release(changedNodes);
			ListPool<uint>.Release(backupData);
			ListPool<Int3>.Release(backupPositionData);
			return;
		}
		throw new InvalidOperationException("Changed nodes have not been tracked, cannot revert from backup");
	}

	public virtual void Apply(GraphNode node)
	{
		if (shape == null || shape.Contains(node))
		{
			node.Penalty = (uint)(node.Penalty + addPenalty);
			if (modifyWalkability)
			{
				node.Walkable = setWalkability;
			}
			if (modifyTag)
			{
				node.Tag = (uint)setTag;
			}
		}
	}

	public GraphUpdateObject()
	{
		requiresFloodFill = true;
		updatePhysics = true;
		resetPenaltyOnPhysics = true;
		updateErosion = true;
		nnConstraint = NNConstraint.None;
		base._002Ector();
	}

	public GraphUpdateObject(Bounds b)
	{
		//IL_002e: Unknown result type (might be due to invalid IL or missing references)
		//IL_002f: Unknown result type (might be due to invalid IL or missing references)
		requiresFloodFill = true;
		updatePhysics = true;
		resetPenaltyOnPhysics = true;
		updateErosion = true;
		nnConstraint = NNConstraint.None;
		base._002Ector();
		bounds = b;
	}
}
