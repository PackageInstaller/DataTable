using System;
using UnityEngine;

namespace ACT.World.Data.SceneRouters;

public enum SceneChunkRouterType
{
	[Obsolete]
	[HideInInspector]
	NotInitialized,
	TwoSideDoor,
	OneWayDoor,
	AreaSwitchDoor
}
