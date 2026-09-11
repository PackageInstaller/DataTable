using System;
using UnityEngine;

[Serializable]
public class P08ObjectBinding
{
	public string key;

	public string path;

	public Vector3 position;

	public Quaternion rotation;

	public Vector3 scale = Vector3.one;

	public bool active;

	public Transform parentTF;

	[NonSerialized]
	public GameObject go;

	public GameObject GetInst()
	{
		GameObject result = null;
		if (parentTF.Find(key) != null)
		{
			return parentTF.Find(key).gameObject;
		}
		if (!string.IsNullOrEmpty(path))
		{
			Asset.Initialize();
			result = Asset.InstantiateWithoutCache(path);
		}
		return result;
	}
}
