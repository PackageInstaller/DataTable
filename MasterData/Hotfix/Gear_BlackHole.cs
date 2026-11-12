using System.Collections.Generic;
using TrueSync;
using UnityEngine;

public class Gear_BlackHole : GearBase, IDeterministicCollisionListener
{
	public bool initialModeIsAttract = true;

	public int checkDuration;

	public FP angle_change_rat = 0.2;

	public FP gravitySpeed = 1;

	public FP switchInterval = 0;

	public GameObject initialFx;

	public GameObject forceFx;

	public GameObject switchFx;

	public FP time_Switch = 0.1f;

	private int currentFrameCount;

	private FP _switchTimer;

	private FP _switchEffectTimer;

	private AdventureFXPlayer currentFx;

	public bool inTriggerCD { get; private set; }

	public bool isAttractMode { get; private set; }

	public bool IsWaitingSwitchEffect { get; private set; }

	protected override void OnInit()
	{
		base.OnInit();
		IsWaitingSwitchEffect = false;
		_switchEffectTimer = 0;
	}

	protected override void OnActive()
	{
		EnableLogicUpdate();
		dtCollider.collisionListener = this;
		inTriggerCD = false;
		isAttractMode = initialModeIsAttract;
		_switchTimer = 0;
		_switchEffectTimer = 0;
		currentFrameCount = 0;
		IsWaitingSwitchEffect = false;
		if (switchInterval <= 0)
		{
			AdventureFXPlayer componentInChildren = GetComponentInChildren<AdventureFXPlayer>(includeInactive: true);
			if (componentInChildren != null)
			{
				componentInChildren.gameObject.SetActive(value: true);
			}
		}
		else
		{
			currentFx = AdventureFXPlayer.PlayFX(initialModeIsAttract ? initialFx : forceFx, 1f, transform.position, Quaternion.identity);
		}
	}

	protected override void OnDeactive()
	{
		base.OnDeactive();
		List<Brick_BallBase> allBalls = Singleton<BrickBreakerManager>.Instance.GetAllBalls();
		if (allBalls != null)
		{
			foreach (Brick_BallBase item in allBalls)
			{
				Singleton<BrickBreakerManager>.Instance.RemoveBlackHoleForBall(item, this);
			}
		}
		if (currentFx != null)
		{
			currentFx.Stop();
			currentFx = null;
		}
		IsWaitingSwitchEffect = false;
	}

	protected override void OnShutdown()
	{
	}

	public int GetDration()
	{
		if (checkDuration > 0)
		{
			return checkDuration;
		}
		return 1;
	}

	private void CheckDuration()
	{
		currentFrameCount++;
		if (checkDuration > 1)
		{
			if (currentFrameCount >= checkDuration)
			{
				currentFrameCount = 0;
				inTriggerCD = false;
			}
			else
			{
				inTriggerCD = true;
			}
		}
		else
		{
			inTriggerCD = false;
		}
	}

	protected override void OnLogicUpdate()
	{
		if (IsWaitingSwitchEffect)
		{
			_switchEffectTimer += LogicDeltaTime;
			if (_switchEffectTimer >= time_Switch)
			{
				isAttractMode = !isAttractMode;
				currentFx?.Stop();
				currentFx = AdventureFXPlayer.PlayFX(isAttractMode ? initialFx : forceFx, 1f, transform.position, Quaternion.identity);
				IsWaitingSwitchEffect = false;
				_switchEffectTimer = 0;
			}
		}
		else if (switchInterval > 0)
		{
			_switchTimer += LogicDeltaTime;
			if (_switchTimer >= switchInterval)
			{
				_switchTimer = 0;
				if (switchFx != null && time_Switch > 0)
				{
					currentFx?.Stop();
					currentFx = AdventureFXPlayer.PlayFX(switchFx, 1f, transform.position, Quaternion.identity);
					IsWaitingSwitchEffect = true;
					_switchEffectTimer = 0;
				}
				else
				{
					isAttractMode = !isAttractMode;
					currentFx?.Stop();
					currentFx = AdventureFXPlayer.PlayFX(isAttractMode ? initialFx : forceFx, 1f, transform.position, Quaternion.identity);
				}
			}
		}
		List<Brick_BallBase> allBalls = Singleton<BrickBreakerManager>.Instance.GetAllBalls();
		if (allBalls != null)
		{
			dtCollider.ColliderSync();
			foreach (Brick_BallBase item in allBalls)
			{
				item.DtCollider.ColliderSync();
				SceneSingleton<DeterministicCollisionManager>.Instance.ContactEvaluate(LockStepManager.frameCount, dtCollider, item.DtCollider, duplex: false);
			}
		}
		CheckDuration();
	}

	public void OnDeterministicCollisionEnter(DeterministicCollider other)
	{
		Brick_BallBase component = other.GetComponent<Brick_BallBase>();
		if (component != null)
		{
			Singleton<BrickBreakerManager>.Instance.AddBlackHoleForBall(component, this);
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
			Singleton<BrickBreakerManager>.Instance.RemoveBlackHoleForBall(component, this);
		}
	}
}
