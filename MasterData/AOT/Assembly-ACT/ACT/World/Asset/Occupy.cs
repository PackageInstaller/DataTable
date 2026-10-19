using System;
using UnityEngine;

namespace ACT.World.Asset;

public struct Occupy : IEquatable<Occupy>
{
	public bool isPoint { get; }

	public Vector2 point { get; }

	public Rect rect { get; }

	public Occupy(Vector2 point)
	{
		isPoint = true;
		this.point = point;
		rect = default;
	}

	public Occupy(Rect rect)
	{
		isPoint = false;
		point = default;
		this.rect = rect;
	}

	public bool Equals(Occupy other)
	{
		if (isPoint != other.isPoint)
		{
			return false;
		}
		if (isPoint)
		{
			return point == other.point;
		}
		return rect == other.rect;
	}
}
