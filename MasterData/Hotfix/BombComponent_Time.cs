using TrueSync;
using UnityEngine;

[AddComponentMenu("游戏/冒险模块/武器组件/炸弹_定时组件(目前仅炸弹可用)")]
[RequireComponent(typeof(AdventureBomb))]
[DisallowMultipleComponent]
public class BombComponent_Time : LogicMonoComponent, IBombComponent, ILogicComponentUpdate, ILogicComponent
{
	public FP time = 1;

	[Space]
	public GameObject earlyWarningPrefab;

	public float earlyWarningScale = 1f;

	protected AdventureBomb _context;

	protected FP _duration;

	protected AdventureEarlyWarningFXPlayer _earlyWarningFXPlayer;

	protected long _earlyWarningFXToken;

	public bool KeepAlive { get; set; } = true;

	public void Setup()
	{
		_context = Entity as AdventureBomb;
	}

	public void Reset(LogicEntity owner = null, TSVector2 position = default(TSVector2), FP positionY = default(FP), TSVector2 direction = default(TSVector2), LogicEntity target = null, TSVector2 targetPosition = default(TSVector2), FP targetPositionY = default(FP))
	{
		if (!(_context == null))
		{
			if (_context.TraceTarget && target != null)
			{
				targetPosition = target.tsTransform.Position;
			}
			_duration = 0;
			KeepAlive = true;
			if (earlyWarningPrefab != null && time > FP.Epsilon)
			{
				_earlyWarningFXPlayer = AdventureEarlyWarningFXPlayer.PlayFX(earlyWarningPrefab, (float)time, new Vector3((float)targetPosition.x, (float)targetPositionY, (float)targetPosition.y), transform.rotation, earlyWarningScale);
				_earlyWarningFXPlayer.Bind(gameObject);
				_earlyWarningFXToken = _earlyWarningFXPlayer.token;
				_earlyWarningFXPlayer.syncSlotRotation = false;
				_earlyWarningFXPlayer.syncSlotScale = false;
				_earlyWarningFXPlayer.syncNode = transform;
			}
		}
	}

	public void OnLogicUpdate()
	{
		if (_context == null || !KeepAlive)
		{
			return;
		}
		_duration += _context.LogicDeltaTime;
		if (((time > 0f) ? TSMath.Clamp01(_duration / time) : ((FP)1f)) >= 1f)
		{
			KeepAlive = false;
			if (_earlyWarningFXPlayer != null && _earlyWarningFXPlayer.token == _earlyWarningFXToken)
			{
				_earlyWarningFXPlayer.Complete();
			}
			_earlyWarningFXPlayer = null;
		}
	}

	public void Finish()
	{
	}

	public override void OnDeactive()
	{
		base.OnDeactive();
		_duration = 0;
		_earlyWarningFXPlayer = null;
		_context = null;
	}
}
