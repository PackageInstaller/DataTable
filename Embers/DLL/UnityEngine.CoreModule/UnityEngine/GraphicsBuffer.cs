using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Export/Graphics/GraphicsBuffer.bindings.h")]
[NativeHeader("Runtime/Shaders/GraphicsBuffer.h")]
[UsedByNativeCode]
public sealed class GraphicsBuffer
{
	[Flags]
	public enum Target
	{
		Vertex = 1,
		Index = 2,
		CopySource = 4,
		CopyDestination = 8,
		Structured = 0x10,
		Raw = 0x20,
		Append = 0x40,
		Counter = 0x80,
		IndirectArguments = 0x100,
		Constant = 0x200
	}

	internal IntPtr m_Ptr;

	public extern int count
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern int stride
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}

	public extern Target target
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
	}
}
