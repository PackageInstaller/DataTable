namespace UnityEngine.Rendering;

[GenerateHLSL(PackingRules.Exact, true, false, false, 1, false, false, false, -1, "D:\\KIIF_Ase_Client3.0_pay\\Library\\PackageCache\\com.unity.render-pipelines.core@12.1.13\\Runtime\\Lighting\\ProbeVolume\\ShaderVariablesProbeVolumes.cs", needAccessors = false, generateCBuffer = true, constantRegister = 5)]
internal struct ShaderVariablesProbeVolumes
{
	public Vector3 _PoolDim;

	public float _ViewBias;

	public Vector3 _MinCellPosition;

	public float _PVSamplingNoise;

	public Vector3 _CellIndicesDim;

	public float _CellInMeters;

	public float _CellInMinBricks;

	public float _MinBrickSize;

	public int _IndexChunkSize;

	public float _NormalBias;
}
