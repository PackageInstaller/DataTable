using System.Collections.Generic;
using UnityEngine;

namespace Capture.Library;

public class Simplex
{
	public List<Vector2> points = new List<Vector2>();

	public void clear()
	{
		points.Clear();
	}

	public int count()
	{
		return points.Count;
	}

	public Vector2 get(int i)
	{
		return points[i];
	}

	public void add(Vector2 point)
	{
		points.Add(point);
	}

	public void remove(int index)
	{
		points.RemoveAt(index);
	}

	public Vector2 getLast()
	{
		return points[points.Count - 1];
	}

	public bool contains(Vector2 point)
	{
		return GJKTool.contains(points, point);
	}
}
