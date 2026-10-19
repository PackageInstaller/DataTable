using System;
using UnityEngine;

namespace ACT.World.Asset;

[Serializable]
public class InteractObjectChangeStateItem
{
	[HideInInspector]
	public int uid;

	public int state;
}
