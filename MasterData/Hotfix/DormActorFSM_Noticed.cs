#define LOG_DEBUG
using UnityEngine;

public class DormActorFSM_Noticed : DormActorFSM
{
	private enum Phase
	{
		Stopped,
		IdleShowing,
		Cooldown
	}

	private Phase _phase;

	private float _timer;

	private float _turnTargetYaw;

	private bool _turning;

	public bool IsBusy
	{
		get
		{
			if (_phase != Phase.Stopped)
			{
				return _phase == Phase.IdleShowing;
			}
			return true;
		}
	}

	public DormActorFSM_Noticed(DormActor actor, int state)
		: base(actor, state)
	{
	}

	public override void OnEnter(object data = null)
	{
		base.OnEnter(data);
		actor.StopMove();
		_phase = Phase.Stopped;
		_timer = 0f;
		BeginTurnToPlayer();
		actor.StartRandomBlink();
	}

	public override void OnExit()
	{
		actor.StopRandomBlink();
		_turning = false;
		if (actor.isPlayingTimelineAnimation)
		{
			actor.StopTimelineAnimation();
		}
		actor.ClearInteractIconHoldState();
		base.OnExit();
	}

	public void RestartToStopped()
	{
		if (actor.isPlayingTimelineAnimation)
		{
			actor.StopTimelineAnimation();
		}
		actor.StopMove();
		_phase = Phase.Stopped;
		_timer = 0f;
		BeginTurnToPlayer();
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (actor.ShouldReleaseHoldNow)
		{
			NovaLogger.Debug("[Dorm] 注目-交互表现结束, 交还漫游: " + actor.name);
			actor.ReleaseToRome();
			return;
		}
		if (actor.IsHoldingInPlace)
		{
			UpdateHeldPhase();
			return;
		}
		switch (_phase)
		{
		case Phase.Stopped:
			TickTurnToPlayer();
			_timer += Time.deltaTime;
			if (_timer >= 5f)
			{
				NovaLogger.Debug($"[Dorm] 注目-等待超时播放IdleShow: {actor.name}(等待={5f}s)");
				actor.PlayIdleShowAnim();
				_phase = Phase.IdleShowing;
			}
			break;
		case Phase.IdleShowing:
			if (!actor.isPlayingTimelineAnimation)
			{
				if (actor.TryGetRandomWalkablePointInScene(out var result))
				{
					actor.MoveTo(result);
				}
				NovaLogger.Debug($"[Dorm] 注目-IdleShow播完仍未交互, 随机移动并进入冷却: {actor.name}(冷却={5f}s)");
				_phase = Phase.Cooldown;
				_timer = 0f;
			}
			break;
		case Phase.Cooldown:
			_timer += Time.deltaTime;
			if (_timer >= 5f)
			{
				NovaLogger.Debug("[Dorm] 注目-冷却结束, 交还漫游: " + actor.name);
				actor.SelectBehaviour();
			}
			break;
		}
	}

	private void UpdateHeldPhase()
	{
		switch (_phase)
		{
		case Phase.Stopped:
			TickTurnToPlayer();
			_timer += Time.deltaTime;
			if (_timer >= 5f)
			{
				actor.PlayIdleShowAnim();
				_phase = Phase.IdleShowing;
			}
			break;
		case Phase.IdleShowing:
			if (!actor.isPlayingTimelineAnimation)
			{
				_phase = Phase.Stopped;
				_timer = 0f;
			}
			break;
		case Phase.Cooldown:
			actor.StopMove();
			_phase = Phase.Stopped;
			_timer = 0f;
			break;
		}
	}

	private bool TryComputeTurnTargetYaw(out float yaw)
	{
		yaw = 0f;
		if (actor.IsNoticeFaceCamera)
		{
			Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
			if (mainCamera == null)
			{
				return false;
			}
			Vector3 forward = mainCamera.transform.forward;
			forward.y = 0f;
			if (forward.sqrMagnitude < 1E-06f)
			{
				return false;
			}
			yaw = Quaternion.LookRotation(forward).eulerAngles.y + 180f;
			return true;
		}
		DormPlayer player = MonoSingleton<DormPlayerController>.Instance.Player;
		if (player == null)
		{
			return false;
		}
		Vector3 forward2 = player.transform.position - actor.transform.position;
		forward2.y = 0f;
		if (forward2.sqrMagnitude < 0.0001f)
		{
			return false;
		}
		yaw = Quaternion.LookRotation(forward2).eulerAngles.y;
		return true;
	}

	private void BeginTurnToPlayer()
	{
		_turning = false;
		if (TryComputeTurnTargetYaw(out _turnTargetYaw))
		{
			if (360f <= 0f || Mathf.Abs(Mathf.DeltaAngle(actor.GetFacingYaw(), _turnTargetYaw)) < 0.1f)
			{
				actor.SyncRotation(_turnTargetYaw);
				return;
			}
			_turning = true;
			actor.PlayWalk();
		}
	}

	private void TickTurnToPlayer()
	{
		if (!_turning)
		{
			return;
		}
		float num = 360f;
		if (num <= 0f)
		{
			actor.SyncRotation(_turnTargetYaw);
			_turning = false;
			actor.PlayIdle();
			return;
		}
		float num2 = Mathf.MoveTowardsAngle(actor.GetFacingYaw(), _turnTargetYaw, num * Time.deltaTime);
		actor.SyncRotation(num2);
		if (Mathf.Abs(Mathf.DeltaAngle(num2, _turnTargetYaw)) < 0.1f)
		{
			_turning = false;
			actor.PlayIdle();
		}
	}
}
