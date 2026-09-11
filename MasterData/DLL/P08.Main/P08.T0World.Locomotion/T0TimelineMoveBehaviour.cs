using System;
using System.Threading;
using System.Threading.Tasks;
using Cinemachine;
using RootMotion;
using T0World;
using UnityEngine;
using UnityEngine.Playables;

namespace P08.T0World.Locomotion;

public class T0TimelineMoveBehaviour : T0MoveBehaviour
{
	public enum State
	{
		Turn,
		MoveByPath,
		Stopping,
		Normal
	}

	private struct Trigger
	{
		private bool value;

		private bool needReset;

		public bool Value
		{
			get
			{
				return value;
			}
			set
			{
				if (value)
				{
					if (!needReset)
					{
						this.value = value;
						needReset = true;
					}
				}
				else
				{
					this.value = value;
				}
			}
		}

		public void Update()
		{
			Value = false;
		}

		public void Reset()
		{
			needReset = false;
		}
	}

	public Transform root;

	public Animator animator;

	private CinemachinePathBase curMovingPath;

	[SerializeField]
	private T0WorldInteractionBehavior interactionBehavior;

	public State state = State.Normal;

	public string standState = "normal_stay_101";

	public string walkState = "normal_walk_102";

	public string smallTurnLState = "normal_turn_101";

	public string smallTurnRState = "normal_turn_102";

	public string turnLState = "normal_turn_101x";

	public string turnRState = "normal_turn_102x";

	[Range(0.05f, 0.98f)]
	[Tooltip("转身至行走的动画混合时间点")]
	public float canTurnBlendToMoveNormalizedTime = 0.65f;

	public float smallTurnThreasholdDegree = 90f;

	public float turnThreasholdDegree = 180f;

	public float stopTurnThreasholdDegree = 10f;

	public float movingStopTurnDistance = 0.25f;

	public float estimateStopDistance = 1.25f;

	public float stopFadeTime;

	private float stopCountdown;

	private float movingByPathDistance;

	private float walkDistance;

	private float maxDistance;

	private const float LERP_POS_TO_PATH = 1f;

	private Vector3 prevPos;

	private Quaternion prevRot;

	private Quaternion targetTurnRot;

	private float turnProgress;

	public float IKFootOnGroundThreashold = 0.25f;

	private const string VAR_FOOT_IK_WEIGHT_L = "LeftFootIK";

	private const string VAR_FOOT_IK_WEIGHT_R = "RightFootIK";

	private const string VAR_FOOT_IK_HIT_GROUND_L = "LeftFootOnGround";

	private const string VAR_FOOT_IK_HIT_GROUND_R = "RightFootOnGround";

	public T0CharacterIkBehavior ikBehavior;

	private Trigger leftFootOnGround;

	private Trigger rightFootOnGround;

	public override bool IsReadyToMove => IsNormal;

	public float CurAnimationTurnDegree { get; private set; }

	private float StoppingProgress => stopCountdown / stopFadeTime;

	public bool IsMovingByPath => state == State.MoveByPath;

	public bool IsTurning => state == State.Turn;

	public bool IsStoppingMove => state == State.Stopping;

	public bool IsNormal => state == State.Normal;

	private static Vector2 GetVecXZ(Vector3 vec)
	{
		return new Vector2(vec.x, vec.z);
	}

	public override async Task<bool> StartMove(CinemachinePathBase path, CancellationToken cancel)
	{
		curMovingPath = path;
		maxDistance = curMovingPath.MaxUnit(CinemachinePathBase.PositionUnits.Distance);
		movingByPathDistance = 0f;
		Vector2 vecXZ = GetVecXZ(path.EvaluateTangent(path.FindClosestPoint(root.position, 0, -1, 4)));
		prevRot = root.rotation;
		if (vecXZ != Vector2.zero)
		{
			await StartTurnBeforeMove(vecXZ, cancel);
		}
		if (!cancel.IsCancellationRequested && root != null)
		{
			prevPos = root.position;
			await InterpolateMove(path, cancel);
			state = State.Normal;
		}
		return !cancel.IsCancellationRequested;
	}

	private void PlayAction(string name)
	{
		interactionBehavior.PlayTimeline("108502ui_" + name, out var _, out var _, DirectorWrapMode.Loop);
	}

	private async Task StartTurnBeforeMove(Vector2 startVec, CancellationToken cancel)
	{
		Vector2 vecXZ = GetVecXZ(root.forward);
		float num = Vector2.SignedAngle(startVec, vecXZ);
		float num2 = Mathf.Abs(num);
		if (cancel.IsCancellationRequested || num2 <= stopTurnThreasholdDegree)
		{
			return;
		}
		string turnStateName;
		if (num2 <= smallTurnThreasholdDegree)
		{
			CurAnimationTurnDegree = smallTurnThreasholdDegree;
			turnStateName = ((!(num < 0f)) ? smallTurnRState : smallTurnLState);
		}
		else
		{
			CurAnimationTurnDegree = turnThreasholdDegree;
			turnStateName = ((!(num < 0f)) ? turnRState : turnLState);
		}
		state = State.Turn;
		turnProgress = 0f;
		targetTurnRot = Quaternion.LookRotation(new Vector3(startVec.x, 0f, startVec.y));
		PlayAction(turnStateName);
		await Task.Yield();
		while (!cancel.IsCancellationRequested && (bool)root)
		{
			Vector2.Angle(startVec, GetVecXZ(root.forward));
			AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
			if (!animator.IsInTransition(0) && (!currentAnimatorStateInfo.IsName(turnStateName) || currentAnimatorStateInfo.normalizedTime >= canTurnBlendToMoveNormalizedTime))
			{
				break;
			}
			await Task.Yield();
		}
	}

	public async Task<bool> TurnTargetDegree(Vector2 startVec, CancellationToken cancel)
	{
		prevRot = root.rotation;
		await StartTurnBeforeMove(startVec, cancel);
		state = State.Normal;
		return !cancel.IsCancellationRequested;
	}

	private async Task InterpolateMove(CinemachinePathBase path, CancellationToken cancel)
	{
		if (!cancel.IsCancellationRequested)
		{
			walkDistance = 0f;
			movingByPathDistance = path.FromPathNativeUnits(path.FindClosestPoint(prevPos, 0, -1, 4), CinemachinePathBase.PositionUnits.Distance);
			state = State.MoveByPath;
			PlayAction(walkState);
			while (!cancel.IsCancellationRequested && movingByPathDistance + estimateStopDistance <= maxDistance)
			{
				await Task.Yield();
			}
		}
	}

	public void SetNormalState()
	{
		PlayAction(standState);
		state = State.Normal;
	}

	public override async Task StopMove(CancellationToken cancel = default(CancellationToken))
	{
		if (!IsStoppingMove)
		{
			PlayAction(standState);
			state = State.Stopping;
		}
		await Task.Yield();
		if (animator != null && animator.IsInTransition(0))
		{
			AnimatorTransitionInfo animatorTransitionInfo = animator.GetAnimatorTransitionInfo(0);
			stopCountdown = Mathf.Clamp01(1f - animatorTransitionInfo.normalizedTime) * animatorTransitionInfo.duration;
			stopFadeTime = animatorTransitionInfo.duration;
		}
		else
		{
			stopCountdown = stopFadeTime;
		}
		while (!cancel.IsCancellationRequested && IsStoppingMove && stopCountdown > 0f)
		{
			stopCountdown -= Time.deltaTime;
			await Task.Yield();
		}
		if (stopCountdown <= 0f)
		{
			stopCountdown = 0f;
			state = State.Normal;
		}
	}

	private float SignedDegree(float degree)
	{
		if (!(degree > 180f))
		{
			return degree;
		}
		return degree - 360f;
	}

	public override Task ChangeMovePath(CinemachinePathBase path, bool needRotate, CancellationToken cancel)
	{
		curMovingPath = path;
		maxDistance = curMovingPath.MaxUnit(CinemachinePathBase.PositionUnits.Distance);
		movingByPathDistance = 0f;
		walkDistance = 0f;
		return Task.CompletedTask;
	}

	public Vector3 GetNextMovingPos(float moveDisValue)
	{
		int num = (int)Math.Ceiling(movingByPathDistance);
		float a = movingByPathDistance + moveDisValue;
		a = Mathf.Min(a, num);
		float pos = curMovingPath.ToNativePathUnits(a, CinemachinePathBase.PositionUnits.Distance);
		Vector3 b = curMovingPath.EvaluatePosition(pos);
		float num2 = Mathf.Min(maxDistance, 1f);
		float t = Mathf.Clamp01(a / num2);
		return Vector3.Lerp(root.position, b, t);
	}

	private void OnAnimatorMove()
	{
		if (IsMovingByPath && movingByPathDistance <= maxDistance)
		{
			float num = Vector3.Dot(animator.deltaPosition, root.forward);
			walkDistance += num;
			movingByPathDistance += num;
			float pos = curMovingPath.ToNativePathUnits(movingByPathDistance, CinemachinePathBase.PositionUnits.Distance);
			Vector3 b = curMovingPath.EvaluatePosition(pos);
			float num2 = Mathf.Min(maxDistance, 1f);
			float t = Mathf.Clamp01(walkDistance / num2);
			b = Vector3.Lerp(root.position, b, t);
			root.position = b;
			if (maxDistance - movingByPathDistance > movingStopTurnDistance)
			{
				Quaternion rotation = curMovingPath.EvaluateOrientation(pos);
				root.rotation = rotation;
			}
		}
		else if (IsTurning)
		{
			Quaternion deltaRotation = animator.deltaRotation;
			float num3 = 1f;
			if (animator.IsInTransition(0))
			{
				num3 = animator.GetNextAnimatorClipInfo(0)[0].weight;
			}
			if (num3 > 0f)
			{
				float num4 = Mathf.Abs(SignedDegree(deltaRotation.eulerAngles.y)) / CurAnimationTurnDegree;
				turnProgress += num4 / num3;
				deltaRotation = Quaternion.SlerpUnclamped(prevRot, targetTurnRot, turnProgress);
				root.rotation = deltaRotation;
			}
		}
		else if (IsNormal)
		{
			root.position += animator.deltaPosition;
			root.rotation = animator.deltaRotation * root.rotation;
		}
		else if (IsStoppingMove)
		{
			float num5 = Vector3.Dot(animator.deltaPosition, root.forward);
			walkDistance += num5;
			float t2 = (maxDistance - walkDistance) / estimateStopDistance;
			root.position = Vector3.Lerp(curMovingPath.EvaluatePosition(curMovingPath.MaxPos), root.position, t2);
			root.rotation = animator.deltaRotation * root.rotation;
		}
		T0WorldScene.Scene.player.UpdateCollisionTest();
	}

	private void Start()
	{
		ikBehavior.bipedIk.scheduleUpdateType = SolverManager.ScheduleUpdate.Manual;
	}

	private void OnAnimatorIK(int layerIndex)
	{
	}

	private void LateUpdate()
	{
		UpdateBaseLayerIK();
		ikBehavior.bipedIk.UpdateSolverExternal();
	}

	private void UpdateBaseLayerIK()
	{
		if (IsTurning || IsMovingByPath)
		{
			leftFootOnGround.Update();
			rightFootOnGround.Update();
			float num = animator.GetFloat("LeftFootIK");
			float num2 = animator.GetFloat("RightFootIK");
			if (num > IKFootOnGroundThreashold)
			{
				leftFootOnGround.Value = true;
			}
			else if (num < 1f - IKFootOnGroundThreashold)
			{
				leftFootOnGround.Reset();
			}
			if (num2 > IKFootOnGroundThreashold)
			{
				rightFootOnGround.Value = true;
			}
			else if (num2 < 1f - IKFootOnGroundThreashold)
			{
				rightFootOnGround.Reset();
			}
			if (leftFootOnGround.Value)
			{
				ikBehavior.UpdateIKGoalPos(AvatarIKGoal.LeftFoot);
			}
			if (rightFootOnGround.Value)
			{
				ikBehavior.UpdateIKGoalPos(AvatarIKGoal.RightFoot);
			}
			ikBehavior.UpdateIKWeight(AvatarIKGoal.LeftFoot, Mathf.InverseLerp(IKFootOnGroundThreashold, 1f, num));
			ikBehavior.UpdateIKWeight(AvatarIKGoal.RightFoot, Mathf.InverseLerp(IKFootOnGroundThreashold, 1f, num2));
		}
		else if (state == State.Stopping)
		{
			float weight = animator.GetFloat("LeftFootIK") * StoppingProgress;
			float weight2 = animator.GetFloat("RightFootIK") * StoppingProgress;
			ikBehavior.UpdateIKWeight(AvatarIKGoal.LeftFoot, weight);
			ikBehavior.UpdateIKWeight(AvatarIKGoal.RightFoot, weight2);
		}
		else if (state == State.Normal)
		{
			ikBehavior.UpdateIKWeight(AvatarIKGoal.LeftFoot, 0f);
			ikBehavior.UpdateIKWeight(AvatarIKGoal.RightFoot, 0f);
		}
	}
}
