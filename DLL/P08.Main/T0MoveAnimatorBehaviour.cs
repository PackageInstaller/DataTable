using System.Threading;
using System.Threading.Tasks;
using Cinemachine;
using UnityEngine;

public class T0MoveAnimatorBehaviour : T0MoveBehaviour
{
	public float stopTurnThreasholdDegree = 10f;

	private const float DAMP_TIME_STEP = 0.2f;

	public float turnEaseTime = 0.5f;

	public float moveEaseTime = 1f;

	public Transform root;

	public Animator animator;

	private Vector3 prevPos;

	private Quaternion prevRot;

	private CinemachinePathBase curMovingPath;

	public float smallTurnThreasholdDegree = 90f;

	public float turnThreasholdDegree = 180f;

	private const string SMALL_TURN_STATE_NAME = "TurnNear";

	private const string TURN_STATE_NAME = "Turn";

	private float movingDistance;

	private float maxDistance;

	private const float LERP_PATH_DISTANCEE = 0.5f;

	public float estimateStopDistance = 1.25f;

	public bool IsStoppingMove { get; private set; }

	public bool IsMovingByPath { get; private set; }

	public bool IsTurning { get; private set; }

	public override bool IsReadyToMove => true;

	private static Vector2 GetVecXZ(Vector3 vec)
	{
		return new Vector2(vec.x, vec.z);
	}

	public override Task ChangeMovePath(CinemachinePathBase path, bool needRotate, CancellationToken cancel)
	{
		return Task.CompletedTask;
	}

	public override async Task<bool> StartMove(CinemachinePathBase path, CancellationToken cancel)
	{
		animator.enabled = true;
		animator.Rebind();
		curMovingPath = path;
		maxDistance = curMovingPath.MaxUnit(CinemachinePathBase.PositionUnits.Distance);
		movingDistance = 0f;
		Vector2 vecXZ = GetVecXZ(path.EvaluateTangent(path.FindClosestPoint(root.position, 0, -1, 4)));
		if (vecXZ != Vector2.zero)
		{
			await StartTurnBeforeMove(vecXZ, cancel);
		}
		prevPos = root.position;
		prevRot = root.rotation;
		await InterpolateMove(path, cancel);
		await StopMove();
		return !cancel.IsCancellationRequested;
	}

	public override async Task StopMove(CancellationToken cancel = default(CancellationToken))
	{
		if (IsStoppingMove)
		{
			while (!cancel.IsCancellationRequested && animator.GetFloat("Move") > 0.05f)
			{
				await Task.Yield();
			}
			return;
		}
		IsStoppingMove = true;
		while (!cancel.IsCancellationRequested && animator.GetFloat("Move") > 0.05f)
		{
			animator.SetFloat("Move", 0f, moveEaseTime * 0.2f, Time.deltaTime);
			await Task.Yield();
		}
		IsStoppingMove = false;
		animator.SetFloat("Move", 0f);
		IsMovingByPath = false;
	}

	private async Task InterpolateMove(CinemachinePathBase path, CancellationToken cancel)
	{
		animator.CrossFadeInFixedTime("Walk", moveEaseTime);
		movingDistance = path.FromPathNativeUnits(path.FindClosestPoint(prevPos, 0, -1, 4), CinemachinePathBase.PositionUnits.Distance);
		IsMovingByPath = true;
		while (!cancel.IsCancellationRequested && movingDistance + estimateStopDistance <= maxDistance)
		{
			animator.SetFloat("Turn", 0f, turnEaseTime * 0.2f, Time.deltaTime);
			animator.SetFloat("Move", 1f, moveEaseTime * 0.2f, Time.deltaTime);
			await Task.Yield();
		}
	}

	private async Task StartTurnBeforeMove(Vector2 startVec, CancellationToken cancel)
	{
		float startDegree = Vector2.SignedAngle(startVec, GetVecXZ(root.forward));
		float num = Mathf.Abs(startDegree);
		_ = turnEaseTime;
		float turnEstimateDegree = turnThreasholdDegree;
		string stateName;
		if (num > smallTurnThreasholdDegree)
		{
			stateName = "Turn";
		}
		else
		{
			stateName = "TurnNear";
			turnEstimateDegree = smallTurnThreasholdDegree;
		}
		if (!animator.GetCurrentAnimatorStateInfo(0).IsName(stateName))
		{
			animator.CrossFade(stateName, 0.05f, 0, 0f);
		}
		if (animator.GetFloat("Move") > 0f)
		{
			await StopMove();
		}
		IsTurning = true;
		animator.SetFloat("Turn", startDegree / turnEstimateDegree);
		while (!cancel.IsCancellationRequested && !(Mathf.Abs(Vector2.SignedAngle(startVec, GetVecXZ(root.forward))) <= stopTurnThreasholdDegree))
		{
			await Task.Yield();
		}
		IsTurning = false;
	}

	private void OnAnimatorMove()
	{
		if (IsMovingByPath && movingDistance <= maxDistance)
		{
			movingDistance += animator.deltaPosition.magnitude;
			float pos = curMovingPath.ToNativePathUnits(movingDistance, CinemachinePathBase.PositionUnits.Distance);
			Vector3 vector = curMovingPath.EvaluatePosition(pos);
			Quaternion rotation = curMovingPath.EvaluateOrientation(pos);
			bool flag;
			float normalizedTime;
			if (animator.IsInTransition(0))
			{
				AnimatorTransitionInfo animatorTransitionInfo = animator.GetAnimatorTransitionInfo(0);
				flag = true;
				normalizedTime = animatorTransitionInfo.normalizedTime;
			}
			else
			{
				AnimatorStateInfo currentAnimatorStateInfo = animator.GetCurrentAnimatorStateInfo(0);
				flag = currentAnimatorStateInfo.IsName("Move");
				normalizedTime = currentAnimatorStateInfo.normalizedTime;
			}
			if (flag)
			{
				float t = Mathf.Clamp01(normalizedTime);
				vector = Vector3.Lerp(root.position, vector, t);
			}
			root.position = vector;
			root.rotation = rotation;
		}
		else if (IsTurning)
		{
			Quaternion deltaRotation = animator.deltaRotation;
			float t2 = Mathf.Abs(animator.GetFloat("Turn"));
			deltaRotation = Quaternion.SlerpUnclamped(Quaternion.identity, deltaRotation, t2);
			root.rotation = deltaRotation * root.rotation;
			root.localPosition += animator.deltaPosition;
		}
		else
		{
			animator.ApplyBuiltinRootMotion();
		}
	}
}
