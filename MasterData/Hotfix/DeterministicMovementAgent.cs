using System.Collections;
using Pathfinding;
using Pathfinding.RVO;
using Pathfinding.Util;
using TrueSync;
using TrueSync.Physics2D;
using UnityEngine;

public class DeterministicMovementAgent : RichAI, IDeterministicMovementBlocker
{
	public enum MovementMode
	{
		Manual,
		Forward,
		Navigation
	}

	protected LogicEntity _owner;

	protected CoroutineNode _traversingOffMeshLinkCoroutine;

	protected readonly NNConstraint _reachableConstraint = NNConstraint.Default;

	public FP groundPenetrationProbeDistance = 10;

	public FP groundPenetrationMinStepDistance = 0.5f;

	private static readonly FP GroundAboveEpsilon = 0.01f;

	[Space]
	[Tooltip("开启移动阻挡")]
	[SerializeField]
	protected bool _canBlock = true;

	[SerializeField]
	protected RVOLayer _blockLayer = RVOLayer.DefaultAgent;

	[SerializeField]
	protected RVOLayer _blockWith = (RVOLayer)(-1);

	[Tooltip("blockPriority大者可以阻挡blockPriority小者")]
	[TSFPRange(0f, 1f)]
	[SerializeField]
	protected FP _blockPriority = 0.5f;

	[Tooltip("阻挡移动阻尼")]
	[TSFPRange(0f, 1f)]
	[SerializeField]
	protected FP _blockDamp = 1f;

	protected AdventureActor _actor;

	private PlayerAdventureActor _player;

	protected bool _initialized;

	protected bool haveNavCut;

	public MovementMode movementMode { get; protected set; }

	public LogicEntity owner
	{
		get
		{
			return _owner;
		}
		set
		{
			_owner = value;
		}
	}

	public Seeker cachedSeeker => seeker;

	public RVOController cachedRVOController => rvoController;

	public TSVector2 movementVelocity
	{
		get
		{
			return velocity2D;
		}
		set
		{
			velocity2D = value;
		}
	}

	public TSVector2 Position2D => new TSVector2(simulatedPosition.x, simulatedPosition.z);

	public FP Rotation2D => TSVector2.SignedAngle(TSVector2.up, Forward2D);

	public TrueSync.Physics2D.Transform MovementTransform
	{
		get
		{
			TrueSync.Physics2D.Transform result = default;
			result.Set(Position2D, Rotation2D * FP.Deg2Rad);
			return result;
		}
	}

	public TSVector2 Forward2D
	{
		get
		{
			TSVector tSVector = simulatedRotation * TSVector.forward;
			return new TSVector2(tSVector.x, tSVector.z);
		}
	}

	public TSVector2 Back2D => Forward2D * -1f;

	public TSVector2 Right2D
	{
		get
		{
			TrueSync.Physics2D.Transform movementTransform = MovementTransform;
			return new TSVector2(y: movementTransform.q.s, x: movementTransform.q.c);
		}
	}

	public TSVector2 Left2D => Right2D * -1f;

	public bool canBlock
	{
		get
		{
			return _canBlock;
		}
		set
		{
			_canBlock = value;
		}
	}

	public RVOLayer blockLayer
	{
		get
		{
			return _blockLayer;
		}
		set
		{
			_blockLayer = value;
		}
	}

	public RVOLayer blockWith
	{
		get
		{
			return _blockWith;
		}
		set
		{
			_blockWith = value;
		}
	}

	public FP blockPriority
	{
		get
		{
			return _blockPriority;
		}
		set
		{
			_blockPriority = value;
		}
	}

	public FP blockDamp
	{
		get
		{
			return _blockDamp;
		}
		set
		{
			_blockDamp = value;
		}
	}

	public FP blockerRadius
	{
		get
		{
			return radius;
		}
		set
		{
			radius = value;
		}
	}

	public TSVector blockerPosition => simulatedPosition;

	public bool UsingGravity
	{
		get
		{
			return usingGravity;
		}
		set
		{
			usingGravity = value;
		}
	}

	public TSVector2 TransformLocalPointToWorldSpace(TSVector2 point)
	{
		TrueSync.Physics2D.Transform T = MovementTransform;
		return MathUtils.Mul(ref T, ref point);
	}

	public TSVector2 TransformWorldPointToLocalSpace(TSVector2 point)
	{
		TrueSync.Physics2D.Transform T = MovementTransform;
		return MathUtils.MulT(ref T, ref point);
	}

	public override void SearchPath()
	{
		if (traversingOffMeshLink)
		{
			delayUpdatePath = true;
		}
		else if (!(destination.x == FP.PositiveInfinity))
		{
			onSearchPath?.Invoke();
			lastRepath = LockStepManager.unscaledTime;
			waitingForPathCalculation = true;
			seeker.CancelCurrentPathRequest();
			CalculatePathRequestEndpoints(out var start, out var end);
			seeker.StartPath(start, end).BlockUntilCalculated();
		}
	}

	protected override void OnPathComplete(Pathfinding.Path p)
	{
		base.OnPathComplete(p);
		if (!p.error)
		{
			movementMode = MovementMode.Navigation;
		}
	}

	public void StartNavigation(TSVector dest)
	{
		if (canSearch && canMove)
		{
			destination = dest;
			isStopped = false;
			SearchPath();
		}
	}

	protected override void OnTargetReached()
	{
		movementMode = MovementMode.Manual;
	}

	public void ForwardMovement(TSVector direction)
	{
		if (canMove)
		{
			destination = GetFeetPosition() + direction * 100f;
			isStopped = false;
			movementMode = MovementMode.Forward;
		}
	}

	public void StopMovement()
	{
		destination = new TSVector(FP.PositiveInfinity, FP.PositiveInfinity, FP.PositiveInfinity);
		steeringTarget = TSVector.zero;
		isStopped = true;
		SetPath(null);
		movementMode = MovementMode.Manual;
	}

	public override void Teleport(TSVector newPosition, bool clearPath = true)
	{
		if (owner == null)
		{
			velocity2D = TSVector2.zero;
			destination = new TSVector(FP.PositiveInfinity, FP.PositiveInfinity, FP.PositiveInfinity);
			steeringTarget = TSVector.zero;
			simulatedRotation = TSQuaternion.identity;
			if (clearPath)
			{
				ClearPath();
			}
			prevPosition1 = (prevPosition2 = (simulatedPosition = newPosition));
			if (updatePosition)
			{
				tr.position = newPosition.ToVector();
			}
			if (rvoController != null)
			{
				rvoController.Move(TSVector.zero);
			}
			return;
		}
		_reachableConstraint.graphMask = cachedSeeker.graphMask;
		_reachableConstraint.constrainDistance = false;
		_reachableConstraint.distanceXZ = true;
		NNInfo nNInfo = ((AstarPath.active != null) ? AstarPath.active.GetNearest(newPosition, _reachableConstraint) : default(NNInfo));
		movementPlane.ToPlane(newPosition, out var elevation);
		newPosition = movementPlane.ToWorld(movementPlane.ToPlane((nNInfo.node != null) ? nNInfo.position : newPosition), elevation);
		velocity2D = TSVector2.zero;
		destination = new TSVector(FP.PositiveInfinity, FP.PositiveInfinity, FP.PositiveInfinity);
		steeringTarget = TSVector.zero;
		TSVector2 forward = owner.tsTransform.Forward;
		simulatedRotation = TSQuaternion.LookRotation(new TSVector(forward.x, 0f, forward.y));
		if (clearPath)
		{
			ClearPath();
		}
		prevPosition1 = (prevPosition2 = (simulatedPosition = newPosition));
		if (updatePosition)
		{
			tr.position = newPosition.ToVector();
		}
		if (rvoController != null)
		{
			rvoController.Move(TSVector.zero);
		}
	}

	protected override void MovementUpdateInternal(FP deltaTime, out TSVector nextPosition, out TSQuaternion nextRotation)
	{
		if (updatePosition)
		{
			simulatedPosition = tr.position.ToTSVector();
		}
		if (updateRotation)
		{
			simulatedRotation = tr.rotation.ToTSQuaternion();
		}
		if (movementMode == MovementMode.Forward)
		{
			TSVector2 tSVector = movementPlane.ToPlane(simulatedPosition, out var _);
			steeringTarget = destination;
			TSVector2 tSVector2 = movementPlane.ToPlane(steeringTarget) - tSVector;
			TSVector2 targetVelocity = VectorMath.Normalize(tSVector2, out distanceToSteeringTarget) * maxSpeed;
			TSVector2 tSVector3 = MovementUtilities.CalculateAccelerationToReachPoint(forwardsVector: movementPlane.ToPlane(simulatedRotation * ((orientation == OrientationMode.YAxisForward) ? TSVector.up : TSVector.forward)), deltaPosition: tSVector2, targetVelocity: targetVelocity, currentVelocity: velocity2D, forwardsAcceleration: acceleration, rotationSpeed: rotationSpeed, maxSpeed: maxSpeed);
			if (_player != null && _player.dodgeButtonHold && (!_player.actorInfo.dodgeToRushAcceleration || _actor.haveExternalForce))
			{
				velocity2D = targetVelocity;
				_actor.haveExternalForce = false;
			}
			else
			{
				velocity2D += tSVector3 * deltaTime;
			}
			FinalMovement(simulatedPosition, deltaTime, 9999, 1f, out nextPosition, out nextRotation);
			if (canBlock)
			{
				DeterministicMovementBlocker.MovementBlock(this, ref nextPosition, _actor);
			}
			return;
		}
		RichPathPart currentPart = richPath.GetCurrentPart();
		if (currentPart is RichSpecial link)
		{
			if (!traversingOffMeshLink)
			{
				_traversingOffMeshLinkCoroutine = _owner.StartLogicCoroutine(TraverseSpecial(link));
			}
			TSVector tSVector4 = (steeringTarget = simulatedPosition);
			nextPosition = tSVector4;
			nextRotation = rotation;
		}
		else if (currentPart is RichFunnel fn && !isStopped)
		{
			TraverseFunnel(fn, deltaTime, out nextPosition, out nextRotation);
			if (canBlock)
			{
				DeterministicMovementBlocker.MovementBlock(this, ref nextPosition, _actor);
			}
		}
		else
		{
			velocity2D -= TSVector2.ClampMagnitude(velocity2D, acceleration * deltaTime);
			FinalMovement(simulatedPosition, deltaTime, 9999, 1f, out nextPosition, out nextRotation);
			if (canBlock)
			{
				DeterministicMovementBlocker.MovementBlock(this, ref nextPosition, _actor);
			}
			steeringTarget = nextPosition;
		}
	}

	protected override IEnumerator TraverseSpecial(RichSpecial link)
	{
		traversingOffMeshLink = true;
		velocity2D = TSVector2.zero;
		IEnumerator routine = ((onTraverseOffMeshLink != null) ? onTraverseOffMeshLink(link) : TraverseOffMeshLinkFallback(link));
		yield return _owner.StartLogicCoroutine(routine);
		traversingOffMeshLink = false;
		_traversingOffMeshLinkCoroutine = null;
		NextPart();
		if (delayUpdatePath)
		{
			delayUpdatePath = false;
			if (canSearch)
			{
				SearchPath();
			}
		}
	}

	public override void FinalizeMovement(TSVector nextPosition, TSQuaternion nextRotation)
	{
		if (enableRotation)
		{
			FinalizeRotation(nextRotation);
		}
		TSVector tSVector = simulatedPosition;
		TSVector tSVector2 = tSVector;
		movementPlane.ToPlane(tSVector, out var elevation);
		tSVector = nextPosition + accumulatedMovementDelta;
		tSVector = ClampToNavmesh(tSVector, out var _);
		if (usingGravity)
		{
			TSVector tSVector3 = tSVector;
			tSVector = RaycastPosition(tSVector3, elevation);
			if (!(tSVector3.x != tSVector.x) && !(tSVector3.y != tSVector.y) && !(tSVector3.z != tSVector.z) && ExceedsPenetrationStepThreshold(tSVector2, tSVector3) && IsGroundAbove(tSVector3))
			{
				movementPlane.ToPlane(tSVector3, out var elevation2);
				TSVector tSVector4 = movementPlane.ToWorld(movementPlane.ToPlane(tSVector2), elevation2);
				tSVector = RaycastPosition(tSVector4, elevation);
			}
		}
		accumulatedMovementDelta = TSVector.zero;
		simulatedPosition = tSVector;
		UpdateVelocity();
	}

	private bool ExceedsPenetrationStepThreshold(TSVector startPosition, TSVector attemptedPosition)
	{
		FP fP = groundPenetrationMinStepDistance;
		if (fP <= FP.Epsilon)
		{
			return true;
		}
		return (movementPlane.ToPlane(attemptedPosition) - movementPlane.ToPlane(startPosition)).LengthSquared() > fP * fP;
	}

	private bool IsGroundAbove(TSVector position)
	{
		float num = (float)groundPenetrationProbeDistance;
		if (num <= 0f)
		{
			return false;
		}
		Vector3 normalized = movementPlane.ToWorld(TSVector2.zero, 1).ToVector().normalized;
		if (!Physics.Raycast(position.ToVector() + normalized * num, -normalized, out var hitInfo, num, groundMask, QueryTriggerInteraction.Ignore))
		{
			return false;
		}
		movementPlane.ToPlane(position, out var elevation);
		movementPlane.ToPlane(hitInfo.point.ToTSVector(), out var elevation2);
		return elevation2 > elevation + GroundAboveEpsilon;
	}

	protected override TSVector ClampToNavmesh(TSVector position, out bool positionChanged)
	{
		if (movementMode == MovementMode.Navigation)
		{
			return base.ClampToNavmesh(position, out positionChanged);
		}
		_reachableConstraint.graphMask = cachedSeeker.graphMask;
		_reachableConstraint.constrainDistance = false;
		_reachableConstraint.distanceXZ = true;
		NNInfo nNInfo = ((AstarPath.active != null) ? AstarPath.active.GetNearest(position, _reachableConstraint) : default(NNInfo));
		movementPlane.ToPlane(position, out var elevation);
		TSVector tSVector = movementPlane.ToWorld(movementPlane.ToPlane((nNInfo.node != null) ? nNInfo.position : position), elevation);
		TSVector2 tSVector2 = movementPlane.ToPlane(tSVector - position);
		if (tSVector2.LengthSquared() > 1.0000001E-06f)
		{
			if (rvoController != null && rvoController.enabled)
			{
				rvoController.SetCollisionNormal(tSVector2.ToTSVector());
			}
			positionChanged = true;
			return tSVector;
		}
		positionChanged = false;
		return position;
	}

	public void UpdateRVOAgentProperties()
	{
		IAgent rvoAgent = rvoController.rvoAgent;
		rvoAgent.Radius = TSMath.Max(0.001f, radius);
		rvoAgent.AgentTimeHorizon = rvoController.agentTimeHorizon;
		rvoAgent.ObstacleTimeHorizon = rvoController.obstacleTimeHorizon;
		rvoAgent.Locked = rvoController.locked;
		rvoAgent.MaxNeighbours = rvoController.maxNeighbours;
		rvoAgent.DebugDraw = rvoController.debug;
		rvoAgent.Layer = rvoController.layer;
		rvoAgent.CollidesWith = rvoController.collidesWith;
		rvoAgent.Priority = rvoController.priority;
		rvoAgent.Position = rvoController.To2D(position, out var elevation);
		if (rvoController.movementPlane == MovementPlane.XZ)
		{
			rvoAgent.Height = height;
			rvoAgent.ElevationCoordinate = elevation;
		}
		else
		{
			rvoAgent.Height = 1;
			rvoAgent.ElevationCoordinate = 0;
		}
	}

	public void RotationTowards(TSVector direction, FP maxDegrees)
	{
		simulatedRotation = SimulateRotationTowards(movementPlane.ToPlane(direction), maxDegrees);
		if (velocity2D != TSVector2.zero)
		{
			TSVector2 tSVector = movementPlane.ToPlane(simulatedRotation * ((orientation == OrientationMode.YAxisForward) ? TSVector.up : TSVector.forward));
			velocity2D = tSVector * velocity2D.magnitude;
		}
	}

	public void RotationTowards(TSVector direction, FP maxDegrees, FP deltaTime)
	{
		simulatedRotation = SimulateRotationTowards(movementPlane.ToPlane(direction), maxDegrees * deltaTime);
		if (velocity2D != TSVector2.zero)
		{
			TSVector2 tSVector = movementPlane.ToPlane(simulatedRotation * ((orientation == OrientationMode.YAxisForward) ? TSVector.up : TSVector.forward));
			velocity2D = tSVector * velocity2D.magnitude;
		}
	}

	protected override void Start()
	{
		usingGravity = !(gravity == TSVector.zero) && (!updatePosition || ((rigid == null || rigid.isKinematic) && (rigid2D == null || rigid2D.isKinematic)));
		groundMask = _actor.actorInfo?.moveType switch
		{
			HotfixEnum.actorMovType.WALK => (LayerMask)2048, 
			HotfixEnum.actorMovType.STATIC => (LayerMask)2048, 
			HotfixEnum.actorMovType.FLY => (LayerMask)16, 
			_ => groundMask, 
		};
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		DeterministicMovementBlocker.activedBlockers.Add(this);
		if (_actor == null)
		{
			_actor = GetComponent<AdventureActor>();
			if (_actor is PlayerAdventureActor player)
			{
				_player = player;
			}
		}
		if (!_initialized)
		{
			base.Start();
			if (rvoController != null)
			{
				rvoController.rvoAgent.PreCalculationCallback = UpdateRVOAgentProperties;
			}
			_initialized = true;
			haveNavCut = GetComponent<NavmeshCut>() != null;
		}
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		if (_traversingOffMeshLinkCoroutine != null)
		{
			_owner.StopLogicCoroutine(_traversingOffMeshLinkCoroutine);
			_traversingOffMeshLinkCoroutine = null;
		}
		DeterministicMovementBlocker.activedBlockers.Remove(this);
	}

	protected override void Update()
	{
	}

	protected override void FixedUpdate()
	{
	}

	public void UpdateMovement(FP deltaTime)
	{
		if (isActiveAndEnabled && canMove && !haveNavCut)
		{
			MovementUpdate(deltaTime, out var nextPosition, out var nextRotation);
			FinalizeMovement(nextPosition, nextRotation);
		}
	}
}
