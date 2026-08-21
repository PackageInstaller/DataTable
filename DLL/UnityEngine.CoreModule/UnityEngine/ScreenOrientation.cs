using System;

namespace UnityEngine;

public enum ScreenOrientation
{
	[Obsolete("Enum member Unknown has been deprecated.", false)]
	Unknown = 0,
	[Obsolete("Use LandscapeLeft instead (UnityUpgradable) -> LandscapeLeft", true)]
	Landscape = 3,
	Portrait = 1,
	PortraitUpsideDown = 2,
	LandscapeLeft = Landscape,
	LandscapeRight = 4,
	AutoRotation = 5
}
