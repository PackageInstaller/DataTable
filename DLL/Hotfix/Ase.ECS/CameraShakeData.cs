using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class CameraShakeData : IReference
{
	private float _weight;

	private float _shakeTimer;

	public float LinearTime;

	private float _startingIntensity;

	private NoiseData _noiseData;

	private AnimationCurve _intensityCurveData;

	private float _startFrequency;

	private AnimationCurve _frequencyCurveData;

	private float _intensityBlendTime;

	private float _lastIntensity;

	private int infoIndex;

	public int InfoIndex => infoIndex;

	public float Weight => _weight;

	public float ShakeTimer => _shakeTimer;

	public float StartingIntensity => _startingIntensity;

	public float StartingFrequency => _startFrequency;

	public NoiseData NoiseData => _noiseData;

	public AnimationCurve IntensityCurveData => _intensityCurveData;

	public float CurTimeIntensity
	{
		get
		{
			float num = StartingIntensity;
			if (_intensityBlendTime > 0f && _shakeTimer - LinearTime <= _intensityBlendTime)
			{
				num = _lastIntensity + (_startFrequency - _lastIntensity) * (_shakeTimer - LinearTime) / _intensityBlendTime;
			}
			else if (_intensityCurveData != null)
			{
				float time = Mathf.Clamp01(1f - LinearTime / _shakeTimer);
				num = _intensityCurveData.Evaluate(time) * _startingIntensity;
			}
			return num * GameSettingExtension.GetFloatRawValue("角色震屏强度");
		}
	}

	public float CurTimeFrequency
	{
		get
		{
			if (_frequencyCurveData != null)
			{
				float time = Mathf.Clamp01(1f - LinearTime / _shakeTimer);
				return _frequencyCurveData.Evaluate(time) * _startFrequency;
			}
			return _startFrequency;
		}
	}

	public static CameraShakeData Create(CameraShakeData cameraShakeData, float weight, float shakeTimer, float startingIntensity, float startFrequency, NoiseData noiseData, AnimationCurve intensityCurveData, AnimationCurve frequencyCurveData, float intensityBlendTime, float lastIntensity, int index)
	{
		CameraShakeData cameraShakeData2 = null;
		cameraShakeData2 = ((cameraShakeData == null) ? ReferencePool.Acquire<CameraShakeData>() : cameraShakeData);
		cameraShakeData2._shakeTimer = shakeTimer;
		cameraShakeData2._weight = weight;
		cameraShakeData2._startingIntensity = startingIntensity;
		cameraShakeData2._startFrequency = startFrequency;
		cameraShakeData2.LinearTime = shakeTimer;
		cameraShakeData2._noiseData = noiseData;
		cameraShakeData2._intensityCurveData = intensityCurveData;
		cameraShakeData2._frequencyCurveData = frequencyCurveData;
		cameraShakeData2._intensityBlendTime = intensityBlendTime;
		cameraShakeData2._lastIntensity = lastIntensity;
		cameraShakeData2.infoIndex = index;
		return cameraShakeData2;
	}

	public void Clear()
	{
		_weight = 0f;
		_shakeTimer = 0f;
		_startingIntensity = 0f;
		_startFrequency = 0f;
		_frequencyCurveData = null;
		_noiseData = null;
		_intensityCurveData = null;
		_intensityBlendTime = 0f;
		LinearTime = 0f;
	}
}
