using System;
using UnityEngine;

namespace Dorm.Furniture;

[ExecuteAlways]
internal class FurnitureConnectInterace : MonoBehaviour
{
	[Flags]
	public enum InterfaceFlags
	{

	}

	public FurnitureTag furnitureTag;

	private void Awake()
	{
		base.gameObject.layer = LayerMask.NameToLayer("Ignore Raycast");
	}

	public bool ConnectReady(FurnitureConnectInterace other)
	{
		if (DormLuaBridge.IsPathPointNearBy(other.transform, base.transform))
		{
			return base.transform.forward == -other.transform.forward;
		}
		return false;
	}
}
