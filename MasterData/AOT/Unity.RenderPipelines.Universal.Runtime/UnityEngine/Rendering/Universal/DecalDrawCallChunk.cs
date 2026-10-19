using Unity.Collections;
using Unity.Mathematics;

namespace UnityEngine.Rendering.Universal;

internal class DecalDrawCallChunk : DecalChunk
{
	internal const int MaxInstancesPerBatch = 64;

	public NativeArray<float4x4> decalToWorlds;

	public NativeArray<float4x4> normalToDecals;

	public NativeArray<DecalSubDrawCall> subCalls;

	public NativeArray<int> subCallCounts;

	public int subCallCount
	{
		get
		{
			return subCallCounts[0];
		}
		set
		{
			subCallCounts[0] = value;
		}
	}

	public override void RemoveAtSwapBack(int entityIndex)
	{
		RemoveAtSwapBack(ref decalToWorlds, entityIndex, count);
		RemoveAtSwapBack(ref normalToDecals, entityIndex, count);
		RemoveAtSwapBack(ref subCalls, entityIndex, count);
		count--;
	}

	public override void SetCapacity(int newCapacity)
	{
		ArrayExtensions.ResizeArray(ref decalToWorlds, newCapacity);
		ArrayExtensions.ResizeArray(ref normalToDecals, newCapacity);
		ArrayExtensions.ResizeArray(ref subCalls, newCapacity);
		capacity = newCapacity;
	}

	public override void Dispose()
	{
		subCallCounts.Dispose();
		if (capacity != 0)
		{
			decalToWorlds.Dispose();
			normalToDecals.Dispose();
			subCalls.Dispose();
			count = 0;
			capacity = 0;
		}
	}
}
