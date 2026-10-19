using ACT.Battle;
using Cinemachine;
using UnityEngine;

namespace ACT.EditorTools;

[ExecuteInEditMode]
[AddComponentMenu("1策划工具/测试相机DesignerTestCamera")]
public class DesignerTestCamera : MonoBehaviour
{
	public bool start;

	private Camera cam;

	[Space(30f)]
	[Range(0f, 100f)]
	public float fov = 45f;

	[Range(0f, 10f)]
	public float updown = 0.5f;

	[Range(0f, 1f)]
	public float leftright = 0.5f;

	private float defaultfov;

	private float defaultupdown;

	private float defaultleftright;

	private Vector3 defaultPos;

	public void calc()
	{
		cam = Camera.main;
		CinemachineVirtualCamera cinemachineVirtualCamera = cam.GetComponent<CinemachineBrain>().ActiveVirtualCamera as CinemachineVirtualCamera;
		CinemachineFramingTransposerACT cinemachineComponent = cinemachineVirtualCamera.GetCinemachineComponent<CinemachineFramingTransposerACT>();
		if (cinemachineVirtualCamera.GetComponent<CinemachineConfiner>() != null)
		{
			cinemachineVirtualCamera.GetComponent<CinemachineConfiner>().m_BoundingVolume.transform.position = defaultPos;
		}
		cinemachineVirtualCamera.m_Lens.FieldOfView = defaultfov;
		cinemachineComponent.m_ScreenX = defaultleftright;
		cinemachineComponent.m_ScreenY = defaultupdown;
		if (cinemachineVirtualCamera.GetComponent<CinemachineCollider>() != null)
		{
			cinemachineVirtualCamera.GetComponent<CinemachineCollider>().enabled = true;
		}
	}

	private void Update()
	{
		if (start)
		{
			cam = Camera.main;
			CinemachineVirtualCamera cinemachineVirtualCamera = cam.GetComponent<CinemachineBrain>().ActiveVirtualCamera as CinemachineVirtualCamera;
			if (cinemachineVirtualCamera.GetComponent<CinemachineCollider>() != null)
			{
				cinemachineVirtualCamera.GetComponent<CinemachineCollider>().enabled = false;
			}
			CinemachineFramingTransposerACT cinemachineComponent = cinemachineVirtualCamera.GetCinemachineComponent<CinemachineFramingTransposerACT>();
			if (cinemachineVirtualCamera.GetComponent<CinemachineConfiner>() != null)
			{
				CinemachineConfiner component = cinemachineVirtualCamera.GetComponent<CinemachineConfiner>();
				component.m_BoundingVolume.transform.position = new Vector3(component.m_BoundingVolume.transform.position.x, updown, component.m_BoundingVolume.transform.position.z);
			}
			cinemachineVirtualCamera.m_Lens.FieldOfView = fov;
			cinemachineComponent.m_ScreenX = leftright;
			cinemachineComponent.m_ScreenY = updown;
		}
		else
		{
			fov = 45f;
			updown = 0.5f;
			leftright = 0.5f;
			defaultfov = 45f;
			defaultleftright = 0.5f;
			defaultupdown = 0.5f;
			cam = Camera.main;
			defaultPos = new Vector3(0f, 2.65f, 0f);
		}
	}
}
