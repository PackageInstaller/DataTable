using System;
using Unity.Collections;

namespace UnityEngine;

internal struct TransformDispatchData : IDisposable
{
	public NativeArray<int> transformedID;

	public NativeArray<int> parentID;

	public NativeArray<Matrix4x4> localToWorldMatrices;

	public NativeArray<Vector3> positions;

	public NativeArray<Quaternion> rotations;

	public NativeArray<Vector3> scales;

	public void Dispose()
	{
		transformedID.Dispose();
		parentID.Dispose();
		localToWorldMatrices.Dispose();
		positions.Dispose();
		rotations.Dispose();
		scales.Dispose();
	}
}
