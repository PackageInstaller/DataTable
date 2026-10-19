namespace UnityEngine.Rendering;

public struct BatchDrawCommand
{
	public uint visibleOffset;

	public uint visibleCount;

	public BatchID batchID;

	public BatchMaterialID materialID;

	public BatchMeshID meshID;

	public ushort submeshIndex;

	public ushort splitVisibilityMask;

	public BatchDrawCommandFlags flags;

	public int sortingPosition;
}
