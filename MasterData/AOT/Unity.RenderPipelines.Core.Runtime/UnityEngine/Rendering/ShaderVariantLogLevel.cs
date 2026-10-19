namespace UnityEngine.Rendering;

public enum ShaderVariantLogLevel
{
	[Tooltip("No shader variants are logged")]
	Disabled,
	[Tooltip("Only shaders that are compatible with SRPs (e.g., URP, HDRP) are logged")]
	OnlySRPShaders,
	[Tooltip("All shader variants are logged")]
	AllShaders
}
