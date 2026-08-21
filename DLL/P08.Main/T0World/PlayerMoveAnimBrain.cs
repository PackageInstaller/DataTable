using System;
using System.Collections.Generic;
using System.Diagnostics;
using Animancer;
using Animancer.FSM;
using Sirenix.OdinInspector;
using UnityEngine;
using XXXXPathfinding;

namespace T0World;

[Serializable]
public class PlayerMoveAnimBrain : SerializedMonoBehaviour
{
	public enum MoveState
	{
		Start,
		Loop,
		End,
		Idle
	}

	public interface IInputProvider
	{
		Vector3 PlayerInput { get; }

		bool InputIsWorldSpaceDir { get; }
	}

	public class TestInputProvider : IInputProvider
	{
		public Vector3 PlayerInput => new Vector3(Input.GetAxis("Horizontal"), 0f, Input.GetAxis("Vertical"));

		[field: SerializeField]
		public bool InputIsWorldSpaceDir { get; }
	}

	public Transform player;

	public AnimancerComponent animancer;

	public string aniDataProfilePath;

	public MoveAniData aniData;

	[Tooltip("移动起步阶段逐步从 期望的动画结束朝向矢量 到 实际面朝方向矢量 的插值权重")]
	public AnimationCurve moveStartDirAjustSpeedWeight = AnimationCurve.Linear(0f, 0f, 1f, 1f);

	[Tooltip("移动结束阶段角度调整速度权重曲线")]
	public AnimationCurve moveEndDirAjustSpeedWeight = AnimationCurve.Linear(0f, 1f, 1f, 0f);

	[HideInInspector]
	public SmoothedFloatParameter rotationValueParameter;

	[HideInInspector]
	public SmoothedFloatParameter speedValueParameter;

	[HideInInspector]
	public SmoothedFloatParameter walkCarefulnessParamter;

	public MoveState moveState = MoveState.Idle;

	public IInputProvider playerInputProvider;

	[HideInInspector]
	public Vector3? overrideMoveInput;

	public Transform moveEndTargetReferenceTrs;

	public bool moveEndPosAlignToTarget;

	public bool moveEndForwardAlignToTarget;

	public Transform leftFeetTrs;

	public Transform rightFeetTrs;

	private StateMachine<PlayerState> stateMachine;

	private MoveStartState startState;

	private MoveLoopState loopState;

	private MoveEndState endState;

	private IdleState idleState;

	public float rotateAngleAdjustSpeed = 60f;

	public float rotateAngleLimitSpeed = 60f;

	public float rotateSmoothTime = 0.3f;

	private Vector3 playerPrevPos;

	private Vector3 playerFwdBeforeCompensation;

	public CharacterController characterController;

	public bool useGravity = true;

	public RichAI ai;

	public AIDestinationSetter aIDestinationSetter;

	public bool stopAIOnReachTarget = true;

	private bool waitAnim;

	private CriAtomSource sfxSourcePlayer;

	private Vector3 PlayerInput => (InputIsWorldSpaceDir ? Quaternion.identity : player.rotation) * (playerInputProvider?.PlayerInput ?? Vector3.zero).normalized;

	public Vector3 MoveInput => overrideMoveInput ?? PlayerInput;

	public bool InputIsWorldSpaceDir => playerInputProvider?.InputIsWorldSpaceDir ?? false;

	public bool InputIsValid => MoveInput != Vector3.zero;

	public Vector3? MoveEndEstimateFacingDir
	{
		get
		{
			if ((bool)moveEndTargetReferenceTrs && moveEndForwardAlignToTarget)
			{
				return moveEndTargetReferenceTrs.forward;
			}
			return moveEndFacingDir;
		}
	}

	public Vector3? MoveEndEstimateTargetPos
	{
		get
		{
			if ((bool)moveEndTargetReferenceTrs && moveEndPosAlignToTarget)
			{
				return moveEndTargetReferenceTrs.position;
			}
			return moveEndTargetPos;
		}
	}

	public Vector3? moveEndFacingDir { get; set; }

	public Vector3? moveEndTargetPos { get; set; }

	public bool WaitAnim
	{
		get
		{
			return waitAnim;
		}
		set
		{
			if (waitAnim != value)
			{
				waitAnim = value;
				if (value && aniData != null)
				{
					stateMachine.ForceSetState(idleState);
				}
			}
		}
	}

	public bool IsAINavigatingMove
	{
		get
		{
			if (IsNavigatingByAI && IsNavigatingDestinationValid && (ai.pathPending || !ai.reachedEndOfPath))
			{
				return true;
			}
			return false;
		}
	}

	public bool IsAINavigationTargetNearBy
	{
		get
		{
			if (IsNavigatingDestinationValid && (ai.destination - ai.position).sqrMagnitude < ai.endReachedDistance * ai.endReachedDistance)
			{
				return true;
			}
			return false;
		}
	}

	[Tooltip("当目标距离小于导航死区范围，AI不进行方向输入")]
	public float navigatingDeadZone
	{
		get
		{
			if ((bool)ai)
			{
				return ai.endReachedDistance;
			}
			return float.NaN;
		}
		set
		{
			if ((bool)ai)
			{
				ai.endReachedDistance = value;
			}
		}
	}

	public float aiMoveCarefulnessFactor
	{
		get
		{
			if (walkCarefulnessParamter == null)
			{
				return 0f;
			}
			return walkCarefulnessParamter.CurrentValue;
		}
	}

	public float walkCarefulness
	{
		get
		{
			if (walkCarefulnessParamter == null)
			{
				return 0f;
			}
			return walkCarefulnessParamter.TargetValue;
		}
		set
		{
			if (walkCarefulnessParamter != null)
			{
				walkCarefulnessParamter.TargetValue = value;
			}
		}
	}

	public bool IsNavigatingByAI
	{
		get
		{
			if (ai != null)
			{
				return !ai.isStopped;
			}
			return false;
		}
	}

	public bool IsNavigatingDestinationValid
	{
		get
		{
			if (ai != null)
			{
				return !float.IsPositiveInfinity(ai.destination.x);
			}
			return false;
		}
	}

	private CriAtomSource SfxSourcePlayer
	{
		get
		{
			if (sfxSourcePlayer == null)
			{
				GameObject gameObject = new GameObject(base.gameObject.name + "_sfx");
				gameObject.transform.SetParent(player, worldPositionStays: false);
				sfxSourcePlayer = gameObject.AddComponent<CriAtomSource>();
			}
			return sfxSourcePlayer;
		}
	}

	private void SetRotationParamMaxSpeed(float value)
	{
		if (rotationValueParameter != null)
		{
			rotationValueParameter.MaxSpeed = value;
		}
	}

	private void SetRotationParamSmoothTime(float value)
	{
		if (rotationValueParameter != null)
		{
			rotationValueParameter.SmoothTime = value;
		}
	}

	[Conditional("UNITY_EDITOR")]
	internal void DebugDraw(Vector3 dir, Color color, Vector3 offset)
	{
		UnityEngine.Debug.DrawLine(player.position + offset, 2f * dir.normalized + player.position + offset, color, 0f, depthTest: false);
	}

	[Conditional("UNITY_EDITOR")]
	internal void DebugDraw(Vector3 dir, Color color)
	{
	}

	public void UpdateMovementAnim()
	{
		if (aniData == null)
		{
			return;
		}
		if (InputIsValid)
		{
			if (!LoopMove())
			{
				StartMove();
			}
		}
		else if (stateMachine.CanSetState(endState))
		{
			EndMove();
		}
		else
		{
			Idle();
		}
		stateMachine.CurrentState.OnUpdate();
	}

	public void RecordPosAndFwd(Quaternion animationDeltaRot)
	{
		playerFwdBeforeCompensation = animationDeltaRot * player.localRotation * Vector3.forward;
		playerFwdBeforeCompensation.y = 0f;
		playerFwdBeforeCompensation.Normalize();
		playerPrevPos = player.localPosition;
	}

	private void MoveStep(Quaternion deltaRotation, Vector3 deltaPosition, float dt)
	{
		player.rotation = deltaRotation * player.rotation;
		if ((bool)characterController && characterController.enabled && !WaitAnim)
		{
			Vector3 gravity = Physics.gravity;
			Vector3 vector = Vector3.zero;
			if (useGravity)
			{
				vector = Vector3.Project(characterController.velocity, gravity.normalized);
				if (characterController.isGrounded && Vector3.Dot(vector, gravity) > 0f)
				{
					vector = Vector3.zero;
				}
				vector += dt * gravity;
			}
			characterController.Move(deltaPosition + vector * dt);
		}
		else
		{
			player.position += deltaPosition;
		}
	}

	public void StopAIMove()
	{
		if (ai != null)
		{
			ai.isStopped = true;
		}
		if ((bool)aIDestinationSetter)
		{
			aIDestinationSetter.enabled = false;
		}
	}

	public void EnableAIMove()
	{
		if (ai != null)
		{
			ai.isStopped = false;
		}
		if ((bool)aIDestinationSetter)
		{
			aIDestinationSetter.enabled = true;
		}
	}

	private void Awake()
	{
		if (aniData == null)
		{
			if (!string.IsNullOrEmpty(aniDataProfilePath))
			{
				Asset.LoadAssetAsync(aniDataProfilePath, delegate(MoveAniData asset)
				{
					InitAniData(asset);
				});
			}
		}
		else
		{
			InitAniData(aniData);
		}
		idleState = new IdleState(this);
		startState = new MoveStartState(this);
		loopState = new MoveLoopState(this);
		endState = new MoveEndState(this);
		stateMachine = new StateMachine<PlayerState>();
	}

	private void InitAniData(MoveAniData aniData)
	{
		this.aniData = aniData;
		rotationValueParameter = new SmoothedFloatParameter(animancer, aniData.rotationValueParameter, rotateSmoothTime, rotateAngleLimitSpeed);
		speedValueParameter = new SmoothedFloatParameter(animancer, aniData.speedValueParameter, 0.5f);
		walkCarefulnessParamter = new SmoothedFloatParameter(animancer, "walkCarefulness", 0.2f);
	}

	private void Start()
	{
		StopAIMove();
	}

	private void OnEnable()
	{
		waitAnim = false;
		if (aniData != null)
		{
			stateMachine.ForceSetState(idleState);
		}
	}

	private void Update()
	{
		if (!WaitAnim)
		{
			UpdateMovementAnim();
		}
	}

	private void AINavigationUpdate(float dt, out Vector3 nextPosition, out Quaternion nextRotation)
	{
		Vector3 position = player.position;
		ai.MovementUpdate(dt, out nextPosition, out nextRotation);
		bool flag = false;
		if (Vector3.Distance(position, ai.destination) < navigatingDeadZone)
		{
			overrideMoveInput = Vector3.zero;
			flag = true;
		}
		else
		{
			if (!ai.pathPending && ai.reachedEndOfPath)
			{
				flag = true;
			}
			overrideMoveInput = (ai.steeringTarget - position).normalized;
		}
		if (flag && stopAIOnReachTarget)
		{
			StopAIMove();
		}
	}

	private void OnAnimatorMove()
	{
		if (stateMachine.CurrentState == null)
		{
			return;
		}
		float deltaTime = Time.deltaTime;
		overrideMoveInput = null;
		RecordPosAndFwd(animancer.Animator.deltaRotation);
		if (ai != null && !ai.isStopped && !WaitAnim)
		{
			AINavigationUpdate(deltaTime, out var nextPosition, out var nextRotation);
			(Quaternion, Vector3) tuple = stateMachine.CurrentState.UpdateMove(deltaTime);
			Quaternion item = tuple.Item1;
			Vector3 a = tuple.Item2 + player.position;
			if (useGravity)
			{
				ai.movementPlane.ToPlane(ai.desiredVelocity, out var elevation);
				Vector3 vector = ai.movementPlane.ToWorld(Vector2.zero, 1f);
				Vector3 vector2 = elevation * deltaTime * vector;
				a += vector2;
			}
			Quaternion a2 = item * player.rotation;
			Vector3 nextPosition2 = Vector3.Lerp(a, nextPosition, aiMoveCarefulnessFactor);
			Quaternion nextRotation2 = Quaternion.Slerp(a2, nextRotation, aiMoveCarefulnessFactor);
			ai.FinalizeMovement(nextPosition2, nextRotation2);
		}
		else
		{
			var (deltaRotation, deltaPosition) = stateMachine.CurrentState.UpdateMove(deltaTime);
			MoveStep(deltaRotation, deltaPosition, deltaTime);
		}
		Vector3 to = player.localRotation * Vector3.forward;
		to.y = 0f;
		to.Normalize();
		float num = Vector3.SignedAngle(playerFwdBeforeCompensation, to, Vector3.up);
		Vector3 vector3 = player.localPosition - playerPrevPos;
		speedValueParameter.TargetValue = vector3.magnitude / deltaTime;
		rotationValueParameter.TargetValue = num / deltaTime;
		T0WorldScene.Scene.player.UpdateCollisionTest();
	}

	private bool StartMove()
	{
		return stateMachine.TrySetState(startState);
	}

	private bool LoopMove()
	{
		return stateMachine.TrySetState(loopState);
	}

	private bool EndMove()
	{
		return stateMachine.TrySetState(endState);
	}

	private bool Idle()
	{
		return stateMachine.TrySetState(idleState);
	}

	public void SetNavigationDestination(Vector3 worldPos, Vector3? tryFacingToDir = null, bool alignPosAndFacingByTarget = false, bool turnOffDestinationSetter = true)
	{
		moveEndTargetReferenceTrs = null;
		moveEndFacingDir = tryFacingToDir;
		moveEndTargetPos = (alignPosAndFacingByTarget ? new Vector3?(worldPos) : ((Vector3?)null));
		moveEndPosAlignToTarget = alignPosAndFacingByTarget;
		moveEndForwardAlignToTarget = alignPosAndFacingByTarget && tryFacingToDir.HasValue;
		if ((aIDestinationSetter != null) & turnOffDestinationSetter)
		{
			aIDestinationSetter.enabled = false;
		}
		if (ai != null)
		{
			ai.canSearch = true;
			ai.destination = worldPos;
			ai.SearchPath();
		}
	}

	public void SetNavigationDestination(Transform transform, bool alignPosAndFacingByTarget = false, bool turnOnDestinationSetter = true, bool immediate = true)
	{
		moveEndTargetReferenceTrs = (alignPosAndFacingByTarget ? transform : null);
		moveEndFacingDir = null;
		moveEndTargetPos = null;
		moveEndPosAlignToTarget = alignPosAndFacingByTarget;
		moveEndForwardAlignToTarget = alignPosAndFacingByTarget;
		if (aIDestinationSetter != null)
		{
			aIDestinationSetter.target = transform;
			if (turnOnDestinationSetter)
			{
				aIDestinationSetter.enabled = true;
			}
		}
		if (ai != null)
		{
			ai.canSearch = true;
			if (immediate)
			{
				ai.destination = transform.position;
				ai.SearchPath();
			}
		}
	}

	public void WalkByPath(Path path, Vector3? tryFacingToDir = null, bool alignPosAndFacingByTarget = false)
	{
		moveEndTargetReferenceTrs = null;
		moveEndFacingDir = tryFacingToDir;
		Vector3? vector;
		if (!alignPosAndFacingByTarget)
		{
			vector = null;
		}
		else
		{
			List<Vector3> vectorPath = path.vectorPath;
			vector = vectorPath[vectorPath.Count - 1];
		}
		moveEndTargetPos = vector;
		moveEndPosAlignToTarget = alignPosAndFacingByTarget;
		moveEndForwardAlignToTarget = alignPosAndFacingByTarget && tryFacingToDir.HasValue;
		if (ai != null)
		{
			ai.canSearch = false;
			ai.SetPath(path);
		}
	}

	public void JustAdjustFacingDir()
	{
		stateMachine.ForceSetState(endState);
	}

	public CriAtomExPlayback Play(string cueSheetName, string cueName, bool useStream)
	{
		if (AudioManager.mInstance == null || AudioManager.mInstance.mListener == null)
		{
			UnityEngine.Debug.LogError("set CriAtomListener before playing please!");
			return new CriAtomExPlayback(uint.MaxValue);
		}
		if (string.IsNullOrEmpty(cueSheetName) || string.IsNullOrEmpty(cueName))
		{
			return new CriAtomExPlayback(uint.MaxValue);
		}
		AudioManager.mInstance.AddCue("effect", cueSheetName, useStream);
		CriAtomSource criAtomSource = SfxSourcePlayer;
		if (criAtomSource == null)
		{
			return new CriAtomExPlayback(uint.MaxValue);
		}
		criAtomSource.cueSheet = cueSheetName;
		criAtomSource.cueName = cueName;
		return criAtomSource.Play();
	}

	public void OnAnimSoundFX(string sfxName)
	{
		if ((bool)AudioManager.mInstance)
		{
			Play("ui_scene_104402_footstep", sfxName, useStream: false);
		}
	}

	public void DestoryPlayer()
	{
		if ((bool)AudioManager.mInstance)
		{
			AudioManager.mInstance.RemoveUsedSheetList("effect");
		}
		if ((bool)sfxSourcePlayer)
		{
			sfxSourcePlayer.Stop();
			UnityEngine.Object.DestroyImmediate(sfxSourcePlayer.gameObject);
		}
	}

	private void OnDestroy()
	{
		DestoryPlayer();
	}

	[Conditional("UNITY_EDITOR")]
	private void OnDrawGizmos()
	{
		if (!(ai == null) && !(ai.transform == null))
		{
			_ = characterController == null;
		}
	}
}
