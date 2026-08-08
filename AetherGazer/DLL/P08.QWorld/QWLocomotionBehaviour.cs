using System;
using System.Collections.Generic;
using P08.QWorld.Utilities;
using UnityEngine;

public class QWLocomotionBehaviour : QWAgentBehaviour, IQWLocomotionBehaviour
{
	public float skinWidth = 0.01f;

	public float radiusOffset = 0.01f;

	public float radiusPredictRatio = 0.5f;

	private Collider[] neighbours;

	private RaycastHit[] hits;

	private CapsuleCollider mCollider;

	[SerializeField]
	private List<QWLocomotionState> mStates;

	private Dictionary<QWLocomotionStateEnum, int> stateIdx;

	public QWLocomotionState DefaultState;

	public string CurAnimation;

	private QWLocomotionState activeState;

	private QWLocomotionState lastState;

	public bool CloneState = true;

	private QWSeekerMoveComponent seeker;

	public Transform target;

	public bool JustActivateState;

	[HideInInspector]
	public float mWalkStep;

	private bool mIsInRush;

	private bool mIsInSlowRush;

	public Action OnRushChanged;

	public Action OnRushStateChanged;

	private bool GroundRootPosition = true;

	public float AmendSpped = 6f;

	private Vector3 additivePosition;

	[SerializeField]
	private float mWalkSpeedRatio = 1f;

	[SerializeField]
	private float mRunSpeedRatio = 1f;

	[SerializeField]
	private float mFastRunSpeedRatio = 1f;

	[SerializeField]
	public float RotateSpeedRatio = 1f;

	[SerializeField]
	public float RushRotateSpeedRatio = 3f;

	public Transform platform;

	protected Vector3 Last_Platform_Pos;

	protected Quaternion Last_Platform_Rot;

	[Range(10f, 90f)]
	[Tooltip("Maximun and Minimun Angle on the terrain the animal can walk. If the Terrain Angle is higher than the Max value: the animal will slideDown")]
	public float SlopeLimit = 50f;

	[Tooltip("Angle on the terrain to start Sliding Down")]
	[Min(0f)]
	public float slideThreshold = 10f;

	[Tooltip("When the Animal gets to a Slide Because the Slope, This is the amount of pushing down")]
	public float slideAmount = 0.5f;

	[Tooltip("Damp Value to activate the sliding effect, Lower Value Faster to achieve the sliding")]
	public float slideDamp = 15f;

	[Tooltip("Maximun and Minimun Angle on the terrain the animal can walk. If the Terrain Angle is higher than the Max value: the animal will stop moving, if is lower than the Min Value: the animal will fall")]
	public Vector2 TerrainSlopeLimit = new Vector2(-50f, 45f);

	public LayerMask blockLayer;

	public Transform WallHit;

	private RaycastHit hit_chest;

	public LayerMask groundLayer;

	private bool grounded;

	private bool mInPlaceRotate;

	public float StartInPlacedTime;

	public QWAgentLayer CollisionLayer = QWAgentLayer.Player;

	private bool useGravity;

	[SerializeField]
	private Vector3 mGravityDir = Vector3.down;

	[SerializeField]
	private float mGravityPower = 9.8f;

	[SerializeField]
	private int mGravityTime = 1;

	[SerializeField]
	private float mClampGravitySpeed = 20f;

	public float LowWallHeight;

	public bool EnableCollisionTest;

	public bool EnableForceOnGround;

	private CapsuleCollider thisCollider
	{
		get
		{
			if (base.mAgent.GetAgentLayer() == QWAgentLayer.Player)
			{
				return (base.mAgent.Blackboard as QWCharacterBlackboard).BodyCollider;
			}
			if (mCollider == null)
			{
				mCollider = GetComponent<CapsuleCollider>();
			}
			return mCollider;
		}
	}

	public QWLocomotionState ActiveState
	{
		get
		{
			return activeState;
		}
		set
		{
			if (activeState != null)
			{
				activeState.OnExit(value.GetStateEnum());
			}
			activeState = value;
			JustActivateState = true;
		}
	}

	public QWLocomotionState LastState
	{
		get
		{
			return lastState;
		}
		set
		{
			lastState = value;
		}
	}

	public bool IsInSeeking
	{
		get
		{
			if (seeker != null)
			{
				return seeker.isInSeeking();
			}
			return false;
		}
	}

	public bool IsInSeekerPausing
	{
		get
		{
			if (seeker != null)
			{
				return seeker.isInPausing();
			}
			return false;
		}
	}

	public float DeltaTime { get; private set; }

	public Vector3 DeltaPos { get; private set; }

	public Animator Anim => base.mAgent.AgentAnimator;

	public bool IsInSleep => !base.mAgent.Blackboard.isInStage;

	public Quaternion Rotation
	{
		get
		{
			return base.transform.rotation;
		}
		set
		{
			base.transform.rotation = value;
		}
	}

	public Vector3 Position
	{
		get
		{
			return base.transform.position;
		}
		set
		{
			base.transform.position = value;
		}
	}

	public Vector3 LastPosition { get; private set; }

	public Vector3 Up => base.transform.up;

	public Vector3 Right => base.transform.right;

	public Vector3 Forward => base.transform.forward;

	public bool AllowRush { get; set; }

	public bool AllowFastRush { get; set; }

	public bool IsInRush
	{
		get
		{
			return mIsInRush;
		}
		set
		{
			if (IsPlayer && (bool)QWorldScene.Scene && QWorldScene.GetQWorldContext().InteractMode != QWInteractionModeEnum.ONLY_CONTROL_WALK)
			{
				mIsInRush = value;
				OnRushChanged?.Invoke();
			}
			else
			{
				mIsInRush = value;
				OnRushChanged?.Invoke();
			}
		}
	}

	public bool IsInFastRush
	{
		get
		{
			return mIsInSlowRush;
		}
		set
		{
			if (IsPlayer && (bool)QWorldScene.Scene && QWorldScene.GetQWorldContext().InteractMode != QWInteractionModeEnum.ONLY_CONTROL_WALK)
			{
				mIsInSlowRush = value;
				OnRushStateChanged?.Invoke();
			}
			else
			{
				mIsInSlowRush = value;
				OnRushStateChanged?.Invoke();
			}
		}
	}

	public bool IsInGroundMove
	{
		get
		{
			if (!CheckIsInState(QWLocomotionStateEnum.Move) && !CheckIsInState(QWLocomotionStateEnum.Rush))
			{
				return CheckIsInState(QWLocomotionStateEnum.FastRush);
			}
			return true;
		}
	}

	public float AnimatorSpeed { get; set; }

	public QWCharacterMovement InputMovement => base.mAgent.Blackboard.inputMovement;

	public Vector3 DeltaRootMotion { get; set; }

	public float TimeMultiplier { get; set; }

	public bool HasDefaultAnim => base.mAgent.Blackboard.defaultAnim.IsNotNullOrEmpty();

	public Vector3 AdditivePosition
	{
		get
		{
			return additivePosition;
		}
		set
		{
			additivePosition = value;
		}
	}

	public bool DisableRotation { get; set; }

	public bool IsPlayer => base.mAgent.GetAgentLayer() == QWAgentLayer.Player;

	public float WalkSpeedRatio
	{
		get
		{
			return mWalkSpeedRatio;
		}
		set
		{
			mWalkSpeedRatio = value;
			QWLocomotionState state = GetState(QWLocomotionStateEnum.Move);
			if (state != null)
			{
				state.SpeedDirty = true;
			}
		}
	}

	public float RunSpeedRatio
	{
		get
		{
			return mRunSpeedRatio;
		}
		set
		{
			mRunSpeedRatio = value;
			QWLocomotionState state = GetState(QWLocomotionStateEnum.Rush);
			if (state != null)
			{
				state.SpeedDirty = true;
			}
		}
	}

	public float FastRunSpeedRatio
	{
		get
		{
			return mFastRunSpeedRatio;
		}
		set
		{
			mFastRunSpeedRatio = value;
			QWLocomotionState state = GetState(QWLocomotionStateEnum.FastRush);
			if (state != null)
			{
				state.SpeedDirty = true;
			}
		}
	}

	public Vector3 DeltaPlatformPos { get; private set; }

	public Quaternion DeltaPlatformRot { get; private set; }

	public float SlopeAngleDifference { get; internal set; }

	public float MainPivotSlope { get; private set; }

	public Vector3 SlopeDirection { get; private set; }

	public float SlopeDirectionAngle { get; internal set; }

	public Vector3 SlopeNormal { get; private set; }

	public Vector3 SurfaceNormal { get; private set; }

	public Vector3 SlopeDirectionSmooth { get; set; }

	public LayerMask BlockLayer => blockLayer;

	public bool MainRay { get; private set; }

	public LayerMask GroundLayer => groundLayer;

	public bool IgnoreModeGrounded { get; private set; }

	public bool Grounded
	{
		get
		{
			return grounded;
		}
		set
		{
			if (grounded != value)
			{
				grounded = value;
				if (!value)
				{
					SetPlatform(null);
					SlopeNormal = UpVector;
				}
				else
				{
					GravityMultiplier = 1f;
					UseGravity = false;
				}
			}
		}
	}

	public bool InPlacedRotate
	{
		get
		{
			return mInPlaceRotate;
		}
		set
		{
			mInPlaceRotate = value;
		}
	}

	public float Pivot_Multiplier { get; private set; }

	public float ScaleFactor => base.transform.localScale.y;

	public Vector3 Main_Pivot_Point => base.mAgent.Center;

	public Vector2 BodySize => base.mAgent.BodySize;

	public bool IgnoreModeGravity { get; private set; }

	public bool UseGravity
	{
		get
		{
			return useGravity;
		}
		set
		{
			useGravity = value;
			if (!useGravity)
			{
				ResetGravityValues();
			}
		}
	}

	public Vector3 Gravity
	{
		get
		{
			return mGravityDir;
		}
		set
		{
			mGravityDir = value;
		}
	}

	public Vector3 UpVector => -mGravityDir;

	public float GravityPower
	{
		get
		{
			return mGravityPower;
		}
		set
		{
			mGravityPower = value;
		}
	}

	public int StartGravityTime
	{
		get
		{
			return mGravityTime;
		}
		private set
		{
			mGravityTime = value;
		}
	}

	public float ClampGravitySpeed
	{
		get
		{
			return mClampGravitySpeed;
		}
		private set
		{
			mClampGravitySpeed = value;
		}
	}

	public float GravityMultiplier { get; private set; }

	public float GravityExtraPower { get; set; }

	public Vector3 GravityStoredVelocity { get; set; }

	public Vector3 GravityOffset { get; set; }

	public bool ForceOnGround { get; set; }

	private void OnAction(QWAgentAction a)
	{
		if (a == null)
		{
			Debug.LogError("空Action 也能发??");
			return;
		}
		switch (a.Type)
		{
		case QWAgentAction.E_Type.ChangeRush:
			if (QWorldScene.GetQWorldContext().InteractMode != QWInteractionModeEnum.ONLY_CONTROL_WALK)
			{
				QWCharacterRushAction qWCharacterRushAction = a as QWCharacterRushAction;
				ChangeToRush(qWCharacterRushAction.isRush);
			}
			break;
		case QWAgentAction.E_Type.ChangeFastRush:
		{
			QWCharacterFastRushAction qWCharacterFastRushAction = a as QWCharacterFastRushAction;
			if (QWorldScene.GetQWorldContext().InteractMode != QWInteractionModeEnum.ONLY_CONTROL_WALK)
			{
				if (CheckIfGrounded() && AllowFastRush && qWCharacterFastRushAction.isFastRush && IsInGroundMove)
				{
					IsInRush = true;
					IsInFastRush = true;
					break;
				}
				QWLocomotionFastRushState obj = GetState(QWLocomotionStateEnum.FastRush) as QWLocomotionFastRushState;
				obj.exitTime = 0f;
				obj.isActionExitDirty = true;
				IsInFastRush = false;
			}
			break;
		}
		case QWAgentAction.E_Type.MoveToTarget:
		{
			QWMoveToTargetAction qWMoveToTargetAction = a as QWMoveToTargetAction;
			InPlacedRotate = false;
			if (qWMoveToTargetAction != null)
			{
				OnSeekerAction(qWMoveToTargetAction);
			}
			break;
		}
		case QWAgentAction.E_Type.RotateToForward:
			if (Grounded && !HasDefaultAnim)
			{
				InPlacedRotate = true;
				StartInPlacedTime = Time.time;
				base.mAgent.Blackboard.disableMoveInput = true;
				base.mAgent.Blackboard.inputMovement = new QWCharacterMovement((a as QWRotateToForwardAction).forward, 0.5f);
			}
			break;
		case QWAgentAction.E_Type.EnterInteractiveState:
			if ((a as QWEnterInteractiveStateAction).isEnter)
			{
				ForceToState(QWLocomotionStateEnum.Interactive);
			}
			else if (ActiveState.GetStateEnum() == QWLocomotionStateEnum.Interactive)
			{
				(ActiveState as QWLocomotionInteractiveState).SetLockState(isLock: false);
			}
			break;
		case QWAgentAction.E_Type.EnterPlayerFocusState:
			if ((a as QWCharacterEnterPlayerFocusAction).isEnter)
			{
				ForceToState(QWLocomotionStateEnum.PlayerFocus);
			}
			else if (ActiveState.GetStateEnum() == QWLocomotionStateEnum.PlayerFocus)
			{
				(ActiveState as QWLocomotionPlayerFocusState).SetLockState(isLock: false);
			}
			break;
		case QWAgentAction.E_Type.ChangeInteractionMode:
		{
			QWChangeInteractionModeAction changeMode = a as QWChangeInteractionModeAction;
			ChangeInteractionMode(changeMode);
			break;
		}
		case QWAgentAction.E_Type.Teleport:
			ResetGravityValues();
			break;
		}
	}

	private void ChangeToRush(bool isRush)
	{
		if ((CheckIfGrounded() && AllowRush) & isRush)
		{
			IsInRush = true;
		}
		else
		{
			IsInRush = false;
		}
	}

	private void ChangeInteractionMode(QWChangeInteractionModeAction changeMode)
	{
		switch (changeMode.mode)
		{
		case QWInteractionModeEnum.FULL:
			IsInRush = true;
			if (CheckIsInState(QWLocomotionStateEnum.Move))
			{
				ChangeToRush(isRush: true);
				ForceToState(QWLocomotionStateEnum.Rush);
			}
			break;
		case QWInteractionModeEnum.ONLY_CONTROL_WALK:
			IsInRush = false;
			if (CheckIsInState(QWLocomotionStateEnum.Rush) || CheckIsInState(QWLocomotionStateEnum.FastRush))
			{
				ChangeToRush(isRush: false);
				ForceToState(QWLocomotionStateEnum.Move);
			}
			break;
		case QWInteractionModeEnum.ONLY_CONTROL_RUN:
			IsInRush = true;
			if (CheckIsInState(QWLocomotionStateEnum.Move))
			{
				ChangeToRush(isRush: true);
				ForceToState(QWLocomotionStateEnum.Rush);
			}
			break;
		}
		LuaHelper.CallFunction("QWorldChangeInteractionMode", (int)changeMode.mode);
	}

	protected Vector3 ComputePenetrationIter(int iterTimes, float buttomOffset, float topOffset, float radius)
	{
		Vector3 zero = Vector3.zero;
		float num = 0.001f;
		for (int i = 0; i < iterTimes; i++)
		{
			Vector3 vector = ComputePenetration(buttomOffset, topOffset, radius);
			if (vector.magnitude < num)
			{
				break;
			}
			zero += vector;
			Position += vector;
		}
		return zero;
	}

	protected Vector3 ComputePenetration(float buttomOffset, float topOffset, float radius)
	{
		if (neighbours == null)
		{
			neighbours = new Collider[8];
		}
		int num = 0;
		Vector3 bottomCenter = base.mAgent.GetBottomCenter(base.transform.position, buttomOffset);
		Vector3 topCenter = base.mAgent.GetTopCenter(base.transform.position, topOffset);
		if (thisCollider == null)
		{
			return Vector3.zero;
		}
		for (int i = 0; i < neighbours.Length; i++)
		{
			neighbours[i] = null;
		}
		if (!thisCollider)
		{
			return Vector3.zero;
		}
		int layerMask = BlockLayer;
		num = Physics.OverlapCapsuleNonAlloc(bottomCenter, topCenter, radius * 2f, neighbours, layerMask);
		if (num == 0)
		{
			return Vector3.zero;
		}
		Vector3 zero = Vector3.zero;
		for (int j = 0; j < num; j++)
		{
			Collider collider = neighbours[j];
			if (collider.transform == thisCollider)
			{
				continue;
			}
			int layer = collider.gameObject.layer;
			if (((1 << layer) & (int)GroundLayer) > 0)
			{
				if (collider.transform == WallHit)
				{
					zero += ComputeBlockPenetration(collider);
				}
				else
				{
					zero += Vector3.zero;
				}
			}
			else if (((1 << layer) & (int)BlockLayer) > 0)
			{
				zero += ComputeBlockPenetration(collider);
			}
		}
		return Vector3.ClampMagnitude(zero, base.mAgent.BodySize.x * 0.5f);
	}

	private Vector3 ComputeBlockPenetration(Collider collider)
	{
		Vector3 position = collider.gameObject.transform.position;
		Quaternion rotation = collider.gameObject.transform.rotation;
		float distance = 0f;
		if (Physics.ComputePenetration(thisCollider, thisCollider.transform.position, thisCollider.transform.rotation, collider, position, rotation, out var direction, out distance))
		{
			Debug.DrawRay(base.transform.position, direction * 10f, Color.yellow);
			return direction * Mathf.Max(distance + skinWidth, 0.001f);
		}
		return Vector3.zero;
	}

	private bool CheckCollisionPredict(Vector3 moveDelta, out Vector3 safeDelta)
	{
		safeDelta = moveDelta;
		if (!thisCollider)
		{
			return true;
		}
		int layerMask = BlockLayer;
		Vector3 bottomCenter = base.mAgent.GetBottomCenter(base.transform.position);
		Vector3 topCenter = base.mAgent.GetTopCenter(base.transform.position);
		if (Physics.CapsuleCast(bottomCenter, topCenter, thisCollider.radius * radiusPredictRatio, moveDelta.normalized, out var hitInfo, moveDelta.magnitude + skinWidth, layerMask))
		{
			float num = hitInfo.distance - radiusOffset;
			safeDelta = moveDelta.normalized * num;
			return true;
		}
		return false;
	}

	public override void Initialize()
	{
		base.Initialize();
		InitVar();
		InitState();
		SetPivot();
		ResetController();
		QWBlackboard blackboard = base.mAgent.Blackboard;
		blackboard.ActionHandler = (QWBlackboard.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new QWBlackboard.AgentActionHandler(OnAction));
	}

	public override void UpdateBehavior()
	{
		UpdateSeeker();
	}

	private void InitVar()
	{
		JustActivateState = false;
		TimeMultiplier = 1f;
		AnimatorSpeed = 1f;
		DisableRotation = false;
		IsInRush = IsPlayer && QWorldScene.GetQWorldContext().InteractMode != QWInteractionModeEnum.ONLY_CONTROL_WALK;
		AllowRush = false;
		AllowFastRush = true;
		InPlacedRotate = false;
	}

	private void InitState()
	{
		stateIdx = new Dictionary<QWLocomotionStateEnum, int>();
		for (int i = 0; i < mStates.Count; i++)
		{
			if (CloneState)
			{
				QWLocomotionState qWLocomotionState = UnityEngine.Object.Instantiate(mStates[i]);
				if (mStates[i] == DefaultState)
				{
					DefaultState = qWLocomotionState;
				}
				stateIdx.Add(qWLocomotionState.GetStateEnum(), i);
				mStates[i] = qWLocomotionState;
			}
			mStates[i].Init(this);
		}
		ActiveState = DefaultState;
	}

	public void AppendState(QWLocomotionState state)
	{
		if (!stateIdx.ContainsKey(state.GetStateEnum()))
		{
			if (CloneState)
			{
				QWLocomotionState qWLocomotionState = UnityEngine.Object.Instantiate(state);
				stateIdx.Add(qWLocomotionState.GetStateEnum(), mStates.Count);
				mStates.Add(qWLocomotionState);
				qWLocomotionState.Init(this);
			}
			else
			{
				stateIdx.Add(state.GetStateEnum(), mStates.Count);
				mStates.Add(state);
				state.Init(this);
			}
		}
	}

	public void ResetController()
	{
		CurAnimation = "";
		if ((bool)Anim)
		{
			Anim.speed = AnimatorSpeed * TimeMultiplier;
		}
		foreach (QWLocomotionState mState in mStates)
		{
			mState.Init(this);
		}
		JustActivateState = false;
		LastPosition = Position;
		GravityMultiplier = 1f;
		GravityExtraPower = 1f;
		mWalkStep = 0f;
		ForceOnGround = true;
		MainRay = false;
		Grounded = true;
		DetectionIfGround();
	}

	public bool CheckIfGrounded()
	{
		if (IsPlayer)
		{
			return MainRay;
		}
		return true;
	}

	public bool DetectionIfGround()
	{
		if (EnableForceOnGround)
		{
			AlignRayCasting();
			if (MainRay)
			{
				Grounded = true;
			}
			return MainRay;
		}
		Grounded = true;
		return true;
	}

	public bool CheckIsInState(QWLocomotionStateEnum state)
	{
		if (ActiveState == null)
		{
			return false;
		}
		return state == ActiveState.GetStateEnum();
	}

	public bool CheckLastIsInState(QWLocomotionStateEnum state)
	{
		if (LastState == null)
		{
			return false;
		}
		return state == LastState.GetStateEnum();
	}

	public override void LateUpdateBehavior()
	{
	}

	public void OnAnimatorMove()
	{
		OnLocomotion();
	}

	protected virtual void OnActivateStatePerform()
	{
		ActiveState.OnAnimatorPerform();
	}

	protected virtual void OnLocomotion()
	{
		DeltaTime = Time.deltaTime;
		if ((double)DeltaTime > 0.033)
		{
			DeltaTime = 0.033f;
		}
		DeltaPos = Position - LastPosition;
		if (IsInSleep)
		{
			if (InPlacedRotate)
			{
				StartInPlacedTime = Time.time;
			}
		}
		else
		{
			if (base.mAgent.Blackboard.disableMove)
			{
				return;
			}
			ResetValue();
			UpdateSpeedReduce();
			if (ActiveState == null)
			{
				return;
			}
			if (Anim != null)
			{
				Anim.speed = AnimatorSpeed * TimeMultiplier;
			}
			ActiveState.InputAxisUpdate();
			ActiveState.SetCanExit();
			ActiveState.OnStatePreMove();
			ActiveState.OnStateMove();
			OnActivateStatePerform();
			PlatformMovement();
			if (EnableForceOnGround)
			{
				if (!GroundedLogic())
				{
					SurfaceNormal = UpVector;
					SlopeMovement();
					GravityLogic();
				}
			}
			else
			{
				SurfaceNormal = UpVector;
			}
			if (float.IsNaN(AdditivePosition.x))
			{
				return;
			}
			DetectionIfGround();
			if (IsPlayer && InPlacedRotate && Time.time - StartInPlacedTime > 1f)
			{
				base.mAgent.Blackboard.inputMovement = new QWCharacterMovement(base.transform.forward, 0f);
				InPlacedRotate = false;
			}
			if (!base.mAgent.Blackboard.disablePosition && !InPlacedRotate && base.mAgent.Blackboard.diablePositionFrame <= 0)
			{
				if (EnableForceOnGround && ForceOnGround)
				{
					AmendVerticalPos();
				}
				Internal_Position_Predict();
			}
			else
			{
				AdditivePosition = Vector3.zero;
				if (EnableForceOnGround && ForceOnGround)
				{
					AmendVerticalPos();
				}
				Internal_Position_Predict();
			}
			if (!DisableRotation)
			{
				float num = RotateSpeedRatio;
				if (CheckIsInState(QWLocomotionStateEnum.Rush) || CheckIsInState(QWLocomotionStateEnum.FastRush))
				{
					num = RushRotateSpeedRatio;
				}
				Vector3 vector = Vector3.Slerp(base.transform.forward, Vector3.ProjectOnPlane(base.mAgent.Blackboard.inputMovement.Value, UpVector), num * DeltaTime * TimeMultiplier * 8f);
				if (!vector.IsTooSmall())
				{
					Rotation = Quaternion.LookRotation(vector);
				}
				if (InPlacedRotate && Vector3.Angle(base.transform.forward.normalized, base.mAgent.Blackboard.inputMovement.Direction.normalized) <= 5f)
				{
					base.mAgent.Blackboard.inputMovement = new QWCharacterMovement(base.transform.forward, 0f);
				}
			}
			Internal_State_Transition();
			if (base.mAgent.Blackboard.diablePositionFrame > 0)
			{
				base.mAgent.Blackboard.diablePositionFrame--;
			}
			else if (!base.mAgent.Blackboard.disableMove)
			{
				if (EnableCollisionTest)
				{
					float buttomOffset = 0f;
					float topOffset = 0f;
					ComputePenetrationIter(5, buttomOffset, topOffset, base.mAgent.BodySize.x * 0.5f);
				}
				LastPosition = Position;
				additivePosition = Vector3.zero;
			}
		}
	}

	public void Internal_Position_Predict()
	{
		if (IsPlayer && CheckCollisionPredict(AdditivePosition, out var safeDelta))
		{
			Position += safeDelta;
		}
		else
		{
			Position += AdditivePosition;
		}
	}

	private void Internal_State_Transition()
	{
		TryExitActiveState();
		TryActivateState();
	}

	private void ResetValue()
	{
		if (!(Anim == null) && Anim.isActiveAndEnabled && !(Anim.deltaPosition == Vector3.zero))
		{
			if (IsPlayer)
			{
				DeltaRootMotion = (GroundRootPosition ? Anim.deltaPosition : Vector3.zero);
			}
			else
			{
				DeltaRootMotion = Anim.deltaPosition;
			}
			if (GroundRootPosition && Anim.deltaPosition.magnitude > 1f)
			{
				DeltaRootMotion = Anim.deltaPosition.normalized * 0.04f;
			}
			AdditivePosition = DeltaRootMotion;
			WallHit = null;
		}
	}

	private void UpdateSpeedReduce()
	{
		mWalkStep = Mathf.MoveTowards(mWalkStep, base.mAgent.Blackboard.inputMovement.Magnitude, 8f * DeltaTime);
		float max = (IsInRush ? 1f : 0.5f);
		mWalkStep = Mathf.Clamp(mWalkStep, 0f, max);
	}

	private bool GroundedLogic()
	{
		if (Grounded && !IgnoreModeGrounded)
		{
			SlopeMovement();
			AlignRayCasting();
			return true;
		}
		return false;
	}

	protected virtual void AlignRayCasting()
	{
		MainRay = false;
		float num = Pivot_Multiplier * ScaleFactor + LowWallHeight;
		num += Vector3.Project(AdditivePosition, UpVector).magnitude;
		Vector3 origin = Main_Pivot_Point + (AdditivePosition + Vector3.Project(AdditivePosition, UpVector).magnitude * UpVector);
		int num2 = GroundLayer.value;
		if (EnableCollisionTest)
		{
			num2 |= BlockLayer.value;
		}
		if (Physics.Raycast(origin, -UpVector, out hit_chest, num, num2))
		{
			MainRay = true;
			SlopeNormal = hit_chest.normal;
			MainPivotSlope = Vector3.SignedAngle(SlopeNormal, UpVector, Right);
			SlopeDirection = Vector3.ProjectOnPlane(Gravity, SlopeNormal).normalized;
			SlopeDirectionAngle = 90f - Vector3.Angle(Gravity, SlopeDirection);
			if (Mathf.Approximately(SlopeDirectionAngle, 90f))
			{
				SlopeDirectionAngle = 0f;
			}
			SetPlatform(hit_chest.transform);
		}
		else
		{
			SetPlatform(null);
		}
	}

	private void SlopeMovement()
	{
	}

	public void SetPlatform(Transform newPlatform)
	{
		if (!(platform != newPlatform))
		{
			return;
		}
		GroundRootPosition = true;
		platform = newPlatform;
		if (platform != null)
		{
			Last_Platform_Pos = platform.position;
			Last_Platform_Rot = platform.rotation;
		}
		foreach (QWLocomotionState mState in mStates)
		{
			mState.OnPlataformChanged();
		}
	}

	private void PlatformMovement()
	{
		if (!(platform == null) && !platform.gameObject.isStatic)
		{
			DeltaPlatformPos = platform.position - Last_Platform_Pos;
			Position += DeltaPlatformPos;
			Quaternion quaternion = Quaternion.Inverse(Last_Platform_Rot);
			DeltaPlatformRot = quaternion * platform.rotation;
			if (DeltaPlatformRot != Quaternion.identity)
			{
				Vector3 vector = base.transform.DeltaPositionFromRotate(platform.position, DeltaPlatformRot);
				Position += vector;
				DeltaPlatformPos += vector;
			}
			Rotation *= DeltaPlatformRot;
			Last_Platform_Pos = platform.position;
			Last_Platform_Rot = platform.rotation;
		}
	}

	public override void OnFirstAddToStage()
	{
		if (stateIdx.ContainsKey(QWLocomotionStateEnum.CustomIdle))
		{
			if (CheckIsInState(QWLocomotionStateEnum.CustomIdle))
			{
				ActiveState.ReActivate();
			}
			else
			{
				ForceToState(QWLocomotionStateEnum.CustomIdle);
			}
		}
	}

	public void GravityLogic()
	{
		if (UseGravity && !IgnoreModeGravity && !Grounded)
		{
			StoredGravityVelocity();
			if (ClampGravitySpeed > 0f && ClampGravitySpeed * ClampGravitySpeed < GravityStoredVelocity.sqrMagnitude)
			{
				GravityStoredVelocity = GravityStoredVelocity.normalized * ClampGravitySpeed;
			}
			AdditivePosition += DeltaTime * GravityExtraPower * GravityStoredVelocity + GravityOffset * DeltaTime;
		}
	}

	private void StoredGravityVelocity()
	{
		GravityStoredVelocity += DeltaTime * GravityPower * Gravity;
	}

	protected virtual void TryExitActiveState()
	{
		if (ActiveState.CanExit)
		{
			ActiveState.TryExitState();
		}
	}

	protected virtual void TryActivateState()
	{
		JustActivateState = false;
		foreach (QWLocomotionState mState in mStates)
		{
			if (!(mState == ActiveState) && (!ActiveState.IgnoreLowerStates || ActiveState.Priority <= mState.Priority) && ActiveState.CanExit && mState.TryActivate())
			{
				LastState = ActiveState;
				mState.Activate();
				break;
			}
		}
	}

	protected void ForceToState(QWLocomotionStateEnum state)
	{
		if (stateIdx.TryGetValue(state, out var value))
		{
			ActiveState.TryExitState();
			LastState = ActiveState;
			mStates[value].Activate();
		}
	}

	protected QWLocomotionState GetState(QWLocomotionStateEnum state)
	{
		if (stateIdx.TryGetValue(state, out var value))
		{
			return mStates[value];
		}
		return null;
	}

	private void AmendVerticalPos()
	{
		if (CheckIfGrounded())
		{
			float num = hit_chest.distance - Pivot_Multiplier * ScaleFactor;
			if (num <= 0f)
			{
				Vector3 b = AdditivePosition + -UpVector * num;
				AdditivePosition = Vector3.Lerp(AdditivePosition, b, AmendSpped * DeltaTime);
			}
			else if (!base.mAgent.Blackboard.inputMovement.Magnitude.AlmostZero() || !base.mAgent.Blackboard.inputMovement.Value.IsTooSmall())
			{
				Vector3 b2 = AdditivePosition + -UpVector * num;
				AdditivePosition = Vector3.Lerp(AdditivePosition, b2, AmendSpped * DeltaTime);
			}
			else if (Mathf.Abs(num) >= 0.002f)
			{
				Vector3 b3 = AdditivePosition + -UpVector * num;
				AdditivePosition = Vector3.Lerp(AdditivePosition, b3, AmendSpped * DeltaTime);
			}
		}
	}

	public void OnSeekerAction(QWMoveToTargetAction mta)
	{
		switch (mta.moveType)
		{
		case QWMoveActionType.FindPath:
			if (seeker == null)
			{
				seeker = new QWSeekerMoveComponent(base.transform);
				QWSeekerMoveComponent qWSeekerMoveComponent5 = seeker;
				qWSeekerMoveComponent5.OnMove = (QWOnSeekerDelegate)Delegate.Combine(qWSeekerMoveComponent5.OnMove, new QWOnSeekerDelegate(OnSeekerMove));
				QWSeekerMoveComponent qWSeekerMoveComponent6 = seeker;
				qWSeekerMoveComponent6.OnStartMove = (Action)Delegate.Combine(qWSeekerMoveComponent6.OnStartMove, new Action(OnSeekerStartMove));
				QWSeekerMoveComponent qWSeekerMoveComponent7 = seeker;
				qWSeekerMoveComponent7.OnStop = (Action)Delegate.Combine(qWSeekerMoveComponent7.OnStop, new Action(OnSeekerStop));
			}
			seeker.StartSeeker(mta.target.position, mta.testRadius);
			break;
		case QWMoveActionType.FindByRoute:
			if (seeker == null)
			{
				seeker = new QWSeekerMoveComponent(base.transform);
				QWSeekerMoveComponent qWSeekerMoveComponent = seeker;
				qWSeekerMoveComponent.OnMove = (QWOnSeekerDelegate)Delegate.Combine(qWSeekerMoveComponent.OnMove, new QWOnSeekerDelegate(OnSeekerMove));
				QWSeekerMoveComponent qWSeekerMoveComponent2 = seeker;
				qWSeekerMoveComponent2.OnStartMove = (Action)Delegate.Combine(qWSeekerMoveComponent2.OnStartMove, new Action(OnSeekerStartMove));
				QWSeekerMoveComponent qWSeekerMoveComponent3 = seeker;
				qWSeekerMoveComponent3.OnStop = (Action)Delegate.Combine(qWSeekerMoveComponent3.OnStop, new Action(OnSeekerStop));
				QWSeekerMoveComponent qWSeekerMoveComponent4 = seeker;
				qWSeekerMoveComponent4.OnInteractionChange = (QWOnOnInteractionChange)Delegate.Combine(qWSeekerMoveComponent4.OnInteractionChange, new QWOnOnInteractionChange(OnInteractionChange));
			}
			seeker.StartSeekerByRoute(new QWSeekerByRouteContext
			{
				needForward = mta.needForward,
				endForward = mta.endForward,
				enableInteraction = mta.enableInteraction,
				inteactionMode = mta.interactionMode
			}, mta.routes, mta.stopCallback, mta.arriveCallback, mta.isRun, mta.testRadius, mta.pauseRadius, mta.pauseCallback);
			break;
		}
	}

	private void UpdateSeeker()
	{
		seeker?.Tick();
		if (!IsPlayer && base.mAgent.IsInit)
		{
			if (IsInSeeking || InPlacedRotate)
			{
				OnLocomotion();
			}
			else
			{
				OnActivateStatePerform();
			}
		}
	}

	private void OnInteractionChange(bool enableInteraction, int mode)
	{
		if (enableInteraction)
		{
			if ((bool)QWorldScene.Scene)
			{
				QWorldScene.GetQWorldContext().ChangeInteractionMode((QWInteractionModeEnum)mode);
			}
		}
		else if ((bool)QWorldScene.Scene)
		{
			QWorldScene.GetQWorldContext().ChangeInteractionMode(QWInteractionModeEnum.FULL);
		}
	}

	private void OnSeekerMove(Vector3 dir, Vector3 targetPos)
	{
		base.mAgent.Blackboard.inputMovement.Direction = dir;
		base.mAgent.Blackboard.inputMovement.Magnitude = 1f;
		IsInRush = seeker.isRun;
	}

	private void OnSeekerStartMove()
	{
		if (IsPlayer)
		{
			base.mAgent.Blackboard.disableMoveInput = true;
		}
		else
		{
			EnableForceOnGround = true;
		}
		IsInRush = seeker.isRun;
	}

	private void OnSeekerStop()
	{
		base.mAgent.Blackboard.inputMovement.Direction = base.transform.forward;
		base.mAgent.Blackboard.inputMovement.Magnitude = 0f;
		if (IsPlayer)
		{
			base.mAgent.Blackboard.disableMoveInput = false;
		}
		else if (!base.mAgent.Blackboard.IsInSeeking)
		{
			EnableForceOnGround = false;
		}
		IsInRush = false;
	}

	public void SetPivot()
	{
		Pivot_Multiplier = base.mAgent.BodySize.y * 0.5f;
	}

	public bool CheckNeedCollisionTest()
	{
		QWAgentLayer agentLayer = base.mAgent.GetAgentLayer();
		return (CollisionLayer & agentLayer) > (QWAgentLayer)0;
	}

	private void ResetGravityValues()
	{
		GravityStoredVelocity = Vector3.zero;
		GravityOffset = Vector3.zero;
	}
}
