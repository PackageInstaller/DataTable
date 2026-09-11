using Pathfinding;
using Pathfinding.Util;
using UnityEngine;

public static class RecastGraphProcessor
{
	public static SimContext mSimContext;

	internal static void Initialize(SimContext simContext)
	{
		mSimContext = simContext;
	}

	public static void RecastGraphCut(SimContext simContext, SimEntity entity, SimBox cutShape)
	{
		//IL_007a: Unknown result type (might be due to invalid IL or missing references)
		//IL_007f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0082: Unknown result type (might be due to invalid IL or missing references)
		//IL_0089: Unknown result type (might be due to invalid IL or missing references)
		//IL_0090: Unknown result type (might be due to invalid IL or missing references)
		//IL_0095: Unknown result type (might be due to invalid IL or missing references)
		//IL_009b: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ae: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b3: Unknown result type (might be due to invalid IL or missing references)
		//IL_00bf: Unknown result type (might be due to invalid IL or missing references)
		//IL_00c4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d0: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d5: Unknown result type (might be due to invalid IL or missing references)
		//IL_00d8: Unknown result type (might be due to invalid IL or missing references)
		AstarPath mMapGraph = simContext.sEntityWorldState.status.mMapGraph;
		for (int i = 0; i < mMapGraph.data.graphs.Length; i++)
		{
			if (mMapGraph.data.graphs[i] is RecastGraph)
			{
				NavmeshCut navmeshCut = null;
				RecastGraph recastGraph = mMapGraph.data.graphs[i] as RecastGraph;
				if (!entity.hasEntityRecastCut)
				{
					navmeshCut = new NavmeshCut();
					entity.AddEntityRecastCut(newIsEnable: true, navmeshCut);
				}
				else
				{
					entity.entityRecastCut.isEnable = true;
					navmeshCut = entity.entityRecastCut.cutParam;
				}
				Vector3 val = (Vector3)cutShape.Size;
				navmeshCut.rectangleSize = new Vector2(val.x, val.z);
				navmeshCut.height = val.y;
				navmeshCut.center = (Vector3)cutShape.Center;
				navmeshCut.foward = (Vector3)cutShape.AxisZ;
				Rect bounds = navmeshCut.GetBounds(recastGraph.transform);
				IntRect touchingTilesInGraphSpace = recastGraph.GetTouchingTilesInGraphSpace(bounds);
				recastGraph.mTileHandler.cuts.Add(navmeshCut, touchingTilesInGraphSpace);
				recastGraph.mTileHandler.ReloadInBounds(touchingTilesInGraphSpace);
			}
		}
		mMapGraph.FlushWorkItems();
	}

	public static void DisableRecastGraphCut(SimContext simContext, SimEntity entity)
	{
		AstarPath mMapGraph = simContext.sEntityWorldState.status.mMapGraph;
		for (int i = 0; i < mMapGraph.data.graphs.Length; i++)
		{
			if (!(mMapGraph.data.graphs[i] is RecastGraph))
			{
				continue;
			}
			NavmeshCut navmeshCut = null;
			RecastGraph recastGraph = mMapGraph.data.graphs[i] as RecastGraph;
			if (entity.hasEntityRecastCut)
			{
				entity.entityRecastCut.isEnable = false;
				navmeshCut = entity.entityRecastCut.cutParam;
			}
			if (navmeshCut != null)
			{
				GridLookup<NavmeshClipper>.Root root = recastGraph.mTileHandler.cuts.GetRoot(navmeshCut);
				if (root != null)
				{
					IntRect previousBounds = root.previousBounds;
					recastGraph.mTileHandler.ReloadInBounds(previousBounds);
				}
				recastGraph.mTileHandler.cuts.Remove(navmeshCut);
			}
		}
		mMapGraph.FlushWorkItems();
	}

	public static void ConnectGraph(SimContext simContext, Int3 startPosition, Int3 end, bool oneWay)
	{
		AstarPath mMapGraph = simContext.sEntityWorldState.status.mMapGraph;
		GraphNode node = mMapGraph.GetNearest(startPosition).node;
		GraphNode node2 = mMapGraph.GetNearest(end).node;
		if (node == null || node2 == null)
		{
			Debug.Log((object)(node?.ToString() + ":" + node2));
			return;
		}
		uint costMagnitude = (uint)(node.position - node2.position).costMagnitude;
		Debug.Log((object)string.Concat("startNode == ", node.GraphIndex.ToString(), ":", node.NodeIndex.ToString(), " 's poition: ", node.position, "=>", node2.GraphIndex.ToString(), ":", node2.NodeIndex.ToString(), " 's poition: ", node2.position));
		node.AddConnection(node2, costMagnitude);
		if (!oneWay)
		{
			node2.AddConnection(node, costMagnitude);
		}
	}

	public static void DisconnectGraph(SimContext simContext, Int3 startPosition, Int3 end, bool oneWay)
	{
		AstarPath mMapGraph = simContext.sEntityWorldState.status.mMapGraph;
		GraphNode node = mMapGraph.GetNearest(startPosition).node;
		GraphNode node2 = mMapGraph.GetNearest(end).node;
		if (node != null && node2 != null)
		{
			uint costMagnitude = (uint)(node.position - node2.position).costMagnitude;
			node.RemoveConnection(node2);
			if (!oneWay)
			{
				node2.RemoveConnection(node);
			}
		}
	}

	internal static void Shutdown()
	{
		mSimContext = null;
	}
}
