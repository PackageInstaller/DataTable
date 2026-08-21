using System;
using System.Collections;
using System.Collections.Generic;
using System.Text;
using Cinemachine.Utility;
using UnityEngine;
using UnityEngine.Events;
using UnityEngine.SceneManagement;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[DisallowMultipleComponent]
[ExecuteAlways]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineBrainProperties.html")]
[SaveDuringPlay]
[AddComponentMenu("Cinemachine/CinemachineBrain")]
public class CinemachineBrain : MonoBehaviour, ICameraOverrideStack
{
	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public enum UpdateMethod
	{
		FixedUpdate,
		LateUpdate,
		SmartUpdate,
		ManualUpdate
	}

	[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
	public enum BrainUpdateMethod
	{
		FixedUpdate,
		LateUpdate
	}

	[Serializable]
	public class BrainEvent : UnityEvent<CinemachineBrain>
	{
	}

	[Serializable]
	public class VcamActivatedEvent : UnityEvent<ICinemachineCamera, ICinemachineCamera>
	{
	}

	private class BrainFrame
	{
		public int id;

		public CinemachineBlend blend = new CinemachineBlend(null, null, null, 0f, 0f);

		public CinemachineBlend workingBlend = new CinemachineBlend(null, null, null, 0f, 0f);

		public BlendSourceVirtualCamera workingBlendSource = new BlendSourceVirtualCamera(null);

		public float deltaTimeOverride;

		public float blendStartPosition;

		public bool Active => blend.IsValid;
	}

	[Tooltip("When enabled, the current camera and blend will be indicated in the game window, for debugging")]
	public bool m_ShowDebugText;

	[Tooltip("When enabled, the camera's frustum will be shown at all times in the scene view")]
	public bool m_ShowCameraFrustum = true;

	[Tooltip("When enabled, the cameras will always respond in real-time to user input and damping, even if the game is running in slow motion")]
	public bool m_IgnoreTimeScale;

	[Tooltip("If set, this object's Y axis will define the worldspace Up vector for all the virtual cameras.  This is useful for instance in top-down game environments.  If not set, Up is worldspace Y.  Setting this appropriately is important, because Virtual Cameras don't like looking straight up or straight down.")]
	public Transform m_WorldUpOverride;

	[Tooltip("The update time for the vcams.  Use FixedUpdate if all your targets are animated during FixedUpdate (e.g. RigidBodies), LateUpdate if all your targets are animated during the normal Update loop, and SmartUpdate if you want Cinemachine to do the appropriate thing on a per-target basis.  SmartUpdate is the recommended setting")]
	public UpdateMethod m_UpdateMethod = UpdateMethod.SmartUpdate;

	[Tooltip("The update time for the Brain, i.e. when the blends are evaluated and the brain's transform is updated")]
	public BrainUpdateMethod m_BlendUpdateMethod = BrainUpdateMethod.LateUpdate;

	[Tooltip("The blend that is used in cases where you haven't explicitly defined a blend between two Virtual Cameras")]
	[CinemachineBlendDefinitionProperty]
	public CinemachineBlendDefinition m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 2f);

	[Tooltip("This is the asset that contains custom settings for blends between specific virtual cameras in your scene")]
	public CinemachineBlenderSettings m_CustomBlends;

	private Camera m_OutputCamera;

	private GameObject m_TargetOverride;

	[Tooltip("This event will fire whenever a virtual camera goes live and there is no blend")]
	public BrainEvent m_CameraCutEvent = new BrainEvent();

	[Tooltip("This event will fire whenever a virtual camera goes live.  If a blend is involved, then the event will fire on the first frame of the blend.")]
	public VcamActivatedEvent m_CameraActivatedEvent = new VcamActivatedEvent();

	private static ICinemachineCamera mSoloCamera;

	private Coroutine mPhysicsCoroutine;

	private int m_LastFrameUpdated;

	private WaitForFixedUpdate mWaitForFixedUpdate = new WaitForFixedUpdate();

	private List<BrainFrame> mFrameStack = new List<BrainFrame>();

	private int mNextFrameId = 1;

	private CinemachineBlend mCurrentLiveCameras = new CinemachineBlend(null, null, null, 0f, 0f);

	private static readonly AnimationCurve mDefaultLinearAnimationCurve = AnimationCurve.Linear(0f, 0f, 1f, 1f);

	private ICinemachineCamera mActiveCameraPreviousFrame;

	private GameObject mActiveCameraPreviousFrameGameObject;

	public Camera OutputCamera
	{
		get
		{
			if (m_OutputCamera == null && !Application.isPlaying)
			{
				ControlledObject.TryGetComponent<Camera>(out m_OutputCamera);
			}
			return m_OutputCamera;
		}
	}

	public GameObject ControlledObject
	{
		get
		{
			if (!(m_TargetOverride == null))
			{
				return m_TargetOverride;
			}
			return base.gameObject;
		}
		set
		{
			if ((object)m_TargetOverride != value)
			{
				m_TargetOverride = value;
				ControlledObject.TryGetComponent<Camera>(out m_OutputCamera);
			}
		}
	}

	public static ICinemachineCamera SoloCamera
	{
		get
		{
			return mSoloCamera;
		}
		set
		{
			if (value != null && !CinemachineCore.Instance.IsLive(value))
			{
				value.OnTransitionFromCamera(null, Vector3.up, CinemachineCore.DeltaTime);
			}
			mSoloCamera = value;
		}
	}

	public Vector3 DefaultWorldUp
	{
		get
		{
			if (!(m_WorldUpOverride != null))
			{
				return Vector3.up;
			}
			return m_WorldUpOverride.transform.up;
		}
	}

	public ICinemachineCamera ActiveVirtualCamera
	{
		get
		{
			if (SoloCamera != null)
			{
				return SoloCamera;
			}
			return DeepCamBFromBlend(mCurrentLiveCameras);
		}
	}

	public bool IsBlending => ActiveBlend != null;

	public CinemachineBlend ActiveBlend
	{
		get
		{
			if (SoloCamera != null)
			{
				return null;
			}
			if (mCurrentLiveCameras.CamA == null || mCurrentLiveCameras.Equals(null) || mCurrentLiveCameras.IsComplete)
			{
				return null;
			}
			return mCurrentLiveCameras;
		}
		set
		{
			if (value == null)
			{
				mFrameStack[0].blend.Duration = 0f;
			}
			else
			{
				mFrameStack[0].blend = value;
			}
		}
	}

	public CameraState CurrentCameraState { get; private set; }

	public static Color GetSoloGUIColor()
	{
		return Color.Lerp(Color.red, Color.yellow, 0.8f);
	}

	private void OnEnable()
	{
		if (mFrameStack.Count == 0)
		{
			mFrameStack.Add(new BrainFrame());
		}
		CinemachineCore.Instance.AddActiveBrain(this);
		CinemachineDebug.OnGUIHandlers = (CinemachineDebug.OnGUIDelegate)Delegate.Remove(CinemachineDebug.OnGUIHandlers, new CinemachineDebug.OnGUIDelegate(OnGuiHandler));
		CinemachineDebug.OnGUIHandlers = (CinemachineDebug.OnGUIDelegate)Delegate.Combine(CinemachineDebug.OnGUIHandlers, new CinemachineDebug.OnGUIDelegate(OnGuiHandler));
		mPhysicsCoroutine = StartCoroutine(AfterPhysics());
		SceneManager.sceneLoaded += OnSceneLoaded;
		SceneManager.sceneUnloaded += OnSceneUnloaded;
	}

	private void OnDisable()
	{
		SceneManager.sceneLoaded -= OnSceneLoaded;
		SceneManager.sceneUnloaded -= OnSceneUnloaded;
		CinemachineDebug.OnGUIHandlers = (CinemachineDebug.OnGUIDelegate)Delegate.Remove(CinemachineDebug.OnGUIHandlers, new CinemachineDebug.OnGUIDelegate(OnGuiHandler));
		CinemachineCore.Instance.RemoveActiveBrain(this);
		mFrameStack.Clear();
		StopCoroutine(mPhysicsCoroutine);
	}

	private void OnSceneLoaded(Scene scene, LoadSceneMode mode)
	{
		if (Time.frameCount == m_LastFrameUpdated && mFrameStack.Count > 0)
		{
			ManualUpdate();
		}
	}

	private void OnSceneUnloaded(Scene scene)
	{
		if (Time.frameCount == m_LastFrameUpdated && mFrameStack.Count > 0)
		{
			ManualUpdate();
		}
	}

	private void Awake()
	{
		ControlledObject.TryGetComponent<Camera>(out m_OutputCamera);
	}

	private void Start()
	{
		m_LastFrameUpdated = -1;
		UpdateVirtualCameras(CinemachineCore.UpdateFilter.Late, -1f);
	}

	private void OnGuiHandler()
	{
		if (!m_ShowDebugText)
		{
			CinemachineDebug.ReleaseScreenPos(this);
			return;
		}
		StringBuilder stringBuilder = CinemachineDebug.SBFromPool();
		Color color = GUI.color;
		stringBuilder.Length = 0;
		stringBuilder.Append("CM ");
		stringBuilder.Append(base.gameObject.name);
		stringBuilder.Append(": ");
		if (SoloCamera != null)
		{
			stringBuilder.Append("SOLO ");
			GUI.color = GetSoloGUIColor();
		}
		if (IsBlending)
		{
			stringBuilder.Append(ActiveBlend.Description);
		}
		else
		{
			ICinemachineCamera activeVirtualCamera = ActiveVirtualCamera;
			if (activeVirtualCamera == null)
			{
				stringBuilder.Append("(none)");
			}
			else
			{
				stringBuilder.Append("[");
				stringBuilder.Append(activeVirtualCamera.Name);
				stringBuilder.Append("]");
			}
		}
		string text = stringBuilder.ToString();
		GUI.Label(CinemachineDebug.GetScreenPos(this, text, GUI.skin.box), text, GUI.skin.box);
		GUI.color = color;
		CinemachineDebug.ReturnToPool(stringBuilder);
	}

	private IEnumerator AfterPhysics()
	{
		while (true)
		{
			yield return mWaitForFixedUpdate;
			if (m_UpdateMethod == UpdateMethod.FixedUpdate || m_UpdateMethod == UpdateMethod.SmartUpdate)
			{
				CinemachineCore.UpdateFilter updateFilter = CinemachineCore.UpdateFilter.Fixed;
				if (m_UpdateMethod == UpdateMethod.SmartUpdate)
				{
					UpdateTracker.OnUpdate(UpdateTracker.UpdateClock.Fixed);
					updateFilter = CinemachineCore.UpdateFilter.Smart;
				}
				UpdateVirtualCameras(updateFilter, GetEffectiveDeltaTime(fixedDelta: true));
			}
			if (m_BlendUpdateMethod == BrainUpdateMethod.FixedUpdate)
			{
				UpdateFrame0(Time.fixedDeltaTime);
				ProcessActiveCamera(Time.fixedDeltaTime);
			}
		}
	}

	private void LateUpdate()
	{
		if (m_UpdateMethod != UpdateMethod.ManualUpdate)
		{
			ManualUpdate();
		}
	}

	public void ManualUpdate()
	{
		m_LastFrameUpdated = Time.frameCount;
		float effectiveDeltaTime = GetEffectiveDeltaTime(fixedDelta: false);
		if (!Application.isPlaying || m_BlendUpdateMethod != BrainUpdateMethod.FixedUpdate)
		{
			UpdateFrame0(effectiveDeltaTime);
		}
		ComputeCurrentBlend(ref mCurrentLiveCameras, 0);
		if (Application.isPlaying && m_UpdateMethod == UpdateMethod.FixedUpdate)
		{
			if (m_BlendUpdateMethod != BrainUpdateMethod.FixedUpdate)
			{
				CinemachineCore.Instance.m_CurrentUpdateFilter = CinemachineCore.UpdateFilter.Fixed;
				if (SoloCamera == null)
				{
					mCurrentLiveCameras.UpdateCameraState(DefaultWorldUp, GetEffectiveDeltaTime(fixedDelta: true));
				}
			}
		}
		else
		{
			CinemachineCore.UpdateFilter updateFilter = CinemachineCore.UpdateFilter.Late;
			if (m_UpdateMethod == UpdateMethod.SmartUpdate)
			{
				UpdateTracker.OnUpdate(UpdateTracker.UpdateClock.Late);
				updateFilter = CinemachineCore.UpdateFilter.SmartLate;
			}
			UpdateVirtualCameras(updateFilter, effectiveDeltaTime);
		}
		if (!Application.isPlaying || m_BlendUpdateMethod != BrainUpdateMethod.FixedUpdate)
		{
			ProcessActiveCamera(effectiveDeltaTime);
		}
	}

	private float GetEffectiveDeltaTime(bool fixedDelta)
	{
		if (CinemachineCore.UniformDeltaTimeOverride >= 0f)
		{
			return CinemachineCore.UniformDeltaTimeOverride;
		}
		if (SoloCamera != null)
		{
			return Time.unscaledDeltaTime;
		}
		if (!Application.isPlaying)
		{
			for (int num = mFrameStack.Count - 1; num > 0; num--)
			{
				BrainFrame brainFrame = mFrameStack[num];
				if (brainFrame.Active)
				{
					return brainFrame.deltaTimeOverride;
				}
			}
			return -1f;
		}
		if (m_IgnoreTimeScale)
		{
			if (!fixedDelta)
			{
				return Time.unscaledDeltaTime;
			}
			return Time.fixedDeltaTime;
		}
		if (!fixedDelta)
		{
			return Time.deltaTime;
		}
		return Time.fixedDeltaTime;
	}

	private void UpdateVirtualCameras(CinemachineCore.UpdateFilter updateFilter, float deltaTime)
	{
		CinemachineCore.Instance.m_CurrentUpdateFilter = updateFilter;
		Camera outputCamera = OutputCamera;
		CinemachineCore.Instance.UpdateAllActiveVirtualCameras((outputCamera == null) ? (-1) : outputCamera.cullingMask, DefaultWorldUp, deltaTime);
		if (SoloCamera != null)
		{
			SoloCamera.UpdateCameraState(DefaultWorldUp, deltaTime);
		}
		mCurrentLiveCameras.UpdateCameraState(DefaultWorldUp, deltaTime);
		updateFilter = CinemachineCore.UpdateFilter.Late;
		if (Application.isPlaying)
		{
			if (m_UpdateMethod == UpdateMethod.SmartUpdate)
			{
				updateFilter |= CinemachineCore.UpdateFilter.Smart;
			}
			else if (m_UpdateMethod == UpdateMethod.FixedUpdate)
			{
				updateFilter = CinemachineCore.UpdateFilter.Fixed;
			}
		}
		CinemachineCore.Instance.m_CurrentUpdateFilter = updateFilter;
	}

	private static ICinemachineCamera DeepCamBFromBlend(CinemachineBlend blend)
	{
		ICinemachineCamera camB;
		for (camB = blend.CamB; camB != null; camB = blendSourceVirtualCamera.Blend.CamB)
		{
			if (!camB.IsValid)
			{
				return null;
			}
			if (!(camB is BlendSourceVirtualCamera blendSourceVirtualCamera))
			{
				break;
			}
		}
		return camB;
	}

	public bool IsLiveInBlend(ICinemachineCamera vcam)
	{
		if (vcam == mCurrentLiveCameras.CamA)
		{
			return true;
		}
		if (mCurrentLiveCameras.CamA is BlendSourceVirtualCamera blendSourceVirtualCamera && blendSourceVirtualCamera.Blend.Uses(vcam))
		{
			return true;
		}
		ICinemachineCamera parentCamera = vcam.ParentCamera;
		if (parentCamera != null && parentCamera.IsLiveChild(vcam))
		{
			return IsLiveInBlend(parentCamera);
		}
		return false;
	}

	private int GetBrainFrame(int withId)
	{
		for (int num = mFrameStack.Count - 1; num > 0; num--)
		{
			if (mFrameStack[num].id == withId)
			{
				return num;
			}
		}
		mFrameStack.Add(new BrainFrame
		{
			id = withId
		});
		return mFrameStack.Count - 1;
	}

	public int SetCameraOverride(int overrideId, ICinemachineCamera camA, ICinemachineCamera camB, float weightB, float deltaTime)
	{
		if (overrideId < 0)
		{
			overrideId = mNextFrameId++;
		}
		BrainFrame brainFrame = mFrameStack[GetBrainFrame(overrideId)];
		brainFrame.deltaTimeOverride = deltaTime;
		brainFrame.blend.CamA = camA;
		brainFrame.blend.CamB = camB;
		brainFrame.blend.BlendCurve = mDefaultLinearAnimationCurve;
		brainFrame.blend.Duration = 1f;
		brainFrame.blend.TimeInBlend = weightB;
		CinemachineVirtualCameraBase cinemachineVirtualCameraBase = camA as CinemachineVirtualCameraBase;
		if (cinemachineVirtualCameraBase != null)
		{
			cinemachineVirtualCameraBase.EnsureStarted();
		}
		cinemachineVirtualCameraBase = camB as CinemachineVirtualCameraBase;
		if (cinemachineVirtualCameraBase != null)
		{
			cinemachineVirtualCameraBase.EnsureStarted();
		}
		return overrideId;
	}

	public void ReleaseCameraOverride(int overrideId)
	{
		for (int num = mFrameStack.Count - 1; num > 0; num--)
		{
			if (mFrameStack[num].id == overrideId)
			{
				mFrameStack.RemoveAt(num);
				break;
			}
		}
	}

	private void ProcessActiveCamera(float deltaTime)
	{
		ICinemachineCamera activeVirtualCamera = ActiveVirtualCamera;
		if (SoloCamera != null)
		{
			CameraState state = SoloCamera.State;
			PushStateToUnityCamera(ref state);
		}
		else if (activeVirtualCamera == null)
		{
			CameraState state2 = CameraState.Default;
			Transform transform = ControlledObject.transform;
			state2.RawPosition = transform.position;
			state2.RawOrientation = transform.rotation;
			state2.Lens = LensSettings.FromCamera(m_OutputCamera);
			state2.BlendHint |= (CameraState.BlendHintValue)67;
			PushStateToUnityCamera(ref state2);
		}
		else
		{
			if (mActiveCameraPreviousFrameGameObject == null)
			{
				mActiveCameraPreviousFrame = null;
			}
			if (activeVirtualCamera != mActiveCameraPreviousFrame)
			{
				activeVirtualCamera.OnTransitionFromCamera(mActiveCameraPreviousFrame, DefaultWorldUp, deltaTime);
				if (m_CameraActivatedEvent != null)
				{
					m_CameraActivatedEvent.Invoke(activeVirtualCamera, mActiveCameraPreviousFrame);
				}
				if (!IsBlending || (mActiveCameraPreviousFrame != null && !ActiveBlend.Uses(mActiveCameraPreviousFrame)))
				{
					if (m_CameraCutEvent != null)
					{
						m_CameraCutEvent.Invoke(this);
					}
					if (CinemachineCore.CameraCutEvent != null)
					{
						CinemachineCore.CameraCutEvent.Invoke(this);
					}
				}
				activeVirtualCamera.UpdateCameraState(DefaultWorldUp, deltaTime);
			}
			CameraState state3 = mCurrentLiveCameras.State;
			PushStateToUnityCamera(ref state3);
		}
		mActiveCameraPreviousFrame = activeVirtualCamera;
		mActiveCameraPreviousFrameGameObject = activeVirtualCamera?.VirtualCameraGameObject;
	}

	private void UpdateFrame0(float deltaTime)
	{
		if (mFrameStack.Count == 0)
		{
			mFrameStack.Add(new BrainFrame());
		}
		BrainFrame brainFrame = mFrameStack[0];
		ICinemachineCamera cinemachineCamera = TopCameraFromPriorityQueue();
		ICinemachineCamera camB = brainFrame.blend.CamB;
		if (cinemachineCamera != camB)
		{
			if ((UnityEngine.Object)cinemachineCamera != null && (UnityEngine.Object)camB != null && deltaTime >= 0f)
			{
				CinemachineBlendDefinition cinemachineBlendDefinition = LookupBlend(camB, cinemachineCamera);
				float num = cinemachineBlendDefinition.BlendTime;
				float blendStartPosition = 0f;
				if (cinemachineBlendDefinition.BlendCurve != null && num > 0.0001f)
				{
					if (brainFrame.blend.IsComplete)
					{
						brainFrame.blend.CamA = camB;
					}
					else
					{
						if ((brainFrame.blend.CamA == cinemachineCamera || (brainFrame.blend.CamA as BlendSourceVirtualCamera)?.Blend.CamB == cinemachineCamera) && brainFrame.blend.CamB == camB)
						{
							float num2 = brainFrame.blendStartPosition + (1f - brainFrame.blendStartPosition) * brainFrame.blend.TimeInBlend / brainFrame.blend.Duration;
							num *= num2;
							blendStartPosition = 1f - num2;
						}
						brainFrame.blend.CamA = new BlendSourceVirtualCamera(new CinemachineBlend(brainFrame.blend.CamA, brainFrame.blend.CamB, brainFrame.blend.BlendCurve, brainFrame.blend.Duration, brainFrame.blend.TimeInBlend));
					}
				}
				brainFrame.blend.BlendCurve = cinemachineBlendDefinition.BlendCurve;
				brainFrame.blend.Duration = num;
				brainFrame.blend.TimeInBlend = 0f;
				brainFrame.blendStartPosition = blendStartPosition;
			}
			brainFrame.blend.CamB = cinemachineCamera;
		}
		if (brainFrame.blend.CamA != null)
		{
			brainFrame.blend.TimeInBlend += ((deltaTime >= 0f) ? deltaTime : brainFrame.blend.Duration);
			if (brainFrame.blend.IsComplete)
			{
				brainFrame.blend.CamA = null;
				brainFrame.blend.BlendCurve = null;
				brainFrame.blend.Duration = 0f;
				brainFrame.blend.TimeInBlend = 0f;
			}
		}
	}

	public void ComputeCurrentBlend(ref CinemachineBlend outputBlend, int numTopLayersToExclude)
	{
		if (mFrameStack.Count == 0)
		{
			mFrameStack.Add(new BrainFrame());
		}
		int index = 0;
		int num = Mathf.Max(1, mFrameStack.Count - numTopLayersToExclude);
		for (int i = 0; i < num; i++)
		{
			BrainFrame brainFrame = mFrameStack[i];
			if (i != 0 && !brainFrame.Active)
			{
				continue;
			}
			brainFrame.workingBlend.CamA = brainFrame.blend.CamA;
			brainFrame.workingBlend.CamB = brainFrame.blend.CamB;
			brainFrame.workingBlend.BlendCurve = brainFrame.blend.BlendCurve;
			brainFrame.workingBlend.Duration = brainFrame.blend.Duration;
			brainFrame.workingBlend.TimeInBlend = brainFrame.blend.TimeInBlend;
			if (i > 0 && !brainFrame.blend.IsComplete)
			{
				if (brainFrame.workingBlend.CamA == null)
				{
					if (mFrameStack[index].blend.IsComplete)
					{
						brainFrame.workingBlend.CamA = mFrameStack[index].blend.CamB;
					}
					else
					{
						brainFrame.workingBlendSource.Blend = mFrameStack[index].workingBlend;
						brainFrame.workingBlend.CamA = brainFrame.workingBlendSource;
					}
				}
				else if (brainFrame.workingBlend.CamB == null)
				{
					if (mFrameStack[index].blend.IsComplete)
					{
						brainFrame.workingBlend.CamB = mFrameStack[index].blend.CamB;
					}
					else
					{
						brainFrame.workingBlendSource.Blend = mFrameStack[index].workingBlend;
						brainFrame.workingBlend.CamB = brainFrame.workingBlendSource;
					}
				}
			}
			index = i;
		}
		CinemachineBlend workingBlend = mFrameStack[index].workingBlend;
		outputBlend.CamA = workingBlend.CamA;
		outputBlend.CamB = workingBlend.CamB;
		outputBlend.BlendCurve = workingBlend.BlendCurve;
		outputBlend.Duration = workingBlend.Duration;
		outputBlend.TimeInBlend = workingBlend.TimeInBlend;
	}

	public bool IsLive(ICinemachineCamera vcam, bool dominantChildOnly = false)
	{
		if (SoloCamera == vcam)
		{
			return true;
		}
		if (mCurrentLiveCameras.Uses(vcam))
		{
			return true;
		}
		ICinemachineCamera parentCamera = vcam.ParentCamera;
		while (parentCamera != null && parentCamera.IsLiveChild(vcam, dominantChildOnly))
		{
			if (SoloCamera == parentCamera || mCurrentLiveCameras.Uses(parentCamera))
			{
				return true;
			}
			vcam = parentCamera;
			parentCamera = vcam.ParentCamera;
		}
		return false;
	}

	protected virtual ICinemachineCamera TopCameraFromPriorityQueue()
	{
		CinemachineCore instance = CinemachineCore.Instance;
		Camera outputCamera = OutputCamera;
		int num = ((outputCamera == null) ? (-1) : outputCamera.cullingMask);
		int virtualCameraCount = instance.VirtualCameraCount;
		for (int i = 0; i < virtualCameraCount; i++)
		{
			CinemachineVirtualCameraBase virtualCamera = instance.GetVirtualCamera(i);
			GameObject gameObject = ((virtualCamera != null) ? virtualCamera.gameObject : null);
			if (gameObject != null && (num & (1 << gameObject.layer)) != 0)
			{
				return virtualCamera;
			}
		}
		return null;
	}

	private CinemachineBlendDefinition LookupBlend(ICinemachineCamera fromKey, ICinemachineCamera toKey)
	{
		CinemachineBlendDefinition cinemachineBlendDefinition = m_DefaultBlend;
		if (m_CustomBlends != null)
		{
			string fromCameraName = ((fromKey != null) ? fromKey.Name : string.Empty);
			string toCameraName = ((toKey != null) ? toKey.Name : string.Empty);
			cinemachineBlendDefinition = m_CustomBlends.GetBlendForVirtualCameras(fromCameraName, toCameraName, cinemachineBlendDefinition);
		}
		if (CinemachineCore.GetBlendOverride != null)
		{
			cinemachineBlendDefinition = CinemachineCore.GetBlendOverride(fromKey, toKey, cinemachineBlendDefinition, this);
		}
		return cinemachineBlendDefinition;
	}

	private void PushStateToUnityCamera(ref CameraState state)
	{
		CurrentCameraState = state;
		Transform obj = ControlledObject.transform;
		Vector3 pos = obj.position;
		Quaternion rot = obj.rotation;
		if ((state.BlendHint & CameraState.BlendHintValue.NoPosition) == 0)
		{
			pos = state.FinalPosition;
		}
		if ((state.BlendHint & CameraState.BlendHintValue.NoOrientation) == 0)
		{
			rot = state.FinalOrientation;
		}
		obj.ConservativeSetPositionAndRotation(pos, rot);
		if ((state.BlendHint & CameraState.BlendHintValue.NoLens) == 0)
		{
			Camera outputCamera = OutputCamera;
			if (outputCamera != null)
			{
				outputCamera.nearClipPlane = state.Lens.NearClipPlane;
				outputCamera.farClipPlane = state.Lens.FarClipPlane;
				outputCamera.orthographicSize = state.Lens.OrthographicSize;
				outputCamera.fieldOfView = state.Lens.FieldOfView;
				outputCamera.lensShift = state.Lens.LensShift;
				if (state.Lens.ModeOverride != LensSettings.OverrideModes.None)
				{
					outputCamera.orthographic = state.Lens.Orthographic;
				}
				bool flag = (outputCamera.usePhysicalProperties = ((state.Lens.ModeOverride == LensSettings.OverrideModes.None) ? outputCamera.usePhysicalProperties : state.Lens.IsPhysicalCamera));
				if (flag && state.Lens.IsPhysicalCamera)
				{
					outputCamera.sensorSize = state.Lens.SensorSize;
					outputCamera.gateFit = state.Lens.GateFit;
					outputCamera.focalLength = Camera.FieldOfViewToFocalLength(state.Lens.FieldOfView, state.Lens.SensorSize.y);
				}
			}
		}
		if (CinemachineCore.CameraUpdatedEvent != null)
		{
			CinemachineCore.CameraUpdatedEvent.Invoke(this);
		}
	}
}
