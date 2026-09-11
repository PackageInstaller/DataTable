using System;

namespace UnityEngine;

public enum ScreenOrientation
{
	Portrait = 1,
	PortraitUpsideDown = 2,
	LandscapeLeft = 3,
	LandscapeRight = 4,
	AutoRotation = 5,
	[Obsolete("Enum member Unknown has been deprecated.", false)]
	Unknown = 0,
	[Obsolete("Use LandscapeLeft instead (UnityUpgradable) -> LandscapeLeft", true)]
	Landscape = LandscapeLeft
}
