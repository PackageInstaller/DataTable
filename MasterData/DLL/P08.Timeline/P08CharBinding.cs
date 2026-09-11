using System;
using UnityEngine;

[Serializable]
public class P08CharBinding
{
	public enum EnumRootMontion
	{
		DEFAULT,
		ROOT_MONTION,
		NON_ROOT_MONTION
	}

	public string key;

	public string path;

	public Vector3 position;

	public Quaternion rotation;

	public EnumRootMontion enumRootMotion;

	public GameObject gua;

	[NonSerialized]
	public GameObject go;

	public GameObject GetInst(GameObject timelineGo)
	{
		GameObject result = null;
		if (!string.IsNullOrEmpty(path))
		{
			Asset.Initialize();
			return Asset.InstantiateWithoutCache(path);
		}
		Transform parent = timelineGo.transform.parent;
		if (parent != null)
		{
			if (parent.name == key)
			{
				result = parent.gameObject;
			}
			else
			{
				Transform parent2 = parent.parent;
				if (parent2 != null && parent2.name == key)
				{
					result = parent2.gameObject;
				}
			}
		}
		return result;
	}
}
