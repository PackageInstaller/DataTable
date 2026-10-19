using System.Collections.Generic;
using Bamboo.ECS;
using Cinemachine;
using UnityEngine;

namespace ACT.Battle;

public class ACTCameraTargetGroup : CinemachineTargetGroup
{
	public float minFOV = 30f;

	public float maxFOV = 80f;

	public float distanceToFOVFactor = 0.5f;

	public float smoothTime = 0.3f;

	public float currentFOV;

	public float smoothVelocity;

	public CinemachineVirtualCamera vcam;

	private void FixedUpdate()
	{
		if (m_UpdateMethod == UpdateMethod.FixedUpdate)
		{
			DoUpdate();
			AutoChangeFOV();
		}
	}

	private void Update()
	{
		if (!Application.isPlaying || m_UpdateMethod == UpdateMethod.Update)
		{
			DoUpdate();
			AutoChangeFOV();
		}
	}

	private void LateUpdate()
	{
		if (m_UpdateMethod == UpdateMethod.LateUpdate)
		{
			DoUpdate();
			AutoChangeFOV();
		}
	}

	public void AutoChangeFOV()
	{
		if (m_Targets.Length != 0)
		{
			Bounds bounds = CalculateGroupBounds();
			float target = CalculateFOVFromBounds(bounds);
			currentFOV = Mathf.SmoothDamp(currentFOV, target, ref smoothVelocity, smoothTime);
			currentFOV = Mathf.Round(currentFOV);
			if (vcam != null)
			{
				vcam.m_Lens.FieldOfView = currentFOV;
			}
		}
	}

	private Bounds CalculateGroupBounds()
	{
		if (m_Targets.Length == 0)
		{
			return new Bounds(transform.position, Vector3.zero);
		}
		Bounds result = new Bounds(m_Targets[0].target.position, Vector3.zero);
		Target[] targets = m_Targets;
		for (int i = 0; i < targets.Length; i++)
		{
			Target target = targets[i];
			if (target.target != null)
			{
				result.Encapsulate(target.target.position);
			}
		}
		return result;
	}

	private float CalculateFOVFromBounds(Bounds bounds)
	{
		float y = bounds.size.y;
		float magnitude = (transform.position - bounds.center).magnitude;
		return Mathf.Clamp(Mathf.Atan2(y * 0.5f, magnitude) * 57.29578f * 2f * distanceToFOVFactor, minFOV, maxFOV);
	}

	public void SetTargetGroup(List<Entity> entityList, List<(float weight, float radius)> targetParams, PositionMode positionMode, RotationMode rotationMode, UpdateMethod updateMethod)
	{
		m_Targets = new Target[entityList.Count];
		for (int i = 0; i < entityList.Count; i++)
		{
			float weight;
			float radius;
			if (i >= targetParams.Count)
			{
				float num = 1f;
				weight = 1f;
				radius = num;
			}
			else
			{
				(weight, radius) = targetParams[i];
			}
			m_Targets[i] = new Target
			{
				target = entityList[i].GetMono().transform,
				weight = weight,
				radius = radius
			};
		}
		m_PositionMode = positionMode;
		m_RotationMode = rotationMode;
		m_UpdateMethod = updateMethod;
	}
}
