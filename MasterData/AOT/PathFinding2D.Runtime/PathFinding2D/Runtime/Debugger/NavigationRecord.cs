using System;
using System.Collections.Generic;
using PathFinding2D.Runtime.Models;
using Unity.Properties;
using UnityEngine;

namespace PathFinding2D.Runtime.Debugger;

[Serializable]
public class NavigationRecord
{
	[CreateProperty]
	public Vector3 StartPosition { get; set; }

	[CreateProperty]
	public Vector3 EndPosition { get; set; }

	[CreateProperty]
	public float GameTime { get; set; }

	[CreateProperty]
	public DateTime DateTime { get; set; }

	[CreateProperty]
	public List<Waypoint> Path { get; set; }

	public NavigationRecord(Vector3 start, Vector3 end, List<Waypoint> path)
	{
		StartPosition = start;
		EndPosition = end;
		Path = new List<Waypoint>(path);
	}

	public NavigationRecord()
	{
		GameTime = Time.time;
		DateTime = DateTime.Now;
	}
}
