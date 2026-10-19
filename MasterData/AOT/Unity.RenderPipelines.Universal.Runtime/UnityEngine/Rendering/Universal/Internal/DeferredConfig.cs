namespace UnityEngine.Rendering.Universal.Internal;

internal static class DeferredConfig
{
	public const int kTilerDepth = 3;

	internal static bool IsOpenGL { get; set; }

	internal static bool IsDX10 { get; set; }
}
