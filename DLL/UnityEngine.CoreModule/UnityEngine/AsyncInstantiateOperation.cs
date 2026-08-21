using System;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Internal;
using UnityEngine.Scripting;

namespace UnityEngine;

[StructLayout(LayoutKind.Sequential)]
[RequiredByNativeCode]
[NativeHeader("Runtime/GameCode/AsyncInstantiate/AsyncInstantiateOperation.h")]
public class AsyncInstantiateOperation : AsyncOperation
{
	internal Object[] m_Result;

	public Object[] Result => m_Result;

	[StaticAccessor("GetAsyncInstantiateManager()", StaticAccessorType.Dot)]
	internal static extern float IntegrationTimeMS
	{
		[MethodImpl((MethodImplOptions)4096)]
		get;
		[MethodImpl((MethodImplOptions)4096)]
		set;
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("IsWaitingForSceneActivation")]
	public extern bool IsWaitingForSceneActivation();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("WaitForCompletion")]
	public extern void WaitForCompletion();

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod("Cancel")]
	public extern void Cancel();

	public static float GetIntegrationTimeMS()
	{
		return IntegrationTimeMS;
	}

	public static void SetIntegrationTimeMS(float integrationTimeMS)
	{
		if (integrationTimeMS <= 0f)
		{
			throw new ArgumentOutOfRangeException("integrationTimeMS", "integrationTimeMS was out of range. Must be greater than zero.");
		}
		IntegrationTimeMS = integrationTimeMS;
	}
}
[ExcludeFromDocs]
public class AsyncInstantiateOperation<T> : CustomYieldInstruction where T : Object
{
	internal AsyncInstantiateOperation m_op;

	public override bool keepWaiting => !m_op.isDone;

	public bool isDone => m_op.isDone;

	public float progress => m_op.progress;

	public bool allowSceneActivation
	{
		get
		{
			return m_op.allowSceneActivation;
		}
		set
		{
			m_op.allowSceneActivation = value;
		}
	}

	public T[] Result
	{
		get
		{
			Object[] from = m_op.Result;
			return UnsafeUtility.As<Object[], T[]>(ref from);
		}
	}

	public event Action<AsyncOperation> completed
	{
		add
		{
			m_op.completed += value;
		}
		remove
		{
			m_op.completed -= value;
		}
	}

	internal AsyncInstantiateOperation(AsyncInstantiateOperation op)
	{
		m_op = op;
	}

	public AsyncInstantiateOperation GetOperation()
	{
		return m_op;
	}

	public static implicit operator AsyncInstantiateOperation(AsyncInstantiateOperation<T> generic)
	{
		return generic.m_op;
	}

	public bool IsWaitingForSceneActivation()
	{
		return m_op.IsWaitingForSceneActivation();
	}

	public void WaitForCompletion()
	{
		m_op.WaitForCompletion();
	}

	public void Cancel()
	{
		m_op.Cancel();
	}
}
