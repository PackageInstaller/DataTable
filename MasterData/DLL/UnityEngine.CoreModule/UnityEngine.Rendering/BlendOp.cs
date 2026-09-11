using UnityEngine.Bindings;

namespace UnityEngine.Rendering;

[NativeHeader("Runtime/GfxDevice/GfxDeviceTypes.h")]
public enum BlendOp
{
	Add,
	Subtract,
	ReverseSubtract,
	Min,
	Max,
	LogicalClear,
	LogicalSet,
	LogicalCopy,
	LogicalCopyInverted,
	LogicalNoop,
	LogicalInvert,
	LogicalAnd,
	LogicalNand,
	LogicalOr,
	LogicalNor,
	LogicalXor,
	LogicalEquivalence,
	LogicalAndReverse,
	LogicalAndInverted,
	LogicalOrReverse,
	LogicalOrInverted,
	Multiply,
	Screen,
	Overlay,
	Darken,
	Lighten,
	ColorDodge,
	ColorBurn,
	HardLight,
	SoftLight,
	Difference,
	Exclusion,
	HSLHue,
	HSLSaturation,
	HSLColor,
	HSLLuminosity
}
