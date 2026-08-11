using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Rendering;
using UnityEngine.Rendering.Universal;

namespace Cinemachine.PostFX;

[HelpURL("https://docs.unity3d.com/Packages/com.unity.cinemachine@2.9/manual/CinemachineVolumeSettings.html")]
[DisallowMultipleComponent]
[SaveDuringPlay]
[AddComponentMenu("")]
[ExecuteAlways]
[DocumentationSorting(DocumentationSortingAttribute.Level.UserRef)]
public class CinemachineVolumeSettings : CinemachineExtension
{
	public enum FocusTrackingMode
	{
		None,
		LookAtTarget,
		FollowTarget,
		CustomTarget,
		Camera
	}

	private class VcamExtraState
	{
		public VolumeProfile mProfileCopy;

		public void CreateProfileCopy(VolumeProfile source)
		{
			DestroyProfileCopy();
			VolumeProfile volumeProfile = ScriptableObject.CreateInstance<VolumeProfile>();
			if (source != null)
			{
				foreach (VolumeComponent component in source.components)
				{
					VolumeComponent item = Object.Instantiate(component);
					volumeProfile.components.Add(item);
					volumeProfile.isDirty = true;
				}
			}
			mProfileCopy = volumeProfile;
		}

		public void DestroyProfileCopy()
		{
			if (mProfileCopy != null)
			{
				RuntimeUtility.DestroyObject(mProfileCopy);
			}
			mProfileCopy = null;
		}
	}

	public static float s_VolumePriority = 1000f;

	[HideInInspector]
	public bool m_FocusTracksTarget;

	[Tooltip("If the profile has the appropriate overrides, will set the base focus distance to be the distance from the selected target to the camera.The Focus Offset field will then modify that distance.")]
	public FocusTrackingMode m_FocusTracking;

	[Tooltip("The target to use if Focus Tracks Target is set to Custom Target")]
	public Transform m_FocusTarget;

	[Tooltip("Offset from target distance, to be used with Focus Tracks Target.  Offsets the sharpest point away from the focus target.")]
	public float m_FocusOffset;

	[Tooltip("This profile will be applied whenever this virtual camera is live")]
	public VolumeProfile m_Profile;

	private static string sVolumeOwnerName = "__CMVolumes";

	private static List<Volume> sVolumes = new List<Volume>();

	public bool IsValid
	{
		get
		{
			if (m_Profile != null)
			{
				return m_Profile.components.Count > 0;
			}
			return false;
		}
	}

	public void InvalidateCachedProfile()
	{
		List<VcamExtraState> allExtraStates = GetAllExtraStates<VcamExtraState>();
		for (int i = 0; i < allExtraStates.Count; i++)
		{
			allExtraStates[i].DestroyProfileCopy();
		}
	}

	protected override void OnEnable()
	{
		base.OnEnable();
		if (m_FocusTracksTarget)
		{
			m_FocusTracking = ((base.VirtualCamera.LookAt != null) ? FocusTrackingMode.LookAtTarget : FocusTrackingMode.Camera);
		}
		m_FocusTracksTarget = false;
	}

	protected override void OnDestroy()
	{
		InvalidateCachedProfile();
		base.OnDestroy();
	}

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (stage != CinemachineCore.Stage.Finalize)
		{
			return;
		}
		VcamExtraState extraState = GetExtraState<VcamExtraState>(vcam);
		if (!IsValid)
		{
			extraState.DestroyProfileCopy();
			return;
		}
		VolumeProfile volumeProfile = m_Profile;
		if (m_FocusTracking == FocusTrackingMode.None)
		{
			extraState.DestroyProfileCopy();
		}
		else
		{
			if (extraState.mProfileCopy == null)
			{
				extraState.CreateProfileCopy(m_Profile);
			}
			volumeProfile = extraState.mProfileCopy;
			if (volumeProfile.TryGet<DepthOfField>(out DepthOfField component))
			{
				float num = m_FocusOffset;
				if (m_FocusTracking == FocusTrackingMode.LookAtTarget)
				{
					num += (state.FinalPosition - state.ReferenceLookAt).magnitude;
				}
				else
				{
					Transform transform = null;
					switch (m_FocusTracking)
					{
					case FocusTrackingMode.FollowTarget:
						transform = base.VirtualCamera.Follow;
						break;
					case FocusTrackingMode.CustomTarget:
						transform = m_FocusTarget;
						break;
					}
					if (transform != null)
					{
						num += (state.FinalPosition - transform.position).magnitude;
					}
				}
				component.focusDistance.value = Mathf.Max(0f, num);
				volumeProfile.isDirty = true;
			}
		}
		state.AddCustomBlendable(new CameraState.CustomBlendable(volumeProfile, 1f));
	}

	private static void OnCameraCut(CinemachineBrain brain)
	{
	}

	private static void ApplyPostFX(CinemachineBrain brain)
	{
		CameraState currentCameraState = brain.CurrentCameraState;
		int numCustomBlendables = currentCameraState.NumCustomBlendables;
		List<Volume> dynamicBrainVolumes = GetDynamicBrainVolumes(brain, numCustomBlendables);
		for (int i = 0; i < dynamicBrainVolumes.Count; i++)
		{
			dynamicBrainVolumes[i].weight = 0f;
			dynamicBrainVolumes[i].sharedProfile = null;
			dynamicBrainVolumes[i].profile = null;
		}
		Volume volume = null;
		int num = 0;
		for (int j = 0; j < numCustomBlendables; j++)
		{
			CameraState.CustomBlendable customBlendable = currentCameraState.GetCustomBlendable(j);
			VolumeProfile volumeProfile = customBlendable.m_Custom as VolumeProfile;
			if (!(volumeProfile == null))
			{
				Volume volume2 = dynamicBrainVolumes[j];
				if (volume == null)
				{
					volume = volume2;
				}
				volume2.sharedProfile = volumeProfile;
				volume2.isGlobal = true;
				volume2.priority = s_VolumePriority - (float)(numCustomBlendables - j) - 1f;
				volume2.weight = customBlendable.m_Weight;
				num++;
			}
		}
	}

	private static List<Volume> GetDynamicBrainVolumes(CinemachineBrain brain, int minVolumes)
	{
		GameObject gameObject = null;
		Transform transform = brain.transform;
		int childCount = transform.childCount;
		sVolumes.Clear();
		int num = 0;
		while (gameObject == null && num < childCount)
		{
			GameObject gameObject2 = transform.GetChild(num).gameObject;
			if (gameObject2.hideFlags == HideFlags.HideAndDontSave)
			{
				gameObject2.GetComponents(sVolumes);
				if (sVolumes.Count > 0)
				{
					gameObject = gameObject2;
				}
			}
			num++;
		}
		if (minVolumes > 0)
		{
			if (gameObject == null)
			{
				gameObject = new GameObject(sVolumeOwnerName);
				gameObject.hideFlags = HideFlags.HideAndDontSave;
				gameObject.transform.parent = transform;
			}
			UniversalAdditionalCameraData component = brain.gameObject.GetComponent<UniversalAdditionalCameraData>();
			if ((Object)(object)component != null)
			{
				int num2 = component.volumeLayerMask;
				for (int i = 0; i < 32; i++)
				{
					if ((num2 & (1 << i)) != 0)
					{
						gameObject.layer = i;
						break;
					}
				}
			}
			while (sVolumes.Count < minVolumes)
			{
				sVolumes.Add(gameObject.gameObject.AddComponent<Volume>());
			}
		}
		return sVolumes;
	}

	[RuntimeInitializeOnLoadMethod]
	private static void InitializeModule()
	{
		CinemachineCore.CameraUpdatedEvent.RemoveListener(ApplyPostFX);
		CinemachineCore.CameraUpdatedEvent.AddListener(ApplyPostFX);
		CinemachineCore.CameraCutEvent.RemoveListener(OnCameraCut);
		CinemachineCore.CameraCutEvent.AddListener(OnCameraCut);
	}
}
