using System;

namespace UnityEngine.Experimental.Rendering;

[Serializable]
internal struct ProbeDilationSettings
{
	public bool enableDilation;

	public float dilationDistance;

	public float dilationValidityThreshold;

	public int dilationIterations;

	public bool squaredDistWeighting;
}
