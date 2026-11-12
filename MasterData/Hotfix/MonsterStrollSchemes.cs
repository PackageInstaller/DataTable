using System;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class MonsterStrollSchemes : MonoBehaviour
{
	[Serializable]
	public class MonsterStrollScheme
	{
		public GameObject[] points;

		public bool runInCircle;

		private Transform parent;

		public Transform Parent
		{
			get
			{
				return parent;
			}
			set
			{
				value.Equals(parent);
			}
		}

		public MonsterStrollScheme(Transform parent)
		{
			Parent = parent;
		}

		public TSVector2[] GetPoints2()
		{
			if (points == null || points.Length == 0)
			{
				return null;
			}
			List<TSVector2> list = new List<TSVector2>();
			for (int i = 0; i < points.Length; i++)
			{
				Vector3 position = points[i].transform.position;
				list.Add(new TSVector2(position.x, position.z));
			}
			return list.ToArray();
		}

		public Vector3[] GetPoints3()
		{
			if (points == null || points.Length == 0)
			{
				return null;
			}
			List<Vector3> list = new List<Vector3>();
			for (int i = 0; i < points.Length; i++)
			{
				list.Add(points[i].transform.position);
			}
			return list.ToArray();
		}
	}

	public MonsterStrollScheme[] monsterStrollSchemes;
}
