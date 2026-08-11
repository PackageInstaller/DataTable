using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode]
[NativeHeader("Runtime/Misc/AsyncOperation.h")]
[NativeHeader("Runtime/Export/Scripting/AsyncOperation.bindings.h")]
public class AsyncOperation : YieldInstruction
{
	internal IntPtr m_Ptr;

	private Action<AsyncOperation> m_completeCallback;

	public extern bool isDone
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("IsDone")]
		get;
	}

	public extern float progress
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetProgress")]
		get;
	}

	public extern int priority
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetPriority")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("SetPriority")]
		set;
	}

	public extern bool allowSceneActivation
	{
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("GetAllowSceneActivation")]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		[NativeMethod("SetAllowSceneActivation")]
		set;
	}

	public event Action<AsyncOperation> completed
	{
		add
		{
			if (isDone)
			{
				value(this);
			}
			else
			{
				m_completeCallback = (Action<AsyncOperation>)Delegate.Combine(m_completeCallback, value);
			}
		}
		remove
		{
			m_completeCallback = (Action<AsyncOperation>)Delegate.Remove(m_completeCallback, value);
		}
	}

	~AsyncOperation()
	{
		InternalDestroy(m_Ptr);
	}

	[RequiredByNativeCode]
	internal void InvokeCompletionEvent()
	{
		if (m_completeCallback != null)
		{
			m_completeCallback(this);
			m_completeCallback = null;
		}
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(IsThreadSafe = true)]
	[StaticAccessor(/*Could not decode attribute arguments.*/)]
	private static extern void InternalDestroy(IntPtr ptr);
}
