using System;
using System.Collections.Generic;
using UnityEngine;

public class ConstraintPointGroup : MonoBehaviour
{
	[Serializable]
	public struct ConstraintPoint
	{
		public string point;

		public Transform transform;
	}

	[SerializeField]
	private List<ConstraintPoint> _points;

	private ConstraintPoint GetConstraintPoint(string point)
	{
		return _points.Find((ConstraintPoint p) => p.point == point);
	}

	public Transform GetConstraintTransform(string point)
	{
		return GetConstraintPoint(point).transform;
	}
}
