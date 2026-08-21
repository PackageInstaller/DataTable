using System.Collections;
using System.Collections.Generic;
using System.Linq;
using LuaInterface;
using UnityEngine;

public class DormPathTag : DormTagBase, IEnumerable<Vector3>, IEnumerable
{
	[SerializeField]
	public List<Transform> points = new List<Transform>();

	public IEnumerator<Vector3> GetEnumerator()
	{
		foreach (Transform point in points)
		{
			yield return point.position;
		}
	}

	IEnumerator IEnumerable.GetEnumerator()
	{
		return GetEnumerator();
	}

	internal IEnumerable<Vector3> ReversePath()
	{
		foreach (Transform item in Enumerable.Reverse(points))
		{
			yield return item.position;
		}
	}

	internal override void Record(int key)
	{
		LuaFunction func = LuaHelper.GetFunc("Dorm.RecordItemTagData");
		Vector3[] array = new Vector3[points.Count];
		for (int i = 0; i < points.Count; i++)
		{
			array[i] = points[i].position;
		}
		func.Call(m_namespace, key, array);
	}
}
