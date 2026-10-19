using System;
using UnityEngine.Bindings;

namespace UnityEngine.Animations;

[Flags]
[NativeType("Modules/Animation/Constraints/ConstraintEnums.h")]
public enum Axis
{
	None = 0,
	X = 1,
	Y = 2,
	Z = 4
}
