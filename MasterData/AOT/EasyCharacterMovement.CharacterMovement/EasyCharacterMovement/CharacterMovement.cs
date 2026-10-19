using System;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

namespace EasyCharacterMovement;

[RequireComponent(typeof(Rigidbody), typeof(CapsuleCollider))]
public sealed class CharacterMovement : MonoBehaviour
{
	private enum DepenetrationBehavior
	{
		IgnoreNone = 0,
		IgnoreStatic = 1,
		IgnoreDynamic = 2,
		IgnoreKinematic = 4
	}

	[Serializable]
	public struct Advanced
	{
		[Tooltip("The minimum move distance of the character controller. If the character tries to move less than this distance, it will not move at all. This can be used to reduce jitter. In most situations this value should be left at 0.")]
		public float minMoveDistance;

		[Tooltip("Max number of iterations used during movement.")]
		public int maxMovementIterations;

		[Tooltip("Max number of iterations used to resolve penetrations.")]
		public int maxDepenetrationIterations;

		[Tooltip("If enabled, the character will move with the moving platform it is standing on.")]
		public bool impartPlatformMovement;

		public float minMoveDistanceSqr => minMoveDistance * minMoveDistance;

		public void Reset()
		{
			minMoveDistance = 0f;
			maxMovementIterations = 5;
			maxDepenetrationIterations = 1;
			impartPlatformMovement = false;
		}

		public void OnValidate()
		{
			minMoveDistance = Mathf.Max(minMoveDistance, 0f);
			maxMovementIterations = Mathf.Max(maxMovementIterations, 1);
			maxDepenetrationIterations = Mathf.Max(maxDepenetrationIterations, 1);
		}
	}

	public struct MovingPlatform
	{
		public Rigidbody lastPlatform;

		public Rigidbody platform;

		public IMovingPlatformSource platformSource;

		public Collider platformSourceCollider;

		public Vector3 position;

		public Vector3 localPosition;

		public Quaternion rotation;

		public Quaternion localRotation;

		public Vector3 platformVelocity;
	}

	public readonly struct State(Vector3 position, Quaternion rotation, Vector3 velocity, bool isConstrainedToGround, float unconstrainedTimer, bool hitGround, bool isWalkable, Vector3 groundNormal)
	{
		public Vector3 position { get; } = position;

		public Quaternion rotation { get; } = rotation;

		public Vector3 velocity { get; } = velocity;

		public bool isConstrainedToGround { get; } = isConstrainedToGround;

		public float unconstrainedTimer { get; } = unconstrainedTimer;

		public bool hitGround { get; } = hitGround;

		public bool isWalkable { get; } = isWalkable;

		public Vector3 groundNormal { get; } = groundNormal;
	}

	public delegate void GroundColliderChange(FindGroundResult result);

	public delegate bool SweepColliderCallBack(Collider collider);

	public delegate bool ColliderFilterCallback(Collider collider);

	public delegate CollisionBehavior CollisionBehaviorCallback(Collider collider);

	public delegate void CollisionResponseCallback(ref CollisionResult inCollisionResult, ref Vector3 characterImpulse, ref Vector3 otherImpulse);

	public delegate void CollisionOverlapCallback(Collider[] overlaps, int overlapCount, int depenetrationIterations);

	public delegate void CollidedEventHandler(ref CollisionResult collisionResult);

	public delegate void FoundGroundEventHandler(ref FindGroundResult foundGround);

	private const float kKindaSmallNumber = 0.0001f;

	private const float kHemisphereLimit = 0.01f;

	private const int kMaxCollisionCount = 8;

	private const int kMaxOverlapCount = 8;

	private const float kSweepEdgeRejectDistance = 0.0015f;

	private const float kMinGroundDistance = 0.019f;

	private const float kMaxGroundDistance = 0.024f;

	private const float kAvgGroundDistance = 0.021499999f;

	private const float kTryDownMoveDistance = 0.2f;

	private const float kTryDownMoveClimbDistance = 0.8f;

	private const float kMinWalkableSlopeLimit = 1f;

	private const float kMaxWalkableSlopeLimit = 0.017452f;

	private const float kPenetrationOffset = 0.00125f;

	private const float kContactOffset = 0.01f;

	private const float kSmallContactOffset = 0.001f;

	private const float kCliffSupportRadius = 0.02f;

	private const float kCliffSupportSlop = 0.01f;

	private const int kCliffClipIterations = 8;

	private const float kCliffCapsuleEdgeSlack = 0.1f;

	[Space(15f)]
	[Tooltip("Allow to constrain the Character so movement along the locked axis is not possible.")]
	[SerializeField]
	private PlaneConstraint _planeConstraint;

	[Space(15f)]
	[SerializeField]
	[Tooltip("The root transform in the avatar.")]
	private Transform _rootTransform;

	[SerializeField]
	private float _dodgeAssistOffset;

	[SerializeField]
	private float _jumpAssistOffset = 0.5f;

	[SerializeField]
	private float _climbCompensateAssistMinOffset = 1f;

	[SerializeField]
	private float _climbCompensateAssistOffset = 1.5f;

	[SerializeField]
	[Tooltip("The root transform will be positioned at this offset from foot position.")]
	private Vector3 _rootTransformOffset = new Vector3(0f, 0f, 0f);

	[Space(15f)]
	[Tooltip("The Character's capsule collider radius.")]
	[SerializeField]
	private float _radius;

	[Tooltip("The Character's capsule collider height")]
	[SerializeField]
	private float _height;

	[Space(15f)]
	[Tooltip("The maximum angle (in degrees) for a walkable surface.")]
	[SerializeField]
	private float _slopeLimit;

	[Tooltip("The maximum height (in meters) for a valid step (up to Character's height).")]
	[SerializeField]
	private float _stepOffset;

	[Tooltip("Allow a Character to perch on the edge of a surface if the horizontal distance from the Character's position to the edge is closer than this.\nNote that characters will not fall off if they are within stepOffset of a walkable surface below.")]
	[SerializeField]
	private float _perchOffset;

	[Tooltip("When perching on a ledge, add this additional distance to stepOffset when determining how high above a walkable ground we can perch.\nNote that we still enforce stepOffset to start the step up, this just allows the Character to hang off the edge or step slightly higher off the ground.")]
	[SerializeField]
	private float _perchAdditionalHeight;

	[SerializeField]
	private float _ladderOffset = 1.5f;

	[Space(15f)]
	[Tooltip("If enabled, colliders with SlopeLimitBehavior component will be able to override this slope limit.")]
	[SerializeField]
	private bool _slopeLimitOverride;

	[Tooltip("When enabled, will treat head collisions as if the character is using a shape with a flat top.")]
	[SerializeField]
	private bool _useFlatTop;

	[Tooltip("Performs ground checks as if the character is using a shape with a flat base.This avoids the situation where characters slowly lower off the side of a ledge (as their capsule 'balances' on the edge).")]
	[SerializeField]
	private bool _useFlatBaseForGroundChecks;

	[Space(15f)]
	[Tooltip("Character collision layers mask.")]
	[SerializeField]
	private LayerMask _collisionLayers = 1;

	[Tooltip("当辅助攀爬(dir != zero)时，忽略这些层上方（头顶/Above）的碰撞，例如 jumpdown 层。")]
	[SerializeField]
	private LayerMask _jumpDownIgnoreLayerMask = 0;

	[Tooltip("Overrides the global Physics.queriesHitTriggers to specify whether queries (raycasts, spherecasts, overlap tests, etc.) hit Triggers by default. Use Ignore for queries to ignore trigger Colliders.")]
	[SerializeField]
	private QueryTriggerInteraction _triggerInteraction = QueryTriggerInteraction.Ignore;

	[Space(15f)]
	[SerializeField]
	private Advanced _advanced;

	private Transform _transform;

	private Rigidbody _rigidbody;

	private CapsuleCollider _capsuleCollider;

	private Vector3 _capsuleCenter;

	private Vector3 _capsuleTopCenter;

	private Vector3 _capsuleBottomCenter;

	private readonly HashSet<Rigidbody> _ignoredRigidbodies = new HashSet<Rigidbody>();

	private readonly HashSet<Collider> _ignoredColliders = new HashSet<Collider>();

	private readonly Comparison<RaycastHit> _comparison = Compare;

	private readonly RaycastHit[] _hits = new RaycastHit[8];

	private readonly Collider[] _overlaps = new Collider[8];

	private readonly Collider[] _collisionOverlap = new Collider[8];

	private int _collisionCount;

	private readonly CollisionResult[] _collisionResults = new CollisionResult[8];

	[SerializeField]
	[HideInInspector]
	private float _minSlopeLimit;

	private bool _detectCollisions = true;

	private bool _isConstrainedToGround = true;

	private float _unconstrainedTimer;

	private Vector3 _constraintPlaneNormal;

	private Vector3 _characterUp;

	private Vector3 _transformedCapsuleCenter;

	private Vector3 _transformedCapsuleTopCenter;

	private Vector3 _transformedCapsuleBottomCenter;

	private Vector3 _velocity;

	private Vector3 _pendingForces;

	private Vector3 _pendingImpulses;

	private Vector3 _pendingLaunchVelocity;

	private float _pushForceScale = 1f;

	private bool _hasLanded;

	private FindGroundResult _foundGround;

	private FindGroundResult _currentGround;

	private Rigidbody _parentPlatform;

	private MovingPlatform _movingPlatform;

	public Action<bool> detectCollisionsAction;

	public bool isWallClimb;

	private float _climbSnapReferenceY;

	private bool _hasClimbSnapReference;

	private float _perchRadiusOverride = -1f;

	private Vector3 computePosition = Vector3.zero;

	private int collisionOverlapCount;

	public float ladderOffset
	{
		get
		{
			return _ladderOffset;
		}
		set
		{
			_ladderOffset = Mathf.Max(0f, value);
		}
	}

	public float climbCompenAssistMinOffset => _climbCompensateAssistMinOffset;

	public float climbCompenAssistOffset
	{
		get
		{
			return _climbCompensateAssistOffset;
		}
		set
		{
			_climbCompensateAssistOffset = Mathf.Max(0f, value);
		}
	}

	public new Transform transform => _transform;

	public Rigidbody rigidbody => _rigidbody;

	public RigidbodyInterpolation interpolation
	{
		get
		{
			return rigidbody.interpolation;
		}
		set
		{
			rigidbody.interpolation = value;
		}
	}

	public Collider collider => _capsuleCollider;

	public Transform rootTransform
	{
		get
		{
			return _rootTransform;
		}
		set
		{
			_rootTransform = value;
		}
	}

	public Vector3 rootTransformOffset
	{
		get
		{
			return _rootTransformOffset;
		}
		set
		{
			_rootTransformOffset = value;
		}
	}

	public Vector3 position
	{
		get
		{
			return GetPosition();
		}
		set
		{
			SetPosition(value);
		}
	}

	public Quaternion rotation
	{
		get
		{
			return GetRotation();
		}
		set
		{
			SetRotation(value);
		}
	}

	public Vector3 worldCenter => position + rotation * _capsuleCenter;

	public Vector3 updatedPosition { get; private set; }

	public Quaternion updatedRotation { get; private set; }

	public Vector3 velocity
	{
		get
		{
			return _velocity;
		}
		set
		{
			_velocity = value;
		}
	}

	public Vector3 extraDisplacement { get; set; }

	public float speed => _velocity.magnitude;

	public float forwardSpeed => _velocity.dot(transform.forward);

	public float sidewaysSpeed => _velocity.dot(transform.right);

	public float radius
	{
		get
		{
			return _radius;
		}
		set
		{
			SetDimensions(value, _height);
		}
	}

	public float height
	{
		get
		{
			return _height;
		}
		set
		{
			SetDimensions(_radius, value);
		}
	}

	public float slopeLimit
	{
		get
		{
			return _slopeLimit;
		}
		set
		{
			_slopeLimit = Mathf.Clamp(value, 0f, 89f);
			_minSlopeLimit = Mathf.Cos((_slopeLimit + 0.01f) * (MathF.PI / 180f));
		}
	}

	public float stepOffset
	{
		get
		{
			return _stepOffset;
		}
		set
		{
			_stepOffset = Mathf.Max(0f, value);
		}
	}

	public float dodgeAssistOffset
	{
		get
		{
			return _dodgeAssistOffset;
		}
		set
		{
			_dodgeAssistOffset = Mathf.Max(0f, value);
		}
	}

	public float jumpAssistOffset
	{
		get
		{
			return _jumpAssistOffset;
		}
		set
		{
			_jumpAssistOffset = Mathf.Max(0f, value);
		}
	}

	public float perchOffset
	{
		get
		{
			return _perchOffset;
		}
		set
		{
			_perchOffset = Mathf.Clamp(value, 0f, _radius);
		}
	}

	public float perchAdditionalHeight
	{
		get
		{
			return _perchAdditionalHeight;
		}
		set
		{
			_perchAdditionalHeight = Mathf.Max(0f, value);
		}
	}

	public bool slopeLimitOverride
	{
		get
		{
			return _slopeLimitOverride;
		}
		set
		{
			_slopeLimitOverride = value;
		}
	}

	public bool useFlatTop
	{
		get
		{
			return _useFlatTop;
		}
		set
		{
			_useFlatTop = value;
		}
	}

	public bool useFlatBaseForGroundChecks
	{
		get
		{
			return _useFlatBaseForGroundChecks;
		}
		set
		{
			_useFlatBaseForGroundChecks = value;
		}
	}

	public LayerMask collisionLayers
	{
		get
		{
			return _collisionLayers;
		}
		set
		{
			_collisionLayers = value;
		}
	}

	public QueryTriggerInteraction triggerInteraction
	{
		get
		{
			return _triggerInteraction;
		}
		set
		{
			_triggerInteraction = value;
		}
	}

	public bool detectCollisions
	{
		get
		{
			return _detectCollisions;
		}
		set
		{
			_detectCollisions = value;
		}
	}

	public CollisionFlags collisionFlags { get; private set; }

	public bool isConstrainedToPlane => _planeConstraint != PlaneConstraint.None;

	public PlaneConstraint planeConstraint
	{
		get
		{
			return _planeConstraint;
		}
		set
		{
			SetPlaneConstraint(value, Vector3.zero);
		}
	}

	public LayerMask jumpDownIgnoreLayerMask
	{
		get
		{
			return _jumpDownIgnoreLayerMask;
		}
		set
		{
			_jumpDownIgnoreLayerMask = value;
		}
	}

	public Advanced advanced
	{
		get
		{
			return _advanced;
		}
		set
		{
			_advanced = value;
		}
	}

	public bool constrainToGround
	{
		get
		{
			return isConstrainedToGround;
		}
		set
		{
			_isConstrainedToGround = value;
		}
	}

	public bool isConstrainedToGround
	{
		get
		{
			if (_isConstrainedToGround)
			{
				return _unconstrainedTimer == 0f;
			}
			return false;
		}
	}

	public bool wasOnGround { get; private set; }

	public bool isOnGround => _currentGround.hitGround;

	public bool wasOnWalkableGround { get; private set; }

	public bool isOnWalkableGround => _currentGround.isWalkableGround;

	public bool wasGrounded { get; private set; }

	public bool isGrounded
	{
		get
		{
			if (isOnWalkableGround)
			{
				return isConstrainedToGround;
			}
			return false;
		}
	}

	public RoadMaterial groundMaterial
	{
		get
		{
			if (!isGrounded)
			{
				return RoadMaterial.Max;
			}
			return _currentGround.roadMaterial;
		}
	}

	public float groundDistance => _currentGround.groundDistance;

	public Vector3 groundPoint => _currentGround.point;

	public Vector3 groundNormal => _currentGround.normal;

	public Vector3 groundSurfaceNormal => _currentGround.surfaceNormal;

	public Collider groundCollider => _currentGround.collider;

	public Transform groundTransform => _currentGround.transform;

	public Rigidbody groundRigidbody => _currentGround.rigidbody;

	public FindGroundResult currentGround => _currentGround;

	public MovingPlatform movingPlatform => _movingPlatform;

	public Vector3 landedVelocity { get; private set; }

	public bool impartPlatformMovement
	{
		get
		{
			return _advanced.impartPlatformMovement;
		}
		set
		{
			_advanced.impartPlatformMovement = value;
		}
	}

	public bool tryDownMove { get; set; }

	public bool tryDownMoveClimb { get; set; }

	public bool cannotOffCliff { get; set; }

	public bool detectCliffBlock { get; set; }

	public bool frameCliffBlocked { get; private set; }

	public ColliderFilterCallback colliderFilterCallback { get; set; }

	public CollisionBehaviorCallback collisionBehaviorCallback { get; set; }

	public CollisionResponseCallback collisionResponseCallback { get; set; }

	public CollisionOverlapCallback collisionOverlapCallback { get; set; }

	public CollisionOverlapCallback collisionOverlapBeforeShouldFilterCallback { get; set; }

	public SweepColliderCallBack sweepColliderCallback { get; set; }

	public GroundColliderChange groundColliderChange { get; set; }

	public UnityAction<Collider> climbUpCallBack { get; set; }

	public Func<CollisionResult, bool> computeSliderVectorCallBack { get; set; }

	public event CollidedEventHandler Collided;

	public event FoundGroundEventHandler FoundGround;

	public static int Compare(RaycastHit x, RaycastHit y)
	{
		if (x.distance < y.distance)
		{
			return -1;
		}
		if (x.distance > y.distance)
		{
			return 1;
		}
		return 0;
	}

	private void OnCollided()
	{
		if (Collided != null)
		{
			for (int i = 0; i < _collisionCount; i++)
			{
				Collided(ref _collisionResults[i]);
			}
		}
	}

	private void OnFoundGround()
	{
		FoundGround?.Invoke(ref _currentGround);
	}

	private Vector3 FindOpposingNormal(Vector3 sweepDirDenorm, ref RaycastHit inHit)
	{
		Vector3 normal = inHit.normal;
		Vector3 origin = inHit.point - sweepDirDenorm;
		float distance = sweepDirDenorm.magnitude * 2f;
		Vector3 direction = sweepDirDenorm / sweepDirDenorm.magnitude;
		if (Raycast(origin, direction, distance, _collisionLayers, out var hitResult, 0.0042499998f))
		{
			normal = hitResult.normal;
		}
		return normal;
	}

	private static Vector3 FindBoxOpposingNormal(Vector3 sweepDirDenorm, ref RaycastHit inHit)
	{
		Transform transform = inHit.transform;
		Vector3 vector = transform.InverseTransformDirection(inHit.normal);
		Vector3 vector2 = transform.InverseTransformDirection(sweepDirDenorm);
		Vector3 direction = vector;
		float num = float.MaxValue;
		for (int i = 0; i < 3; i++)
		{
			if (vector[i] > 0.0001f)
			{
				float num2 = vector2[i];
				if (num2 < num)
				{
					num = num2;
					direction = Vector3.zero;
					direction[i] = 1f;
				}
			}
			else if (vector[i] < -0.0001f)
			{
				float num3 = 0f - vector2[i];
				if (num3 < num)
				{
					num = num3;
					direction = Vector3.zero;
					direction[i] = -1f;
				}
			}
		}
		return transform.TransformDirection(direction);
	}

	private static Vector3 FindBoxOpposingNormal(Vector3 displacement, Vector3 hitNormal, Transform hitTransform)
	{
		Vector3 vector = hitTransform.InverseTransformDirection(hitNormal);
		Vector3 vector2 = hitTransform.InverseTransformDirection(displacement);
		Vector3 direction = vector;
		float num = float.MaxValue;
		for (int i = 0; i < 3; i++)
		{
			if (vector[i] > 0.0001f)
			{
				float num2 = vector2[i];
				if (num2 < num)
				{
					num = num2;
					direction = Vector3.zero;
					direction[i] = 1f;
				}
			}
			else if (vector[i] < -0.0001f)
			{
				float num3 = 0f - vector2[i];
				if (num3 < num)
				{
					num = num3;
					direction = Vector3.zero;
					direction[i] = -1f;
				}
			}
		}
		return hitTransform.TransformDirection(direction);
	}

	private Vector3 FindGeomOpposingNormal(Vector3 sweepDirDenorm, ref RaycastHit inHit)
	{
		if (inHit.collider is SphereCollider || inHit.collider is CapsuleCollider)
		{
			return inHit.normal;
		}
		if (inHit.collider is BoxCollider)
		{
			return FindBoxOpposingNormal(sweepDirDenorm, ref inHit);
		}
		if (inHit.collider is MeshCollider { convex: false, sharedMesh: var sharedMesh })
		{
			if ((bool)sharedMesh && sharedMesh.isReadable)
			{
				return MeshUtility.FindMeshOpposingNormal(sharedMesh, ref inHit);
			}
			return FindOpposingNormal(sweepDirDenorm, ref inHit);
		}
		if (inHit.collider is MeshCollider { convex: not false })
		{
			return FindOpposingNormal(sweepDirDenorm, ref inHit);
		}
		return inHit.normal;
	}

	public static bool IsFinite(float value)
	{
		if (!float.IsNaN(value))
		{
			return !float.IsInfinity(value);
		}
		return false;
	}

	public static bool IsFinite(Vector3 value)
	{
		if (IsFinite(value.x) && IsFinite(value.y))
		{
			return IsFinite(value.z);
		}
		return false;
	}

	private static Vector3 GetRigidbodyVelocity(Rigidbody rigidbody, Vector3 worldPoint)
	{
		if (rigidbody == null)
		{
			return Vector3.zero;
		}
		if (!rigidbody.TryGetComponent<CharacterMovement>(out var component))
		{
			return rigidbody.GetPointVelocity(worldPoint);
		}
		return component.velocity;
	}

	private static bool IsWalkable(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.Walkable) != 0;
	}

	private static bool IsNotWalkable(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.NotWalkable) != 0;
	}

	private static bool CanPerchOn(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanPerchOn) != 0;
	}

	private static bool CanNotPerchOn(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanNotPerchOn) != 0;
	}

	private static bool CanStepOn(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanStepOn) != 0;
	}

	private static bool CanNotStepOn(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanNotStepOn) != 0;
	}

	private static bool CanRideOn(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanRideOn) != 0;
	}

	private static bool CanNotRideOn(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanNotRideOn) != 0;
	}

	private static bool CanDodgeAssist(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanDodgeAssist) != 0;
	}

	private static bool CanNotDodgeAssist(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanNotDodgeAssist) != 0;
	}

	private static bool CanIncreaseSlopeSlide(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.IncreaseSlopeSlide) != 0;
	}

	private static void MakeCapsule(float radius, float height, out Vector3 center, out Vector3 bottomCenter, out Vector3 topCenter)
	{
		radius = Mathf.Max(radius, 0f);
		height = Mathf.Max(height, radius * 2f);
		center = height * 0.5f * Vector3.up;
		float num = height - radius * 2f;
		bottomCenter = center - num * 0.5f * Vector3.up;
		topCenter = center + num * 0.5f * Vector3.up;
	}

	public void SetDimensions(float characterRadius, float characterHeight)
	{
		_radius = Mathf.Max(characterRadius, 0f);
		_height = Mathf.Max(characterHeight, characterRadius * 2f);
		MakeCapsule(_radius, _height, out _capsuleCenter, out _capsuleBottomCenter, out _capsuleTopCenter);
		if ((bool)_capsuleCollider)
		{
			_capsuleCollider.radius = _radius;
			_capsuleCollider.height = _height;
			_capsuleCollider.center = _capsuleCenter;
		}
	}

	public void SetHeight(float characterHeight)
	{
		_height = Mathf.Max(characterHeight, _radius * 2f);
		MakeCapsule(_radius, _height, out _capsuleCenter, out _capsuleBottomCenter, out _capsuleTopCenter);
		if ((bool)_capsuleCollider)
		{
			_capsuleCollider.height = _height;
			_capsuleCollider.center = _capsuleCenter;
		}
	}

	private void CacheComponents()
	{
		_transform = GetComponent<Transform>();
		_rigidbody = GetComponent<Rigidbody>();
		if ((bool)_rigidbody)
		{
			_rigidbody.drag = 0f;
			_rigidbody.angularDrag = 0f;
			_rigidbody.useGravity = false;
			_rigidbody.isKinematic = true;
		}
		_capsuleCollider = GetComponent<CapsuleCollider>();
	}

	public void SetPlaneConstraint(PlaneConstraint constrainAxis, Vector3 planeNormal)
	{
		_planeConstraint = constrainAxis;
		switch (_planeConstraint)
		{
		case PlaneConstraint.None:
			_constraintPlaneNormal = Vector3.zero;
			if ((bool)_rigidbody)
			{
				_rigidbody.constraints = RigidbodyConstraints.None;
			}
			break;
		case PlaneConstraint.ConstrainXAxis:
			_constraintPlaneNormal = Vector3.right;
			if ((bool)_rigidbody)
			{
				_rigidbody.constraints = RigidbodyConstraints.FreezePositionX;
			}
			break;
		case PlaneConstraint.ConstrainYAxis:
			_constraintPlaneNormal = Vector3.up;
			if ((bool)_rigidbody)
			{
				_rigidbody.constraints = RigidbodyConstraints.FreezePositionY;
			}
			break;
		case PlaneConstraint.ConstrainZAxis:
			_constraintPlaneNormal = Vector3.forward;
			if ((bool)_rigidbody)
			{
				_rigidbody.constraints = RigidbodyConstraints.FreezePositionZ;
			}
			break;
		case PlaneConstraint.Custom:
			_constraintPlaneNormal = planeNormal;
			if ((bool)_rigidbody)
			{
				_rigidbody.constraints = RigidbodyConstraints.None;
			}
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
	}

	public Vector3 ConstrainDirectionToPlane(Vector3 direction)
	{
		return ConstrainVectorToPlane(direction).normalized;
	}

	public Vector3 ConstrainVectorToPlane(Vector3 vector)
	{
		if (!isConstrainedToPlane)
		{
			return vector;
		}
		return vector.projectedOnPlane(_constraintPlaneNormal);
	}

	private void ResetCollisionFlags()
	{
		collisionFlags = CollisionFlags.None;
	}

	private void UpdateCollisionFlags(HitLocation hitLocation)
	{
		collisionFlags |= (CollisionFlags)hitLocation;
	}

	private HitLocation ComputeHitLocation(Vector3 inNormal)
	{
		float num = inNormal.dot(_characterUp);
		if (num > 0.01f)
		{
			return HitLocation.Below;
		}
		if (!(num < -0.01f))
		{
			return HitLocation.Sides;
		}
		return HitLocation.Above;
	}

	private bool IsWalkable(Collider inCollider, Vector3 inNormal)
	{
		if (ComputeHitLocation(inNormal) != HitLocation.Below)
		{
			return false;
		}
		if (collisionBehaviorCallback != null)
		{
			CollisionBehavior behaviorFlags = collisionBehaviorCallback(inCollider);
			if (IsWalkable(behaviorFlags))
			{
				return Vector3.Dot(inNormal, _characterUp) > 0.017452f;
			}
			if (IsNotWalkable(behaviorFlags))
			{
				return Vector3.Dot(inNormal, _characterUp) > 1f;
			}
		}
		float num = _minSlopeLimit;
		if (_slopeLimitOverride && inCollider.TryGetComponent<SlopeLimitBehavior>(out var component))
		{
			switch (component.walkableSlopeBehaviour)
			{
			case SlopeBehaviour.Walkable:
				num = 0.017452f;
				break;
			case SlopeBehaviour.NotWalkable:
				num = 1f;
				break;
			case SlopeBehaviour.Override:
				num = component.slopeLimitCos;
				break;
			}
		}
		return Vector3.Dot(inNormal, _characterUp) > num;
	}

	private Vector3 ComputeBlockingNormal(Vector3 inNormal, bool isWalkable)
	{
		if ((isGrounded || _hasLanded) && !isWalkable)
		{
			Vector3 vector = (_hasLanded ? _foundGround.normal : _currentGround.normal).perpendicularTo(inNormal).perpendicularTo(_characterUp);
			if (Vector3.Dot(vector, inNormal) < 0f)
			{
				vector = -vector;
			}
			if (!vector.isZero())
			{
				inNormal = vector;
			}
			return inNormal;
		}
		return inNormal;
	}

	public bool ShouldFilter(Collider otherCollider)
	{
		if (otherCollider == _capsuleCollider || otherCollider.attachedRigidbody == rigidbody)
		{
			return true;
		}
		if (_ignoredColliders.Contains(otherCollider))
		{
			return true;
		}
		Rigidbody attachedRigidbody = otherCollider.attachedRigidbody;
		if ((bool)attachedRigidbody && _ignoredRigidbodies.Contains(attachedRigidbody))
		{
			return true;
		}
		if (colliderFilterCallback != null)
		{
			return colliderFilterCallback(otherCollider);
		}
		return false;
	}

	public void CapsuleIgnoreCollision(Collider otherCollider, bool ignore = true)
	{
		if (!(otherCollider == null))
		{
			Physics.IgnoreCollision(_capsuleCollider, otherCollider, ignore);
		}
	}

	public void IgnoreCollision(Collider otherCollider, bool ignore = true)
	{
		if (!(otherCollider == null))
		{
			if (ignore)
			{
				_ignoredColliders.Add(otherCollider);
			}
			else
			{
				_ignoredColliders.Remove(otherCollider);
			}
		}
	}

	public void IgnoreCollision(Rigidbody otherRigidbody, bool ignore = true)
	{
		if (!(otherRigidbody == null))
		{
			if (ignore)
			{
				_ignoredRigidbodies.Add(otherRigidbody);
			}
			else
			{
				_ignoredRigidbodies.Remove(otherRigidbody);
			}
		}
	}

	private void ClearCollisionResults()
	{
		_collisionCount = 0;
	}

	private void AddCollisionResult(ref CollisionResult collisionResult)
	{
		UpdateCollisionFlags(collisionResult.hitLocation);
		if ((bool)collisionResult.rigidbody)
		{
			if (collisionResult.rigidbody == _movingPlatform.platform)
			{
				return;
			}
			for (int i = 0; i < _collisionCount; i++)
			{
				if (collisionResult.rigidbody == _collisionResults[i].rigidbody)
				{
					return;
				}
			}
		}
		if (_collisionCount < 8)
		{
			_collisionResults[_collisionCount++] = collisionResult;
		}
	}

	public int GetCollisionCount()
	{
		return _collisionCount;
	}

	public CollisionResult GetCollisionResult(int index)
	{
		return _collisionResults[index];
	}

	private bool ComputeInflatedMTD(Vector3 characterPosition, Quaternion characterRotation, float mtdInflation, Collider hitCollider, Transform hitTransform, out Vector3 mtdDirection, out float mtdDistance)
	{
		mtdDirection = Vector3.zero;
		mtdDistance = 0f;
		_capsuleCollider.radius = _radius + mtdInflation * 1f;
		_capsuleCollider.height = _height + mtdInflation * 2f;
		bool flag = Physics.ComputePenetration(_capsuleCollider, characterPosition, characterRotation, hitCollider, hitTransform.position, hitTransform.rotation, out var direction, out var distance);
		if (flag)
		{
			if (IsFinite(direction))
			{
				mtdDirection = direction;
				mtdDistance = Mathf.Max(Mathf.Abs(distance) - mtdInflation, 0f) + 0.0001f;
			}
			else
			{
				Debug.LogWarning("Warning: ComputeInflatedMTD_Internal: MTD returned NaN " + direction.ToString("F4"));
			}
		}
		_capsuleCollider.radius = _radius;
		_capsuleCollider.height = _height;
		return flag;
	}

	private bool ComputeMTD(Vector3 characterPosition, Quaternion characterRotation, Collider hitCollider, Transform hitTransform, out Vector3 mtdDirection, out float mtdDistance)
	{
		if (ComputeInflatedMTD(characterPosition, characterRotation, 0.0025f, hitCollider, hitTransform, out mtdDirection, out mtdDistance) || ComputeInflatedMTD(characterPosition, characterRotation, 0.0175f, hitCollider, hitTransform, out mtdDirection, out mtdDistance))
		{
			return true;
		}
		return false;
	}

	private void ResolveOverlaps(DepenetrationBehavior depenetrationBehavior = DepenetrationBehavior.IgnoreNone)
	{
		if (!detectCollisions)
		{
			return;
		}
		bool flag = (depenetrationBehavior & DepenetrationBehavior.IgnoreStatic) != 0;
		bool flag2 = (depenetrationBehavior & DepenetrationBehavior.IgnoreDynamic) != 0;
		bool flag3 = (depenetrationBehavior & DepenetrationBehavior.IgnoreKinematic) != 0;
		for (int i = 0; i < _advanced.maxDepenetrationIterations; i++)
		{
			Vector3 point = updatedPosition + _transformedCapsuleTopCenter;
			int num = Physics.OverlapCapsuleNonAlloc(updatedPosition + _transformedCapsuleBottomCenter, point, _radius, _overlaps, _collisionLayers, triggerInteraction);
			if (num == 0)
			{
				break;
			}
			collisionOverlapBeforeShouldFilterCallback?.Invoke(_overlaps, num, i);
			collisionOverlapCallback?.Invoke(_overlaps, num, i);
			TryResolveCollisionOverlap(_overlaps, num, i);
			for (int j = 0; j < num; j++)
			{
				Collider collider = _overlaps[j];
				if (ShouldFilter(collider))
				{
					continue;
				}
				Rigidbody attachedRigidbody = collider.attachedRigidbody;
				if (flag && attachedRigidbody == null)
				{
					continue;
				}
				if ((bool)attachedRigidbody)
				{
					bool isKinematic = attachedRigidbody.isKinematic;
					if ((flag3 & isKinematic) || (flag2 && !isKinematic))
					{
						continue;
					}
				}
				if (!ComputeMTD(updatedPosition, updatedRotation, collider, collider.transform, out var mtdDirection, out var mtdDistance))
				{
					continue;
				}
				mtdDirection = ConstrainDirectionToPlane(mtdDirection);
				if (!isWallClimb || ((1 << collider.gameObject.layer) & (int)_jumpDownIgnoreLayerMask) == 0 || ComputeHitLocation(mtdDirection) != HitLocation.Above)
				{
					HitLocation hitLocation = ComputeHitLocation(mtdDirection);
					bool isWalkable = IsWalkable(collider, mtdDirection);
					Vector3 vector = ComputeBlockingNormal(mtdDirection, isWalkable);
					updatedPosition += vector * (mtdDistance + 0.00125f);
					if (_collisionCount < 8)
					{
						Vector3 vector2 = hitLocation switch
						{
							HitLocation.Above => updatedPosition + _transformedCapsuleTopCenter - mtdDirection * _radius, 
							HitLocation.Below => updatedPosition + _transformedCapsuleBottomCenter - mtdDirection * _radius, 
							_ => updatedPosition + _transformedCapsuleCenter - mtdDirection * _radius, 
						};
						CollisionResult collisionResult = new CollisionResult
						{
							startPenetrating = true,
							hitLocation = hitLocation,
							isWalkable = isWalkable,
							position = updatedPosition,
							velocity = _velocity,
							otherVelocity = GetRigidbodyVelocity(attachedRigidbody, vector2),
							point = vector2,
							normal = vector,
							surfaceNormal = vector,
							collider = collider
						};
						AddCollisionResult(ref collisionResult);
					}
				}
			}
		}
	}

	public int OverlapTest(Vector3 characterPosition, Quaternion characterRotation, float testRadius, float testHeight, int layerMask, Collider[] results, QueryTriggerInteraction queryTriggerInteraction)
	{
		MakeCapsule(testRadius, testHeight, out var _, out var bottomCenter, out var topCenter);
		Vector3 point = characterPosition + characterRotation * topCenter;
		int num = Physics.OverlapCapsuleNonAlloc(characterPosition + characterRotation * bottomCenter, point, testRadius, results, layerMask, queryTriggerInteraction);
		if (num == 0)
		{
			return 0;
		}
		int num2 = num;
		for (int i = 0; i < num; i++)
		{
			Collider otherCollider = results[i];
			if (ShouldFilter(otherCollider) && i < --num2)
			{
				results[i] = results[num2];
			}
		}
		return num2;
	}

	public Collider[] OverlapTest(Vector3 characterPosition, Quaternion characterRotation, float testRadius, float testHeight, int layerMask, QueryTriggerInteraction queryTriggerInteraction, out int overlapCount)
	{
		overlapCount = OverlapTest(characterPosition, characterRotation, testRadius, testHeight, layerMask, _overlaps, queryTriggerInteraction);
		return _overlaps;
	}

	public bool CheckHeight(float testHeight)
	{
		IgnoreCollision(_movingPlatform.platform);
		int num = OverlapTest(position, rotation, radius, testHeight, collisionLayers, _overlaps, triggerInteraction);
		IgnoreCollision(_movingPlatform.platform, ignore: false);
		return num > 0;
	}

	public bool IsWithinEdgeTolerance(Vector3 characterPosition, Vector3 inPoint, float testRadius)
	{
		float sqrMagnitude = (inPoint - characterPosition).projectedOnPlane(_characterUp).sqrMagnitude;
		float num = Mathf.Max(0.0016f, testRadius - 0.0015f);
		return sqrMagnitude < num * num;
	}

	private bool ShouldCheckForValidLandingSpot(ref CollisionResult inCollision)
	{
		if (inCollision.hitLocation == HitLocation.Below && inCollision.normal != inCollision.surfaceNormal && IsWithinEdgeTolerance(updatedPosition, inCollision.point, _radius))
		{
			return true;
		}
		return false;
	}

	private bool IsValidLandingSpot(Vector3 characterPosition, ref CollisionResult inCollision)
	{
		if (!inCollision.isWalkable)
		{
			return false;
		}
		if (inCollision.hitLocation != HitLocation.Below)
		{
			return false;
		}
		if (!IsWithinEdgeTolerance(characterPosition, inCollision.point, _radius))
		{
			inCollision.isWalkable = false;
			return false;
		}
		FindGround(characterPosition, out var outGroundResult);
		inCollision.isWalkable = outGroundResult.isWalkableGround;
		if (inCollision.isWalkable)
		{
			_foundGround = outGroundResult;
			return true;
		}
		return false;
	}

	public bool Raycast(Vector3 origin, Vector3 direction, float distance, int layerMask, out RaycastHit hitResult, float thickness = 0f)
	{
		hitResult = default;
		int num = ((thickness == 0f) ? Physics.RaycastNonAlloc(origin, direction, _hits, distance, layerMask, triggerInteraction) : Physics.SphereCastNonAlloc(origin - direction * thickness, thickness, direction, _hits, distance, layerMask, triggerInteraction));
		if (num == 0)
		{
			return false;
		}
		float num2 = float.PositiveInfinity;
		int num3 = -1;
		for (int i = 0; i < num; i++)
		{
			ref RaycastHit reference = ref _hits[i];
			if (!(reference.distance <= 0f) && !ShouldFilter(reference.collider) && reference.distance < num2)
			{
				num2 = reference.distance;
				num3 = i;
			}
		}
		if (num3 != -1)
		{
			hitResult = _hits[num3];
			return true;
		}
		return false;
	}

	private bool CapsuleCast(Vector3 characterPosition, float castRadius, Vector3 castDirection, float castDistance, int layerMask, out RaycastHit hitResult, out bool startPenetrating)
	{
		hitResult = default;
		startPenetrating = false;
		Vector3 point = characterPosition + _transformedCapsuleTopCenter;
		int num = Physics.CapsuleCastNonAlloc(characterPosition + _transformedCapsuleBottomCenter, point, castRadius, castDirection, _hits, castDistance, layerMask, triggerInteraction);
		if (num == 0)
		{
			return false;
		}
		float num2 = float.PositiveInfinity;
		int num3 = -1;
		for (int i = 0; i < num; i++)
		{
			ref RaycastHit reference = ref _hits[i];
			if (!ShouldFilter(reference.collider))
			{
				if (reference.distance <= 0f)
				{
					startPenetrating = true;
				}
				else if (reference.distance < num2)
				{
					num2 = reference.distance;
					num3 = i;
				}
			}
		}
		if (num3 != -1)
		{
			hitResult = _hits[num3];
			return true;
		}
		return false;
	}

	private bool CapsuleCastEx(Vector3 characterPosition, float castRadius, Vector3 castDirection, float castDistance, int layerMask, out RaycastHit hitResult, out bool startPenetrating, out Vector3 recoverDirection, out float recoverDistance, bool ignoreNonBlockingOverlaps = false)
	{
		hitResult = default;
		startPenetrating = false;
		recoverDirection = default;
		recoverDistance = 0f;
		Vector3 point = characterPosition + _transformedCapsuleTopCenter;
		int num = Physics.CapsuleCastNonAlloc(characterPosition + _transformedCapsuleBottomCenter, point, castRadius, castDirection, _hits, castDistance, layerMask, triggerInteraction);
		if (num == 0)
		{
			return false;
		}
		for (int i = 0; i < num; i++)
		{
			ref RaycastHit reference = ref _hits[i];
			if (!ShouldFilter(reference.collider) && reference.distance <= 0f && ComputeMTD(characterPosition, updatedRotation, reference.collider, reference.collider.transform, out var mtdDirection, out var mtdDistance))
			{
				mtdDirection = ConstrainDirectionToPlane(mtdDirection);
				if (!isWallClimb || ((1 << reference.collider.gameObject.layer) & (int)_jumpDownIgnoreLayerMask) == 0 || ComputeHitLocation(mtdDirection) != HitLocation.Above)
				{
					Vector3 point2 = ComputeHitLocation(mtdDirection) switch
					{
						HitLocation.Above => characterPosition + _transformedCapsuleTopCenter - mtdDirection * _radius, 
						HitLocation.Below => characterPosition + _transformedCapsuleBottomCenter - mtdDirection * _radius, 
						_ => characterPosition + _transformedCapsuleCenter - mtdDirection * _radius, 
					};
					Vector3 normal = ComputeBlockingNormal(mtdDirection, IsWalkable(reference.collider, mtdDirection));
					reference.point = point2;
					reference.normal = normal;
					reference.distance = 0f - mtdDistance;
				}
			}
		}
		_hits.Sort(0, num, _comparison);
		float num2 = float.PositiveInfinity;
		int num3 = -1;
		for (int j = 0; j < num; j++)
		{
			ref RaycastHit reference2 = ref _hits[j];
			if (ShouldFilter(reference2.collider))
			{
				continue;
			}
			if (reference2.distance <= 0f && !reference2.point.isZero())
			{
				float num4 = Vector3.Dot(castDirection, reference2.normal);
				if ((!ignoreNonBlockingOverlaps || !(num4 > 0f)) && num4 < num2)
				{
					num2 = num4;
					num3 = j;
				}
			}
			else if (num3 == -1)
			{
				num3 = j;
				break;
			}
		}
		if (num3 >= 0)
		{
			hitResult = _hits[num3];
			if (hitResult.distance <= 0f)
			{
				startPenetrating = true;
				recoverDirection = hitResult.normal;
				recoverDistance = Mathf.Abs(hitResult.distance);
			}
			return true;
		}
		return false;
	}

	private bool SweepTest(Vector3 sweepOrigin, float sweepRadius, Vector3 sweepDirection, float sweepDistance, int sweepLayerMask, out RaycastHit hitResult, out bool startPenetrating)
	{
		hitResult = default;
		bool flag = CapsuleCast(sweepOrigin, sweepRadius, sweepDirection, sweepDistance + sweepRadius, sweepLayerMask, out var hitResult2, out startPenetrating) && hitResult2.distance <= sweepDistance;
		float num = sweepRadius + 0.01f;
		bool flag2 = CapsuleCast(sweepOrigin, num, sweepDirection, sweepDistance + num, sweepLayerMask, out var hitResult3, out var _) && hitResult3.distance <= sweepDistance;
		if (!(flag | flag2))
		{
			return false;
		}
		if (!flag2)
		{
			hitResult = hitResult2;
			hitResult.distance = Mathf.Max(0f, hitResult.distance - 0.01f);
		}
		else if (flag && hitResult2.distance < hitResult3.distance)
		{
			hitResult = hitResult2;
			hitResult.distance = Mathf.Max(0f, hitResult.distance - 0.01f);
		}
		else
		{
			hitResult = hitResult3;
			hitResult.distance = Mathf.Max(0f, hitResult.distance - 0.001f);
		}
		return true;
	}

	private bool SweepTestEx(Vector3 sweepOrigin, float sweepRadius, Vector3 sweepDirection, float sweepDistance, int sweepLayerMask, out RaycastHit hitResult, out bool startPenetrating, out Vector3 recoverDirection, out float recoverDistance, bool ignoreBlockingOverlaps = false)
	{
		hitResult = default;
		bool flag = CapsuleCastEx(sweepOrigin, sweepRadius, sweepDirection, sweepDistance + sweepRadius, sweepLayerMask, out var hitResult2, out startPenetrating, out recoverDirection, out recoverDistance, ignoreBlockingOverlaps) && hitResult2.distance <= sweepDistance;
		if (flag & startPenetrating)
		{
			hitResult = hitResult2;
			hitResult.distance = Mathf.Max(0f, hitResult.distance - 0.001f);
			return true;
		}
		float num = sweepRadius + 0.01f;
		bool flag2 = CapsuleCast(sweepOrigin, num, sweepDirection, sweepDistance + num, sweepLayerMask, out var hitResult3, out var _) && hitResult3.distance <= sweepDistance;
		if (!(flag | flag2))
		{
			return false;
		}
		if (!flag2)
		{
			hitResult = hitResult2;
			hitResult.distance = Mathf.Max(0f, hitResult.distance - 0.01f);
		}
		else if (flag && hitResult2.distance < hitResult3.distance)
		{
			hitResult = hitResult2;
			hitResult.distance = Mathf.Max(0f, hitResult.distance - 0.01f);
		}
		else
		{
			hitResult = hitResult3;
			hitResult.distance = Mathf.Max(0f, hitResult.distance - 0.001f);
		}
		return true;
	}

	private bool ResolvePenetration(Vector3 displacement, Vector3 proposedAdjustment)
	{
		Vector3 vector = ConstrainVectorToPlane(proposedAdjustment);
		if (vector.isZero())
		{
			return false;
		}
		if (OverlapTest(updatedPosition + vector, updatedRotation, _radius + 0.001f, _height, _collisionLayers, _overlaps, triggerInteraction) <= 0)
		{
			updatedPosition += vector;
			return true;
		}
		Vector3 vector2 = updatedPosition;
		if (!CapsuleCastEx(updatedPosition, _radius, vector.normalized, vector.magnitude, _collisionLayers, out var hitResult, out var startPenetrating, out var recoverDirection, out var recoverDistance, ignoreNonBlockingOverlaps: true))
		{
			updatedPosition += vector;
		}
		else
		{
			updatedPosition += vector.normalized * Mathf.Max(hitResult.distance - 0.001f, 0f);
		}
		bool flag = updatedPosition != vector2;
		bool startPenetrating2;
		Vector3 recoverDirection2;
		float recoverDistance2;
		if (!flag & startPenetrating)
		{
			Vector3 vector3 = recoverDirection * (recoverDistance + 0.01f + 0.00125f);
			Vector3 vector4 = vector + vector3;
			if (vector3 != vector && !vector4.isZero())
			{
				vector2 = updatedPosition;
				if (!CapsuleCastEx(updatedPosition, _radius, vector4.normalized, vector4.magnitude, _collisionLayers, out hitResult, out startPenetrating2, out recoverDirection2, out recoverDistance2, ignoreNonBlockingOverlaps: true))
				{
					updatedPosition += vector4;
				}
				else
				{
					updatedPosition += vector4.normalized * Mathf.Max(hitResult.distance - 0.001f, 0f);
				}
				flag = updatedPosition != vector2;
			}
		}
		if (!flag)
		{
			Vector3 vector5 = ConstrainVectorToPlane(displacement);
			if (!vector5.isZero())
			{
				vector2 = updatedPosition;
				Vector3 vector6 = vector + vector5;
				if (!CapsuleCastEx(updatedPosition, _radius, vector6.normalized, vector6.magnitude, _collisionLayers, out hitResult, out startPenetrating2, out recoverDirection2, out recoverDistance2, ignoreNonBlockingOverlaps: true))
				{
					updatedPosition += vector6;
				}
				else
				{
					updatedPosition += vector6.normalized * Mathf.Max(hitResult.distance - 0.001f, 0f);
				}
				flag = updatedPosition != vector2;
				if (!flag && Vector3.Dot(vector5, vector) > 0f)
				{
					vector2 = updatedPosition;
					if (!CapsuleCastEx(updatedPosition, _radius, vector5.normalized, vector5.magnitude, _collisionLayers, out hitResult, out startPenetrating2, out recoverDirection2, out recoverDistance2, ignoreNonBlockingOverlaps: true))
					{
						updatedPosition += vector5;
					}
					else
					{
						updatedPosition += vector5.normalized * Mathf.Max(hitResult.distance - 0.001f, 0f);
					}
					flag = updatedPosition != vector2;
				}
			}
		}
		return flag;
	}

	private bool MovementSweepTest(Vector3 characterPosition, Vector3 inVelocity, Vector3 displacement, out CollisionResult collisionResult, Vector3 dir = default(Vector3), bool invokeSweepColliderCallback = true)
	{
		collisionResult = default;
		Vector3 vector = characterPosition;
		Vector3 normalized;
		float magnitude;
		if (isWallClimb)
		{
			normalized = dir.normalized;
			magnitude = dir.magnitude;
		}
		else
		{
			normalized = displacement.normalized;
			magnitude = displacement.magnitude;
		}
		float sweepRadius = _radius;
		int sweepLayerMask = _collisionLayers;
		bool flag = SweepTestEx(vector, sweepRadius, normalized, magnitude, sweepLayerMask, out var hitResult, out var startPenetrating, out var recoverDirection, out var recoverDistance);
		if ((flag & invokeSweepColliderCallback) && sweepColliderCallback != null && sweepColliderCallback(hitResult.collider))
		{
			return false;
		}
		if (startPenetrating)
		{
			Vector3 proposedAdjustment = recoverDirection * (recoverDistance + 0.01f + 0.00125f);
			if (ResolvePenetration(displacement, proposedAdjustment))
			{
				vector = updatedPosition;
				flag = SweepTestEx(vector, sweepRadius, normalized, magnitude, sweepLayerMask, out hitResult, out startPenetrating, out var _, out var _);
			}
		}
		if (!flag)
		{
			return false;
		}
		HitLocation hitLocation = ComputeHitLocation(hitResult.normal);
		Vector3 vector2 = normalized * hitResult.distance;
		Vector3 remainingDisplacement = displacement - vector2;
		Vector3 vector3 = vector + vector2;
		Vector3 vector4 = hitResult.normal;
		bool isWalkable = false;
		if (hitLocation == HitLocation.Below)
		{
			vector4 = FindGeomOpposingNormal(displacement, ref hitResult);
			isWalkable = IsWalkable(hitResult.collider, vector4);
		}
		collisionResult = new CollisionResult
		{
			startPenetrating = startPenetrating,
			hitLocation = hitLocation,
			isWalkable = isWalkable,
			position = vector3,
			velocity = inVelocity,
			otherVelocity = GetRigidbodyVelocity(hitResult.rigidbody, hitResult.point),
			point = hitResult.point,
			normal = hitResult.normal,
			surfaceNormal = vector4,
			displacementToHit = vector2,
			remainingDisplacement = remainingDisplacement,
			collider = hitResult.collider,
			hitResult = hitResult
		};
		return true;
	}

	private Vector3 HandleSlopeBoosting(Vector3 slideResult, Vector3 displacement, Vector3 inNormal)
	{
		Vector3 vector = slideResult;
		float num = Vector3.Dot(vector, _characterUp);
		if (num > 0f)
		{
			float num2 = Vector3.Dot(displacement, _characterUp);
			if (num - num2 > 0.0001f)
			{
				if (num2 > 0f)
				{
					float num3 = num2 / num;
					vector *= num3;
				}
				else
				{
					vector = Vector3.zero;
				}
				Vector3 thisVector = (slideResult - vector).projectedOnPlane(_characterUp);
				Vector3 normalized = inNormal.projectedOnPlane(_characterUp).normalized;
				Vector3 vector2 = thisVector.projectedOnPlane(normalized);
				vector += vector2;
			}
		}
		return vector;
	}

	private Vector3 ComputeSlideVector(Vector3 displacement, Vector3 inNormal, bool isWalkable, CollisionResult inHit)
	{
		if (isGrounded)
		{
			if (isWalkable)
			{
				displacement = displacement.tangentTo(inNormal, _characterUp);
			}
			else if (computeSliderVectorCallBack(inHit))
			{
				displacement = Vector3.zero;
			}
			else
			{
				Vector3 normal = inNormal.perpendicularTo(groundNormal).perpendicularTo(inNormal);
				displacement = displacement.projectedOnPlane(inNormal);
				displacement = displacement.tangentTo(normal, _characterUp);
			}
		}
		else if (isWalkable)
		{
			if (_isConstrainedToGround)
			{
				displacement = displacement.projectedOnPlane(_characterUp);
			}
			displacement = displacement.projectedOnPlane(inNormal);
		}
		else
		{
			bool flag = false;
			if (collisionBehaviorCallback != null)
			{
				flag = CanIncreaseSlopeSlide(collisionBehaviorCallback(inHit.collider));
			}
			if (flag && (double)displacement.y < 0.0)
			{
				Vector3 vector = displacement.projectedOnPlane(Vector3.right).projectedOnPlane(inNormal);
				if (_isConstrainedToGround)
				{
					vector = HandleSlopeBoosting(vector, displacement, inNormal);
				}
				displacement = vector;
			}
			else
			{
				Vector3 vector2 = displacement.projectedOnPlane(inNormal);
				if (_isConstrainedToGround)
				{
					vector2 = HandleSlopeBoosting(vector2, displacement, inNormal);
				}
				displacement = vector2;
			}
		}
		return ConstrainVectorToPlane(displacement);
	}

	private int SlideAlongSurface(int iteration, Vector3 inputDisplacement, ref Vector3 inVelocity, ref Vector3 displacement, ref CollisionResult inHit, ref Vector3 prevNormal)
	{
		if (useFlatTop && inHit.hitLocation == HitLocation.Above)
		{
			Vector3 vector = FindBoxOpposingNormal(displacement, inHit.normal, inHit.transform);
			if (inHit.normal != vector)
			{
				inHit.normal = vector;
				inHit.surfaceNormal = vector;
			}
		}
		inHit.normal = ComputeBlockingNormal(inHit.normal, inHit.isWalkable);
		if (inHit.isWalkable && isConstrainedToGround)
		{
			inVelocity = ComputeSlideVector(inVelocity, inHit.normal, isWalkable: true, inHit);
			displacement = ComputeSlideVector(displacement, inHit.normal, isWalkable: true, inHit);
		}
		else
		{
			switch (iteration)
			{
			case 0:
				inVelocity = ComputeSlideVector(inVelocity, inHit.normal, inHit.isWalkable, inHit);
				displacement = ComputeSlideVector(displacement, inHit.normal, inHit.isWalkable, inHit);
				iteration++;
				break;
			case 1:
			{
				Vector3 vector2 = prevNormal.perpendicularTo(inHit.normal);
				Vector3 vector3 = inputDisplacement.projectedOnPlane(vector2);
				Vector3 thisVector = ComputeSlideVector(displacement, inHit.normal, inHit.isWalkable, inHit);
				thisVector = thisVector.projectedOnPlane(vector2);
				if (vector3.dot(thisVector) <= 0f || prevNormal.dot(inHit.normal) < 0f)
				{
					inVelocity = ConstrainVectorToPlane(inVelocity.projectedOn(vector2));
					displacement = ConstrainVectorToPlane(displacement.projectedOn(vector2));
					iteration++;
				}
				else
				{
					inVelocity = ComputeSlideVector(inVelocity, inHit.normal, inHit.isWalkable, inHit);
					displacement = ComputeSlideVector(displacement, inHit.normal, inHit.isWalkable, inHit);
				}
				break;
			}
			default:
				inVelocity = Vector3.zero;
				displacement = Vector3.zero;
				break;
			}
			prevNormal = inHit.normal;
		}
		return iteration;
	}

	private void PerformMovement(float deltaTime, Vector3 dir = default(Vector3))
	{
		DepenetrationBehavior depenetrationBehavior = DepenetrationBehavior.IgnoreDynamic;
		ResolveOverlaps(depenetrationBehavior);
		if (isGrounded)
		{
			_velocity = _velocity.projectedOnPlane(_characterUp);
		}
		Vector3 displacement = _velocity * deltaTime + extraDisplacement;
		Vector3 displacement2 = displacement;
		Vector3 vector = _velocity;
		extraDisplacement = Vector3.zero;
		if (isGrounded)
		{
			displacement = displacement.tangentTo(groundNormal, _characterUp);
			displacement = ConstrainVectorToPlane(displacement);
		}
		Vector3 inputDisplacement = displacement;
		int iteration = 0;
		Vector3 prevNormal = default;
		for (int i = 0; i < _collisionCount; i++)
		{
			ref CollisionResult reference = ref _collisionResults[i];
			if (!(displacement.dot(reference.normal) < 0f))
			{
				continue;
			}
			if (isConstrainedToGround && !isOnWalkableGround)
			{
				if (IsValidLandingSpot(updatedPosition, ref reference))
				{
					_hasLanded = true;
					landedVelocity = reference.velocity;
				}
				else if (reference.hitLocation == HitLocation.Below)
				{
					FindGround(updatedPosition, out var outGroundResult);
					reference.isWalkable = outGroundResult.isWalkableGround;
					if (reference.isWalkable)
					{
						_foundGround = outGroundResult;
						_hasLanded = true;
						landedVelocity = reference.velocity;
					}
				}
				if (!_hasLanded && reference.hitLocation == HitLocation.Below)
				{
					_foundGround.SetFromSweepResult(hitGround: true, isWalkable: false, updatedPosition, reference.point, reference.normal, reference.surfaceNormal, reference.collider, reference.hitResult.distance);
				}
			}
			iteration = SlideAlongSurface(iteration, inputDisplacement, ref _velocity, ref displacement, ref reference, ref prevNormal);
		}
		if (isWallClimb)
		{
			int maxMovementIterations = _advanced.maxMovementIterations;
			CollisionResult collisionResult;
			while (detectCollisions && maxMovementIterations-- > 0 && MovementSweepTest(updatedPosition, _velocity, displacement, out collisionResult, dir))
			{
				updatedPosition += collisionResult.displacementToHit;
				displacement = collisionResult.remainingDisplacement;
				if (!isConstrainedToGround && !isOnWalkableGround)
				{
					CheckLanded(ref collisionResult);
					if (!_hasLanded && collisionResult.hitLocation != HitLocation.Below && CanClimb(collisionResult.collider) && ClimbCompensation(ref collisionResult, out var y, deltaTime, dir, 0.3f))
					{
						updatedPosition = new Vector3(updatedPosition.x, y, updatedPosition.z);
						displacement = Vector3.zero;
						climbUpCallBack?.Invoke(collisionResult.collider);
					}
				}
				iteration = SlideAlongSurface(iteration, inputDisplacement, ref _velocity, ref displacement, ref collisionResult, ref prevNormal);
				AddCollisionResult(ref collisionResult);
			}
		}
		else
		{
			int maxMovementIterations2 = _advanced.maxMovementIterations;
			CollisionResult collisionResult2;
			while (detectCollisions && maxMovementIterations2-- > 0 && displacement.sqrMagnitude > _advanced.minMoveDistanceSqr && MovementSweepTest(updatedPosition, _velocity, displacement, out collisionResult2))
			{
				updatedPosition += collisionResult2.displacementToHit;
				displacement = collisionResult2.remainingDisplacement;
				if (!collisionResult2.isWalkable && CanDodgeAssist(collisionResult2.collider) && DodgeAssist(ref collisionResult2, out var sweepResult))
				{
					updatedPosition = sweepResult.position;
					displacement = Vector3.zero;
					break;
				}
				if (isGrounded && !collisionResult2.isWalkable && CanStepUp(collisionResult2.collider) && StepUp(ref collisionResult2, out var stepResult))
				{
					updatedPosition = stepResult.position;
					displacement = Vector3.zero;
					break;
				}
				if (isConstrainedToGround && !isOnWalkableGround)
				{
					CheckLanded(ref collisionResult2);
				}
				iteration = SlideAlongSurface(iteration, inputDisplacement, ref _velocity, ref displacement, ref collisionResult2, ref prevNormal);
				AddCollisionResult(ref collisionResult2);
			}
		}
		if (displacement.sqrMagnitude > _advanced.minMoveDistanceSqr)
		{
			updatedPosition += displacement;
		}
		if (isConstrainedToGround && !isOnWalkableGround && MovementSweepTest(updatedPosition, vector, displacement2, out var collisionResult3, default, invokeSweepColliderCallback: false))
		{
			CheckLanded(ref collisionResult3);
			if (!_hasLanded && CanClimb(collisionResult3.collider) && ClimbCompensation(ref collisionResult3, out var y2, deltaTime, default, 0.12f, vector))
			{
				updatedPosition = new Vector3(updatedPosition.x, y2, updatedPosition.z);
				climbUpCallBack?.Invoke(collisionResult3.collider);
			}
		}
		if (tryDownMove && !isGrounded && !_hasLanded)
		{
			float num = (tryDownMoveClimb ? 0.8f : 0.2f);
			bool flag = MovementSweepTest(updatedPosition, Vector3.zero, Vector3.down * num, out var collisionResult4) && collisionResult4.hitLocation == HitLocation.Below && collisionResult4.hitResult.distance > 0.024f;
			if (flag && tryDownMoveClimb && _hasClimbSnapReference && collisionResult4.point.y <= _climbSnapReferenceY + 0.024f)
			{
				flag = false;
			}
			if (flag)
			{
				Vector3 vector2 = updatedPosition;
				updatedPosition += collisionResult4.displacementToHit;
				CheckLanded(ref collisionResult4);
				if (_hasLanded)
				{
					_unconstrainedTimer = 0f;
				}
				else
				{
					updatedPosition = vector2;
					_foundGround = default;
				}
			}
		}
		if (isGrounded)
		{
			_velocity = _velocity.projectedOnPlane(_characterUp).normalized * _velocity.magnitude;
			_velocity = ConstrainVectorToPlane(_velocity);
		}
	}

	private void CheckLanded(ref CollisionResult collisionResult)
	{
		if (IsValidLandingSpot(updatedPosition, ref collisionResult))
		{
			_hasLanded = true;
			landedVelocity = collisionResult.velocity;
		}
		else if (ShouldCheckForValidLandingSpot(ref collisionResult))
		{
			FindGround(updatedPosition, out var outGroundResult);
			collisionResult.isWalkable = outGroundResult.isWalkableGround;
			if (collisionResult.isWalkable)
			{
				_foundGround = outGroundResult;
				_hasLanded = true;
				landedVelocity = collisionResult.velocity;
			}
		}
		if (!_hasLanded && collisionResult.hitLocation == HitLocation.Below)
		{
			float distance = collisionResult.hitResult.distance;
			Vector3 surfaceNormal = collisionResult.surfaceNormal;
			_foundGround.SetFromSweepResult(hitGround: true, isWalkable: false, updatedPosition, distance, ref collisionResult.hitResult, surfaceNormal);
		}
	}

	private bool CanPerchOn(Collider otherCollider)
	{
		if (otherCollider == null)
		{
			return false;
		}
		if (collisionBehaviorCallback != null)
		{
			CollisionBehavior behaviorFlags = collisionBehaviorCallback(otherCollider);
			if (CanPerchOn(behaviorFlags))
			{
				return true;
			}
			if (CanNotPerchOn(behaviorFlags))
			{
				return false;
			}
		}
		return true;
	}

	private float ResolvePerchOffset()
	{
		if (_perchRadiusOverride >= 0f)
		{
			return Mathf.Clamp(_perchRadiusOverride, 0f, _radius);
		}
		return perchOffset;
	}

	private float GetPerchRadiusThreshold()
	{
		return Mathf.Max(0f, _radius - ResolvePerchOffset());
	}

	private float GetValidPerchRadius(Collider otherCollider)
	{
		if (!CanPerchOn(otherCollider))
		{
			return 0.0011f;
		}
		return Mathf.Clamp(ResolvePerchOffset(), 0.0011f, _radius);
	}

	private bool ShouldComputePerchResult(Vector3 characterPosition, ref RaycastHit inHit)
	{
		if (GetPerchRadiusThreshold() <= 0.0015f)
		{
			return false;
		}
		float sqrMagnitude = (inHit.point - characterPosition).projectedOnPlane(_characterUp).sqrMagnitude;
		float validPerchRadius = GetValidPerchRadius(inHit.collider);
		if (sqrMagnitude <= validPerchRadius.square())
		{
			return false;
		}
		return true;
	}

	private bool CapsuleCast(Vector3 point1, Vector3 point2, float castRadius, Vector3 castDirection, float castDistance, int castLayerMask, out RaycastHit hitResult, out bool startPenetrating)
	{
		hitResult = default;
		startPenetrating = false;
		int num = Physics.CapsuleCastNonAlloc(point1, point2, castRadius, castDirection, _hits, castDistance, castLayerMask, triggerInteraction);
		if (num == 0)
		{
			return false;
		}
		float num2 = float.PositiveInfinity;
		int num3 = -1;
		for (int i = 0; i < num; i++)
		{
			ref RaycastHit reference = ref _hits[i];
			if (!ShouldFilter(reference.collider))
			{
				if (reference.distance <= 0f)
				{
					startPenetrating = true;
				}
				else if (reference.distance < num2)
				{
					num2 = reference.distance;
					num3 = i;
				}
			}
		}
		if (num3 != -1)
		{
			hitResult = _hits[num3];
			return true;
		}
		return false;
	}

	private bool BoxCast(Vector3 center, Vector3 halfExtents, Quaternion orientation, Vector3 castDirection, float castDistance, int castLayerMask, out RaycastHit hitResult, out bool startPenetrating)
	{
		hitResult = default;
		startPenetrating = false;
		int num = Physics.BoxCastNonAlloc(center, halfExtents, castDirection, _hits, orientation, castDistance, castLayerMask, triggerInteraction);
		if (num == 0)
		{
			return false;
		}
		float num2 = float.PositiveInfinity;
		int num3 = -1;
		for (int i = 0; i < num; i++)
		{
			ref RaycastHit reference = ref _hits[i];
			if (!ShouldFilter(reference.collider))
			{
				if (reference.distance <= 0f)
				{
					startPenetrating = true;
				}
				else if (reference.distance < num2)
				{
					num2 = reference.distance;
					num3 = i;
				}
			}
		}
		if (num3 != -1)
		{
			hitResult = _hits[num3];
			return true;
		}
		return false;
	}

	private bool GroundSweepTest(Vector3 characterPosition, float capsuleRadius, float capsuleHalfHeight, float sweepDistance, out RaycastHit hitResult, out bool startPenetrating, LayerMask layerMask)
	{
		bool flag;
		if (!useFlatBaseForGroundChecks)
		{
			Vector3 vector = characterPosition + _transformedCapsuleCenter;
			Vector3 point = vector - _characterUp * (capsuleHalfHeight - capsuleRadius);
			Vector3 point2 = vector + _characterUp * (capsuleHalfHeight - capsuleRadius);
			Vector3 castDirection = -1f * _characterUp;
			flag = CapsuleCast(point, point2, capsuleRadius, castDirection, sweepDistance, layerMask, out hitResult, out startPenetrating);
		}
		else
		{
			Vector3 center = characterPosition + _transformedCapsuleCenter;
			Vector3 halfExtents = new Vector3(capsuleRadius * 0.707f, capsuleHalfHeight, capsuleRadius * 0.707f);
			Quaternion quaternion = rotation * Quaternion.Euler(0f, 0f - rotation.eulerAngles.y, 0f);
			Vector3 castDirection2 = -1f * _characterUp;
			flag = BoxCast(center, halfExtents, quaternion * Quaternion.Euler(0f, 45f, 0f), castDirection2, sweepDistance, layerMask, out hitResult, out startPenetrating);
			if (!flag && !startPenetrating)
			{
				flag = BoxCast(center, halfExtents, quaternion, castDirection2, sweepDistance, layerMask, out hitResult, out startPenetrating);
			}
		}
		return flag;
	}

	private bool ExternalGroundSweepTest(Vector3 characterPosition, float capsuleRadius, float capsuleHalfHeight, float sweepDistance, out RaycastHit hitResult, out bool startPenetrating, LayerMask layerMask, Vector3 transformedCapsuleCenter)
	{
		Vector3 vector = characterPosition + transformedCapsuleCenter;
		Vector3 point = vector - Vector3.up * (capsuleHalfHeight - capsuleRadius);
		Vector3 point2 = vector + Vector3.up * (capsuleHalfHeight - capsuleRadius);
		Vector3 castDirection = -1f * Vector3.up;
		return CapsuleCast(point, point2, capsuleRadius, castDirection, sweepDistance, layerMask, out hitResult, out startPenetrating);
	}

	private bool ExternalIsWithinEdgeTolerance(Vector3 characterPosition, Vector3 inPoint, float testRadius)
	{
		float sqrMagnitude = (inPoint - characterPosition).projectedOnPlane(Vector3.up).sqrMagnitude;
		float num = Mathf.Max(0.0016f, testRadius - 0.0015f);
		return sqrMagnitude < num * num;
	}

	private HitLocation ExternalComputeHitLocation(Vector3 inNormal)
	{
		float num = inNormal.dot(Vector3.up);
		if (num > 0.01f)
		{
			return HitLocation.Below;
		}
		if (!(num < -0.01f))
		{
			return HitLocation.Sides;
		}
		return HitLocation.Above;
	}

	private bool ExternalIsWalkable(Collider inCollider, Vector3 inNormal)
	{
		if (ComputeHitLocation(inNormal) != HitLocation.Below)
		{
			return false;
		}
		if (collisionBehaviorCallback != null)
		{
			CollisionBehavior behaviorFlags = collisionBehaviorCallback(inCollider);
			if (IsWalkable(behaviorFlags))
			{
				return Vector3.Dot(inNormal, Vector3.up) > 0.017452f;
			}
			if (IsNotWalkable(behaviorFlags))
			{
				return Vector3.Dot(inNormal, Vector3.up) > 1f;
			}
		}
		float num = _minSlopeLimit;
		if (_slopeLimitOverride && inCollider.TryGetComponent<SlopeLimitBehavior>(out var component))
		{
			switch (component.walkableSlopeBehaviour)
			{
			case SlopeBehaviour.Walkable:
				num = 0.017452f;
				break;
			case SlopeBehaviour.NotWalkable:
				num = 1f;
				break;
			case SlopeBehaviour.Override:
				num = component.slopeLimitCos;
				break;
			}
		}
		return Vector3.Dot(inNormal, Vector3.up) > num;
	}

	public void ExternalComputeGroundDistance(Vector3 characterPosition, float height, Vector3 capsuleCenter, float radius, Quaternion rotation, float sweepDistance, float castDistance, out FindGroundResult outGroundResult, LayerMask groundDistanceLayerMask)
	{
		outGroundResult = default;
		if (sweepDistance < castDistance)
		{
			return;
		}
		float num = height * 0.5f;
		Vector3 transformedCapsuleCenter = rotation * capsuleCenter;
		bool flag = false;
		bool startPenetrating = false;
		if (sweepDistance > 0f && radius > 0f)
		{
			float num2 = (num - radius) * 0.100000024f;
			float num3 = radius;
			float capsuleHalfHeight = num - num2;
			float sweepDistance2 = sweepDistance + num2;
			flag = ExternalGroundSweepTest(characterPosition, num3, capsuleHalfHeight, sweepDistance2, out var hitResult, out startPenetrating, groundDistanceLayerMask, transformedCapsuleCenter);
			if (flag | startPenetrating)
			{
				if (startPenetrating || !ExternalIsWithinEdgeTolerance(characterPosition, hitResult.point, num3))
				{
					num2 = (num - radius) * 0.9f;
					num3 = Mathf.Max(0.0011f, num3 - 0.0015f - 0.0001f);
					capsuleHalfHeight = Mathf.Max(num3, num - num2);
					sweepDistance2 = sweepDistance + num2;
					flag = ExternalGroundSweepTest(characterPosition, num3, capsuleHalfHeight, sweepDistance2, out hitResult, out startPenetrating, groundDistanceLayerMask, transformedCapsuleCenter);
				}
				if (flag && !startPenetrating)
				{
					float num4 = Mathf.Max(0f - Mathf.Max(0.024f, radius), hitResult.distance - num2);
					Vector3 vector = -1f * Vector3.up;
					Vector3 vector2 = characterPosition + vector * num4;
					Vector3 vector3 = hitResult.normal;
					bool isWalkable = false;
					bool flag2 = num4 <= sweepDistance && ExternalComputeHitLocation(hitResult.normal) == HitLocation.Below;
					if (flag2)
					{
						if (useFlatBaseForGroundChecks)
						{
							isWalkable = ExternalIsWalkable(hitResult.collider, vector3);
						}
						else
						{
							vector3 = FindGeomOpposingNormal(vector * sweepDistance, ref hitResult);
							isWalkable = ExternalIsWalkable(hitResult.collider, vector3);
						}
					}
					outGroundResult.SetFromSweepResult(flag2, isWalkable, vector2, num4, ref hitResult, vector3);
					if (outGroundResult.isWalkableGround)
					{
						return;
					}
				}
			}
		}
		if (!flag && !startPenetrating)
		{
			return;
		}
		if (castDistance > 0f)
		{
			Vector3 origin = characterPosition + rotation * capsuleCenter;
			Vector3 direction = -1f * Vector3.up;
			float num5 = num;
			float distance = castDistance + num5;
			if (Raycast(origin, direction, distance, groundDistanceLayerMask, out var hitResult2) && hitResult2.distance > 0f)
			{
				float num6 = Mathf.Max(0f - Mathf.Max(0.024f, radius), hitResult2.distance - num5);
				if (num6 <= castDistance && ExternalIsWalkable(hitResult2.collider, hitResult2.normal))
				{
					outGroundResult.SetFromRaycastResult(hitGround: true, isWalkable: true, outGroundResult.position, outGroundResult.groundDistance, num6, ref hitResult2);
					return;
				}
			}
		}
		outGroundResult.isWalkable = false;
	}

	public void ComputeGroundDistance(Vector3 characterPosition, float sweepRadius, float sweepDistance, float castDistance, out FindGroundResult outGroundResult, LayerMask groundDistanceLayerMask = default(LayerMask))
	{
		outGroundResult = default;
		if (sweepDistance < castDistance)
		{
			return;
		}
		float num = _radius;
		float num2 = _height * 0.5f;
		bool flag = false;
		bool startPenetrating = false;
		LayerMask layerMask = (((int)groundDistanceLayerMask == 0) ? _collisionLayers : groundDistanceLayerMask);
		if (sweepDistance > 0f && sweepRadius > 0f)
		{
			float num3 = (num2 - num) * 0.100000024f;
			float num4 = sweepRadius;
			float capsuleHalfHeight = num2 - num3;
			float sweepDistance2 = sweepDistance + num3;
			flag = GroundSweepTest(characterPosition, num4, capsuleHalfHeight, sweepDistance2, out var hitResult, out startPenetrating, layerMask);
			if (flag | startPenetrating)
			{
				if (startPenetrating || !IsWithinEdgeTolerance(characterPosition, hitResult.point, num4))
				{
					num3 = (num2 - num) * 0.9f;
					num4 = Mathf.Max(0.0011f, num4 - 0.0015f - 0.0001f);
					capsuleHalfHeight = Mathf.Max(num4, num2 - num3);
					sweepDistance2 = sweepDistance + num3;
					flag = GroundSweepTest(characterPosition, num4, capsuleHalfHeight, sweepDistance2, out hitResult, out startPenetrating, layerMask);
				}
				if (flag && !startPenetrating)
				{
					float num5 = Mathf.Max(0f - Mathf.Max(0.024f, num), hitResult.distance - num3);
					Vector3 vector = -1f * _characterUp;
					Vector3 vector2 = characterPosition + vector * num5;
					Vector3 vector3 = hitResult.normal;
					bool isWalkable = false;
					bool flag2 = num5 <= sweepDistance && ComputeHitLocation(hitResult.normal) == HitLocation.Below;
					if (flag2)
					{
						if (useFlatBaseForGroundChecks)
						{
							isWalkable = IsWalkable(hitResult.collider, vector3);
						}
						else
						{
							vector3 = FindGeomOpposingNormal(vector * sweepDistance, ref hitResult);
							isWalkable = IsWalkable(hitResult.collider, vector3);
						}
					}
					outGroundResult.SetFromSweepResult(flag2, isWalkable, vector2, num5, ref hitResult, vector3);
					if (outGroundResult.isWalkableGround)
					{
						return;
					}
				}
			}
		}
		if (!flag && !startPenetrating)
		{
			return;
		}
		if (castDistance > 0f)
		{
			Vector3 origin = characterPosition + _transformedCapsuleCenter;
			Vector3 direction = -1f * _characterUp;
			float num6 = num2;
			float distance = castDistance + num6;
			if (Raycast(origin, direction, distance, layerMask, out var hitResult2) && hitResult2.distance > 0f)
			{
				float num7 = Mathf.Max(0f - Mathf.Max(0.024f, num), hitResult2.distance - num6);
				if (num7 <= castDistance && IsWalkable(hitResult2.collider, hitResult2.normal))
				{
					outGroundResult.SetFromRaycastResult(hitGround: true, isWalkable: true, outGroundResult.position, outGroundResult.groundDistance, num7, ref hitResult2);
					return;
				}
			}
		}
		outGroundResult.isWalkable = false;
	}

	private bool ComputePerchResult(Vector3 characterPosition, float testRadius, float inMaxGroundDistance, ref RaycastHit inHit, out FindGroundResult perchGroundResult)
	{
		perchGroundResult = default;
		if (inMaxGroundDistance <= 0f)
		{
			return false;
		}
		float num = Mathf.Max(0f, Vector3.Dot(inHit.point - characterPosition, _characterUp));
		float castDistance = Mathf.Max(0f, inMaxGroundDistance - num);
		float sweepDistance = Mathf.Max(0f, inMaxGroundDistance) + _radius;
		ComputeGroundDistance(characterPosition, testRadius, sweepDistance, castDistance, out perchGroundResult);
		if (!perchGroundResult.isWalkable)
		{
			return false;
		}
		if (num + perchGroundResult.groundDistance > inMaxGroundDistance)
		{
			perchGroundResult.isWalkable = false;
			return false;
		}
		return true;
	}

	public void FindGround(Vector3 characterPosition, out FindGroundResult outGroundResult)
	{
		if (!_detectCollisions)
		{
			outGroundResult = default;
			return;
		}
		float num = (isGrounded ? 0.0241f : (-0.024f));
		float num2 = Mathf.Max(0.024f, stepOffset + num);
		ComputeGroundDistance(characterPosition, _radius, num2, num2, out outGroundResult);
		if (!outGroundResult.hitGround || outGroundResult.isRaycastResult)
		{
			return;
		}
		Vector3 characterPosition2 = outGroundResult.position;
		if (!ShouldComputePerchResult(characterPosition2, ref outGroundResult.hitResult))
		{
			return;
		}
		float num3 = num2;
		if (isGrounded)
		{
			num3 += perchAdditionalHeight;
		}
		float validPerchRadius = GetValidPerchRadius(outGroundResult.collider);
		if (ComputePerchResult(characterPosition2, validPerchRadius, num3, ref outGroundResult.hitResult, out var perchGroundResult))
		{
			if (0.021499999f - outGroundResult.groundDistance + perchGroundResult.groundDistance >= num3)
			{
				outGroundResult.groundDistance = 0.021499999f;
			}
			if (!outGroundResult.isWalkableGround)
			{
				float num4 = outGroundResult.groundDistance;
				float castDistance = Mathf.Max(0.019f, num4);
				outGroundResult.SetFromRaycastResult(hitGround: true, isWalkable: true, outGroundResult.position, num4, castDistance, ref perchGroundResult.hitResult);
			}
		}
		else
		{
			outGroundResult.isWalkable = false;
		}
	}

	private void AdjustGroundHeight()
	{
		if (!_currentGround.isWalkableGround || !isConstrainedToGround)
		{
			return;
		}
		float raycastDistance = _currentGround.groundDistance;
		if (_currentGround.isRaycastResult)
		{
			if (raycastDistance < 0.019f && _currentGround.raycastDistance >= 0.019f)
			{
				return;
			}
			raycastDistance = _currentGround.raycastDistance;
		}
		if (raycastDistance < 0.019f || raycastDistance > 0.024f)
		{
			float num = Vector3.Dot(updatedPosition, _characterUp);
			float num2 = 0.021499999f - raycastDistance;
			Vector3 vector = _characterUp * num2;
			Vector3 sweepOrigin = updatedPosition;
			Vector3 normalized = vector.normalized;
			float sweepRadius = _radius;
			float magnitude = vector.magnitude;
			int sweepLayerMask = _collisionLayers;
			if (!SweepTestEx(sweepOrigin, sweepRadius, normalized, magnitude, sweepLayerMask, out var hitResult, out var startPenetrating, out var _, out var _, ignoreBlockingOverlaps: true) && !startPenetrating)
			{
				updatedPosition += vector;
				_currentGround.groundDistance += num2;
			}
			else if (num2 > 0f)
			{
				updatedPosition += normalized * hitResult.distance;
				float num3 = Vector3.Dot(updatedPosition, _characterUp);
				_currentGround.groundDistance += num3 - num;
			}
			else
			{
				updatedPosition += normalized * hitResult.distance;
				float num4 = Vector3.Dot(updatedPosition, _characterUp);
				_currentGround.groundDistance = num4 - num;
			}
		}
		SyncRootTransformPosition();
	}

	public void SyncRootTransformPosition()
	{
		if ((bool)_rootTransform)
		{
			_rootTransform.localPosition = _rootTransformOffset - new Vector3(0f, 0.021499999f, 0f);
		}
	}

	private bool CanStepUp(Collider otherCollider)
	{
		if (otherCollider == null)
		{
			return false;
		}
		if (collisionBehaviorCallback != null)
		{
			CollisionBehavior behaviorFlags = collisionBehaviorCallback(otherCollider);
			if (CanStepOn(behaviorFlags))
			{
				return true;
			}
			if (CanNotStepOn(behaviorFlags))
			{
				return false;
			}
		}
		return true;
	}

	private bool CanDodgeAssist(Collider otherCollider)
	{
		if (otherCollider == null)
		{
			return false;
		}
		if (collisionBehaviorCallback != null)
		{
			CollisionBehavior behaviorFlags = collisionBehaviorCallback(otherCollider);
			if (CanDodgeAssist(behaviorFlags))
			{
				return true;
			}
			if (CanNotDodgeAssist(behaviorFlags))
			{
				return false;
			}
		}
		return true;
	}

	private bool StepUp(ref CollisionResult inCollision, out CollisionResult stepResult)
	{
		stepResult = default;
		if (inCollision.hitLocation == HitLocation.Above)
		{
			return false;
		}
		float num = Vector3.Dot(inCollision.position, _characterUp);
		float num2 = num;
		float num3 = Mathf.Max(0f, _currentGround.GetDistanceToGround());
		num -= num3;
		float num4 = Mathf.Max(0f, stepOffset - num3);
		float num5 = stepOffset + 0.048f;
		bool flag = !IsWithinEdgeTolerance(inCollision.position, inCollision.point, _radius + 0.01f);
		num2 = ((_currentGround.isRaycastResult || flag) ? (num2 - _currentGround.groundDistance) : Vector3.Dot(groundPoint, _characterUp));
		if (Vector3.Dot(inCollision.point, _characterUp) <= num)
		{
			return false;
		}
		Vector3 vector = inCollision.position;
		Vector3 characterUp = _characterUp;
		float sweepRadius = _radius;
		float num6 = num4;
		int sweepLayerMask = _collisionLayers;
		bool flag2 = SweepTest(vector, sweepRadius, characterUp, num6, sweepLayerMask, out var hitResult, out var startPenetrating);
		if (startPenetrating)
		{
			return false;
		}
		if (!flag2)
		{
			vector += characterUp * num6;
		}
		else
		{
			vector += characterUp * hitResult.distance;
		}
		Vector3 remainingDisplacement = inCollision.remainingDisplacement;
		Vector3 vector2 = ConstrainVectorToPlane(Vector3.ProjectOnPlane(remainingDisplacement, _characterUp));
		num6 = remainingDisplacement.magnitude;
		characterUp = vector2.normalized;
		flag2 = SweepTest(vector, sweepRadius, characterUp, num6, sweepLayerMask, out hitResult, out startPenetrating);
		if (startPenetrating)
		{
			return false;
		}
		if (!flag2)
		{
			vector += characterUp * num6;
			characterUp = -_characterUp;
			num6 = num5;
			flag2 = SweepTest(vector, sweepRadius, characterUp, num6, sweepLayerMask, out hitResult, out startPenetrating);
			if (!flag2 | startPenetrating)
			{
				return false;
			}
			float num7 = Vector3.Dot(hitResult.point, _characterUp) - num2;
			if (num7 > stepOffset)
			{
				return false;
			}
			Vector3 vector3 = vector + characterUp * hitResult.distance;
			if (OverlapTest(vector3, updatedRotation, _radius, _height, _collisionLayers, _overlaps, triggerInteraction) > 0)
			{
				return false;
			}
			Vector3 vector4 = FindGeomOpposingNormal(characterUp * num6, ref hitResult);
			if (!IsWalkable(hitResult.collider, vector4))
			{
				if (Vector3.Dot(remainingDisplacement, vector4) < 0f)
				{
					return false;
				}
				if (Vector3.Dot(vector3, _characterUp) > Vector3.Dot(inCollision.position, _characterUp))
				{
					return false;
				}
			}
			if (!IsWithinEdgeTolerance(vector3, hitResult.point, _radius + 0.01f))
			{
				return false;
			}
			if (num7 > 0f && !CanStepUp(hitResult.collider))
			{
				return false;
			}
			stepResult = new CollisionResult
			{
				position = vector3
			};
			return true;
		}
		return false;
	}

	private bool DodgeAssist(ref CollisionResult inCollision, out CollisionResult sweepResult)
	{
		sweepResult = default;
		if (inCollision.hitLocation == HitLocation.Above)
		{
			return false;
		}
		float num = Vector3.Dot(inCollision.position, _characterUp);
		float num2 = num;
		float num3 = Mathf.Max(0f, _currentGround.GetDistanceToGround());
		num -= num3;
		float num4 = Mathf.Max(0f, dodgeAssistOffset - num3);
		float num5 = dodgeAssistOffset + 0.048f;
		bool flag = !IsWithinEdgeTolerance(inCollision.position, inCollision.point, _radius + 0.01f);
		num2 = ((_currentGround.isRaycastResult || flag) ? (num2 - _currentGround.groundDistance) : Vector3.Dot(groundPoint, _characterUp));
		if (Vector3.Dot(inCollision.point, _characterUp) <= num)
		{
			return false;
		}
		Vector3 vector = inCollision.position;
		Vector3 characterUp = _characterUp;
		float sweepRadius = _radius;
		float num6 = num4;
		int sweepLayerMask = _collisionLayers;
		bool flag2 = SweepTest(vector, sweepRadius, characterUp, num6, sweepLayerMask, out var hitResult, out var startPenetrating);
		if (startPenetrating)
		{
			return false;
		}
		if (!flag2)
		{
			vector += characterUp * num6;
		}
		else
		{
			vector += characterUp * hitResult.distance;
		}
		Vector3 remainingDisplacement = inCollision.remainingDisplacement;
		Vector3 vector2 = ConstrainVectorToPlane(Vector3.ProjectOnPlane(remainingDisplacement, _characterUp));
		num6 = remainingDisplacement.magnitude;
		characterUp = vector2.normalized;
		flag2 = SweepTest(vector, sweepRadius, characterUp, num6, sweepLayerMask, out hitResult, out startPenetrating);
		if (startPenetrating)
		{
			return false;
		}
		if (!flag2)
		{
			vector += characterUp * num6;
			characterUp = -_characterUp;
			num6 = num5;
			flag2 = SweepTest(vector, sweepRadius, characterUp, num6, sweepLayerMask, out hitResult, out startPenetrating);
			if (!flag2 | startPenetrating)
			{
				return false;
			}
			float num7 = Vector3.Dot(hitResult.point, _characterUp) - num2;
			if (num7 > dodgeAssistOffset)
			{
				return false;
			}
			Vector3 vector3 = vector + characterUp * hitResult.distance;
			if (OverlapTest(vector3, updatedRotation, _radius, _height, _collisionLayers, _overlaps, triggerInteraction) > 0)
			{
				return false;
			}
			Vector3 vector4 = FindGeomOpposingNormal(characterUp * num6, ref hitResult);
			if (!IsWalkable(hitResult.collider, vector4))
			{
				if (Vector3.Dot(remainingDisplacement, vector4) < 0f)
				{
					return false;
				}
				if (Vector3.Dot(vector3, _characterUp) > Vector3.Dot(inCollision.position, _characterUp))
				{
					return false;
				}
			}
			if (!IsWithinEdgeTolerance(vector3, hitResult.point, _radius + 0.01f))
			{
				return false;
			}
			if (num7 > 0f && !CanDodgeAssist(hitResult.collider))
			{
				return false;
			}
			sweepResult = new CollisionResult
			{
				position = vector3
			};
			return true;
		}
		return false;
	}

	public void PauseGroundConstraint(float unconstrainedTime = 0.1f)
	{
		_unconstrainedTimer = unconstrainedTime;
	}

	private void UpdateCurrentGround(ref FindGroundResult inGroundResult)
	{
		wasOnGround = isOnGround;
		wasOnWalkableGround = isOnWalkableGround;
		wasGrounded = isGrounded;
		_currentGround = inGroundResult;
		groundColliderChange(_currentGround);
	}

	private int SlideAlongSurface(int iteration, Vector3 inputDisplacement, ref Vector3 displacement, ref CollisionResult inHit, ref Vector3 prevNormal)
	{
		inHit.normal = ComputeBlockingNormal(inHit.normal, inHit.isWalkable);
		if (inHit.isWalkable && isConstrainedToGround)
		{
			displacement = ComputeSlideVector(displacement, inHit.normal, isWalkable: true, inHit);
		}
		else
		{
			switch (iteration)
			{
			case 0:
				displacement = ComputeSlideVector(displacement, inHit.normal, inHit.isWalkable, inHit);
				iteration++;
				break;
			case 1:
			{
				Vector3 vector = prevNormal.perpendicularTo(inHit.normal);
				Vector3 vector2 = inputDisplacement.projectedOnPlane(vector);
				Vector3 thisVector = ComputeSlideVector(displacement, inHit.normal, inHit.isWalkable, inHit);
				thisVector = thisVector.projectedOnPlane(vector);
				if (vector2.dot(thisVector) <= 0f || prevNormal.dot(inHit.normal) < 0f)
				{
					displacement = ConstrainVectorToPlane(displacement.projectedOn(vector));
					iteration++;
				}
				else
				{
					displacement = ComputeSlideVector(displacement, inHit.normal, inHit.isWalkable, inHit);
				}
				break;
			}
			default:
				displacement = Vector3.zero;
				break;
			}
			prevNormal = inHit.normal;
		}
		return iteration;
	}

	private void MoveAndSlide(Vector3 displacement)
	{
		Vector3 inputDisplacement = displacement;
		int iteration = 0;
		Vector3 prevNormal = default;
		int maxMovementIterations = _advanced.maxMovementIterations;
		CollisionResult collisionResult;
		while (maxMovementIterations-- > 0 && displacement.sqrMagnitude > _advanced.minMoveDistanceSqr && MovementSweepTest(updatedPosition, default, displacement, out collisionResult))
		{
			updatedPosition += collisionResult.displacementToHit;
			displacement = collisionResult.remainingDisplacement;
			iteration = SlideAlongSurface(iteration, inputDisplacement, ref displacement, ref collisionResult, ref prevNormal);
			AddCollisionResult(ref collisionResult);
		}
		if (displacement.sqrMagnitude > _advanced.minMoveDistanceSqr)
		{
			updatedPosition += displacement;
		}
	}

	private bool CanRideOn(Collider otherCollider, out IMovingPlatformSource platformSource)
	{
		platformSource = null;
		if (otherCollider == null)
		{
			return false;
		}
		Rigidbody attachedRigidbody = otherCollider.attachedRigidbody;
		platformSource = otherCollider.GetComponentInParent<IMovingPlatformSource>();
		if (!attachedRigidbody && platformSource == null)
		{
			return false;
		}
		if (collisionBehaviorCallback != null)
		{
			CollisionBehavior behaviorFlags = collisionBehaviorCallback(otherCollider);
			if (CanRideOn(behaviorFlags))
			{
				return true;
			}
			if (CanNotRideOn(behaviorFlags))
			{
				return false;
			}
		}
		return true;
	}

	private void IgnoreCurrentPlatform(bool ignore)
	{
		IgnoreCollision(_movingPlatform.platform, ignore);
		IgnoreCollision(_movingPlatform.platformSourceCollider, ignore);
	}

	public void SetPlatform(Rigidbody newPlatform)
	{
		_parentPlatform = newPlatform;
	}

	public void SetPlatformAsNull()
	{
		_movingPlatform.platform = null;
		_movingPlatform.platformSource = null;
		_movingPlatform.platformSourceCollider = null;
	}

	public void ReplacePlatform(MovingPlatform platform)
	{
		_movingPlatform.platform = platform.platform;
		_movingPlatform.platformSource = platform.platformSource;
		_movingPlatform.platformSourceCollider = platform.platformSourceCollider;
		_movingPlatform.lastPlatform = platform.lastPlatform;
		_movingPlatform.position = platform.position;
		_movingPlatform.platformVelocity = platform.platformVelocity;
		_movingPlatform.rotation = platform.rotation;
		_movingPlatform.localPosition = platform.localPosition;
		_movingPlatform.localRotation = platform.localRotation;
	}

	private void UpdateCurrentPlatform()
	{
		_movingPlatform.lastPlatform = _movingPlatform.platform;
		_movingPlatform.platform = null;
		_movingPlatform.platformSource = null;
		_movingPlatform.platformSourceCollider = null;
		IMovingPlatformSource platformSource;
		if ((bool)_parentPlatform)
		{
			_movingPlatform.platform = _parentPlatform;
		}
		else if (isGrounded && CanRideOn(groundCollider, out platformSource))
		{
			_movingPlatform.platform = groundCollider.attachedRigidbody;
			if (!_movingPlatform.platform)
			{
				_movingPlatform.platformSource = platformSource;
				_movingPlatform.platformSourceCollider = groundCollider;
			}
		}
		if ((bool)_movingPlatform.platform)
		{
			Transform transform = _movingPlatform.platform.transform;
			_movingPlatform.position = updatedPosition;
			_movingPlatform.localPosition = transform.InverseTransformPoint(updatedPosition);
			_movingPlatform.rotation = updatedRotation;
			_movingPlatform.localRotation = Quaternion.Inverse(transform.rotation) * updatedRotation;
		}
	}

	private void UpdatePlatformMovement(float deltaTime)
	{
		_ = _movingPlatform;
		Vector3 deltaPosition;
		Quaternion deltaRotation;
		if ((bool)_movingPlatform.platform)
		{
			Vector3 vector = _movingPlatform.platform.transform.TransformPoint(_movingPlatform.localPosition) - _movingPlatform.position;
			_movingPlatform.platformVelocity = ((deltaTime > 0f) ? (vector / deltaTime) : Vector3.zero);
		}
		else if (_movingPlatform.platformSource != null && _movingPlatform.platformSource.TryGetDeltaPose(updatedPosition, out deltaPosition, out deltaRotation))
		{
			_movingPlatform.platformVelocity = ((deltaTime > 0f) ? (deltaPosition / deltaTime) : Vector3.zero);
		}
		else
		{
			_movingPlatform.platformVelocity = Vector3.zero;
		}
		if (impartPlatformMovement && _movingPlatform.platformVelocity.sqrMagnitude > 0f)
		{
			IgnoreCurrentPlatform(ignore: true);
			MoveAndSlide(_movingPlatform.platformVelocity * deltaTime);
			IgnoreCurrentPlatform(ignore: false);
		}
	}

	public void SetPosition(Vector3 newPosition, bool updateGround = false)
	{
		updatedPosition = newPosition;
		if (updateGround)
		{
			FindGround(updatedPosition, out var outGroundResult);
			UpdateCurrentGround(ref outGroundResult);
			AdjustGroundHeight();
			UpdateCurrentPlatform();
		}
		rigidbody.position = updatedPosition;
		transform.position = updatedPosition;
	}

	public Vector3 GetPosition()
	{
		return transform.position;
	}

	public Vector3 GetFootPosition()
	{
		return transform.position - transform.up * 0.021499999f;
	}

	public void SetRotation(Quaternion newRotation)
	{
		updatedRotation = newRotation;
		rigidbody.rotation = updatedRotation;
		transform.rotation = updatedRotation;
	}

	public Quaternion GetRotation()
	{
		return transform.rotation;
	}

	public void SetPositionAndRotation(Vector3 newPosition, Quaternion newRotation, bool updateGround = false)
	{
		updatedPosition = newPosition;
		updatedRotation = newRotation;
		if (updateGround)
		{
			FindGround(updatedPosition, out var outGroundResult);
			UpdateCurrentGround(ref outGroundResult);
			AdjustGroundHeight();
			UpdateCurrentPlatform();
		}
		rigidbody.position = updatedPosition;
		rigidbody.rotation = updatedRotation;
		transform.SetPositionAndRotation(updatedPosition, updatedRotation);
	}

	public void RotateTowards(Vector3 worldDirection, float maxDegreesDelta, bool updateYawOnly = true)
	{
		Vector3 up = transform.up;
		if (updateYawOnly)
		{
			worldDirection = worldDirection.projectedOnPlane(up);
		}
		if (!(worldDirection == Vector3.zero))
		{
			Quaternion to = Quaternion.LookRotation(worldDirection, up);
			rotation = Quaternion.RotateTowards(rotation, to, maxDegreesDelta);
		}
	}

	private void UpdateCachedFields()
	{
		_hasLanded = false;
		_foundGround = default;
		updatedPosition = transform.position;
		updatedRotation = transform.rotation;
		_characterUp = updatedRotation * Vector3.up;
		_transformedCapsuleCenter = updatedRotation * _capsuleCenter;
		_transformedCapsuleTopCenter = updatedRotation * _capsuleTopCenter;
		_transformedCapsuleBottomCenter = updatedRotation * _capsuleBottomCenter;
		ResetCollisionFlags();
	}

	public void ClearAccumulatedForces()
	{
		_pendingForces = Vector3.zero;
		_pendingImpulses = Vector3.zero;
		_pendingLaunchVelocity = Vector3.zero;
	}

	public void AddForce(Vector3 force, ForceMode forceMode = ForceMode.Force)
	{
		switch (forceMode)
		{
		case ForceMode.Force:
			_pendingForces += force / rigidbody.mass;
			break;
		case ForceMode.Acceleration:
			_pendingForces += force;
			break;
		case ForceMode.Impulse:
			_pendingImpulses += force / rigidbody.mass;
			break;
		case ForceMode.VelocityChange:
			_pendingImpulses += force;
			break;
		case (ForceMode)3:
		case (ForceMode)4:
			break;
		}
	}

	public void LaunchCharacter(Vector3 launchVelocity, bool overrideVerticalVelocity = false, bool overrideLateralVelocity = false)
	{
		Vector3 pendingLaunchVelocity = launchVelocity;
		Vector3 up = transform.up;
		if (!overrideLateralVelocity)
		{
			pendingLaunchVelocity += _velocity.projectedOnPlane(up);
		}
		if (!overrideVerticalVelocity)
		{
			pendingLaunchVelocity += _velocity.projectedOn(up);
		}
		_pendingLaunchVelocity = pendingLaunchVelocity;
	}

	private void UpdateVelocity(Vector3 newVelocity, float deltaTime)
	{
		_velocity = newVelocity;
		_velocity += _pendingForces * deltaTime;
		_velocity += _pendingImpulses;
		if (_pendingLaunchVelocity.sqrMagnitude > 0f)
		{
			_velocity = _pendingLaunchVelocity;
		}
		ClearAccumulatedForces();
		_velocity = ConstrainVectorToPlane(_velocity);
	}

	public CollisionFlags Move(Vector3 newVelocity, float deltaTime = 0f, Vector3 dir = default(Vector3))
	{
		UpdateCachedFields();
		ClearCollisionResults();
		frameCliffBlocked = false;
		UpdateVelocity(newVelocity, deltaTime);
		UpdatePlatformMovement(deltaTime);
		PerformMovement(deltaTime, dir);
		if (isGrounded || _hasLanded)
		{
			if (cannotOffCliff || detectCliffBlock)
			{
				ApplyCliffEdgeConstraint();
			}
			else
			{
				FindGround(updatedPosition, out var outGroundResult);
				_foundGround = outGroundResult;
			}
		}
		UpdateCurrentGround(ref _foundGround);
		if (_unconstrainedTimer > 0f)
		{
			_unconstrainedTimer -= deltaTime;
			if (_unconstrainedTimer <= 0f)
			{
				_unconstrainedTimer = 0f;
			}
		}
		AdjustGroundHeight();
		UpdateCurrentPlatform();
		SetPositionAndRotation(updatedPosition, updatedRotation);
		OnCollided();
		if (!wasOnWalkableGround && isOnGround)
		{
			OnFoundGround();
		}
		return collisionFlags;
	}

	public CollisionFlags Move(float deltaTime = 0f, Vector3 dir = default(Vector3))
	{
		return Move(_velocity, deltaTime, dir);
	}

	public State GetState()
	{
		return new State(updatedPosition, updatedRotation, _velocity, _isConstrainedToGround, _unconstrainedTimer, _currentGround.hitGround, _currentGround.isWalkable, _currentGround.normal);
	}

	public void SetState(in State inState)
	{
		SetPositionAndRotation(inState.position, inState.rotation);
		_velocity = inState.velocity;
		_isConstrainedToGround = inState.isConstrainedToGround;
		_unconstrainedTimer = inState.unconstrainedTimer;
		_currentGround.hitGround = inState.hitGround;
		_currentGround.isWalkable = inState.isWalkable;
		_currentGround.hitResult.normal = inState.groundNormal;
	}

	[ContextMenu("Init Collision Layers from Collision Matrix")]
	private void InitCollisionMask()
	{
		int layer = gameObject.layer;
		_collisionLayers = 0;
		for (int i = 0; i < 32; i++)
		{
			if (!Physics.GetIgnoreLayerCollision(layer, i))
			{
				_collisionLayers = (int)_collisionLayers | (1 << i);
			}
		}
	}

	private void Reset()
	{
		SetDimensions(0.5f, 2f);
		SetPlaneConstraint(PlaneConstraint.None, Vector3.zero);
		_slopeLimit = 45f;
		_stepOffset = 0.45f;
		_perchOffset = 0.5f;
		_perchAdditionalHeight = 0.4f;
		_triggerInteraction = QueryTriggerInteraction.Ignore;
		_advanced.Reset();
		_isConstrainedToGround = true;
		_pushForceScale = 1f;
	}

	private void OnValidate()
	{
		SetDimensions(_radius, _height);
		SetPlaneConstraint(_planeConstraint, _constraintPlaneNormal);
		slopeLimit = _slopeLimit;
		stepOffset = _stepOffset;
		perchOffset = _perchOffset;
		perchAdditionalHeight = _perchAdditionalHeight;
		_advanced.OnValidate();
	}

	private void Awake()
	{
		CacheComponents();
		SetDimensions(_radius, _height);
		SetPlaneConstraint(_planeConstraint, _constraintPlaneNormal);
	}

	private void OnEnable()
	{
		updatedPosition = transform.position;
		updatedRotation = transform.rotation;
	}

	private float CliffCapsuleEdgeDistance()
	{
		return Mathf.Max(0f, _radius - 0.1f);
	}

	private bool ProbeCliffGround(Vector3 characterPosition, out FindGroundResult ground)
	{
		float perchRadiusOverride = _perchRadiusOverride;
		_perchRadiusOverride = 0.02f;
		try
		{
			FindGround(characterPosition, out ground);
		}
		finally
		{
			_perchRadiusOverride = perchRadiusOverride;
		}
		return ground.hitGround;
	}

	private Vector3 CliffRimPosition(Vector3 characterPosition, Vector3 outward)
	{
		return characterPosition + outward * CliffCapsuleEdgeDistance();
	}

	private bool IsCliffRimSupported(Vector3 characterPosition, Vector3 outward)
	{
		ProbeCliffGround(CliffRimPosition(characterPosition, outward), out var ground);
		if (!ground.isWalkableGround)
		{
			return CanOffCliff(ground.collider);
		}
		return true;
	}

	private Vector3 SearchRimSegment(Vector3 from, Vector3 to, Vector3 outward, bool testEnd)
	{
		if (testEnd && IsCliffRimSupported(to, outward))
		{
			return to;
		}
		float num = 0f;
		float num2 = 1f;
		for (int i = 0; i < 8; i++)
		{
			float num3 = (num + num2) * 0.5f;
			Vector3 characterPosition = Vector3.Lerp(from, to, num3);
			if (IsCliffRimSupported(characterPosition, outward))
			{
				num = num3;
			}
			else
			{
				num2 = num3;
			}
		}
		return Vector3.Lerp(from, to, num);
	}

	private Vector3 ResolveCliffOutward(FindGroundResult endGround, Vector3 endPosition, Vector3 horizontalDelta)
	{
		if (endGround.hitGround)
		{
			Vector3 vector = (endPosition - endGround.point).projectedOnPlane(_characterUp);
			float value = 0.03f;
			if (vector.sqrMagnitude > value.square())
			{
				return vector.normalized;
			}
		}
		return horizontalDelta.normalized;
	}

	private Vector3 RecoverInsideCliff(Vector3 characterPosition, Vector3 outward)
	{
		float num = CliffCapsuleEdgeDistance() + _radius;
		if (num <= 0.0001f)
		{
			return characterPosition;
		}
		float num2 = -1f;
		float num3 = 0f;
		float num4 = num;
		for (int i = 0; i < 8; i++)
		{
			float num5 = (num3 + num4) * 0.5f;
			Vector3 characterPosition2 = characterPosition - outward * num5;
			if (IsCliffRimSupported(characterPosition2, outward))
			{
				num2 = num5;
				num4 = num5;
			}
			else
			{
				num3 = num5;
			}
		}
		if (num2 < 0f)
		{
			return characterPosition;
		}
		return characterPosition - outward * num2;
	}

	private Vector3 ClipRimDisplacement(Vector3 startPosition, Vector3 endPosition, Vector3 outward)
	{
		Vector3 vector = (endPosition - startPosition).projectedOnPlane(_characterUp);
		if (vector.sqrMagnitude <= 0.0001f)
		{
			return startPosition;
		}
		float num = vector.dot(outward);
		Vector3 vector2 = vector - outward * num;
		Vector3 vector3 = SearchRimSegment(startPosition, endPosition, outward, testEnd: false);
		if (vector2.sqrMagnitude <= 0.0001f)
		{
			return vector3;
		}
		Vector3 normalized = vector2.normalized;
		float num2 = (vector3 - startPosition).projectedOnPlane(_characterUp).dot(normalized);
		float num3 = vector2.magnitude - num2;
		if (num3 <= 0.01f)
		{
			return vector3;
		}
		Vector3 to = vector3 + normalized * num3;
		return SearchRimSegment(vector3, to, outward, testEnd: true);
	}

	private void ApplyCliffEdgeConstraint()
	{
		Vector3 vector = position;
		Vector3 vector2 = updatedPosition;
		Vector3 horizontalDelta = (vector2 - vector).projectedOnPlane(_characterUp);
		FindGround(vector2, out var outGroundResult);
		if (CanOffCliff(outGroundResult.collider))
		{
			_foundGround = outGroundResult;
			return;
		}
		if (horizontalDelta.sqrMagnitude <= 0.0001f)
		{
			_foundGround = outGroundResult;
			return;
		}
		Vector3 outward = ResolveCliffOutward(outGroundResult, vector2, horizontalDelta);
		if (IsCliffRimSupported(vector2, outward))
		{
			_foundGround = outGroundResult;
			return;
		}
		FindGround(vector, out var outGroundResult2);
		if (!outGroundResult2.hitGround)
		{
			return;
		}
		Vector3 vector3 = vector;
		if (!IsCliffRimSupported(vector3, outward))
		{
			vector3 = RecoverInsideCliff(vector3, outward);
		}
		if (!IsCliffRimSupported(vector3, outward))
		{
			updatedPosition = vector;
			_foundGround = outGroundResult2;
			MarkCliffBlockedIfOutwardClipped(vector, vector2, updatedPosition, outward);
			return;
		}
		Vector3 vector4 = vector3 + (vector2 - vector);
		if (!IsCliffRimSupported(vector4, outward))
		{
			vector4 = ClipRimDisplacement(vector3, vector4, outward);
		}
		updatedPosition = vector4;
		FindGround(vector4, out var outGroundResult3);
		if (outGroundResult3.isWalkableGround || CanOffCliff(outGroundResult3.collider))
		{
			_foundGround = outGroundResult3;
			MarkCliffBlockedIfOutwardClipped(vector, vector2, updatedPosition, outward);
		}
		else
		{
			updatedPosition = vector3;
			FindGround(vector3, out _foundGround);
			MarkCliffBlockedIfOutwardClipped(vector, vector2, updatedPosition, outward);
		}
	}

	private void MarkCliffBlockedIfOutwardClipped(Vector3 startPosition, Vector3 desiredEnd, Vector3 actualEnd, Vector3 outward)
	{
		if (detectCliffBlock && !frameCliffBlocked)
		{
			Vector3 characterUp = _characterUp;
			float num = (desiredEnd - startPosition).projectedOnPlane(characterUp).dot(outward);
			float num2 = (actualEnd - startPosition).projectedOnPlane(characterUp).dot(outward);
			if (num > 0.01f && num2 < num - 0.01f)
			{
				frameCliffBlocked = true;
			}
		}
	}

	private static bool CanOffCliff(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanOffCliff) != 0;
	}

	private bool CanOffCliff(Collider otherCollider)
	{
		if (otherCollider == null)
		{
			return false;
		}
		if (collisionBehaviorCallback != null && CanOffCliff(collisionBehaviorCallback(otherCollider)))
		{
			return true;
		}
		return false;
	}

	private static bool CanClimb(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanClimb) != 0;
	}

	private static bool CanNotClimb(CollisionBehavior behaviorFlags)
	{
		return (behaviorFlags & CollisionBehavior.CanNotClimb) != 0;
	}

	private bool CanClimb(Collider otherCollider)
	{
		if (otherCollider == null)
		{
			return false;
		}
		if (collisionBehaviorCallback != null)
		{
			CollisionBehavior behaviorFlags = collisionBehaviorCallback(otherCollider);
			if (CanClimb(behaviorFlags))
			{
				return true;
			}
			CanNotClimb(behaviorFlags);
			return false;
		}
		return false;
	}

	private bool ClimbCompensation(ref CollisionResult inCollision, out float y, float deltaTime, Vector3 dir = default(Vector3), float offset = 0.12f, Vector3 climbVelocity = default(Vector3))
	{
		float num = 1.6f;
		y = 0f;
		Vector3 vector = Vector3.zero;
		Vector3 vector2 = inCollision.position;
		if (inCollision.rigidbody != null)
		{
			vector = inCollision.otherVelocity * deltaTime;
			vector2.y += ((vector.y > 0f) ? vector.y : 0f);
		}
		Vector3 characterUp = _characterUp;
		float sweepRadius = _radius;
		float num2 = num;
		int sweepLayerMask = _collisionLayers;
		bool flag = SweepTest(vector2, sweepRadius, characterUp, num2, sweepLayerMask, out var hitResult, out var startPenetrating);
		if (startPenetrating)
		{
			return false;
		}
		if (!flag)
		{
			vector2 += characterUp * num2;
		}
		else
		{
			vector2 += characterUp * hitResult.distance;
		}
		num2 = _radius * 2f;
		characterUp = ((!(dir == Vector3.zero)) ? dir.normalized : Vector3.ProjectOnPlane(((climbVelocity == default(Vector3)) ? velocity : climbVelocity) - inCollision.otherVelocity, _characterUp).normalized);
		flag = SweepTest(vector2, sweepRadius, characterUp, num2, sweepLayerMask, out hitResult, out startPenetrating);
		if (startPenetrating)
		{
			return false;
		}
		if (!flag)
		{
			vector2 += characterUp * num2;
			characterUp = -_characterUp;
			num2 = num;
			flag = SweepTest(vector2, sweepRadius, characterUp, num2, sweepLayerMask, out hitResult, out startPenetrating);
			if (!flag | startPenetrating)
			{
				return false;
			}
			float num3 = hitResult.point.y - inCollision.position.y;
			float num4 = Mathf.Min(num3, climbCompenAssistOffset);
			y = hitResult.point.y - num4;
			if (vector.y > 0f)
			{
				y += vector.y;
			}
			_ = vector2 + characterUp * hitResult.distance;
			Vector3 inNormal = FindGeomOpposingNormal(characterUp * num2, ref hitResult);
			if (!IsWalkable(hitResult.collider, inNormal))
			{
				return false;
			}
			if (num3 < climbCompenAssistMinOffset)
			{
				return false;
			}
			if (num3 > climbCompenAssistOffset + offset)
			{
				return false;
			}
			RememberClimbSnapReference(y);
			return true;
		}
		return false;
	}

	private void RememberClimbSnapReference(float characterY)
	{
		_climbSnapReferenceY = characterY;
		_hasClimbSnapReference = true;
	}

	public void ClearClimbSnapReference()
	{
		_hasClimbSnapReference = false;
	}

	public void TryResolveCollisionOverlap(Collider[] overlaps, int overlapCount, int depenetrationIterations)
	{
		computePosition = updatedPosition;
		for (int i = 0; i < overlapCount; i++)
		{
			Collider collider = overlaps[i];
			if (!ShouldFilter(collider) && ComputeMTD(computePosition, updatedRotation, collider, collider.transform, out var mtdDirection, out var mtdDistance))
			{
				mtdDirection = ConstrainDirectionToPlane(mtdDirection);
				bool isWalkable = IsWalkable(collider, mtdDirection);
				Vector3 vector = ComputeBlockingNormal(mtdDirection, isWalkable);
				computePosition += vector * (mtdDistance + 0.00125f);
			}
		}
		Vector3 point = computePosition + _transformedCapsuleTopCenter;
		int overlapCount2 = Physics.OverlapCapsuleNonAlloc(computePosition + _transformedCapsuleBottomCenter, point, _radius, _collisionOverlap, _collisionLayers, triggerInteraction);
		collisionOverlapCallback(_collisionOverlap, overlapCount2, depenetrationIterations);
	}

	public int GetCollisionResultRealCount()
	{
		int num = 0;
		for (int i = 0; i < _collisionResults.Length; i++)
		{
			if (_collisionResults[i].collider != null)
			{
				num++;
			}
		}
		return num;
	}

	public Collider[] GetCollisionOverlaps()
	{
		return _collisionOverlap;
	}
}
