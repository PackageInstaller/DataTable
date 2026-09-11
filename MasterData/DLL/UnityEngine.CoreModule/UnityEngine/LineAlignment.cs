using System;

namespace UnityEngine;

public enum LineAlignment
{
	View = 0,
	[Obsolete("Enum member Local has been deprecated. Use TransformZ instead (UnityUpgradable) -> TransformZ", false)]
	Local = 1,
	TransformZ = Local
}
