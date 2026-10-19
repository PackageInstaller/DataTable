using System;
using System.Collections.Generic;
using ACT.Battle;
using Bamboo.Precache;
using UnityEngine;

namespace ACT.World.StateObject;

public sealed class HitHealDeviceLightPoint : MonoBehaviour, IDisposable
{
	private enum Stage
	{
		Scatter,
		Wait,
		Chase,
		Released
	}

	private const float ArrivalDistance = 0.05f;

	private const int CurveAreaSampleCount = 16;

	private const float MinimumSpeedCurveArea = 0.001f;

	private HitHealDeviceManager _manager;

	private InstanceHandle _handle;

	private Func<Vector3?> _getChaseTargetPosition;

	private Action _onArrive;

	private Action<HitHealDeviceLightPoint> _onReleased;

	private Vector3 _scatterTarget;

	private Vector3 _lastPosition;

	private Vector3 _position;

	private AnimationCurve _scatterSpeedCurve;

	private AnimationCurve _chaseSpeedCurve;

	private float _scatterMoveDuration;

	private float _chaseMaxSpeed;

	private float _chaseAccelerationDuration;

	private float _scatterElapsedTime;

	private float _chaseElapsedTime;

	private float _scatterBaseSpeed;

	private float _arrivalWaitTime;

	private float _waitRemaining;

	private bool _initialized;

	private Stage _stage;

	internal LinkedListNode<HitHealDeviceManager.ActiveLightPoint> node;

	public void Initialize(InstanceHandle handle, HitHealDeviceManager manager, Vector3 startPosition, Vector3 scatterTarget, Vector3 direction, float scatterMoveDuration, AnimationCurve scatterSpeedCurve, float arrivalWaitTime, float chaseMaxSpeed, float chaseAccelerationDuration, AnimationCurve chaseSpeedCurve, Func<Vector3?> getChaseTargetPosition, Action onArrive, Action<HitHealDeviceLightPoint> onReleased)
	{
		_handle = handle;
		_manager = manager;
		_scatterTarget = scatterTarget;
		_lastPosition = startPosition;
		_position = startPosition;
		_scatterMoveDuration = Mathf.Max(0.001f, scatterMoveDuration);
		_scatterSpeedCurve = scatterSpeedCurve;
		_arrivalWaitTime = arrivalWaitTime;
		_chaseMaxSpeed = Mathf.Max(0.001f, chaseMaxSpeed);
		_chaseAccelerationDuration = Mathf.Max(0.001f, chaseAccelerationDuration);
		_chaseSpeedCurve = chaseSpeedCurve;
		_scatterElapsedTime = 0f;
		_chaseElapsedTime = 0f;
		_scatterBaseSpeed = CalculateScatterBaseSpeed(startPosition, scatterTarget, _scatterMoveDuration, _scatterSpeedCurve);
		_getChaseTargetPosition = getChaseTargetPosition;
		_onArrive = onArrive;
		_onReleased = onReleased;
		_stage = Stage.Scatter;
		_initialized = true;
		transform.position = _position;
		if (direction.sqrMagnitude > 0f)
		{
			transform.up = direction;
		}
	}

	private void FixedUpdate()
	{
		if (!_initialized || _stage == Stage.Released)
		{
			return;
		}
		if (_handle == null || !_handle.IsValid)
		{
			Release(releaseInstance: false);
			return;
		}
		float fixedDeltaTime = Time.fixedDeltaTime;
		_lastPosition = _position;
		switch (_stage)
		{
		case Stage.Scatter:
			_position = MoveScatterWithSpeedCurve(_position, _scatterTarget, _scatterSpeedCurve, ref _scatterElapsedTime, _scatterMoveDuration, _scatterBaseSpeed, fixedDeltaTime);
			if (_scatterElapsedTime >= _scatterMoveDuration)
			{
				_position = _scatterTarget;
				_waitRemaining = _arrivalWaitTime;
				_stage = Stage.Wait;
			}
			break;
		case Stage.Wait:
			_waitRemaining -= fixedDeltaTime;
			if (_waitRemaining <= 0f)
			{
				_chaseElapsedTime = 0f;
				_stage = Stage.Chase;
			}
			break;
		case Stage.Chase:
		{
			Vector3? vector = _getChaseTargetPosition?.Invoke();
			if (vector.HasValue)
			{
				_position = MoveTowardsWithTimeSpeedCurve(_position, vector.Value, _chaseSpeedCurve, ref _chaseElapsedTime, _chaseAccelerationDuration, _chaseMaxSpeed, fixedDeltaTime);
				if ((_position - vector.Value).sqrMagnitude <= 0.0025000002f)
				{
					_onArrive?.Invoke();
					Dispose();
				}
			}
			break;
		}
		}
	}

	private static float CalculateScatterBaseSpeed(Vector3 startPosition, Vector3 targetPosition, float duration, AnimationCurve speedCurve)
	{
		float b = CalculateSpeedCurveArea(speedCurve, 0f, 1f);
		return Vector3.Distance(startPosition, targetPosition) / (Mathf.Max(0.001f, duration) * Mathf.Max(0.001f, b));
	}

	private static Vector3 MoveScatterWithSpeedCurve(Vector3 currentPosition, Vector3 targetPosition, AnimationCurve speedCurve, ref float elapsedTime, float duration, float baseSpeed, float deltaTime)
	{
		float startNormalizedTime = Mathf.Clamp01(elapsedTime / duration);
		elapsedTime = Mathf.Min(elapsedTime + deltaTime, duration);
		float endNormalizedTime = Mathf.Clamp01(elapsedTime / duration);
		float num = CalculateSpeedCurveArea(speedCurve, startNormalizedTime, endNormalizedTime);
		float maxDistanceDelta = baseSpeed * duration * num;
		return Vector3.MoveTowards(currentPosition, targetPosition, maxDistanceDelta);
	}

	private static float CalculateSpeedCurveArea(AnimationCurve speedCurve, float startNormalizedTime, float endNormalizedTime)
	{
		if (endNormalizedTime <= startNormalizedTime)
		{
			return 0f;
		}
		int num = Mathf.Max(1, Mathf.CeilToInt((endNormalizedTime - startNormalizedTime) * 16f));
		float num2 = (endNormalizedTime - startNormalizedTime) / (float)num;
		float num3 = EvaluateNormalizedSpeed(speedCurve, startNormalizedTime);
		float num4 = 0f;
		for (int i = 1; i <= num; i++)
		{
			float normalizedTime = startNormalizedTime + num2 * (float)i;
			float num5 = EvaluateNormalizedSpeed(speedCurve, normalizedTime);
			num4 += (num3 + num5) * 0.5f * num2;
			num3 = num5;
		}
		return num4;
	}

	private static float EvaluateNormalizedSpeed(AnimationCurve speedCurve, float normalizedTime)
	{
		return Mathf.Clamp01(speedCurve?.Evaluate(normalizedTime) ?? 1f);
	}

	private static Vector3 MoveTowardsWithTimeSpeedCurve(Vector3 currentPosition, Vector3 targetPosition, AnimationCurve speedCurve, ref float elapsedTime, float duration, float baseSpeed, float deltaTime)
	{
		elapsedTime += deltaTime;
		float time = Mathf.Clamp01(elapsedTime / duration);
		float num = Mathf.Clamp01(speedCurve?.Evaluate(time) ?? 1f);
		return Vector3.MoveTowards(currentPosition, targetPosition, baseSpeed * num * deltaTime);
	}

	private void Update()
	{
		if (_initialized && _stage != Stage.Released)
		{
			if (_handle == null || !_handle.IsValid)
			{
				Release(releaseInstance: false);
				return;
			}
			float fixedDeltaTime = Time.fixedDeltaTime;
			float t = ((fixedDeltaTime > 0f) ? ((Time.time - Time.fixedTime) / fixedDeltaTime) : 0f);
			transform.position = Vector3.Lerp(_lastPosition, _position, t);
		}
	}

	public void Dispose()
	{
		Release(releaseInstance: true);
	}

	private void OnDestroy()
	{
		Release(releaseInstance: false);
	}

	private void Release(bool releaseInstance)
	{
		if (_initialized && _stage != Stage.Released)
		{
			_stage = Stage.Released;
			if (node != null)
			{
				_manager?.Unregister(node);
				node = null;
			}
			Action<HitHealDeviceLightPoint> onReleased = _onReleased;
			_onReleased = null;
			_onArrive = null;
			_getChaseTargetPosition = null;
			onReleased?.Invoke(this);
			InstanceHandle handle = _handle;
			_handle = null;
			if (releaseInstance && handle != null && handle.IsValid)
			{
				PrecacheManager.Instance.ReleaseInstanceHandle(handle);
			}
		}
	}
}
