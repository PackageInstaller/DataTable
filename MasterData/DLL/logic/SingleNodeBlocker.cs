using System;
using Pathfinding;
using UnityEngine;

[HelpURL("http://arongranberg.com/astar/docs/class_single_node_blocker.php")]
public class SingleNodeBlocker : VersionedMonoBehaviour
{
	public BlockManager manager;

	public GraphNode lastBlocked { get; private set; }

	public void BlockAtCurrentPosition()
	{
		//IL_0007: Unknown result type (might be due to invalid IL or missing references)
		BlockAt(((Component)this).transform.position);
	}

	public void BlockAt(Vector3 position)
	{
		//IL_000b: Unknown result type (might be due to invalid IL or missing references)
		Unblock();
		GraphNode node = AstarPath.active.GetNearest((Int3)position, NNConstraint.None).node;
		if (node != null)
		{
			Block(node);
		}
	}

	public void Block(GraphNode node)
	{
		if (node == null)
		{
			throw new ArgumentNullException("node");
		}
		manager.InternalBlock(node, this);
		lastBlocked = node;
	}

	public void Unblock()
	{
		if (lastBlocked == null || lastBlocked.Destroyed)
		{
			lastBlocked = null;
			return;
		}
		manager.InternalUnblock(lastBlocked, this);
		lastBlocked = null;
	}
}
