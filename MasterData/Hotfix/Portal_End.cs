using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class Portal_End : LogicEntity, IDeterministicCollisionListener
{
	private Gear_Portal _owner;

	private readonly Dictionary<Brick_BallBase, TSVector2> _lastPos = new Dictionary<Brick_BallBase, TSVector2>(BrickBallRefComparer.Instance);

	public Portal_TractionRange tractionRange;

	public int tractionCheckInterval = 1;

	public FP tractionSpeed = 1;

	public FP tractionAngleRate = 0.2;

	public GameObject tractionFx;

	private int _tractionFrame;

	private AdventureFXPlayer _tractionFxPlayer;

	private bool _tractionPlaying;

	private static readonly FP TELEPORT_IMMUNE = 2;

	private readonly Dictionary<Brick_BallBase, FP> _immune = new Dictionary<Brick_BallBase, FP>(BrickBallRefComparer.Instance);

	private static readonly List<Brick_BallBase> _pruneTmp = new List<Brick_BallBase>();

	private static readonly List<Brick_BallBase> _immuneTmp = new List<Brick_BallBase>();

	public DeterministicCollider Collider { get; private set; }

	public bool InTractionCD { get; private set; }

	public FP TractionSpeed => tractionSpeed;

	public FP TractionAngleRate => tractionAngleRate;

	public void InitData(Gear_Portal owner)
	{
		_owner = owner;
	}

	protected override void OnInit()
	{
		Collider = AddOrGetMonoLogicComponent<DeterministicCollider>();
		tractionRange?.InitData(this);
	}

	protected override void OnActive()
	{
		_lastPos.Clear();
		_immune.Clear();
		_tractionFrame = 0;
		InTractionCD = false;
		_tractionPlaying = false;
		EnableLogicUpdate();
	}

	protected override void OnDeactive()
	{
		_lastPos.Clear();
		_immune.Clear();
		StopTractionFx();
		List<Brick_BallBase> allBalls = Singleton<BrickBreakerManager>.Instance.GetAllBalls();
		if (allBalls != null)
		{
			for (int i = 0; i < allBalls.Count; i++)
			{
				Singleton<BrickBreakerManager>.Instance.RemovePortalTractionForBall(allBalls.get_Item(i), this);
			}
		}
	}

	protected override void OnShutdown()
	{
	}

	public bool ContainsPoint(TSVector2 point)
	{
		return Collider.CheckPointInterior(ref point);
	}

	public bool IsBallImmune(Brick_BallBase ball)
	{
		if (ball != null && _immune.TryGetValue(ball, out var value))
		{
			return value > 0;
		}
		return false;
	}

	public void StartImmune(Brick_BallBase ball)
	{
		if (!(ball == null))
		{
			_immune.set_Item(ball, TELEPORT_IMMUNE);
		}
	}

	protected override void OnLogicUpdate()
	{
		if (_owner == null)
		{
			return;
		}
		List<Brick_BallBase> allBalls = Singleton<BrickBreakerManager>.Instance.GetAllBalls();
		if (allBalls == null)
		{
			_lastPos.Clear();
			_immune.Clear();
			return;
		}
		Collider.ColliderSync();
		if (_lastPos.Count > 0 || _immune.Count > 0)
		{
			PruneStale(allBalls);
		}
		_owner.PruneSuppressed(allBalls);
		bool hasPortalTraction = Singleton<BrickBreakerManager>.Instance.HasPortalTraction;
		UpdateTractionFx(hasPortalTraction);
		DecayImmune();
		if (hasPortalTraction && tractionRange != null && tractionRange.dtCollider != null)
		{
			tractionRange.dtCollider.ColliderSync();
		}
		for (int num = allBalls.Count - 1; num >= 0; num--)
		{
			Brick_BallBase brick_BallBase = allBalls.get_Item(num);
			if (!(brick_BallBase == null))
			{
				TSVector2 position = brick_BallBase.tsTransform.Position;
				if (_lastPos.TryGetValue(brick_BallBase, out var value))
				{
					TSVector2 tSVector = position - value;
					FP magnitude = tSVector.magnitude;
					if (magnitude > 0)
					{
						TSVector2 direction = tSVector / magnitude;
						if (Collider.Raycast(ref value, ref direction, out var hitInfo, magnitude, preTest: true))
						{
							_owner.OnEndHit(this, brick_BallBase, hitInfo.point, direction);
							position = brick_BallBase.tsTransform.Position;
						}
					}
				}
				_lastPos.set_Item(brick_BallBase, position);
				_owner.OnEndStep(this, brick_BallBase, position);
				if (hasPortalTraction && tractionRange != null && tractionRange.dtCollider != null)
				{
					brick_BallBase.DtCollider.ColliderSync();
					SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, tractionRange.dtCollider, brick_BallBase.DtCollider, duplex: false);
				}
			}
		}
		if (hasPortalTraction)
		{
			CheckTractionDuration();
			return;
		}
		for (int i = 0; i < allBalls.Count; i++)
		{
			Singleton<BrickBreakerManager>.Instance.RemovePortalTractionForBall(allBalls.get_Item(i), this);
		}
	}

	private void CheckTractionDuration()
	{
		_tractionFrame++;
		if (tractionCheckInterval > 1)
		{
			if (_tractionFrame >= tractionCheckInterval)
			{
				_tractionFrame = 0;
				InTractionCD = false;
			}
			else
			{
				InTractionCD = true;
			}
		}
		else
		{
			InTractionCD = false;
		}
	}

	private void DecayImmune()
	{
		if (_immune.Count == 0)
		{
			return;
		}
		_immuneTmp.Clear();
		foreach (KeyValuePair<Brick_BallBase, FP> item in _immune)
		{
			_immuneTmp.Add(item.Key);
		}
		for (int i = 0; i < _immuneTmp.Count; i++)
		{
			Brick_BallBase key = _immuneTmp.get_Item(i);
			FP fP = _immune.get_Item(key) - LogicDeltaTime;
			if (fP <= 0)
			{
				_immune.Remove(key);
			}
			else
			{
				_immune.set_Item(key, fP);
			}
		}
	}

	private void UpdateTractionFx(bool active)
	{
		if (active && !_tractionPlaying)
		{
			if (tractionFx != null)
			{
				_tractionFxPlayer = AdventureFXPlayer.PlayFX(tractionFx, 1f, transform.position, transform.rotation);
			}
			_tractionPlaying = true;
		}
		else if (!active && _tractionPlaying)
		{
			StopTractionFx();
		}
	}

	private void StopTractionFx()
	{
		_tractionFxPlayer?.Stop();
		_tractionFxPlayer = null;
		_tractionPlaying = false;
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		Brick_BallBase component = other.GetComponent<Brick_BallBase>();
		if (component != null)
		{
			Singleton<BrickBreakerManager>.Instance.AddPortalTractionForBall(component, this);
		}
	}

	public void OnDeterministicCollisionStay(DeterministicCollider other)
	{
	}

	public void OnDeterministicCollisionExit(DeterministicCollider other)
	{
		Brick_BallBase component = other.GetComponent<Brick_BallBase>();
		if (component != null)
		{
			Singleton<BrickBreakerManager>.Instance.RemovePortalTractionForBall(component, this);
		}
	}

	private void PruneStale(List<Brick_BallBase> balls)
	{
		_pruneTmp.Clear();
		foreach (KeyValuePair<Brick_BallBase, TSVector2> lastPo in _lastPos)
		{
			if (lastPo.Key == null || !balls.Contains(lastPo.Key))
			{
				_pruneTmp.Add(lastPo.Key);
			}
		}
		for (int i = 0; i < _pruneTmp.Count; i++)
		{
			_lastPos.Remove(_pruneTmp.get_Item(i));
		}
		_pruneTmp.Clear();
		foreach (KeyValuePair<Brick_BallBase, FP> item in _immune)
		{
			if (item.Key == null || !balls.Contains(item.Key))
			{
				_pruneTmp.Add(item.Key);
			}
		}
		for (int j = 0; j < _pruneTmp.Count; j++)
		{
			_immune.Remove(_pruneTmp.get_Item(j));
		}
	}
}
