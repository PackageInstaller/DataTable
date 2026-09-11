using UnityEngine;
using UnityEngine.Playables;

public class SlowFollowBehaviour : PlayableBehaviour
{
	public ETargetType targetType;

	public ExposedReference<Transform> target;

	public ExposedReference<Transform> follower;

	public float angleThreshold;

	public float distanceThreshold;

	public AnimationCurve speedCurve;

	private Transform _targetTrans;

	private Transform _followerTrans;

	private Quaternion _lastRot;

	private Quaternion _currentRot;

	private Vector3 _lastPos;

	private Vector3 _currentPos;

	private Vector3 _targetPos;

	private bool _isMoving;

	private float _maxDistance;

	public override void OnGraphStart(Playable playable)
	{
		base.OnGraphStart(playable);
		Init(playable);
	}

	private void Init(Playable playable)
	{
		if (targetType == ETargetType.MainCamera)
		{
			_targetTrans = Camera.main.gameObject.transform;
		}
		else
		{
			_targetTrans = target.Resolve(playable.GetGraph().GetResolver());
		}
		_followerTrans = follower.Resolve(playable.GetGraph().GetResolver());
		if (_targetTrans == null || _followerTrans == null)
		{
			Debug.LogError("_targetTrans == null or _followerTrans == null");
			return;
		}
		_lastRot = _targetTrans.rotation;
		_targetPos = (_lastPos = _targetTrans.position);
		_followerTrans.position = _targetPos;
		_isMoving = false;
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		base.ProcessFrame(playable, info, playerData);
		if (!(_targetTrans == null) && !(_followerTrans == null))
		{
			if (Vector3.Distance(_targetTrans.position, _currentPos) > distanceThreshold)
			{
				Init(playable);
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
				_followerTrans.position = Vector3.MoveTowards(_followerTrans.position, _targetPos, num4 * info.deltaTime);
			}
		}
	}
}
