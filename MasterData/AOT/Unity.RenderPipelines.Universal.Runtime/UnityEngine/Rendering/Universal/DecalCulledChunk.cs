using Unity.Collections;

namespace UnityEngine.Rendering.Universal;

internal class DecalCulledChunk : DecalChunk
{
	public Vector3 cameraPosition;

	public ulong sceneCullingMask;

	public int cullingMask;

	public CullingGroup cullingGroups;

	public int[] visibleDecalIndexArray;

	public NativeArray<int> visibleDecalIndices;

	public int visibleDecalCount;

	public override void RemoveAtSwapBack(int entityIndex)
	{
		RemoveAtSwapBack(ref visibleDecalIndexArray, entityIndex, count);
		RemoveAtSwapBack(ref visibleDecalIndices, entityIndex, count);
		count--;
	}

	public override void SetCapacity(int newCapacity)
	{
		ArrayExtensions.ResizeArray(ref visibleDecalIndexArray, newCapacity);
		ArrayExtensions.ResizeArray(ref visibleDecalIndices, newCapacity);
		if (cullingGroups == null)
		{
			cullingGroups = new CullingGroup();
		}
		capacity = newCapacity;
	}

	public override void Dispose()
	{
		if (capacity != 0)
		{
			visibleDecalIndices.Dispose();
			visibleDecalIndexArray = null;
			count = 0;
			capacity = 0;
			cullingGroups.Dispose();
			cullingGroups = null;
		}
	}
}
