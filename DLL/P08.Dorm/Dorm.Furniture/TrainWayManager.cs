using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

namespace Dorm.Furniture;

public class TrainWayManager
{
	private static TrainWayManager sInstance;

	public CinemachineSmoothPath path;

	public static TrainWayManager Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new TrainWayManager();
			}
			return sInstance;
		}
	}

	public void InitPath(List<Transform> transforms, bool isRing)
	{
		if (path == null)
		{
			GameObject gameObject = new GameObject();
			gameObject.name = "TrainPath";
			gameObject.transform.position = Vector3.zero;
			gameObject.transform.rotation = Quaternion.identity;
			path = gameObject.AddComponent<CinemachineSmoothPath>();
		}
		path.m_Looped = isRing;
		path.m_Waypoints = new CinemachineSmoothPath.Waypoint[transforms.Count];
		for (int i = 0; i < transforms.Count; i++)
		{
			path.m_Waypoints[i] = new CinemachineSmoothPath.Waypoint
			{
				position = transforms[i].position,
				roll = 0f
			};
		}
		path.InvalidateDistanceCache();
	}
}
