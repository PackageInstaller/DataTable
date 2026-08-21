using System;
using UnityEngine;

namespace MusicGame;

[Serializable]
public class ObjectPoolItem
{
	public string tag;

	public GameObject objectToPool;

	public int amountToPool;

	public bool shouldExpand = true;

	public ObjectPoolItem(string t, GameObject obj, int amt, bool exp = true)
	{
		tag = t;
		objectToPool = obj;
		amountToPool = Mathf.Max(amt, 2);
		shouldExpand = exp;
	}
}
