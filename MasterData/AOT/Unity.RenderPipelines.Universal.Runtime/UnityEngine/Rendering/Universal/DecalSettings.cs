using System;

namespace UnityEngine.Rendering.Universal;

[Serializable]
public class DecalSettings
{
	[Tooltip("Runtime content switch. The Renderer Feature Active checkbox remains the authoring-level gate.")]
	public bool enabled = true;

	public float maxDrawDistance = 1000f;

	public DecalSettings Clone()
	{
		return (DecalSettings)MemberwiseClone();
	}
}
