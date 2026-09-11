using System;
using Unity.Collections;
using Unity.Collections.LowLevel.Unsafe;
using UnityEngine.Bindings;
using UnityEngine.Scripting;

namespace UnityEngine;

[NativeHeader("Runtime/Misc/ObjectDispatcher.h")]
[RequiredByNativeCode]
[StaticAccessor("GetObjectDispatcher()", StaticAccessorType.Dot)]
internal sealed class ObjectDispatcher
{
	private IntPtr m_Ptr;

	private unsafe static Action<Object[], IntPtr, IntPtr, int, int, Action<TypeDispatchData>> s_TypeDispatch = delegate(Object[] changed, IntPtr changedID, IntPtr destroyedID, int changedCount, int destroyedCount, Action<TypeDispatchData> callback)
	{
		NativeArray<int> changedID2 = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<int>(changedID.ToPointer(), changedCount, Allocator.Invalid);
		NativeArray<int> destroyedID2 = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<int>(destroyedID.ToPointer(), destroyedCount, Allocator.Invalid);
		TypeDispatchData obj = new TypeDispatchData
		{
			changed = changed,
			changedID = changedID2,
			destroyedID = destroyedID2
		};
		callback(obj);
	};

	private unsafe static Action<IntPtr, IntPtr, IntPtr, IntPtr, IntPtr, IntPtr, int, Action<TransformDispatchData>> s_TransformDispatch = delegate(IntPtr transformed, IntPtr parents, IntPtr localToWorldMatrices, IntPtr positions, IntPtr rotations, IntPtr scales, int count, Action<TransformDispatchData> callback)
	{
		NativeArray<int> transformedID = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<int>(transformed.ToPointer(), count, Allocator.Invalid);
		NativeArray<int> parentID = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<int>(parents.ToPointer(), (parents != IntPtr.Zero) ? count : 0, Allocator.Invalid);
		NativeArray<Matrix4x4> localToWorldMatrices2 = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<Matrix4x4>(localToWorldMatrices.ToPointer(), (localToWorldMatrices != IntPtr.Zero) ? count : 0, Allocator.Invalid);
		NativeArray<Vector3> positions2 = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<Vector3>(positions.ToPointer(), (positions != IntPtr.Zero) ? count : 0, Allocator.Invalid);
		NativeArray<Quaternion> rotations2 = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<Quaternion>(rotations.ToPointer(), (rotations != IntPtr.Zero) ? count : 0, Allocator.Invalid);
		NativeArray<Vector3> scales2 = NativeArrayUnsafeUtility.ConvertExistingDataToNativeArray<Vector3>(scales.ToPointer(), (scales != IntPtr.Zero) ? count : 0, Allocator.Invalid);
		TransformDispatchData obj = new TransformDispatchData
		{
			transformedID = transformedID,
			parentID = parentID,
			localToWorldMatrices = localToWorldMatrices2,
			positions = positions2,
			rotations = rotations2,
			scales = scales2
		};
		callback(obj);
	};
}
