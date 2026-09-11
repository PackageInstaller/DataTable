using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using AINodes;
using P08.SimBusiness.Pathfinding;
using P08.T0World.Locomotion;
using Pathfinding;
using UnityEngine;

namespace T0World;

[Serializable]
public class T0InterationHandleData : T0InterationBaseData
{
	public T0InterationHandleTypeEnum handle_type;

	public float distance;

	public float timeValue;

	private float timeCount;

	public Vector3 rotateAngle;

	private Vector3 beginAngle;

	public Vector3 targetMovePos;

	public Vector3 targetMoveDir;

	private CancellationTokenSource cancel;

	private T0CharacterBehaviorAI aiBehaviour;

	private T0TimelineMoveBehaviour moveBehaviour;

	public override T0InterationTypeEnum GetStateEnum()
	{
		return T0InterationTypeEnum.Handle;
	}

	public override void StartEvent(T0WorldInteractionBehavior behaviour)
	{
		switch (handle_type)
		{
		case T0InterationHandleTypeEnum.Time:
			timeCount = 0f;
			break;
		case T0InterationHandleTypeEnum.MovePos:
			StartMovePosEvent(behaviour);
			break;
		case T0InterationHandleTypeEnum.Rotate:
			timeCount = 0f;
			beginAngle = behaviour.transform.eulerAngles;
			AddRotateEvent(behaviour);
			break;
		case T0InterationHandleTypeEnum.Teleport:
			behaviour.transform.position = targetMovePos;
			behaviour.transform.eulerAngles = rotateAngle;
			base.IsFinish = true;
			break;
		case T0InterationHandleTypeEnum.ExecuteFollow:
			(behaviour.mAgent.Blackboard as T0CharacterBlackborad).executeFollow = true;
			base.IsFinish = true;
			break;
		}
	}

	public override void UpdateEvent(T0WorldInteractionBehavior behaviour)
	{
		switch (handle_type)
		{
		case T0InterationHandleTypeEnum.Exit:
			UpdateExitEvent(behaviour);
			break;
		case T0InterationHandleTypeEnum.OpenAI:
			base.IsFinish = true;
			break;
		case T0InterationHandleTypeEnum.Time:
			UpdateTimeEvent(behaviour);
			break;
		}
	}

	public override void FinishEvent(T0WorldInteractionBehavior behaviour)
	{
	}

	public override void DisposeEvent()
	{
		if (handle_type == T0InterationHandleTypeEnum.MovePos)
		{
			DisposeMoveEvent();
		}
		else if (handle_type == T0InterationHandleTypeEnum.Rotate)
		{
			DisposeRotateEvent();
		}
	}

	public void UpdateExitEvent(T0WorldInteractionBehavior behaviour)
	{
		if (Vector3.Distance(T0WorldScene.Scene.player.transform.position, behaviour.transform.position) > distance)
		{
			base.IsFinish = true;
		}
	}

	public void UpdateTimeEvent(T0WorldInteractionBehavior behaviour)
	{
		timeCount += Time.deltaTime;
		if (timeCount >= timeValue)
		{
			base.IsFinish = true;
		}
	}

	public async void AddRotateEvent(T0WorldInteractionBehavior behaviour)
	{
		GameObject self = behaviour.gameObject;
		moveBehaviour = self.GetComponentInChildren<T0TimelineMoveBehaviour>();
		moveBehaviour.stopFadeTime = 0f;
		if (T0WorldTools.IsNeedStopManualAnimator())
		{
			StopAllManualAnimator(behaviour.animator);
		}
		behaviour.GetComponent<T0ChangeAnimatorController>().ChangeToDefaultController();
		float f = rotateAngle.y * (MathF.PI / 180f);
		Vector2 startVec = new Vector2(Mathf.Sin(f), Mathf.Cos(f));
		CancellationTokenSource cancel = (this.cancel = new CancellationTokenSource());
		bool flag = await moveBehaviour.TurnTargetDegree(startVec, cancel.Token);
		if (!cancel.IsCancellationRequested)
		{
			if (flag && self != null)
			{
				behaviour.CloseExcutePlayable();
				self.transform.eulerAngles = rotateAngle;
				base.IsFinish = true;
			}
			this.cancel = null;
		}
	}

	public async void DisposeRotateEvent()
	{
		if ((bool)moveBehaviour && cancel != null)
		{
			await moveBehaviour.StopMove(cancel.Token);
		}
		CancelPrevMove();
	}

	public void CancelPrevMove()
	{
		if (cancel != null)
		{
			cancel.Cancel();
			cancel = null;
		}
	}

	private async Task WaitMoveNavigationComplete(T0CharacterBehaviorAI aiBehaviour, CancellationToken cancellation)
	{
		PlayerMoveAnimBrain moveBrain = aiBehaviour.moveAnimBrain;
		while (!cancellation.IsCancellationRequested && aiBehaviour.moveAnimBrain.IsAINavigatingMove)
		{
			float value = Vector3.Distance(moveBrain.player.position, moveBrain.MoveEndEstimateTargetPos.Value);
			moveBrain.walkCarefulness = Mathf.InverseLerp(0.5f, 0.2f, value);
			await Task.Yield();
		}
	}

	private async Task WaitMoveEndToIdle(T0CharacterBehaviorAI aiBehaviour, CancellationToken cancellation)
	{
		while (!cancellation.IsCancellationRequested && aiBehaviour.moveAnimBrain.moveState != PlayerMoveAnimBrain.MoveState.Idle)
		{
			await Task.Yield();
		}
	}

	public async void StartMovePosEvent(T0WorldInteractionBehavior behaviour)
	{
		CancelPrevMove();
		GameObject gameObject = behaviour.gameObject;
		cancel = new CancellationTokenSource();
		using CancellationTokenSource cancellation = CancellationTokenSource.CreateLinkedTokenSource(behaviour.cancel.Token, cancel.Token);
		aiBehaviour = gameObject.GetComponent<T0CharacterBehaviorAI>();
		moveBehaviour = gameObject.GetComponentInChildren<T0TimelineMoveBehaviour>();
		if ((bool)aiBehaviour)
		{
			_ = aiBehaviour.moveAnimBrain.navigatingDeadZone;
			aiBehaviour.moveAnimBrain.navigatingDeadZone = 0.1f;
			aiBehaviour.AiMoveTargetPos(targetMovePos, targetMoveDir);
			if (!aiBehaviour.moveAnimBrain.IsAINavigationTargetNearBy)
			{
				await WaitMoveNavigationComplete(aiBehaviour, cancellation.Token);
			}
			else
			{
				aiBehaviour.moveAnimBrain.JustAdjustFacingDir();
				await Task.Yield();
			}
			aiBehaviour.moveAnimBrain.walkCarefulness = 0f;
			await WaitMoveEndToIdle(aiBehaviour, cancellation.Token);
			if (!cancellation.IsCancellationRequested)
			{
				aiBehaviour.OpenMove(isMove: false);
			}
			base.IsFinish = true;
		}
		else if ((bool)moveBehaviour)
		{
			await StartMovePosEventOld(behaviour, gameObject, moveBehaviour, cancellation.Token);
		}
	}

	public async Task StartMovePosEventOld(T0WorldInteractionBehavior behaviour, GameObject self, T0TimelineMoveBehaviour moveBehaviour, CancellationToken cancel)
	{
		T0MovePath smoothPath = U3DUtil.Get<T0MovePath>(self);
		if (!smoothPath)
		{
			smoothPath = BTTestMove.GetSmoothPathCom(self);
		}
		Path path = await BTTestMove.CalcPathToTarget(U3DUtil.Get<PathfindingSeeker>(self), targetMovePos);
		float oldEstimateStopDistance = moveBehaviour.estimateStopDistance;
		float oldStopFadeTime = moveBehaviour.stopFadeTime;
		if ((this.cancel != null && this.cancel.IsCancellationRequested) || path.int3Path.Count <= 1)
		{
			base.IsFinish = true;
		}
		else
		{
			List<Int3> int3Path = path.int3Path;
			_ = (Vector3)int3Path[int3Path.Count - 1];
			List<Int3> int3Path2 = path.int3Path;
			int3Path2[int3Path2.Count - 1] = (Int3)targetMovePos;
			moveBehaviour.estimateStopDistance = 0f;
			moveBehaviour.stopFadeTime = 1f;
			if (T0WorldTools.IsNeedStopManualAnimator())
			{
				StopAllManualAnimator(behaviour.animator);
			}
			behaviour.GetComponent<T0ChangeAnimatorController>().ChangeToDefaultController();
			List<Int3> int3Path3 = path.int3Path;
			Vector3 vector = (Vector3)int3Path3[int3Path3.Count - 1];
			T0MoveBehaviour.ConstructSmoothPath(path, ((Vector3)(path.int3Path[1] - path.int3Path[0])).normalized, targetMovePos - vector, smoothPath);
			bool flag = await moveBehaviour.StartMove(smoothPath, cancel);
			if (!cancel.IsCancellationRequested)
			{
				if (flag)
				{
					await moveBehaviour.StopMove(cancel);
					base.IsFinish = true;
				}
				this.cancel = null;
			}
		}
		moveBehaviour.estimateStopDistance = oldEstimateStopDistance;
		moveBehaviour.stopFadeTime = oldStopFadeTime;
	}

	private void StopAllManualAnimator(Animator animator)
	{
		if (animator.gameObject.TryGetComponent<ManualAnimator>(out var component))
		{
			UnityEngine.Object.Destroy(component);
		}
	}

	public void DisposeMoveEvent()
	{
		CancelPrevMove();
	}
}
