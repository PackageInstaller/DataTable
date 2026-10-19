using System;
using System.Collections.Generic;
using ACT.World;
using ACT.World.Asset;
using UnityEngine;

namespace ACT.Battle;

public class MonoMixBoxCollider : MonoTriggerEvent
{
	[NonSerialized]
	public List<MonoTrigger> MonoTriggers;

	public void Init(MixedBox[] boxColliderParametersArray)
	{
		MonoTriggers = new List<MonoTrigger>();
		foreach (MixedBox obj in boxColliderParametersArray)
		{
			GameObject gameObject = new GameObject("组合区域");
			gameObject.transform.SetParent(transform);
			BoxCollider boxCollider = gameObject.gameObject.AddComponent<BoxCollider>();
			boxCollider.isTrigger = true;
			obj.CopyTo(boxCollider, gameObject.transform);
			MonoTrigger item = gameObject.gameObject.AddComponent<MonoTrigger>();
			MonoTriggers.Add(item);
		}
	}
}
