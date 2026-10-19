using ACT.Battle;

namespace Bamboo.ECS;

public static class Entity_Extension_Time
{
	public static void ApplyFrameHalt(this Entity entity, float frameHaltDuration, float frameHaltSpeedMul)
	{
		if (entity.TryGetCompTime(out CompTime component))
		{
			component.frameHaltDuration = frameHaltDuration;
			component.frameHaltScale = frameHaltSpeedMul;
		}
	}

	public static void ApplyDebugFrameHalt(this Entity entity, float duration, float speed)
	{
		if (entity.TryGetCompTime(out CompTime component))
		{
			component.frameHaltDuration = duration;
			component.debugFrameHaltScale = speed;
			component.frameHaltDuration = 0f;
			component.frameHaltScale = 1f;
		}
	}
}
