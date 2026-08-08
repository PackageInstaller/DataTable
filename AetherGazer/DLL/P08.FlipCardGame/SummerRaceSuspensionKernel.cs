using UnityEngine;

public static class SummerRaceSuspensionKernel
{
	public struct SpringState
	{
		public float value;

		public float velocity;
	}

	public struct SpringConfig
	{
		public float springK;

		public float damping;
	}

	public struct SuspensionBodyMultipliers
	{
		public float springMul;

		public float dampingMul;
	}

	public struct SuspensionContext
	{
		public SummerRaceBodyType bodyType;

		public float wheelRadius;

		public float wheelProbeExtra;

		public float massScale;

		public float normalSpeed;

		public float compression;

		public float tangentVelocity;

		public float throttle;
	}

	public static void IntegrateSpring(ref SpringState state, SpringConfig config, float dt)
	{
		float num = Mathf.Max(0.0001f, dt);
		float num2 = Mathf.Max(0f, config.springK);
		float num3 = Mathf.Max(0f, config.damping);
		float num4 = (0f - num2) * state.value - num3 * state.velocity;
		state.velocity += num4 * num;
		state.value += state.velocity * num;
	}

	public static float ComputeSuspensionReach(in SuspensionContext context)
	{
		float num = ((context.bodyType == SummerRaceBodyType.Heavy) ? 1.38f : ((context.bodyType == SummerRaceBodyType.Light) ? 1f : 1.16f));
		return Mathf.Max(0.05f, context.wheelProbeExtra * num + context.wheelRadius * 0.22f);
	}

	public static SuspensionBodyMultipliers ResolveBodyMultipliers(in SuspensionContext context)
	{
		if (context.bodyType == SummerRaceBodyType.Heavy)
		{
			return new SuspensionBodyMultipliers
			{
				springMul = 1.14f,
				dampingMul = 0.98f
			};
		}
		if (context.bodyType == SummerRaceBodyType.Light)
		{
			return new SuspensionBodyMultipliers
			{
				springMul = 1f,
				dampingMul = 1f
			};
		}
		return new SuspensionBodyMultipliers
		{
			springMul = 1f,
			dampingMul = 1f
		};
	}
}
