namespace UnityEngine.Rendering.Universal;

public readonly struct TemporalColorHistory
{
	public readonly RenderTargetIdentifier texture;

	public readonly int width;

	public readonly int height;

	public bool isValid
	{
		get
		{
			if (width > 0)
			{
				return height > 0;
			}
			return false;
		}
	}

	public TemporalColorHistory(RenderTargetIdentifier texture, int width, int height)
	{
		this.texture = texture;
		this.width = width;
		this.height = height;
	}
}
