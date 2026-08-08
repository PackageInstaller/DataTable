using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

namespace T0World;

public class T0WorldCameraManager
{
	public T0WorldCameraContext data = new T0WorldCameraContext();

	public static T0WorldCameraManager Instance;

	private Dictionary<T0WorldCameraFlag, IT0WorldUICamera> cameras;

	private const string CUT_CAM_NAME = "CUT";

	public void RegisterCamera(IT0WorldUICamera controller, T0WorldCameraFlag flag)
	{
		if (cameras == null)
		{
			cameras = new Dictionary<T0WorldCameraFlag, IT0WorldUICamera>();
		}
		if (cameras.ContainsKey(flag))
		{
			cameras.Remove(flag);
		}
		cameras.Add(flag, controller);
	}

	public IT0WorldUICamera GetUseCamera(T0WorldCameraFlag cameraFlag)
	{
		return cameras[cameraFlag];
	}

	public void EnableCamera(int flag)
	{
		if (flag == 1)
		{
			data.cameraFlag = (T0WorldCameraFlag)flag;
		}
	}

	private void InitBrain()
	{
		CinemachineBrain component = Camera.main.GetComponent<CinemachineBrain>();
		if (component.m_CustomBlends == null)
		{
			component.m_CustomBlends = new CinemachineBlenderSettings();
			CinemachineBlenderSettings.CustomBlend customBlend = new CinemachineBlenderSettings.CustomBlend
			{
				m_From = "**ANY CAMERA**",
				m_To = "T0WorldFreeCamera",
				m_Blend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f)
			};
			CinemachineBlenderSettings.CustomBlend customBlend2 = new CinemachineBlenderSettings.CustomBlend
			{
				m_To = "**ANY CAMERA**",
				m_From = "T0WorldFreeCamera",
				m_Blend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f)
			};
			CinemachineBlenderSettings.CustomBlend customBlend3 = default(CinemachineBlenderSettings.CustomBlend);
			customBlend.m_From = "**ANY CAMERA**";
			customBlend.m_To = "CUT";
			customBlend.m_Blend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
			CinemachineBlenderSettings.CustomBlend customBlend4 = default(CinemachineBlenderSettings.CustomBlend);
			customBlend2.m_To = "**ANY CAMERA**";
			customBlend2.m_From = "CUT";
			customBlend2.m_Blend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
			component.m_CustomBlends.m_CustomBlends = new CinemachineBlenderSettings.CustomBlend[4] { customBlend, customBlend2, customBlend3, customBlend4 };
		}
	}

	public void Init()
	{
		Instance = this;
		InitBrain();
	}

	public void Dispose()
	{
		Instance = null;
		cameras?.Clear();
		cameras = null;
	}

	public void Tick()
	{
		if (cameras == null)
		{
			return;
		}
		foreach (KeyValuePair<T0WorldCameraFlag, IT0WorldUICamera> camera in cameras)
		{
			Behaviour behaviour = camera.Value as Behaviour;
			if ((bool)behaviour && behaviour.isActiveAndEnabled)
			{
				camera.Value.Tick();
			}
		}
	}

	public void LateTick()
	{
	}
}
