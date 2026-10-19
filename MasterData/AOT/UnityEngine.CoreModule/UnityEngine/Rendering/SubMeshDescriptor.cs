namespace UnityEngine.Rendering;

public struct SubMeshDescriptor
{
	public Bounds bounds { get; }

	public MeshTopology topology { get; }

	public int indexStart { get; }

	public int indexCount { get; }

	public int baseVertex { get; }

	public int firstVertex { get; }

	public int vertexCount { get; }

	public override string ToString()
	{
		return $"(topo={topology} indices={indexStart},{indexCount} vertices={firstVertex},{vertexCount} basevtx={baseVertex} bounds={bounds})";
	}
}
