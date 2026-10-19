namespace UnityEngine.Rendering.Universal;

public readonly struct TemporalResolveResult(RenderTargetIdentifier source, RTHandle outputHandle, int outputWidth, int outputHeight)
{
	public readonly RenderTargetIdentifier source = source;

	public readonly RTHandle outputHandle = outputHandle;

	public readonly int outputWidth = outputWidth;

	public readonly int outputHeight = outputHeight;
}
