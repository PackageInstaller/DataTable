using System.Collections.Generic;
using System.Linq;
using Dorm;
using UnityEngine;

[QuickOptions(new string[] { "restaurant.itemInteractPoints" })]
public class DormItemInteractPointsSubTag : DormItemSubTagBase
{
	[SerializeField]
	public List<Vector3> interactPoints;

	internal override object Value => interactPoints.Select((Vector3 p) => DormEntityManager.GetRelativePointWorldPos(p, base.transform)).ToArray();

	private void Awake()
	{
		m_namespace = "restaurant.itemInteractPoints";
	}

	public void AddPoint()
	{
		AddPoint((interactPoints?.Count ?? 0).ToString(), Vector3.zero);
	}

	public void AddPoint(string v, Vector3 p)
	{
		if (interactPoints == null)
		{
			interactPoints = new List<Vector3>();
		}
		interactPoints.Add(p);
	}
}
