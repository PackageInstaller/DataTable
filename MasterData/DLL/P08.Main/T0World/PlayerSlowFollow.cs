using UnityEngine;

namespace T0World;

public class PlayerSlowFollow : MonoBehaviour
{
	public float angleThreshold = 999f;

	public float distanceThreshold = 999f;

	[Tooltip("x为归一化的距离")]
	public AnimationCurve speedCurve = new AnimationCurve(new Keyframe(0f, 1f), new Keyframe(1f, 1f));

	private Transform _targetTrans;

	private Transform _followerTrans;

	private Quaternion _lastRot;

	private Quaternion _currentRot;

	private Vector3 _lastPos;

	private Vector3 _currentPos;

	private Vector3 _targetPos;

	private bool _isMoving;

	private float _maxDistance;

	public void SetFollowTarget(Transform targetNode)
	{
		_targetTrans = targetNode;
		_followerTrans = base.transform;
	}

	public void Init()
	{
		_lastRot = _targetTrans.rotation;
		_targetPos = (_lastPos = _targetTrans.position);
		_followerTrans.position = _targetPos;
		_isMoving = false;
	}

	private void Update()
	{
		if (!(_targetTrans == null) && !(_followerTrans == null))
		{
			if (Vector3.Distance(_targetTrans.position, _currentPos) > distanceThreshold)
			{
				Init();
			}
			_currentRot = _targetTrans.rotation;
			_currentPos = _targetTrans.position;
			float num = Quaternion.Angle(_lastRot, _currentRot);
			float num2 = Vector3.Distance(_lastPos, _currentPos);
			if ((num >= angleThreshold || num2 >= distanceThreshold) && !_isMoving)
			{
				_lastRot = _currentRot;
				_lastPos = _currentPos;
				_targetPos = _targetTrans.position;
				_maxDistance = num2;
				_isMoving = true;
			}
			float num3 = Vector3.SqrMagnitude(_followerTrans.position - _targetPos);
			if (num3 <= 0.0001f)
			{
				_isMoving = false;
			}
			if (_isMoving)
			{
				_targetPos = _targetTrans.position;
				float time = 1f - Mathf.Clamp01(num3 / (_maxDistance * _maxDistance));
				float num4 = speedCurve.Evaluate(time);
				_followerTrans.position = Vector3.MoveTowards(_followerTrans.position, _targetPos, num4 * Time.deltaTime);
			}
		}
	}
}
