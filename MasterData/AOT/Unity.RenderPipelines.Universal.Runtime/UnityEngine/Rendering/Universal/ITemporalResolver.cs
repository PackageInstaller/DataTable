namespace UnityEngine.Rendering.Universal;

public interface ITemporalResolver
{
	bool usesTemporalOutput { get; }

	bool TryResolve(CommandBuffer cmd, RenderTargetIdentifier source, RTHandle sourceHandle, ref RenderingData renderingData, out TemporalResolveResult result);
}
