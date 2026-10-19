using Unity.Collections;
using UnityEngine.Jobs;

namespace UnityEngine.Rendering.Universal;

internal class DecalEntityChunk : DecalChunk
{
	public Material material;

	public NativeArray<DecalEntity> decalEntities;

	public DecalProjector[] decalProjectors;

	public TransformAccessArray transformAccessArray;

	public override void Push()
	{
		count++;
	}

	public override void RemoveAtSwapBack(int entityIndex)
	{
		RemoveAtSwapBack(ref decalEntities, entityIndex, count);
		RemoveAtSwapBack(ref decalProjectors, entityIndex, count);
		transformAccessArray.RemoveAtSwapBack(entityIndex);
		count--;
	}

	public override void SetCapacity(int newCapacity)
	{
		ArrayExtensions.ResizeArray(ref decalEntities, newCapacity);
		ResizeNativeArray(ref transformAccessArray, decalProjectors, newCapacity);
		ArrayExtensions.ResizeArray(ref decalProjectors, newCapacity);
		capacity = newCapacity;
	}

	public override void Dispose()
	{
		if (capacity != 0)
		{
			decalEntities.Dispose();
			transformAccessArray.Dispose();
			decalProjectors = null;
			count = 0;
			capacity = 0;
		}
	}
}
