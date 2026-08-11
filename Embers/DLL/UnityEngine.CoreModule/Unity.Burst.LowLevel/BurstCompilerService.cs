using System.Reflection;
using System.Runtime.CompilerServices;
using UnityEngine;
using UnityEngine.Bindings;

namespace Unity.Burst.LowLevel;

[NativeHeader("Runtime/Burst/Burst.h")]
[NativeHeader("Runtime/Burst/BurstDelegateCache.h")]
[StaticAccessor(/*Could not decode attribute arguments.*/)]
internal static class BurstCompilerService
{
	public enum BurstLogType
	{
		Info,
		Warning,
		Error
	}

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern string GetDisassembly(MethodInfo m, string compilerOptions);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	public static extern int CompileAsyncDelegateMethod(object delegateMethod, string compilerOptions);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction]
	public unsafe static extern void* GetAsyncCompiledAsyncDelegateMethod(int userID);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public unsafe static extern void* GetOrCreateSharedMemory(ref Hash128 key, uint size_of, uint alignment);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern void SetCurrentExecutionMode(uint environment);

	[MethodImpl((MethodImplOptions)4096)]
	[ThreadSafe]
	public static extern uint GetCurrentExecutionMode();

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("DefaultBurstLogCallback", true)]
	public unsafe static extern void Log(void* userData, BurstLogType logType, byte* message, byte* filename, int lineNumber);

	[MethodImpl((MethodImplOptions)4096)]
	public static extern bool LoadBurstLibrary(string fullPathToLibBurstGenerated);
}
