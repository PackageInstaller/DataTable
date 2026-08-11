namespace UnityEngine.Experimental.Rendering.RenderGraphModule;

public struct ComputeBufferDesc
{
	public int count;

	public int stride;

	public ComputeBufferType type;

	public string name;

	public ComputeBufferDesc(int count, int stride)
	{
		this = default(ComputeBufferDesc);
		this.count = count;
		this.stride = stride;
		type = ComputeBufferType.Default;
	}

	public ComputeBufferDesc(int count, int stride, ComputeBufferType type)
	{
		this = default(ComputeBufferDesc);
		this.count = count;
		this.stride = stride;
		this.type = type;
	}

	public override int GetHashCode()
	{
		return (int)(((17 * 23 + count) * 23 + stride) * 23 + type);
	}
}
