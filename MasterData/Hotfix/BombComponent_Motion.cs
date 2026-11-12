using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器组件/炸弹_移动组件(目前仅炸弹可用)")]
[RequireComponent(typeof(AdventureBomb))]
[DisallowMultipleComponent]
public class BombComponent_Motion : LogicMonoComponent, IBombComponent, ILogicComponentUpdate, ILogicComponent
{
	public FP time = 1;

	public TSVector2 startRelativePosition = TSVector2.zero;

	public FP startRelativePositionY = 0f;

	public TSFloatEase.EaseType motionEaseType;

	public bool traceTarget;

	public GameObject trailFx;

	public bool finishEndMove;

	protected AdventureBomb _context;

	protected AdventureFXPlayer _fxPlayer;

	protected FP _duration;

	protected TSVector2 _startPosition;

	protected FP _startPositionY;

	protected FP _targetPositionY;

	public bool KeepAlive { get; set; } = true;

	public void Setup()
	{
		_context = Entity as AdventureBomb;
		if (!(_context == null))
		{
			_context.TraceTarget = traceTarget;
			if (trailFx != null)
			{
				_fxPlayer = AdventureFXPlayer.PlayFX(trailFx, (float)_context.logicTimeScale, _context.transform.position, _context.transform.rotation);
				_fxPlayer.Bind(_context.gameObject);
				_fxPlayer.syncNode = _context.transform;
			}
		}
	}

	public void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		if (!(_context == null))
		{
			_duration = 0;
			KeepAlive = true;
			if (_context.TraceTarget && target != null)
			{
				targetPosition = target.tsTransform.Position;
			}
			_targetPositionY = targetPositionY;
			_context.tsTransform.Position = (_startPosition = targetPosition + startRelativePosition);
			_context.tsTransform.PositionY = (_startPositionY = _targetPositionY + startRelativePositionY);
		}
	}

	public void OnLogicUpdate()
	{
		if (_context == null || !KeepAlive)
		{
			return;
		}
		_duration += _context.LogicDeltaTime;
		FP fP = ((time > 0f) ? TSMath.Clamp01(_duration / time) : ((FP)1f));
		if (fP < 1f)
		{
			Motion(fP);
			return;
		}
		_context.tsTransform.Position = _context.targetPosition;
		_context.tsTransform.PositionY = _targetPositionY;
		if (_fxPlayer.isPlaying)
		{
			_fxPlayer.Stop();
		}
		if (finishEndMove)
		{
			KeepAlive = false;
		}
	}

	protected void Motion(FP normalizedTime)
	{
		if (traceTarget && _context.target != null)
		{
			_context.targetPosition = _context.target.tsTransform.Position;
		}
		FP x = TSFloatEase.Easing(TSFloatEase.EaseType.Linear, _startPosition.x, _context.targetPosition.x, normalizedTime);
		FP y = TSFloatEase.Easing(TSFloatEase.EaseType.Linear, _startPosition.y, _context.targetPosition.y, normalizedTime);
		_context.tsTransform.Position = new TSVector2(x, y);
		FP positionY = TSFloatEase.Easing(motionEaseType, _startPositionY, _targetPositionY, normalizedTime);
		_context.tsTransform.PositionY = positionY;
	}

	public void Finish()
	{
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_duration = 0;
		_fxPlayer = null;
		_context = null;
	}
}
