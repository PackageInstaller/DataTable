using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;
using UnityEngine.Rendering;

namespace UnityEngine;

[NativeHeader("Runtime/Graphics/GraphicsScriptBindings.h")]
public struct RenderBuffer
{
	internal int m_RenderTextureInstanceID;

	internal IntPtr m_BufferPtr;

	internal RenderBufferLoadAction loadAction
	{
		get
		{
			return GetLoadAction();
		}
		set
		{
			SetLoadAction(value);
		}
	}

	internal RenderBufferStoreAction storeAction
	{
		get
		{
			return GetStoreAction();
		}
		set
		{
			SetStoreAction(value);
		}
	}

	[FreeFunction(Name = "RenderBufferScripting::SetLoadAction", HasExplicitThis = true)]
	internal void SetLoadAction(RenderBufferLoadAction action)
	{
		SetLoadAction_Injected(ref this, action);
	}

	[FreeFunction(Name = "RenderBufferScripting::SetStoreAction", HasExplicitThis = true)]
	internal void SetStoreAction(RenderBufferStoreAction action)
	{
		SetStoreAction_Injected(ref this, action);
	}

	[FreeFunction(Name = "RenderBufferScripting::GetLoadAction", HasExplicitThis = true)]
	internal RenderBufferLoadAction GetLoadAction()
	{
		return GetLoadAction_Injected(ref this);
	}

	[FreeFunction(Name = "RenderBufferScripting::GetStoreAction", HasExplicitThis = true)]
	internal RenderBufferStoreAction GetStoreAction()
	{
		return GetStoreAction_Injected(ref this);
	}

	[FreeFunction(Name = "RenderBufferScripting::GetNativeRenderBufferPtr", HasExplicitThis = true)]
	public IntPtr GetNativeRenderBufferPtr()
	{
		return GetNativeRenderBufferPtr_Injected(ref this);
	}

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetLoadAction_Injected(ref RenderBuffer _unity_self, RenderBufferLoadAction action);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern void SetStoreAction_Injected(ref RenderBuffer _unity_self, RenderBufferStoreAction action);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern RenderBufferLoadAction GetLoadAction_Injected(ref RenderBuffer _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern RenderBufferStoreAction GetStoreAction_Injected(ref RenderBuffer _unity_self);

	[MethodImpl((MethodImplOptions)4096)]
	private static extern IntPtr GetNativeRenderBufferPtr_Injected(ref RenderBuffer _unity_self);
}
