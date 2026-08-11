using GameFramework;
using UnityEngine;

namespace Ase.ECS;

public class AnimationCurveData : IReference
{
	private AnimationCurve _moveCurve;

	private float _moveTime;

	private float _curvePercent;

	private Vector3 _originPos;

	private float _startCurve;

	private float _curveMultiple;

	private float _lastCurvePercent;

	private float value;

	private float offset;

	public float MoveTime => _moveTime;

	public static AnimationCurveData Create(AnimationCurve curve, float length, float multiple, float startTime, Vector3 originPos, float offset = 0f)
	{
		AnimationCurveData animationCurveData = ReferencePool.Acquire<AnimationCurveData>();
		animationCurveData._moveCurve = curve;
		animationCurveData._moveTime = length + startTime;
		animationCurveData._curvePercent = startTime;
		animationCurveData._startCurve = curve.Evaluate(0f);
		animationCurveData._originPos = originPos;
		animationCurveData._curveMultiple = multiple;
		animationCurveData._lastCurvePercent = startTime;
		animationCurveData.value = 0f;
		animationCurveData.offset = offset;
		return animationCurveData;
	}

	public AnimationCurveData CopySelf()
	{
		AnimationCurveData animationCurveData = ReferencePool.Acquire<AnimationCurveData>();
		animationCurveData._moveCurve = _moveCurve;
		animationCurveData._moveTime = _moveTime;
		animationCurveData._curvePercent = _curvePercent;
		animationCurveData._startCurve = _startCurve;
		animationCurveData._originPos = _originPos;
		animationCurveData._curveMultiple = _curveMultiple;
		animationCurveData._lastCurvePercent = _lastCurvePercent;
		animationCurveData.value = value;
		animationCurveData.offset = offset;
		return animationCurveData;
	}

	public float GetOffset(float deltaTime)
	{
		_lastCurvePercent = _curvePercent;
		_curvePercent = Mathf.Clamp(_curvePercent + deltaTime, 0f, _moveTime);
		value = _moveCurve.Evaluate(_curvePercent) * _curveMultiple;
		return value + offset;
	}

	public void Clear()
	{
		_moveCurve = null;
	}
}
