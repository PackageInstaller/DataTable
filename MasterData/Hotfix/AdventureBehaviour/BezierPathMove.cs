using System;
using System.Collections;
using TrueSync;
using UnityEngine;

namespace AdventureBehaviour;

public class BezierPathMove
{
	private CoroutineNode _movingCoroutine;

	private TSVector _startPosition;

	private TSVector _endPosition;

	private TSVector _controlPoint;

	private int _currentStep;

	private int _moveStep;

	private bool _stepMoveFinish;

	private AdventureActor _actor;

	private AdventureActor.MovementMode _movementMode;

	private Action<bool> _completeCallback;

	private bool _moveEnd = true;

	private FP _moveSpeedRatioAbsAmend;

	private FP _maxDuration;

	private FP _startTime;

	public void BeginMove(AdventureActor actor, TSVector2 targetPosition, FP controlPointXOffsetRatio, FP controlPointYOffsetRatio, bool comboWithAttack = false, FP moveSpeedRatioAbsAmend = default(FP), AdventureActor.MovementMode movementMode = AdventureActor.MovementMode.Run, int moveStep = 20, Action<bool> completeCallback = null, FP maxDuration = default(FP))
	{
		if (moveStep < 2)
		{
			Debug.LogWarning("移动步数不能小于2");
			completeCallback?.Invoke(obj: false);
			return;
		}
		_moveEnd = false;
		_actor = actor;
		_moveStep = moveStep;
		_moveSpeedRatioAbsAmend = moveSpeedRatioAbsAmend;
		_movementMode = movementMode;
		_completeCallback = completeCallback;
		_startPosition = new TSVector(actor.tsTransform.Position.x, 0, actor.tsTransform.Position.y);
		_endPosition = new TSVector(targetPosition.x, 0, targetPosition.y);
		_maxDuration = maxDuration;
		_startTime = _actor.LogicTime;
		TSVector normalized = (_endPosition - _startPosition).normalized;
		FP fP = TSVector.Distance(_startPosition, _endPosition);
		FP fP2 = fP * controlPointXOffsetRatio;
		FP fP3 = TSMath.Abs(fP * controlPointYOffsetRatio);
		TSVector tSVector = ((!(controlPointYOffsetRatio < 0)) ? new TSVector(normalized.z, 0, -normalized.x).normalized : new TSVector(-normalized.z, 0, normalized.x).normalized);
		_controlPoint = _startPosition + normalized * fP2;
		_controlPoint += tSVector * fP3;
		if (!comboWithAttack)
		{
			actor.InterruptAttack(force: true, fadeOutAnim: false);
		}
		_movingCoroutine = actor.StartLogicCoroutine(Moving());
	}

	private bool CheckBreak()
	{
		if (_maxDuration > 0 && _maxDuration + _startTime < _actor.LogicTime)
		{
			return true;
		}
		if (_actor.iExMove)
		{
			return true;
		}
		return false;
	}

	private IEnumerator Moving()
	{
		_currentStep = 1;
		bool finish = true;
		_actor.actorInfo.moveSpeedRatioAbsAmend = _moveSpeedRatioAbsAmend;
		_actor.RefreshMoveSpeed();
		while (_currentStep <= _moveStep)
		{
			if (CheckBreak())
			{
				CancelMove();
				break;
			}
			FP t = (FP)_currentStep / (FP)_moveStep;
			TSVector bezierPointByT = CommonHelper.GetBezierPointByT(_startPosition, _controlPoint, _endPosition, t);
			TSVector2 tSVector = new TSVector2(bezierPointByT.x, bezierPointByT.z);
			if (!_actor.QueryPositionWalkable(tSVector))
			{
				finish = false;
				_actor.StandBy();
				break;
			}
			_stepMoveFinish = false;
			bool stayWhenReachTarget = _currentStep < _moveStep;
			if (!_actor.MoveTo(tSVector, 0, targetPosY: _actor.tsTransform.PositionY, enableNavigation: true, movementMode: _movementMode, onComplete: () =>
			{
				_stepMoveFinish = true;
			}, randomMove: false, forceMove: false, onLeave: () =>
			{
				_stepMoveFinish = true;
				_currentStep = _moveStep + 1;
			}, stayWhenReachTarget: stayWhenReachTarget))
			{
				finish = false;
				_actor.StandBy();
				break;
			}
			_currentStep++;
			while (!_stepMoveFinish)
			{
				if (CheckBreak())
				{
					CancelMove();
					break;
				}
				yield return null;
			}
		}
		End(finish);
	}

	private void End(bool finish)
	{
		if (_moveEnd)
		{
			return;
		}
		_moveEnd = true;
		if (_actor != null)
		{
			if (_actor.movementState == ActorState.Move)
			{
				_actor.StandBy();
			}
			_actor.actorInfo.moveSpeedRatioAbsAmend = -(FDP)_moveSpeedRatioAbsAmend;
			_actor.RefreshMoveSpeed();
		}
		_completeCallback?.Invoke(finish);
	}

	public void CancelMove()
	{
		if (_movingCoroutine != null)
		{
			_actor.StopLogicCoroutine(_movingCoroutine);
			_movingCoroutine = null;
		}
		End(finish: false);
	}

	public void Clear()
	{
		_actor = null;
		_completeCallback = null;
	}
}
