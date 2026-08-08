using System;
using Spine;
using Spine.Unity;
using UnityEngine;

[DisallowMultipleComponent]
[DefaultExecutionOrder(1000)]
public sealed class VehicleSoftOvalShadowController : MonoBehaviour
{
	private const string ArenaFloorName = "ArenaFloor";

	[Header("Spine Wheel Fallback")]
	[SerializeField]
	private string frontWheelBoneName = "FrontWheel";

	[SerializeField]
	private string rearWheelBoneName = "BackWheel";

	[SerializeField]
	private SkeletonAnimation skeletonAnimation;

	[SerializeField]
	private SkeletonGraphic skeletonGraphic;

	[Header("Runtime Wheel References")]
	[SerializeField]
	private Transform frontWheelTransform;

	[SerializeField]
	private Transform rearWheelTransform;

	[SerializeField]
	[Min(0f)]
	private float frontWheelRadius;

	[SerializeField]
	[Min(0f)]
	private float rearWheelRadius;

	[SerializeField]
	private Transform shadowTransform;

	[SerializeField]
	private SpriteRenderer shadowRenderer;

	[Header("Ground Sampling")]
	[SerializeField]
	private LayerMask groundLayer = -1;

	[SerializeField]
	[Min(0.01f)]
	private float groundRaycastHeight = 4f;

	[SerializeField]
	[Min(0.01f)]
	private float groundRaycastDistance = 8f;

	[SerializeField]
	[Range(0f, 1f)]
	private float minGroundHitNormalY = 0.35f;

	[Header("Shape")]
	[SerializeField]
	[Min(0.01f)]
	private float overallScaleMultiplier = 3f;

	[SerializeField]
	[Min(0.01f)]
	private float baseLengthMultiplier = 1.18f;

	[SerializeField]
	[Min(0.01f)]
	private float baseThickness = 0.22f;

	[SerializeField]
	[Min(0.01f)]
	private float maxWheelLift = 0.85f;

	[SerializeField]
	[Range(0.01f, 1f)]
	private float minLengthRatio = 0.42f;

	[SerializeField]
	[Min(0.01f)]
	private float maxLengthRatio = 1.2f;

	[Header("Alpha And Height")]
	[SerializeField]
	[Range(0f, 1f)]
	private float groundedAlpha = 0.42f;

	[SerializeField]
	[Range(0f, 1f)]
	private float airborneAlpha = 0.18f;

	[SerializeField]
	[Range(0f, 2f)]
	private float liftFadeFactor = 1f;

	[SerializeField]
	[Min(0.01f)]
	private float heightScaleFactor = 1.18f;

	[Header("Placement")]
	[SerializeField]
	private float lightOffsetX;

	[SerializeField]
	private float yOffsetFromGround = -0.03f;

	[SerializeField]
	[Min(0f)]
	private float smoothing = 18f;

	[Header("Rendering")]
	[SerializeField]
	private Color shadowColor = new Color(0f, 0f, 0f, 1f);

	[SerializeField]
	private string sortingLayerName = string.Empty;

	[SerializeField]
	private int sortingOrderOffset = -8;

	private Bone frontWheelBone;

	private Bone rearWheelBone;

	private readonly RaycastHit2D[] groundHits = new RaycastHit2D[8];

	private bool initialized;

	private bool ownsShadowTransform;

	private bool presentationVisible = true;

	private Vector3 smoothedPosition;

	private Vector3 smoothedScale;

	private float smoothedAlpha;

	private float baseLength = 1f;

	public void ConfigureRuntime(SkeletonAnimation bodySkeletonAnimation, Transform bodyVisualRoot, Transform frontWheel, Transform rearWheel, float frontRadius, float rearRadius, Renderer bodyRenderer, LayerMask groundMask)
	{
		skeletonAnimation = ((bodySkeletonAnimation != null) ? bodySkeletonAnimation : skeletonAnimation);
		if (skeletonAnimation == null && bodyVisualRoot != null)
		{
			skeletonAnimation = bodyVisualRoot.GetComponent<SkeletonAnimation>();
		}
		frontWheelTransform = ((frontWheel != null) ? frontWheel : frontWheelTransform);
		rearWheelTransform = ((rearWheel != null) ? rearWheel : rearWheelTransform);
		frontWheelRadius = Mathf.Max(0f, frontRadius);
		rearWheelRadius = Mathf.Max(0f, rearRadius);
		groundLayer = groundMask;
		if (bodyRenderer != null)
		{
			sortingLayerName = bodyRenderer.sortingLayerName;
			int sortingOrder = bodyRenderer.sortingOrder + sortingOrderOffset;
			EnsureShadowRenderer();
			shadowRenderer.sortingLayerID = bodyRenderer.sortingLayerID;
			shadowRenderer.sortingOrder = sortingOrder;
		}
		ResolveBones();
		RecomputeBaseLength();
		ForceSnap();
	}

	private void Reset()
	{
		skeletonAnimation = GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		skeletonGraphic = GetComponentInChildren<SkeletonGraphic>(includeInactive: true);
		frontWheelTransform = base.transform.Find("FrontWheel");
		rearWheelTransform = base.transform.Find("BackWheel");
	}

	private void Awake()
	{
		EnsureShadowRenderer();
		ResolveBones();
		RecomputeBaseLength();
		ForceSnap();
	}

	private void LateUpdate()
	{
		UpdateShadow(Time.deltaTime);
	}

	private void OnValidate()
	{
		overallScaleMultiplier = Mathf.Max(0.01f, overallScaleMultiplier);
		baseLengthMultiplier = Mathf.Max(0.01f, baseLengthMultiplier);
		baseThickness = Mathf.Max(0.01f, baseThickness);
		frontWheelRadius = Mathf.Max(0f, frontWheelRadius);
		rearWheelRadius = Mathf.Max(0f, rearWheelRadius);
		maxWheelLift = Mathf.Max(0.01f, maxWheelLift);
		minLengthRatio = Mathf.Clamp(minLengthRatio, 0.01f, 1f);
		maxLengthRatio = Mathf.Max(minLengthRatio, maxLengthRatio);
		heightScaleFactor = Mathf.Max(0.01f, heightScaleFactor);
		minGroundHitNormalY = Mathf.Clamp01(minGroundHitNormalY);
		smoothing = Mathf.Max(0f, smoothing);
	}

	private void ForceSnap()
	{
		Vector3 targetPosition;
		Vector3 targetScale;
		float targetAlpha;
		if (!Application.isPlaying)
		{
			initialized = false;
		}
		else if (TryEvaluateShadow(out targetPosition, out targetScale, out targetAlpha))
		{
			smoothedPosition = targetPosition;
			smoothedScale = targetScale;
			smoothedAlpha = targetAlpha;
			initialized = true;
			ApplyShadow(smoothedPosition, smoothedScale, smoothedAlpha);
		}
	}

	private void UpdateShadow(float dt)
	{
		EnsureShadowRenderer();
		ResolveBones();
		if (!presentationVisible)
		{
			if (shadowRenderer != null)
			{
				shadowRenderer.enabled = false;
			}
			return;
		}
		if (!TryEvaluateShadow(out var targetPosition, out var targetScale, out var targetAlpha))
		{
			if (shadowRenderer != null)
			{
				shadowRenderer.enabled = false;
			}
			return;
		}
		if (shadowRenderer != null)
		{
			shadowRenderer.enabled = true;
		}
		float t = ((smoothing <= 0f) ? 1f : (1f - Mathf.Exp((0f - smoothing) * Mathf.Max(0f, dt))));
		if (!initialized)
		{
			smoothedPosition = targetPosition;
			smoothedScale = targetScale;
			smoothedAlpha = targetAlpha;
			initialized = true;
		}
		else
		{
			smoothedPosition = targetPosition;
			smoothedScale = Vector3.Lerp(smoothedScale, targetScale, t);
			smoothedAlpha = Mathf.Lerp(smoothedAlpha, targetAlpha, t);
		}
		ApplyShadow(smoothedPosition, smoothedScale, smoothedAlpha);
	}

	public void SetPresentationVisible(bool visible)
	{
		presentationVisible = visible;
		if (shadowRenderer != null)
		{
			shadowRenderer.enabled = visible;
		}
	}

	private bool TryEvaluateShadow(out Vector3 targetPosition, out Vector3 targetScale, out float targetAlpha)
	{
		targetPosition = base.transform.position;
		targetScale = Vector3.one;
		targetAlpha = 0f;
		if (!TryResolveWheelWorldPosition(front: true, out var world) || !TryResolveWheelWorldPosition(front: false, out var world2))
		{
			return false;
		}
		float num = ResolveGroundY(world);
		float num2 = ResolveGroundY(world2);
		if (!IsFinite(num) || !IsFinite(num2))
		{
			return false;
		}
		float num3 = Mathf.Max(0f, world.y - num);
		float num4 = Mathf.Max(0f, world2.y - num2);
		float t = Mathf.Clamp01(num3 / maxWheelLift);
		float t2 = Mathf.Clamp01(num4 / maxWheelLift);
		float x = world.x;
		float x2 = world2.x;
		float b = (x + x2) * 0.5f;
		float num5 = Mathf.Lerp(x, b, t);
		float num6 = Mathf.Lerp(x2, b, t2);
		float num7 = Mathf.Abs(x2 - x) * baseLengthMultiplier;
		if (num7 > 0.0001f)
		{
			baseLength = Mathf.Max(baseLength, num7);
		}
		float value = Mathf.Abs(num6 - num5) * baseLengthMultiplier;
		value = Mathf.Clamp(value, baseLength * minLengthRatio, baseLength * maxLengthRatio);
		float num8 = (num5 + num6) * 0.5f;
		float num9 = (num3 + num4) * 0.5f;
		float num10 = Mathf.Clamp01(num9 / maxWheelLift);
		targetAlpha = Mathf.Lerp(groundedAlpha, airborneAlpha, Mathf.Clamp01(num10 * liftFadeFactor));
		num8 += num9 * lightOffsetX;
		float y = (num + num2) * 0.5f + yOffsetFromGround;
		targetPosition = new Vector3(num8, y, base.transform.position.z);
		targetScale = new Vector3(Mathf.Max(0.01f, value * overallScaleMultiplier), Mathf.Max(0.01f, baseThickness * Mathf.Lerp(1f, heightScaleFactor, num10) * overallScaleMultiplier), 1f);
		return true;
	}

	private bool TryResolveWheelWorldPosition(bool front, out Vector3 world)
	{
		Transform transform = (front ? frontWheelTransform : rearWheelTransform);
		if (transform != null)
		{
			world = transform.position;
			return IsFinite(world);
		}
		Bone bone = (front ? frontWheelBone : rearWheelBone);
		if (bone != null && skeletonAnimation != null)
		{
			world = skeletonAnimation.transform.TransformPoint(new Vector3(bone.WorldX, bone.WorldY, 0f));
			return IsFinite(world);
		}
		if (bone != null && skeletonGraphic != null)
		{
			world = skeletonGraphic.transform.TransformPoint(new Vector3(bone.WorldX, bone.WorldY, 0f));
			return IsFinite(world);
		}
		world = default(Vector3);
		return false;
	}

	private float ResolveGroundY(Vector3 wheelWorld)
	{
		int num = Physics2D.RaycastNonAlloc(new Vector2(wheelWorld.x, wheelWorld.y + groundRaycastHeight), Vector2.down, groundHits, groundRaycastHeight + groundRaycastDistance, groundLayer);
		float num2 = float.NegativeInfinity;
		bool flag = false;
		for (int i = 0; i < num; i++)
		{
			Collider2D collider = groundHits[i].collider;
			if (!(collider == null) && !collider.isTrigger && !ShouldIgnoreGroundHit(collider) && IsArenaFloorCollider(collider) && !(groundHits[i].normal.y < minGroundHitNormalY))
			{
				Rigidbody2D attachedRigidbody = collider.attachedRigidbody;
				if ((!(attachedRigidbody != null) || attachedRigidbody.bodyType == RigidbodyType2D.Static) && (!flag || groundHits[i].point.y > num2))
				{
					num2 = groundHits[i].point.y;
					flag = true;
				}
			}
		}
		if (flag)
		{
			return num2;
		}
		return float.NaN;
	}

	private static bool IsArenaFloorCollider(Collider2D hitCollider)
	{
		Transform transform = ((hitCollider != null) ? hitCollider.transform : null);
		while (transform != null)
		{
			if (transform.name == "ArenaFloor")
			{
				return true;
			}
			transform = transform.parent;
		}
		return false;
	}

	private void EnsureShadowRenderer()
	{
		if (shadowTransform == null)
		{
			Transform transform = base.transform.Find("SoftOvalShadow");
			if (transform == null)
			{
				GameObject obj = UnityEngine.Object.Instantiate(SummerRaceConfigLoader.LoadSoftOvalShadowPrefabOrThrow(base.name + " soft oval shadow"));
				obj.name = "SoftOvalShadow";
				obj.transform.SetParent((base.transform.parent != null) ? base.transform.parent : base.transform, worldPositionStays: true);
				transform = obj.transform;
				ownsShadowTransform = true;
			}
			shadowTransform = transform;
		}
		if (shadowRenderer == null)
		{
			shadowRenderer = shadowTransform.GetComponent<SpriteRenderer>();
			if (shadowRenderer == null)
			{
				throw new InvalidOperationException("[SummerRace] Soft oval shadow prefab instance missing SpriteRenderer. owner=" + base.name);
			}
		}
		if (shadowRenderer.sprite == null)
		{
			throw new InvalidOperationException("[SummerRace] Soft oval shadow prefab instance missing sprite. owner=" + base.name);
		}
		if (shadowRenderer.sharedMaterial == null)
		{
			throw new InvalidOperationException("[SummerRace] Soft oval shadow prefab instance missing material. owner=" + base.name);
		}
		shadowRenderer.color = new Color(shadowColor.r, shadowColor.g, shadowColor.b, groundedAlpha);
		shadowRenderer.enabled = true;
		shadowRenderer.forceRenderingOff = false;
		if (!string.IsNullOrWhiteSpace(sortingLayerName))
		{
			shadowRenderer.sortingLayerName = sortingLayerName;
		}
	}

	private void ApplyShadow(Vector3 worldPosition, Vector3 worldScale, float alpha)
	{
		if (!(shadowTransform == null) && !(shadowRenderer == null))
		{
			shadowTransform.position = worldPosition;
			shadowTransform.rotation = Quaternion.identity;
			shadowTransform.localScale = worldScale;
			shadowRenderer.color = new Color(shadowColor.r, shadowColor.g, shadowColor.b, Mathf.Clamp01(alpha));
		}
	}

	private void OnDestroy()
	{
		if (ownsShadowTransform && !(shadowTransform == null) && !(shadowTransform == base.transform))
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(shadowTransform.gameObject);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(shadowTransform.gameObject);
			}
		}
	}

	private void ResolveBones()
	{
		if (skeletonAnimation == null)
		{
			skeletonAnimation = GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		}
		if (skeletonGraphic == null)
		{
			skeletonGraphic = GetComponentInChildren<SkeletonGraphic>(includeInactive: true);
		}
		frontWheelBone = ResolveBone(skeletonAnimation, skeletonGraphic, frontWheelBoneName);
		rearWheelBone = ResolveBone(skeletonAnimation, skeletonGraphic, rearWheelBoneName);
	}

	private static Bone ResolveBone(SkeletonAnimation animation, SkeletonGraphic graphic, string boneName)
	{
		if (string.IsNullOrWhiteSpace(boneName))
		{
			return null;
		}
		if (animation != null && animation.Skeleton != null)
		{
			Bone bone = animation.Skeleton.FindBone(boneName);
			if (bone != null)
			{
				return bone;
			}
		}
		if (graphic != null && graphic.Skeleton != null)
		{
			return graphic.Skeleton.FindBone(boneName);
		}
		return null;
	}

	private void RecomputeBaseLength()
	{
		if (TryResolveWheelWorldPosition(front: true, out var world) && TryResolveWheelWorldPosition(front: false, out var world2))
		{
			baseLength = Mathf.Max(baseLength, Mathf.Abs(world2.x - world.x) * baseLengthMultiplier);
		}
	}

	private static bool IsFinite(Vector3 value)
	{
		if (IsFinite(value.x) && IsFinite(value.y))
		{
			return IsFinite(value.z);
		}
		return false;
	}

	private static bool IsFinite(float value)
	{
		if (!float.IsNaN(value))
		{
			return !float.IsInfinity(value);
		}
		return false;
	}

	private bool ShouldIgnoreGroundHit(Collider2D hitCollider)
	{
		if (hitCollider == null)
		{
			return false;
		}
		Transform transform = hitCollider.transform;
		if (transform == base.transform || transform.IsChildOf(base.transform))
		{
			return true;
		}
		return hitCollider.GetComponentInParent<SummerRaceCharacterBase>() != null;
	}
}
