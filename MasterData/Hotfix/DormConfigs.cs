using UnityEngine;

public class DormConfigs
{
	public const bool enableRVOAvoidance = true;

	public const float rvoPriorityActor = 0.2f;

	public const float rvoPriorityPlayer = 1f;

	public static readonly Vector3 dormActorCapsuleColliderCenter = new Vector3(0f, 0.8f, 0f);

	public const float dormActorCapsuleColliderRadius = 0.4f;

	public const float dormActorCapsuleColliderHeight = 1.6f;

	public const int dormActorCapsuleColliderDirection = 1;

	public const float dormActorMovAgentRadius = 0.3f;

	public const float dormActorWalkSpeed = 1.2f;

	public const float dormActorRunSpeed = 3.41f;

	public const float dormPlayerWalkSpeed = 1.2f;

	public const float dormPlayerRunSpeed = 3.41f;

	public const float dormPlayerIdleShowDelay = 5f;

	public const float _moveSlowConeHalfAngle = 30f;

	public const float noticeRange = 2f;

	public static readonly Vector2 waitTimeRange = new Vector2(3f, 10f);

	public static readonly Vector2 roamIdleDurationRange = new Vector2(6f, 8f);

	public static readonly Vector2 roamMoveDurationRange = new Vector2(3f, 4f);

	public static readonly Vector2 roamIdleShowDelayRange = new Vector2(2f, 4f);

	public const float roamIdleWeight = 5f;

	public const float roamMoveWeight = 2f;

	public const float roamInteractWeight = 3f;

	public const bool enableRoamRepeatPenalty = true;

	public const float roamRepeatPenaltyFactor = 0.3f;

	public const int roamMaxSameBehaviourRun = 3;

	public const bool roamLogBehaviourPick = false;

	public const float roamSpecialIdleThreshold = 5f;

	public const float roamInteractMoveTimeout = 8f;

	public const float roamInteractArriveRange = 0.5f;

	public const float roamLeaveFurnitureDistance = 2f;

	public const float roamLeaveFurnitureTimeout = 5f;

	public const float avoidDistance = 1.5f;

	public const float actorRotationSpeed = 360f;

	public const float playerMoveRotationSpeed = 540f;

	public static bool marchInPlaceOnBlock = false;

	public static float marchInPlaceProbeDistance = 0.4f;

	public static float marchInPlaceMovedRatio = 0.2f;

	public static bool interactOcclusionCheck = true;

	public static float interactOcclusionRayHeight = 0.25f;

	public static bool playAnimSpaceCheckDebugDraw = false;

	public const float stuckMoveEpsilon = 0.08f;

	public const float stuckDuration = 0.5f;

	public const float actorOverlapRadius = 0.7f;

	public const bool enableActorOverlapSelfHeal = true;

	public const float actorOverlapSelfHealCheckInterval = 1f;

	public const float actorOverlapSelfHealDelay = 1.5f;

	public const float actorOverlapSelfHealMoveTimeout = 3f;

	public const bool avoidOccupiedInteractPoint = true;

	public const bool clearActorsNearInteractPoint = true;

	public const float clearActorsNearInteractPointRadius = 0.8f;

	public const float elevatorClearActorRadius = 1.5f;

	public const float elevatorDoorOpenDuration = 1f;

	public const float elevatorDoorCloseDuration = 1f;

	public const float elevatorMoveTimeout = 3f;

	public const bool elevatorAlwaysBlockNaviCut = true;

	public const bool enableInteractionNaviCut = true;

	public const float elevatorGlideSpeed = 1.2f;

	public const float noticeTurnSpeed = 360f;

	public const float playerTurnToActorSpeed = 360f;

	public const float noticeFaceCameraOffset = 180f;

	public const float noticeIdleShowDelay = 5f;

	public const float noticeCooldown = 5f;

	public const float furnitureInteractCooldown = 10f;

	public const float actorOnHoverForward = 210f;

	public const float cameraDragRotateRange = 0f;

	public const float dragEdgeScrollMargin = 0.1f;

	public const float dragEdgeScrollSpeed = 500f;

	public const float interactFocusDepthScale = 0.4f;

	public const float interactFocusMinDepth = 2f;

	public const float interactFocusActorWeight = 0.75f;

	public const bool interactFocusIgnoreFollowDeadzone = true;

	public const float interactFocusTransitionDuration = 0.5f;

	public const float interactFocusSettleEpsilon = 0.01f;

	public const float interactFocusPitchDegrees = 11f;

	public const float interactFocusSideYawOffset = 58f;

	public const float viewSelectFocusDepthScale = 0.75f;

	public const float viewSelectFocusPitchDegrees = -1f;

	public const float viewSelectFocusAimHeight = 0.8f;

	public const float viewSelectFocusMoveSpeed = 10f;

	public const bool viewSelectFocusSingleBlend = true;

	public const bool viewSelectFocusKeepPointOnExit = true;

	public const float interactFocusAimHeight = -0.1f;

	public const bool viewSelectFocusLockPoseFromEntry = true;

	public const bool interactFocusSmoothEase = true;

	public const bool interactFocusSideView = true;

	public const float viewTopPpsEnterZoom = 0.95f;

	public const float viewTopPpsExitZoom = 0.85f;

	public const float ppsWeightTweenDuration = 0.5f;

	public const string actorSocialEmojiPath = "Assets/AssetBundles/FX/Dorm/Emoji/Effect/fx_dorm_effect_love.prefab";

	public const string actorSocialBubblePath = "Assets/AssetBundles/FX/Dorm/Emoji/Bubble/fx_dorm_bubble_shy_1.prefab";

	public const SDFacialExpression actorSocialFacial = SDFacialExpression.Shy;

	public const float actorSocialFacialDuration = 2f;

	public static readonly Vector2 actorBlinkIntervalRange = new Vector2(2f, 6f);

	public static readonly Vector2 actorBlinkDurationRange = new Vector2(0.15f, 0.25f);

	public const float actorHoverHeight = 0.2f;

	public const float actorDragHoldSeconds = 0.3f;

	public const string actorHoverTopOfHeadFXPath = "Assets/AssetBundles/FX/Dorm/UI/fx_dorm_ui_hand_catch.prefab";

	public const string actorHoverPosMarkFXPath = "Assets/AssetBundles/FX/Dorm/UI/fx_dorm_ui_drop_point.prefab";

	public const string actorHoverCatchWwiseEvent = "Home_UI_catch";

	public const string actorHoverPutWwiseEvent = "Home_UI_put";

	public static float moveSlowConeHalfAngle => Mathf.Clamp(30f, 0f, 180f);
}
