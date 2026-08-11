using System.Collections.Generic;
using Ase.ECS;
using UnityEngine;

namespace Ase;

public abstract class MovementMotorBase
{
	public const int MaxHitsBudget = 32;

	public const int MaxCollisionBudget = 32;

	public const int MaxGroundingSweepIterations = 2;

	public const int MaxSteppingSweepIterations = 3;

	public const int MaxRigidbodyOverlapsCount = 32;

	public const float CollisionOffset = 0.01f;

	public const float GroundProbeReboundDistance = 0.02f;

	public const float MinimumGroundProbingDistance = 0.005f;

	public const float GroundProbingBackstepDistance = 0.1f;

	public const float SweepProbingBackstepDistance = 0.002f;

	public const float SecondaryProbesVertical = 0.02f;

	public const float SecondaryProbesHorizontal = 0.001f;

	public const float MinVelocityMagnitude = 0.01f;

	public const float SteppingForwardDistance = 0.03f;

	public const float MinDistanceForLedge = 0.05f;

	public const float CorrelationForVerticalObstruction = 0.01f;

	public const float ExtraSteppingForwardDistance = 0.01f;

	public const float ExtraStepHeightPadding = 0.01f;

	protected BaseEntity _entity;

	protected PhysicsScene physicsScene;

	protected float FloorBaseDistance;

	protected bool IsOpenFallOffCorrection;

	protected CapsuleCollider Capsule;

	protected float CapsuleRadius = 0.5f;

	protected float CapsuleHeight = 2f;

	protected float CapsuleYOffset = 1f;

	protected PhysicMaterial CapsulePhysicsMaterial;

	public float GroundDetectionExtraDistance;

	public float MaxStableSlopeAngle = 60f;

	public LayerMask StableGroundLayers = 1 << LayerMask.NameToLayer("Ground");

	public bool DiscreteCollisionEvents;

	public StepHandlingMethod StepHandling = StepHandlingMethod.Standard;

	public float MaxStepHeight = 0.33f;

	public bool AllowSteppingWithoutStableGrounding;

	public float MinRequiredStepDepth = 0.1f;

	public bool LedgeAndDenivelationHandling = true;

	public float MaxStableDistanceFromLedge = 0.5f;

	public float MaxVelocityForLedgeSnap;

	public float MaxStableDenivelationAngle = 180f;

	public bool InteractiveRigidbodyHandling = true;

	public RigidbodyInteractionType RigidbodyInteractionType;

	public float SimulatedCharacterMass = 1f;

	public bool PreserveAttachedRigidbodyMomentum = true;

	public bool HasPlanarConstraint;

	public Vector3 PlanarConstraintAxis = Vector3.forward;

	public int MaxMovementIterations = 5;

	public int MaxDecollisionIterations = 2;

	public bool CheckMovementInitialOverlaps;

	public bool KillVelocityWhenExceedMaxMovementIterations = true;

	public bool KillRemainingMovementWhenExceedMaxMovementIterations = true;

	public CharacterGroundingReport GroundingStatus;

	public CharacterTransientGroundingReport LastGroundingStatus;

	public LayerMask CollidableLayers = -1;

	protected ILTransform _transform;

	protected Vector3 _transientPosition;

	protected Vector3 _characterUp;

	protected Vector3 _characterForward;

	protected Vector3 _characterRight;

	protected Vector3 _initialSimulationPosition;

	protected Quaternion _initialSimulationRotation;

	protected Rigidbody _attachedRigidbody;

	protected Vector3 _characterTransformToCapsuleCenter;

	private Vector3 _characterTransformToCapsuleBottom;

	private Vector3 _characterTransformToCapsuleTop;

	protected Vector3 _characterTransformToCapsuleBottomHemi;

	protected Vector3 _characterTransformToCapsuleTopHemi;

	protected Vector3 _attachedRigidbodyVelocity;

	protected int _overlapsCount;

	protected OverlapResult[] _overlaps = new OverlapResult[32];

	public KinematicMoveComponent CharacterController;

	public bool LastMovementIterationFoundAnyGround;

	public int IndexInCharacterSystem;

	public Vector3 InitialTickPosition;

	public Quaternion InitialTickRotation;

	public Rigidbody AttachedRigidbodyOverride;

	public Vector3 BaseVelocity;

	protected RaycastHit[] _internalCharacterHits = (RaycastHit[])(object)new RaycastHit[32];

	protected Collider[] _internalProbedColliders = (Collider[])(object)new Collider[32];

	protected List<Rigidbody> _rigidbodiesPushedThisMove = new List<Rigidbody>(16);

	protected RigidbodyProjectionHit[] _internalRigidbodyProjectionHits = new RigidbodyProjectionHit[32];

	protected Rigidbody _lastAttachedRigidbody;

	protected bool _solveMovementCollisions = true;

	protected bool _solveGrounding = true;

	protected bool _solveWallCollisions = true;

	protected bool _movePositionDirty;

	protected bool _teleportMovement;

	protected Vector3 _movePositionTarget = Vector3.zero;

	protected bool _moveRotationDirty;

	protected Quaternion _moveRotationTarget = Quaternion.identity;

	protected bool _lastSolvedOverlapNormalDirty;

	protected Vector3 _lastSolvedOverlapNormal = Vector3.forward;

	protected int _rigidbodyProjectionHitCount;

	protected bool _isMovingFromAttachedRigidbody;

	protected bool _mustUnground;

	protected float _mustUngroundTimeCounter;

	protected Vector3 _cachedWorldUp = Vector3.up;

	protected Vector3 _cachedWorldForward = Vector3.forward;

	protected Vector3 _cachedWorldRight = Vector3.right;

	protected Vector3 _cachedZeroVector = Vector3.zero;

	protected Quaternion _transientRotation;

	public BaseEntity Entity => _entity;

	public bool TeleportMovement => _teleportMovement;

	public ILTransform Transform => _transform;

	public Vector3 TransientPosition => _transientPosition;

	public Vector3 CharacterUp => _characterUp;

	public Vector3 CharacterForward => _characterForward;

	public Vector3 CharacterRight => _characterRight;

	public Vector3 InitialSimulationPosition => _initialSimulationPosition;

	public Quaternion InitialSimulationRotation => _initialSimulationRotation;

	public Rigidbody AttachedRigidbody => _attachedRigidbody;

	public Vector3 CharacterTransformToCapsuleCenter => _characterTransformToCapsuleCenter;

	public Vector3 CharacterTransformToCapsuleBottom => _characterTransformToCapsuleBottom;

	public Vector3 CharacterTransformToCapsuleTop => _characterTransformToCapsuleTop;

	public Vector3 CharacterTransformToCapsuleBottomHemi => _characterTransformToCapsuleBottomHemi;

	public Vector3 CharacterTransformToCapsuleTopHemi => _characterTransformToCapsuleTopHemi;

	public Vector3 AttachedRigidbodyVelocity => _attachedRigidbodyVelocity;

	public int OverlapsCount => _overlapsCount;

	public OverlapResult[] Overlaps => _overlaps;

	public Quaternion TransientRotation
	{
		get
		{
			return _transientRotation;
		}
		protected set
		{
			_transientRotation = value;
			_characterUp = _transientRotation * _cachedWorldUp;
			_characterForward = _transientRotation * _cachedWorldForward;
			_characterRight = _transientRotation * _cachedWorldRight;
		}
	}

	public Vector3 Velocity => BaseVelocity + _attachedRigidbodyVelocity;

	public void Init(KinematicMoveComponent moveComponent)
	{
		//IL_007b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0080: Unknown result type (might be due to invalid IL or missing references)
		CharacterController = moveComponent;
		_transform = moveComponent.transform;
		_entity = moveComponent.Entity;
		_transientPosition = _transform.position;
		TransientRotation = _transform.rotation;
		_movePositionTarget = _transform.position;
		_moveRotationTarget = _transform.rotation;
		CollidableLayers = 0;
		physicsScene = moveComponent.Entity.GetWorld().GetPhysicsScene();
		for (int i = 0; i < 32; i++)
		{
			if (!Physics.GetIgnoreLayerCollision(0, i))
			{
				CollidableLayers = (int)CollidableLayers | (1 << i);
			}
		}
		OnInit();
	}

	protected virtual void OnInit()
	{
	}

	public void OnDead()
	{
		_transientPosition = _transform.position;
		_transientRotation = _transform.rotation;
		_movePositionDirty = false;
		_movePositionTarget = _transform.position;
		_moveRotationDirty = false;
		_moveRotationTarget = _transform.rotation;
		BaseVelocity = Vector3.zero;
	}

	public void OnLeaveGround()
	{
		BaseVelocity.x = 0f;
		BaseVelocity.z = 0f;
	}

	public void OnDispose()
	{
		_entity = null;
		Capsule = null;
		CharacterController = null;
	}

	public void RegisterBodyCollider(CapsuleCollider bodyCollider)
	{
		Capsule = bodyCollider;
		if (!((Object)(object)Capsule == null))
		{
			CapsuleRadius = Mathf.Clamp(CapsuleRadius, 0f, CapsuleHeight * 0.5f);
			Capsule.direction = 1;
			SetCapsuleDimensions(Capsule.radius, Capsule.height, Capsule.center.y);
			MaxStepHeight = Mathf.Clamp(MaxStepHeight, 0f, float.PositiveInfinity);
			MinRequiredStepDepth = Mathf.Clamp(MinRequiredStepDepth, 0f, CapsuleRadius);
			MaxStableDistanceFromLedge = Mathf.Clamp(MaxStableDistanceFromLedge, 0f, CapsuleRadius);
		}
	}

	public void SetCapsuleCollisionsActivation(bool collisionsActive)
	{
		((Collider)Capsule).isTrigger = !collisionsActive;
	}

	public void SetMovementCollisionsSolvingActivation(bool movementCollisionsSolvingActive)
	{
		_solveMovementCollisions = movementCollisionsSolvingActive;
	}

	public void SetGroundSolvingActivation(bool stabilitySolvingActive)
	{
		_solveGrounding = stabilitySolvingActive;
	}

	public void SetWallCollisionSolvingActivation(bool wallCollisionSolvingActivation)
	{
		_solveWallCollisions = wallCollisionSolvingActivation;
	}

	public void SetFloorBaseDistance(float floorBaseDistance)
	{
		FloorBaseDistance = floorBaseDistance;
		IsOpenFallOffCorrection = true;
	}

	public void OpenFallOffCorrection(bool isOpenFallOffCorrection)
	{
		IsOpenFallOffCorrection = isOpenFallOffCorrection;
	}

	public void SetPosition(Vector3 position, bool bypassInterpolation = true)
	{
		_transform.position = position;
		_initialSimulationPosition = position;
		_transientPosition = position;
		if (bypassInterpolation)
		{
			InitialTickPosition = position;
		}
	}

	public void SetRotation(Quaternion rotation, bool bypassInterpolation = true)
	{
		rotation = Utility.Math.Round(rotation);
		_transform.rotation = rotation;
		_initialSimulationRotation = rotation;
		TransientRotation = rotation;
		if (bypassInterpolation)
		{
			InitialTickRotation = rotation;
		}
	}

	public virtual void SetPositionAndRotation(Vector3 position, Quaternion rotation)
	{
		_transientPosition = position;
		_transform.position = position;
		_transform.rotation = rotation;
	}

	public void TeleportToPoint(Vector3 position, Quaternion rotation)
	{
		_teleportMovement = true;
		BaseVelocity = Vector3.zero;
		SetPositionAndRotation(position, rotation);
		_initialSimulationPosition = position;
		_initialSimulationRotation = rotation;
		_transientPosition = position;
		TransientRotation = rotation;
		LastGroundingStatus.Teleport = true;
		LastGroundingStatus.IsStableOnGround = true;
	}

	public void MoveCharacter(Vector3 toPosition)
	{
		_movePositionDirty = true;
		_movePositionTarget = toPosition;
	}

	public void RotateCharacter(Quaternion toRotation)
	{
		toRotation = Utility.Math.Round(toRotation);
		_moveRotationDirty = true;
		_moveRotationTarget = toRotation;
	}

	public void StackedMoveCharacter(Vector3 toPosition)
	{
		_movePositionDirty = true;
		_movePositionTarget += toPosition;
	}

	public Vector3 GetCurrentMoveDir()
	{
		return (_transientPosition - _initialSimulationPosition).normalized;
	}

	public KinematicCharacterMotorState GetState()
	{
		KinematicCharacterMotorState result = default(KinematicCharacterMotorState);
		result.Position = _transientPosition;
		result.Rotation = _transientRotation;
		result.BaseVelocity = BaseVelocity;
		result.AttachedRigidbodyVelocity = _attachedRigidbodyVelocity;
		result.MustUnground = _mustUnground;
		result.MustUngroundTime = _mustUngroundTimeCounter;
		result.LastMovementIterationFoundAnyGround = LastMovementIterationFoundAnyGround;
		result.GroundingStatus.CopyFrom(GroundingStatus);
		result.AttachedRigidbody = _attachedRigidbody;
		return result;
	}

	private void SetCapsuleDimensions(float radius, float height, float yOffset)
	{
		height = Mathf.Max(height, radius * 2f + 0.01f);
		CapsuleRadius = radius;
		CapsuleHeight = height;
		CapsuleYOffset = yOffset;
		Capsule.radius = CapsuleRadius;
		Capsule.height = Mathf.Clamp(CapsuleHeight, CapsuleRadius * 2f, CapsuleHeight);
		Capsule.center = new Vector3(0f, CapsuleYOffset, 0f);
		_characterTransformToCapsuleCenter = Capsule.center;
		_characterTransformToCapsuleBottom = Capsule.center + -_cachedWorldUp * (Capsule.height * 0.5f);
		_characterTransformToCapsuleTop = Capsule.center + _cachedWorldUp * (Capsule.height * 0.5f);
		_characterTransformToCapsuleBottomHemi = Capsule.center + -_cachedWorldUp * (Capsule.height * 0.5f) + _cachedWorldUp * Capsule.radius;
		_characterTransformToCapsuleTopHemi = Capsule.center + _cachedWorldUp * (Capsule.height * 0.5f) + -_cachedWorldUp * Capsule.radius;
	}

	public abstract void UpdatePhase1(float deltaTime);

	public abstract void UpdatePhase2(float deltaTime);

	protected bool IsStableOnNormal(Vector3 normal)
	{
		return Vector3.Angle(_characterUp, normal) <= MaxStableSlopeAngle;
	}

	protected bool IsStableWithSpecialCases(ref HitStabilityReport stabilityReport, Vector3 velocity)
	{
		if (LedgeAndDenivelationHandling)
		{
			if (stabilityReport.LedgeDetected)
			{
				if (stabilityReport.IsMovingTowardsEmptySideOfLedge && Vector3.Project(velocity, stabilityReport.LedgeFacingDirection).magnitude >= MaxVelocityForLedgeSnap)
				{
					return false;
				}
				if (stabilityReport.IsOnEmptySideOfLedge && stabilityReport.DistanceFromLedge > MaxStableDistanceFromLedge)
				{
					return false;
				}
			}
			if (LastGroundingStatus.FoundAnyGround && stabilityReport.InnerNormal.sqrMagnitude != 0f && stabilityReport.OuterNormal.sqrMagnitude != 0f)
			{
				if (Vector3.Angle(stabilityReport.InnerNormal, stabilityReport.OuterNormal) > MaxStableDenivelationAngle)
				{
					return false;
				}
				if (Vector3.Angle(LastGroundingStatus.InnerGroundNormal, stabilityReport.OuterNormal) > MaxStableDenivelationAngle)
				{
					return false;
				}
			}
		}
		return true;
	}

	protected void ProbeGround(ref Vector3 probingPosition, Quaternion atRotation, float probingDistance, ref CharacterGroundingReport groundingReport)
	{
		//IL_0013: Unknown result type (might be due to invalid IL or missing references)
		if (probingDistance < 0.005f)
		{
			probingDistance = 0.005f;
		}
		int num = 0;
		RaycastHit closestHit = default(RaycastHit);
		bool flag = false;
		Vector3 vector = probingPosition;
		Vector3 vector2 = atRotation * -_cachedWorldUp;
		float num2 = probingDistance;
		while (num2 > 0f && num <= 2 && !flag)
		{
			if (CharacterGroundSweep(vector, atRotation, vector2, num2, out closestHit))
			{
				Vector3 atCharacterPosition = vector + vector2 * ((RaycastHit)(ref closestHit)).distance;
				HitStabilityReport stabilityReport = default(HitStabilityReport);
				EvaluateHitStability(((RaycastHit)(ref closestHit)).collider, ((RaycastHit)(ref closestHit)).normal, ((RaycastHit)(ref closestHit)).point, atCharacterPosition, _transientRotation, BaseVelocity, ref stabilityReport);
				groundingReport.FoundAnyGround = true;
				groundingReport.GroundNormal = ((RaycastHit)(ref closestHit)).normal;
				groundingReport.InnerGroundNormal = stabilityReport.InnerNormal;
				groundingReport.OuterGroundNormal = stabilityReport.OuterNormal;
				groundingReport.GroundCollider = ((RaycastHit)(ref closestHit)).collider;
				groundingReport.GroundPoint = ((RaycastHit)(ref closestHit)).point;
				groundingReport.SnappingPrevented = false;
				if (stabilityReport.IsStable)
				{
					groundingReport.SnappingPrevented = !IsStableWithSpecialCases(ref stabilityReport, BaseVelocity);
					groundingReport.IsStableOnGround = true;
					if (!groundingReport.SnappingPrevented)
					{
						probingPosition = vector + vector2 * (((RaycastHit)(ref closestHit)).distance - 0.01f);
					}
					CharacterController.OnGroundHit(((RaycastHit)(ref closestHit)).collider, ((RaycastHit)(ref closestHit)).normal, ((RaycastHit)(ref closestHit)).point, ref stabilityReport);
					flag = true;
				}
				else
				{
					Vector3 vector3 = vector2 * ((RaycastHit)(ref closestHit)).distance + atRotation * _cachedWorldUp * Mathf.Max(0.01f, ((RaycastHit)(ref closestHit)).distance);
					vector += vector3;
					num2 = Mathf.Min(0.02f, Mathf.Max(num2 - vector3.magnitude, 0f));
					vector2 = Vector3.ProjectOnPlane(vector2, ((RaycastHit)(ref closestHit)).normal).normalized;
				}
			}
			else
			{
				flag = true;
			}
			num++;
		}
	}

	public void ForceUnground(float time = 0.1f)
	{
		_mustUnground = true;
		_mustUngroundTimeCounter = time;
	}

	public bool MustUnground()
	{
		if (!_mustUnground)
		{
			return _mustUngroundTimeCounter > 0f;
		}
		return true;
	}

	public Vector3 GetDirectionTangentToSurface(Vector3 direction, Vector3 surfaceNormal)
	{
		Vector3 rhs = Vector3.Cross(direction, _characterUp);
		return Vector3.Cross(surfaceNormal, rhs).normalized;
	}

	protected abstract bool InternalCharacterMove(ref Vector3 transientVelocity, float deltaTime);

	protected Vector3 GetObstructionNormal(Vector3 hitNormal, bool stableOnHit)
	{
		Vector3 vector = hitNormal;
		if (GroundingStatus.IsStableOnGround && !MustUnground() && !stableOnHit)
		{
			vector = Vector3.Cross(Vector3.Cross(GroundingStatus.GroundNormal, vector).normalized, _characterUp).normalized;
		}
		if (vector.sqrMagnitude == 0f)
		{
			vector = hitNormal;
		}
		return vector;
	}

	protected void StoreRigidbodyHit(Rigidbody hitRigidbody, Vector3 hitVelocity, Vector3 hitPoint, Vector3 obstructionNormal, HitStabilityReport hitStabilityReport)
	{
		if (_rigidbodyProjectionHitCount < _internalRigidbodyProjectionHits.Length && ((Component)(object)hitRigidbody).TryGetComponent(out EntityView component) && component.Entity.GetComponent<KinematicMoveComponent>() == null)
		{
			RigidbodyProjectionHit rigidbodyProjectionHit = new RigidbodyProjectionHit
			{
				Rigidbody = hitRigidbody,
				HitPoint = hitPoint,
				EffectiveHitNormal = obstructionNormal,
				HitVelocity = hitVelocity,
				StableOnHit = hitStabilityReport.IsStable
			};
			_internalRigidbodyProjectionHits[_rigidbodyProjectionHitCount] = rigidbodyProjectionHit;
			_rigidbodyProjectionHitCount++;
		}
	}

	public void SetTransientPosition(Vector3 newPos)
	{
		_transientPosition = newPos;
	}

	protected void InternalHandleVelocityProjection(bool stableOnHit, Vector3 hitNormal, Vector3 obstructionNormal, Vector3 originalDirection, ref MovementSweepState sweepState, bool previousHitIsStable, Vector3 previousVelocity, Vector3 previousObstructionNormal, ref Vector3 transientVelocity, ref float remainingMovementMagnitude, ref Vector3 remainingMovementDirection)
	{
		if (transientVelocity.sqrMagnitude <= 0f)
		{
			return;
		}
		Vector3 vector = transientVelocity;
		if (stableOnHit)
		{
			LastMovementIterationFoundAnyGround = true;
			HandleVelocityProjection(ref transientVelocity, obstructionNormal, stableOnHit);
		}
		else if (sweepState == MovementSweepState.Initial)
		{
			HandleVelocityProjection(ref transientVelocity, obstructionNormal, stableOnHit);
			sweepState = MovementSweepState.AfterFirstHit;
		}
		else if (sweepState == MovementSweepState.AfterFirstHit)
		{
			EvaluateCrease(transientVelocity, previousVelocity, obstructionNormal, previousObstructionNormal, stableOnHit, previousHitIsStable, GroundingStatus.IsStableOnGround && !MustUnground(), out var isValidCrease, out var creaseDirection);
			if (isValidCrease)
			{
				if (GroundingStatus.IsStableOnGround && !MustUnground())
				{
					transientVelocity = Vector3.zero;
					sweepState = MovementSweepState.FoundBlockingCorner;
				}
				else
				{
					transientVelocity = Vector3.Project(transientVelocity, creaseDirection);
					sweepState = MovementSweepState.FoundBlockingCrease;
				}
			}
			else
			{
				HandleVelocityProjection(ref transientVelocity, obstructionNormal, stableOnHit);
			}
		}
		else if (sweepState == MovementSweepState.FoundBlockingCrease)
		{
			transientVelocity = Vector3.zero;
			sweepState = MovementSweepState.FoundBlockingCorner;
		}
		if (HasPlanarConstraint)
		{
			transientVelocity = Vector3.ProjectOnPlane(transientVelocity, PlanarConstraintAxis.normalized);
		}
		float num = transientVelocity.magnitude / vector.magnitude;
		remainingMovementMagnitude *= num;
		remainingMovementDirection = transientVelocity.normalized;
	}

	private void EvaluateCrease(Vector3 currentCharacterVelocity, Vector3 previousCharacterVelocity, Vector3 currentHitNormal, Vector3 previousHitNormal, bool currentHitIsStable, bool previousHitIsStable, bool characterIsStable, out bool isValidCrease, out Vector3 creaseDirection)
	{
		isValidCrease = false;
		creaseDirection = default(Vector3);
		if (characterIsStable && currentHitIsStable && previousHitIsStable)
		{
			return;
		}
		Vector3 vector = Vector3.Cross(currentHitNormal, previousHitNormal).normalized;
		float num = Vector3.Dot(currentHitNormal, previousHitNormal);
		bool flag = false;
		if (num < 0.999f)
		{
			Vector3 normalized = Vector3.ProjectOnPlane(currentHitNormal, vector).normalized;
			Vector3 normalized2 = Vector3.ProjectOnPlane(previousHitNormal, vector).normalized;
			float num2 = Vector3.Dot(normalized, normalized2);
			Vector3 normalized3 = Vector3.ProjectOnPlane(previousCharacterVelocity, vector).normalized;
			if (num2 <= Vector3.Dot(-normalized3, normalized) + 0.001f && num2 <= Vector3.Dot(-normalized3, normalized2) + 0.001f)
			{
				flag = true;
			}
		}
		if (flag)
		{
			if (Vector3.Dot(vector, currentCharacterVelocity) < 0f)
			{
				vector = -vector;
			}
			isValidCrease = true;
			creaseDirection = vector;
		}
	}

	public virtual void HandleVelocityProjection(ref Vector3 velocity, Vector3 obstructionNormal, bool stableOnHit)
	{
		if (GroundingStatus.IsStableOnGround && !MustUnground())
		{
			if (stableOnHit)
			{
				velocity = GetDirectionTangentToSurface(velocity, obstructionNormal) * velocity.magnitude;
				return;
			}
			Vector3 normalized = Vector3.Cross(Vector3.Cross(obstructionNormal, GroundingStatus.GroundNormal).normalized, obstructionNormal).normalized;
			velocity = GetDirectionTangentToSurface(velocity, normalized) * velocity.magnitude;
			velocity = Vector3.ProjectOnPlane(velocity, obstructionNormal);
		}
		else if (stableOnHit)
		{
			velocity = Vector3.ProjectOnPlane(velocity, CharacterUp);
			velocity = GetDirectionTangentToSurface(velocity, obstructionNormal) * velocity.magnitude;
		}
		else
		{
			velocity = Vector3.ProjectOnPlane(velocity, obstructionNormal);
		}
	}

	public virtual void HandleSimulatedRigidbodyInteraction(ref Vector3 processedVelocity, RigidbodyProjectionHit hit, float deltaTime)
	{
	}

	protected void ProcessVelocityForRigidbodyHits(ref Vector3 processedVelocity, float deltaTime)
	{
		for (int i = 0; i < _rigidbodyProjectionHitCount; i++)
		{
			RigidbodyProjectionHit hit = _internalRigidbodyProjectionHits[i];
			if (!(Object)(object)hit.Rigidbody || _rigidbodiesPushedThisMove.Contains(hit.Rigidbody) || !((Object)(object)_internalRigidbodyProjectionHits[i].Rigidbody != (Object)(object)_attachedRigidbody))
			{
				continue;
			}
			_rigidbodiesPushedThisMove.Add(hit.Rigidbody);
			float simulatedCharacterMass = SimulatedCharacterMass;
			Vector3 hitVelocity = hit.HitVelocity;
			if (!((Component)(object)hit.Rigidbody).TryGetComponent(out EntityView component))
			{
				continue;
			}
			KinematicMoveComponent component2 = component.Entity.GetComponent<KinematicMoveComponent>();
			if (component2 != null)
			{
				MovementMotorBase motor = component2.GetMotor();
				bool flag = motor != null;
				bool flag2 = !hit.Rigidbody.isKinematic;
				float num = hit.Rigidbody.mass;
				Vector3 bodyVelocity = hit.Rigidbody.velocity;
				PhysicsMover component3;
				if (flag)
				{
					_ = motor.SimulatedCharacterMass;
					num = motor.SimulatedCharacterMass;
					bodyVelocity = motor.BaseVelocity;
				}
				else if (!flag2 && ((Component)(object)hit.Rigidbody).TryGetComponent(out component3))
				{
					bodyVelocity = component3.Velocity;
				}
				float num2 = 1f;
				num2 = ((!(simulatedCharacterMass + num > 0f)) ? 0.5f : (simulatedCharacterMass / (simulatedCharacterMass + num)));
				if (!flag2)
				{
					num2 = 0f;
				}
				else if (RigidbodyInteractionType == RigidbodyInteractionType.Kinematic && !flag)
				{
					num2 = 1f;
				}
				ComputeCollisionResolutionForHitBody(hit.EffectiveHitNormal, hitVelocity, bodyVelocity, num2, out var velocityChangeOnCharacter, out var velocityChangeOnBody);
				processedVelocity += velocityChangeOnCharacter;
				if (flag)
				{
					motor.BaseVelocity += velocityChangeOnCharacter;
				}
				else if (flag2)
				{
					hit.Rigidbody.AddForceAtPosition(velocityChangeOnBody, hit.HitPoint, (ForceMode)2);
				}
				if (RigidbodyInteractionType == RigidbodyInteractionType.SimulatedDynamic)
				{
					HandleSimulatedRigidbodyInteraction(ref processedVelocity, hit, deltaTime);
				}
			}
		}
	}

	public void ComputeCollisionResolutionForHitBody(Vector3 hitNormal, Vector3 characterVelocity, Vector3 bodyVelocity, float characterToBodyMassRatio, out Vector3 velocityChangeOnCharacter, out Vector3 velocityChangeOnBody)
	{
		velocityChangeOnCharacter = default(Vector3);
		velocityChangeOnBody = default(Vector3);
		float num = 1f - characterToBodyMassRatio;
		float num2 = Vector3.Dot(characterVelocity, hitNormal);
		float num3 = Vector3.Dot(bodyVelocity, hitNormal);
		if (num2 < 0f)
		{
			Vector3 vector = hitNormal * num2;
			velocityChangeOnCharacter += vector;
		}
		if (num3 > num2)
		{
			Vector3 vector2 = hitNormal * (num3 - num2);
			velocityChangeOnCharacter += vector2 * num;
			velocityChangeOnBody += -vector2 * characterToBodyMassRatio;
		}
	}

	protected bool CheckIfColliderValidForCollisions(Collider coll)
	{
		if ((Object)(object)coll == (Object)(object)Capsule)
		{
			return false;
		}
		if (!InternalIsColliderValidForCollisions(coll))
		{
			return false;
		}
		return true;
	}

	protected abstract bool InternalIsColliderValidForCollisions(Collider coll);

	protected abstract bool InternalIsColliderValidForGroundCollisions(Collider coll, RaycastHit hit);

	public void EvaluateHitStability(Collider hitCollider, Vector3 hitNormal, Vector3 hitPoint, Vector3 atCharacterPosition, Quaternion atCharacterRotation, Vector3 withCharacterVelocity, ref HitStabilityReport stabilityReport)
	{
		if (!_solveGrounding)
		{
			stabilityReport.IsStable = false;
			return;
		}
		Vector3 vector = atCharacterRotation * _cachedWorldUp;
		Vector3 normalized = Vector3.ProjectOnPlane(hitNormal, vector).normalized;
		stabilityReport.IsStable = IsStableOnNormal(hitNormal);
		stabilityReport.FoundInnerNormal = false;
		stabilityReport.FoundOuterNormal = false;
		stabilityReport.InnerNormal = hitNormal;
		stabilityReport.OuterNormal = hitNormal;
		if (LedgeAndDenivelationHandling)
		{
			float num = 0.05f;
			if (StepHandling != StepHandlingMethod.None)
			{
				num = MaxStepHeight;
			}
			bool flag = false;
			bool flag2 = false;
			if (CharacterCollisionsRaycast(hitPoint + vector * 0.02f + normalized * 0.001f, -vector, num + 0.02f, out var closestHit, _internalCharacterHits) > 0)
			{
				Vector3 normal = (stabilityReport.InnerNormal = ((RaycastHit)(ref closestHit)).normal);
				stabilityReport.FoundInnerNormal = true;
				flag = IsStableOnNormal(normal);
			}
			if (CharacterCollisionsRaycast(hitPoint + vector * 0.02f + -normalized * 0.001f, -vector, num + 0.02f, out var closestHit2, _internalCharacterHits) > 0)
			{
				Vector3 normal2 = (stabilityReport.OuterNormal = ((RaycastHit)(ref closestHit2)).normal);
				stabilityReport.FoundOuterNormal = true;
				flag2 = IsStableOnNormal(normal2);
			}
			stabilityReport.LedgeDetected = flag != flag2;
			if (stabilityReport.LedgeDetected)
			{
				stabilityReport.IsOnEmptySideOfLedge = flag2 && !flag;
				stabilityReport.LedgeGroundNormal = (flag2 ? stabilityReport.OuterNormal : stabilityReport.InnerNormal);
				stabilityReport.LedgeRightDirection = Vector3.Cross(hitNormal, stabilityReport.LedgeGroundNormal).normalized;
				stabilityReport.LedgeFacingDirection = Vector3.ProjectOnPlane(Vector3.Cross(stabilityReport.LedgeGroundNormal, stabilityReport.LedgeRightDirection), CharacterUp).normalized;
				stabilityReport.DistanceFromLedge = Vector3.ProjectOnPlane(hitPoint - (atCharacterPosition + atCharacterRotation * _characterTransformToCapsuleBottom), vector).magnitude;
				stabilityReport.IsMovingTowardsEmptySideOfLedge = Vector3.Dot(withCharacterVelocity.normalized, stabilityReport.LedgeFacingDirection) > 0f;
			}
			if (stabilityReport.IsStable)
			{
				stabilityReport.IsStable = IsStableWithSpecialCases(ref stabilityReport, withCharacterVelocity);
			}
		}
		if (StepHandling != StepHandlingMethod.None && !stabilityReport.IsStable)
		{
			Rigidbody attachedRigidbody = hitCollider.attachedRigidbody;
			if (!(Object)(object)attachedRigidbody || attachedRigidbody.isKinematic)
			{
				DetectSteps(atCharacterPosition, atCharacterRotation, hitPoint, normalized, ref stabilityReport);
				if (stabilityReport.ValidStepDetected)
				{
					stabilityReport.IsStable = true;
				}
			}
		}
		CharacterController.ProcessHitStabilityReport(hitCollider, hitNormal, hitPoint, atCharacterPosition, atCharacterRotation, ref stabilityReport);
	}

	private void DetectSteps(Vector3 characterPosition, Quaternion characterRotation, Vector3 hitPoint, Vector3 innerHitDirection, ref HitStabilityReport stabilityReport)
	{
		int num = 0;
		Vector3 vector = characterRotation * _cachedWorldUp;
		Vector3 vector2 = Vector3.Project(hitPoint - characterPosition, vector);
		Vector3 normalized = Vector3.ProjectOnPlane(hitPoint - characterPosition, vector).normalized;
		Vector3 vector3 = hitPoint - vector2 + vector * MaxStepHeight + normalized * 0.01f * 3f;
		num = CharacterCollisionsSweep(vector3, characterRotation, -vector, MaxStepHeight + 0.01f, out var closestHit, _internalCharacterHits, 0f, acceptOnlyStableGroundLayer: true);
		if (CheckStepValidity(num, characterPosition, characterRotation, innerHitDirection, vector3, out var hitCollider))
		{
			stabilityReport.ValidStepDetected = true;
			stabilityReport.SteppedCollider = hitCollider;
		}
		if (StepHandling == StepHandlingMethod.Extra && !stabilityReport.ValidStepDetected)
		{
			vector3 = characterPosition + vector * MaxStepHeight + -innerHitDirection * MinRequiredStepDepth;
			num = CharacterCollisionsSweep(vector3, characterRotation, -vector, MaxStepHeight - 0.01f, out closestHit, _internalCharacterHits, 0f, acceptOnlyStableGroundLayer: true);
			if (CheckStepValidity(num, characterPosition, characterRotation, innerHitDirection, vector3, out hitCollider))
			{
				stabilityReport.ValidStepDetected = true;
				stabilityReport.SteppedCollider = hitCollider;
			}
		}
	}

	private bool CheckStepValidity(int nbStepHits, Vector3 characterPosition, Quaternion characterRotation, Vector3 innerHitDirection, Vector3 stepCheckStartPos, out Collider hitCollider)
	{
		//IL_0019: Unknown result type (might be due to invalid IL or missing references)
		//IL_0051: Unknown result type (might be due to invalid IL or missing references)
		//IL_0056: Unknown result type (might be due to invalid IL or missing references)
		//IL_0201: Unknown result type (might be due to invalid IL or missing references)
		//IL_0206: Unknown result type (might be due to invalid IL or missing references)
		hitCollider = null;
		Vector3 vector = characterRotation * Vector3.up;
		bool flag = false;
		while (nbStepHits > 0 && !flag)
		{
			RaycastHit val = default(RaycastHit);
			float num = 0f;
			int num2 = 0;
			for (int i = 0; i < nbStepHits; i++)
			{
				float distance = ((RaycastHit)(ref _internalCharacterHits[i])).distance;
				if (distance > num)
				{
					num = distance;
					val = _internalCharacterHits[i];
					num2 = i;
				}
			}
			Vector3 vector2 = stepCheckStartPos + -vector * (((RaycastHit)(ref val)).distance - 0.01f);
			if (CharacterCollisionsOverlap(vector2, characterRotation, _internalProbedColliders) <= 0 && CharacterCollisionsRaycast(((RaycastHit)(ref val)).point + vector * 0.02f + -innerHitDirection * 0.001f, -vector, MaxStepHeight + 0.02f, out var closestHit, _internalCharacterHits, acceptOnlyStableGroundLayer: true) > 0 && IsStableOnNormal(((RaycastHit)(ref closestHit)).normal) && CharacterCollisionsSweep(characterPosition, characterRotation, vector, MaxStepHeight - ((RaycastHit)(ref val)).distance, out var _, _internalCharacterHits) <= 0)
			{
				bool flag2 = false;
				RaycastHit closestHit3;
				if (AllowSteppingWithoutStableGrounding)
				{
					flag2 = true;
				}
				else if (CharacterCollisionsRaycast(characterPosition + Vector3.Project(vector2 - characterPosition, vector), -vector, MaxStepHeight, out closestHit3, _internalCharacterHits, acceptOnlyStableGroundLayer: true) > 0 && IsStableOnNormal(((RaycastHit)(ref closestHit3)).normal))
				{
					flag2 = true;
				}
				if (!flag2 && CharacterCollisionsRaycast(((RaycastHit)(ref val)).point + innerHitDirection * 0.001f, -vector, MaxStepHeight, out closestHit3, _internalCharacterHits, acceptOnlyStableGroundLayer: true) > 0 && IsStableOnNormal(((RaycastHit)(ref closestHit3)).normal))
				{
					flag2 = true;
				}
				if (flag2)
				{
					hitCollider = ((RaycastHit)(ref val)).collider;
					flag = true;
					return true;
				}
			}
			if (!flag)
			{
				nbStepHits--;
				if (num2 < nbStepHits)
				{
					_internalCharacterHits[num2] = _internalCharacterHits[nbStepHits];
				}
			}
		}
		return false;
	}

	public void GetVelocityFromRigidbodyMovement(Rigidbody interactiveRigidbody, Vector3 atPoint, float deltaTime, out Vector3 linearVelocity, out Vector3 angularVelocity)
	{
		if (deltaTime > 0f)
		{
			linearVelocity = interactiveRigidbody.velocity;
			angularVelocity = interactiveRigidbody.angularVelocity;
			if (interactiveRigidbody.isKinematic && ((Component)(object)interactiveRigidbody).TryGetComponent(out PhysicsMover component))
			{
				linearVelocity = component.Velocity;
				angularVelocity = component.AngularVelocity;
			}
			if (angularVelocity != Vector3.zero)
			{
				Vector3 vector = ((Component)(object)interactiveRigidbody).transform.TransformPoint(interactiveRigidbody.centerOfMass);
				Vector3 vector2 = atPoint - vector;
				Quaternion quaternion = Quaternion.Euler(57.29578f * angularVelocity * deltaTime);
				Vector3 vector3 = vector + quaternion * vector2;
				linearVelocity += (vector3 - atPoint) / deltaTime;
			}
		}
		else
		{
			linearVelocity = default(Vector3);
			angularVelocity = default(Vector3);
		}
	}

	protected Rigidbody GetInteractiveRigidbody(Collider onCollider)
	{
		Rigidbody attachedRigidbody = onCollider.attachedRigidbody;
		if ((bool)(Object)(object)attachedRigidbody)
		{
			if (((Component)(object)attachedRigidbody).gameObject.TryGetComponent<PhysicsMover>(out var _))
			{
				return attachedRigidbody;
			}
			if (!attachedRigidbody.isKinematic)
			{
				return attachedRigidbody;
			}
		}
		return null;
	}

	public Vector3 GetVelocityForMovePosition(Vector3 fromPosition, Vector3 toPosition, float deltaTime)
	{
		return GetVelocityFromMovement(toPosition - fromPosition, deltaTime);
	}

	public Vector3 GetVelocityFromMovement(Vector3 movement, float deltaTime)
	{
		if (deltaTime <= 0f)
		{
			return Vector3.zero;
		}
		return movement / deltaTime;
	}

	private void RestrictVectorToPlane(ref Vector3 vector, Vector3 toPlane)
	{
		if (vector.x > 0f != toPlane.x > 0f)
		{
			vector.x = 0f;
		}
		if (vector.y > 0f != toPlane.y > 0f)
		{
			vector.y = 0f;
		}
		if (vector.z > 0f != toPlane.z > 0f)
		{
			vector.z = 0f;
		}
	}

	public abstract int CharacterCollisionsOverlap(Vector3 position, Quaternion rotation, Collider[] overlappedColliders, float inflate = 0f, bool acceptOnlyStableGroundLayer = false);

	public int CharacterOverlap(Vector3 position, Quaternion rotation, Collider[] overlappedColliders, LayerMask layers, QueryTriggerInteraction triggerInteraction, float inflate = 0f)
	{
		//IL_008c: Unknown result type (might be due to invalid IL or missing references)
		Vector3 vector = position + rotation * _characterTransformToCapsuleBottomHemi;
		Vector3 vector2 = position + rotation * _characterTransformToCapsuleTopHemi;
		if (inflate != 0f)
		{
			vector += rotation * Vector3.down * inflate;
			vector2 += rotation * Vector3.up * inflate;
		}
		int num = 0;
		ref PhysicsScene reference = ref physicsScene;
		Vector3 vector3 = vector;
		Vector3 vector4 = vector2;
		CapsuleCollider capsule = Capsule;
		for (int num2 = (num = ((PhysicsScene)(ref reference)).OverlapCapsule(vector3, vector4, (capsule != null) ? capsule.radius : (0f + inflate), overlappedColliders, (int)layers, triggerInteraction)) - 1; num2 >= 0; num2--)
		{
			if ((Object)(object)overlappedColliders[num2] == (Object)(object)Capsule)
			{
				num--;
				if (num2 < num)
				{
					overlappedColliders[num2] = overlappedColliders[num];
				}
			}
		}
		return num;
	}

	public abstract int CharacterCollisionsSweep(Vector3 position, Quaternion rotation, Vector3 direction, float distance, out RaycastHit closestHit, RaycastHit[] hits, float inflate = 0f, bool acceptOnlyStableGroundLayer = false);

	public int CharacterSweep(Vector3 position, Quaternion rotation, Vector3 direction, float distance, out RaycastHit closestHit, RaycastHit[] hits, LayerMask layers, QueryTriggerInteraction triggerInteraction, float inflate = 0f)
	{
		//IL_0002: Unknown result type (might be due to invalid IL or missing references)
		//IL_0098: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b1: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b6: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ea: Unknown result type (might be due to invalid IL or missing references)
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_0106: Unknown result type (might be due to invalid IL or missing references)
		//IL_0108: Unknown result type (might be due to invalid IL or missing references)
		closestHit = default(RaycastHit);
		Vector3 vector = position + rotation * _characterTransformToCapsuleBottomHemi;
		Vector3 vector2 = position + rotation * _characterTransformToCapsuleTopHemi;
		if (inflate != 0f)
		{
			vector += rotation * Vector3.down * inflate;
			vector2 += rotation * Vector3.up * inflate;
		}
		int num = 0;
		ref PhysicsScene reference = ref physicsScene;
		Vector3 vector3 = vector;
		Vector3 vector4 = vector2;
		CapsuleCollider capsule = Capsule;
		int num2 = ((PhysicsScene)(ref reference)).CapsuleCast(vector3, vector4, (capsule != null) ? capsule.radius : (0f + inflate), direction, hits, distance, (int)layers, triggerInteraction);
		float num3 = float.PositiveInfinity;
		num = num2;
		for (int num4 = num2 - 1; num4 >= 0; num4--)
		{
			RaycastHit val = hits[num4];
			if (((RaycastHit)(ref val)).distance <= 0f || (Object)(object)((RaycastHit)(ref val)).collider == (Object)(object)Capsule)
			{
				num--;
				if (num4 < num)
				{
					hits[num4] = hits[num];
				}
			}
			else
			{
				float distance2 = ((RaycastHit)(ref val)).distance;
				if (distance2 < num3)
				{
					closestHit = val;
					num3 = distance2;
				}
			}
		}
		return num;
	}

	protected abstract bool CharacterGroundSweep(Vector3 position, Quaternion rotation, Vector3 direction, float distance, out RaycastHit closestHit);

	public abstract int CharacterCollisionsRaycast(Vector3 position, Vector3 direction, float distance, out RaycastHit closestHit, RaycastHit[] hits, bool acceptOnlyStableGroundLayer = false);

	protected bool IsGroundCollider(Collider collider)
	{
		if (((Component)(object)collider).gameObject.layer == LayerMask.NameToLayer("Ground"))
		{
			return true;
		}
		return false;
	}
}
