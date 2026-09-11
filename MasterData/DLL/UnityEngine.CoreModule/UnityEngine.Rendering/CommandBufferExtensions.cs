using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine.Rendering;

[UsedByNativeCode]
[NativeHeader("Runtime/Export/Graphics/RenderingCommandBufferExtensions.bindings.h")]
public static class CommandBufferExtensions
{
	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBufferExtensions_Bindings::Internal_SwitchIntoFastMemory")]
	private static extern void Internal_SwitchIntoFastMemory([NotNull("NullExceptionObject")] CommandBuffer cmd, ref RenderTargetIdentifier rt, FastMemoryFlags fastMemoryFlags, float residency, bool copyContents);

	[MethodImpl((MethodImplOptions)4096)]
	[FreeFunction("RenderingCommandBufferExtensions_Bindings::Internal_SwitchOutOfFastMemory")]
	private static extern void Internal_SwitchOutOfFastMemory([NotNull("NullExceptionObject")] CommandBuffer cmd, ref RenderTargetIdentifier rt, bool copyContents);

	[NativeConditional("UNITY_XBOXONE || UNITY_GAMECORE_XBOXONE")]
	public static void SwitchIntoFastMemory(this CommandBuffer cmd, RenderTargetIdentifier rid, FastMemoryFlags fastMemoryFlags, float residency, bool copyContents)
	{
		Internal_SwitchIntoFastMemory(cmd, ref rid, fastMemoryFlags, residency, copyContents);
	}

	[NativeConditional("UNITY_XBOXONE || UNITY_GAMECORE_XBOXONE")]
	public static void SwitchOutOfFastMemory(this CommandBuffer cmd, RenderTargetIdentifier rid, bool copyContents)
	{
		Internal_SwitchOutOfFastMemory(cmd, ref rid, copyContents);
	}
}
