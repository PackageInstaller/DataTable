using System;
using System.Collections.Generic;
using Pathfinding.Util;
using UnityEngine;

namespace Pathfinding;

[HelpURL("http://arongranberg.com/astar/docs/class_pathfinding_1_1_tile_handler_helper.php")]
public class TileHandlerHelper : VersionedMonoBehaviour
{
	private TileHandler handler;

	public float updateInterval;

	private float lastUpdateTime = float.NegativeInfinity;

	private readonly List<IntRect> forcedReloadRects = new List<IntRect>();

	public void UseSpecifiedHandler(TileHandler newHandler)
	{
		Debug.Log((object)("==============================================================================>> new handler" + newHandler));
		if (!((Behaviour)this).enabled)
		{
			throw new InvalidOperationException("TileHandlerHelper is disabled");
		}
		if (handler != null)
		{
			NavmeshClipper.RemoveEnableCallback(HandleOnEnableCallback, HandleOnDisableCallback);
			NavmeshBase graph = handler.graph;
			graph.OnRecalculatedTiles = (Action<NavmeshTile[]>)Delegate.Remove(graph.OnRecalculatedTiles, new Action<NavmeshTile[]>(OnRecalculatedTiles));
		}
		handler = newHandler;
		if (handler != null)
		{
			NavmeshClipper.AddEnableCallback(HandleOnEnableCallback, HandleOnDisableCallback);
			NavmeshBase graph2 = handler.graph;
			graph2.OnRecalculatedTiles = (Action<NavmeshTile[]>)Delegate.Combine(graph2.OnRecalculatedTiles, new Action<NavmeshTile[]>(OnRecalculatedTiles));
		}
	}

	private void OnEnable()
	{
		if (handler != null)
		{
			NavmeshClipper.AddEnableCallback(HandleOnEnableCallback, HandleOnDisableCallback);
			NavmeshBase graph = handler.graph;
			graph.OnRecalculatedTiles = (Action<NavmeshTile[]>)Delegate.Combine(graph.OnRecalculatedTiles, new Action<NavmeshTile[]>(OnRecalculatedTiles));
		}
		forcedReloadRects.Clear();
	}

	private void OnDisable()
	{
		if (handler != null)
		{
			NavmeshClipper.RemoveEnableCallback(HandleOnEnableCallback, HandleOnDisableCallback);
			forcedReloadRects.Clear();
			NavmeshBase graph = handler.graph;
			graph.OnRecalculatedTiles = (Action<NavmeshTile[]>)Delegate.Remove(graph.OnRecalculatedTiles, new Action<NavmeshTile[]>(OnRecalculatedTiles));
		}
	}

	public void DiscardPending()
	{
		if (handler != null)
		{
			for (GridLookup<NavmeshClipper>.Root root = handler.cuts.AllItems; root != null; root = root.next)
			{
				if (root.obj.RequiresUpdate())
				{
					root.obj.NotifyUpdated();
				}
			}
		}
		forcedReloadRects.Clear();
	}

	private void Start()
	{
		if (Object.FindObjectsOfType(typeof(TileHandlerHelper)).Length > 1)
		{
			Debug.LogError((object)"There should only be one TileHandlerHelper per scene. Destroying.");
			Object.Destroy((Object)(object)this);
		}
		else if (handler == null)
		{
			FindGraph();
		}
	}

	private void FindGraph()
	{
		if (AstarPath.active != null)
		{
			NavmeshBase navmeshBase = (NavmeshBase)(((object)AstarPath.active.data.recastGraph) ?? ((object)AstarPath.active.data.navmesh));
			if (navmeshBase != null)
			{
				UseSpecifiedHandler(new TileHandler(navmeshBase));
				handler.CreateTileTypesFromGraph();
			}
		}
	}

	private void OnRecalculatedTiles(NavmeshTile[] tiles)
	{
		if (!handler.isValid)
		{
			UseSpecifiedHandler(new TileHandler(handler.graph));
		}
		handler.OnRecalculatedTiles(tiles);
	}

	private void HandleOnEnableCallback(NavmeshClipper obj)
	{
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_0016: Unknown result type (might be due to invalid IL or missing references)
		//IL_0022: Unknown result type (might be due to invalid IL or missing references)
		Rect bounds = obj.GetBounds(handler.graph.transform);
		IntRect touchingTilesInGraphSpace = handler.graph.GetTouchingTilesInGraphSpace(bounds);
		handler.cuts.Add(obj, touchingTilesInGraphSpace);
		obj.ForceUpdate();
	}

	private void HandleOnDisableCallback(NavmeshClipper obj)
	{
		GridLookup<NavmeshClipper>.Root root = handler.cuts.GetRoot(obj);
		if (root != null)
		{
			forcedReloadRects.Add(root.previousBounds);
			handler.cuts.Remove(obj);
		}
		lastUpdateTime = float.NegativeInfinity;
	}

	private void Update()
	{
		if (handler == null)
		{
			FindGraph();
		}
		if (handler != null && !AstarPath.active.isScanning && ((updateInterval >= 0f && Time.realtimeSinceStartup - lastUpdateTime > updateInterval) || !handler.isValid))
		{
			ForceUpdate();
		}
	}

	public void ForceUpdate()
	{
		//IL_0161: Unknown result type (might be due to invalid IL or missing references)
		//IL_0166: Unknown result type (might be due to invalid IL or missing references)
		//IL_0173: Unknown result type (might be due to invalid IL or missing references)
		if (handler == null)
		{
			throw new Exception("Cannot update graphs. No TileHandler. Do not call the ForceUpdate method in Awake.");
		}
		lastUpdateTime = Time.realtimeSinceStartup;
		if (!handler.isValid)
		{
			if (!handler.graph.exists)
			{
				UseSpecifiedHandler(null);
				return;
			}
			Debug.Log((object)"TileHandler no longer matched the underlaying graph (possibly because of a graph scan). Recreating TileHandler...");
			UseSpecifiedHandler(new TileHandler(handler.graph));
			handler.CreateTileTypesFromGraph();
			forcedReloadRects.Add(new IntRect(int.MinValue, int.MinValue, int.MaxValue, int.MaxValue));
		}
		GridLookup<NavmeshClipper>.Root allItems = handler.cuts.AllItems;
		if (forcedReloadRects.Count == 0)
		{
			int num = 0;
			for (GridLookup<NavmeshClipper>.Root root = allItems; root != null; root = root.next)
			{
				if (root.obj.RequiresUpdate())
				{
					num++;
					break;
				}
			}
			if (num == 0)
			{
				return;
			}
		}
		bool flag = handler.StartBatchLoad();
		for (int i = 0; i < forcedReloadRects.Count; i++)
		{
			handler.ReloadInBounds(forcedReloadRects[i]);
		}
		forcedReloadRects.Clear();
		for (GridLookup<NavmeshClipper>.Root root2 = allItems; root2 != null; root2 = root2.next)
		{
			if (root2.obj.RequiresUpdate())
			{
				handler.ReloadInBounds(root2.previousBounds);
				Rect bounds = root2.obj.GetBounds(handler.graph.transform);
				IntRect touchingTilesInGraphSpace = handler.graph.GetTouchingTilesInGraphSpace(bounds);
				handler.cuts.Move(root2.obj, touchingTilesInGraphSpace);
				handler.ReloadInBounds(touchingTilesInGraphSpace);
			}
		}
		for (GridLookup<NavmeshClipper>.Root root3 = allItems; root3 != null; root3 = root3.next)
		{
			if (root3.obj.RequiresUpdate())
			{
				root3.obj.NotifyUpdated();
			}
		}
		if (flag)
		{
			handler.EndBatchLoad();
		}
	}
}
