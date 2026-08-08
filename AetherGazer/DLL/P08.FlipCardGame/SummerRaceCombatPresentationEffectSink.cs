using System;
using System.Collections.Generic;
using Spine;
using Spine.Unity;
using UnityEngine;

[DisallowMultipleComponent]
public sealed class SummerRaceCombatPresentationEffectSink : MonoBehaviour, ISummerRaceCombatPresentationSink
{
	private sealed class ActiveSpriteEffect
	{
		public Transform Transform;

		public SpriteRenderer Renderer;

		public float StartTime;

		public float Lifetime;

		public Vector3 StartScale;

		public Vector3 EndScale;

		public Color StartColor;

		public Color EndColor;

		public Vector2 Velocity;
	}

	private sealed class HookVisualSession
	{
		public string Key;

		public UtilityModuleDefinition Def;

		public Transform Root;

		public Transform Anchor;

		public Transform MountVisualRoot;

		public Transform SourceTransform;

		public Transform TargetTransform;

		public Transform Head;

		public SkeletonAnimation HeadAnimation;

		public Transform Rope;

		public SkeletonAnimation RopeAnimation;

		public Transform HeadHitbox;

		public Transform HookPointLeft;

		public Transform HookPointRight;

		public Vector2 SourcePoint;

		public Vector2 TargetPoint;

		public Vector2 LaunchDirection;

		public string CurrentHeadAnimationName;

		public bool IsRecycling;

		public bool PendingRelease;

		public bool IsFlightVisible;

		public bool IsLatchedImpact;

		public bool IsHeadDetached;

		public Transform HeadOriginalParent;

		public int HeadOriginalSibling;

		public Vector3 HeadDockLocalScale;

		public Quaternion HeadFlightWorldRotation;

		public Vector3 LatchedHeadLocalPositionOffset;

		public Quaternion LatchedHeadRotationOffset;

		public float LatchedHeadFixedEulerX;

		public float LatchedHeadFixedEulerY;

		public float LatchedHeadZOffsetFromTarget;

		public Transform LatchedRotationTarget;

		public bool HasLatchedRotationOffset;

		public float HeadFlightFixedY;

		public float HeadFlightFixedZ;

		public float RecycleTotalDistance;

		public float NextEndpointLogAt;
	}

	private const int BodyBand = 0;

	private const int WeaponEquipEffectFrontBand = 4;

	private const int WeaponEquipBand = 3;

	private const string HookUnifiedVisualRootName = "Visual";

	private const float HookHeadLocalPosX = -0.3f;

	private const float HookHeadLocalPosY = 0.05f;

	private const int HookHeadSortingOrderDeltaFromMountVisual = -1;

	private const int HookRopeSortingOrderDeltaFromHead = -1;

	private const string HookHeadDefaultAnimationName = "default";

	private const string HookHeadAtkAnimationName = "atk";

	private const string HookPointLeftName = "HookPointLeft";

	private const string HookPointRightName = "HookPointRight";

	private const float HookRopeAuthoringLength = 2.54f;

	private const float HookRopeInitialLength = 0.254f;

	private const float HookRopeUnitsToPx = 100f;

	private const float HookRopeEndpointLogInterval = 0.12f;

	[SerializeField]
	private int transientSortingOrder = 340;

	[SerializeField]
	private bool enableTransientSpriteEffects;

	[SerializeField]
	private bool hookTraceLog = true;

	[SerializeField]
	private float hookRecycleSpeed = 18f;

	[SerializeField]
	[Range(0f, 1f)]
	private float hookRecycleEaseOutPortion = 0.35f;

	[SerializeField]
	[Range(0.05f, 1f)]
	private float hookRecycleMinSpeedScale = 0.2f;

	private readonly List<ActiveSpriteEffect> activeEffects = new List<ActiveSpriteEffect>(24);

	private readonly Stack<ActiveSpriteEffect> pooledEffects = new Stack<ActiveSpriteEffect>(24);

	private readonly Dictionary<string, HookVisualSession> hookSessions = new Dictionary<string, HookVisualSession>(8);

	private readonly List<string> hookSessionRemovalScratch = new List<string>(4);

	private Transform effectRoot;

	private void LateUpdate()
	{
		for (int num = activeEffects.Count - 1; num >= 0; num--)
		{
			ActiveSpriteEffect activeSpriteEffect = activeEffects[num];
			if (activeSpriteEffect == null || activeSpriteEffect.Transform == null || activeSpriteEffect.Renderer == null)
			{
				activeEffects.RemoveAt(num);
			}
			else
			{
				float num2 = Mathf.Max(0.01f, activeSpriteEffect.Lifetime);
				float num3 = Mathf.Clamp01((Time.time - activeSpriteEffect.StartTime) / num2);
				if (num3 >= 1f)
				{
					RecycleEffect(activeSpriteEffect);
					activeEffects.RemoveAt(num);
				}
				else
				{
					activeSpriteEffect.Transform.position += (Vector3)(activeSpriteEffect.Velocity * Time.deltaTime);
					activeSpriteEffect.Transform.localScale = Vector3.LerpUnclamped(activeSpriteEffect.StartScale, activeSpriteEffect.EndScale, num3);
					activeSpriteEffect.Renderer.color = Color.LerpUnclamped(activeSpriteEffect.StartColor, activeSpriteEffect.EndColor, num3);
				}
			}
		}
		if (hookSessions.Count <= 0)
		{
			return;
		}
		hookSessionRemovalScratch.Clear();
		foreach (KeyValuePair<string, HookVisualSession> hookSession in hookSessions)
		{
			if (IsHookSessionInvalid(hookSession.Value))
			{
				CleanupHookSessionArtifacts(hookSession.Value);
				hookSessionRemovalScratch.Add(hookSession.Key);
			}
			else
			{
				UpdateHookSession(hookSession.Value, Time.deltaTime);
			}
		}
		for (int i = 0; i < hookSessionRemovalScratch.Count; i++)
		{
			hookSessions.Remove(hookSessionRemovalScratch[i]);
		}
		hookSessionRemovalScratch.Clear();
	}

	private void OnDestroy()
	{
		if (effectRoot != null)
		{
			UnityEngine.Object.Destroy(effectRoot.gameObject);
			effectRoot = null;
		}
		hookSessions.Clear();
	}

	public void HandleWeaponPresentation(SummerRaceWeaponPresentationEvent presentationEvent)
	{
		if (presentationEvent.WeaponDefinition == null)
		{
			return;
		}
		if (presentationEvent.Phase == SummerRacePresentationPhase.Fired && presentationEvent.DeliveryKind != SummerRacePresentationDeliveryKind.SpinMelee)
		{
			PlayWeaponEmitterFireAnimationOrThrow(presentationEvent);
		}
		if (presentationEvent.DeliveryKind == SummerRacePresentationDeliveryKind.SpinMelee)
		{
			if (presentationEvent.Phase == SummerRacePresentationPhase.Activated)
			{
				SetWeaponEmitterStateOrThrow(presentationEvent, useFireAnimation: true, loop: true);
			}
			else if (presentationEvent.Phase == SummerRacePresentationPhase.ActiveExpired)
			{
				SetWeaponEmitterStateOrThrow(presentationEvent, useFireAnimation: false, loop: true);
			}
		}
		SummerRaceWeaponPresentationProfile profile = SummerRaceWeaponPresentationProfileResolver.Resolve(presentationEvent.WeaponDefinition);
		if (presentationEvent.DeliveryKind == SummerRacePresentationDeliveryKind.Beam)
		{
			HandleBeamPresentation(presentationEvent, profile);
			return;
		}
		if (presentationEvent.DeliveryKind == SummerRacePresentationDeliveryKind.SpinMelee)
		{
			HandleSpinMeleePresentation(presentationEvent, profile);
			return;
		}
		switch (presentationEvent.Phase)
		{
		case SummerRacePresentationPhase.Fired:
			EmitMuzzleFlash(presentationEvent.SourcePoint, presentationEvent.Direction, profile);
			break;
		case SummerRacePresentationPhase.Impact:
			EmitImpact(presentationEvent.TargetPoint, presentationEvent.Direction, profile);
			break;
		}
	}

	public void HandleWeaponOverloadPresentation(SummerRaceWeaponOverloadPresentationEvent presentationEvent)
	{
	}

	public void HandleEquipPresentation(SummerRaceEquipPresentationEvent presentationEvent)
	{
		if (presentationEvent.EquipDefinition == null)
		{
			return;
		}
		if (presentationEvent.Phase == SummerRacePresentationPhase.Activated)
		{
			PlayEquipEmitterFireAnimationOrThrow(presentationEvent);
		}
		if (presentationEvent.DeliveryKind == SummerRacePresentationDeliveryKind.Dash || presentationEvent.DeliveryKind == SummerRacePresentationDeliveryKind.ShieldAura)
		{
			if (presentationEvent.Phase == SummerRacePresentationPhase.Activated)
			{
				SetEquipEmitterStateOrThrow(presentationEvent, useFireAnimation: true, loop: true);
			}
			else if (presentationEvent.Phase == SummerRacePresentationPhase.ActiveExpired)
			{
				SetEquipEmitterStateOrThrow(presentationEvent, useFireAnimation: false, loop: true);
			}
		}
		if (presentationEvent.DeliveryKind == SummerRacePresentationDeliveryKind.HookLine)
		{
			HandleHookLinePresentation(presentationEvent);
		}
	}

	public void HandleProjectilePresentation(SummerRaceProjectilePresentationEvent presentationEvent)
	{
		if (!(presentationEvent.WeaponDefinition == null))
		{
			SummerRaceWeaponPresentationProfile profile = SummerRaceWeaponPresentationProfileResolver.Resolve(presentationEvent.WeaponDefinition);
			SummerRacePresentationDeliveryKind deliveryKind = presentationEvent.DeliveryKind;
			if (deliveryKind != SummerRacePresentationDeliveryKind.Rocket)
			{
				_ = 4;
			}
			else if (presentationEvent.Phase == SummerRacePresentationPhase.Spawned)
			{
				EmitRocketSpawnExhaust(presentationEvent.Position, presentationEvent.Direction, profile);
			}
		}
	}

	public float HandleDefeatPresentation(SummerRaceDefeatPresentationEvent presentationEvent)
	{
		return 0f;
	}

	private static void PlayWeaponEmitterFireAnimationOrThrow(SummerRaceWeaponPresentationEvent presentationEvent)
	{
		if (presentationEvent.MountPoint == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Weapon fired event is missing mount point. weapon=" + ((presentationEvent.WeaponDefinition != null) ? presentationEvent.WeaponDefinition.name : "<null>"));
		}
		if (presentationEvent.WeaponDefinition == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Weapon fired event is missing weapon definition.");
		}
		string emitterIdleAnimName = presentationEvent.WeaponDefinition.EmitterIdleAnimName;
		string emitterFireAnimName = presentationEvent.WeaponDefinition.EmitterFireAnimName;
		if (string.IsNullOrWhiteSpace(emitterIdleAnimName) || string.IsNullOrWhiteSpace(emitterFireAnimName))
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing emitter animation contract on weapon=" + presentationEvent.WeaponDefinition.name);
		}
		GameObject visualInstance = presentationEvent.MountPoint.VisualInstance;
		if (visualInstance == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing mounted visual instance for weapon=" + presentationEvent.WeaponDefinition.name + " mount=" + presentationEvent.MountPoint.LocalId);
		}
		SkeletonAnimation componentInChildren = visualInstance.GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		if (componentInChildren == null || componentInChildren.AnimationState == null || componentInChildren.Skeleton == null || componentInChildren.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing SkeletonAnimation on mounted weapon visual. weapon=" + presentationEvent.WeaponDefinition.name + " mount=" + presentationEvent.MountPoint.LocalId);
		}
		if (IsNoneAnimationToken(emitterFireAnimName))
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Weapon fire animation cannot be NONE token. weapon=" + presentationEvent.WeaponDefinition.name);
		}
		if (componentInChildren.Skeleton.Data.FindAnimation(emitterFireAnimName) == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing fire animation '" + emitterFireAnimName + "' on weapon=" + presentationEvent.WeaponDefinition.name);
		}
		if (!IsNoneAnimationToken(emitterIdleAnimName) && componentInChildren.Skeleton.Data.FindAnimation(emitterIdleAnimName) == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing idle animation '" + emitterIdleAnimName + "' on weapon=" + presentationEvent.WeaponDefinition.name);
		}
		componentInChildren.AnimationState.SetAnimation(0, emitterFireAnimName, loop: false);
		if (IsNoneAnimationToken(emitterIdleAnimName))
		{
			componentInChildren.AnimationState.AddEmptyAnimation(0, 0f, 0f);
		}
		else
		{
			componentInChildren.AnimationState.AddAnimation(0, emitterIdleAnimName, loop: true, 0f);
		}
	}

	private static void PlayEquipEmitterFireAnimationOrThrow(SummerRaceEquipPresentationEvent presentationEvent)
	{
		if (presentationEvent.MountPoint == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Equip activated event is missing mount point. equip=" + ((presentationEvent.EquipDefinition != null) ? presentationEvent.EquipDefinition.name : "<null>"));
		}
		if (presentationEvent.EquipDefinition == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Equip activated event is missing equip definition.");
		}
		string emitterIdleAnimName = presentationEvent.EquipDefinition.EmitterIdleAnimName;
		string emitterFireAnimName = presentationEvent.EquipDefinition.EmitterFireAnimName;
		if (string.IsNullOrWhiteSpace(emitterIdleAnimName) || string.IsNullOrWhiteSpace(emitterFireAnimName))
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing emitter animation contract on equip=" + presentationEvent.EquipDefinition.name);
		}
		GameObject visualInstance = presentationEvent.MountPoint.VisualInstance;
		if (visualInstance == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing mounted visual instance for equip=" + presentationEvent.EquipDefinition.name + " mount=" + presentationEvent.MountPoint.LocalId);
		}
		SkeletonAnimation componentInChildren = visualInstance.GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		if (componentInChildren == null || componentInChildren.AnimationState == null || componentInChildren.Skeleton == null || componentInChildren.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing SkeletonAnimation on mounted equip visual. equip=" + presentationEvent.EquipDefinition.name + " mount=" + presentationEvent.MountPoint.LocalId);
		}
		if (IsNoneAnimationToken(emitterFireAnimName))
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Equip fire animation cannot be NONE token. equip=" + presentationEvent.EquipDefinition.name);
		}
		if (componentInChildren.Skeleton.Data.FindAnimation(emitterFireAnimName) == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing fire animation '" + emitterFireAnimName + "' on equip=" + presentationEvent.EquipDefinition.name);
		}
		if (!IsNoneAnimationToken(emitterIdleAnimName) && componentInChildren.Skeleton.Data.FindAnimation(emitterIdleAnimName) == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing idle animation '" + emitterIdleAnimName + "' on equip=" + presentationEvent.EquipDefinition.name);
		}
		componentInChildren.AnimationState.SetAnimation(0, emitterFireAnimName, loop: false);
		if (IsNoneAnimationToken(emitterIdleAnimName))
		{
			componentInChildren.AnimationState.AddEmptyAnimation(0, 0f, 0f);
		}
		else
		{
			componentInChildren.AnimationState.AddAnimation(0, emitterIdleAnimName, loop: true, 0f);
		}
	}

	private static void SetWeaponEmitterStateOrThrow(SummerRaceWeaponPresentationEvent presentationEvent, bool useFireAnimation, bool loop)
	{
		SkeletonAnimation skeletonAnimation = ResolveEmitterSkeletonAnimationOrThrow(presentationEvent.MountPoint, "weapon", (presentationEvent.WeaponDefinition != null) ? presentationEvent.WeaponDefinition.name : "<null>");
		string text = (useFireAnimation ? presentationEvent.WeaponDefinition.EmitterFireAnimName : presentationEvent.WeaponDefinition.EmitterIdleAnimName);
		if (IsNoneAnimationToken(text))
		{
			SetEmitterToSetupPose(skeletonAnimation);
			return;
		}
		ValidateAnimationExistsOrThrow(skeletonAnimation, text, "weapon", presentationEvent.WeaponDefinition.name);
		TrackEntry current = skeletonAnimation.AnimationState.GetCurrent(0);
		float timeScale = (((SummerRaceCombatPresentationRouter.ResolveWeaponKind(presentationEvent.WeaponDefinition) == WeaponKind.RotatingSaw) & useFireAnimation) ? Mathf.Clamp01(presentationEvent.WeaponDefinition.RotatingSawSpinSpeedScale) : 1f);
		if (current != null && current.Animation != null && string.Equals(current.Animation.Name, text, StringComparison.Ordinal) && current.Loop == loop)
		{
			current.TimeScale = timeScale;
		}
		else
		{
			skeletonAnimation.AnimationState.SetAnimation(0, text, loop).TimeScale = timeScale;
		}
	}

	private static void SetEquipEmitterStateOrThrow(SummerRaceEquipPresentationEvent presentationEvent, bool useFireAnimation, bool loop)
	{
		SkeletonAnimation skeletonAnimation = ResolveEmitterSkeletonAnimationOrThrow(presentationEvent.MountPoint, "equip", (presentationEvent.EquipDefinition != null) ? presentationEvent.EquipDefinition.name : "<null>");
		string animationName = (useFireAnimation ? presentationEvent.EquipDefinition.EmitterFireAnimName : presentationEvent.EquipDefinition.EmitterIdleAnimName);
		if (IsNoneAnimationToken(animationName))
		{
			SetEmitterToSetupPose(skeletonAnimation);
			return;
		}
		ValidateAnimationExistsOrThrow(skeletonAnimation, animationName, "equip", presentationEvent.EquipDefinition.name);
		skeletonAnimation.AnimationState.SetAnimation(0, animationName, loop);
	}

	private static SkeletonAnimation ResolveEmitterSkeletonAnimationOrThrow(MountPoint mountPoint, string category, string defName)
	{
		if (mountPoint == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing mount point while resolving emitter animation. type=" + category + ", def=" + defName);
		}
		GameObject visualInstance = mountPoint.VisualInstance;
		if (visualInstance == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing mounted visual instance while resolving emitter animation. type=" + category + ", def=" + defName + ", mount=" + mountPoint.LocalId);
		}
		SkeletonAnimation componentInChildren = visualInstance.GetComponentInChildren<SkeletonAnimation>(includeInactive: true);
		if (componentInChildren == null || componentInChildren.AnimationState == null || componentInChildren.Skeleton == null || componentInChildren.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing SkeletonAnimation while resolving emitter animation. type=" + category + ", def=" + defName + ", mount=" + mountPoint.LocalId);
		}
		return componentInChildren;
	}

	private static void ValidateAnimationExistsOrThrow(SkeletonAnimation animation, string animationName, string category, string defName)
	{
		if (string.IsNullOrWhiteSpace(animationName))
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Empty emitter animation name. type=" + category + ", def=" + defName);
		}
		if (IsNoneAnimationToken(animationName) || animation.Skeleton.Data.FindAnimation(animationName) != null)
		{
			return;
		}
		throw new InvalidOperationException("[SummerRace][Presentation] Missing emitter animation '" + animationName + "'. type=" + category + ", def=" + defName);
	}

	private static bool IsNoneAnimationToken(string animationName)
	{
		if (!string.IsNullOrWhiteSpace(animationName))
		{
			return string.Equals(animationName.Trim(), "none", StringComparison.OrdinalIgnoreCase);
		}
		return false;
	}

	private static void SetEmitterToSetupPose(SkeletonAnimation animation)
	{
		if (!(animation == null) && animation.AnimationState != null && animation.Skeleton != null)
		{
			animation.AnimationState.ClearTracks();
			animation.Skeleton.SetToSetupPose();
			animation.AnimationState.Apply(animation.Skeleton);
		}
	}

	private void HandleHookLinePresentation(SummerRaceEquipPresentationEvent presentationEvent)
	{
		switch (presentationEvent.Phase)
		{
		case SummerRacePresentationPhase.Activated:
			UpdateOrCreateHookSession(presentationEvent);
			break;
		case SummerRacePresentationPhase.Spawned:
			UpdateOrCreateHookSession(presentationEvent);
			SetHookFlightVisibility(presentationEvent, visible: true);
			break;
		case SummerRacePresentationPhase.Impact:
			UpdateOrCreateHookSession(presentationEvent);
			SetHookFlightVisibility(presentationEvent, visible: true);
			break;
		case SummerRacePresentationPhase.Rejected:
		case SummerRacePresentationPhase.ActiveExpired:
			UpdateOrCreateHookSession(presentationEvent);
			HideHookSession(BuildHookSessionKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex));
			break;
		case SummerRacePresentationPhase.Recycled:
			StartHookSessionRecycle(presentationEvent);
			break;
		case SummerRacePresentationPhase.Fired:
		case SummerRacePresentationPhase.ReturnStarted:
		case SummerRacePresentationPhase.Hit:
			break;
		}
	}

	private void UpdateOrCreateHookSession(SummerRaceEquipPresentationEvent presentationEvent)
	{
		string text = BuildHookSessionKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex);
		if (hookSessions.TryGetValue(text, out var value) && IsHookSessionInvalid(value))
		{
			if (hookTraceLog)
			{
				SummerRaceRuntimeLog.Warning("[SummerRace][HookTrace][SessionRebuild] key=" + text + " reason=stale_or_destroyed_nodes");
			}
			CleanupHookSessionArtifacts(value);
			hookSessions.Remove(text);
		}
		if (!hookSessions.TryGetValue(text, out var value2))
		{
			value2 = CreateHookSession(text, presentationEvent);
			hookSessions[text] = value2;
		}
		else
		{
			SetHookSessionParent(value2, presentationEvent.MountPoint);
		}
		value2.SourceTransform = presentationEvent.SourceTransform;
		value2.TargetTransform = presentationEvent.TargetTransform;
		value2.SourcePoint = presentationEvent.SourcePoint;
		value2.TargetPoint = presentationEvent.TargetPoint;
		if (presentationEvent.Phase == SummerRacePresentationPhase.Spawned || presentationEvent.Phase == SummerRacePresentationPhase.Activated || value2.LaunchDirection.sqrMagnitude <= 0.0001f)
		{
			Vector2 vector = ((presentationEvent.SourceTransform != null) ? ((Vector2)presentationEvent.SourceTransform.right) : Vector2.right);
			value2.LaunchDirection = ((presentationEvent.Direction.sqrMagnitude > 0.0001f) ? presentationEvent.Direction.normalized : ((vector.sqrMagnitude > 0.0001f) ? vector.normalized : Vector2.right));
		}
		value2.IsRecycling = false;
		value2.PendingRelease = false;
		value2.IsLatchedImpact = presentationEvent.Phase == SummerRacePresentationPhase.Impact;
		if (!value2.IsLatchedImpact)
		{
			value2.HasLatchedRotationOffset = false;
			value2.LatchedRotationTarget = null;
			value2.LatchedHeadRotationOffset = Quaternion.identity;
			value2.LatchedHeadLocalPositionOffset = Vector3.zero;
			value2.LatchedHeadFixedEulerX = 0f;
			value2.LatchedHeadFixedEulerY = 0f;
			value2.LatchedHeadZOffsetFromTarget = 0f;
		}
		if (presentationEvent.Phase == SummerRacePresentationPhase.ActiveExpired)
		{
			ReattachHookHeadToMount(value2, "prewarm");
			value2.IsFlightVisible = false;
			value2.TargetTransform = null;
			value2.TargetPoint = value2.SourcePoint;
			value2.IsLatchedImpact = false;
			value2.HasLatchedRotationOffset = false;
			value2.LatchedRotationTarget = null;
			value2.LatchedHeadRotationOffset = Quaternion.identity;
			value2.LatchedHeadLocalPositionOffset = Vector3.zero;
			value2.LatchedHeadFixedEulerX = 0f;
			value2.LatchedHeadFixedEulerY = 0f;
			value2.LatchedHeadZOffsetFromTarget = 0f;
			if (value2.Rope != null)
			{
				value2.Rope.gameObject.SetActive(value: false);
			}
			ApplyHookHeadDockPose(value2);
			UpdateHookHeadAnimation(value2, "default", loop: true, "prewarm");
			return;
		}
		Vector2 vector2 = value2.TargetPoint - value2.SourcePoint;
		if (vector2.sqrMagnitude <= 0.0001f)
		{
			ReattachHookHeadToMount(value2, "no_delta");
			ApplyHookHeadDockPose(value2);
			if (value2.Rope != null)
			{
				value2.Rope.gameObject.SetActive(value: false);
			}
			UpdateHookHeadAnimation(value2, "default", loop: true, "no_delta");
			return;
		}
		vector2.Normalize();
		if (value2.IsLatchedImpact && value2.TargetTransform != null)
		{
			UpdateHookHeadLatchedPose(value2, value2.TargetTransform, "event_latched");
		}
		else
		{
			UpdateHookHeadFlightPose(value2, value2.TargetPoint, "event_update");
		}
		UpdateHookHeadAnimation(value2, value2.IsLatchedImpact ? "atk" : "default", loop: true, value2.IsLatchedImpact ? "latched_impact" : "traveling");
		if (hookTraceLog)
		{
			string[] obj = new string[14]
			{
				"[SummerRace][HookTrace][Spine] phase=",
				presentationEvent.Phase.ToString(),
				" key=",
				text,
				" source=",
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null,
				null
			};
			Vector2 sourcePoint = value2.SourcePoint;
			obj[5] = sourcePoint.ToString();
			obj[6] = " target=";
			sourcePoint = value2.TargetPoint;
			obj[7] = sourcePoint.ToString();
			obj[8] = " launchDir=";
			sourcePoint = value2.LaunchDirection;
			obj[9] = sourcePoint.ToString();
			obj[10] = " reach=";
			float reachDistance = presentationEvent.ReachDistance;
			obj[11] = reachDistance.ToString("F3");
			obj[12] = " targetCount=";
			int targetCount = presentationEvent.TargetCount;
			obj[13] = targetCount.ToString();
			SummerRaceRuntimeLog.Log(string.Concat(obj));
		}
	}

	private static bool IsHookSessionInvalid(HookVisualSession session)
	{
		if (session == null || session.Def == null)
		{
			return true;
		}
		if (session.Root == null || session.Head == null || session.Rope == null)
		{
			return true;
		}
		if (session.HeadAnimation == null || session.RopeAnimation == null)
		{
			return true;
		}
		if (session.HookPointLeft == null || session.HookPointRight == null)
		{
			return true;
		}
		return false;
	}

	private static void CleanupHookSessionArtifacts(HookVisualSession session)
	{
		if (session == null)
		{
			return;
		}
		if (session.Root != null)
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(session.Root.gameObject);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(session.Root.gameObject);
			}
			return;
		}
		if (session.Head != null)
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(session.Head.gameObject);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(session.Head.gameObject);
			}
		}
		if (session.Rope != null)
		{
			if (Application.isPlaying)
			{
				UnityEngine.Object.Destroy(session.Rope.gameObject);
			}
			else
			{
				UnityEngine.Object.DestroyImmediate(session.Rope.gameObject);
			}
		}
	}

	private static void SetHookSessionParent(HookVisualSession session, MountPoint mountPoint)
	{
		if (session != null && !(session.Root == null) && !(mountPoint == null) && !(mountPoint.VisualInstance == null))
		{
			Transform transform = mountPoint.VisualInstance.transform;
			if (!(session.Root.parent == transform))
			{
				session.Root.SetParent(transform, worldPositionStays: false);
				session.MountVisualRoot = transform;
				EnsureHookAnchorHierarchy(session);
			}
		}
	}

	private void HideHookSession(string key)
	{
		if (!string.IsNullOrEmpty(key) && hookSessions.TryGetValue(key, out var value) && value != null)
		{
			if (value.Rope != null)
			{
				value.Rope.gameObject.SetActive(value: false);
			}
			if (value.Head != null)
			{
				ReattachHookHeadToMount(value, "hide");
				value.Head.gameObject.SetActive(value: true);
				ApplyHookHeadDockPose(value);
				value.Head.localRotation = Quaternion.identity;
			}
			value.IsFlightVisible = false;
			value.IsRecycling = false;
			value.PendingRelease = false;
			value.TargetTransform = null;
			value.TargetPoint = value.SourcePoint;
			value.LaunchDirection = ((value.SourceTransform != null) ? ((Vector2)value.SourceTransform.right) : Vector2.right);
			value.IsLatchedImpact = false;
			value.HasLatchedRotationOffset = false;
			value.LatchedRotationTarget = null;
			value.LatchedHeadRotationOffset = Quaternion.identity;
			value.LatchedHeadLocalPositionOffset = Vector3.zero;
			value.LatchedHeadFixedEulerX = 0f;
			value.LatchedHeadFixedEulerY = 0f;
			value.LatchedHeadZOffsetFromTarget = 0f;
			UpdateHookHeadAnimation(value, "default", loop: true, "hide");
		}
	}

	private void StartHookSessionRecycle(SummerRaceEquipPresentationEvent presentationEvent)
	{
		string text = BuildHookSessionKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex);
		if (hookSessions.TryGetValue(text, out var value))
		{
			SetHookSessionParent(value, presentationEvent.MountPoint);
			value.SourceTransform = presentationEvent.SourceTransform;
			value.TargetTransform = null;
			value.SourcePoint = ResolveHookSessionSourcePoint(value, presentationEvent.SourcePoint);
			value.IsRecycling = true;
			value.PendingRelease = false;
			value.IsFlightVisible = true;
			value.IsLatchedImpact = false;
			value.HasLatchedRotationOffset = false;
			value.LatchedRotationTarget = null;
			value.LatchedHeadRotationOffset = Quaternion.identity;
			value.LatchedHeadLocalPositionOffset = Vector3.zero;
			value.LatchedHeadFixedEulerX = 0f;
			value.LatchedHeadFixedEulerY = 0f;
			value.LatchedHeadZOffsetFromTarget = 0f;
			value.RecycleTotalDistance = Mathf.Max(0.0001f, Vector2.Distance(value.SourcePoint, value.TargetPoint));
			DetachHookHeadForFlight(value, "recycle_start");
			if (value.Head != null)
			{
				value.Head.gameObject.SetActive(value: true);
			}
			if (value.Rope != null)
			{
				value.Rope.gameObject.SetActive(value: true);
			}
			if (hookTraceLog)
			{
				string[] obj = new string[6] { "[SummerRace][HookTrace][Spine] phase=Recycled key=", text, " source=", null, null, null };
				Vector2 sourcePoint = value.SourcePoint;
				obj[3] = sourcePoint.ToString();
				obj[4] = " target=";
				sourcePoint = value.TargetPoint;
				obj[5] = sourcePoint.ToString();
				SummerRaceRuntimeLog.Log(string.Concat(obj));
			}
		}
	}

	private void SetHookFlightVisibility(SummerRaceEquipPresentationEvent presentationEvent, bool visible)
	{
		string key = BuildHookSessionKey(presentationEvent.SourceTransform, presentationEvent.SlotIndex);
		if (!hookSessions.TryGetValue(key, out var value) || value == null)
		{
			return;
		}
		value.IsFlightVisible = visible;
		if (value.Head != null)
		{
			if (visible)
			{
				DetachHookHeadForFlight(value, "flight_visible");
			}
			else
			{
				ReattachHookHeadToMount(value, "flight_hidden");
			}
			value.Head.gameObject.SetActive(visible);
			if (!visible)
			{
				value.Head.localRotation = Quaternion.identity;
			}
		}
		if (value.Rope != null)
		{
			value.Rope.gameObject.SetActive(visible);
		}
		if (value.Head != null && !visible)
		{
			ApplyHookHeadDockPose(value);
			value.Head.localRotation = Quaternion.identity;
		}
		if (value.Rope != null && !visible)
		{
			ResetHookRopeIdlePose(value);
		}
		UpdateHookHeadAnimation(value, "default", loop: true, visible ? "show" : "hide");
	}

	private void UpdateHookSession(HookVisualSession session, float deltaTime)
	{
		if (session == null || session.Rope == null || session.Def == null)
		{
			return;
		}
		ApplyHookSessionSorting(session);
		session.SourcePoint = ResolveHookSessionSourcePoint(session, session.SourcePoint);
		if (session.TargetTransform != null && !session.IsLatchedImpact)
		{
			session.TargetPoint = session.TargetTransform.position;
		}
		if (!session.IsFlightVisible && !session.IsRecycling)
		{
			ReattachHookHeadToMount(session, "idle");
			ApplyHookHeadDockPose(session);
			if (session.Head != null)
			{
				session.Head.localRotation = Quaternion.identity;
			}
			if (session.Rope != null)
			{
				session.Rope.gameObject.SetActive(value: false);
				ResetHookRopeIdlePose(session);
			}
			UpdateHookHeadAnimation(session, "default", loop: true, "idle");
			return;
		}
		if (session.IsRecycling)
		{
			DetachHookHeadForFlight(session, "recycling");
			Vector2 vector = session.SourcePoint - session.TargetPoint;
			float magnitude = vector.magnitude;
			float num = Mathf.Max(0.0001f, session.RecycleTotalDistance);
			float normalizedRemain = Mathf.Clamp01(magnitude / num);
			float num2 = ResolveHookRecycleSpeedScale(normalizedRemain);
			float num3 = Mathf.Max(0.1f, hookRecycleSpeed * num2) * Mathf.Max(0.0001f, deltaTime);
			if (magnitude <= num3)
			{
				session.TargetPoint = session.SourcePoint;
				session.IsRecycling = false;
				session.PendingRelease = true;
				session.IsFlightVisible = false;
				session.IsLatchedImpact = false;
				session.HasLatchedRotationOffset = false;
				session.LatchedRotationTarget = null;
				session.LatchedHeadRotationOffset = Quaternion.identity;
				session.LatchedHeadLocalPositionOffset = Vector3.zero;
				session.LatchedHeadFixedEulerX = 0f;
				session.LatchedHeadFixedEulerY = 0f;
				session.LatchedHeadZOffsetFromTarget = 0f;
				if (session.Head != null)
				{
					session.Head.gameObject.SetActive(value: false);
				}
				if (session.Rope != null)
				{
					session.Rope.gameObject.SetActive(value: false);
				}
			}
			else
			{
				session.TargetPoint += vector / magnitude * num3;
			}
			if (hookTraceLog)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][RecycleCurve] key=" + session.Key + " remain=" + magnitude.ToString("F4") + " normRemain=" + normalizedRemain.ToString("F4") + " speedScale=" + num2.ToString("F4") + " step=" + num3.ToString("F4"));
			}
		}
		Vector2 vector2 = session.TargetPoint - session.SourcePoint;
		if (vector2.sqrMagnitude <= 1E-06f)
		{
			if (session.PendingRelease)
			{
				session.PendingRelease = false;
				session.IsFlightVisible = false;
				session.TargetTransform = null;
				session.IsLatchedImpact = false;
				session.HasLatchedRotationOffset = false;
				session.LatchedRotationTarget = null;
				session.LatchedHeadRotationOffset = Quaternion.identity;
				session.LatchedHeadLocalPositionOffset = Vector3.zero;
				session.LatchedHeadFixedEulerX = 0f;
				session.LatchedHeadFixedEulerY = 0f;
				session.LatchedHeadZOffsetFromTarget = 0f;
				if (session.Rope != null)
				{
					session.Rope.gameObject.SetActive(value: false);
					ResetHookRopeIdlePose(session);
				}
				if (session.Head != null)
				{
					ReattachHookHeadToMount(session, "return_complete");
					session.Head.gameObject.SetActive(value: true);
					ApplyHookHeadDockPose(session);
					session.Head.localRotation = Quaternion.identity;
				}
				UpdateHookHeadAnimation(session, "default", loop: true, "return_complete");
				return;
			}
			if (hookTraceLog)
			{
				string[] obj = new string[8] { "[SummerRace][HookTrace][RopeDeltaClamp] key=", session.Key, " source=", null, null, null, null, null };
				Vector2 sourcePoint = session.SourcePoint;
				obj[3] = sourcePoint.ToString();
				obj[4] = " target=";
				sourcePoint = session.TargetPoint;
				obj[5] = sourcePoint.ToString();
				obj[6] = " deltaSqr=";
				obj[7] = vector2.sqrMagnitude.ToString("F8");
				SummerRaceRuntimeLog.Warning(string.Concat(obj));
			}
		}
		if (session.IsLatchedImpact && session.TargetTransform != null)
		{
			UpdateHookHeadLatchedPose(session, session.TargetTransform, "latched_update");
			session.TargetPoint = ((session.Head != null) ? ((Vector2)session.Head.position) : session.TargetPoint);
		}
		else
		{
			UpdateHookHeadFlightPose(session, session.TargetPoint, session.IsRecycling ? "recycling" : "traveling");
		}
		ResolveHookAnchorPointsOrThrow(session, out var leftAnchorWorld, out var rightAnchorWorld);
		Vector2 vector3 = new Vector2(rightAnchorWorld.x - leftAnchorWorld.x, rightAnchorWorld.y - leftAnchorWorld.y);
		float magnitude2 = vector3.magnitude;
		float num4 = Mathf.Max(0.0001f, 2.54f);
		float num5 = Mathf.Max(0.01f, magnitude2 / num4);
		float z = Mathf.Atan2(vector3.y, vector3.x) * 57.29578f;
		session.Rope.rotation = Quaternion.Euler(0f, 0f, z);
		session.Rope.localScale = new Vector3(num5, 1f, 1f);
		AlignRopeLeftEndpointToAnchor(session, leftAnchorWorld);
		if (TryResolveRopeEndpointWorld(session, out var ropeLeftWorld, out var ropeRightWorld))
		{
			float num6 = Vector2.Distance(ropeLeftWorld, ropeRightWorld);
			if (num6 > 0.0001f && magnitude2 > 0.0001f)
			{
				float num7 = magnitude2 / num6;
				num5 = Mathf.Max(0.01f, num5 * num7);
				session.Rope.localScale = new Vector3(num5, 1f, 1f);
				AlignRopeLeftEndpointToAnchor(session, leftAnchorWorld);
			}
		}
		if (hookTraceLog)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][Anchor] key=" + session.Key + " left=" + leftAnchorWorld.ToString("F4") + " right=" + rightAnchorWorld.ToString("F4"));
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][RopeSolve] key=" + session.Key + " distance=" + magnitude2.ToString("F4") + " authoringLength=" + num4.ToString("F4") + " scaleX=" + num5.ToString("F4") + " rotationZ=" + z.ToString("F2") + " ropeWorldAnchor=" + session.Rope.position.ToString("F4") + " leftAnchorPath=" + ((session.HookPointLeft != null) ? BuildTransformPath(session.HookPointLeft) : "<null>") + " rightAnchorPath=" + ((session.HookPointRight != null) ? BuildTransformPath(session.HookPointRight) : "<null>"));
			TryLogHookRopeEndpointDiagnostics(session, leftAnchorWorld, rightAnchorWorld, num5);
		}
		string animationName = (session.IsLatchedImpact ? "atk" : "default");
		UpdateHookHeadAnimation(session, animationName, loop: true, session.IsLatchedImpact ? "latched_update" : "flight_update");
	}

	private static void ResolveHookAnchorPointsOrThrow(HookVisualSession session, out Vector3 leftAnchorWorld, out Vector3 rightAnchorWorld)
	{
		if (session == null || session.HookPointLeft == null || session.HookPointRight == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Hook anchor missing while solving rope. key=" + ((session != null) ? session.Key : "<null>"));
		}
		leftAnchorWorld = session.HookPointLeft.position;
		rightAnchorWorld = session.HookPointRight.position;
	}

	private static Vector2 ResolveHookSessionSourcePoint(HookVisualSession session, Vector2 fallback)
	{
		if (session != null && session.HookPointLeft != null)
		{
			return session.HookPointLeft.position;
		}
		if (session != null && session.SourceTransform != null)
		{
			return session.SourceTransform.position;
		}
		return fallback;
	}

	private static void ApplyHookSessionSorting(HookVisualSession session)
	{
		if (session == null || session.MountVisualRoot == null)
		{
			return;
		}
		ResolveHookSortingAnchorOrThrow(session.MountVisualRoot, out var sortingLayerId, out var hookRopeSortingOrder, out var mountVisualSortingOrder);
		MeshRenderer meshRenderer = ((session.RopeAnimation != null) ? session.RopeAnimation.GetComponent<MeshRenderer>() : null);
		if (meshRenderer != null)
		{
			meshRenderer.sortingLayerID = sortingLayerId;
			meshRenderer.sortingOrder = hookRopeSortingOrder;
		}
		MeshRenderer meshRenderer2 = ((session.HeadAnimation != null) ? session.HeadAnimation.GetComponent<MeshRenderer>() : null);
		if (meshRenderer2 != null)
		{
			meshRenderer2.sortingLayerID = sortingLayerId;
			int num = (meshRenderer2.sortingOrder = mountVisualSortingOrder + -1);
			if (meshRenderer != null)
			{
				meshRenderer.sortingOrder = num + -1;
			}
		}
	}

	private HookVisualSession CreateHookSession(string key, SummerRaceEquipPresentationEvent presentationEvent)
	{
		UtilityModuleDefinition equipDefinition = presentationEvent.EquipDefinition;
		if (equipDefinition == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Hook session creation requires equip definition.");
		}
		int slotIndex;
		if (presentationEvent.MountPoint == null || presentationEvent.MountPoint.VisualInstance == null)
		{
			string text = equipDefinition.name;
			slotIndex = presentationEvent.SlotIndex;
			throw new InvalidOperationException("[SummerRace][Presentation] Hook session creation requires mounted equip visual instance. equip=" + text + " slot=" + slotIndex);
		}
		Transform transform = presentationEvent.MountPoint.VisualInstance.transform;
		ResolveHookSortingAnchorOrThrow(transform, out var sortingLayerId, out var hookRopeSortingOrder, out slotIndex);
		Transform transform2 = EnsureHookUnifiedVisualRoot(transform);
		transform2.localPosition = equipDefinition.HookHeadSpineLocalOffset;
		transform2.localRotation = Quaternion.Euler(0f, 0f, equipDefinition.HookHeadSpineLocalAngle);
		SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][Attach] key=" + key + " parent=" + transform.name + " path=" + BuildTransformPath(transform2));
		HookVisualSession hookVisualSession = new HookVisualSession
		{
			Key = key,
			Def = equipDefinition,
			Root = transform2,
			Anchor = transform2,
			MountVisualRoot = transform,
			IsFlightVisible = false
		};
		hookVisualSession.RopeAnimation = EnsureHookSpineNodeOrThrow(transform2, "HookRope", equipDefinition.HookRopeSpineSkeletonDataPath, Vector2.zero, 0f, 1f, sortingLayerId, hookRopeSortingOrder, out var nodeTransform);
		hookVisualSession.Rope = nodeTransform;
		SetHookNodeAnimationOrThrow(hookVisualSession.RopeAnimation, equipDefinition.HookRopeSpineAnimationName, "hook-rope", equipDefinition.name, loop: true);
		hookVisualSession.Rope.gameObject.SetActive(value: false);
		hookVisualSession.HeadAnimation = EnsureHookSpineNodeOrThrow(transform2, "HookHead", equipDefinition.HookHeadSpineSkeletonDataPath, new Vector2(-0.3f, 0.05f), 0f, 1f, sortingLayerId, hookRopeSortingOrder, out var nodeTransform2);
		hookVisualSession.Head = nodeTransform2;
		ValidateHookHeadAnimationsOrThrow(hookVisualSession.HeadAnimation, equipDefinition.name);
		hookVisualSession.CurrentHeadAnimationName = string.Empty;
		UpdateHookHeadAnimation(hookVisualSession, "default", loop: true, "create");
		hookVisualSession.Head.gameObject.SetActive(value: true);
		hookVisualSession.Head.localPosition = new Vector3(-0.3f, 0.05f, 0f);
		hookVisualSession.Head.localRotation = Quaternion.identity;
		hookVisualSession.HeadDockLocalScale = hookVisualSession.Head.localScale;
		float num = 1f;
		float num2 = 1f;
		float x = transform2.localScale.x;
		ApplyHookHeadDockPose(hookVisualSession);
		Transform transform3 = EnsureChildTransform(hookVisualSession.Head, "HookHitBox");
		transform3.localPosition = Vector3.zero;
		transform3.localRotation = Quaternion.identity;
		transform3.localScale = Vector3.one;
		hookVisualSession.HeadHitbox = transform3;
		EnsureHookAnchorHierarchy(hookVisualSession);
		ResetHookRopeIdlePose(hookVisualSession);
		if (hookTraceLog)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][ScaleResolve] key=" + key + " parentLossyScale=(" + transform.lossyScale.x.ToString("F3") + "," + transform.lossyScale.y.ToString("F3") + ") fitScale=" + num.ToString("F3") + " configuredScale=" + num2.ToString("F3") + " resolvedScale=" + x.ToString("F3") + " computedLocalScale=(" + transform2.localScale.x.ToString("F3") + "," + transform2.localScale.y.ToString("F3") + ") finalWorldScale=(" + Mathf.Abs(transform2.lossyScale.x).ToString("F3") + "," + Mathf.Abs(transform2.lossyScale.y).ToString("F3") + ")");
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][Sorting] key=" + key + " layer=" + sortingLayerId + " ropeOrder=" + hookRopeSortingOrder + " headOrder=mount-1 visualScale=" + transform2.localScale.ToString() + " hierarchy=" + BuildTransformPath(transform2) + " ropeNode=" + ((hookVisualSession.Rope != null) ? BuildTransformPath(hookVisualSession.Rope) : "<null>") + " headNode=" + ((hookVisualSession.Head != null) ? BuildTransformPath(hookVisualSession.Head) : "<null>") + " hitboxNode=" + ((hookVisualSession.HeadHitbox != null) ? BuildTransformPath(hookVisualSession.HeadHitbox) : "<null>"));
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][InitPose] key=" + key + " visualScale=" + transform2.localScale.ToString() + " headLocalPos=" + hookVisualSession.Head.localPosition.ToString() + " headLocalRot=" + hookVisualSession.Head.localRotation.eulerAngles.ToString() + " hitboxLocalPos=" + transform3.localPosition.ToString() + " hitboxLocalRot=" + transform3.localRotation.eulerAngles.ToString() + " ropeLocalPos=" + ((hookVisualSession.Rope != null) ? hookVisualSession.Rope.localPosition.ToString("F4") : "<null>") + " ropeLocalRot=" + ((hookVisualSession.Rope != null) ? hookVisualSession.Rope.localRotation.eulerAngles.ToString("F4") : "<null>"));
		}
		return hookVisualSession;
	}

	private static Transform EnsureChildTransform(Transform parent, string childName)
	{
		if (parent == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Cannot ensure child on null parent. child=" + childName);
		}
		if (string.IsNullOrWhiteSpace(childName))
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Child name is empty while ensuring transform.");
		}
		Transform transform = parent.Find(childName);
		if (transform != null)
		{
			return transform;
		}
		transform = new GameObject(childName).transform;
		transform.SetParent(parent, worldPositionStays: false);
		transform.localPosition = Vector3.zero;
		transform.localRotation = Quaternion.identity;
		transform.localScale = Vector3.one;
		return transform;
	}

	private Transform EnsureHookUnifiedVisualRoot(Transform hookVisualRoot)
	{
		if (hookVisualRoot == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Hook visual root is null while ensuring unified Visual root.");
		}
		for (int num = hookVisualRoot.childCount - 1; num >= 0; num--)
		{
			Transform child = hookVisualRoot.GetChild(num);
			if (!(child == null) && child.name.StartsWith("HookLineSpine_", StringComparison.Ordinal))
			{
				if (hookTraceLog)
				{
					SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][Cleanup] removeLegacy=" + BuildTransformPath(child));
				}
				if (Application.isPlaying)
				{
					UnityEngine.Object.Destroy(child.gameObject);
				}
				else
				{
					UnityEngine.Object.DestroyImmediate(child.gameObject);
				}
			}
		}
		Transform result = EnsureChildTransform(hookVisualRoot, "Visual");
		if (hookTraceLog)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][Attach] unifiedRoot=" + BuildTransformPath(result));
		}
		return result;
	}

	private static SkeletonAnimation EnsureHookSpineNodeOrThrow(Transform parent, string nodeName, string skeletonDataPath, Vector2 localOffset, float localAngle, float localScale, int sortingLayerId, int sortingOrder, out Transform nodeTransform)
	{
		SkeletonDataAsset skeletonDataAsset = SummerRaceConfigLoader.LoadSkeletonDataAssetOrThrow(skeletonDataPath, "hook node=" + nodeName + " field=skeletonDataPath");
		nodeTransform = EnsureChildTransform(parent, nodeName);
		nodeTransform.localPosition = localOffset;
		nodeTransform.localRotation = Quaternion.Euler(0f, 0f, localAngle);
		nodeTransform.localScale = new Vector3(localScale, localScale, 1f);
		GameObject gameObject = nodeTransform.gameObject;
		SkeletonAnimation skeletonAnimation = gameObject.GetComponent<SkeletonAnimation>();
		if (skeletonAnimation == null)
		{
			skeletonAnimation = gameObject.AddComponent<SkeletonAnimation>();
		}
		skeletonAnimation.skeletonDataAsset = skeletonDataAsset;
		skeletonAnimation.Initialize(overwrite: true);
		MeshRenderer component = skeletonAnimation.GetComponent<MeshRenderer>();
		if (component != null)
		{
			component.sortingLayerID = sortingLayerId;
			component.sortingOrder = sortingOrder;
		}
		return skeletonAnimation;
	}

	private static void ResolveHookSortingAnchorOrThrow(Transform hookVisualRoot, out int sortingLayerId, out int hookRopeSortingOrder, out int mountVisualSortingOrder)
	{
		if (hookVisualRoot == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Hook visual root is null while resolving sorting anchor.");
		}
		Renderer renderer = ResolveMountVisualRendererOrThrow(hookVisualRoot);
		if (renderer == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing mount renderer while resolving hook sorting anchor. root=" + hookVisualRoot.name);
		}
		int num = renderer.sortingOrder - 3;
		sortingLayerId = renderer.sortingLayerID;
		mountVisualSortingOrder = renderer.sortingOrder;
		hookRopeSortingOrder = num + 4;
	}

	private static Renderer ResolveMountVisualRendererOrThrow(Transform hookVisualRoot)
	{
		if (hookVisualRoot == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Hook visual root is null while resolving mount renderer.");
		}
		Transform transform = hookVisualRoot.Find("Visual");
		if (transform == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing unified Visual root while resolving mount renderer. root=" + hookVisualRoot.name);
		}
		Renderer component = transform.GetComponent<MeshRenderer>();
		if (component != null)
		{
			return component;
		}
		component = transform.GetComponent<Renderer>();
		if (component != null)
		{
			return component;
		}
		Renderer[] componentsInChildren = transform.GetComponentsInChildren<Renderer>(includeInactive: true);
		foreach (Renderer renderer in componentsInChildren)
		{
			if (!(renderer == null))
			{
				Transform transform2 = renderer.transform;
				if (!(transform2 != null) || (!(transform2.name == "HookHead") && !(transform2.name == "HookRope")))
				{
					return renderer;
				}
			}
		}
		throw new InvalidOperationException("[SummerRace][Presentation] No renderer found on unified Visual root. root=" + hookVisualRoot.name);
	}

	private static void ApplyHookHeadDockPose(HookVisualSession session)
	{
		if (session != null && !(session.Head == null))
		{
			session.Head.localPosition = new Vector3(-0.3f, 0.05f, 0f);
			session.Head.localRotation = Quaternion.identity;
			session.Head.localScale = ((session.HeadDockLocalScale.sqrMagnitude > 0.0001f) ? session.HeadDockLocalScale : Vector3.one);
		}
	}

	private static void EnsureHookAnchorHierarchy(HookVisualSession session)
	{
		if (session == null || session.Root == null || session.HeadHitbox == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Hook anchor hierarchy requires Root and HeadHitbox.");
		}
		session.HookPointLeft = EnsureChildTransform(session.Root, "HookPointLeft");
		session.HookPointLeft.localPosition = Vector3.zero;
		session.HookPointLeft.localRotation = Quaternion.identity;
		session.HookPointLeft.localScale = Vector3.one;
		session.HookPointRight = EnsureChildTransform(session.HeadHitbox, "HookPointRight");
		session.HookPointRight.localPosition = new Vector3(1f, 0f, 0f);
		session.HookPointRight.localRotation = Quaternion.identity;
		session.HookPointRight.localScale = Vector3.one;
	}

	private static void ResetHookRopeIdlePose(HookVisualSession session)
	{
		if (session != null && !(session.Rope == null))
		{
			float x = 1f;
			session.Rope.localPosition = Vector3.zero;
			session.Rope.localRotation = Quaternion.identity;
			session.Rope.localScale = new Vector3(x, 1f, 1f);
		}
	}

	private static void AlignRopeLeftEndpointToAnchor(HookVisualSession session, Vector3 leftAnchorWorld)
	{
		if (session != null && !(session.Rope == null) && TryResolveRopeEndpointWorld(session, out var ropeLeftWorld, out var _))
		{
			Vector3 vector = leftAnchorWorld - ropeLeftWorld;
			if (!float.IsNaN(vector.x) && !float.IsNaN(vector.y) && !float.IsInfinity(vector.x) && !float.IsInfinity(vector.y))
			{
				session.Rope.position += vector;
			}
		}
	}

	private static bool TryResolveRopeEndpointWorld(HookVisualSession session, out Vector3 ropeLeftWorld, out Vector3 ropeRightWorld)
	{
		ropeLeftWorld = Vector3.zero;
		ropeRightWorld = Vector3.zero;
		if (session == null || session.Rope == null || session.RopeAnimation == null)
		{
			return false;
		}
		Renderer component = session.RopeAnimation.GetComponent<MeshRenderer>();
		if (component == null)
		{
			component = session.RopeAnimation.GetComponent<Renderer>();
		}
		if (component == null)
		{
			return false;
		}
		Bounds localBounds = component.localBounds;
		Vector3 position = new Vector3(localBounds.min.x, localBounds.center.y, localBounds.center.z);
		Vector3 position2 = new Vector3(localBounds.max.x, localBounds.center.y, localBounds.center.z);
		ropeLeftWorld = session.Rope.TransformPoint(position);
		ropeRightWorld = session.Rope.TransformPoint(position2);
		return true;
	}

	private float ResolveHookRecycleSpeedScale(float normalizedRemain)
	{
		float a = Mathf.Clamp01(hookRecycleMinSpeedScale);
		float num = Mathf.Clamp01(hookRecycleEaseOutPortion);
		if (num <= 0.0001f)
		{
			return 1f;
		}
		if (normalizedRemain >= num)
		{
			return 1f;
		}
		float num2 = Mathf.Clamp01(normalizedRemain / num);
		float t = num2 * num2 * (3f - 2f * num2);
		return Mathf.Lerp(a, 1f, t);
	}

	private void TryLogHookRopeEndpointDiagnostics(HookVisualSession session, Vector3 leftAnchorWorld, Vector3 rightAnchorWorld, float ropeScaleX)
	{
		if (hookTraceLog && session != null && !(session.Rope == null) && !(session.RopeAnimation == null) && !(Time.time < session.NextEndpointLogAt))
		{
			session.NextEndpointLogAt = Time.time + 0.12f;
			if (!TryResolveRopeEndpointWorld(session, out var ropeLeftWorld, out var ropeRightWorld))
			{
				SummerRaceRuntimeLog.Warning("[SummerRace][HookTrace][RopeEndpoint] cannot resolve rope endpoints from mesh bounds. key=" + session.Key);
				return;
			}
			Vector2 vector = new Vector2(ropeLeftWorld.x - leftAnchorWorld.x, ropeLeftWorld.y - leftAnchorWorld.y);
			Vector2 vector2 = new Vector2(ropeRightWorld.x - rightAnchorWorld.x, ropeRightWorld.y - rightAnchorWorld.y);
			float num = vector.magnitude * 100f;
			float num2 = vector2.magnitude * 100f;
			float num3 = Vector2.Distance(leftAnchorWorld, rightAnchorWorld);
			float num4 = Vector2.Distance(ropeLeftWorld, ropeRightWorld);
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][RopeEndpoint] key=" + session.Key + " scaleX=" + ropeScaleX.ToString("F4") + " anchorDist=" + num3.ToString("F4") + " ropeDist=" + num4.ToString("F4") + " leftDeltaWorld=" + vector.ToString("F4") + " rightDeltaWorld=" + vector2.ToString("F4") + " leftDeltaPx=" + num.ToString("F2") + " rightDeltaPx=" + num2.ToString("F2"));
		}
	}

	private void DetachHookHeadForFlight(HookVisualSession session, string reason)
	{
		if (session != null && !(session.Head == null) && !session.IsHeadDetached)
		{
			session.HeadOriginalParent = session.Head.parent;
			session.HeadOriginalSibling = session.Head.GetSiblingIndex();
			session.HeadFlightFixedY = session.Head.position.y;
			session.HeadFlightFixedZ = session.Head.position.z;
			session.HeadFlightWorldRotation = session.Head.rotation;
			session.Head.SetParent(EnsureEffectRoot(), worldPositionStays: true);
			session.IsHeadDetached = true;
			if (hookTraceLog)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][Detach] key=" + session.Key + " reason=" + reason + " originalParent=" + ((session.HeadOriginalParent != null) ? BuildTransformPath(session.HeadOriginalParent) : "<null>") + " sibling=" + session.HeadOriginalSibling + " lockY=" + session.HeadFlightFixedY.ToString("F4") + " lockZ=" + session.HeadFlightFixedZ.ToString("F4") + " lockRot=" + session.HeadFlightWorldRotation.eulerAngles.ToString("F4"));
			}
		}
	}

	private void ReattachHookHeadToMount(HookVisualSession session, string reason)
	{
		if (session != null && !(session.Head == null) && session.IsHeadDetached)
		{
			Transform transform = ((session.HeadOriginalParent != null) ? session.HeadOriginalParent : session.Root);
			session.Head.SetParent(transform, worldPositionStays: false);
			int max = Mathf.Max(0, transform.childCount - 1);
			int siblingIndex = Mathf.Clamp(session.HeadOriginalSibling, 0, max);
			session.Head.SetSiblingIndex(siblingIndex);
			session.Head.localScale = ((session.HeadDockLocalScale.sqrMagnitude > 0.0001f) ? session.HeadDockLocalScale : Vector3.one);
			session.IsHeadDetached = false;
			session.HeadOriginalParent = null;
			session.HeadOriginalSibling = 0;
			if (hookTraceLog)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][Reattach] key=" + session.Key + " reason=" + reason + " parent=" + BuildTransformPath(transform) + " sibling=" + siblingIndex);
			}
		}
	}

	private void UpdateHookHeadFlightPose(HookVisualSession session, Vector2 targetPoint, string reason)
	{
		if (session != null && !(session.Head == null))
		{
			DetachHookHeadForFlight(session, reason);
			Vector3 position = session.Head.position;
			position.x = targetPoint.x;
			position.y = targetPoint.y;
			position.z = session.HeadFlightFixedZ;
			session.Head.position = position;
			session.Head.rotation = session.HeadFlightWorldRotation;
			if (hookTraceLog)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][FlightPose] key=" + session.Key + " reason=" + reason + " headWorld=" + session.Head.position.ToString("F4") + " headRot=" + session.Head.rotation.eulerAngles.ToString("F4") + " target=" + targetPoint.ToString("F4"));
			}
		}
	}

	private void UpdateHookHeadLatchedPose(HookVisualSession session, Transform targetTransform, string reason)
	{
		if (session == null || session.Head == null || targetTransform == null)
		{
			return;
		}
		DetachHookHeadForFlight(session, reason);
		Quaternion rotation = targetTransform.rotation;
		if (!session.HasLatchedRotationOffset || session.LatchedRotationTarget != targetTransform)
		{
			Vector3 position = session.Head.position;
			if (reason == "event_latched")
			{
				position = new Vector3(session.TargetPoint.x, session.TargetPoint.y, position.z);
				session.Head.position = position;
			}
			session.LatchedHeadLocalPositionOffset = targetTransform.InverseTransformPoint(position);
			session.LatchedHeadRotationOffset = Quaternion.Inverse(rotation) * session.Head.rotation;
			Vector3 eulerAngles = session.Head.rotation.eulerAngles;
			Vector3 eulerAngles2 = rotation.eulerAngles;
			session.LatchedHeadFixedEulerX = eulerAngles.x;
			session.LatchedHeadFixedEulerY = eulerAngles.y;
			session.LatchedHeadZOffsetFromTarget = Mathf.DeltaAngle(eulerAngles2.z, eulerAngles.z);
			session.LatchedRotationTarget = targetTransform;
			session.HasLatchedRotationOffset = true;
		}
		Vector3 position2 = targetTransform.TransformPoint(session.LatchedHeadLocalPositionOffset);
		float z = targetTransform.rotation.eulerAngles.z + session.LatchedHeadZOffsetFromTarget;
		Quaternion rotation2 = Quaternion.Euler(session.LatchedHeadFixedEulerX, session.LatchedHeadFixedEulerY, z);
		session.Head.SetPositionAndRotation(position2, rotation2);
		if (hookTraceLog)
		{
			SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][FlightPose] key=" + session.Key + " reason=" + reason + " mode=latched_follow_target headWorld=" + session.Head.position.ToString("F4") + " headRot=" + session.Head.rotation.eulerAngles.ToString("F4") + " localPosOffset=" + session.LatchedHeadLocalPositionOffset.ToString("F4") + " fixedXY=(" + session.LatchedHeadFixedEulerX.ToString("F2") + "," + session.LatchedHeadFixedEulerY.ToString("F2") + ") zOffset=" + session.LatchedHeadZOffsetFromTarget.ToString("F4") + " offsetRot=" + session.LatchedHeadRotationOffset.eulerAngles.ToString("F4") + " target=" + BuildTransformPath(targetTransform));
		}
	}

	private static void SetHookNodeAnimationOrThrow(SkeletonAnimation animation, string animationName, string nodeCategory, string equipDefName, bool loop)
	{
		if (animation == null || animation.Skeleton == null || animation.Skeleton.Data == null || animation.AnimationState == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing SkeletonAnimation on hook node. node=" + nodeCategory + " equip=" + equipDefName);
		}
		if (string.IsNullOrWhiteSpace(animationName))
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing hook animation contract. node=" + nodeCategory + " equip=" + equipDefName);
		}
		if (IsNoneAnimationToken(animationName))
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Hook animation cannot be NONE token. node=" + nodeCategory + " equip=" + equipDefName);
		}
		if (animation.Skeleton.Data.FindAnimation(animationName) == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing hook animation '" + animationName + "'. node=" + nodeCategory + " equip=" + equipDefName);
		}
		TrackEntry current = animation.AnimationState.GetCurrent(0);
		if (current == null || current.Animation == null || !string.Equals(current.Animation.Name, animationName, StringComparison.Ordinal) || current.Loop != loop)
		{
			animation.AnimationState.SetAnimation(0, animationName, loop);
		}
	}

	private static void ValidateHookHeadAnimationsOrThrow(SkeletonAnimation animation, string equipDefName)
	{
		if (animation == null || animation.Skeleton == null || animation.Skeleton.Data == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Hook head animation validate failed: skeleton missing. equip=" + equipDefName);
		}
		if (animation.Skeleton.Data.FindAnimation("default") == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing hook head animation 'default'. equip=" + equipDefName);
		}
		if (animation.Skeleton.Data.FindAnimation("atk") == null)
		{
			throw new InvalidOperationException("[SummerRace][Presentation] Missing hook head animation 'atk'. equip=" + equipDefName);
		}
	}

	private void UpdateHookHeadAnimation(HookVisualSession session, string animationName, bool loop, string reason)
	{
		if (session != null && !(session.HeadAnimation == null) && !string.Equals(session.CurrentHeadAnimationName, animationName, StringComparison.Ordinal))
		{
			SetHookNodeAnimationOrThrow(session.HeadAnimation, animationName, "hook-head", (session.Def != null) ? session.Def.name : "<null>", loop);
			session.CurrentHeadAnimationName = animationName;
			if (hookTraceLog)
			{
				SummerRaceRuntimeLog.Log("[SummerRace][HookTrace][AnimState] key=" + session.Key + " anim=" + animationName + " reason=" + reason);
			}
		}
	}

	private static string BuildHookSessionKey(Transform sourceTransform, int slotIndex)
	{
		return ((sourceTransform != null) ? sourceTransform.GetInstanceID() : 0) + ":" + slotIndex;
	}

	private static string BuildTransformPath(Transform transform)
	{
		if (transform == null)
		{
			return "<null>";
		}
		string text = transform.name;
		Transform parent = transform.parent;
		while (parent != null)
		{
			text = parent.name + "/" + text;
			parent = parent.parent;
		}
		return text;
	}

	private void HandleSpinMeleePresentation(SummerRaceWeaponPresentationEvent presentationEvent, SummerRaceWeaponPresentationProfile profile)
	{
		switch (presentationEvent.WeaponKind)
		{
		case WeaponKind.Drill:
			HandleDrillPresentation(presentationEvent, profile);
			return;
		case WeaponKind.RotatingSaw:
			HandleRotatingSawPresentation(presentationEvent, profile);
			return;
		case WeaponKind.Shovel:
			HandleShovelPresentation(presentationEvent, profile);
			return;
		}
		switch (presentationEvent.Phase)
		{
		case SummerRacePresentationPhase.Fired:
			EmitMuzzleFlash(presentationEvent.SourcePoint, presentationEvent.Direction, profile);
			break;
		case SummerRacePresentationPhase.Impact:
			EmitImpact(presentationEvent.TargetPoint, presentationEvent.Direction, profile);
			break;
		}
	}

	private void HandleBeamPresentation(SummerRaceWeaponPresentationEvent presentationEvent, SummerRaceWeaponPresentationProfile profile)
	{
		switch (presentationEvent.Phase)
		{
		case SummerRacePresentationPhase.Fired:
			EmitMuzzleFlash(presentationEvent.SourcePoint, presentationEvent.Direction, profile);
			break;
		case SummerRacePresentationPhase.Spawned:
			EmitBeamSourcePulse(presentationEvent.SourcePoint, presentationEvent.Direction, profile);
			EmitBeamLine(presentationEvent.SourcePoint, presentationEvent.TargetPoint, profile);
			break;
		case SummerRacePresentationPhase.ActiveExpired:
			EmitBeamCollapse(presentationEvent.Position, presentationEvent.Direction, profile);
			break;
		case SummerRacePresentationPhase.Impact:
			EmitImpact(presentationEvent.TargetPoint, presentationEvent.Direction, profile);
			break;
		}
	}

	private void HandleDrillPresentation(SummerRaceWeaponPresentationEvent presentationEvent, SummerRaceWeaponPresentationProfile profile)
	{
		switch (presentationEvent.Phase)
		{
		case SummerRacePresentationPhase.Fired:
			EmitDrillThrust(presentationEvent.SourcePoint, presentationEvent.Direction, profile);
			break;
		case SummerRacePresentationPhase.Impact:
			EmitDrillImpact(presentationEvent.TargetPoint, presentationEvent.Direction, profile);
			break;
		}
	}

	private void HandleRotatingSawPresentation(SummerRaceWeaponPresentationEvent presentationEvent, SummerRaceWeaponPresentationProfile profile)
	{
		switch (presentationEvent.Phase)
		{
		case SummerRacePresentationPhase.Fired:
			EmitSawStartup(presentationEvent.SourcePoint, presentationEvent.Direction, profile);
			break;
		case SummerRacePresentationPhase.Activated:
			EmitSawStartup(presentationEvent.SourcePoint, presentationEvent.Direction, profile);
			break;
		case SummerRacePresentationPhase.Impact:
			EmitSawImpact(presentationEvent.TargetPoint, presentationEvent.Direction, profile);
			break;
		case SummerRacePresentationPhase.ActiveExpired:
			EmitSawShutdown(presentationEvent.Position, presentationEvent.Direction, profile);
			break;
		}
	}

	private void HandleShovelPresentation(SummerRaceWeaponPresentationEvent presentationEvent, SummerRaceWeaponPresentationProfile profile)
	{
		switch (presentationEvent.Phase)
		{
		case SummerRacePresentationPhase.Fired:
			EmitShovelSwing(presentationEvent.SourcePoint, presentationEvent.Direction, profile);
			break;
		case SummerRacePresentationPhase.Impact:
			EmitShovelImpact(presentationEvent.TargetPoint, presentationEvent.Direction, profile);
			break;
		}
	}

	private void EmitRocketSpawnExhaust(Vector2 position, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? (-direction.normalized) : Vector2.left);
		SpawnEffect(SummerRaceSpriteUtil.GetCircleSprite(), position + vector * 0.06f, 0f, new Vector3(0.14f, 0.14f, 1f), new Vector3(0.02f, 0.02f, 1f), profile.MuzzleFlashColor, FadeOut(profile.MuzzleFlashColor), vector * 1.2f, 0.1f);
	}

	private void EmitMuzzleFlash(Vector2 sourcePoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float rotationDegrees = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		Vector2 vector2 = vector * (profile.MuzzleFlashSize.x * 0.22f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), sourcePoint + vector2, rotationDegrees, new Vector3(profile.MuzzleFlashSize.x, profile.MuzzleFlashSize.y, 1f), new Vector3(profile.MuzzleFlashSize.x * 0.55f, profile.MuzzleFlashSize.y * 0.35f, 1f), profile.MuzzleFlashColor, FadeOut(profile.MuzzleFlashColor), vector * 1.6f, profile.MuzzleFlashLifetime);
	}

	private void EmitImpact(Vector2 targetPoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float rotationDegrees = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), targetPoint, rotationDegrees, new Vector3(profile.ImpactFlashScale, profile.ImpactFlashScale * 0.7f, 1f), new Vector3(profile.ImpactFlashScale * 0.36f, profile.ImpactFlashScale * 0.18f, 1f), profile.ImpactFlashColor, FadeOut(profile.ImpactFlashColor), vector * 0.8f, profile.ImpactFlashLifetime);
		SpawnEffect(SummerRaceSpriteUtil.GetCircleSprite(), targetPoint, 0f, new Vector3(profile.ImpactRingStartScale, profile.ImpactRingStartScale, 1f), new Vector3(profile.ImpactRingEndScale, profile.ImpactRingEndScale, 1f), profile.ImpactRingColor, FadeOut(profile.ImpactRingColor), Vector2.zero, profile.ImpactRingLifetime);
	}

	private void EmitBeamSourcePulse(Vector2 sourcePoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float rotationDegrees = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		float num = Mathf.Max(0.12f, profile.ProjectileSize.y * 2.2f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), sourcePoint + vector * (num * 0.4f), rotationDegrees, new Vector3(num * 1.8f, num * 0.95f, 1f), new Vector3(num * 0.55f, num * 0.28f, 1f), profile.MuzzleFlashColor, FadeOut(profile.MuzzleFlashColor), vector * 0.3f, 0.08f);
	}

	private void EmitBeamLine(Vector2 sourcePoint, Vector2 targetPoint, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = targetPoint - sourcePoint;
		float num = Mathf.Max(0.24f, vector.magnitude);
		Vector2 vector2 = ((vector.sqrMagnitude > 0.0001f) ? vector.normalized : Vector2.right);
		float rotationDegrees = Mathf.Atan2(vector2.y, vector2.x) * 57.29578f;
		Vector2 position = sourcePoint + vector2 * (num * 0.5f);
		float num2 = Mathf.Max(0.1f, profile.ProjectileSize.y * 1.8f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), position, rotationDegrees, new Vector3(num, num2 * 1.8f, 1f), new Vector3(num * 0.96f, num2 * 0.75f, 1f), MultiplyAlpha(profile.TrailColor, 0.72f), FadeOut(profile.TrailColor), Vector2.zero, 0.14f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), position, rotationDegrees, new Vector3(num, num2, 1f), new Vector3(num * 0.94f, num2 * 0.45f, 1f), profile.MuzzleFlashColor, FadeOut(profile.MuzzleFlashColor), Vector2.zero, 0.12f);
	}

	private void EmitBeamCollapse(Vector2 position, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float rotationDegrees = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		float num = Mathf.Max(0.1f, profile.ProjectileSize.y * 2.1f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), position, rotationDegrees, new Vector3(num * 1.3f, num * 0.85f, 1f), new Vector3(num * 0.25f, num * 0.12f, 1f), profile.ImpactFlashColor, FadeOut(profile.ImpactFlashColor), vector * 0.4f, 0.1f);
	}

	private void EmitDrillThrust(Vector2 sourcePoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float rotationDegrees = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		float num = Mathf.Max(0.28f, profile.ProjectileSize.x * 1.8f);
		float num2 = Mathf.Max(0.1f, profile.ProjectileSize.y * 0.85f);
		Vector2 position = sourcePoint + vector * (num * 0.45f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), position, rotationDegrees, new Vector3(num, num2, 1f), new Vector3(num * 0.45f, num2 * 0.32f, 1f), profile.MuzzleFlashColor, FadeOut(profile.MuzzleFlashColor), vector * 1f, profile.MuzzleFlashLifetime);
	}

	private void EmitDrillImpact(Vector2 targetPoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float rotationDegrees = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		float num = Mathf.Max(0.2f, profile.ImpactFlashScale * 0.95f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), targetPoint, rotationDegrees, new Vector3(num, num * 0.5f, 1f), new Vector3(num * 0.22f, num * 0.12f, 1f), profile.ImpactFlashColor, FadeOut(profile.ImpactFlashColor), vector * 0.55f, profile.ImpactFlashLifetime);
		SpawnEffect(SummerRaceSpriteUtil.GetCircleSprite(), targetPoint, 0f, new Vector3(profile.ImpactRingStartScale * 0.65f, profile.ImpactRingStartScale * 0.65f, 1f), new Vector3(profile.ImpactRingEndScale * 0.85f, profile.ImpactRingEndScale * 0.85f, 1f), profile.ImpactRingColor, FadeOut(profile.ImpactRingColor), Vector2.zero, profile.ImpactRingLifetime);
	}

	private void EmitSawStartup(Vector2 sourcePoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		Vector2 vector2 = vector * (profile.ProjectileSize.x * 0.45f);
		float num = Mathf.Max(0.24f, profile.ProjectileSize.x * 1.25f);
		SpawnEffect(SummerRaceSpriteUtil.GetCircleSprite(), sourcePoint + vector2, 0f, new Vector3(num, num, 1f), new Vector3(num * 1.22f, num * 1.22f, 1f), MultiplyAlpha(profile.TrailColor, 0.82f), FadeOut(profile.TrailColor), vector * 0.18f, profile.MuzzleFlashLifetime + 0.03f);
	}

	private void EmitSawImpact(Vector2 targetPoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float num = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		float num2 = Mathf.Max(0.24f, profile.ImpactFlashScale * 0.9f);
		float num3 = Mathf.Max(0.08f, num2 * 0.28f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), targetPoint, num + 28f, new Vector3(num2, num3, 1f), new Vector3(num2 * 0.25f, num3 * 0.1f, 1f), profile.ImpactFlashColor, FadeOut(profile.ImpactFlashColor), vector * 0.35f, profile.ImpactFlashLifetime);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), targetPoint, num - 28f, new Vector3(num2, num3, 1f), new Vector3(num2 * 0.25f, num3 * 0.1f, 1f), profile.ImpactFlashColor, FadeOut(profile.ImpactFlashColor), vector * 0.25f, profile.ImpactFlashLifetime);
	}

	private void EmitSawShutdown(Vector2 sourcePoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float num = Mathf.Max(0.22f, profile.ProjectileSize.x * 1.05f);
		SpawnEffect(SummerRaceSpriteUtil.GetCircleSprite(), sourcePoint + vector * (profile.ProjectileSize.x * 0.25f), 0f, new Vector3(num, num, 1f), new Vector3(num * 0.68f, num * 0.68f, 1f), MultiplyAlpha(profile.TrailColor, 0.55f), FadeOut(profile.TrailColor), vector * 0.1f, profile.MuzzleFlashLifetime);
	}

	private void EmitShovelSwing(Vector2 sourcePoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float num = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		float num2 = Mathf.Max(0.34f, profile.ProjectileSize.x * 1.95f);
		float num3 = Mathf.Max(0.12f, profile.ProjectileSize.y * 1.1f);
		Vector2 position = sourcePoint + vector * (num2 * 0.38f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), position, num + 12f, new Vector3(num2, num3, 1f), new Vector3(num2 * 0.42f, num3 * 0.26f, 1f), profile.MuzzleFlashColor, FadeOut(profile.MuzzleFlashColor), vector * 0.75f, profile.MuzzleFlashLifetime + 0.02f);
	}

	private void EmitShovelImpact(Vector2 targetPoint, Vector2 direction, SummerRaceWeaponPresentationProfile profile)
	{
		Vector2 vector = ((direction.sqrMagnitude > 0.0001f) ? direction.normalized : Vector2.right);
		float rotationDegrees = Mathf.Atan2(vector.y, vector.x) * 57.29578f;
		float num = Mathf.Max(0.3f, profile.ImpactFlashScale * 1.15f);
		float num2 = Mathf.Max(0.14f, num * 0.48f);
		SpawnEffect(SummerRaceSpriteUtil.GetSquareSprite(), targetPoint, rotationDegrees, new Vector3(num, num2, 1f), new Vector3(num * 0.28f, num2 * 0.14f, 1f), profile.ImpactFlashColor, FadeOut(profile.ImpactFlashColor), vector * 0.18f, profile.ImpactFlashLifetime);
		SpawnEffect(SummerRaceSpriteUtil.GetCircleSprite(), targetPoint - vector * 0.04f, 0f, new Vector3(profile.ImpactRingStartScale * 0.85f, profile.ImpactRingStartScale * 0.6f, 1f), new Vector3(profile.ImpactRingEndScale * 1.05f, profile.ImpactRingEndScale * 0.72f, 1f), MultiplyAlpha(profile.ImpactRingColor, 0.82f), FadeOut(profile.ImpactRingColor), Vector2.zero, profile.ImpactRingLifetime);
	}

	private void SpawnEffect(Sprite sprite, Vector2 position, float rotationDegrees, Vector3 startScale, Vector3 endScale, Color startColor, Color endColor, Vector2 velocity, float lifetime)
	{
		if (enableTransientSpriteEffects)
		{
			ActiveSpriteEffect activeSpriteEffect = AcquireEffect();
			activeSpriteEffect.StartTime = Time.time;
			activeSpriteEffect.Lifetime = Mathf.Max(0.01f, lifetime);
			activeSpriteEffect.StartScale = startScale;
			activeSpriteEffect.EndScale = endScale;
			activeSpriteEffect.StartColor = startColor;
			activeSpriteEffect.EndColor = endColor;
			activeSpriteEffect.Velocity = velocity;
			activeSpriteEffect.Transform.position = position;
			activeSpriteEffect.Transform.rotation = Quaternion.Euler(0f, 0f, rotationDegrees);
			activeSpriteEffect.Transform.localScale = startScale;
			activeSpriteEffect.Renderer.sprite = sprite;
			activeSpriteEffect.Renderer.color = startColor;
			activeSpriteEffect.Renderer.enabled = true;
			activeEffects.Add(activeSpriteEffect);
		}
	}

	private ActiveSpriteEffect AcquireEffect()
	{
		if (pooledEffects.Count > 0)
		{
			return pooledEffects.Pop();
		}
		GameObject gameObject = new GameObject("TransientFx");
		gameObject.transform.SetParent(EnsureEffectRoot(), worldPositionStays: false);
		SpriteRenderer spriteRenderer = gameObject.AddComponent<SpriteRenderer>();
		spriteRenderer.sortingOrder = transientSortingOrder;
		SummerRaceSpriteMaterialUtility.ApplyDefault2D(spriteRenderer);
		return new ActiveSpriteEffect
		{
			Transform = gameObject.transform,
			Renderer = spriteRenderer
		};
	}

	private void RecycleEffect(ActiveSpriteEffect effect)
	{
		effect.Transform.SetParent(EnsureEffectRoot(), worldPositionStays: false);
		effect.Transform.localPosition = Vector3.zero;
		effect.Transform.localRotation = Quaternion.identity;
		effect.Transform.localScale = Vector3.one;
		effect.Renderer.enabled = false;
		effect.Renderer.sprite = null;
		pooledEffects.Push(effect);
	}

	private Transform EnsureEffectRoot()
	{
		if (effectRoot != null)
		{
			return effectRoot;
		}
		GameObject gameObject = new GameObject(base.name + "_CombatPresentationFx");
		gameObject.transform.SetPositionAndRotation(Vector3.zero, Quaternion.identity);
		effectRoot = gameObject.transform;
		return effectRoot;
	}

	private static Color FadeOut(Color color)
	{
		return new Color(color.r, color.g, color.b, 0f);
	}

	private static Color MultiplyAlpha(Color color, float alphaScale)
	{
		color.a *= Mathf.Clamp01(alphaScale);
		return color;
	}
}
