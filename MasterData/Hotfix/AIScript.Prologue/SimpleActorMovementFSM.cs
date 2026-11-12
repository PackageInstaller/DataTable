using TrueSync;
using UnityEngine;

namespace AIScript.Prologue;

public class SimpleActorMovementFSM(GameObject gObj) : ActorMovementFSM(gObj)
{
	public bool isOverride;

	private ActorState lastState;

	private bool isSpdDown;

	private FP curSpeed;

	private FP fadeTime = 0.25;

	private FP deltaSpeedDown;

	public override void OnUpdate()
	{
		base.OnUpdate();
	}

	public override void UpdateAnimation(bool applyRootMotion, bool applyRootMotionRotate)
	{
		if (!isOverride)
		{
			base.UpdateAnimation(applyRootMotion, applyRootMotionRotate);
		}
		else
		{
			if (_actor.animatorController == null)
			{
				return;
			}
			if (applyRootMotionRotate)
			{
				_actor.rootBoneRotationLocked = true;
			}
			else
			{
				_actor.rootBoneRotationLocked = false;
			}
			bool flag = _actor is SimplePlayerAdventureActor;
			FP fP = (flag ? (_actor as SimplePlayerAdventureActor).animMaxSpd : _actor.GetMaxSpeed());
			float value = (float)(_actor.velocitySpeed / fP);
			if (_actor.movementState == ActorState.StandBy && lastState == ActorState.Move)
			{
				isSpdDown = true;
				curSpeed = _actor.GetMaxSpeed();
				deltaSpeedDown = curSpeed * _actor.LogicDeltaTime / fadeTime;
			}
			else if (_actor.movementState == ActorState.Move && lastState == ActorState.StandBy)
			{
				isSpdDown = false;
			}
			lastState = _actor.movementState;
			if (isSpdDown)
			{
				curSpeed -= deltaSpeedDown;
				if (curSpeed < 0)
				{
					isSpdDown = false;
					curSpeed = 0;
				}
				value = (float)(curSpeed / fP);
			}
			_actor.animatorController.SetFloat(SimplePlayerAdventureActor.actorSpeedHash, value, flag);
		}
	}

	protected override void Move(TSVector2 movementDelta)
	{
		if (!isOverride)
		{
			base.Move(movementDelta);
			return;
		}
		_accumulatedMovementDelta += movementDelta;
		_actor.AgentMove(new TSVector(movementDelta.x, 0f, movementDelta.y));
	}
}
