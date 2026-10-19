using UnityEngine;

namespace ACT.Battle.Configs;

public class RandomJitterVelocityModifier : VelocityModifier
{
	public float amplitude = 0.5f;

	public float frequency = 10f;

	public bool keepMagnitude = true;

	public DimensionMode dimensionMode;

	public Vector3 noiseOffset = new Vector3(11.73f, 37.19f, 59.71f);

	public override Vector3 Modify(Vector3 velocity, float dt, float lifeTime)
	{
		if (amplitude <= 0f || frequency <= 0f)
		{
			return velocity;
		}
		Vector3 jitter = SampleJitter(lifeTime);
		jitter = ApplyDimension(jitter);
		Vector3 result = velocity + jitter;
		if (keepMagnitude && velocity != Vector3.zero)
		{
			result = result.normalized * velocity.magnitude;
		}
		return result;
	}

	private Vector3 SampleJitter(float lifeTime)
	{
		float num = lifeTime * frequency;
		float x = (Mathf.PerlinNoise(num + noiseOffset.x, noiseOffset.x) * 2f - 1f) * amplitude;
		float y = (Mathf.PerlinNoise(num + noiseOffset.y, noiseOffset.y) * 2f - 1f) * amplitude;
		float z = (Mathf.PerlinNoise(num + noiseOffset.z, noiseOffset.z) * 2f - 1f) * amplitude;
		return new Vector3(x, y, z);
	}

	private Vector3 ApplyDimension(Vector3 jitter)
	{
		return dimensionMode switch
		{
			DimensionMode.XZ => new Vector3(jitter.x, 0f, jitter.z), 
			DimensionMode.XYZ => jitter, 
			DimensionMode.Z => new Vector3(0f, 0f, jitter.z), 
			DimensionMode.X => new Vector3(jitter.x, 0f, 0f), 
			DimensionMode.Y => new Vector3(0f, jitter.y, 0f), 
			_ => jitter, 
		};
	}
}
