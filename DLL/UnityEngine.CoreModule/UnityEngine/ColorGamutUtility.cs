using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine;

public class ColorGamutUtility
{
	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern ColorPrimaries GetColorPrimaries(ColorGamut gamut);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern WhitePoint GetWhitePoint(ColorGamut gamut);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern TransferFunction GetTransferFunction(ColorGamut gamut);
}
