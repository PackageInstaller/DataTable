namespace UnityEngine.Rendering;

public struct SubMeshDescriptor(int indexStart, int indexCount, MeshTopology topology = MeshTopology.Triangles)
{
	public Bounds bounds { get; set; } = default(Bounds);

	public MeshTopology topology { get; set; } = topology;

	public int indexStart { get; set; } = indexStart;

	public int indexCount { get; set; } = indexCount;

	public int baseVertex { get; set; } = 0;

	public int firstVertex { get; set; } = 0;

	public int vertexCount { get; set; } = 0;

	public override string ToString()
	{
		return $"(topo={topology} indices={indexStart},{indexCount} vertices={firstVertex},{vertexCount} basevtx={baseVertex} bounds={bounds})";
	}
}
