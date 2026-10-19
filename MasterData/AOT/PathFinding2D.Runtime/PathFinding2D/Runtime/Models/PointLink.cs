using System;
using UnityEngine;

namespace PathFinding2D.Runtime.Models;

[Serializable]
public class PointLink
{
	[SerializeField]
	internal uint fromId;

	[SerializeField]
	internal uint targetId;

	[SerializeField]
	private float weight;

	[SerializeField]
	internal NavigationLinkType linkType;

	public uint FromId => fromId;

	public uint TargetId => targetId;

	public Waypoint From { get; private set; }

	public Waypoint Target { get; private set; }

	public NavigationLinkType LinkType => linkType;

	public float Weight
	{
		get
		{
			if (Target.Enabled)
			{
				return weight;
			}
			return float.MaxValue;
		}
	}

	internal void LinkWaypoints(Waypoint from, Waypoint target)
	{
		From = from;
		Target = target;
	}

	public static PointLink Create(Waypoint from, Waypoint target, NavigationLinkType linkType = NavigationLinkType.Walk)
	{
		return new PointLink
		{
			fromId = from.PointId,
			targetId = target.PointId,
			weight = Vector3.Distance(from.Position, target.Position),
			linkType = linkType
		};
	}
}
