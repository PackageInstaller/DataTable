using System;
using System.Collections.Generic;
using System.Text;
using Cinemachine.Utility;
using UnityEngine;

namespace Cinemachine;

[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
[DisallowMultipleComponent]
[AddComponentMenu("Cinemachine/CinemachineStateDrivenCamera")]
[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineStateDrivenCamera.html")]
[ExecuteAlways]
[ExcludeFromPreset]
public class CinemachineStateDrivenCamera : CinemachineVirtualCameraBase
{
	[Serializable]
	public struct Instruction
	{
		[Tooltip("The full hash of the animation state")]
		public int m_FullHash;

		[Tooltip("The virtual camera to activate when the animation state becomes active")]
		public CinemachineVirtualCameraBase m_VirtualCamera;

		[Tooltip("How long to wait (in seconds) before activating the virtual camera. This filters out very short state durations")]
		public float m_ActivateAfter;

		[Tooltip("The minimum length of time (in seconds) to keep a virtual camera active")]
		public float m_MinDuration;
	}

	[Serializable]
	[DocumentationSorting(DocumentationSortingAttribute.Level.Undoc)]
	internal struct ParentHash(int h, int p)
	{
		public int m_Hash = h;

		public int m_ParentHash = p;
	}

	private struct HashPair
	{
		public int parentHash;

		public int hash;
	}

	[NoSaveDuringPlay]
	[VcamTargetProperty]
	[Tooltip("Default object for the camera children to look at (the aim target), if not specified in a child camera.  May be empty if all of the children define targets of their own.")]
	public Transform m_LookAt;

	[Tooltip("Default object for the camera children wants to move with (the body target), if not specified in a child camera.  May be empty if all of the children define targets of their own.")]
	[NoSaveDuringPlay]
	[VcamTargetProperty]
	public Transform m_Follow;

	[Space]
	[Tooltip("The state machine whose state changes will drive this camera's choice of active child")]
	[NoSaveDuringPlay]
	public Animator m_AnimatedTarget;

	[NoSaveDuringPlay]
	[Tooltip("Which layer in the target state machine to observe")]
	public int m_LayerIndex;

	[Tooltip("When enabled, the current child camera and blend will be indicated in the game window, for debugging")]
	public bool m_ShowDebugText;

	[NoSaveDuringPlay]
	[HideInInspector]
	[SerializeField]
	internal CinemachineVirtualCameraBase[] m_ChildCameras;

	[Tooltip("The set of instructions associating virtual cameras with states.  These instructions are used to choose the live child at any given moment")]
	public Instruction[] m_Instructions;

	[CinemachineBlendDefinitionProperty]
	[Tooltip("The blend which is used if you don't explicitly define a blend between two Virtual Camera children")]
	public CinemachineBlendDefinition m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseInOut, 0.5f);

	[Tooltip("This is the asset which contains custom settings for specific child blends")]
	public CinemachineBlenderSettings m_CustomBlends;

	[SerializeField]
	[HideInInspector]
	internal ParentHash[] m_ParentHash;

	private ICinemachineCamera m_TransitioningFrom;

	private CameraState m_State = CameraState.Default;

	private Dictionary<AnimationClip, List<HashPair>> mHashCache;

	private float mActivationTime;

	private Instruction mActiveInstruction;

	private float mPendingActivationTime;

	private Instruction mPendingInstruction;

	private CinemachineBlend mActiveBlend;

	private Dictionary<int, int> mInstructionDictionary;

	private Dictionary<int, int> mStateParentLookup;

	private List<AnimatorClipInfo> m_clipInfoList = new List<AnimatorClipInfo>();

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

	public CinemachineVirtualCameraBase[] ChildCameras
	{
		get
		{
			UpdateListOfChildren();
			return m_ChildCameras;
		}
	}

	public bool IsBlending => mActiveBlend != null;

	public CinemachineBlend ActiveBlend => mActiveBlend;

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

	public override void OnTransitionFromCamera(ICinemachineCamera fromCam, Vector3 worldUp, float deltaTime)
	{
		base.OnTransitionFromCamera(fromCam, worldUp, deltaTime);
		InvokeOnTransitionInExtensions(fromCam, worldUp, deltaTime);
		m_TransitioningFrom = fromCam;
		InternalUpdateCameraState(worldUp, deltaTime);
	}

	public override void InternalUpdateCameraState(Vector3 worldUp, float deltaTime)
	{
		UpdateListOfChildren();
		CinemachineVirtualCameraBase cinemachineVirtualCameraBase = ChooseCurrentCamera();
		if (cinemachineVirtualCameraBase != null && !cinemachineVirtualCameraBase.gameObject.activeInHierarchy)
		{
			cinemachineVirtualCameraBase.gameObject.SetActive(value: true);
			cinemachineVirtualCameraBase.UpdateCameraState(worldUp, deltaTime);
		}
		ICinemachineCamera liveChild = LiveChild;
		LiveChild = cinemachineVirtualCameraBase;
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

	public static int CreateFakeHash(int parentHash, AnimationClip clip)
	{
		return Animator.StringToHash(parentHash + "_" + ((UnityEngine.Object)(object)clip).name);
	}

	private int LookupFakeHash(int parentHash, AnimationClip clip)
	{
		if (mHashCache == null)
		{
			mHashCache = new Dictionary<AnimationClip, List<HashPair>>();
		}
		List<HashPair> value = null;
		if (!mHashCache.TryGetValue(clip, out value))
		{
			value = new List<HashPair>();
			mHashCache[clip] = value;
		}
		for (int i = 0; i < value.Count; i++)
		{
			if (value[i].parentHash == parentHash)
			{
				return value[i].hash;
			}
		}
		int num = CreateFakeHash(parentHash, clip);
		value.Add(new HashPair
		{
			parentHash = parentHash,
			hash = num
		});
		mStateParentLookup[num] = parentHash;
		return num;
	}

	private void InvalidateListOfChildren()
	{
		m_ChildCameras = null;
		LiveChild = null;
	}

	private void UpdateListOfChildren()
	{
		if (m_ChildCameras != null && mInstructionDictionary != null && mStateParentLookup != null)
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
		ValidateInstructions();
	}

	internal void ValidateInstructions()
	{
		if (m_Instructions == null)
		{
			m_Instructions = Array.Empty<Instruction>();
		}
		mInstructionDictionary = new Dictionary<int, int>();
		for (int i = 0; i < m_Instructions.Length; i++)
		{
			if (m_Instructions[i].m_VirtualCamera != null && m_Instructions[i].m_VirtualCamera.transform.parent != base.transform)
			{
				m_Instructions[i].m_VirtualCamera = null;
			}
			mInstructionDictionary[m_Instructions[i].m_FullHash] = i;
		}
		mStateParentLookup = new Dictionary<int, int>();
		if (m_ParentHash != null)
		{
			ParentHash[] parentHash = m_ParentHash;
			for (int j = 0; j < parentHash.Length; j++)
			{
				ParentHash parentHash2 = parentHash[j];
				mStateParentLookup[parentHash2.m_Hash] = parentHash2.m_ParentHash;
			}
		}
		mHashCache = null;
		mActivationTime = (mPendingActivationTime = 0f);
		mActiveBlend = null;
	}

	private CinemachineVirtualCameraBase ChooseCurrentCamera()
	{
		//IL_00ef: Unknown result type (might be due to invalid IL or missing references)
		//IL_00f4: Unknown result type (might be due to invalid IL or missing references)
		//IL_00af: Unknown result type (might be due to invalid IL or missing references)
		//IL_00b4: Unknown result type (might be due to invalid IL or missing references)
		if (m_ChildCameras == null || m_ChildCameras.Length == 0)
		{
			mActivationTime = 0f;
			return null;
		}
		CinemachineVirtualCameraBase cinemachineVirtualCameraBase = m_ChildCameras[0];
		if ((UnityEngine.Object)(object)m_AnimatedTarget == null || !((Component)(object)m_AnimatedTarget).gameObject.activeSelf || (UnityEngine.Object)(object)m_AnimatedTarget.runtimeAnimatorController == null || m_LayerIndex < 0 || !m_AnimatedTarget.hasBoundPlayables || m_LayerIndex >= m_AnimatedTarget.layerCount)
		{
			mActivationTime = 0f;
			return cinemachineVirtualCameraBase;
		}
		int num;
		if (m_AnimatedTarget.IsInTransition(m_LayerIndex))
		{
			AnimatorStateInfo nextAnimatorStateInfo = m_AnimatedTarget.GetNextAnimatorStateInfo(m_LayerIndex);
			m_AnimatedTarget.GetNextAnimatorClipInfo(m_LayerIndex, m_clipInfoList);
			num = GetClipHash(((AnimatorStateInfo)(ref nextAnimatorStateInfo)).fullPathHash, m_clipInfoList);
		}
		else
		{
			AnimatorStateInfo currentAnimatorStateInfo = m_AnimatedTarget.GetCurrentAnimatorStateInfo(m_LayerIndex);
			m_AnimatedTarget.GetCurrentAnimatorClipInfo(m_LayerIndex, m_clipInfoList);
			num = GetClipHash(((AnimatorStateInfo)(ref currentAnimatorStateInfo)).fullPathHash, m_clipInfoList);
		}
		while (num != 0 && !mInstructionDictionary.ContainsKey(num))
		{
			num = (mStateParentLookup.ContainsKey(num) ? mStateParentLookup[num] : 0);
		}
		float currentTime = CinemachineCore.CurrentTime;
		if (mActivationTime != 0f)
		{
			if (mActiveInstruction.m_FullHash == num)
			{
				mPendingActivationTime = 0f;
				return mActiveInstruction.m_VirtualCamera;
			}
			if (PreviousStateIsValid && mPendingActivationTime != 0f && mPendingInstruction.m_FullHash == num)
			{
				if (currentTime - mPendingActivationTime > mPendingInstruction.m_ActivateAfter && (currentTime - mActivationTime > mActiveInstruction.m_MinDuration || mPendingInstruction.m_VirtualCamera.Priority > mActiveInstruction.m_VirtualCamera.Priority))
				{
					mActiveInstruction = mPendingInstruction;
					mActivationTime = currentTime;
					mPendingActivationTime = 0f;
				}
				return mActiveInstruction.m_VirtualCamera;
			}
		}
		mPendingActivationTime = 0f;
		if (!mInstructionDictionary.ContainsKey(num))
		{
			if (mActivationTime != 0f)
			{
				return mActiveInstruction.m_VirtualCamera;
			}
			return cinemachineVirtualCameraBase;
		}
		Instruction instruction = m_Instructions[mInstructionDictionary[num]];
		if (instruction.m_VirtualCamera == null)
		{
			instruction.m_VirtualCamera = cinemachineVirtualCameraBase;
		}
		if (PreviousStateIsValid && mActivationTime > 0f && (instruction.m_ActivateAfter > 0f || (currentTime - mActivationTime < mActiveInstruction.m_MinDuration && instruction.m_VirtualCamera.Priority <= mActiveInstruction.m_VirtualCamera.Priority)))
		{
			mPendingInstruction = instruction;
			mPendingActivationTime = currentTime;
			if (mActivationTime != 0f)
			{
				return mActiveInstruction.m_VirtualCamera;
			}
			return cinemachineVirtualCameraBase;
		}
		mActiveInstruction = instruction;
		mActivationTime = currentTime;
		return mActiveInstruction.m_VirtualCamera;
	}

	private int GetClipHash(int hash, List<AnimatorClipInfo> clips)
	{
		//IL_000c: Unknown result type (might be due to invalid IL or missing references)
		//IL_0011: Unknown result type (might be due to invalid IL or missing references)
		//IL_001b: Unknown result type (might be due to invalid IL or missing references)
		//IL_0020: Unknown result type (might be due to invalid IL or missing references)
		//IL_003f: Unknown result type (might be due to invalid IL or missing references)
		//IL_0044: Unknown result type (might be due to invalid IL or missing references)
		//IL_0057: Unknown result type (might be due to invalid IL or missing references)
		//IL_005c: Unknown result type (might be due to invalid IL or missing references)
		int num = -1;
		AnimatorClipInfo val;
		for (int i = 0; i < clips.Count; i++)
		{
			if (num >= 0)
			{
				val = clips[i];
				float weight = ((AnimatorClipInfo)(ref val)).weight;
				val = clips[num];
				if (!(weight > ((AnimatorClipInfo)(ref val)).weight))
				{
					continue;
				}
			}
			num = i;
		}
		if (num >= 0)
		{
			val = clips[num];
			if (((AnimatorClipInfo)(ref val)).weight > 0f)
			{
				int parentHash = hash;
				val = clips[num];
				hash = LookupFakeHash(parentHash, ((AnimatorClipInfo)(ref val)).clip);
			}
		}
		return hash;
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
}
