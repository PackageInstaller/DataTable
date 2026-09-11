using System;
using Sirenix.OdinInspector;
using UnityEngine.EventSystems;
using UnityEngine.Events;

namespace UnityEngine.Pipelines.SimPipeline.Character;

[ExecuteAlways]
[DefaultExecutionOrder(10)]
public class StockingController : SerializedMonoBehaviour, IBeginDragHandler, IEventSystemHandler, IDragHandler, IEndDragHandler, IInitializePotentialDragHandler
{
	private enum AnimState
	{
		Invalid,
		Idle,
		ToMin,
		ToMax
	}

	[Serializable]
	private struct DragStockingState
	{
		public AnimState state;

		public int? pointerID;

		public float currentScale;

		public float scaleAniCountdown;

		public float zAniCountdown;

		public Vector3 curPos;

		public Vector2 currentUV;

		public Vector2 velocityUV;

		public float velocityY;

		public Vector2 screenUpDir;

		public bool IsValid => state != AnimState.Invalid;
	}

	private const int SUPPORT_DRAGING_CNT = 1;

	[NonSerialized]
	private DragStockingState[] dragStockingStates;

	private float targetScale = 0.5f;

	private float xStartValue;

	private float yStartValue;

	private float zStartValue;

	private float uvxStartValue = -0.9f;

	private MaterialPropertyBlock _propertyBlock;

	private static int _Position = Shader.PropertyToID("_Position");

	private static int _UVXY = Shader.PropertyToID("_UVXY");

	private static int _Scale = Shader.PropertyToID("_Scale");

	private static int _OffsetY = Shader.PropertyToID("_OffsetY");

	public Renderer targetRenderer;

	[Header("UV Y方向范围控制")]
	public float uvYSensitivity = 0.001f;

	public float uvYMin = -0.01f;

	public float uvYMax = 0.45f;

	public float uvYOffset;

	[Header("UV X方向范围控制")]
	public float uvXSensitivity = 0.002f;

	public float uvXMin = -0.95f;

	public float uvXMax = -0.85f;

	[Header("X 控制")]
	public float xSensitivity = 0.002f;

	public float xMin = -0.1f;

	public float xMax = 0.1f;

	[Header("Y 控制")]
	public float ySensitivity = 0.0005f;

	public float ySmoothTime = 0.1f;

	public float yMin = -0.05f;

	public float yMax = 0.05f;

	[Header("Z 控制")]
	public float zMin;

	public float zMax = 1f;

	public float zToMaxTime = 0.5f;

	public float zToMinTime = 0.3f;

	[Header("Scale 控制")]
	public float scaleToMaxTime = 1f;

	public float scaleToMinTime = 0.5f;

	public float ScaleMin = 1f;

	public float ScaleMax = 20f;

	private bool firstInit = true;

	public AnimationCurve stockingVelocityCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	public bool keepDragStateOnDisable;

	private float maxDragSqrMagnitude;

	private bool isDraging;

	public float dragThreashold = 0.1f;

	public UnityEvent OnAnyDragStockingBegin;

	public UnityEvent OnAllDragStockingEnd;

	private bool AllStateIsReleasedFromDrag
	{
		get
		{
			if (dragStockingStates == null)
			{
				return false;
			}
			for (int i = 0; i < 1; i++)
			{
				ref DragStockingState reference = ref dragStockingStates[i];
				if (reference.state != AnimState.ToMin && reference.state != AnimState.Invalid)
				{
					return false;
				}
			}
			return true;
		}
	}

	private bool AnyStateIsClaimedByDrag
	{
		get
		{
			if (dragStockingStates == null)
			{
				return false;
			}
			for (int i = 0; i < 1; i++)
			{
				ref DragStockingState reference = ref dragStockingStates[i];
				if (reference.state == AnimState.ToMax || reference.state == AnimState.Idle)
				{
					return true;
				}
			}
			return false;
		}
	}

	private void HandleDragPos(PointerEventData eventData, int stateIdx)
	{
		ref DragStockingState reference = ref dragStockingStates[stateIdx];
		Vector2 delta = eventData.delta;
		ref Vector2 screenUpDir = ref reference.screenUpDir;
		Vector2 normalized = ((Vector2)Vector3.Cross(screenUpDir, Vector3.forward)).normalized;
		float y = Vector2.Dot(screenUpDir, delta);
		float x = Vector2.Dot(normalized, delta);
		delta = new Vector2(x, y);
		UpdateMove(ref reference, delta, Time.deltaTime);
	}

	private void UpdateMove(ref DragStockingState state, Vector2 mouseDelta, float dt)
	{
		ref float x = ref state.currentUV.x;
		ref float y = ref state.currentUV.y;
		ref float x2 = ref state.velocityUV.x;
		ref float y2 = ref state.velocityUV.y;
		x = Mathf.SmoothDamp(x, Mathf.Clamp(x - mouseDelta.x * uvXSensitivity, uvXMin, uvXMax), ref x2, ySmoothTime);
		y = Mathf.SmoothDamp(y, Mathf.Clamp(y - mouseDelta.y * uvYSensitivity, uvYMin, uvYMax), ref y2, ySmoothTime);
		maxDragSqrMagnitude = Mathf.Max(maxDragSqrMagnitude, state.velocityUV.sqrMagnitude);
		ref float x3 = ref state.curPos.x;
		x3 = Mathf.Clamp(x3 - mouseDelta.x * xSensitivity, xMin, xMax);
		ref float y3 = ref state.curPos.y;
		y3 = Mathf.SmoothDamp(y3, y3 + mouseDelta.y * ySensitivity, ref state.velocityY, ySmoothTime);
		y3 = Mathf.Clamp(y3, yMin, yMax);
		UpdateState(ref state, dt);
	}

	private void UpdateState(ref DragStockingState state, float dt)
	{
		if (state.scaleAniCountdown > 0f)
		{
			state.scaleAniCountdown -= dt;
		}
		if (state.zAniCountdown > 0f)
		{
			state.zAniCountdown -= dt;
		}
		ref AnimState state2 = ref state.state;
		if (state2 == AnimState.Invalid)
		{
			return;
		}
		if (state2 == AnimState.Idle)
		{
			if (!state.pointerID.HasValue)
			{
				state.state = AnimState.ToMin;
			}
			return;
		}
		ref float z = ref state.curPos.z;
		float b = ((state2 == AnimState.ToMin) ? zMin : zMax);
		float num = ((state2 == AnimState.ToMin) ? zToMinTime : zToMaxTime);
		float time = 1f - Mathf.Clamp01(state.zAniCountdown / num);
		z = Mathf.Lerp(t: stockingVelocityCurve.Evaluate(time), a: zStartValue, b: b);
		ref float currentScale = ref state.currentScale;
		float b2 = ((state2 == AnimState.ToMin) ? ScaleMin : ScaleMax);
		float num2 = ((state2 == AnimState.ToMin) ? scaleToMinTime : scaleToMaxTime);
		float time2 = 1f - Mathf.Clamp01(state.scaleAniCountdown / num2);
		currentScale = Mathf.Lerp(t: stockingVelocityCurve.Evaluate(time2), a: currentScale, b: b2);
		if (state.zAniCountdown <= 0f && state.scaleAniCountdown <= 0f)
		{
			if (state.state == AnimState.ToMin)
			{
				state.pointerID = null;
				state.state = AnimState.Invalid;
			}
			else
			{
				state.state = AnimState.Idle;
			}
		}
	}

	private void ForceAnimationReset()
	{
		if (_propertyBlock == null)
		{
			_propertyBlock = new MaterialPropertyBlock();
		}
		targetRenderer.GetPropertyBlock(_propertyBlock);
		_propertyBlock.SetFloat(_OffsetY, uvYOffset);
		_propertyBlock.SetVector(_Position, Vector4.zero);
		_propertyBlock.SetVector(_UVXY, new Vector4(0f, 0f, 0f, 0f));
		_propertyBlock.SetFloat(_Scale, ScaleMax);
		targetRenderer.SetPropertyBlock(_propertyBlock);
	}

	private void UpdateAnimations(ref DragStockingState state, int idx)
	{
		_propertyBlock.SetFloat(_OffsetY, uvYOffset);
		_propertyBlock.SetVector(_Position, state.curPos);
		_propertyBlock.SetVector(_UVXY, state.currentUV);
		_propertyBlock.SetFloat(_Scale, state.currentScale);
	}

	private void Start()
	{
		ForceAnimationReset();
	}

	private void OnEnable()
	{
		if (!keepDragStateOnDisable)
		{
			dragStockingStates = null;
			ForceAnimationReset();
			isDraging = false;
		}
		ResetAllDrag();
	}

	private void OnDisable()
	{
		if (!keepDragStateOnDisable)
		{
			ForceAnimationReset();
			DisposeAllDrag();
			_propertyBlock = null;
			isDraging = false;
			OnAllDragStockingEnd?.Invoke();
		}
	}

	private void ResetAllDrag()
	{
		if (dragStockingStates == null)
		{
			dragStockingStates = new DragStockingState[1];
		}
		for (int i = 0; i < 1; i++)
		{
			ResetToMin(i);
		}
	}

	private void DisposeAllDrag()
	{
		dragStockingStates = null;
	}

	private bool FindAvailableStateForDragEvent(PointerEventData eventData, out int idx)
	{
		int pointerId = eventData.pointerId;
		int? num = null;
		for (int i = 0; i < 1; i++)
		{
			ref DragStockingState reference = ref dragStockingStates[i];
			if (reference.pointerID == pointerId)
			{
				idx = i;
				return true;
			}
			if (!reference.IsValid && !num.HasValue)
			{
				num = i;
			}
		}
		idx = num.GetValueOrDefault();
		return num.HasValue;
	}

	private bool FindSpecificStateForDragEvent(PointerEventData eventData, out int idx)
	{
		for (int i = 0; i < 1; i++)
		{
			if (dragStockingStates[i].pointerID == eventData.pointerId)
			{
				idx = i;
				return true;
			}
		}
		idx = 0;
		return false;
	}

	private void Update()
	{
		float deltaTime = Time.deltaTime;
		for (int i = 0; i < 1; i++)
		{
			ref DragStockingState reference = ref dragStockingStates[i];
			if (reference.IsValid)
			{
				UpdateState(ref reference, deltaTime);
			}
		}
	}

	private void LateUpdate()
	{
		if (_propertyBlock == null)
		{
			_propertyBlock = new MaterialPropertyBlock();
		}
		if ((bool)targetRenderer && (!Application.isPlaying || dragStockingStates != null))
		{
			if (!Application.isPlaying || firstInit)
			{
				ForceAnimationReset();
				firstInit = false;
			}
			targetRenderer.GetPropertyBlock(_propertyBlock);
			for (int i = 0; i < 1; i++)
			{
				UpdateAnimations(ref dragStockingStates[i], i);
			}
			targetRenderer.SetPropertyBlock(_propertyBlock);
			bool flag = isDraging;
			isDraging = AnyStateIsClaimedByDrag && maxDragSqrMagnitude >= dragThreashold * dragThreashold;
			if (!flag && isDraging)
			{
				OnAnyDragStockingBegin?.Invoke();
			}
			else if (flag && !isDraging)
			{
				OnAllDragStockingEnd?.Invoke();
			}
			maxDragSqrMagnitude = 0f;
		}
	}

	private void StartToMin(int idx, bool invalidatePointer = false)
	{
		ref DragStockingState reference = ref dragStockingStates[idx];
		reference.state = AnimState.ToMin;
		reference.scaleAniCountdown = scaleToMinTime;
		reference.zAniCountdown = zToMinTime;
		if (invalidatePointer)
		{
			reference.pointerID = null;
		}
	}

	private void StartToMax(int idx, int pointerID)
	{
		ref DragStockingState reference = ref dragStockingStates[idx];
		reference.pointerID = pointerID;
		reference.state = AnimState.ToMax;
		reference.scaleAniCountdown = scaleToMaxTime;
		reference.zAniCountdown = zToMaxTime;
	}

	private void ResetToMin(int idx)
	{
		dragStockingStates[idx] = new DragStockingState
		{
			currentScale = 1f,
			screenUpDir = Vector2.up
		};
	}

	public void OnBeginDrag(PointerEventData eventData)
	{
		if (dragStockingStates != null && FindAvailableStateForDragEvent(eventData, out var idx))
		{
			StartToMax(idx, eventData.pointerId);
		}
	}

	public void OnDrag(PointerEventData eventData)
	{
		if (dragStockingStates != null && FindSpecificStateForDragEvent(eventData, out var idx))
		{
			HandleDragPos(eventData, idx);
		}
	}

	public void OnEndDrag(PointerEventData eventData)
	{
		if (dragStockingStates != null && FindSpecificStateForDragEvent(eventData, out var idx))
		{
			StartToMin(idx);
		}
	}

	public void OnInitializePotentialDrag(PointerEventData eventData)
	{
	}
}
