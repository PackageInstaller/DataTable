using System;
using System.Collections.Generic;
using Pathfinding;
using Pathfinding.Util;
using TrueSync;
using UnityEngine;

public class DormActorMoveAgent : DeterministicMovementAgent
{
	public enum ActorMovementMode
	{
		MoveByDirection,
		Move2Target
	}

	public bool isMoving;

	private Vector3 movePos;

	public DormActor.DormActoBehaviour dormActorState;

	private Action moveEnd;

	private Vector3 _stuckLastPos;

	private float _stuckTimer;

	public Action onStuck;

	private ActorMovementMode movmentMode = ActorMovementMode.Move2Target;

	private bool blockMoveBehaviour;

	private TSVector2 _lastMoveDir = TSVector2.zero;

	protected override void Start()
	{
		groundMask = 2048;
	}

	public void Init()
	{
		radius = 0.3f;
		endReachedDistance = 1;
		wallForce = 0;
		wallDist = 0;
		updatePosition = false;
		updateRotation = false;
		rotationSpeed = 360f;
		simulatedPosition = tr.position.ToTSVector();
		simulatedRotation = tr.rotation.ToTSQuaternion();
	}

	public void ForwardMove(TSVector2 moveDirection)
	{
		if (moveDirection.LengthSquared() > FP.Epsilon)
		{
			TSVector2 tSVector = movementVelocity;
			if (tSVector.LengthSquared() > FP.Epsilon && TSVector2.Dot(tSVector.normalized, moveDirection.normalized) < FP.Zero)
			{
				movementVelocity = TSVector2.zero;
			}
		}
		_lastMoveDir = moveDirection;
		destination = GetFeetPosition() + new TSVector(moveDirection.x, 0, moveDirection.y);
		SearchPath();
		canSearch = true;
		isMoving = true;
		dormActorState = DormActor.DormActoBehaviour.Move;
		movmentMode = ActorMovementMode.MoveByDirection;
	}

	public void ForwardMove(TSVector moveDirection)
	{
		_lastMoveDir = new TSVector2(moveDirection.x, moveDirection.z);
		destination = GetFeetPosition() + moveDirection;
		canSearch = true;
		SearchPath();
		isMoving = true;
		dormActorState = DormActor.DormActoBehaviour.Move;
		movmentMode = ActorMovementMode.MoveByDirection;
	}

	public void MoveToPos(Vector3 pos, Action actionMoveEnd = null)
	{
		movePos = pos;
		destination = pos.ToTSVector();
		SearchPath();
		canSearch = true;
		isMoving = true;
		dormActorState = DormActor.DormActoBehaviour.Move;
		moveEnd = actionMoveEnd;
		movmentMode = ActorMovementMode.Move2Target;
		ResetStuckDetection();
	}

	private void ResetStuckDetection()
	{
		_stuckTimer = 0f;
		_stuckLastPos = transform.position;
	}

	public void StopMove()
	{
		if (dormActorState == DormActor.DormActoBehaviour.Move)
		{
			ClearPath();
			isMoving = false;
			dormActorState = DormActor.DormActoBehaviour.Idle;
			ResetStuckDetection();
		}
	}

	public void SyncRotation(Quaternion rotation)
	{
		transform.rotation = rotation;
		simulatedRotation = rotation.ToTSQuaternion();
	}

	public void BlockMoveBehaviour()
	{
		blockMoveBehaviour = true;
	}

	public void ResumeMoveBehaviour()
	{
		blockMoveBehaviour = false;
	}

	protected override void Update()
	{
		if (blockMoveBehaviour)
		{
			return;
		}
		if (Time.frameCount % 10 == 0)
		{
			SearchPath();
		}
		if (dormActorState == DormActor.DormActoBehaviour.Move && movmentMode == ActorMovementMode.Move2Target)
		{
			if (Vector3.Distance(transform.position, movePos) < 0.2f)
			{
				ClearPath();
				dormActorState = DormActor.DormActoBehaviour.Idle;
				isMoving = false;
				ResetStuckDetection();
				if (moveEnd != null)
				{
					moveEnd();
				}
			}
			else
			{
				Vector3 stuckLastPos = transform.position;
				float num = stuckLastPos.x - _stuckLastPos.x;
				float num2 = stuckLastPos.z - _stuckLastPos.z;
				float num3 = num * num + num2 * num2;
				float num4 = 0.08f;
				if (num3 < num4 * num4)
				{
					_stuckTimer += Time.deltaTime;
					if (_stuckTimer >= 0.5f)
					{
						ResetStuckDetection();
						onStuck?.Invoke();
					}
				}
				else
				{
					_stuckTimer = 0f;
					_stuckLastPos = stuckLastPos;
				}
			}
		}
		UpdateMovement(Time.deltaTime);
	}

	protected void UpdateMovement(float deltaTime)
	{
		if (isActiveAndEnabled && canMove && isMoving)
		{
			MovementUpdate(deltaTime, out var nextPosition, out var nextRotation);
			FinalizeMovement(nextPosition, nextRotation);
			transform.position = simulatedPosition.ToVector();
			transform.rotation = simulatedRotation.ToQuaternion();
		}
	}

	protected override void MovementUpdateInternal(FP deltaTime, out TSVector nextPosition, out TSQuaternion nextRotation)
	{
		base.MovementUpdateInternal(deltaTime, out nextPosition, out nextRotation);
		if (DormConfigs.marchInPlaceOnBlock && movmentMode == ActorMovementMode.MoveByDirection && isMoving && IsPathBlocked(nextPosition))
		{
			TSVector2 walkableAxisComponents = GetWalkableAxisComponents(_lastMoveDir);
			if (walkableAxisComponents.LengthSquared() > FP.Epsilon)
			{
				TSVector tSVector = new TSVector(walkableAxisComponents.x, 0, walkableAxisComponents.y) * (maxSpeed * deltaTime);
				nextPosition = simulatedPosition + tSVector;
				velocity2D = TSVector2.zero;
				accumulatedMovementDelta = TSVector.zero;
			}
			else
			{
				nextPosition = simulatedPosition;
				velocity2D = TSVector2.zero;
				accumulatedMovementDelta = TSVector.zero;
			}
		}
		if (movmentMode == ActorMovementMode.MoveByDirection && isMoving && _lastMoveDir.LengthSquared() > FP.Epsilon)
		{
			float num = 540f;
			FP maxDegrees = ((num > 0f) ? (num * deltaTime) : ((FP)360));
			nextRotation = SimulateRotationTowards(new TSVector(_lastMoveDir.x, 0, _lastMoveDir.y), maxDegrees);
		}
	}

	private bool IsPathBlocked(TSVector baseNextPosition)
	{
		if (_lastMoveDir.LengthSquared() <= FP.Epsilon)
		{
			return false;
		}
		TSVector tSVector = baseNextPosition - simulatedPosition;
		FP fP = tSVector.x * tSVector.x + tSVector.z * tSVector.z;
		FP fP2 = maxSpeed * LockStepManager.deltaTime * DormConfigs.marchInPlaceMovedRatio;
		return fP < fP2 * fP2;
	}

	private TSVector2 GetWalkableAxisComponents(TSVector2 input)
	{
		TSVector feetPosition = GetFeetPosition();
		FP fP = DormConfigs.marchInPlaceProbeDistance;
		TSVector2 zero = TSVector2.zero;
		if (input.x * input.x > FP.Epsilon)
		{
			FP fP2 = ((input.x > FP.Zero) ? FP.One : (-FP.One));
			TSVector jVector = feetPosition + new TSVector(fP2 * fP, 0, 0);
			if (CheckPositionWalkable(jVector.ToVector()))
			{
				zero.x = input.x;
			}
		}
		if (input.y * input.y > FP.Epsilon)
		{
			FP fP3 = ((input.y > FP.Zero) ? FP.One : (-FP.One));
			TSVector jVector2 = feetPosition + new TSVector(0, 0, fP3 * fP);
			if (CheckPositionWalkable(jVector2.ToVector()))
			{
				zero.y = input.y;
			}
		}
		return zero;
	}

	private NavmeshBase GetNavmeshGraph()
	{
		if (AstarPath.active == null || seeker == null)
		{
			return null;
		}
		GraphMask graphMask = seeker.graphMask;
		NavGraph[] graphs = AstarPath.active.graphs;
		if (graphs == null)
		{
			return null;
		}
		for (int i = 0; i < graphs.Length; i++)
		{
			NavGraph navGraph = graphs[i];
			if (navGraph != null && graphMask.Contains(i))
			{
				return navGraph as NavmeshBase;
			}
		}
		return null;
	}

	public bool TryGetNearestWalkablePoint(Vector3 position, out Vector3 result)
	{
		result = position;
		NavmeshBase navmeshGraph = GetNavmeshGraph();
		if (navmeshGraph == null)
		{
			return false;
		}
		NNConstraint nNConstraint = NNConstraint.Default;
		nNConstraint.graphMask = seeker.graphMask;
		nNConstraint.constrainWalkability = true;
		nNConstraint.walkable = true;
		NNInfoInternal nearest = navmeshGraph.GetNearest(position.ToTSVector(), nNConstraint);
		if (nearest.node == null)
		{
			return false;
		}
		result = nearest.clampedPosition.ToVector();
		return true;
	}

	public bool CheckPositionWalkable(Vector3 position)
	{
		NavmeshBase navmeshGraph = GetNavmeshGraph();
		if (navmeshGraph != null)
		{
			NNConstraint nNConstraint = NNConstraint.Default;
			nNConstraint.graphMask = seeker.graphMask;
			nNConstraint.constrainDistance = true;
			nNConstraint.distanceXZ = true;
			nNConstraint.constrainWalkability = true;
			nNConstraint.walkable = true;
			return navmeshGraph.PointOnNavmesh(position.ToTSVector(), nNConstraint) != null;
		}
		return false;
	}

	public bool TryGetRandomWalkablePointInScene(out Vector3 result, float minDistanceFromSelf = 0f, int maxAttempts = 16)
	{
		result = transform.position;
		NavmeshBase navmeshGraph = GetNavmeshGraph();
		if (navmeshGraph == null)
		{
			return false;
		}
		NNConstraint nNConstraint = NNConstraint.Default;
		nNConstraint.graphMask = seeker.graphMask;
		nNConstraint.constrainWalkability = true;
		nNConstraint.walkable = true;
		GraphNode node = navmeshGraph.GetNearest(transform.position.ToTSVector(), nNConstraint).node;
		if (node == null)
		{
			return false;
		}
		List<GraphNode> list = PathUtilities.GetReachableNodes(node);
		if (list == null || list.Count == 0)
		{
			return false;
		}
		try
		{
			float num = minDistanceFromSelf * minDistanceFromSelf;
			Vector3 vector = transform.position;
			for (int i = 0; i < Mathf.Max(1, maxAttempts); i++)
			{
				List<TSVector> list2 = PathUtilities.GetPointsOnNodes(list, 1);
				if (list2 != null && list2.Count != 0)
				{
					Vector3 vector2 = list2.get_Item(0).ToVector();
					ListPool<TSVector>.Release(ref list2);
					if ((num <= 0f || (vector2 - vector).sqrMagnitude >= num) && CheckPositionWalkable(vector2))
					{
						result = vector2;
						return true;
					}
				}
			}
			for (int j = 0; j < 4; j++)
			{
				List<TSVector> list3 = PathUtilities.GetPointsOnNodes(list, 1);
				if (list3 != null && list3.Count != 0)
				{
					Vector3 vector3 = list3.get_Item(0).ToVector();
					ListPool<TSVector>.Release(ref list3);
					if (CheckPositionWalkable(vector3))
					{
						result = vector3;
						return true;
					}
				}
			}
			return false;
		}
		finally
		{
			ListPool<GraphNode>.Release(ref list);
		}
	}
}
