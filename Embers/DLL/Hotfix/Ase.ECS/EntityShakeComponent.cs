using Cinemachine;
using UnityEngine;

namespace Ase.ECS;

public class EntityShakeComponent : BaseComponent
{
	private bool openShake;

	private int attakPower = -1;

	private float m_AmplitudeGain;

	private float m_FrequencyGain = 1f;

	private float mNoiseTime;

	private Vector3 mNoiseOffsets = Vector3.zero;

	private Vector3 positionCorrection;

	private Quaternion orientationCorrection;

	private Vector3 rawPosition;

	private Quaternion rawOrientation;

	private Transform rootTransform;

	private float shakeTimer;

	private float shakeTimerTotal;

	private float startingIntensity;

	private float shakeMultiple = 1f;

	public override void OnAwake(object data = null)
	{
		base.OnAwake(data);
		rootTransform = mBaseEntity.GetComponent<EntityBoneComponent>().GetBoneRoot("root");
		if (!(rootTransform == null))
		{
			rawPosition = rootTransform.localPosition;
			rawOrientation = rootTransform.rotation;
			orientationCorrection = rawOrientation;
			mNoiseTime = 0f;
			shakeMultiple = mBaseEntity.GetData<float>("ShakeMultiple");
			if (mNoiseOffsets == Vector3.zero)
			{
				ReSeed();
			}
		}
	}

	private void ReSeed()
	{
		mNoiseOffsets = new Vector3(Random.Range(-1000f, 1000f), Random.Range(-1000f, 1000f), Random.Range(-1000f, 1000f));
	}

	public override void OnFixedUpdate(WorldUpdateType updateType, float deltaTime)
	{
		base.OnFixedUpdate(updateType, deltaTime);
		if (rootTransform == null || !openShake || deltaTime < 0f)
		{
			return;
		}
		if (shakeTimer > 0f)
		{
			shakeTimer -= 0.033f;
			if (shakeTimer <= 0f)
			{
				rootTransform.localPosition = rawPosition;
				shakeTimer = 0f;
				openShake = false;
				attakPower = -1;
				m_AmplitudeGain = 0f;
				shakeTimerTotal = 0f;
				positionCorrection = Vector3.zero;
				orientationCorrection = rawOrientation;
				mNoiseTime = 0f;
				return;
			}
		}
		OnShakeEntity(deltaTime);
	}

	private void OnShakeEntity(float deltaTime)
	{
		if (!(rootTransform == null))
		{
			mNoiseTime += deltaTime * m_FrequencyGain;
			NoiseSettings monsterNoiseSettings = mBaseEntity.GetWorld().MonsterNoiseSettings;
			if (!(monsterNoiseSettings == null))
			{
				positionCorrection = rawOrientation * orientationCorrection * NoiseSettings.GetCombinedFilterResults(monsterNoiseSettings.PositionNoise, mNoiseTime, mNoiseOffsets) * m_AmplitudeGain;
				rootTransform.localPosition = rawPosition + positionCorrection;
			}
		}
	}

	public void ShakeEntity(float duration, int strength, float multiple)
	{
		if (!(rootTransform == null) && strength > 0 && attakPower <= strength)
		{
			attakPower = strength;
			m_AmplitudeGain = 4f / 9f * (float)(strength - 1) + 1f;
			m_AmplitudeGain *= multiple;
			m_AmplitudeGain *= shakeMultiple;
			shakeTimer = duration;
			shakeTimerTotal = duration;
			mNoiseTime = 0f;
			openShake = true;
		}
	}
}
