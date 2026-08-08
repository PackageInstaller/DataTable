using Cinemachine;
using UnityEngine;

public class DynamicCameraDeadZoom : MonoBehaviour
{
	public CinemachineVirtualCamera VirCamera;

	public CinemachineFramingTransposer Transposer;

	private P08JoystickController joystickController;

	public float deadZoomMin;

	public float deadZoomMax = 2f;

	public float lerpParm = 0.5f;

	public void Init(float min, float max, float lerp, P08JoystickController controller)
	{
		VirCamera = base.transform.GetComponent<CinemachineVirtualCamera>();
		if (VirCamera == null)
		{
			VirCamera = base.transform.GetComponentInChildren<CinemachineVirtualCamera>();
		}
		Transposer = VirCamera.GetCinemachineComponent<CinemachineFramingTransposer>();
		deadZoomMin = min;
		deadZoomMax = max;
		lerpParm = lerp;
		joystickController = controller;
	}

	public void Update()
	{
		float b = (1f + joystickController.GetjoystickLastForwardVector().y) / 2f * (deadZoomMax - deadZoomMin) + deadZoomMin;
		Transposer.m_DeadZoneWidth = Mathf.Lerp(Transposer.m_DeadZoneWidth, b, lerpParm);
	}
}
