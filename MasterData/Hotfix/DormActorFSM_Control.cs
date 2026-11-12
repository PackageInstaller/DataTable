using UnityEngine;

public class DormActorFSM_Control : DormActorFSM
{
	private float _idleTimer;

	private bool _isPlayingIdleShow;

	private bool hasStopMoved;

	private float _turnTargetYaw;

	private bool _turning;

	public DormActorFSM_Control(DormActor actor, int state)
		: base(actor, state)
	{
	}

	public override void OnEnter(object data = null)
	{
		base.OnEnter(data);
		_turning = false;
		actor.StartRandomBlink();
	}

	public override void OnExit()
	{
		actor.StopRandomBlink();
		_turning = false;
		ResetIdleShow();
		base.OnExit();
	}

	public void RequestTurnTo(Vector3 targetPos)
	{
		_turning = false;
		ResetIdleShow();
		Vector3 forward = targetPos - actor.transform.position;
		forward.y = 0f;
		if (!(forward.sqrMagnitude < 0.0001f))
		{
			_turnTargetYaw = Quaternion.LookRotation(forward).eulerAngles.y;
			if (360f <= 0f || Mathf.Abs(Mathf.DeltaAngle(actor.GetFacingYaw(), _turnTargetYaw)) < 0.1f)
			{
				actor.SyncRotation(_turnTargetYaw);
				return;
			}
			_turning = true;
			actor.PlayWalk();
		}
	}

	private void TickTurn()
	{
		float num = 360f;
		if (num <= 0f)
		{
			actor.SyncRotation(_turnTargetYaw);
			EndTurn();
			return;
		}
		float num2 = Mathf.MoveTowardsAngle(actor.GetFacingYaw(), _turnTargetYaw, num * Time.deltaTime);
		actor.SyncRotation(num2);
		if (Mathf.Abs(Mathf.DeltaAngle(num2, _turnTargetYaw)) < 0.1f)
		{
			EndTurn();
		}
	}

	private void EndTurn()
	{
		_turning = false;
		actor.PlayIdle();
	}

	public override void OnUpdate()
	{
		base.OnUpdate();
		if (_turning)
		{
			TickTurn();
			_idleTimer = 0f;
			return;
		}
		if (IsInteractingWithActor())
		{
			if (_isPlayingIdleShow)
			{
				ResetIdleShow();
				actor.PlayIdle();
			}
			_idleTimer = 0f;
			return;
		}
		if (_isPlayingIdleShow)
		{
			if (actor.IsMoving)
			{
				ResetIdleShow();
			}
			return;
		}
		if (actor.IsMoving)
		{
			_idleTimer = 0f;
			return;
		}
		_idleTimer += Time.deltaTime;
		if (_idleTimer >= 5f)
		{
			_isPlayingIdleShow = true;
			actor.PlayIdleShowAnim(() =>
			{
				_isPlayingIdleShow = false;
				_idleTimer = 0f;
				actor.PlayIdle();
			});
		}
	}

	public override void OnInputUpdate(bool movementHasInput, Vector2 inputValue, bool bWalk = false)
	{
		if (movementHasInput)
		{
			_turning = false;
			NotifyMovementInputForIdleShow();
			hasStopMoved = false;
			actor.ForwardMove(inputValue, bWalk);
		}
		else if (!hasStopMoved)
		{
			hasStopMoved = true;
			actor.StopMove();
		}
	}

	private bool IsInteractingWithActor()
	{
		DormLevelController dormLevelController = ModuleController<DormModuleController>.Instance.levelInstance as DormLevelController;
		if (null != dormLevelController)
		{
			return dormLevelController.IsInteractingWithActor;
		}
		return false;
	}

	private void NotifyMovementInputForIdleShow()
	{
		ResetIdleShow();
	}

	private void ResetIdleShow()
	{
		if (_isPlayingIdleShow)
		{
			actor.StopTimelineAnimation();
		}
		_isPlayingIdleShow = false;
		_idleTimer = 0f;
	}
}
