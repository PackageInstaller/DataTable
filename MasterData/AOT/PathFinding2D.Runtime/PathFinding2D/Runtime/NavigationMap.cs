using System;
using System.Collections.Generic;
using System.Linq;
using PathFinding2D.Runtime.Models;
using UnityEngine;

namespace PathFinding2D.Runtime;

public class NavigationMap
{
	private PriorityQueue<Waypoint> openSet = new PriorityQueue<Waypoint>();

	private HashSet<uint> closedSet = new HashSet<uint>();

	private Dictionary<uint, float> gScore = new Dictionary<uint, float>();

	private Dictionary<uint, float> fScore = new Dictionary<uint, float>();

	private Dictionary<uint, Waypoint> cameFrom = new Dictionary<uint, Waypoint>();

	private static float s_LastEmptyWaypointLogTime = -999f;

	private static float s_LastNavigateMissLogTime = -999f;

	private List<Waypoint> _waypoints = new List<Waypoint>();

	private Dictionary<uint, Waypoint> Waypoints { get; } = new Dictionary<uint, Waypoint>();

	public int WaypointCount => Waypoints.Count;

	private Dictionary<uint, List<PointLink>> PointLinks { get; } = new Dictionary<uint, List<PointLink>>();

	private void Clear()
	{
		openSet.Clear();
		closedSet.Clear();
		gScore.Clear();
		fScore.Clear();
		cameFrom.Clear();
	}

	public static NavigationMap Create(NavigationData data, Vector3 offset)
	{
		NavigationMap navigationMap = new NavigationMap();
		foreach (Waypoint waypoint in data.Waypoints)
		{
			waypoint.SetOffset(offset);
			navigationMap.AddWaypoint(waypoint);
		}
		foreach (PointLink pointLink in data.PointLinks)
		{
			navigationMap.LinkWaypoint(pointLink);
			navigationMap.AddPointLink(pointLink);
		}
		return navigationMap;
	}

	public static NavigationMap Create(NavigationData data)
	{
		return Create(data, Vector3.zero);
	}

	public Waypoint FindClosestPoint(Vector3 referencePoint, WaypointLayerMask layerMask)
	{
		if (Waypoints.Count == 0)
		{
			LogEmptyWaypoints("FindClosestPoint", referencePoint, layerMask);
		}
		Waypoint result = null;
		float num = float.MaxValue;
		foreach (var (_, waypoint2) in Waypoints)
		{
			if (layerMask.HasLayer(waypoint2.Layer) && waypoint2.Enabled)
			{
				if (new Vector3(waypoint2.Position.x - referencePoint.x, waypoint2.Position.y - referencePoint.y, waypoint2.Position.z - referencePoint.z).magnitude < 0.0001f)
				{
					return waypoint2;
				}
				float num3 = Vector3.Distance(referencePoint, waypoint2.Position);
				if (num3 < num)
				{
					num = num3;
					result = waypoint2;
				}
			}
		}
		return result;
	}

	public List<Waypoint> Navigate(GameObject gameObject, Vector3 targetPosition, WaypointLayerMask layerMask)
	{
		return Navigate(gameObject.transform.position, targetPosition, layerMask);
	}

	public List<Waypoint> Navigate(Vector3 startPosition, Vector3 targetPosition, WaypointLayerMask layerMask, NavigationMoveCapability capability = NavigationMoveCapability.WalkAndDrop)
	{
		Waypoint waypoint = FindClosestPoint(startPosition, layerMask);
		Waypoint waypoint2 = FindClosestPoint(targetPosition, layerMask);
		if (waypoint == null || waypoint2 == null)
		{
			LogNavigateMiss(startPosition, targetPosition, layerMask, waypoint, waypoint2);
			return null;
		}
		List<Waypoint> list = Navigate(waypoint, waypoint2, layerMask, capability);
		if (list != null && list.Count > 1)
		{
			Vector3 lhs = startPosition - list.First().Position;
			Vector3 rhs = startPosition - list[1].Position;
			if (Vector3.Dot(lhs, rhs) < 0f)
			{
				list.RemoveAt(0);
			}
			if (list.Count > 1)
			{
				Vector3 lhs2 = targetPosition - list.Last().Position;
				Vector3 rhs2 = targetPosition - list[list.Count - 2].Position;
				if (Vector3.Dot(lhs2, rhs2) < 0f)
				{
					list.RemoveAt(list.Count - 1);
				}
			}
		}
		return list;
	}

	public List<Waypoint> Navigate(uint startId, uint targetId, WaypointLayerMask layerMask, NavigationMoveCapability capability = NavigationMoveCapability.WalkAndDrop)
	{
		if (!Waypoints.ContainsKey(startId) || !Waypoints.ContainsKey(targetId))
		{
			return null;
		}
		Waypoint waypoint = Waypoints[startId];
		Waypoint waypoint2 = Waypoints[targetId];
		if (!waypoint.Enabled || !waypoint2.Enabled)
		{
			return null;
		}
		if (startId == targetId)
		{
			return new List<Waypoint> { waypoint };
		}
		return Navigate(waypoint, waypoint2, layerMask, capability);
	}

	public List<Waypoint> Navigate(Waypoint start, Waypoint target, WaypointLayerMask layerMask, NavigationMoveCapability capability = NavigationMoveCapability.WalkAndDrop)
	{
		Clear();
		gScore[start.PointId] = 0f;
		fScore[start.PointId] = CostEstimate(start, target);
		openSet.Enqueue(start, fScore[start.PointId]);
		while (openSet.Count > 0)
		{
			Waypoint waypoint = openSet.Dequeue();
			uint pointId = waypoint.PointId;
			if (pointId == target.PointId)
			{
				return ReconstructPath(cameFrom, waypoint);
			}
			closedSet.Add(pointId);
			if (!PointLinks.TryGetValue(pointId, out var value))
			{
				continue;
			}
			foreach (PointLink item in value)
			{
				Waypoint target2 = item.Target;
				if (target2 == null)
				{
					continue;
				}
				uint pointId2 = target2.PointId;
				NavigationLinkType linkType = NavigationLinkTypeUtility.Resolve(item.LinkType, waypoint.Position, target2.Position);
				if (!NavigationLinkTypeUtility.CanTraverse(capability, linkType) || closedSet.Contains(pointId2) || !target2.Enabled || !layerMask.HasLayer(target2.Layer))
				{
					continue;
				}
				float num = gScore[pointId] + item.Weight;
				if (!gScore.ContainsKey(pointId2) || num < gScore[pointId2])
				{
					cameFrom[pointId2] = waypoint;
					gScore[pointId2] = num;
					fScore[pointId2] = gScore[pointId2] + CostEstimate(target2, target);
					if (!openSet.Contains(target2))
					{
						openSet.Enqueue(target2, fScore[pointId2]);
					}
					else
					{
						openSet.UpdatePriority(target2, fScore[pointId2]);
					}
				}
			}
		}
		return null;
	}

	public void Navigate(Waypoint[] result, Waypoint start, Waypoint target, WaypointLayerMask layerMask)
	{
		List<Waypoint> waypoints = Navigate(start, target, layerMask);
		FillArray(result, waypoints);
	}

	public void Navigate(Waypoint[] result, GameObject gameObject, Vector3 targetPosition, WaypointLayerMask layerMask)
	{
		List<Waypoint> waypoints = Navigate(gameObject, targetPosition, layerMask);
		FillArray(result, waypoints);
	}

	public void Navigate(Waypoint[] result, Vector3 startPosition, Vector3 targetPosition, WaypointLayerMask layerMask)
	{
		List<Waypoint> waypoints = Navigate(startPosition, targetPosition, layerMask);
		FillArray(result, waypoints);
	}

	public Waypoint NavigateOne(Waypoint start, Waypoint target, WaypointLayerMask layerMask)
	{
		return Navigate(start, target, layerMask)?.FirstOrDefault();
	}

	public Waypoint NavigateOne(GameObject gameObject, Vector3 targetPosition, WaypointLayerMask layerMask)
	{
		return Navigate(gameObject, targetPosition, layerMask)?.FirstOrDefault();
	}

	public Waypoint NavigateOne(Vector3 startPosition, Vector3 targetPosition, WaypointLayerMask layerMask)
	{
		return Navigate(startPosition, targetPosition, layerMask)?.FirstOrDefault();
	}

	public bool CanNavigate(Vector3 startPosition, Vector3 targetPosition, WaypointLayerMask layerMask, NavigationMoveCapability capability = NavigationMoveCapability.WalkAndDrop)
	{
		List<Waypoint> list = Navigate(startPosition, targetPosition, layerMask, capability);
		if (list != null)
		{
			return list.Count > 0;
		}
		return false;
	}

	private float CostEstimate(Waypoint from, Waypoint to)
	{
		return Vector3.Distance(from.Position, to.Position);
	}

	private void LogEmptyWaypoints(string method, Vector3 referencePoint, WaypointLayerMask layerMask)
	{
		if (!(Time.unscaledTime - s_LastEmptyWaypointLogTime < 2f))
		{
			s_LastEmptyWaypointLogTime = Time.unscaledTime;
			string text = (NavigationRuntime.IsInstantiated ? NavigationRuntime.FormatData(NavigationRuntime.Instance.NavigationData) : "runtime-not-instantiated");
			string[] array = new string[10] { "[PF2D] ", method, " Waypoints.Count=0 pos=", null, null, null, null, null, null, null };
			Vector3 vector = referencePoint;
			array[3] = vector.ToString();
			array[4] = " layerMask=";
			array[5] = layerMask.ToString();
			array[6] = " thisMapWp=";
			array[7] = WaypointCount.ToString();
			array[8] = " runtimeData=";
			array[9] = text;
			Debug.LogWarning(string.Concat(array));
			NavigationRuntime.LogSceneSnapshot(method + "-empty");
		}
	}

	private void LogNavigateMiss(Vector3 startPosition, Vector3 targetPosition, WaypointLayerMask layerMask, Waypoint startClosest, Waypoint targetClosest)
	{
		if (!(Time.unscaledTime - s_LastNavigateMissLogTime < 2f))
		{
			s_LastNavigateMissLogTime = Time.unscaledTime;
			string text = (NavigationRuntime.IsInstantiated ? NavigationRuntime.FormatData(NavigationRuntime.Instance.NavigationData) : "runtime-not-instantiated");
			string[] array = new string[14]
			{
				"[PF2D] Navigate miss start=", null, null, null, null, null, null, null, null, null,
				null, null, null, null
			};
			Vector3 vector = startPosition;
			array[1] = vector.ToString();
			array[2] = " target=";
			vector = targetPosition;
			array[3] = vector.ToString();
			array[4] = " layerMask=";
			array[5] = layerMask.ToString();
			array[6] = " startClosest=";
			array[7] = ((startClosest != null) ? startClosest.PointId.ToString() : "null");
			array[8] = " targetClosest=";
			array[9] = ((targetClosest != null) ? targetClosest.PointId.ToString() : "null");
			array[10] = " mapWp=";
			array[11] = WaypointCount.ToString();
			array[12] = " runtimeData=";
			array[13] = text;
			Debug.LogWarning(string.Concat(array));
			NavigationRuntime.LogSceneSnapshot("Navigate-miss");
		}
	}

	private void FillArray(Waypoint[] array, List<Waypoint> waypoints)
	{
		if (waypoints == null)
		{
			Array.Fill(array, null);
			return;
		}
		for (int i = 0; i < array.Length; i++)
		{
			if (i < waypoints.Count)
			{
				array[i] = waypoints[i];
			}
			else
			{
				array[i] = null;
			}
		}
	}

	private List<Waypoint> ReconstructPath(Dictionary<uint, Waypoint> from, Waypoint current)
	{
		_waypoints.Clear();
		_waypoints.Add(current);
		List<Waypoint> waypoints = _waypoints;
		while (from.ContainsKey(current.PointId))
		{
			current = from[current.PointId];
			waypoints.Insert(0, current);
		}
		return waypoints;
	}

	public void AddWaypoint(Waypoint waypoint)
	{
		if (!Waypoints.TryAdd(waypoint.PointId, waypoint))
		{
			throw new Exception($"Cannot add point. Point id {waypoint.PointId} has already been added");
		}
	}

	public void AddPointLink(PointLink link)
	{
		uint fromId = link.fromId;
		if (!PointLinks.ContainsKey(fromId))
		{
			PointLinks[fromId] = new List<PointLink>();
		}
		PointLinks[fromId].Add(link);
	}

	public void CreateBidirectionalLink(Waypoint from, Waypoint to)
	{
		PointLink link = PointLink.Create(from, to);
		PointLink link2 = PointLink.Create(to, from);
		AddPointLink(link);
		AddPointLink(link2);
	}

	private void LinkWaypoint(PointLink link)
	{
		if (Waypoints.TryGetValue(link.fromId, out var value) && Waypoints.TryGetValue(link.targetId, out var value2))
		{
			link.LinkWaypoints(value, value2);
		}
	}
}
