namespace UnityEngine.Rendering.Universal;

internal static class RenderPassScheduleModeExtensions
{
	internal static bool UsesLinearMotionVector(this RenderPassScheduleMode mode)
	{
		return mode == RenderPassScheduleMode.PC;
	}

	internal static bool UsesHighPrecisionGBufferMotionVector(this RenderPassScheduleMode mode)
	{
		return mode == RenderPassScheduleMode.PC;
	}
}
