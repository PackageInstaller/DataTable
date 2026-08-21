using System;
using System.Collections.Generic;
using Pathfinding;
using Pathfinding.Util;
using UnityEngine;

[HelpURL("http://arongranberg.com/astar/docs/class_block_manager.php")]
public class BlockManager : VersionedMonoBehaviour
{
	public enum BlockMode
	{
		AllExceptSelector,
		OnlySelector
	}

	public class TraversalProvider : ITraversalProvider
	{
		private readonly BlockManager blockManager;

		private readonly List<SingleNodeBlocker> selector;

		public BlockMode mode { get; private set; }

		public TraversalProvider(BlockManager blockManager, BlockMode mode, List<SingleNodeBlocker> selector)
		{
			if ((Object)(object)blockManager == (Object)null)
			{
				throw new ArgumentNullException("blockManager");
			}
			if (selector == null)
			{
				throw new ArgumentNullException("selector");
			}
			this.blockManager = blockManager;
			this.mode = mode;
			this.selector = selector;
		}

		public bool CanTraverse(Path path, GraphNode node)
		{
			if (!node.Walkable || ((path.enabledTags >> (int)node.Tag) & 1) == 0)
			{
				return false;
			}
			if (mode == BlockMode.OnlySelector)
			{
				return !blockManager.NodeContainsAnyOf(node, selector);
			}
			return !blockManager.NodeContainsAnyExcept(node, selector);
		}

		public uint GetTraversalCost(Path path, GraphNode node)
		{
			return path.GetTagPenalty((int)node.Tag) + node.Penalty;
		}
	}

	private Dictionary<GraphNode, List<SingleNodeBlocker>> blocked = new Dictionary<GraphNode, List<SingleNodeBlocker>>();

	private void Start()
	{
		if (AstarPath.active != null)
		{
			throw new Exception("No AstarPath object in the scene");
		}
	}

	public bool NodeContainsAnyOf(GraphNode node, List<SingleNodeBlocker> selector)
	{
		if (!blocked.TryGetValue(node, out var value))
		{
			return false;
		}
		for (int i = 0; i < value.Count; i++)
		{
			SingleNodeBlocker singleNodeBlocker = value[i];
			for (int j = 0; j < selector.Count; j++)
			{
				if (singleNodeBlocker == selector[j])
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool NodeContainsAnyExcept(GraphNode node, List<SingleNodeBlocker> selector)
	{
		if (!blocked.TryGetValue(node, out var value))
		{
			return false;
		}
		for (int i = 0; i < value.Count; i++)
		{
			SingleNodeBlocker singleNodeBlocker = value[i];
			bool flag = false;
			for (int j = 0; j < selector.Count; j++)
			{
				if (singleNodeBlocker == selector[j])
				{
					flag = true;
					break;
				}
			}
			if (!flag)
			{
				return true;
			}
		}
		return false;
	}

	public void InternalBlock(GraphNode node, SingleNodeBlocker blocker)
	{
		AstarPath.active.AddWorkItem(new AstarWorkItem((Action)delegate
		{
			if (!blocked.TryGetValue(node, out var value))
			{
				List<SingleNodeBlocker> list = (blocked[node] = ListPool<SingleNodeBlocker>.Claim());
				value = list;
			}
			value.Add(blocker);
		}, (Func<bool, bool>)null));
	}

	public void InternalUnblock(GraphNode node, SingleNodeBlocker blocker)
	{
		AstarPath.active.AddWorkItem(new AstarWorkItem((Action)delegate
		{
			if (blocked.TryGetValue(node, out var value))
			{
				value.Remove(blocker);
				if (value.Count == 0)
				{
					blocked.Remove(node);
					ListPool<SingleNodeBlocker>.Release(value);
				}
			}
		}, (Func<bool, bool>)null));
	}
}
