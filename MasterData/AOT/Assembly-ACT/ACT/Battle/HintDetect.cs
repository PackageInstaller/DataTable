using System;
using ACT.World.Behave;
using ACT.World.StateObject;
using UnityEngine;

namespace ACT.Battle;

[Obsolete]
public class HintDetect : MonoBehaviour
{
	public InteractObjectType type;

	public StateObjectBase stateObjectBase;

	public CollectionBehaveEvents collectionBehaveEvents;

	public BoxCollider boxCollider;

	private bool hasHandleStay;

	public StateObjectBase StateObjectBase
	{
		get
		{
			if (type == InteractObjectType.InteractObject)
			{
				return stateObjectBase;
			}
			if (type == InteractObjectType.InteractCollection)
			{
				return collectionBehaveEvents.interactCollection;
			}
			return null;
		}
	}

	public void SetColliderEnable(bool active)
	{
		boxCollider.enabled = active;
	}
}
