using System.Collections.Generic;
using Sirenix.OdinInspector;
using UnityEngine;

public abstract class DormTagBase : SerializedMonoBehaviour
{
	internal static HashSet<DormTagBase> All = new HashSet<DormTagBase>();

	[SerializeField]
	internal string m_namespace;

	internal abstract void Record(int key);

	internal static void Collect(IEnumerable<GameObject> searchRoot)
	{
		All.Clear();
		foreach (GameObject item2 in searchRoot)
		{
			DormTagBase[] componentsInChildren = item2.GetComponentsInChildren<DormTagBase>(includeInactive: true);
			foreach (DormTagBase item in componentsInChildren)
			{
				All.Add(item);
			}
		}
	}

	internal static void Cleanup()
	{
		All.Clear();
	}
}
