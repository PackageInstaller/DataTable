using System;
using System.Runtime.CompilerServices;
using UnityEngine.Bindings;

namespace UnityEngine.Jobs;

[NativeType(/*Could not decode attribute arguments.*/)]
public struct TransformAccessArray : IDisposable
{
	private IntPtr m_TransformArray;

	public bool isCreated => m_TransformArray != IntPtr.Zero;

	public Transform this[int index] => GetTransform(m_TransformArray, index);

	public int length => GetLength(m_TransformArray);

	public TransformAccessArray(int capacity, int desiredJobCount = -1)
	{
		Allocate(capacity, desiredJobCount, out this);
	}

	public static void Allocate(int capacity, int desiredJobCount, out TransformAccessArray array)
	{
		array.m_TransformArray = Create(capacity, desiredJobCount);
	}

	public void Dispose()
	{
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

	public void RemoveAtSwapBack(int index)
	{
		RemoveAtSwapBack(m_TransformArray, index);
	}

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::Create", IsFreeFunction = true)]
	private static extern IntPtr Create(int capacity, int desiredJobCount);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "DestroyTransformAccessArray", IsFreeFunction = true)]
	private static extern void DestroyTransformAccessArray(IntPtr transformArray);

	[MethodImpl((MethodImplOptions)4096)]
	[NativeMethod(Name = "TransformAccessArrayBindings::AddTransform", IsFreeFunction = true)]
	private static extern void Add(IntPtr transformArrayIntPtr, Transform transform);

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
	[NativeMethod(Name = "TransformAccessArrayBindings::GetTransform", IsFreeFunction = true, ThrowsException = true)]
	internal static extern Transform GetTransform(IntPtr transformArrayIntPtr, int index);
}
