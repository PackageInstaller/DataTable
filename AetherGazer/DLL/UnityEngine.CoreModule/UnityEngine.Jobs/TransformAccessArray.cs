using System;
using System.Runtime.CompilerServices;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;

namespace UnityEngine.Jobs;

[NativeType(Header = "Runtime/Transform/ScriptBindings/TransformAccess.bindings.h", CodegenOptions = CodegenOptions.Custom)]
public struct TransformAccessArray : IDisposable
{
	private IntPtr m_TransformArray;

	public bool isCreated => m_TransformArray != IntPtr.Zero;

	public Transform this[int index]
	{
		get
		{
			return GetTransform(m_TransformArray, index);
		}
		set
		{
			SetTransform(m_TransformArray, index, value);
		}
	}

	public int capacity
	{
		get
		{
			return GetCapacity(m_TransformArray);
		}
		set
		{
			SetCapacity(m_TransformArray, value);
		}
	}

	public int length => GetLength(m_TransformArray);

	public TransformAccessArray(Transform[] transforms, int desiredJobCount = -1)
	{
		Allocate(transforms.Length, desiredJobCount, out this);
		SetTransforms(m_TransformArray, transforms);
	}

	public TransformAccessArray(int capacity, int desiredJobCount = -1)
	{
		Allocate(capacity, desiredJobCount, out this);
	}

	public static void Allocate(int capacity, int desiredJobCount, out TransformAccessArray array)
	{
		array.m_TransformArray = Create(capacity, desiredJobCount);
		UnsafeUtility.LeakRecord(array.m_TransformArray, LeakCategory.TransformAccessArray, 0);
	}

	public void Dispose()
	{
		UnsafeUtility.LeakErase(m_TransformArray, LeakCategory.TransformAccessArray);
		DestroyTransformAccessArray(m_TransformArray);
		m_TransformArray = IntPtr.Zero;
	}

	internal IntPtr GetTransformAccessArrayForSchedule()
	{
		return m_TransformArray;
	}

	public void Add(Transform transform)
	{
		Add(m_TransformArray, transform);
	}

	public void Add(int instanceId)
	{
		AddInstanceId(m_TransformArray, instanceId);
	}

	public void RemoveAtSwapBack(int index)
	{
		RemoveAtSwapBack(m_TransformArray, index);
	}

	public void SetTransforms(Transform[] transforms)
	{
		SetTransforms(m_TransformArray, transforms);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::Create", IsFreeFunction = true)]
	private static extern IntPtr Create(int capacity, int desiredJobCount);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "DestroyTransformAccessArray", IsFreeFunction = true)]
	private static extern void DestroyTransformAccessArray(IntPtr transformArray);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::SetTransforms", IsFreeFunction = true)]
	private static extern void SetTransforms(IntPtr transformArrayIntPtr, Transform[] transforms);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::AddTransform", IsFreeFunction = true)]
	private static extern void Add(IntPtr transformArrayIntPtr, Transform transform);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::AddTransformInstanceId", IsFreeFunction = true)]
	private static extern void AddInstanceId(IntPtr transformArrayIntPtr, int instanceId);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::RemoveAtSwapBack", IsFreeFunction = true, ThrowsException = true)]
	private static extern void RemoveAtSwapBack(IntPtr transformArrayIntPtr, int index);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::GetSortedTransformAccess", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	internal static extern IntPtr GetSortedTransformAccess(IntPtr transformArrayIntPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::GetSortedToUserIndex", IsThreadSafe = true, IsFreeFunction = true, ThrowsException = true)]
	internal static extern IntPtr GetSortedToUserIndex(IntPtr transformArrayIntPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::GetLength", IsFreeFunction = true)]
	internal static extern int GetLength(IntPtr transformArrayIntPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::GetCapacity", IsFreeFunction = true)]
	internal static extern int GetCapacity(IntPtr transformArrayIntPtr);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::SetCapacity", IsFreeFunction = true)]
	internal static extern void SetCapacity(IntPtr transformArrayIntPtr, int capacity);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::GetTransform", IsFreeFunction = true, ThrowsException = true)]
	internal static extern Transform GetTransform(IntPtr transformArrayIntPtr, int index);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::SetTransform", IsFreeFunction = true, ThrowsException = true)]
	internal static extern void SetTransform(IntPtr transformArrayIntPtr, int index, Transform transform);
}
