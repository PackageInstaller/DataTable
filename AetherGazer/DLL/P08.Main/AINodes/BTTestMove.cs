using System;
using System.Collections.Generic;
using System.Threading;
using System.Threading.Tasks;
using BilliardGame.Spell;
using Dorm.Character;
using P08.SimBusiness.Pathfinding;
using P08.T0World.Locomotion;
using Pathfinding;
using T0World;
using UnityEngine;

namespace AINodes;

public class BTTestMove : BActionNode
{
	private class EndingConditionProximity : ABPathEndingCondition
	{
		public float maxDistance = 10f;

		public EndingConditionProximity(ABPath p, float maxDistance)
			: base(p)
		{
			this.maxDistance = maxDistance;
		}

		public override bool TargetFound(PathNode node)
		{
			GraphNode node2 = node.node;
			Int3 originalEndPoint = abPath.originalEndPoint;
			if (node2 != null && AstarData.GetGraph(node2) is IRaycastableGraph raycastableGraph && raycastableGraph.Linecast(node2.position, originalEndPoint, node2, out var hit))
			{
				Int3 point = hit.point;
				if (hit.node == node2)
				{
					return ((Vector3)(point - abPath.originalEndPoint)).sqrMagnitude <= maxDistance * maxDistance;
				}
				return false;
			}
			return false;
		}
	}

	public enum MoveBusyState
	{
		Idle,
		Occupy,
		Wait,
		NewTask
	}

	public enum MoveState
	{
		Begin,
		Loop,
		End
	}

	public string sourceName = "Self";

	public string targetName = "Target";

	[NonSerialized]
	private BTNodeStatus status;

	public float time = 5f;

	private float runMoveChangeTargetTimeLength = 2.5f;

	private float runMoveChangeTargetSegment;

	private static Vector3 nowTargetPos = Vector3.zero;

	private const float MOVE_PATH_SEG_CUT = 0.5f;

	private static List<Vector3> pathWaypoint = new List<Vector3>();

	private static int executeMoveID = 0;

	private static Vector3 executeMovePos = Vector3.zero;

	private static MoveBusyState moveBusyState = MoveBusyState.Idle;

	private static MoveState moveState = MoveState.Begin;

	private CancellationTokenSource cancel;

	public override BTNodeStatus Run(BTEnv env)
	{
		if (!BNode.CheckRequiredParamsFromEnv(env, sourceName, targetName))
		{
			return BTNodeStatus.Failure;
		}
		if (status == BTNodeStatus.Inactive)
		{
			T0WorldScene.Scene.interactionManager.InteractContext.ClearFocusEvent();
			T0WorldScene.Scene.agentManager.CharacteraAgent.ClearEvent();
			runMoveChangeTargetSegment = 0f;
			status = BTNodeStatus.Running;
			StartMove(env);
		}
		else if (status == BTNodeStatus.Running)
		{
			if (moveBusyState == MoveBusyState.Wait)
			{
				StartMove(env);
			}
			else if (runMoveChangeTargetSegment > runMoveChangeTargetTimeLength)
			{
				runMoveChangeTargetSegment = 0f;
				if (Vector3.Distance(env.GetObject<Transform>(targetName).position, nowTargetPos) > 0.1f)
				{
					StartMove(env);
				}
			}
			runMoveChangeTargetSegment += Time.deltaTime;
		}
		return status;
	}

	public static Task<Path> CalcPathToTarget(PathfindingSeeker seeker, Transform target)
	{
		_ = AstarPath.active;
		Vector3 position = seeker.transform.position;
		seeker.startEndModifier.exactStartPoint = StartEndModifier.Exactness.Original;
		seeker.startEndModifier.exactEndPoint = StartEndModifier.Exactness.Original;
		seeker.startEndModifier.useGraphRaycasting = true;
		XPath xPath = XPath.Construct((Int3)position, (Int3)target.position);
		xPath.heuristic = Heuristic.Euclidean;
		TaskCompletionSource<Path> source = new TaskCompletionSource<Path>();
		seeker.StartPath(xPath, delegate(Path p)
		{
			source.SetResult(p);
		});
		return source.Task;
	}

	public static Task<Path> CalcPathToTarget(PathfindingSeeker seeker, Vector3 targetPos)
	{
		_ = AstarPath.active;
		Vector3 position = seeker.transform.position;
		seeker.startEndModifier.exactStartPoint = StartEndModifier.Exactness.Original;
		seeker.startEndModifier.exactEndPoint = StartEndModifier.Exactness.Original;
		seeker.startEndModifier.useGraphRaycasting = true;
		XPath xPath = XPath.Construct((Int3)position, (Int3)targetPos);
		xPath.heuristic = Heuristic.Euclidean;
		TaskCompletionSource<Path> source = new TaskCompletionSource<Path>();
		seeker.StartPath(xPath, delegate(Path p)
		{
			source.SetResult(p);
		});
		return source.Task;
	}

	private static bool FurtherThan(Vector3 p1, Vector3 p2, float len)
	{
		return (p2 - p1).sqrMagnitude >= len * len;
	}

	public static bool CheckIsInWaitState()
	{
		return moveBusyState == MoveBusyState.Wait;
	}

	public static void ChangeMoveBusyState(MoveBusyState state)
	{
		if (state == MoveBusyState.NewTask)
		{
			if (moveBusyState == MoveBusyState.Wait || moveBusyState == MoveBusyState.Idle)
			{
				moveBusyState = MoveBusyState.Idle;
			}
			else
			{
				moveBusyState = state;
			}
		}
		else
		{
			moveBusyState = state;
		}
	}

	public static void InterpolateEntityMove(Transform entityTrans, Vector3 p0, Vector3 p1, Vector3 p2, Vector3 p3, float t, bool useCatmullRom = false, float dt = 0.01f)
	{
		if (p0 == p1 && p2 == p3)
		{
			useCatmullRom = false;
		}
		Vector3 vector;
		Vector3 vector2;
		if (useCatmullRom)
		{
			vector = DormEntityAction.publicEntityMoveInterpolateFunc(p0, p1, p2, p3, t);
			float arg = t + dt;
			vector2 = DormEntityAction.publicEntityMoveInterpolateFunc(p0, p1, p2, p3, arg) - vector;
		}
		else
		{
			vector = Vector3.Lerp(p1, p2, t);
			float t2 = 1f - Mathf.Clamp01(Vector3.Distance(vector, p2) / 0.5f);
			vector2 = ((!(p3 == p2)) ? Vector3.Slerp(p2 - p1, p3 - p2, t2) : (p2 - p1));
		}
		vector2.y = 0f;
		vector2 = vector2.normalized;
		if (vector2 != Vector3.zero)
		{
			entityTrans.forward = vector2;
			entityTrans.position = vector;
		}
	}

	internal static void DebugDrawLine(Vector3 start, Vector3 end, Color color, float duration = 5f)
	{
		Debug.DrawLine(start, end, color, duration, depthTest: false);
	}

	public static T0MovePath GetSmoothPathCom(GameObject self)
	{
		GameObject gameObject = new GameObject("T0CharaMovePath");
		gameObject.transform.SetParent(self.transform);
		return gameObject.AddComponent<T0MovePath>();
	}

	public void CancelPrevMove()
	{
		if (cancel != null)
		{
			cancel.Cancel();
		}
	}

	private async void StartMove(BTEnv env)
	{
		T0WorldScene.Scene.player.enableCollisionTest = true;
		GameObject self = env.GetObject<GameObject>(sourceName);
		T0WorldInteractionBehavior interactionBehavior = self.GetComponent<T0WorldInteractionBehavior>();
		T0TimelineMoveBehaviour moveBehaviour = self.GetComponentInChildren<T0TimelineMoveBehaviour>();
		if (moveBehaviour.IsTurning)
		{
			return;
		}
		CancellationTokenSource cancel = this.cancel;
		if (!moveBehaviour.IsMovingByPath && !moveBehaviour.IsStoppingMove)
		{
			CancelPrevMove();
			cancel = (this.cancel = new CancellationTokenSource());
		}
		_ = nowTargetPos;
		Transform target = env.GetObject<Transform>(targetName);
		nowTargetPos = target.position;
		self.transform.GetChild(0).transform.localRotation = Quaternion.identity;
		T0MovePath smoothPath = self.GetComponentInChildren<T0MovePath>();
		if (!smoothPath)
		{
			smoothPath = GetSmoothPathCom(self);
		}
		PathfindingSeeker seeker = U3DUtil.Get<PathfindingSeeker>(self);
		Vector3 vector = target.position - self.transform.position;
		Vector3 targetPos = target.position - vector.normalized;
		targetPos.y = 0f;
		bool result;
		if (moveBehaviour.IsMovingByPath || moveBehaviour.IsStoppingMove)
		{
			if (cancel == null)
			{
				cancel = new CancellationTokenSource();
			}
			this.cancel = cancel;
			Path path = await CalcPathToTarget(seeker, targetPos);
			Vector3 nextMovingPos = moveBehaviour.GetNextMovingPos(0.05f);
			Int3 @int = path.int3Path[1];
			Vector3 vector2 = nowTargetPos - self.transform.position;
			Vector3 position = self.transform.position;
			List<Int3> int3Path = path.int3Path;
			Vector3 vector3 = position - (Vector3)int3Path[int3Path.Count - 1];
			if (vector2.sqrMagnitude > 0.01f && Vector3.Dot(vector2.normalized, vector3.normalized) > 0f)
			{
				return;
			}
			bool flag = Vector3.Angle((Vector3)(@int - (Int3)self.transform.position), nextMovingPos - self.transform.position) > 360f;
			path.int3Path[0] = (Int3)self.transform.position;
			if (!flag)
			{
				if (path.int3Path.Count > 2)
				{
					path.int3Path[1] = (Int3)nextMovingPos;
				}
				else
				{
					path.int3Path.Insert(1, (Int3)nextMovingPos);
				}
			}
			List<Int3> int3Path2 = path.int3Path;
			Vector3 vector4 = (Vector3)int3Path2[int3Path2.Count - 1];
			T0MoveBehaviour.ConstructSmoothPath(path, ((Vector3)(path.int3Path[1] - path.int3Path[0])).normalized, target.transform.position - vector4, smoothPath);
			if (!flag)
			{
				await moveBehaviour.ChangeMovePath(smoothPath, flag, cancel.Token);
				return;
			}
			CancelPrevMove();
			cancel = (this.cancel = new CancellationTokenSource());
			result = await moveBehaviour.StartMove(smoothPath, cancel.Token);
			if (!cancel.IsCancellationRequested)
			{
				if (result)
				{
					await moveBehaviour.StopMove(cancel.Token);
				}
				this.cancel = null;
			}
			if (result)
			{
				OnMoveEnd(result);
			}
			return;
		}
		Path path2 = await CalcPathToTarget(seeker, targetPos);
		if (cancel.IsCancellationRequested || path2.int3Path.Count <= 1)
		{
			OnMoveEnd(result: false);
			return;
		}
		if (T0WorldTools.IsNeedStopManualAnimator())
		{
			StopAllManualAnimator(interactionBehavior.animator);
		}
		interactionBehavior.GetComponent<T0ChangeAnimatorController>().ChangeToDefaultController();
		List<Int3> int3Path3 = path2.int3Path;
		Vector3 vector5 = (Vector3)int3Path3[int3Path3.Count - 1];
		T0MoveBehaviour.ConstructSmoothPath(path2, ((Vector3)(path2.int3Path[1] - path2.int3Path[0])).normalized, target.transform.position - vector5, smoothPath);
		result = await moveBehaviour.StartMove(smoothPath, cancel.Token);
		if (!cancel.IsCancellationRequested)
		{
			if (result)
			{
				await moveBehaviour.StopMove(cancel.Token);
			}
			this.cancel = null;
		}
		if (result)
		{
			OnMoveEnd(result);
		}
	}

	private void StopAllManualAnimator(Animator animator)
	{
		if (animator.gameObject.TryGetComponent<ManualAnimator>(out var component))
		{
			UnityEngine.Object.Destroy(component);
		}
	}

	private void OnMoveEnd(bool result)
	{
		T0WorldScene.Scene.player.enableCollisionTest = false;
		status = ((!result) ? BTNodeStatus.Failure : BTNodeStatus.Success);
	}

	public override void OnEnd(BTEnv env)
	{
		CancelPrevMove();
		cancel = null;
		base.OnEnd(env);
		status = BTNodeStatus.Inactive;
	}
}
