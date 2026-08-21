#define ENABLE_ERROR_AND_ABOVE_LOG
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;
using UnityEngine.Rendering.Universal;

namespace Ase;

public class CameraComponent : GameFrameworkComponent
{
	[SerializeField]
	private Camera m_MainCamera;

	[SerializeField]
	private Camera m_EffectCamera;

	private UniversalAdditionalCameraData additionalCameraData;

	[SerializeField]
	private GameObject m_EffectCameraShadow;

	public Camera MainCamera => m_MainCamera;

	public Camera EffectCamera => m_EffectCamera;

	public GameObject EffectCameraShadow => m_EffectCameraShadow;

	public override void Init()
	{
		if (m_MainCamera == null)
		{
			m_MainCamera = Camera.main;
		}
		if (!(m_MainCamera == null))
		{
			additionalCameraData = CameraExtensions.GetUniversalAdditionalCameraData(m_MainCamera);
		}
	}

	public void AttachCamera(Camera tCamera)
	{
		if (tCamera == null)
		{
			Log.Error("Camera is invalid.");
		}
		else if (!additionalCameraData.cameraStack.Contains(tCamera))
		{
			additionalCameraData.cameraStack.Add(tCamera);
		}
	}

	public void InsertCamera(Camera tCamera)
	{
		if (tCamera == null)
		{
			Log.Error("Camera is invalid.");
		}
		else if (!additionalCameraData.cameraStack.Contains(tCamera))
		{
			additionalCameraData.cameraStack.Insert(0, tCamera);
		}
	}

	public void RemoveCamera(Camera tCamera)
	{
		if (tCamera == null)
		{
			Log.Error("Camera is invalid.");
		}
		else if (additionalCameraData.cameraStack.Contains(tCamera))
		{
			additionalCameraData.cameraStack.Remove(tCamera);
		}
	}

	public override void Shutdown()
	{
	}
}
