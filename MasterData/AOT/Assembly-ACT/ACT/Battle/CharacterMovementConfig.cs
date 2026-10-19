using EasyCharacterMovement;
using UnityEngine;

namespace ACT.Battle;

[DisallowMultipleComponent]
public class CharacterMovementConfig : MonoBehaviour
{
	[Tooltip("约束运动方向")]
	public PlaneConstraint planeConstraint = PlaneConstraint.ConstrainZAxis;

	[Tooltip("根骨骼 Transform（Awake 后由 ApplyTo 写入）")]
	public Transform rootTransform;

	[Tooltip("Root Transform 相对脚底的偏移")]
	public Vector3 rootTransformOffset;

	public float radius = 0.4f;

	public float height = 1.8f;

	public bool colliderEnabled = true;

	public bool colliderIsTrigger;

	[Tooltip("0=X, 1=Y, 2=Z。角色默认应保持 Y 轴")]
	public int colliderDirection = 1;

	public PhysicMaterial colliderMaterial;

	public float rigidbodyMass = 1f;

	public float rigidbodyDrag;

	public float rigidbodyAngularDrag;

	public bool rigidbodyUseGravity;

	public bool rigidbodyIsKinematic = true;

	public RigidbodyInterpolation rigidbodyInterpolation = RigidbodyInterpolation.Interpolate;

	public CollisionDetectionMode rigidbodyCollisionDetectionMode;

	public RigidbodyConstraints rigidbodyConstraints;

	[Tooltip("slopeLimit")]
	public float slopeLimit = 44f;

	[Tooltip("stepOffset")]
	public float stepOffset = 0.45f;

	[Tooltip("perchOffset")]
	public float perchOffset = 0.4f;

	[Tooltip("perchAdditionalHeight")]
	public float perchAdditionalHeight;

	[Tooltip("dodgeAssistOffset")]
	public float dodgeAssistOffset = 0.8f;

	[Tooltip("jumpAssistOffset")]
	public float jumpAssistOffset = 0.1f;

	[Tooltip("ladderOffset")]
	public float ladderOffset = 1f;

	[Tooltip("climbCompensateAssistOffset")]
	public float climbCompensateAssistOffset = 1.5f;

	public bool slopeLimitOverride;

	public bool useFlatTop;

	public bool useFlatBaseForGroundChecks;

	public LayerMask collisionLayers;

	public LayerMask jumpDownIgnoreLayerMask = 0;

	public QueryTriggerInteraction triggerInteraction = QueryTriggerInteraction.Ignore;

	public CharacterMovement.Advanced advanced = new CharacterMovement.Advanced
	{
		maxMovementIterations = 5,
		maxDepenetrationIterations = 2,
		impartPlatformMovement = true
	};

	public void ApplyTo(CharacterMovement cm)
	{
		if (!(cm == null))
		{
			cm.rootTransform = rootTransform;
			cm.rootTransformOffset = rootTransformOffset;
			cm.radius = radius;
			cm.height = height;
			cm.slopeLimit = slopeLimit;
			cm.stepOffset = stepOffset;
			cm.perchOffset = perchOffset;
			cm.perchAdditionalHeight = perchAdditionalHeight;
			cm.dodgeAssistOffset = dodgeAssistOffset;
			cm.jumpAssistOffset = jumpAssistOffset;
			cm.slopeLimitOverride = slopeLimitOverride;
			cm.useFlatTop = useFlatTop;
			cm.useFlatBaseForGroundChecks = useFlatBaseForGroundChecks;
			cm.collisionLayers = collisionLayers;
			cm.triggerInteraction = triggerInteraction;
			cm.SetPlaneConstraint(planeConstraint, Vector3.zero);
			cm.ladderOffset = ladderOffset;
			cm.climbCompenAssistOffset = climbCompensateAssistOffset;
			cm.jumpDownIgnoreLayerMask = jumpDownIgnoreLayerMask;
			cm.advanced = advanced;
			cm.SyncRootTransformPosition();
			ApplyTo(cm.GetComponent<CapsuleCollider>());
			ApplyTo(cm.GetComponent<Rigidbody>());
		}
	}

	public void EnsureRuntimePhysicsComponents(GameObject root)
	{
		if (!(root == null))
		{
			EnsureCapsuleCollider(root);
			EnsureRigidbody(root);
		}
	}

	public CapsuleCollider EnsureCapsuleCollider(GameObject root)
	{
		if (root == null)
		{
			return null;
		}
		CapsuleCollider capsuleCollider = root.GetComponent<CapsuleCollider>();
		if (capsuleCollider == null)
		{
			capsuleCollider = root.AddComponent<CapsuleCollider>();
		}
		ApplyTo(capsuleCollider);
		return capsuleCollider;
	}

	public Rigidbody EnsureRigidbody(GameObject root)
	{
		if (root == null)
		{
			return null;
		}
		Rigidbody rigidbody = root.GetComponent<Rigidbody>();
		if (rigidbody == null)
		{
			rigidbody = root.AddComponent<Rigidbody>();
		}
		ApplyTo(rigidbody);
		return rigidbody;
	}

	public void ApplyTo(CapsuleCollider capsuleCollider)
	{
		if (!(capsuleCollider == null))
		{
			capsuleCollider.enabled = colliderEnabled;
			capsuleCollider.isTrigger = colliderIsTrigger;
			capsuleCollider.direction = Mathf.Clamp(colliderDirection, 0, 2);
			capsuleCollider.sharedMaterial = colliderMaterial;
			capsuleCollider.radius = radius;
			capsuleCollider.height = Mathf.Max(height, radius * 2f);
			capsuleCollider.center = Vector3.up * (capsuleCollider.height * 0.5f);
		}
	}

	public void ApplyTo(Rigidbody rb)
	{
		if (!(rb == null))
		{
			rb.mass = rigidbodyMass;
			rb.drag = rigidbodyDrag;
			rb.angularDrag = rigidbodyAngularDrag;
			rb.useGravity = rigidbodyUseGravity;
			rb.isKinematic = rigidbodyIsKinematic;
			rb.interpolation = rigidbodyInterpolation;
			rb.collisionDetectionMode = rigidbodyCollisionDetectionMode;
			rb.constraints = rigidbodyConstraints;
		}
	}

	public void CaptureFromRuntimeComponents(CapsuleCollider capsuleCollider, Rigidbody rb)
	{
		if (capsuleCollider != null)
		{
			radius = capsuleCollider.radius;
			height = capsuleCollider.height;
			colliderEnabled = capsuleCollider.enabled;
			colliderIsTrigger = capsuleCollider.isTrigger;
			colliderDirection = capsuleCollider.direction;
			colliderMaterial = capsuleCollider.sharedMaterial;
		}
		if (rb != null)
		{
			rigidbodyMass = rb.mass;
			rigidbodyDrag = rb.drag;
			rigidbodyAngularDrag = rb.angularDrag;
			rigidbodyUseGravity = rb.useGravity;
			rigidbodyIsKinematic = rb.isKinematic;
			rigidbodyInterpolation = rb.interpolation;
			rigidbodyCollisionDetectionMode = rb.collisionDetectionMode;
			rigidbodyConstraints = rb.constraints;
		}
	}
}
