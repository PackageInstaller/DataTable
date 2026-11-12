using System;
using System.Collections;
using TMPro;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.InputSystem;
using UnityEngine.InputSystem.EnhancedTouch;
using UnityEngine.InputSystem.LowLevel;
using UnityEngine.InputSystem.Utilities;

public class MathParkourPlayerController : MonoBehaviour
{
	public MathParkourPlayerTrigger TriggerController;

	[Header("赛道")]
	[SerializeField]
	[Min(0f)]
	private float maxMoveSpeed = 20f;

	[SerializeField]
	[Min(0f)]
	private float returnToLaneCenterSpeed = 12f;

	[SerializeField]
	[Range(0f, 1f)]
	private float gamepadDeadZone = 0.2f;

	[Header("墙体阻挡")]
	[SerializeField]
	private BoxCollider movementProbe;

	[SerializeField]
	private LayerMask wallLayerMask;

	[SerializeField]
	[Min(0f)]
	private float wallCastPadding = 0.02f;

	private float maxHorizontalMoveStep = 0.5f;

	private int maxHorizontalMoveStepsPerFrame = 4;

	private MathParkourLevelController levelController;

	private long entityId = 1L;

	[SerializeField]
	private Canvas worldSpaceCanvas;

	[SerializeField]
	private TextMeshProUGUI hpText;

	[SerializeField]
	private Animator scoreAnimator;

	[Header("特效节点")]
	[SerializeField]
	private GameObject drillFxPrefab;

	[SerializeField]
	private GameObject sawFxPrefab;

	[SerializeField]
	private GameObject shieldFxPrefab;

	[SerializeField]
	private Animator hpDecreaseAnimator;

	[SerializeField]
	private Animator hpIncreaseAnimator;

	[SerializeField]
	private Animator playerAnimator;

	private Coroutine animationCoroutine;

	private int laneCount;

	private int centerLaneIndex;

	private float laneWidth;

	private float dragWorldDistancePerPixel;

	private bool bBlockInput;

	private bool isMovementTemporarilyLocked;

	private bool isDragging;

	private bool isMovingToCenterLane;

	private bool shouldAlignBossPosition;

	private bool isGameplayPaused;

	private bool isBlockedByFrontWall;

	private float gamepadHorizontalInput;

	private Vector2 dragStartScreenPosition;

	private Vector2 dragCurrentScreenPosition;

	private float dragStartLocalX;

	private float targetBossWorldZ;

	private float hpDecreaseRemainder;

	public int Hp { get; private set; }

	public long EntityId => entityId;

	public int CurrentLaneIndex { get; private set; }

	public void Init(int laneCount, float laneWidth, float dragWorldDistancePerPixel)
	{
		if (laneCount < 1 || laneWidth <= 0f || dragWorldDistancePerPixel < 0f)
		{
			Debug.LogError($"[MathParkour] 角色赛道参数非法：laneCount={laneCount}, laneWidth={laneWidth}, dragScale={dragWorldDistancePerPixel}。", this);
			return;
		}
		this.laneCount = laneCount;
		centerLaneIndex = (laneCount - 1) / 2;
		this.laneWidth = laneWidth;
		this.dragWorldDistancePerPixel = dragWorldDistancePerPixel;
		CurrentLaneIndex = GetNearestLaneIndex(transform.localPosition.x);
		BindHudCamera();
		ResetData();
		hpDecreaseAnimator.gameObject.SetActive(value: true);
		hpIncreaseAnimator.gameObject.SetActive(value: true);
		hpText.gameObject.SetActive(value: false);
	}

	public void PlayInAnimator()
	{
		StartCoroutine(WaitForOneFrame());
		PlayAnimatorAnim("in", () =>
		{
			hpText.gameObject.SetActive(value: true);
		});
	}

	public void SetPlayerScaleZero()
	{
		playerAnimator.transform.localScale = Vector3.zero;
	}

	private void ResetData()
	{
		bBlockInput = true;
		isMovementTemporarilyLocked = false;
		isDragging = false;
		isMovingToCenterLane = false;
		shouldAlignBossPosition = false;
		isGameplayPaused = false;
		isBlockedByFrontWall = false;
		gamepadHorizontalInput = 0f;
		dragStartScreenPosition = Vector2.zero;
		dragCurrentScreenPosition = Vector2.zero;
		dragStartLocalX = 0f;
		hpDecreaseRemainder = 0f;
	}

	public void InitHp(int initialHp)
	{
		if (initialHp <= 0)
		{
			Debug.LogError($"[MathParkour] 角色初始生命值必须大于 0，当前值：{initialHp}。", this);
			Hp = 0;
		}
		else
		{
			Hp = initialHp;
			hpDecreaseRemainder = 0f;
			UpdateHud();
		}
	}

	public int GetHp()
	{
		return Hp;
	}

	public void SetHp(int hp)
	{
		if (hp < Hp)
		{
			PlayHpChangeAnimation(hpDecreaseAnimator);
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_down");
		}
		else if (hp > Hp)
		{
			PlayHpChangeAnimation(hpIncreaseAnimator);
			PlayAnimatorAnim("sprint");
			MonoSingleton<WwiseAudioManager>.Instance.PostEvent("Mode_400018_up");
		}
		Hp = hp;
		UpdateHud();
		scoreAnimator.Play("MathParkourPlayerHP_in");
	}

	private void PlayHpChangeAnimation(Animator animator)
	{
		if (animator != null)
		{
			animator.Play("in", 0, 0f);
		}
	}

	public void PlayAnimatorAnim(string name, Action finishCallback = null, bool skipIfAlreadyPlaying = false)
	{
		if (playerAnimator == null)
		{
			finishCallback?.Invoke();
			return;
		}
		if (string.IsNullOrEmpty(name))
		{
			Debug.LogWarning("[MathParkour] Animator 状态名为空。", this);
			finishCallback?.Invoke();
			return;
		}
		int num = Animator.StringToHash(name);
		if (skipIfAlreadyPlaying)
		{
			AnimatorStateInfo currentAnimatorStateInfo = playerAnimator.GetCurrentAnimatorStateInfo(0);
			if (currentAnimatorStateInfo.shortNameHash == num && currentAnimatorStateInfo.normalizedTime < 1f)
			{
				return;
			}
		}
		if (animationCoroutine != null)
		{
			StopCoroutine(animationCoroutine);
			animationCoroutine = null;
		}
		playerAnimator.Play(num, 0, 0f);
		if (finishCallback != null)
		{
			animationCoroutine = StartCoroutine(WaitForAnimatorAnimationComplete(num, finishCallback));
		}
	}

	private IEnumerator WaitForAnimatorAnimationComplete(int stateHash, Action finishCallback)
	{
		yield return null;
		while (playerAnimator != null)
		{
			AnimatorStateInfo currentAnimatorStateInfo = playerAnimator.GetCurrentAnimatorStateInfo(0);
			if (currentAnimatorStateInfo.shortNameHash != stateHash || currentAnimatorStateInfo.normalizedTime >= 1f)
			{
				break;
			}
			yield return null;
		}
		animationCoroutine = null;
		finishCallback();
	}

	private IEnumerator WaitForOneFrame()
	{
		playerAnimator.transform.localScale = Vector3.zero;
		yield return null;
		playerAnimator.transform.localScale = new Vector3(1.1f, 1.1f, 1.1f);
	}

	public void SetLevelController(MathParkourLevelController levelController)
	{
		this.levelController = levelController;
		TriggerController.SetLevelController(levelController);
	}

	public void SetGameplayPaused(bool paused)
	{
		isGameplayPaused = paused;
		if (paused)
		{
			isDragging = false;
		}
		SetBlockInput(paused);
	}

	public void SetBlockInput(bool block)
	{
		bBlockInput = block;
	}

	public void SetMovementTemporarilyLocked(bool locked)
	{
		isMovementTemporarilyLocked = locked;
		if (locked)
		{
			isDragging = false;
		}
	}

	public void SetToInitialPosition(Transform initialPosition)
	{
		if (IsInitialized())
		{
			isDragging = false;
			isMovingToCenterLane = false;
			shouldAlignBossPosition = false;
			if (initialPosition != null)
			{
				transform.position = initialPosition.position;
				CurrentLaneIndex = GetNearestLaneIndex(transform.localPosition.x);
			}
			else
			{
				SetToCenterLaneImmediately();
			}
		}
	}

	private void SetToCenterLaneImmediately()
	{
		Vector3 localPosition = transform.localPosition;
		localPosition.x = GetLaneCenterX(centerLaneIndex);
		transform.localPosition = localPosition;
		CurrentLaneIndex = centerLaneIndex;
	}

	public void MoveToBossPositionAndCancelDrag(Transform bossPosition)
	{
		if (IsInitialized())
		{
			isDragging = false;
			bBlockInput = true;
			isMovingToCenterLane = true;
			CurrentLaneIndex = centerLaneIndex;
			if (bossPosition != null)
			{
				targetBossWorldZ = bossPosition.position.z;
				shouldAlignBossPosition = true;
			}
			else
			{
				Debug.LogWarning("[MathParkour] 未配置 Boss Position，跳过 Boss 位置对齐。", this);
				shouldAlignBossPosition = false;
			}
		}
	}

	private void OnDisable()
	{
		isDragging = false;
		isMovingToCenterLane = false;
		shouldAlignBossPosition = false;
	}

	public void ReduceHp(float amount)
	{
		if (!(amount <= 0f) && Hp > 0)
		{
			hpDecreaseRemainder += amount;
			int num = Mathf.FloorToInt(hpDecreaseRemainder);
			if (num > 0)
			{
				hpDecreaseRemainder -= num;
				Hp = Mathf.Max(0, Hp - num);
				UpdateHud();
				scoreAnimator.Play("MathParkourPlayerHP_in");
				PlayAnimatorAnim("attack", () =>
				{
				}, skipIfAlreadyPlaying: true);
			}
		}
	}

	public void ResetHpDecreaseRemainder()
	{
		hpDecreaseRemainder = 0f;
	}

	private void Update()
	{
		if (isGameplayPaused || !IsInitialized())
		{
			return;
		}
		CacheMovementInput();
		UpdateFrontWallBlockState();
		if (isMovingToCenterLane)
		{
			MoveToCenterLane();
		}
		else if (!bBlockInput && !isMovementTemporarilyLocked)
		{
			if (!MoveByCachedInput())
			{
				ReturnToCurrentLaneCenter();
			}
			UpdateFrontWallBlockState();
		}
	}

	private void CacheMovementInput()
	{
		if (Application.isMobilePlatform)
		{
			CacheTouchDragInput();
		}
		else
		{
			CacheMouseDragInput();
		}
		CacheHorizontalInput();
	}

	private bool MoveByCachedInput()
	{
		if (isDragging)
		{
			MoveByScreenPosition(dragCurrentScreenPosition);
			return true;
		}
		if (Mathf.Abs(gamepadHorizontalInput) < gamepadDeadZone)
		{
			return false;
		}
		TryMoveHorizontal(gamepadHorizontalInput * maxMoveSpeed * Time.deltaTime);
		return true;
	}

	private void CacheHorizontalInput()
	{
		gamepadHorizontalInput = ((MonoSingleton<InputManager>.Instance != null) ? MonoSingleton<InputManager>.Instance.GetAxis("Horizontal") : 0f);
	}

	private void CacheMouseDragInput()
	{
		InputManager instance = MonoSingleton<InputManager>.Instance;
		if (instance == null)
		{
			return;
		}
		if (instance.GetMouseButtonDown(MouseButton.Left))
		{
			if (IsPointerOverUi())
			{
				return;
			}
			BeginDrag(instance.GetMousePosition());
		}
		if (isDragging)
		{
			if (instance.GetMouseButton(MouseButton.Left))
			{
				dragCurrentScreenPosition = instance.GetMousePosition();
			}
			else
			{
				EndDrag();
			}
		}
	}

	private void CacheTouchDragInput()
	{
		InputManager instance = MonoSingleton<InputManager>.Instance;
		if (instance == null)
		{
			return;
		}
		ReadOnlyArray<UnityEngine.InputSystem.EnhancedTouch.Touch> activeTouches = instance.GetActiveTouches();
		if (activeTouches.Count == 0)
		{
			if (isDragging)
			{
				EndDrag();
			}
			return;
		}
		UnityEngine.InputSystem.EnhancedTouch.Touch touch = activeTouches.get_Item(0);
		if (touch.phase == UnityEngine.InputSystem.TouchPhase.Began)
		{
			if (IsPointerOverUi(touch.touchId))
			{
				return;
			}
			BeginDrag(touch.screenPosition);
		}
		if (!isDragging)
		{
			return;
		}
		UnityEngine.InputSystem.TouchPhase phase = touch.phase;
		if (phase == UnityEngine.InputSystem.TouchPhase.Moved || phase == UnityEngine.InputSystem.TouchPhase.Stationary)
		{
			dragCurrentScreenPosition = touch.screenPosition;
			return;
		}
		phase = touch.phase;
		if (phase == UnityEngine.InputSystem.TouchPhase.Ended || phase == UnityEngine.InputSystem.TouchPhase.Canceled)
		{
			EndDrag();
		}
	}

	private void BeginDrag(Vector2 screenPosition)
	{
		isDragging = true;
		dragStartScreenPosition = screenPosition;
		dragCurrentScreenPosition = screenPosition;
		dragStartLocalX = transform.localPosition.x;
	}

	private void MoveByScreenPosition(Vector2 screenPosition)
	{
		float num = dragStartLocalX + (screenPosition.x - dragStartScreenPosition.x) * dragWorldDistancePerPixel;
		if (!TryMoveHorizontal(num - transform.localPosition.x))
		{
			dragStartScreenPosition = screenPosition;
			dragStartLocalX = transform.localPosition.x;
		}
	}

	private void EndDrag()
	{
		isDragging = false;
		CurrentLaneIndex = GetNearestLaneIndex(transform.localPosition.x);
	}

	private static bool IsPointerOverUi(int pointerId = -1)
	{
		if (EventSystem.current != null)
		{
			return EventSystem.current.IsPointerOverGameObject(pointerId);
		}
		return false;
	}

	private bool TryMoveHorizontal(float desiredMoveDistance)
	{
		if (Mathf.Approximately(desiredMoveDistance, 0f))
		{
			return false;
		}
		Vector3 localPosition = transform.localPosition;
		float num = Mathf.Clamp(localPosition.x + desiredMoveDistance, GetLaneCenterX(0), GetLaneCenterX(laneCount - 1)) - localPosition.x;
		if (Mathf.Approximately(num, 0f))
		{
			return false;
		}
		bool result = false;
		float b = GetMaxHorizontalMoveStep();
		int num2 = 0;
		while (!Mathf.Approximately(num, 0f) && num2 < maxHorizontalMoveStepsPerFrame)
		{
			num2++;
			float moveDistance = Mathf.Sign(num) * Mathf.Min(Mathf.Abs(num), b);
			if (IsCombatEntityBlocking(moveDistance))
			{
				break;
			}
			moveDistance = GetSafeWallMoveDistance(moveDistance);
			if (Mathf.Approximately(moveDistance, 0f))
			{
				break;
			}
			localPosition.x += moveDistance;
			transform.localPosition = localPosition;
			Physics.SyncTransforms();
			CurrentLaneIndex = GetNearestLaneIndex(localPosition.x);
			result = true;
			num -= moveDistance;
			if (levelController.TryStartCollisionCombatAtMovementProbe(movementProbe))
			{
				break;
			}
		}
		if (!Mathf.Approximately(num, 0f))
		{
			dragStartScreenPosition = dragCurrentScreenPosition;
			dragStartLocalX = transform.localPosition.x;
		}
		return result;
	}

	private float GetMaxHorizontalMoveStep()
	{
		if (movementProbe == null)
		{
			return maxHorizontalMoveStep;
		}
		return Mathf.Min(maxHorizontalMoveStep, Mathf.Max(0.01f, movementProbe.bounds.extents.x));
	}

	public void UpdateFrontWallBlockState()
	{
		if (!(levelController == null) && !(movementProbe == null))
		{
			bool flag = levelController.IsGeneratedFrontWallOverlapping(movementProbe, wallLayerMask, wallCastPadding);
			if (isBlockedByFrontWall != flag)
			{
				isBlockedByFrontWall = flag;
				levelController.SetPlayerBlockedByFrontWall(flag);
			}
		}
	}

	private float GetSafeWallMoveDistance(float moveDistance)
	{
		if (levelController == null)
		{
			Debug.LogError("[MathParkour] 未绑定 MathParkourLevelController，无法检测活动 Chunk 的墙体。", this);
			return 0f;
		}
		Vector3 direction = transform.right * Mathf.Sign(moveDistance);
		float generatedWallSafeMoveDistance = levelController.GetGeneratedWallSafeMoveDistance(movementProbe, direction, Mathf.Abs(moveDistance), wallLayerMask, wallCastPadding, isBlockedByFrontWall);
		return Mathf.Sign(moveDistance) * generatedWallSafeMoveDistance;
	}

	private bool IsCombatEntityBlocking(float moveDistance)
	{
		if (levelController == null)
		{
			return false;
		}
		Vector3 direction = transform.right * Mathf.Sign(moveDistance);
		return levelController.IsGeneratedCombatEntityBlocking(movementProbe, direction, Mathf.Abs(moveDistance), wallCastPadding);
	}

	private void ReturnToCurrentLaneCenter()
	{
		Vector3 localPosition = transform.localPosition;
		float laneCenterX = GetLaneCenterX(CurrentLaneIndex);
		float desiredMoveDistance = Mathf.MoveTowards(localPosition.x, laneCenterX, returnToLaneCenterSpeed * Time.deltaTime) - localPosition.x;
		TryMoveHorizontal(desiredMoveDistance);
	}

	private void MoveToCenterLane()
	{
		Vector3 localPosition = transform.localPosition;
		float laneCenterX = GetLaneCenterX(centerLaneIndex);
		localPosition.x = Mathf.MoveTowards(localPosition.x, laneCenterX, returnToLaneCenterSpeed * Time.deltaTime);
		transform.localPosition = localPosition;
		Physics.SyncTransforms();
		if (shouldAlignBossPosition)
		{
			Vector3 position = transform.position;
			position.z = Mathf.MoveTowards(position.z, targetBossWorldZ, returnToLaneCenterSpeed * Time.deltaTime);
			transform.position = position;
			Physics.SyncTransforms();
		}
		if (Mathf.Approximately(transform.localPosition.x, laneCenterX) && (!shouldAlignBossPosition || Mathf.Approximately(transform.position.z, targetBossWorldZ)))
		{
			CurrentLaneIndex = centerLaneIndex;
			isMovingToCenterLane = false;
			shouldAlignBossPosition = false;
		}
	}

	private float GetLaneCenterX(int laneIndex)
	{
		return (float)(laneIndex - centerLaneIndex) * laneWidth;
	}

	private int GetNearestLaneIndex(float localX)
	{
		return Mathf.Clamp(Mathf.RoundToInt(localX / laneWidth) + centerLaneIndex, 0, laneCount - 1);
	}

	private bool IsInitialized()
	{
		if (laneCount > 0)
		{
			return laneWidth > 0f;
		}
		return false;
	}

	private void BindHudCamera()
	{
		if ((object)worldSpaceCanvas == null)
		{
			worldSpaceCanvas = GetComponentInChildren<Canvas>(includeInactive: true);
		}
		if (!(worldSpaceCanvas == null))
		{
			if (worldSpaceCanvas.renderMode != RenderMode.WorldSpace)
			{
				Debug.LogError("[MathParkour] 角色的 HUD Canvas 必须使用 World Space 模式。", worldSpaceCanvas);
			}
			else
			{
				worldSpaceCanvas.worldCamera = ModuleController<MathParkourModuleController>.Instance?.hudCamera;
			}
		}
	}

	private void UpdateHud()
	{
		if (!(hpText == null))
		{
			if (Hp <= 0)
			{
				hpText.gameObject.SetActive(value: false);
			}
			hpText.SetText("{0}", Hp);
		}
	}

	public void PlayDrillFx()
	{
		if (drillFxPrefab != null)
		{
			drillFxPrefab.gameObject.SetActive(value: true);
		}
	}

	public void StopDrillFx()
	{
		if (drillFxPrefab != null)
		{
			drillFxPrefab.gameObject.SetActive(value: false);
		}
	}

	public void PlaySawFx()
	{
		if (sawFxPrefab != null)
		{
			sawFxPrefab.gameObject.SetActive(value: true);
		}
	}

	public void StopSawFx()
	{
		if (sawFxPrefab != null)
		{
			sawFxPrefab.gameObject.SetActive(value: false);
		}
	}

	public void PlayShieldFx()
	{
		if (shieldFxPrefab != null)
		{
			shieldFxPrefab.gameObject.SetActive(value: true);
		}
	}

	public void StopShieldFx()
	{
		if (shieldFxPrefab != null)
		{
			shieldFxPrefab.gameObject.SetActive(value: false);
		}
	}
}
