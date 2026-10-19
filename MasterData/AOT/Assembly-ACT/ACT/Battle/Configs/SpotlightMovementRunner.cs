using Bamboo.ECS;
using UnityEngine;

namespace ACT.Battle.Configs;

public class SpotlightMovementRunner : TrajectoryMovementRunner
{
	private const float TotalInterpolationTime = 1f;

	private float interpolationTime;

	private float angle;

	protected override void OnCreate()
	{
		CompSpotLightBuffer compSpotLightBuffer = bullet.GetCompSpotLightBuffer();
		CompTransform? compTransform = bullet.GetCompTransform();
		Vector3 pos = compSpotLightBuffer.pos + Vector3.up * compSpotLightBuffer.height;
		compTransform.UpdatePosition(pos);
		compTransform.UpdatePosition(pos);
	}

	public override void FixedUpdate(float dt)
	{
		CompSpotLightBuffer compSpotLightBuffer = bullet.GetCompSpotLightBuffer();
		CompTransform? compTransform = bullet.GetCompTransform();
		float num = angle;
		if (!Mathf.Approximately(angle, compSpotLightBuffer.biasAngle))
		{
			interpolationTime += dt;
			num = Mathf.Lerp(angle, compSpotLightBuffer.biasAngle, interpolationTime / 1f);
			if (num == compSpotLightBuffer.biasAngle)
			{
				angle = compSpotLightBuffer.biasAngle;
				interpolationTime = 0f;
			}
		}
		Vector3 vector = compSpotLightBuffer.pos + compSpotLightBuffer.height * Mathf.Sin(num) * Vector3.right + compSpotLightBuffer.height * Vector3.up;
		compTransform.UpdatePosition(vector);
		compTransform.rotation = Quaternion.LookRotation(compSpotLightBuffer.pos - vector, Vector3.forward);
	}

	public override void Update(float dt)
	{
		UpdatePositionInterpolation();
	}

	protected override void OnReset()
	{
	}
}
