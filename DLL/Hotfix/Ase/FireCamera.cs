using System;
using UnityEngine;

namespace Ase;

public class FireCamera : MonoBehaviour
{
	public Camera mainCamera;

	public GameObject pointObj;

	private Camera GetCamera()
	{
		if (mainCamera == null)
		{
			mainCamera = GameEntry.Camera.MainCamera;
		}
		return mainCamera;
	}

	public void SetOuterCamera(bool value)
	{
		if (mainCamera != null)
		{
			mainCamera.gameObject.SetActive(value);
		}
	}

	public void FireBullet(Action shoot)
	{
		GetCamera();
		Camera camera = mainCamera;
		RaycastHit val = default(RaycastHit);
		if ((bool)camera && Physics.Raycast(camera.ScreenPointToRay(Input.mousePosition), ref val, 100f, 1 << LayerMask.NameToLayer("Default")))
		{
			Blast component = ((Component)(object)((RaycastHit)(ref val)).collider).GetComponent<Blast>();
			if (!(component == null))
			{
				shoot?.Invoke();
				component.Beat(((RaycastHit)(ref val)).point);
			}
		}
	}

	public Vector3 GetRayToGemPoint(GameObject gem)
	{
		Vector3 result = new Vector3(0f, 0f, 0f);
		Camera camera = GetCamera();
		if (camera != null)
		{
			Vector3 position = camera.transform.position;
			Vector3 direct = position - gem.transform.position;
			Vector3 forward = Vector3.forward;
			Vector3 position2 = pointObj.transform.position;
			return GetIntersectWithLineAndPlane(position, direct, forward, position2);
		}
		return result;
	}

	private Vector3 GetIntersectWithLineAndPlane(Vector3 point, Vector3 direct, Vector3 planeNormal, Vector3 planePoint)
	{
		return Vector3.Dot(planePoint - point, planeNormal) / Vector3.Dot(direct.normalized, planeNormal) * direct.normalized + point;
	}
}
