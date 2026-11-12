#define LOG_WARNING
#define LOG_ERROR
using System;
using System.Collections;
using Drawing;
using Nova.Hotfix;
using Pathfinding;
using Pathfinding.RVO;
using TrueSync;
using UnityEngine;

public class DormActor : DormEntity
{
	public enum DormActoBehaviour
	{
		Idle,
		Move,
		EnterFsm
	}

	public enum DormActorState
	{
		None,
		Control,
		Rome,
		Noticed,
		Hover,
		Interactive,
		Hide
	}

	public enum ActorBehaviourMode
	{
		Default,
		BeControlled
	}

	public enum DormMode
	{
		Default,
		View,
		Edit,
		Visitor,
		SwitchActor
	}

	private bool _spawnBehaviourPending;

	private int _logicStopRC;

	private static readonly int RunSpdAnimParameterHash = Animator.StringToHash("RunSpd");

	private string _interruptWwiseEventName;

	private static readonly Collider[] s_playAnimSpaceOverlapBuffer = new Collider[32];

	private static readonly int kPlayAnimSpaceCheckMask = (1 << DormConstValue.LAYER_ACTOR) | (1 << DormConstValue.LAYER_FURNITURE) | (1 << DormConstValue.LAYER_ROOM_BOUND);

	private const float PLAY_ANIM_SPACE_GIZMO_DURATION = 2f;

	private Coroutine _playFacialExpCoroutine;

	private Coroutine _randomBlinkCoroutine;

	protected ActorBehaviourMode _behaviourMode;

	private AdventureFXPlayer curBubbleEmoji;

	private AdventureFXPlayer curEmojiFX;

	private float _furnitureInteractCooldownUntil;

	private DormFurObj _reservedInteractFur;

	private DormFurObjInteractivePoint _reservedInteractPoint;

	protected Coroutine corWaitForNextBehaviour;

	protected Coroutine corInteractiveBehaviour;

	protected Coroutine corInteractiveWait;

	private bool _roamArrived;

	private bool _roamRepick;

	private Action _onInteractiveComplete;

	private Vector3 _curInteractFurniturePos;

	private bool _hasCurInteractFurniturePos;

	private bool _leaveFurniturePending;

	private Vector3 _leaveFurnitureFromPos;

	private DormActorMoveAgent moveAgent;

	private bool blockMoveBehaviour;

	private Seeker seeker;

	private bool _heldByInteractIcon;

	private bool _pendingReleaseAfterInteraction;

	private bool _noticeFaceCamera;

	protected DormMode dormMode;

	protected DormActorStateMgr stateMgr;

	public DormRole RoleData { get; private set; }

	public DormRoleSkin SkinData { get; private set; }

	public int RoleId { get; private set; }

	public int SkinId { get; private set; }

	public bool IsLogicStopped => _logicStopRC > 0;

	public CapsuleCollider collider { get; protected set; }

	public DormCommonInteractionAnimationLibrary animLibrary { get; private set; }

	public bool isPlayingFacialExpression => _playFacialExpCoroutine != null;

	public bool isRandomBlinkEnabled => _randomBlinkCoroutine != null;

	public bool IsFurnitureInteractOnCooldown => Time.time < _furnitureInteractCooldownUntil;

	protected virtual float walkSpeed => 1.2f;

	protected virtual float runSpeed => 3.41f;

	protected virtual bool blockOtherActorsHard => false;

	protected virtual float rvoPriority => 0.2f;

	public bool IsMoving
	{
		get
		{
			if (moveAgent != null)
			{
				return moveAgent.dormActorState == DormActoBehaviour.Move;
			}
			return false;
		}
	}

	private DormActorFSM_Noticed NoticedFSM => stateMgr?.GetFSM(DormActorState.Noticed) as DormActorFSM_Noticed;

	public bool IsNoticeFaceCamera => _noticeFaceCamera;

	public bool IsHeldByInteractIcon => _heldByInteractIcon;

	public bool IsHoldingInPlace
	{
		get
		{
			if (!_heldByInteractIcon)
			{
				return _pendingReleaseAfterInteraction;
			}
			return true;
		}
	}

	public bool ShouldReleaseHoldNow
	{
		get
		{
			if (_pendingReleaseAfterInteraction)
			{
				return !isPlayingFacialExpression;
			}
			return false;
		}
	}

	public bool CanBeNoticedByPlayer
	{
		get
		{
			if (!(this is DormPlayer) && FSMState != DormActorState.Noticed)
			{
				return FSMState != DormActorState.Interactive;
			}
			return false;
		}
	}

	public bool IsNoticedByPlayerBusy
	{
		get
		{
			DormActorFSM_Noticed noticedFSM = NoticedFSM;
			if (FSMState == DormActorState.Noticed && noticedFSM != null)
			{
				return noticedFSM.IsBusy;
			}
			return false;
		}
	}

	public DormActorState FSMState => stateMgr.State;

	public bool IsInteractionUninterruptible
	{
		get
		{
			if (FSMState == DormActorState.Interactive && stateMgr?.GetFSM(DormActorState.Interactive) is DormActorFSM_Interactive dormActorFSM_Interactive)
			{
				return dormActorFSM_Interactive.IsElevatorFlow;
			}
			return false;
		}
	}

	protected override void Awake()
	{
		base.Awake();
		entityType = DormConstValue.LAYER_ACTOR;
	}

	protected override void OnEnable()
	{
		base.OnEnable();
	}

	protected override void OnDisable()
	{
		SwitchState(DormActorState.None);
		base.OnDisable();
	}

	public void LoadData(DormRole roleData, DormRoleSkin skinData)
	{
		RoleData = roleData;
		SkinData = skinData;
		RoleId = roleData?.Id ?? 0;
		SkinId = skinData?.Id ?? 0;
	}

	public void Spawn()
	{
		_spawnBehaviourPending = true;
	}

	public bool ConsumeSpawnBehaviourPending()
	{
		if (!_spawnBehaviourPending)
		{
			return false;
		}
		_spawnBehaviourPending = false;
		return true;
	}

	protected virtual void Update()
	{
		stateMgr?.Update();
	}

	protected virtual void LateUpdate()
	{
		stateMgr?.LateUpdate();
	}

	public void OnStartDrag()
	{
		SwitchState(DormActorState.Hover);
	}

	public void OnDrag(TSVector2 position, FP positionY)
	{
		SyncMovementLocation(position, positionY);
	}

	public void OnStopDrag()
	{
		SwitchState(DormActorState.Rome);
	}

	public void StopLogic()
	{
		_logicStopRC++;
		if (_logicStopRC == 1)
		{
			seeker.enabled = false;
			moveAgent.enabled = false;
		}
	}

	public void ResumeLogic()
	{
		_logicStopRC--;
		if (_logicStopRC <= 0 && _logicStopRC < 0)
		{
			_logicStopRC = 0;
			NovaLogger.Warning("StopLogic与ResumeLogic使用不匹配，请成对使用");
		}
	}

	public void ResetLogicStopped()
	{
		if (_logicStopRC > 0)
		{
			_logicStopRC = 0;
			seeker.enabled = true;
			moveAgent.enabled = true;
		}
	}

	public void RestoreVisibleAndLogic()
	{
		bool flag = false;
		if (IsLogicStopped)
		{
			ResetLogicStopped();
			flag = true;
		}
		if (isHide)
		{
			ResetVisible();
			flag = true;
		}
		if (flag)
		{
			RelocateOntoNavmesh();
		}
	}

	protected override void InitializeComponents()
	{
		collider = gameObject.GetComponent<CapsuleCollider>();
		if (collider == null)
		{
			collider = gameObject.AddComponent<CapsuleCollider>();
			collider.center = DormConfigs.dormActorCapsuleColliderCenter;
			collider.radius = 0.4f;
			collider.height = 1.6f;
			collider.direction = 1;
		}
		base.InitializeComponents();
		InitializeMoveAgent();
		seeker = gameObject.GetComponent<Seeker>();
		stateMgr = new DormActorStateMgr(this);
		RegisterFSM();
	}

	protected override void ReleaseComponents()
	{
		base.ReleaseComponents();
		ReleaseMoveAgent();
	}

	protected override void InitializeVisual()
	{
		base.InitializeVisual();
		InitializeVisualComponents(collider.radius, collider.height, isOccludee: true);
		SetRenderingLayerMask(16u);
	}

	public void StopAction()
	{
		if (corInteractiveWait != null)
		{
			StopCoroutine(corInteractiveWait);
			corInteractiveWait = null;
		}
		if (corWaitForNextBehaviour != null)
		{
			StopCoroutine(corWaitForNextBehaviour);
			corWaitForNextBehaviour = null;
		}
		if (corInteractiveBehaviour != null)
		{
			StopCoroutine(corInteractiveBehaviour);
			corInteractiveBehaviour = null;
		}
		StopMove();
	}

	public void ResumeAction()
	{
		SelectBehaviour();
	}

	protected override void InitializeAnimation()
	{
		base.InitializeAnimation();
		if (animLibrary == null)
		{
			animLibrary = GetComponent<DormCommonInteractionAnimationLibrary>();
		}
	}

	protected override void ReleaseAnimation()
	{
		StopRandomBlink();
		base.ReleaseAnimation();
	}

	public void PlayIdle()
	{
		if (animator != null)
		{
			animator.SetFloat(RunSpdAnimParameterHash, 0f);
		}
	}

	public void PlayWalk()
	{
		if (animator != null)
		{
			animator.SetFloat(RunSpdAnimParameterHash, 0.5f);
		}
	}

	public void PlayRun()
	{
		if (animator != null)
		{
			animator.SetFloat(RunSpdAnimParameterHash, 1f);
		}
	}

	public void PlayIdleShowAnim(Action onComplete = null)
	{
		if (animLibrary == null)
		{
			onComplete?.Invoke();
		}
		else if (animLibrary.idleShowTimelinePrefab != null)
		{
			if (CheckPlayAnimSpaceEnough(animLibrary.idleShowTimelinePrefab))
			{
				PlayTimelineAnimation(animLibrary.idleShowTimelinePrefab, 1, onComplete);
			}
			else
			{
				onComplete?.Invoke();
			}
		}
		else
		{
			onComplete?.Invoke();
		}
	}

	public void StopIdleShowAnim()
	{
		StopTimelineAnimation();
	}

	public void PlayCatchAnim(Action onComplete = null)
	{
		if (animLibrary == null)
		{
			onComplete?.Invoke();
		}
		else if (animLibrary.catchTimelinePrefab != null)
		{
			PlayTimelineAnimation(animLibrary.catchTimelinePrefab, 1, onComplete);
		}
		else
		{
			onComplete?.Invoke();
		}
	}

	public void StopCatchAnim()
	{
		StopTimelineAnimation();
	}

	public void PlayAnimByName(string aniName, float crossFadeTime = 0f)
	{
		if (animator != null && animator.runtimeAnimatorController != null)
		{
			if (crossFadeTime > 0f)
			{
				animator.CrossFade(aniName, crossFadeTime);
			}
			else
			{
				animator.Play(aniName);
			}
		}
	}

	protected override void OnInterruptTimelineAnimation()
	{
		if (_interruptWwiseEventName == null && SkinData != null)
		{
			_interruptWwiseEventName = $"Home_{SkinData.Id}_stop";
		}
		if (_interruptWwiseEventName != null)
		{
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent(_interruptWwiseEventName, gameObject);
		}
	}

	private bool CheckPlayAnimSpaceEnough(GameObject timelinePrefab)
	{
		Transform transform = ((animator != null) ? animator.transform : base.transform);
		int hitCount = 0;
		Collider component = timelinePrefab.GetComponent<Collider>();
		if (component == null || !component.enabled)
		{
			return true;
		}
		bool isCapsule = false;
		Vector3 p = default;
		Vector3 p2 = default;
		Vector3 boxCenter = default;
		Vector3 boxHalfExtents = default;
		float radius = 0f;
		if (component is CapsuleCollider { center: var center, radius: var radius2 } capsuleCollider)
		{
			Vector3 vector;
			if (capsuleCollider.direction != 0)
			{
				vector = ((capsuleCollider.direction == 2) ? Vector3.forward : Vector3.up);
			}
			else
			{
				vector = Vector3.right;
			}
			float num = Mathf.Max(0f, capsuleCollider.height * 0.5f - radius2);
			Vector3 vector2 = transform.position + transform.rotation * center;
			Vector3 vector3 = transform.rotation * vector;
			Vector3 vector4 = vector2 - vector3 * num;
			Vector3 vector5 = vector2 + vector3 * num;
			p = vector4;
			p2 = vector5;
			radius = radius2;
			isCapsule = true;
			hitCount = Physics.OverlapCapsuleNonAlloc(vector4, vector5, radius2, s_playAnimSpaceOverlapBuffer, kPlayAnimSpaceCheckMask, QueryTriggerInteraction.Ignore);
		}
		else if (component is BoxCollider { center: var center2 } boxCollider)
		{
			Vector3 vector6 = boxCollider.size * 0.5f;
			Vector3 center3 = (boxCenter = transform.position + transform.rotation * center2);
			boxHalfExtents = vector6;
			hitCount = Physics.OverlapBoxNonAlloc(center3, vector6, s_playAnimSpaceOverlapBuffer, transform.rotation, kPlayAnimSpaceCheckMask, QueryTriggerInteraction.Ignore);
		}
		bool flag = FilterSpaceCheckHits(hitCount);
		DrawPlayAnimSpaceCheckGizmo(transform, isCapsule, p, p2, radius, boxCenter, boxHalfExtents, flag);
		return flag;
	}

	private bool FilterSpaceCheckHits(int hitCount)
	{
		for (int i = 0; i < hitCount; i++)
		{
			Collider collider = s_playAnimSpaceOverlapBuffer[i];
			if (collider == null || collider.transform.IsChildOf(transform))
			{
				continue;
			}
			int layer = collider.gameObject.layer;
			if (layer == DormConstValue.LAYER_ACTOR)
			{
				DormActor componentInParent = collider.GetComponentInParent<DormActor>();
				if (!(componentInParent != null) || !componentInParent.isHide)
				{
					return false;
				}
			}
			else if (layer == DormConstValue.LAYER_FURNITURE)
			{
				DormFurObj componentInParent2 = collider.GetComponentInParent<DormFurObj>();
				if (!(componentInParent2 != null) || !componentInParent2.IsFlatDecor)
				{
					return false;
				}
			}
			else if (layer == DormConstValue.LAYER_ROOM_BOUND)
			{
				return false;
			}
		}
		return true;
	}

	private void DrawPlayAnimSpaceCheckGizmo(Transform anchor, bool isCapsule, Vector3 p0, Vector3 p1, float radius, Vector3 boxCenter, Vector3 boxHalfExtents, bool spaceEnough)
	{
		if (!DormConfigs.playAnimSpaceCheckDebugDraw)
		{
			return;
		}
		CommandBuilder ingame = Draw.ingame;
		using (ingame.WithDuration(2f))
		{
			using (ingame.WithColor(spaceEnough ? Color.green : Color.red))
			{
				if (isCapsule)
				{
					ingame.WireCapsule(p0, p1, radius);
				}
				else
				{
					ingame.WireBox(boxCenter, anchor.rotation, boxHalfExtents * 2f);
				}
			}
		}
	}

	public void PlayFacialExpression(SDFacialExpression id, float duration, float delay = 0f, Action onComplete = null)
	{
		if (facialAnimator == null)
		{
			NovaLogger.Error(gameObject.name + " 播放表情动画但缺少表情控制器组件!");
			return;
		}
		if (_playFacialExpCoroutine != null)
		{
			StopCoroutine(_playFacialExpCoroutine);
			_playFacialExpCoroutine = null;
		}
		_playFacialExpCoroutine = StartCoroutine(PlayFacialExpressionCoroutine(id, duration, delay, onComplete));
	}

	private IEnumerator PlayFacialExpressionCoroutine(SDFacialExpression id, float duration, float delay, Action onComplete)
	{
		if (delay > 0f)
		{
			yield return new WaitForSeconds(delay);
		}
		facialAnimator.SetExpression(id);
		yield return new WaitForSeconds(duration);
		facialAnimator.SetExpression(SDFacialExpression.Normal);
		_playFacialExpCoroutine = null;
		onComplete?.Invoke();
	}

	public void StartRandomBlink()
	{
		if (!(facialAnimator == null) && _randomBlinkCoroutine == null)
		{
			_randomBlinkCoroutine = StartCoroutine(RandomBlinkCoroutine());
		}
	}

	public void StopRandomBlink()
	{
		if (_randomBlinkCoroutine != null)
		{
			StopCoroutine(_randomBlinkCoroutine);
			_randomBlinkCoroutine = null;
		}
		facialAnimator?.SetBlink(0f);
	}

	private IEnumerator RandomBlinkCoroutine()
	{
		while (true)
		{
			float seconds = UnityEngine.Random.Range(DormConfigs.actorBlinkIntervalRange.x, DormConfigs.actorBlinkIntervalRange.y);
			yield return new WaitForSeconds(seconds);
			if (!isPlayingTimelineAnimation)
			{
				float num = UnityEngine.Random.Range(DormConfigs.actorBlinkDurationRange.x, DormConfigs.actorBlinkDurationRange.y);
				float halfBlinkDuration = num * 0.5f;
				float t = 0f;
				while (t < halfBlinkDuration)
				{
					t += Time.deltaTime;
					facialAnimator.SetBlink(Mathf.Lerp(0f, 1f, t / halfBlinkDuration));
					yield return null;
				}
				facialAnimator.SetBlink(1f);
				t = 0f;
				while (t < halfBlinkDuration)
				{
					t += Time.deltaTime;
					facialAnimator.SetBlink(Mathf.Lerp(1f, 0f, t / halfBlinkDuration));
					yield return null;
				}
				facialAnimator.SetBlink(0f);
			}
		}
	}

	public AdventureFXPlayer PlayBubbleEmoji(string path)
	{
		return PlayFX(path);
	}

	public AdventureFXPlayer PlayEmojiFX(string path)
	{
		return PlayFX(path);
	}

	internal AdventureFXPlayer PlayFX(string path)
	{
		GameObject prefab = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, path, typeof(GameObject)) as GameObject;
		return PlayFX(prefab);
	}

	internal AdventureFXPlayer PlayFX(GameObject prefab)
	{
		if (prefab == null)
		{
			return null;
		}
		AdventureFXPlayer adventureFXPlayer = AdventureFXPlayer.PlayFX(prefab, 1f, transform.position, transform.rotation);
		adventureFXPlayer.Bind(gameObject);
		return adventureFXPlayer;
	}

	public void BeginFurnitureInteractCooldown()
	{
		_furnitureInteractCooldownUntil = Time.time + 10f;
	}

	public void ReserveFurnitureInteractPoint(DormFurObj fur, DormFurObjInteractivePoint point)
	{
		if (!(null == fur) && point != null)
		{
			ReleaseFurnitureInteractReservation();
			_reservedInteractFur = fur;
			_reservedInteractPoint = point;
			fur.ReserveInteractivePoint(point, id);
		}
	}

	public bool TryConsumeFurnitureInteractReservation(DormFurObj fur, out DormFurObjInteractivePoint point)
	{
		point = null;
		if (null == fur || _reservedInteractFur != fur || _reservedInteractPoint == null)
		{
			ReleaseFurnitureInteractReservation();
			return false;
		}
		bool flag = _reservedInteractPoint.reserveEntityID == id;
		if (flag)
		{
			point = _reservedInteractPoint;
		}
		ReleaseFurnitureInteractReservation();
		return flag;
	}

	public void ReleaseFurnitureInteractReservation()
	{
		if (null != _reservedInteractFur)
		{
			_reservedInteractFur.ReleasePointReservation(_reservedInteractPoint, id);
		}
		_reservedInteractFur = null;
		_reservedInteractPoint = null;
	}

	public void SelectBehaviour()
	{
		SwitchState(DormActorState.Rome);
	}

	public void StopInteractiveWithObject()
	{
		SwitchState(DormActorState.Rome);
	}

	public virtual void InterWithObjeComplete()
	{
		MarkLeaveFurniturePending();
		InvokeInteractiveCompleteCallback();
		SwitchState(DormActorState.Rome);
	}

	protected void MarkLeaveFurniturePending()
	{
		if (_hasCurInteractFurniturePos)
		{
			_leaveFurniturePending = true;
			_leaveFurnitureFromPos = _curInteractFurniturePos;
			_hasCurInteractFurniturePos = false;
		}
	}

	public bool ConsumeLeaveFurniturePending(out Vector3 furniturePos)
	{
		furniturePos = _leaveFurnitureFromPos;
		if (!_leaveFurniturePending)
		{
			return false;
		}
		_leaveFurniturePending = false;
		return true;
	}

	public void DiscardLeaveFurniturePending()
	{
		_leaveFurniturePending = false;
	}

	protected void InvokeInteractiveCompleteCallback()
	{
		Action onInteractiveComplete = _onInteractiveComplete;
		_onInteractiveComplete = null;
		onInteractiveComplete?.Invoke();
	}

	public void DiscardInteractiveCompleteCallback()
	{
		_onInteractiveComplete = null;
		_hasCurInteractFurniturePos = false;
	}

	public void DoInteractiveWithObject(DormInteractiveContext ctx, Action callback = null)
	{
		_onInteractiveComplete = callback;
		_hasCurInteractFurniturePos = ctx != null && null != ctx.furObj;
		if (_hasCurInteractFurniturePos)
		{
			_curInteractFurniturePos = ctx.furObj.transform.position;
		}
		SwitchState(DormActorState.Interactive, ctx);
	}

	public void PlayInteractiveBehaviour(Action callback = null)
	{
		SwitchState(DormActorState.Interactive);
	}

	public void StopInteractiveBehaviour()
	{
		if (corInteractiveWait != null)
		{
			StopCoroutine(corInteractiveWait);
			corInteractiveWait = null;
		}
		if (corInteractiveBehaviour != null)
		{
			StopCoroutine(corInteractiveBehaviour);
			corInteractiveBehaviour = null;
		}
	}

	protected virtual void InitializeMoveAgent()
	{
		moveAgent = gameObject.AddOrGetComponent<DormActorMoveAgent>();
		moveAgent.Init();
		moveAgent.canBlock = blockOtherActorsHard;
		InitializeRVOController();
	}

	private void InitializeRVOController()
	{
		(ModuleController<DormModuleController>.Instance.levelInstance as DormLevelController)?.EnsureRVOSimulator();
		gameObject.AddOrGetComponent<RVOController>().priority = rvoPriority;
		if (moveAgent.cachedRVOController != null && moveAgent.cachedRVOController.rvoAgent != null)
		{
			moveAgent.cachedRVOController.rvoAgent.PreCalculationCallback = moveAgent.UpdateRVOAgentProperties;
		}
	}

	protected virtual void ReleaseMoveAgent()
	{
		RVOController component = gameObject.GetComponent<RVOController>();
		if (component != null)
		{
			UnityEngine.Object.Destroy(component);
		}
		UnityEngine.Object.Destroy(moveAgent);
		moveAgent = null;
	}

	public bool CheckPositionWalkable(Vector3 position)
	{
		return moveAgent.CheckPositionWalkable(position);
	}

	public void SetAvoidanceSimulationEnabled(bool enable)
	{
		if (!enable || !(RVOSimulator.active == null))
		{
			RVOController rVOController = moveAgent?.cachedRVOController;
			if (null != rVOController)
			{
				rVOController.enabled = enable;
			}
		}
	}

	public void DisableMovment()
	{
		seeker.enabled = false;
		moveAgent.enabled = false;
	}

	public void EnableMovment()
	{
		seeker.enabled = true;
		moveAgent.enabled = true;
	}

	public void MoveTo(Vector3 pos, Action callback = null, Action onStuck = null)
	{
		if (!blockMoveBehaviour)
		{
			moveAgent.maxSpeed = walkSpeed;
			PlayWalk();
			moveAgent.onStuck = onStuck;
			moveAgent?.MoveToPos(pos, () =>
			{
				PlayIdle();
				callback?.Invoke();
			});
		}
	}

	public void ForwardMove(Vector2 moveDirection, bool bWalk = false)
	{
		if (!blockMoveBehaviour)
		{
			if (bWalk)
			{
				moveAgent.maxSpeed = walkSpeed;
				PlayWalk();
			}
			else
			{
				moveAgent.maxSpeed = runSpeed;
				PlayRun();
			}
			moveAgent?.ForwardMove(moveDirection.ToTSVector2());
		}
	}

	public bool TryGetRandomWalkablePointInScene(out Vector3 result, float minDistanceFromSelf = 0f, int maxAttempts = 16)
	{
		result = default;
		return moveAgent.TryGetRandomWalkablePointInScene(out result, minDistanceFromSelf, maxAttempts);
	}

	public bool TryGetNearestWalkablePoint(Vector3 position, out Vector3 result)
	{
		result = position;
		if (moveAgent != null)
		{
			return moveAgent.TryGetNearestWalkablePoint(position, out result);
		}
		return false;
	}

	public float GetFacingYaw()
	{
		return (transform.eulerAngles.y % 360f + 360f) % 360f;
	}

	public void SyncRotation(float yawDegrees)
	{
		Quaternion rotation = Quaternion.Euler(0f, yawDegrees, 0f);
		moveAgent?.SyncRotation(rotation);
	}

	public void SyncMovementLocation(TSVector2 position, FP positionY)
	{
		transform.position = new Vector3((float)position.x, (float)positionY, (float)position.y);
		moveAgent?.Teleport(new TSVector(position.x, positionY, position.y));
	}

	public void RelocateOntoNavmesh()
	{
		if (!(moveAgent == null) && (moveAgent.TryGetNearestWalkablePoint(transform.position, out var result) || TryGetRandomWalkablePointInScene(out result)))
		{
			SyncMovementLocation(new TSVector2(result.x, result.z), result.y);
		}
	}

	public void StopMove()
	{
		moveAgent?.StopMove();
		PlayIdle();
	}

	private void BlockMoveBehaviour()
	{
		blockMoveBehaviour = true;
		moveAgent?.BlockMoveBehaviour();
	}

	public void ResumeMoveBehaviour()
	{
		blockMoveBehaviour = false;
		moveAgent?.ResumeMoveBehaviour();
	}

	public void HoldByInteractIcon()
	{
		_heldByInteractIcon = true;
		_pendingReleaseAfterInteraction = false;
		_noticeFaceCamera = false;
		if (FSMState == DormActorState.Noticed)
		{
			NoticedFSM?.RestartToStopped();
		}
		else
		{
			NoticeByPlayer();
		}
	}

	public void HoldByInteractIconFaceCamera()
	{
		_heldByInteractIcon = true;
		_pendingReleaseAfterInteraction = false;
		_noticeFaceCamera = true;
		if (FSMState == DormActorState.Noticed)
		{
			NoticedFSM?.RestartToStopped();
		}
		else
		{
			EnterNoticedForViewSelect();
		}
	}

	private void EnterNoticedForViewSelect()
	{
		if (!IsLogicStopped && FSMState != DormActorState.Noticed && FSMState != DormActorState.Interactive)
		{
			SwitchState(DormActorState.Noticed);
		}
	}

	public void ReleaseInteractIconHold()
	{
		if (_heldByInteractIcon)
		{
			_heldByInteractIcon = false;
			if (isPlayingFacialExpression)
			{
				_pendingReleaseAfterInteraction = true;
			}
			else
			{
				ReleaseToRome();
			}
		}
	}

	public void ReleaseToRome()
	{
		_pendingReleaseAfterInteraction = false;
		if (FSMState == DormActorState.Noticed)
		{
			SelectBehaviour();
		}
	}

	public void ClearInteractIconHoldState()
	{
		_heldByInteractIcon = false;
		_pendingReleaseAfterInteraction = false;
		_noticeFaceCamera = false;
	}

	public void NoticeByPlayer()
	{
		if (!(this is DormPlayer) && !IsLogicStopped && CanBeNoticedByPlayer)
		{
			SwitchState(DormActorState.Noticed);
		}
	}

	public void CancelNoticeByPlayer()
	{
		if (!_heldByInteractIcon && IsNoticedByPlayerBusy)
		{
			SwitchState(DormActorState.Rome);
		}
	}

	protected virtual void RegisterFSM()
	{
		RegisterFSM(DormActorState.None);
		RegisterFSM(DormActorState.Rome);
		RegisterFSM(DormActorState.Noticed);
		RegisterFSM(DormActorState.Hover);
		RegisterFSM(DormActorState.Interactive);
		RegisterFSM(DormActorState.Hide);
	}

	protected void RegisterFSM(DormActorState state)
	{
		stateMgr.Register(state);
	}

	protected void SwitchState(DormActorState state, object data = null)
	{
		stateMgr.Switch(state, data);
	}

	public void ResetStateForElevatorReentry()
	{
		if (FSMState == DormActorState.Interactive)
		{
			SwitchState(DormActorState.Rome);
		}
	}

	public void LeaveInteractiveToNone()
	{
		if (FSMState == DormActorState.Interactive)
		{
			SwitchState(DormActorState.None);
		}
	}

	public virtual void ResetToSpawnState()
	{
		StopAction();
		DiscardLeaveFurniturePending();
		ReleaseFurnitureInteractReservation();
		SwitchState(DormActorState.None);
		SwitchState(DormActorState.Rome);
	}

	public void SuspendForPerform()
	{
		StopAction();
		SwitchState(DormActorState.None);
	}

	public void RequestMoveAwayFrom(Vector3 avoidFromPos)
	{
		if (!IsHeldByInteractIcon)
		{
			if (FSMState == DormActorState.Noticed)
			{
				SwitchState(DormActorState.Rome);
			}
			if (FSMState == DormActorState.Rome && stateMgr.GetFSM(DormActorState.Rome) is DormActorFSM_Rome dormActorFSM_Rome)
			{
				dormActorFSM_Rome.RequestMoveAway(avoidFromPos);
			}
		}
	}

	public void SwitchDormMode(DormMode dormMode)
	{
		switch (dormMode)
		{
		case DormMode.Default:
			EnterModeDefault();
			break;
		case DormMode.View:
			EnterModeView();
			break;
		case DormMode.Visitor:
			EnterModeVisitor();
			break;
		case DormMode.Edit:
			EnterModeEdit();
			break;
		case DormMode.SwitchActor:
			EnterModeSwitchActor();
			break;
		default:
			_logger.LogError("后宅模式错误!");
			break;
		}
		this.dormMode = dormMode;
	}

	protected virtual void EnterModeDefault()
	{
		DormActorState fSMState = FSMState;
		if (fSMState == DormActorState.Hide || fSMState == DormActorState.None)
		{
			SwitchState(DormActorState.Rome);
		}
	}

	protected virtual void EnterModeView()
	{
		DormActorState fSMState = FSMState;
		if (fSMState == DormActorState.Hide || fSMState == DormActorState.None || fSMState == DormActorState.Control)
		{
			SwitchState(DormActorState.Rome);
		}
	}

	protected virtual void EnterModeVisitor()
	{
		DormActorState fSMState = FSMState;
		if (fSMState == DormActorState.Hide || fSMState == DormActorState.None || fSMState == DormActorState.Control)
		{
			SwitchState(DormActorState.Rome);
		}
	}

	protected virtual void EnterModeEdit()
	{
		SwitchState(DormActorState.Hide);
	}

	protected virtual void EnterModeSwitchActor()
	{
		SwitchState(DormActorState.Hide);
	}
}
