#define LOG_WARNING
using System;
using System.Collections.Generic;
using Cinemachine;
using Game.Graphics.HighlightOutliner;
using Game.Graphics.Overdrawer;
using TrueSync;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using XLua;

public class DormCameraController : SceneSingleton<DormCameraController>
{
	public CinemachineVirtualCamera dormMainVCam;

	public Transform cameraBeacon;

	public Camera closeupCamera;

	public Camera hudCamera;

	[Range(0.001f, 0.1f)]
	public float dragSensitivity = 0.01f;

	[Range(0.1f, 5f)]
	public float pinchZoomSpeed = 1f;

	[Range(0.01f, 1f)]
	public float dragRotateSensitivity = 0.2f;

	private DormCameraConfigureData activedCameraConfigData;

	private static readonly AnimationCurve _fallbackFOVCurve = AnimationCurve.Linear(7f, 30f, 12f, 30f);

	private static readonly AnimationCurve _fallbackHeightCurve = AnimationCurve.Linear(7f, 8f, 12f, 13f);

	private static readonly AnimationCurve _fallbackFocusEaseCurve = AnimationCurve.EaseInOut(0f, 0f, 1f, 1f);

	protected int _cameraControlEnableRC;

	private bool needCameraMove;

	private FP _fixedDuration;

	private Vector3 _cameraFollowTargetPosition = Vector3.zero;

	private Vector3 _cameraDampPosition = Vector3.zero;

	private Vector3 _cameraDampVelocity = Vector3.zero;

	private float _cameraDampAngle;

	private float _cameraDampAngleVelocity;

	private float _cameraRotationDampAngle;

	private float _cameraRotationDampAngleVelocity;

	private float _cameraRotationDragOffset;

	private float _cameraDepth;

	private float _cameraDampDepth;

	private float _cameraDampDepthVelocity;

	private float _cameraFOVDamp;

	private float _cameraFOVDampVelocity;

	protected float _cameraFollowSmoothTime;

	private CinemachineTransposer _cameraTransposer;

	private CinemachineComposer _cameraComposer;

	private float updateCameraDepthValue = 1f;

	private GameObject bindFocusObj;

	private float _beaconBaseY;

	private bool _bindFocusObjGroundBased = true;

	private GameObject _focusAnchor;

	private GameObject _savedFocusObj;

	private bool _savedFocusObjGroundBased = true;

	private float _savedDepthValue;

	private Vector3 _savedBeaconPosition;

	private bool _isFocusing;

	private bool _cameraInputLocked;

	private float _focusTransitionDuration = -1f;

	private float _focusSettleEpsilon = 0.01f;

	private bool _focusTransitionActive;

	private float _focusElapsed;

	private float _focusMoveDuration;

	private bool _focusMovingStage;

	private float _focusStageHoldDepth;

	private const float FOCUS_MOVE_MAX_DURATION = 3f;

	private float _focusBlendDuration = -1f;

	private bool _focusKeepPointOnExit;

	private bool _focusSmoothEase;

	private float _focusFrameT = 1f;

	private float _focusEasedPrev;

	private bool _focusIgnoreFollowDeadzone;

	private const float FOCUS_MIN_DEPTH = 2f;

	private float _focusMinDepth = 2f;

	private float _focusPitchDegrees = -1f;

	private float _focusWeight;

	private float _focusWeightVelocity;

	private bool _focusSideViewActive;

	private float _focusSideYawOffset;

	private float _focusSideYaw;

	private bool _focusSideLocked;

	private float _focusSideSign = 1f;

	private float _focusAimHeightOffset;

	private float _focusAimHeight;

	private float _focusAimHeightVelocity;

	private bool _focusFOVLocked;

	private float _focusLockedFOV;

	private bool _focusPoseLockedFromEntry;

	private bool mouseScrollWheelDirection;

	private Vector3 cameraShiftValue = Vector3.zero;

	private Vector3 _dragRngCenter = Vector3.zero;

	private bool _hasViewCameraSnapshot;

	private Vector3 _viewSnapBeaconPos;

	private float _viewSnapRotationDragOffset;

	private float _viewSnapDepthValue;

	private UniversalAdditionalCameraData _closeupCameraAdditionalCameraData;

	private int _closeupCameraEnabledRC;

	public RenderingMode outlinerRenderingMode = RenderingMode.HDR;

	[Range(0.15f, 1f)]
	public float outlinerPrimaryRendererScale = 0.75f;

	[Range(0f, 2f)]
	public float outlinerBlurShift = 1f;

	[Range(0f, 2f)]
	public float outlinerDilateShift = 1f;

	public int outlinerDilateIterations = 1;

	public DilateQuality outlinerDilateQuality;

	public int outlinerBlurIterations = 1;

	public BlurType outlinerBlurType = BlurType.Box;

	public Color outlineHighlightColor;

	[BlackList]
	public float cameraFollowDampTime => activedCameraConfigData.cameraFollowDampTime;

	[BlackList]
	public float cameraFollowRngRadius => activedCameraConfigData.cameraFollowRngRadius;

	[BlackList]
	public float cameraOffsetRngRadius => activedCameraConfigData.cameraOffsetRngRadius;

	[BlackList]
	public float cameraViewRngRadius => activedCameraConfigData.cameraViewRngRadius;

	[BlackList]
	public float cameraAngle => activedCameraConfigData.cameraAngle;

	[BlackList]
	public float cameraRotationAngle => activedCameraConfigData.cameraRotationAngle * (float)reversalCameraRotationAngle;

	[BlackList]
	public int reversalCameraRotationAngle { get; set; } = 1;

	[BlackList]
	public AnimationCurve cameraFOVCurve
	{
		get
		{
			AnimationCurve animationCurve = activedCameraConfigData.cameraFOVCurve;
			if (animationCurve == null || animationCurve.length < 2)
			{
				return _fallbackFOVCurve;
			}
			return animationCurve;
		}
	}

	[BlackList]
	public float CurrentFOV => _cameraFOVDamp;

	[BlackList]
	public float CurrentZoomNormalized
	{
		get
		{
			if (null == activedCameraConfigData)
			{
				return 0f;
			}
			Vector2 vector = cameraScaleRng;
			float num = vector.y - vector.x;
			if (!(num <= 1E-05f))
			{
				return Mathf.Clamp01((_cameraDampDepth - vector.x) / num);
			}
			return 0f;
		}
	}

	[BlackList]
	public AnimationCurve cameraHeightCurve
	{
		get
		{
			AnimationCurve animationCurve = activedCameraConfigData.cameraHeightCurve;
			if (animationCurve == null || animationCurve.length < 2)
			{
				return _fallbackHeightCurve;
			}
			return animationCurve;
		}
	}

	[BlackList]
	public Vector2 cameraScaleRng
	{
		get
		{
			AnimationCurve animationCurve = cameraHeightCurve;
			float time = animationCurve.get_Item(0).time;
			float time2 = animationCurve.get_Item(animationCurve.length - 1).time;
			return new Vector2(Mathf.Min(time, time2), Mathf.Max(time, time2));
		}
	}

	[BlackList]
	public float cameraHeightOffset => activedCameraConfigData.cameraHeightOffset;

	[BlackList]
	public float cameraHorizontalOffset => activedCameraConfigData.cameraHorizontalOffset;

	public bool enableCameraDragRng => activedCameraConfigData.enableCameraDragRngSettings;

	[BlackList]
	public float2 cameraDragRngHorizontal => activedCameraConfigData.cameraDragRngHorizontal;

	[BlackList]
	public float2 cameraDragRngVertical => activedCameraConfigData.cameraDragRngVertical;

	[BlackList]
	public AnimationCurve focusMoveEaseCurve
	{
		get
		{
			AnimationCurve animationCurve = activedCameraConfigData.focusMoveEaseCurve;
			if (animationCurve == null || animationCurve.length < 2)
			{
				return _fallbackFocusEaseCurve;
			}
			return animationCurve;
		}
	}

	[BlackList]
	public AnimationCurve focusZoomEaseCurve
	{
		get
		{
			AnimationCurve animationCurve = activedCameraConfigData.focusZoomEaseCurve;
			if (animationCurve == null || animationCurve.length < 2)
			{
				return _fallbackFocusEaseCurve;
			}
			return animationCurve;
		}
	}

	[BlackList]
	public AnimationCurve focusMoveDurationCurve
	{
		get
		{
			AnimationCurve animationCurve = activedCameraConfigData.focusMoveDurationCurve;
			if (animationCurve == null || animationCurve.length < 2)
			{
				return null;
			}
			return animationCurve;
		}
	}

	[BlackList]
	public bool cameraControlEnabled => _cameraControlEnableRC > 0;

	public Transform focusTarget
	{
		get
		{
			if (null != bindFocusObj)
			{
				return bindFocusObj.transform;
			}
			if (null != cameraBeacon)
			{
				return cameraBeacon.transform;
			}
			return null;
		}
	}

	private float FocusPhaseDuration
	{
		get
		{
			if (!_focusMovingStage)
			{
				if (!_isFocusing || !(_focusBlendDuration > 0f))
				{
					return _focusTransitionDuration;
				}
				return _focusBlendDuration;
			}
			return _focusMoveDuration;
		}
	}

	private bool FocusLinearActive
	{
		get
		{
			if (_focusTransitionActive)
			{
				return FocusPhaseDuration >= 0f;
			}
			return false;
		}
	}

	public bool IsFocusing => _isFocusing;

	public bool hasViewCameraSnapshot => _hasViewCameraSnapshot;

	public HashSet<Outlinable> activedHighlightOutlines { get; private set; } = new HashSet<Outlinable>();

	public void InitCameraController()
	{
		GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
		Camera mainCamera = instance.mainCamera;
		UniversalAdditionalCameraData mainCameraAdditionalCameraData = instance.mainCameraAdditionalCameraData;
		Camera uiCamera = instance.uiCamera;
		uiCamera.GetUniversalAdditionalCameraData();
		_closeupCameraAdditionalCameraData = closeupCamera.GetUniversalAdditionalCameraData();
		hudCamera.GetUniversalAdditionalCameraData();
		instance.SetupMainCameraRender();
		instance.SetCameraMode(mainCamera, GameCameraStackManager.CameraMode.MainMaster);
		instance.InsertCameraToCameraStack(closeupCamera, 0, GameCameraStackManager.CameraMode.MainSlave);
		instance.InsertCameraToCameraStack(hudCamera, 1, GameCameraStackManager.CameraMode.UIMaster);
		instance.SetCameraMode(uiCamera, GameCameraStackManager.CameraMode.UISlave);
		mainCameraAdditionalCameraData.volumeTrigger = mainCamera.transform;
		_closeupCameraAdditionalCameraData.volumeTrigger = mainCamera.transform;
		closeupCamera.enabled = false;
		dormMainVCam.Follow = cameraBeacon;
		dormMainVCam.LookAt = cameraBeacon;
		_cameraComposer = dormMainVCam.GetCinemachineComponent<CinemachineComposer>();
		_cameraTransposer = dormMainVCam.GetCinemachineComponent<CinemachineTransposer>();
		InitCameraRendering();
	}

	public void ReleaseCameraController()
	{
		GameCameraStackManager instance = MonoSingleton<GameCameraStackManager>.Instance;
		if (!(instance == null))
		{
			_closeupCameraAdditionalCameraData.volumeTrigger = null;
			instance.RemoveCameraFromCameraStack(closeupCamera);
			instance.RemoveCameraFromCameraStack(hudCamera);
			instance.DisableMainCameraBrainDefaultBlendSetting();
			ReleaseCameraRendering();
		}
	}

	private void LateUpdate()
	{
		if (!(null == activedCameraConfigData))
		{
			UpdateCameraValue(Time.deltaTime);
			UpdateCamera();
			TickFocusTransitionSettle();
			if (closeupCamera.enabled)
			{
				Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
				closeupCamera.transform.SetPositionAndRotation(mainCamera.transform.position, mainCamera.transform.rotation);
				closeupCamera.SyncWith(mainCamera);
			}
		}
	}

	protected override void OnDestroy()
	{
		CrossPlatformInputManager.UnRegisterVirtualJoystick("Horizontal", "Vertical");
		base.OnDestroy();
	}

	[BlackList]
	public float GetRotateDurationTime()
	{
		if (_focusTransitionActive && _focusTransitionDuration >= 0f)
		{
			return _focusTransitionDuration;
		}
		return activedCameraConfigData.cameraRotationDuration;
	}

	public void OverrideCameraConfig(DormCameraConfigureData configureData)
	{
		if (null == configureData)
		{
			Debug.LogError("要加载的相机配置为空！");
			return;
		}
		activedCameraConfigData = configureData;
		_cameraRotationDragOffset = 0f;
		InitCameraValue();
	}

	public void CameraControlEnable()
	{
		_cameraControlEnableRC++;
		if (_cameraControlEnableRC == 1)
		{
			InitCameraValue();
		}
	}

	public void CameraControlDisable()
	{
		_cameraControlEnableRC--;
		_ = _cameraControlEnableRC;
		if (_cameraControlEnableRC < 0)
		{
			Debug.LogWarning("CameraControlEnable与CameraControlDisable使用不匹配，请成对使用");
		}
	}

	private void InitCameraValue()
	{
		if (!(null == activedCameraConfigData))
		{
			UpdateCameraFollowTargetPosition(initialize: true, 0f);
			_cameraDampPosition = _cameraFollowTargetPosition;
			Vector2 vector = cameraScaleRng;
			_cameraDepth = Mathf.Lerp(vector.x, vector.y, 0.5f) * updateCameraDepthValue;
			_cameraDepth = Math.Clamp(_cameraDepth, vector.x, vector.y);
			_cameraDampAngle = cameraAngle;
			_cameraRotationDampAngle = cameraRotationAngle - 180f + _cameraRotationDragOffset;
			_cameraDampDepth = _cameraDepth;
			_cameraFOVDamp = cameraFOVCurve.Evaluate(_cameraDepth);
			_cameraTransposer.m_FollowOffset = ComputeFollowOffset(_cameraRotationDampAngle, _cameraDampDepth);
			Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
			Vector3 position = cameraBeacon.transform.position;
			mainCamera.transform.position = position + _cameraTransposer.m_FollowOffset;
			dormMainVCam.transform.position = position + _cameraTransposer.m_FollowOffset;
			dormMainVCam.m_Lens.FieldOfView = _cameraFOVDamp;
			ResetCameraDampVelocities();
			_cameraFollowSmoothTime = 0f;
			dormMainVCam.enabled = true;
			UpdateCameraValue(Time.deltaTime);
			UpdateCamera();
		}
	}

	protected void UpdateCameraFollowTargetPosition(bool initialize, float dt)
	{
		if (null == bindFocusObj)
		{
			return;
		}
		Vector3 position = bindFocusObj.transform.position;
		float num = ((bindFocusObj == cameraBeacon.gameObject) ? _beaconBaseY : position.y);
		_fixedDuration -= (FP)dt;
		_focusAimHeight = DampOrLinear(target: _isFocusing ? _focusAimHeightOffset : 0f, current: _focusAimHeight, velocity: ref _focusAimHeightVelocity, dt: dt);
		float y = num + cameraHeightOffset + _focusAimHeight;
		_cameraFollowTargetPosition = new Vector3(position.x + cameraHorizontalOffset, y, position.z) + cameraShiftValue;
		if (initialize)
		{
			needCameraMove = false;
			_cameraDampPosition = _cameraFollowTargetPosition;
		}
		else
		{
			Vector3 position2 = cameraBeacon.transform.position;
			float num2 = position2.x - position.x;
			float num3 = position2.z - position.z;
			needCameraMove = num2 * num2 + num3 * num3 >= cameraFollowRngRadius * cameraFollowRngRadius;
			if (_focusIgnoreFollowDeadzone && (_isFocusing || _focusTransitionActive))
			{
				needCameraMove = true;
			}
		}
		_cameraFollowSmoothTime = ((_focusTransitionActive && FocusPhaseDuration >= 0f) ? FocusPhaseDuration : cameraFollowDampTime);
		if (needCameraMove)
		{
			_cameraDampPosition = (FocusLinearActive ? Vector3.Lerp(cameraBeacon.position, _cameraFollowTargetPosition, FocusLinearT(dt)) : Vector3.SmoothDamp(cameraBeacon.position, _cameraFollowTargetPosition, ref _cameraDampVelocity, _cameraFollowSmoothTime));
			if (_fixedDuration < 0 && !_isFocusing && !_focusTransitionActive)
			{
				Vector2 vector = new Vector2(position.x, position.z);
				Vector2 vector2 = new Vector2(_cameraDampPosition.x, _cameraDampPosition.z);
				Vector2 vector3 = vector2 - vector;
				if (vector3.magnitude > cameraOffsetRngRadius)
				{
					Vector2 normalized = vector3.normalized;
					vector2 = vector + normalized * cameraOffsetRngRadius;
					_cameraDampPosition = new Vector3(vector2.x, _cameraDampPosition.y, vector2.y);
				}
			}
		}
		_cameraDampPosition.y = y;
		_cameraDampPosition += cameraShiftValue;
		if (enableCameraDragRng && !_isFocusing && !_focusTransitionActive)
		{
			_cameraDampPosition = ClampToDragRng(_cameraDampPosition);
		}
	}

	private Vector3 ClampToDragRng(Vector3 pos)
	{
		if (!enableCameraDragRng)
		{
			return pos;
		}
		pos.x = _dragRngCenter.x + Mathf.Clamp(pos.x - _dragRngCenter.x, cameraDragRngHorizontal.x, cameraDragRngHorizontal.y);
		pos.z = _dragRngCenter.z + Mathf.Clamp(pos.z - _dragRngCenter.z, cameraDragRngVertical.x, cameraDragRngVertical.y);
		return pos;
	}

	private void UpdateCameraValue(float dt)
	{
		if (_focusTransitionActive && dt > float.Epsilon)
		{
			_focusElapsed += dt;
		}
		TickFocusStage();
		if (FocusLinearActive && dt > float.Epsilon)
		{
			TickFocusTransitionT(dt);
		}
		UpdateCameraFollowTargetPosition(initialize: false, dt);
		Vector2 vector = cameraScaleRng;
		if (_focusMovingStage)
		{
			_cameraDepth = _focusStageHoldDepth;
		}
		else if (_isFocusing)
		{
			_cameraDepth = vector.x * updateCameraDepthValue;
			float min = Mathf.Min(Mathf.Max(_focusMinDepth, 0f), vector.x);
			_cameraDepth = Math.Clamp(_cameraDepth, min, vector.x);
		}
		else
		{
			_cameraDepth = Mathf.Lerp(vector.x, vector.y, 0.5f) * updateCameraDepthValue;
			_cameraDepth = Math.Clamp(_cameraDepth, vector.x, vector.y);
		}
		cameraBeacon.position = _cameraDampPosition;
		if (dt > float.Epsilon)
		{
			_cameraDampAngle = DampOrLinear(_cameraDampAngle, cameraAngle, ref _cameraDampAngleVelocity, dt);
			float target = (_focusSideViewActive ? (_cameraRotationDampAngle + Mathf.DeltaAngle(_cameraRotationDampAngle, _focusSideYaw)) : (cameraRotationAngle - 180f + _cameraRotationDragOffset));
			_cameraRotationDampAngle = DampOrLinear(_cameraRotationDampAngle, target, ref _cameraRotationDampAngleVelocity, dt);
			_cameraDampDepth = DampOrLinear(_cameraDampDepth, _cameraDepth, ref _cameraDampDepthVelocity, dt);
			float target2 = ((_focusFOVLocked && (_isFocusing || _focusTransitionActive)) ? _focusLockedFOV : cameraFOVCurve.Evaluate(_cameraDepth));
			_cameraFOVDamp = DampOrLinear(_cameraFOVDamp, target2, ref _cameraFOVDampVelocity, dt);
			float target3 = (((_isFocusing || (_focusTransitionActive && _focusPoseLockedFromEntry)) && _focusPitchDegrees > 0f) ? 1f : 0f);
			_focusWeight = DampOrLinear(_focusWeight, target3, ref _focusWeightVelocity, dt);
		}
		_cameraTransposer.m_FollowOffset = ComputeFollowOffset(_cameraRotationDampAngle, _cameraDampDepth);
		dormMainVCam.m_Lens.FieldOfView = _cameraFOVDamp;
	}

	private Vector3 ComputeFollowOffset(float rotationAngle, float xzDistance)
	{
		float num = cameraHeightCurve.Evaluate(xzDistance);
		float y = num;
		if (_focusPitchDegrees > 0f && _focusWeight > 0f)
		{
			float b = xzDistance * Mathf.Tan(MathF.PI / 180f * _focusPitchDegrees);
			y = Mathf.Lerp(num, b, _focusWeight);
		}
		return new Vector3((0f - Mathf.Sin(MathF.PI / 180f * rotationAngle)) * xzDistance, y, Mathf.Cos(MathF.PI / 180f * rotationAngle) * xzDistance);
	}

	private void UpdateCamera()
	{
		_ = cameraControlEnabled;
	}

	public void BindFocusObject(GameObject obj, bool groundBased = true)
	{
		bindFocusObj = obj;
		_bindFocusObjGroundBased = groundBased;
	}

	public void BindFocusObjectDefault()
	{
		if (null != bindFocusObj)
		{
			Vector3 position = bindFocusObj.transform.position;
			if (bindFocusObj != cameraBeacon.gameObject && _bindFocusObjGroundBased)
			{
				_beaconBaseY = position.y;
			}
			cameraBeacon.transform.position = new Vector3(position.x, _beaconBaseY, position.z);
		}
		bindFocusObj = cameraBeacon.gameObject;
		_bindFocusObjGroundBased = true;
	}

	private void TickFocusTransitionT(float dt)
	{
		float focusPhaseDuration = FocusPhaseDuration;
		if (focusPhaseDuration <= 0f)
		{
			_focusFrameT = 1f;
			_focusEasedPrev = 1f;
			return;
		}
		if (!_focusSmoothEase)
		{
			_focusFrameT = Mathf.Clamp01(dt / Mathf.Max(focusPhaseDuration - _focusElapsed, dt));
			return;
		}
		float num = Mathf.Clamp01(_focusElapsed / focusPhaseDuration);
		AnimationCurve animationCurve = (_focusMovingStage ? focusMoveEaseCurve : focusZoomEaseCurve);
		float num2 = ((num >= 1f) ? 1f : Mathf.Clamp01(animationCurve.Evaluate(num)));
		float num3 = 1f - _focusEasedPrev;
		_focusFrameT = ((num3 <= 1E-05f) ? 1f : Mathf.Clamp01((num2 - _focusEasedPrev) / num3));
		_focusEasedPrev = num2;
	}

	private float FocusLinearT(float dt)
	{
		if (!(dt > float.Epsilon))
		{
			return 0f;
		}
		return _focusFrameT;
	}

	private float DampOrLinear(float current, float target, ref float velocity, float dt)
	{
		if (FocusLinearActive)
		{
			return Mathf.Lerp(current, target, FocusLinearT(dt));
		}
		return Mathf.SmoothDamp(current, target, ref velocity, GetRotateDurationTime(), float.PositiveInfinity, dt);
	}

	public void EnterFocus(Vector3 worldPos, float depthScale, float transitionDuration = -1f, float settleEpsilon = 0.01f, float pitchDegrees = -1f, float minDepth = -1f, bool ignoreFollowDeadzone = false, bool lockPoseFromEntry = false, bool smoothEase = false, float aimHeightOffset = 0f, float moveSpeed = -1f, bool keepPointOnExit = false, bool singleBlend = false)
	{
		bool flag = !_isFocusing;
		if (flag)
		{
			_savedFocusObj = bindFocusObj;
			_savedFocusObjGroundBased = _bindFocusObjGroundBased;
			_savedDepthValue = updateCameraDepthValue;
			_savedBeaconPosition = cameraBeacon.position;
			_isFocusing = true;
			_cameraInputLocked = true;
		}
		if (_focusAnchor == null)
		{
			_focusAnchor = new GameObject("DormCameraFocusAnchor");
		}
		_focusAnchor.transform.position = worldPos;
		bindFocusObj = _focusAnchor;
		_bindFocusObjGroundBased = true;
		updateCameraDepthValue = depthScale;
		_focusMinDepth = ((minDepth < 0f) ? 2f : minDepth);
		_focusIgnoreFollowDeadzone = ignoreFollowDeadzone;
		_focusAimHeightOffset = aimHeightOffset;
		_focusKeepPointOnExit = keepPointOnExit;
		if (flag)
		{
			_focusMovingStage = false;
			_focusBlendDuration = -1f;
			if (moveSpeed > 0f)
			{
				float num = worldPos.x - cameraBeacon.position.x;
				float num2 = worldPos.z - cameraBeacon.position.z;
				float num3 = Mathf.Sqrt(num * num + num2 * num2);
				float value = focusMoveDurationCurve?.Evaluate(num3) ?? (num3 / moveSpeed);
				value = Mathf.Clamp(value, 0f, 3f);
				if (singleBlend)
				{
					_focusBlendDuration = Mathf.Max(value, transitionDuration);
				}
				else
				{
					_focusMoveDuration = value;
					_focusMovingStage = _focusMoveDuration > 0.01f;
					_focusStageHoldDepth = _cameraDampDepth;
				}
			}
		}
		else
		{
			_focusBlendDuration = -1f;
		}
		if (!lockPoseFromEntry)
		{
			_focusPitchDegrees = pitchDegrees;
			_focusPoseLockedFromEntry = false;
		}
		else if (flag)
		{
			float cameraDampDepth = _cameraDampDepth;
			float num4 = ((null != _cameraTransposer) ? _cameraTransposer.m_FollowOffset.y : 0f);
			if (cameraDampDepth > 0.01f && num4 > 0.01f)
			{
				_focusPitchDegrees = Mathf.Atan2(num4, cameraDampDepth) * 57.29578f;
				_focusWeight = 1f;
				_focusWeightVelocity = 0f;
				_focusFOVLocked = true;
				_focusLockedFOV = _cameraFOVDamp;
				_focusPoseLockedFromEntry = true;
			}
			else
			{
				_focusPitchDegrees = pitchDegrees;
				_focusPoseLockedFromEntry = false;
			}
		}
		_focusTransitionDuration = transitionDuration;
		_focusSettleEpsilon = settleEpsilon;
		_focusSmoothEase = smoothEase;
		_focusTransitionActive = true;
		_focusElapsed = 0f;
		_focusEasedPrev = 0f;
		_focusFrameT = 0f;
		SceneSingleton<DormAudioListenerController>.Instance?.NotifyEnterFocus();
	}

	private void TickFocusStage()
	{
		if (_focusMovingStage)
		{
			if (!_isFocusing)
			{
				_focusMovingStage = false;
			}
			else if (!(_focusElapsed < _focusMoveDuration))
			{
				_focusMovingStage = false;
				_focusElapsed = 0f;
				_focusEasedPrev = 0f;
				_focusFrameT = 0f;
			}
		}
	}

	public void UpdateFocusPoint(Vector3 worldPos)
	{
		if (_isFocusing && !(_focusAnchor == null))
		{
			_focusAnchor.transform.position = worldPos;
		}
	}

	public void UpdateFocusSideView(bool enable, Vector3 playerPos, Vector3 actorPos, float sideYawOffset)
	{
		if (!enable || !_isFocusing)
		{
			_focusSideViewActive = false;
			_focusSideLocked = false;
			return;
		}
		_focusSideViewActive = true;
		_focusSideYawOffset = sideYawOffset;
		float num = actorPos.x - playerPos.x;
		float num2 = actorPos.z - playerPos.z;
		if (!(num * num + num2 * num2 < 1E-06f))
		{
			float num3 = Mathf.Atan2(0f - num, num2) * 57.29578f;
			if (!_focusSideLocked)
			{
				float num4 = Mathf.Abs(Mathf.DeltaAngle(_cameraRotationDampAngle, num3 + 90f));
				float num5 = Mathf.Abs(Mathf.DeltaAngle(_cameraRotationDampAngle, num3 - 90f));
				_focusSideSign = ((num4 <= num5) ? 1f : (-1f));
				_focusSideLocked = true;
			}
			_focusSideYaw = num3 + _focusSideSign * (90f + sideYawOffset);
		}
	}

	public void ExitFocus()
	{
		if (_isFocusing)
		{
			bindFocusObj = _savedFocusObj;
			_bindFocusObjGroundBased = _savedFocusObjGroundBased;
			updateCameraDepthValue = _savedDepthValue;
			if (_savedFocusObj == cameraBeacon.gameObject)
			{
				Vector3 vector = (_focusKeepPointOnExit ? ClampToDragRng(cameraBeacon.position) : _savedBeaconPosition);
				cameraBeacon.position = vector;
				_cameraFollowTargetPosition = vector;
				_cameraDampPosition = vector;
			}
			_isFocusing = false;
			_cameraInputLocked = false;
			_focusMovingStage = false;
			_focusBlendDuration = -1f;
			_focusSideViewActive = false;
			_focusSideLocked = false;
			_focusElapsed = 0f;
			_focusEasedPrev = 0f;
			_focusFrameT = 0f;
			SceneSingleton<DormAudioListenerController>.Instance?.NotifyExitFocus();
		}
	}

	private void TickFocusTransitionSettle()
	{
		if (!_focusTransitionActive || _isFocusing)
		{
			return;
		}
		bool flag = FocusPhaseDuration >= 0f;
		if ((!flag || !(_focusElapsed < FocusPhaseDuration)) && !(Mathf.Abs(_cameraDampDepth - _cameraDepth) >= _focusSettleEpsilon))
		{
			_focusTransitionActive = false;
			_focusFOVLocked = false;
			_focusPoseLockedFromEntry = false;
			if (flag)
			{
				ResetCameraDampVelocities();
			}
		}
	}

	private void ResetCameraDampVelocities()
	{
		_cameraDampVelocity = Vector3.zero;
		_cameraDampAngleVelocity = 0f;
		_cameraRotationDampAngleVelocity = 0f;
		_cameraDampDepthVelocity = 0f;
		_cameraFOVDampVelocity = 0f;
		_focusWeightVelocity = 0f;
		_focusAimHeightVelocity = 0f;
	}

	public void UpdateCameraDepthValue(bool mouseScrollWheelHasInput, float mouseScrollWheelInput)
	{
		if (_cameraInputLocked || !mouseScrollWheelHasInput)
		{
			return;
		}
		if (mouseScrollWheelInput > 0f)
		{
			if (mouseScrollWheelDirection)
			{
				updateCameraDepthValue *= 0.9f;
				return;
			}
			mouseScrollWheelDirection = true;
			updateCameraDepthValue = 0.9f;
		}
		else if (!mouseScrollWheelDirection)
		{
			updateCameraDepthValue *= 1.1f;
		}
		else
		{
			mouseScrollWheelDirection = false;
			updateCameraDepthValue = 1.1f;
		}
	}

	public void UpdateCameraDepthByPinch(bool hasInput, float pinchDelta)
	{
		if (!_cameraInputLocked && hasInput)
		{
			updateCameraDepthValue *= Mathf.Clamp(1f - pinchDelta * pinchZoomSpeed, 0.5f, 2f);
			mouseScrollWheelDirection = pinchDelta > 0f;
		}
	}

	public void UpdateCameraShiftValue(bool camerShiftHasInput, Vector2 cameraShiftValue)
	{
		if (_cameraInputLocked)
		{
			this.cameraShiftValue = Vector3.zero;
			return;
		}
		if (!camerShiftHasInput)
		{
			this.cameraShiftValue = Vector3.zero;
			return;
		}
		Vector2 vector = cameraShiftValue * dragSensitivity;
		float f = MathF.PI / 180f * _cameraRotationDampAngle;
		Vector3 vector2 = new Vector3(0f - Mathf.Sin(f), 0f, Mathf.Cos(f));
		Vector3 vector3 = new Vector3(vector2.z, 0f, 0f - vector2.x);
		this.cameraShiftValue = vector.x * vector3 + vector.y * vector2;
	}

	public void UpdateCameraRotateByDrag(bool hasInput, Vector2 dragDelta, float rangeLimit = -1f)
	{
		if (!_cameraInputLocked && hasInput)
		{
			float num = (0f - dragDelta.x) * dragRotateSensitivity;
			float cameraRotationDragOffset = _cameraRotationDragOffset;
			float num2 = cameraRotationDragOffset + num;
			if (rangeLimit > 0f)
			{
				num2 = Mathf.Clamp(num2, 0f - rangeLimit, rangeLimit);
			}
			float num3 = num2 - cameraRotationDragOffset;
			_cameraRotationDragOffset = num2;
			_cameraRotationDampAngle += num3;
		}
	}

	public void ResetCameraRotateDragOffset()
	{
		_cameraRotationDragOffset = 0f;
	}

	public void SetDragRngCenter(Vector3 worldCenter)
	{
		_dragRngCenter = worldCenter;
	}

	public void CenterBeaconToDragRngCenter()
	{
		Vector3 position = cameraBeacon.transform.position;
		position.x = _dragRngCenter.x;
		position.z = _dragRngCenter.z;
		cameraBeacon.transform.position = position;
		_cameraDampPosition = position;
		_cameraDampVelocity = Vector3.zero;
		cameraShiftValue = Vector3.zero;
	}

	public void SaveViewCameraState()
	{
		_hasViewCameraSnapshot = true;
		_viewSnapBeaconPos = cameraBeacon.position;
		_viewSnapRotationDragOffset = _cameraRotationDragOffset;
		_viewSnapDepthValue = updateCameraDepthValue;
	}

	public void RestoreViewCameraState()
	{
		if (_hasViewCameraSnapshot)
		{
			_hasViewCameraSnapshot = false;
			_cameraRotationDragOffset = _viewSnapRotationDragOffset;
			updateCameraDepthValue = _viewSnapDepthValue;
			cameraBeacon.position = ClampToDragRng(_viewSnapBeaconPos);
			InitCameraValue();
		}
	}

	public void DiscardViewCameraState()
	{
		_hasViewCameraSnapshot = false;
	}

	public void EnableCloseupCamera()
	{
		if (++_closeupCameraEnabledRC == 1)
		{
			closeupCamera.enabled = true;
			closeupCamera.cullingMask = 67108864;
			_closeupCameraAdditionalCameraData.clearDepth = true;
			_closeupCameraAdditionalCameraData.renderShadows = false;
			_closeupCameraAdditionalCameraData.renderPostProcessing = true;
			MonoSingleton<GameCameraStackManager>.Instance.mainCamera.cullingMask |= 67108864;
			if (GameMainLight.Instance != null)
			{
				GameMainLight.Instance.light.cullingMask |= 67108864;
			}
		}
	}

	public void DisableCloseupCamera()
	{
		if (--_closeupCameraEnabledRC == 0)
		{
			closeupCamera.enabled = false;
			MonoSingleton<GameCameraStackManager>.Instance.mainCamera.cullingMask &= -67108865;
			if (GameMainLight.Instance != null)
			{
				GameMainLight.Instance.light.cullingMask &= -67108865;
			}
		}
		else if (_closeupCameraEnabledRC < 0)
		{
			_closeupCameraEnabledRC = 0;
			NovaLogger.Warning("[DormCameraController] EnableCloseupCamera 与 DisableCloseupCamera 使用不匹配，请成对使用");
		}
	}

	private void InitCameraRendering()
	{
		Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
		if (!mainCamera.TryGetComponent<Outliner>(out var component))
		{
			component = mainCamera.gameObject.AddComponent<Outliner>();
		}
		component.enabled = true;
		component.RenderingMode = outlinerRenderingMode;
		component.PrimaryBufferSizeMode = BufferSizeMode.Scaled;
		component.PrimaryRendererScale = outlinerPrimaryRendererScale;
		component.BlurShift = outlinerBlurShift;
		component.DilateShift = outlinerDilateShift;
		component.DilateIterations = outlinerDilateIterations;
		component.DilateQuality = outlinerDilateQuality;
		component.BlurIterations = outlinerBlurIterations;
		component.BlurType = outlinerBlurType;
		if (!mainCamera.TryGetComponent<Overdrawer>(out var component2))
		{
			component2 = mainCamera.gameObject.AddComponent<Overdrawer>();
		}
		else
		{
			component2.enabled = true;
		}
	}

	private void ReleaseCameraRendering()
	{
		Camera mainCamera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
		if (mainCamera.TryGetComponent<Outliner>(out var component))
		{
			component.enabled = false;
		}
		if (mainCamera.TryGetComponent<Overdrawer>(out var component2))
		{
			component2.enabled = false;
		}
	}

	public void ActiveHighlightOutline(GameObject target)
	{
		if (!target.TryGetComponent<Outlinable>(out var component))
		{
			component = target.AddComponent<Outlinable>();
			component.AddAllChildRenderersToRenderingList(Game.Graphics.HighlightOutliner.RenderersAddingMode.MeshRenderer | Game.Graphics.HighlightOutliner.RenderersAddingMode.SkinnedMeshRenderer);
		}
		activedHighlightOutlines.Add(component);
		component.enabled = true;
		component.OutlineParameters.Enabled = true;
		component.OutlineParameters.Color = outlineHighlightColor;
	}

	public void DeactiveHighlightOutline(GameObject target)
	{
		if (target.TryGetComponent<Outlinable>(out var component))
		{
			activedHighlightOutlines.Remove(component);
			component.enabled = false;
		}
	}
}
