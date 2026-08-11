using System;

namespace UnityEngine.Experimental.Rendering;

[Serializable]
internal struct ProbeVolumeBakingProcessSettings
{
	public ProbeDilationSettings dilationSettings;

	public VirtualOffsetSettings virtualOffsetSettings;
}
