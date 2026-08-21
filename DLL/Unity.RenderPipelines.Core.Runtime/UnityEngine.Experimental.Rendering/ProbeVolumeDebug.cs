namespace UnityEngine.Experimental.Rendering;

internal class ProbeVolumeDebug
{
	public bool drawProbes;

	public bool drawBricks;

	public bool drawCells;

	public bool realtimeSubdivision;

	public int subdivisionCellUpdatePerFrame = 4;

	public float subdivisionDelayInSeconds = 1f;

	public DebugProbeShadingMode probeShading;

	public float probeSize = 1f;

	public float subdivisionViewCullingDistance = 500f;

	public float probeCullingDistance = 200f;

	public int maxSubdivToVisualize = 7;

	public float exposureCompensation;
}
