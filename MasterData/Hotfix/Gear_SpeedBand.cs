using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class Gear_SpeedBand : GearBase, IDeterministicCollisionListener
{
	public FP deltaSpeedAccel = 1f;

	public FP deltaSpeedDecel = -1f;

	public FP switchInterval = 0;

	public bool initialAccelerating = true;

	public GameObject fx_Accelerate;

	public GameObject fx_Decelerate;

	public GameObject fx_Switch;

	public FP time_Switch = 0.1f;

	public GameObject fx_AccelerateTrigger;

	public GameObject fx_DecelerateTrigger;

	private FP _switchTimer;

	private FP _switchEffectTimer;

	private AdventureFXPlayer currentFx;

	private AdventureFXPlayer currentFxTrigger;

	private Dictionary<Brick_BallBase, bool> enterStates = new Dictionary<Brick_BallBase, bool>(BrickBallRefComparer.Instance);

	public bool isAccelerating { get; private set; }

	public bool IsWaitingSwitchEffect { get; private set; }

	protected override void OnInit()
	{
		base.OnInit();
		isAccelerating = initialAccelerating;
		IsWaitingSwitchEffect = false;
		_switchEffectTimer = 0;
	}

	protected override void OnActive()
	{
		EnableLogicUpdate();
		dtCollider.collisionListener = this;
		_switchTimer = 0;
		_switchEffectTimer = 0;
		enterStates.Clear();
		IsWaitingSwitchEffect = false;
		isAccelerating = initialAccelerating;
		GameObject fxPrefab = (isAccelerating ? fx_Accelerate : fx_Decelerate);
		currentFx = AdventureFXPlayer.PlayFX(fxPrefab, 1f, transform.position, Quaternion.identity);
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		List<Brick_BallBase> allBalls = Singleton<BrickBreakerManager>.Instance.GetAllBalls();
		if (allBalls != null)
		{
			foreach (Brick_BallBase item in allBalls)
			{
				Singleton<BrickBreakerManager>.Instance.RemoveAllSpeedBandForBall(item);
			}
		}
		currentFx?.Stop();
		currentFx = null;
		currentFxTrigger?.Stop();
		currentFxTrigger = null;
		IsWaitingSwitchEffect = false;
	}

	protected override void OnShutdown()
	{
	}

	protected override void OnLogicUpdate()
	{
		bool flag = false;
		if (IsWaitingSwitchEffect)
		{
			_switchEffectTimer += LogicDeltaTime;
			if (_switchEffectTimer >= time_Switch)
			{
				isAccelerating = !isAccelerating;
				currentFx?.Stop();
				GameObject fxPrefab = (isAccelerating ? fx_Accelerate : fx_Decelerate);
				currentFx = AdventureFXPlayer.PlayFX(fxPrefab, 1f, transform.position, Quaternion.identity);
				IsWaitingSwitchEffect = false;
				_switchEffectTimer = 0;
				flag = true;
			}
		}
		else if (switchInterval > 0)
		{
			_switchTimer += LogicDeltaTime;
			if (_switchTimer >= switchInterval)
			{
				_switchTimer = 0;
				if (fx_Switch != null && time_Switch > 0)
				{
					currentFx?.Stop();
					currentFx = AdventureFXPlayer.PlayFX(fx_Switch, 1f, transform.position, Quaternion.identity);
					IsWaitingSwitchEffect = true;
					_switchEffectTimer = 0;
				}
				else
				{
					isAccelerating = !isAccelerating;
					currentFx?.Stop();
					GameObject fxPrefab2 = (isAccelerating ? fx_Accelerate : fx_Decelerate);
					currentFx = AdventureFXPlayer.PlayFX(fxPrefab2, 1f, transform.position, Quaternion.identity);
					flag = true;
				}
			}
		}
		List<Brick_BallBase> allBalls = Singleton<BrickBreakerManager>.Instance.GetAllBalls();
		if (allBalls == null)
		{
			return;
		}
		bool value = default;
		foreach (Brick_BallBase item in allBalls)
		{
			if (!(item == null))
			{
				if ((flag && enterStates.TryGetValue(item, out value)) & value)
				{
					Singleton<BrickBreakerManager>.Instance.AddSpeedBandForBall(item, isAccelerating ? deltaSpeedAccel : deltaSpeedDecel);
					currentFxTrigger?.Stop();
					GameObject fxPrefab3 = (isAccelerating ? fx_AccelerateTrigger : fx_DecelerateTrigger);
					currentFxTrigger = AdventureFXPlayer.PlayFX(fxPrefab3, 1f, transform.position, Quaternion.identity);
				}
				item.DtCollider.ColliderSync();
				SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, dtCollider, item.DtCollider, duplex: false);
			}
		}
	}

	private void SetEnterState(Brick_BallBase ball, bool istate)
	{
		if (enterStates.ContainsKey(ball))
		{
			enterStates.set_Item(ball, istate);
		}
		else
		{
			enterStates.Add(ball, istate);
		}
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		Brick_BallBase component = other.GetComponent<Brick_BallBase>();
		if (component != null)
		{
			SetEnterState(component, istate: true);
			Singleton<BrickBreakerManager>.Instance.AddSpeedBandForBall(component, isAccelerating ? deltaSpeedAccel : deltaSpeedDecel);
			currentFxTrigger?.Stop();
			GameObject fxPrefab = (isAccelerating ? fx_AccelerateTrigger : fx_DecelerateTrigger);
			currentFxTrigger = AdventureFXPlayer.PlayFX(fxPrefab, 1f, transform.position, Quaternion.identity);
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
			SetEnterState(component, istate: false);
		}
	}
}
