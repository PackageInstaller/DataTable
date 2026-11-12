using UnityEngine;

public class DormPlayer : DormActor
{
	protected override bool blockOtherActorsHard => true;

	protected override float rvoPriority => 1f;

	protected override float walkSpeed => 1.2f;

	protected override float runSpeed => 3.41f;

	protected override void RegisterFSM()
	{
		RegisterFSM(DormActorState.None);
		RegisterFSM(DormActorState.Control);
		RegisterFSM(DormActorState.Rome);
		RegisterFSM(DormActorState.Hover);
		RegisterFSM(DormActorState.Interactive);
		RegisterFSM(DormActorState.Hide);
		RegisterFSM(DormActorState.Noticed);
	}

	public void OnMovementInput(bool movementHasInput, Vector2 movementInputDirection, bool bWalk = false)
	{
		stateMgr?.OnInputUpdate(movementHasInput, movementInputDirection, bWalk);
	}

	protected override void EnterModeDefault()
	{
		if (FSMState != DormActorState.Interactive)
		{
			SwitchState(DormActorState.Control);
		}
		SceneSingleton<DormCameraController>.Instance.BindFocusObject(gameObject);
	}

	protected override void EnterModeVisitor()
	{
		if (FSMState != DormActorState.Interactive)
		{
			SwitchState(DormActorState.Control);
		}
		SceneSingleton<DormCameraController>.Instance.BindFocusObject(gameObject);
	}

	public void RequestTurnToFace(Vector3 targetPos)
	{
		if (FSMState == DormActorState.Control && stateMgr.GetFSM(DormActorState.Control) is DormActorFSM_Control dormActorFSM_Control)
		{
			dormActorFSM_Control.RequestTurnTo(targetPos);
		}
	}

	public override void InterWithObjeComplete()
	{
		if (base.dormMode == DormMode.View)
		{
			base.InterWithObjeComplete();
			return;
		}
		DormMode dormMode = base.dormMode;
		if (dormMode == DormMode.Default || dormMode == DormMode.Visitor)
		{
			InvokeInteractiveCompleteCallback();
			SwitchState(DormActorState.Control);
		}
	}

	public override void ResetToSpawnState()
	{
		DormMode dormMode = base.dormMode;
		if (dormMode != DormMode.Default && dormMode != DormMode.Visitor)
		{
			base.ResetToSpawnState();
			return;
		}
		StopAction();
		DiscardLeaveFurniturePending();
		SwitchState(DormActorState.None);
		SwitchState(DormActorState.Control);
		SceneSingleton<DormCameraController>.Instance.BindFocusObject(gameObject);
	}

	protected void WwiseEvent(string eventName)
	{
		if (FSMState == DormActorState.Control || FSMState == DormActorState.Interactive)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent(eventName, gameObject);
		}
	}
}
