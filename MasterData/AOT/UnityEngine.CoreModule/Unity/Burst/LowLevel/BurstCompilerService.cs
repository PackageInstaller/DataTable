using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.Bindings;

namespace Unity.Burst.LowLevel;

[NativeHeader("Runtime/Burst/Burst.h")]
[StaticAccessor("BurstCompilerService::Get()", StaticAccessorType.Arrow)]
[NativeHeader("Runtime/Burst/BurstDelegateCache.h")]
internal static class BurstCompilerService
{
	public enum BurstLogType
	{
		Info,
		Warning,
		Error
	}

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public static extern int CompileAsyncDelegateMethod(object delegateMethod, string compilerOptions);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction(IsThreadSafe = true)]
	public unsafe static extern void* GetAsyncCompiledAsyncDelegateMethod(int userID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern void* GetOrCreateSharedMemory(ref Hash128 key, uint size_of, uint alignment);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("DefaultBurstLogCallback", true)]
	public unsafe static extern void Log(void* userData, BurstLogType logType, byte* message, byte* filename, int lineNumber);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("DefaultBurstRuntimeLogCallback", true)]
	public unsafe static extern void RuntimeLog(void* userData, BurstLogType logType, byte* message, byte* filename, int lineNumber);
}
