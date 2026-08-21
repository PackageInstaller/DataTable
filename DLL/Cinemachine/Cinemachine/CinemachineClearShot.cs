using System;
using System.Collections.Generic;
using System.Text;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[ExcludeFromPreset]
[ExecuteAlways]
[DisallowMultipleComponent]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineClearShot.html")]
[AddComponentMenu("Cinemachine/CinemachineClearShot")]
public class CinemachineClearShot : CinemachineVirtualCameraBase
{
	private struct Pair
	{
		public int a;

		public float b;
	}

	[Tooltip("Default object for the camera children to look at (the aim target), if not specified in a child camera.  May be empty if all children specify targets of their own.")]
	[NoSaveDuringPlay]
	[VcamTargetProperty]
	public Transform m_LookAt;

	[Tooltip("Default object for the camera children wants to move with (the body target), if not specified in a child camera.  May be empty if all children specify targets of their own.")]
	[NoSaveDuringPlay]
	[VcamTargetProperty]
	public Transform m_Follow;

	[Tooltip("When enabled, the current child camera and blend will be indicated in the game window, for debugging")]
	[NoSaveDuringPlay]
	public bool m_ShowDebugText;

	[SerializeField]
	[HideInInspector]
	[NoSaveDuringPlay]
	internal CinemachineVirtualCameraBase[] m_ChildCameras;

	[Tooltip("Wait this many seconds before activating a new child camera")]
	public float m_ActivateAfter;

	[Tooltip("An active camera must be active for at least this many seconds")]
	public float m_MinDuration;

	[Tooltip("If checked, camera choice will be randomized if multiple cameras are equally desirable.  Otherwise, child list order and child camera priority will be used.")]
	public bool m_RandomizeChoice;

	[Tooltip("The blend which is used if you don't explicitly define a blend between two Virtual Cameras")]
	[CinemachineBlendDefinitionProperty]
	public CinemachineBlendDefinition m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);

	[HideInInspector]
	public CinemachineBlenderSettings m_CustomBlends;

	private CameraState m_State = CameraState.Default;

	private float mActivationTime;

	private float mPendingActivationTime;

	private ICinemachineCamera mPendingCamera;

	private CinemachineBlend mActiveBlend;

	private bool mRandomizeNow;

	private CinemachineVirtualCameraBase[] m_RandomizedChilden;

	private ICinemachineCamera m_TransitioningFrom;

	public override string Description
	{
		get
		{
			if (mActiveBlend != null)
			{
				return mActiveBlend.Description;
			}
			ICinemachineCamera liveChild = LiveChild;
			if (liveChild == null)
			{
				return "(none)";
			}
			StringBuilder stringBuilder = CinemachineDebug.SBFromPool();
			stringBuilder.Append("[");
			stringBuilder.Append(liveChild.Name);
			stringBuilder.Append("]");
			string result = stringBuilder.ToString();
			CinemachineDebug.ReturnToPool(stringBuilder);
			return result;
		}
	}

	public ICinemachineCamera LiveChild { get; set; }

	public override CameraState State => m_State;

	public override Transform LookAt
	{
		get
		{
			return ResolveLookAt(m_LookAt);
		}
		set
		{
			m_LookAt = value;
		}
	}

	public override Transform Follow
	{
		get
		{
			return ResolveFollow(m_Follow);
		}
		set
		{
			m_Follow = value;
		}
	}

	public bool IsBlending => mActiveBlend != null;

	public CinemachineBlend ActiveBlend => mActiveBlend;

	public CinemachineVirtualCameraBase[] ChildCameras
	{
		get
		{
			UpdateListOfChildren();
			return m_ChildCameras;
		}
	}

	public override bool IsLiveChild(ICinemachineCamera vcam, bool dominantChildOnly = false)
	{
		if (vcam != LiveChild)
		{
			if (mActiveBlend != null)
			{
				return mActiveBlend.Uses(vcam);
			}
			return false;
		}
		return true;
	}

	public override void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
		UpdateListOfChildren();
		CinemachineVirtualCameraBase[] childCameras = m_ChildCameras;
		for (int i = 0; i < childCameras.Length; i++)
		{
			childCameras[i].OnTargetObjectWarped(target, positionDelta);
		}
		base.OnTargetObjectWarped(target, positionDelta);
	}

	public override void ForceCameraPosition(Vector3 pos, Quaternion rot)
	{
		UpdateListOfChildren();
		CinemachineVirtualCameraBase[] childCameras = m_ChildCameras;
		for (int i = 0; i < childCameras.Length; i++)
		{
			childCameras[i].ForceCameraPosition(pos, rot);
		}
		base.ForceCameraPosition(pos, rot);
	}

	public override void InternalUpdateCameraState(Vector3 worldUp, float deltaTime)
	{
		UpdateListOfChildren();
		ICinemachineCamera liveChild = LiveChild;
		LiveChild = ChooseCurrentCamera(worldUp);
		if (liveChild != LiveChild && LiveChild != null)
		{
			LiveChild.OnTransitionFromCamera(liveChild, worldUp, deltaTime);
			CinemachineCore.Instance.GenerateCameraActivationEvent(LiveChild, liveChild);
			if (liveChild != null)
			{
				mActiveBlend = CreateBlend(liveChild, LiveChild, LookupBlend(liveChild, LiveChild), mActiveBlend);
				if (mActiveBlend == null || !mActiveBlend.Uses(liveChild))
				{
					CinemachineCore.Instance.GenerateCameraCutEvent(LiveChild);
				}
			}
		}
		if (mActiveBlend != null)
		{
			mActiveBlend.TimeInBlend += ((deltaTime >= 0f) ? deltaTime : mActiveBlend.Duration);
			if (mActiveBlend.IsComplete)
			{
				mActiveBlend = null;
			}
		}
		if (mActiveBlend != null)
		{
			mActiveBlend.UpdateCameraState(worldUp, deltaTime);
			m_State = mActiveBlend.State;
		}
		else if (LiveChild != null)
		{
			if (m_TransitioningFrom != null)
			{
				LiveChild.OnTransitionFromCamera(m_TransitioningFrom, worldUp, deltaTime);
			}
			m_State = LiveChild.State;
		}
		m_TransitioningFrom = null;
		InvokePostPipelineStageCallback(this, CinemachineCore.Stage.Finalize, ref m_State, deltaTime);
		PreviousStateIsValid = true;
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		InvalidateListOfChildren();
		mActiveBlend = null;
		CinemachineDebug.OnGUIHandlers = (CinemachineDebug.OnGUIDelegate)Delegate.Remove(CinemachineDebug.OnGUIHandlers, new CinemachineDebug.OnGUIDelegate(OnGuiHandler));
		CinemachineDebug.OnGUIHandlers = (CinemachineDebug.OnGUIDelegate)Delegate.Combine(CinemachineDebug.OnGUIHandlers, new CinemachineDebug.OnGUIDelegate(OnGuiHandler));
	}

	protected override void OnDisable()
	{
		base.OnDisable();
		CinemachineDebug.OnGUIHandlers = (CinemachineDebug.OnGUIDelegate)Delegate.Remove(CinemachineDebug.OnGUIHandlers, new CinemachineDebug.OnGUIDelegate(OnGuiHandler));
	}

	public void OnTransformChildrenChanged()
	{
		InvalidateListOfChildren();
		UpdateListOfChildren();
	}

	private void OnGuiHandler()
	{
		if (!m_ShowDebugText)
		{
			CinemachineDebug.ReleaseScreenPos(this);
			return;
		}
		StringBuilder stringBuilder = CinemachineDebug.SBFromPool();
		stringBuilder.Append(base.Name);
		stringBuilder.Append(": ");
		stringBuilder.Append(Description);
		string text = stringBuilder.ToString();
		GUI.Label(CinemachineDebug.GetScreenPos(this, text, GUI.skin.box), text, GUI.skin.box);
		CinemachineDebug.ReturnToPool(stringBuilder);
	}

	private void InvalidateListOfChildren()
	{
		m_ChildCameras = null;
		m_RandomizedChilden = null;
		LiveChild = null;
	}

	public void ResetRandomization()
	{
		m_RandomizedChilden = null;
		mRandomizeNow = true;
	}

	private void UpdateListOfChildren()
	{
		if (m_ChildCameras != null)
		{
			return;
		}
		List<CinemachineVirtualCameraBase> list = new List<CinemachineVirtualCameraBase>();
		CinemachineVirtualCameraBase[] componentsInChildren = GetComponentsInChildren<CinemachineVirtualCameraBase>(includeInactive: true);
		foreach (CinemachineVirtualCameraBase cinemachineVirtualCameraBase in componentsInChildren)
		{
			if (cinemachineVirtualCameraBase.transform.parent == base.transform)
			{
				list.Add(cinemachineVirtualCameraBase);
			}
		}
		m_ChildCameras = list.ToArray();
		mActivationTime = (mPendingActivationTime = 0f);
		mPendingCamera = null;
		LiveChild = null;
		mActiveBlend = null;
	}

	private ICinemachineCamera ChooseCurrentCamera(Vector3 worldUp)
	{
		if (m_ChildCameras == null || m_ChildCameras.Length == 0)
		{
			mActivationTime = 0f;
			return null;
		}
		CinemachineVirtualCameraBase[] array = m_ChildCameras;
		if (!m_RandomizeChoice)
		{
			m_RandomizedChilden = null;
		}
		else if (m_ChildCameras.Length > 1)
		{
			if (m_RandomizedChilden == null)
			{
				m_RandomizedChilden = Randomize(m_ChildCameras);
			}
			array = m_RandomizedChilden;
		}
		if (LiveChild != null && !LiveChild.VirtualCameraGameObject.activeSelf)
		{
			LiveChild = null;
		}
		ICinemachineCamera cinemachineCamera = LiveChild;
		foreach (CinemachineVirtualCameraBase cinemachineVirtualCameraBase in array)
		{
			if (cinemachineVirtualCameraBase != null && cinemachineVirtualCameraBase.gameObject.activeInHierarchy && (cinemachineCamera == null || cinemachineVirtualCameraBase.State.ShotQuality > cinemachineCamera.State.ShotQuality || (cinemachineVirtualCameraBase.State.ShotQuality == cinemachineCamera.State.ShotQuality && cinemachineVirtualCameraBase.Priority > cinemachineCamera.Priority) || (m_RandomizeChoice && mRandomizeNow && cinemachineVirtualCameraBase != LiveChild && cinemachineVirtualCameraBase.State.ShotQuality == cinemachineCamera.State.ShotQuality && cinemachineVirtualCameraBase.Priority == cinemachineCamera.Priority)))
			{
				cinemachineCamera = cinemachineVirtualCameraBase;
			}
		}
		mRandomizeNow = false;
		float currentTime = CinemachineCore.CurrentTime;
		if (mActivationTime != 0f)
		{
			if (LiveChild == cinemachineCamera)
			{
				mPendingActivationTime = 0f;
				mPendingCamera = null;
				return cinemachineCamera;
			}
			if (PreviousStateIsValid && mPendingActivationTime != 0f && mPendingCamera == cinemachineCamera)
			{
				if (currentTime - mPendingActivationTime > m_ActivateAfter && currentTime - mActivationTime > m_MinDuration)
				{
					m_RandomizedChilden = null;
					mActivationTime = currentTime;
					mPendingActivationTime = 0f;
					mPendingCamera = null;
					return cinemachineCamera;
				}
				return LiveChild;
			}
		}
		mPendingActivationTime = 0f;
		mPendingCamera = null;
		if (PreviousStateIsValid && mActivationTime > 0f && (m_ActivateAfter > 0f || currentTime - mActivationTime < m_MinDuration))
		{
			mPendingCamera = cinemachineCamera;
			mPendingActivationTime = currentTime;
			return LiveChild;
		}
		m_RandomizedChilden = null;
		mActivationTime = currentTime;
		return cinemachineCamera;
	}

	private CinemachineVirtualCameraBase[] Randomize(CinemachineVirtualCameraBase[] src)
	{
		List<Pair> list = new List<Pair>();
		for (int i = 0; i < src.Length; i++)
		{
			list.Add(new Pair
			{
				a = i,
				b = UnityEngine.Random.Range(0f, 1000f)
			});
		}
		list.Sort((Pair p1, Pair p2) => (int)p1.b - (int)p2.b);
		CinemachineVirtualCameraBase[] array = new CinemachineVirtualCameraBase[src.Length];
		Pair[] array2 = list.ToArray();
		for (int num = 0; num < src.Length; num++)
		{
			array[num] = src[array2[num].a];
		}
		return array;
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

	public override void OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime)
	{
		base.OnTransitionFromCamera(fromCam, worldUp, deltaTime);
		InvokeOnTransitionInExtensions(fromCam, worldUp, deltaTime);
		m_TransitioningFrom = fromCam;
		if (m_RandomizeChoice && mActiveBlend == null)
		{
			m_RandomizedChilden = null;
			LiveChild = null;
		}
		InternalUpdateCameraState(worldUp, deltaTime);
	}
}
