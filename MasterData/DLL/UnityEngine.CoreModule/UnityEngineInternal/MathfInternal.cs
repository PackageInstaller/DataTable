using System.Runtime.InteropServices;
using System.Threading;
using Unity.IL2CPP.CompilerServices;

namespace UnityEngineInternal;

[StructLayout(LayoutKind.Sequential, Size = 1)]
[Il2CppEagerStaticClassConstruction]
public struct MathfInternal
{
	public static volatile float FloatMinNormal = 1.1754944E-38f;

	public static volatile float FloatMinDenormal = float.Epsilon;

	public static bool IsFlushToZeroEnabled = Interlocked.CompareExchange(ref FloatMinDenormal, FloatMinDenormal, 0f) == 0f;
}
