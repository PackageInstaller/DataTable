using System.Collections;
using TrueSync;
using UnityEngine;

[AddComponentMenu("Game/Adventure/AreaEffect/AreaEffectComponents/区域效果组件_移动(废弃，不可使用！)")]
[RequireComponent(typeof(AreaEffectEntity))]
[DisallowMultipleComponent]
public class AreaEffect_MoveComponent : AreaEffect_Component
{
	public FP speed = 1f;

	public FP moveInterval = 0f;

	[Space]
	public bool triggerActorStop;

	public TargetFilterCriteriaInfo triggerCriteriaInfo;

	public FP delayTime_TriggerActorStop = 0;

	[Space]
	public bool isArc;

	public AnimationCurve moveCurveX;

	public AnimationCurve moveCurveZ;

	private TSVector2 _velocityDirection;

	private FP _velocitySpeed;

	private FP _moveInterval;

	private bool _triggerActorStop;

	private CoroutineNode _delayStopCor;

	private bool _stop;

	private FP _animADSRTimer;

	private TSVector2 lastOffest;

	private TSVector2 _velocityLeft;

	private FP _speed;

	protected override bool ShowCheckTag => false;

	private TSVector2 Velocity => _velocityDirection * _velocitySpeed;

	public FP Speed
	{
		get
		{
			return _speed;
		}
		set
		{
			_speed = value;
			_velocitySpeed = value;
		}
	}

	protected override void OnSetup()
	{
		base.OnSetup();
		_velocityDirection = _context.tsTransform.Forward;
		_speed = speed;
		_velocitySpeed = speed;
		_velocityLeft = _context.tsTransform.Left.normalized;
		_moveInterval = 0;
		_animADSRTimer = 0;
		lastOffest = TSVector2.zero;
		_triggerActorStop = false;
		_stop = false;
		_context.EnableSmooth();
	}

	protected override void OnLogicUpdate(FP logicDeltaTime)
	{
		if (_stop || _velocitySpeed == 0)
		{
			return;
		}
		if (!isArc)
		{
			if (moveInterval > 0)
			{
				_moveInterval += logicDeltaTime;
				if (_moveInterval >= moveInterval)
				{
					_context.tsTransform.Position += Velocity * _moveInterval;
					_moveInterval = 0;
				}
			}
			else
			{
				_context.tsTransform.Position += Velocity * logicDeltaTime;
			}
			return;
		}
		_animADSRTimer += logicDeltaTime;
		FP fP = TSMath.Clamp01(_animADSRTimer / _context.duration);
		TSVector2 tSVector = new TSVector2(_velocityLeft.x * moveCurveX.Evaluate(fP.AsFloat()), _velocityLeft.y * moveCurveZ.Evaluate(fP.AsFloat()));
		if (moveInterval > 0)
		{
			_moveInterval += logicDeltaTime;
			if (_moveInterval >= moveInterval)
			{
				_context.tsTransform.Position += Velocity * _moveInterval + tSVector - lastOffest;
				_moveInterval = 0;
			}
		}
		else
		{
			_context.tsTransform.Position += Velocity * logicDeltaTime + tSVector - lastOffest;
		}
		lastOffest = tSVector;
	}

	private IEnumerator DelayStop(FP delayTime)
	{
		yield return delayTime;
		_stop = true;
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		if (_delayStopCor != null)
		{
			_context.StopLogicCoroutine(_delayStopCor);
		}
		_delayStopCor = null;
		_context?.DisableSmooth();
	}

	protected override void OnDeterministicCollisionEnter(LogicEntity entity)
	{
		base.OnDeterministicCollisionEnter(entity);
		if (triggerActorStop && !_triggerActorStop && entity is AdventureActor target && _context.CheckTarget(target, triggerCriteriaInfo))
		{
			if (delayTime_TriggerActorStop > 0)
			{
				_delayStopCor = _context.StartLogicCoroutine(DelayStop(delayTime_TriggerActorStop));
			}
			else
			{
				_stop = true;
			}
			_triggerActorStop = true;
		}
	}
}
