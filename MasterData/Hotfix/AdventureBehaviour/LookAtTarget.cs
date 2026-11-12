using System;
using System.Collections;
using TrueSync;
using TrueSync.Physics2D;

namespace AdventureBehaviour;

public class LookAtTarget
{
	public static FP rotTime = AdventureModuleController.Config.RotTime;

	public static FP delayTime = AdventureModuleController.Config.DelayTime;

	protected LogicEntity _target;

	protected Action _onComplete;

	protected Action _onRotateClear;

	protected Action _onClear;

	protected AdventureActor _actor;

	protected FP _rotateSpeed;

	protected FP _duration;

	protected bool _ignoreActorTimeScale;

	protected TSVector2 _targetPos;

	protected TSVector2 _targetDir;

	protected bool toDir;

	protected FP _stopAngle;

	protected bool iCloseTarget;

	protected CoroutineNode _coroutine;

	protected CoroutineNode corRot;

	protected CoroutineNode corDelay;

	private bool isRotate;

	private FP accAngle;

	private FP lastRelativeAngle;

	public void BeginLookAt(AdventureActor actor, LogicEntity target, FP duration, FP rotateSpeed, Action onComplete, bool ignoreActorTimeScale = false, Action onRotateClear = null, FP stopAngle = default(FP))
	{
		if (target == null)
		{
			onRotateClear?.Invoke();
			return;
		}
		if (_coroutine != null)
		{
			_actor.StopLogicCoroutine(_coroutine);
			_coroutine = null;
		}
		toDir = false;
		iCloseTarget = false;
		_stopAngle = ((stopAngle == default(FP)) ? ((FP)0.1f) : stopAngle);
		_actor = actor;
		_target = target;
		_onComplete = onComplete;
		_onRotateClear = onRotateClear;
		_duration = duration;
		_rotateSpeed = rotateSpeed;
		_ignoreActorTimeScale = ignoreActorTimeScale;
		TSVector2 normalized = (target.tsTransform.Position - actor.tsTransform.Position).normalized;
		FP fP = TSVector2.Angle(b: actor.tsTransform.Forward, a: normalized);
		FP y = -normalized.x;
		FP y2 = normalized.y;
		FP fP2 = FP.Atan2(y, y2) * FP.Rad2Deg;
		Rot rot = new Rot(fP2 * FP.Deg2Rad);
		if (rot.s == _actor.tsTransform.dtTransform.q.s && rot.c == _actor.tsTransform.dtTransform.q.c)
		{
			fP = 0;
		}
		FP fP3 = 1;
		if (rotateSpeed == 0)
		{
			ActorInfo actorInfo = actor.actorInfo;
			if (actorInfo != null)
			{
				rotateSpeed = actorInfo.moveRotationSpeed;
			}
		}
		fP3 = ((!(rotateSpeed > 0)) ? ((FP)0f) : (fP / rotateSpeed));
		if (duration > 0)
		{
			DoRotate();
			_coroutine = actor.StartLogicCoroutine(TimeCounter());
			return;
		}
		_actor.isRotateCloseTarget = fP < 0.5f;
		iCloseTarget = fP < _stopAngle;
		if (iCloseTarget || !actor.LookAt(target.tsTransform.Position, fP3, onComplete, onRotateClear))
		{
			OnComplete();
		}
	}

	public void BeginLookAtByPos(AdventureActor actor, TSVector2 targetPos, FP duration, FP rotateSpeed, Action onComplete, Action onClear = null, bool ignoreActorTimeScale = false, FP stopAngle = default(FP))
	{
		if (_coroutine != null)
		{
			_actor.StopLogicCoroutine(_coroutine);
			_coroutine = null;
		}
		toDir = false;
		iCloseTarget = false;
		_stopAngle = stopAngle;
		_actor = actor;
		_target = null;
		_onComplete = onComplete;
		_onClear = onClear;
		_duration = duration;
		_rotateSpeed = rotateSpeed;
		_ignoreActorTimeScale = ignoreActorTimeScale;
		_targetPos = targetPos;
		TSVector2 a = targetPos - actor.tsTransform.Position;
		FP fP = TSVector2.Angle(b: actor.tsTransform.Forward, a: a);
		FP y = -a.x;
		FP y2 = a.y;
		FP fP2 = FP.Atan2(y, y2) * FP.Rad2Deg;
		Rot rot = new Rot(fP2 * FP.Deg2Rad);
		if (rot.s == _actor.tsTransform.dtTransform.q.s && rot.c == _actor.tsTransform.dtTransform.q.c)
		{
			fP = 0;
		}
		FP duration2 = 1f;
		if (rotateSpeed == 0)
		{
			ActorInfo actorInfo = actor.actorInfo;
			if (actorInfo != null)
			{
				rotateSpeed = actorInfo.moveRotationSpeed;
			}
		}
		if (rotateSpeed > 0)
		{
			duration2 = fP / rotateSpeed;
		}
		if (duration > 0)
		{
			DoRotate();
			_coroutine = actor.StartLogicCoroutine(TimeCounter());
			return;
		}
		_actor.isRotateCloseTarget = fP < 0.5f;
		iCloseTarget = fP < _stopAngle;
		if (iCloseTarget || !actor.LookAt(targetPos, duration2, onComplete, onClear))
		{
			OnComplete();
		}
	}

	public void BeginLookAtByDir(AdventureActor actor, TSVector2 targetDir, FP duration, FP rotateSpeed, Action onComplete, Action onClear = null, bool ignoreActorTimeScale = false, FP stopAngle = default(FP))
	{
		if (_coroutine != null)
		{
			_actor.StopLogicCoroutine(_coroutine);
			_coroutine = null;
		}
		toDir = true;
		iCloseTarget = false;
		_stopAngle = stopAngle;
		_actor = actor;
		_target = null;
		_onComplete = onComplete;
		_onClear = onClear;
		_duration = duration;
		_rotateSpeed = rotateSpeed;
		_ignoreActorTimeScale = ignoreActorTimeScale;
		_targetDir = targetDir;
		TSVector2 a = targetDir;
		FP fP = TSVector2.Angle(b: actor.tsTransform.Forward, a: a);
		FP y = -a.x;
		FP y2 = a.y;
		FP fP2 = FP.Atan2(y, y2) * FP.Rad2Deg;
		Rot rot = new Rot(fP2 * FP.Deg2Rad);
		if (rot.s == _actor.tsTransform.dtTransform.q.s && rot.c == _actor.tsTransform.dtTransform.q.c)
		{
			fP = 0;
		}
		FP duration2 = 1f;
		if (rotateSpeed == 0)
		{
			ActorInfo actorInfo = actor.actorInfo;
			if (actorInfo != null)
			{
				rotateSpeed = actorInfo.moveRotationSpeed;
			}
		}
		if (rotateSpeed > 0)
		{
			duration2 = fP / rotateSpeed;
		}
		if (duration > 0)
		{
			DoRotate();
			_coroutine = actor.StartLogicCoroutine(TimeCounter());
			return;
		}
		_actor.isRotateCloseTarget = fP < 0.5f;
		iCloseTarget = fP < _stopAngle;
		if (iCloseTarget || !actor.LookAtDir(targetDir, duration2, onComplete, onClear))
		{
			OnComplete();
		}
	}

	protected IEnumerator TimeCounter()
	{
		FP timer = 0f;
		bool hTarget = _target != null;
		while (true)
		{
			if ((_target == null) & hTarget)
			{
				_onRotateClear?.Invoke();
				break;
			}
			if (_ignoreActorTimeScale)
			{
				timer += LockStepManager.deltaTime;
			}
			else
			{
				timer += _actor.LogicDeltaTime;
			}
			if (timer >= _duration)
			{
				break;
			}
			TSVector2 a = ((!toDir) ? (((_target == null) ? _targetPos : _target.tsTransform.Position) - _actor.tsTransform.Position) : _targetDir);
			TSVector2 forward = _actor.tsTransform.Forward;
			FP fP = TSVector2.Angle(a, forward);
			_actor.isRotateCloseTarget = fP < 0.5f;
			if (iCloseTarget && fP > _stopAngle)
			{
				DoRotate();
			}
			yield return null;
		}
		OnComplete();
	}

	protected void DoRotate()
	{
		TSVector2 tSVector = TSVector2.zero;
		TSVector2 tSVector2;
		if (toDir)
		{
			tSVector2 = _targetDir;
		}
		else
		{
			tSVector = ((_target == null) ? _targetPos : _target.tsTransform.Position);
			tSVector2 = tSVector - _actor.tsTransform.Position;
		}
		TSVector2 forward = _actor.tsTransform.Forward;
		FP fP = TSVector2.Angle(tSVector2, forward);
		iCloseTarget = fP < _stopAngle;
		if (iCloseTarget)
		{
			return;
		}
		FP fP2 = 1f;
		if (_rotateSpeed == 0)
		{
			ActorInfo actorInfo = _actor.actorInfo;
			if (actorInfo != null)
			{
				_rotateSpeed = actorInfo.moveRotationSpeed;
			}
		}
		if (_rotateSpeed > 0)
		{
			fP2 = fP / _rotateSpeed;
		}
		if (fP2 == 0)
		{
			fP2 = 0.01f;
		}
		if (!toDir)
		{
			_actor.LookAt(tSVector, fP2, DoRotate);
		}
		else
		{
			_actor.LookAtDir(tSVector2, fP2, DoRotate);
		}
	}

	public void StopLookAt()
	{
		if (_actor == null)
		{
			return;
		}
		if (_coroutine != null)
		{
			_actor.StopLogicCoroutine(_coroutine);
			_coroutine = null;
		}
		if (corRot != null)
		{
			_actor?.StopLogicCoroutine(corRot);
			corRot = null;
			if (_actor != null)
			{
				_actor.isRotate = false;
			}
		}
		_actor.StopRotate();
		_actor.isRotateCloseTarget = false;
	}

	protected void OnComplete()
	{
		if (_actor != null)
		{
			if (_coroutine != null)
			{
				_actor.StopLogicCoroutine(_coroutine);
				_coroutine = null;
			}
			_actor.StopRotate();
			_actor.isRotateCloseTarget = false;
			_onComplete?.Invoke();
		}
	}

	public void Clear()
	{
		_onClear?.Invoke();
		if (corDelay != null)
		{
			_actor?.StopLogicCoroutine(corDelay);
			corDelay = null;
		}
		if (_coroutine != null)
		{
			_actor?.StopLogicCoroutine(_coroutine);
			_coroutine = null;
		}
		if (corRot != null)
		{
			_actor?.StopLogicCoroutine(corRot);
			corRot = null;
			if (_actor != null)
			{
				_actor.isRotate = false;
			}
		}
		if (_actor != null)
		{
			_actor.StopRotate();
			_actor.isRotateCloseTarget = false;
			_actor = null;
		}
		_onComplete = null;
		_onRotateClear = null;
		_target = null;
	}

	public void BeginLookAtForMonster(AdventureActor actor, LogicEntity target, FP duration, FP rotateSpeed, FP stopAngle = default(FP), bool ignoreActorTimeScale = false, Action onComplete = null, Action onRotateClear = null)
	{
		if (target == null)
		{
			onRotateClear?.Invoke();
			return;
		}
		_actor = actor;
		_target = target;
		_onComplete = onComplete;
		_onRotateClear = onRotateClear;
		_duration = duration;
		_rotateSpeed = rotateSpeed;
		_ignoreActorTimeScale = ignoreActorTimeScale;
		rotateSpeed = ((rotateSpeed == 0) ? actor.actorInfo.moveRotationSpeed : rotateSpeed);
		if (duration > 0)
		{
			if (corRot != null)
			{
				_actor.StopLogicCoroutine(corRot);
				_actor.isRotate = false;
			}
			corRot = actor.StartLogicCoroutine(KeepRotate(target, duration, rotateSpeed, stopAngle, ignoreActorTimeScale, onComplete, onRotateClear));
			return;
		}
		TSVector2 normalized = (target.tsTransform.Position - actor.tsTransform.Position).normalized;
		FP fP = TSVector2.Angle(b: actor.tsTransform.Forward, a: normalized);
		FP y = -normalized.x;
		FP y2 = normalized.y;
		FP fP2 = FP.Atan2(y, y2) * FP.Rad2Deg;
		Rot rot = new Rot(fP2 * FP.Deg2Rad);
		if (rot.s == _actor.tsTransform.dtTransform.q.s && rot.c == _actor.tsTransform.dtTransform.q.c)
		{
			fP = 0;
		}
		_actor.isRotateCloseTarget = fP < 0.5f;
		if (rotateSpeed > 0)
		{
			duration = fP / rotateSpeed;
		}
		if (corRot != null)
		{
			_actor.StopLogicCoroutine(corRot);
			_actor.isRotate = false;
		}
		corRot = actor.StartLogicCoroutine(KeepRotate(target, duration, rotateSpeed, stopAngle, ignoreActorTimeScale, onComplete, onRotateClear));
	}

	private IEnumerator KeepRotate(LogicEntity target, FP duration, FP rotateSpeed, FP stopAngle, bool ignoreActorTimeScale, Action onComplete, Action onRotateClear)
	{
		isRotate = false;
		accAngle = 0;
		FP relativeAngle = 0;
		lastRelativeAngle = 0;
		FP timer = 0;
		int clockwise = 0;
		FP startTime = 0;
		bool lastStop = false;
		while (timer < duration && !_actor.isDead && _actor.isControllable)
		{
			FP deltaAgnle = (ignoreActorTimeScale ? LockStepManager.deltaTime : _actor.LogicDeltaTime) * rotateSpeed;
			if (!isRotate)
			{
				if (target == null)
				{
					onRotateClear?.Invoke();
					_actor.isRotate = false;
					break;
				}
				accAngle = 0;
				relativeAngle = CalRot(target, _actor);
				clockwise = ((!(relativeAngle < 0)) ? 1 : (-1));
				if (CheckCanRot(relativeAngle, deltaAgnle, clockwise, stopAngle))
				{
					if (corDelay != null)
					{
						_actor.StopLogicCoroutine(corDelay);
						corDelay = null;
					}
					startTime = _actor.LogicTime;
					isRotate = true;
					lastStop = false;
					_actor.isRotate = true;
					_actor.isRotateCloseTarget = false;
					RotDelta(relativeAngle, deltaAgnle, clockwise);
				}
				else if (!lastStop)
				{
					if (_actor.LogicTime - startTime > _actor.LogicDeltaTime && _actor.LogicTime - startTime < rotTime)
					{
						corDelay = _actor.StartLogicCoroutine(DelayStop(delayTime));
					}
					else
					{
						_actor.isRotate = false;
						_actor.isRotateCloseTarget = true;
					}
					lastStop = true;
				}
			}
			else
			{
				RotDelta(relativeAngle, deltaAgnle, clockwise);
			}
			timer += _actor.LogicDeltaTime;
			yield return null;
		}
		onComplete?.Invoke();
		_actor.isRotate = false;
	}

	private IEnumerator DelayStop(FP delayTime)
	{
		yield return delayTime;
		if (!isRotate)
		{
			_actor.isRotate = false;
			_actor.isRotateCloseTarget = true;
		}
	}

	private bool CheckCanRot(FP relativeAngle, FP deltaAgnle, int clockwise, FP stopAngle)
	{
		bool flag = TSMath.Abs(relativeAngle) > stopAngle;
		bool flag2 = true;
		bool flag3 = true;
		if (flag)
		{
			if (accAngle + deltaAgnle > TSMath.Abs(relativeAngle))
			{
				flag2 = _actor.CheckCanRot(relativeAngle - accAngle * clockwise);
			}
			flag3 = relativeAngle != lastRelativeAngle;
			lastRelativeAngle = relativeAngle;
		}
		return flag & flag2 & flag3;
	}

	private void RotDelta(FP relativeAngle, FP deltaAgnle, int clockwise)
	{
		if (accAngle + deltaAgnle > TSMath.Abs(relativeAngle))
		{
			_actor.RotDelta(relativeAngle - accAngle * clockwise);
			isRotate = false;
		}
		else
		{
			_actor.RotDelta(deltaAgnle * clockwise);
			accAngle += deltaAgnle;
		}
	}

	public FP CalRot(LogicEntity target, AdventureActor actor)
	{
		FP fP = ((target.tsTransform.Position - actor.tsTransform.Position).normalized.GetAngle() + 360f) % 360f;
		FP rotation = actor.tsTransform.Rotation360;
		FP fP2 = fP - rotation;
		FP fP3 = ((fP2 > 0f) ? fP2 : (-fP2));
		if (fP3 > 180f)
		{
			fP2 = ((fP2 > 0f) ? (-(360f - fP3)) : (360f - fP3));
		}
		return fP2;
	}

	public FP CalRot(TSVector2 targetPos, AdventureActor actor)
	{
		FP fP = ((targetPos - actor.tsTransform.Position).normalized.GetAngle() + 360f) % 360f;
		FP rotation = actor.tsTransform.Rotation360;
		FP fP2 = fP - rotation;
		FP fP3 = ((fP2 > 0f) ? fP2 : (-fP2));
		if (fP3 > 180f)
		{
			fP2 = ((fP2 > 0f) ? (-(360f - fP3)) : (360f - fP3));
		}
		return fP2;
	}
}
