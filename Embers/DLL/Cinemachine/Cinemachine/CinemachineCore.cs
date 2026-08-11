using System.Collections.Generic;
using UnityEngine;

namespace Cinemachine;

public sealed class CinemachineCore
{
	public enum Stage
	{
		Body,
		Aim,
		Noise,
		Finalize
	}

	public delegate float AxisInputDelegate(string axisName);

	public delegate CinemachineBlendDefinition GetBlendOverrideDelegate(ICinemachineCamera fromVcam, ICinemachineCamera toVcam, CinemachineBlendDefinition defaultBlend, MonoBehaviour owner);

	private class UpdateStatus
	{
		public int lastUpdateFrame;

		public int lastUpdateFixedFrame;

		public UpdateTracker.UpdateClock lastUpdateMode;

		public float lastUpdateDeltaTime;
	}

	internal enum UpdateFilter
	{
		Fixed = 0,
		Late = 1,
		Smart = 8,
		SmartFixed = Smart,
		SmartLate = 9
	}

	public static readonly int kStreamingVersion = 20170927;

	private static CinemachineCore sInstance = null;

	public static bool sShowHiddenObjects = false;

	public static AxisInputDelegate GetInputAxis = Input.GetAxis;

	public static float UniformDeltaTimeOverride = -1f;

	public static float CurrentTimeOverride = -1f;

	public static GetBlendOverrideDelegate GetBlendOverride;

	public static CinemachineBrain.BrainEvent CameraUpdatedEvent = new CinemachineBrain.BrainEvent();

	public static CinemachineBrain.BrainEvent CameraCutEvent = new CinemachineBrain.BrainEvent();

	private List<CinemachineBrain> mActiveBrains = new List<CinemachineBrain>();

	internal static bool FrameDeltaCompensationEnabled = true;

	private List<CinemachineVirtualCameraBase> mActiveCameras = new List<CinemachineVirtualCameraBase>();

	private bool m_ActiveCamerasAreSorted;

	private int m_ActivationSequence;

	private List<List<CinemachineVirtualCameraBase>> mAllCameras = new List<List<CinemachineVirtualCameraBase>>();

	private CinemachineVirtualCameraBase mRoundRobinVcamLastFrame;

	private static float s_LastUpdateTime;

	private static int s_FixedFrameCount;

	private Dictionary<CinemachineVirtualCameraBase, UpdateStatus> mUpdateStatus;

	internal UpdateFilter m_CurrentUpdateFilter;

	public static CinemachineCore Instance
	{
		get
		{
			if (sInstance == null)
			{
				sInstance = new CinemachineCore();
			}
			return sInstance;
		}
	}

	public static float DeltaTime
	{
		get
		{
			if (!(UniformDeltaTimeOverride >= 0f))
			{
				return Time.deltaTime;
			}
			return UniformDeltaTimeOverride;
		}
	}

	public static float CurrentTime
	{
		get
		{
			if (!(CurrentTimeOverride >= 0f))
			{
				return Time.time;
			}
			return CurrentTimeOverride;
		}
	}

	public int BrainCount => mActiveBrains.Count;

	public int VirtualCameraCount => mActiveCameras.Count;

	public CinemachineBrain GetActiveBrain(int index)
	{
		return mActiveBrains[index];
	}

	internal void AddActiveBrain(CinemachineBrain brain)
	{
		RemoveActiveBrain(brain);
		mActiveBrains.Insert(0, brain);
	}

	internal void RemoveActiveBrain(CinemachineBrain brain)
	{
		mActiveBrains.Remove(brain);
	}

	public CinemachineVirtualCameraBase GetVirtualCamera(int index)
	{
		if (!m_ActiveCamerasAreSorted && mActiveCameras.Count > 1)
		{
			mActiveCameras.Sort((CinemachineVirtualCameraBase x, CinemachineVirtualCameraBase y) => (x.Priority != y.Priority) ? y.Priority.CompareTo(x.Priority) : y.m_ActivationId.CompareTo(x.m_ActivationId));
			m_ActiveCamerasAreSorted = true;
		}
		return mActiveCameras[index];
	}

	internal void AddActiveCamera(CinemachineVirtualCameraBase vcam)
	{
		vcam.m_ActivationId = m_ActivationSequence++;
		mActiveCameras.Add(vcam);
		m_ActiveCamerasAreSorted = false;
	}

	internal void RemoveActiveCamera(CinemachineVirtualCameraBase vcam)
	{
		if (mActiveCameras.Contains(vcam))
		{
			mActiveCameras.Remove(vcam);
		}
	}

	internal void CameraDestroyed(CinemachineVirtualCameraBase vcam)
	{
		if (mActiveCameras.Contains(vcam))
		{
			mActiveCameras.Remove(vcam);
		}
		if (mUpdateStatus != null && mUpdateStatus.ContainsKey(vcam))
		{
			mUpdateStatus.Remove(vcam);
		}
	}

	internal void CameraEnabled(CinemachineVirtualCameraBase vcam)
	{
		int num = 0;
		for (ICinemachineCamera parentCamera = vcam.ParentCamera; parentCamera != null; parentCamera = parentCamera.ParentCamera)
		{
			num++;
		}
		while (mAllCameras.Count <= num)
		{
			mAllCameras.Add(new List<CinemachineVirtualCameraBase>());
		}
		mAllCameras[num].Add(vcam);
	}

	internal void CameraDisabled(CinemachineVirtualCameraBase vcam)
	{
		for (int i = 0; i < mAllCameras.Count; i++)
		{
			mAllCameras[i].Remove(vcam);
		}
		if (mRoundRobinVcamLastFrame == vcam)
		{
			mRoundRobinVcamLastFrame = null;
		}
	}

	internal void UpdateAllActiveVirtualCameras(int layerMask, Vector3 worldUp, float deltaTime)
	{
		UpdateFilter currentUpdateFilter = m_CurrentUpdateFilter;
		bool flag = currentUpdateFilter != UpdateFilter.Smart;
		CinemachineVirtualCameraBase cinemachineVirtualCameraBase = mRoundRobinVcamLastFrame;
		float currentTime = CurrentTime;
		if (currentTime != s_LastUpdateTime)
		{
			s_LastUpdateTime = currentTime;
			if ((currentUpdateFilter & (UpdateFilter)(-9)) == 0)
			{
				s_FixedFrameCount++;
			}
		}
		for (int num = mAllCameras.Count - 1; num >= 0; num--)
		{
			List<CinemachineVirtualCameraBase> list = mAllCameras[num];
			for (int num2 = list.Count - 1; num2 >= 0; num2--)
			{
				CinemachineVirtualCameraBase cinemachineVirtualCameraBase2 = list[num2];
				if (flag && cinemachineVirtualCameraBase2 == mRoundRobinVcamLastFrame)
				{
					cinemachineVirtualCameraBase = null;
				}
				if (cinemachineVirtualCameraBase2 == null)
				{
					list.RemoveAt(num2);
				}
				else if (cinemachineVirtualCameraBase2.m_StandbyUpdate == CinemachineVirtualCameraBase.StandbyUpdateMode.Always || IsLive(cinemachineVirtualCameraBase2))
				{
					if (((1 << cinemachineVirtualCameraBase2.gameObject.layer) & layerMask) != 0)
					{
						UpdateVirtualCamera(cinemachineVirtualCameraBase2, worldUp, deltaTime);
					}
				}
				else if (((cinemachineVirtualCameraBase == null && mRoundRobinVcamLastFrame != cinemachineVirtualCameraBase2) & flag) && cinemachineVirtualCameraBase2.m_StandbyUpdate != CinemachineVirtualCameraBase.StandbyUpdateMode.Never && cinemachineVirtualCameraBase2.isActiveAndEnabled)
				{
					m_CurrentUpdateFilter &= (UpdateFilter)(-9);
					UpdateVirtualCamera(cinemachineVirtualCameraBase2, worldUp, deltaTime);
					m_CurrentUpdateFilter = currentUpdateFilter;
					cinemachineVirtualCameraBase = cinemachineVirtualCameraBase2;
				}
			}
		}
		if (flag)
		{
			if (cinemachineVirtualCameraBase == mRoundRobinVcamLastFrame)
			{
				cinemachineVirtualCameraBase = null;
			}
			mRoundRobinVcamLastFrame = cinemachineVirtualCameraBase;
		}
	}

	internal void UpdateVirtualCamera(CinemachineVirtualCameraBase vcam, Vector3 worldUp, float deltaTime)
	{
		if (vcam == null)
		{
			return;
		}
		bool num = (m_CurrentUpdateFilter & UpdateFilter.Smart) == UpdateFilter.Smart;
		UpdateTracker.UpdateClock updateClock = (UpdateTracker.UpdateClock)(m_CurrentUpdateFilter & (UpdateFilter)(-9));
		if (num)
		{
			Transform updateTarget = GetUpdateTarget(vcam);
			if (updateTarget == null || UpdateTracker.GetPreferredUpdate(updateTarget) != updateClock)
			{
				return;
			}
		}
		if (mUpdateStatus == null)
		{
			mUpdateStatus = new Dictionary<CinemachineVirtualCameraBase, UpdateStatus>();
		}
		if (!mUpdateStatus.TryGetValue(vcam, out var value))
		{
			value = new UpdateStatus
			{
				lastUpdateDeltaTime = -2f,
				lastUpdateMode = UpdateTracker.UpdateClock.Late,
				lastUpdateFrame = Time.frameCount + 2,
				lastUpdateFixedFrame = s_FixedFrameCount + 2
			};
			mUpdateStatus.Add(vcam, value);
		}
		int num2 = ((updateClock == UpdateTracker.UpdateClock.Late) ? (Time.frameCount - value.lastUpdateFrame) : (s_FixedFrameCount - value.lastUpdateFixedFrame));
		if (deltaTime >= 0f)
		{
			if (num2 == 0 && value.lastUpdateMode == updateClock && value.lastUpdateDeltaTime == deltaTime)
			{
				return;
			}
			if (FrameDeltaCompensationEnabled && num2 > 0)
			{
				deltaTime *= (float)num2;
			}
		}
		vcam.InternalUpdateCameraState(worldUp, deltaTime);
		value.lastUpdateFrame = Time.frameCount;
		value.lastUpdateFixedFrame = s_FixedFrameCount;
		value.lastUpdateMode = updateClock;
		value.lastUpdateDeltaTime = deltaTime;
	}

	[RuntimeInitializeOnLoadMethod]
	private static void InitializeModule()
	{
		Instance.mUpdateStatus = new Dictionary<CinemachineVirtualCameraBase, UpdateStatus>();
	}

	private static Transform GetUpdateTarget(CinemachineVirtualCameraBase vcam)
	{
		if (vcam == null || vcam.gameObject == null)
		{
			return null;
		}
		Transform lookAt = vcam.LookAt;
		if (lookAt != null)
		{
			return lookAt;
		}
		lookAt = vcam.Follow;
		if (lookAt != null)
		{
			return lookAt;
		}
		return vcam.transform;
	}

	internal UpdateTracker.UpdateClock GetVcamUpdateStatus(CinemachineVirtualCameraBase vcam)
	{
		if (mUpdateStatus == null || !mUpdateStatus.TryGetValue(vcam, out var value))
		{
			return UpdateTracker.UpdateClock.Late;
		}
		return value.lastUpdateMode;
	}

	public bool IsLive(ICinemachineCamera vcam)
	{
		if (vcam != null)
		{
			for (int i = 0; i < BrainCount; i++)
			{
				CinemachineBrain activeBrain = GetActiveBrain(i);
				if (activeBrain != null && activeBrain.IsLive(vcam))
				{
					return true;
				}
			}
		}
		return false;
	}

	public bool IsLiveInBlend(ICinemachineCamera vcam)
	{
		if (vcam != null)
		{
			for (int i = 0; i < BrainCount; i++)
			{
				CinemachineBrain activeBrain = GetActiveBrain(i);
				if (activeBrain != null && activeBrain.IsLiveInBlend(vcam))
				{
					return true;
				}
			}
		}
		return false;
	}

	public void GenerateCameraActivationEvent(ICinemachineCamera vcam, ICinemachineCamera vcamFrom)
	{
		if (vcam == null)
		{
			return;
		}
		for (int i = 0; i < BrainCount; i++)
		{
			CinemachineBrain activeBrain = GetActiveBrain(i);
			if (activeBrain != null && activeBrain.IsLive(vcam))
			{
				activeBrain.m_CameraActivatedEvent.Invoke(vcam, vcamFrom);
			}
		}
	}

	public void GenerateCameraCutEvent(ICinemachineCamera vcam)
	{
		if (vcam == null)
		{
			return;
		}
		for (int i = 0; i < BrainCount; i++)
		{
			CinemachineBrain activeBrain = GetActiveBrain(i);
			if (activeBrain != null && activeBrain.IsLive(vcam))
			{
				if (activeBrain.m_CameraCutEvent != null)
				{
					activeBrain.m_CameraCutEvent.Invoke(activeBrain);
				}
				if (CameraCutEvent != null)
				{
					CameraCutEvent.Invoke(activeBrain);
				}
			}
		}
	}

	public CinemachineBrain FindPotentialTargetBrain(CinemachineVirtualCameraBase vcam)
	{
		if (vcam != null)
		{
			int brainCount = BrainCount;
			for (int i = 0; i < brainCount; i++)
			{
				CinemachineBrain activeBrain = GetActiveBrain(i);
				if (activeBrain != null && activeBrain.OutputCamera != null && activeBrain.IsLive(vcam))
				{
					return activeBrain;
				}
			}
			int num = 1 << vcam.gameObject.layer;
			for (int j = 0; j < brainCount; j++)
			{
				CinemachineBrain activeBrain2 = GetActiveBrain(j);
				if (activeBrain2 != null && activeBrain2.OutputCamera != null && (activeBrain2.OutputCamera.cullingMask & num) != 0)
				{
					return activeBrain2;
				}
			}
		}
		return null;
	}

	public void OnTargetObjectWarped(Transform target, Vector3 positionDelta)
	{
		int virtualCameraCount = VirtualCameraCount;
		for (int i = 0; i < virtualCameraCount; i++)
		{
			GetVirtualCamera(i).OnTargetObjectWarped(target, positionDelta);
		}
	}
}
