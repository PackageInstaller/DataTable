using UnityEngine;

public class HexCamera : MonoBehaviour
{
	public Transform target;

	private int MouseWheelSensitivity = 1;

	private int MouseZoomMin = 1;

	private int MouseZoomMax = 20;

	private float moveSpeed = 10f;

	private float xSpeed = 250f;

	private float ySpeed = 120f;

	private int yMinLimit = -360;

	private int yMaxLimit = 360;

	private float x;

	private float y;

	private float Distance = 5f;

	private Vector3 targetOnScreenPosition;

	private Quaternion storeRotation;

	private Vector3 CameraTargetPosition;

	private Vector3 initPosition;

	private Vector3 cameraX;

	private Vector3 cameraY;

	private Vector3 cameraZ;

	private Vector3 initScreenPos;

	private Vector3 curScreenPos;

	private void Start()
	{
		Vector3 eulerAngles = base.transform.eulerAngles;
		x = eulerAngles.y;
		y = eulerAngles.x;
		CameraTargetPosition = target.position;
		storeRotation = Quaternion.Euler(y + 60f, x, 0f);
		base.transform.rotation = storeRotation;
		_ = storeRotation * new Vector3(0f, 0f, 0f - Distance) + CameraTargetPosition;
		base.transform.position = storeRotation * new Vector3(0f, 0f, 0f - Distance) + CameraTargetPosition;
	}

	private void Update()
	{
		if (Input.GetMouseButton(1))
		{
			x += Input.GetAxis("Mouse X") * xSpeed * 0.02f;
			y -= Input.GetAxis("Mouse Y") * ySpeed * 0.02f;
			y = ClampAngle(y, yMinLimit, yMaxLimit);
			storeRotation = Quaternion.Euler(y + 60f, x, 0f);
			Vector3 position = storeRotation * new Vector3(0f, 0f, 0f - Distance) + CameraTargetPosition;
			base.transform.rotation = storeRotation;
			base.transform.position = position;
		}
		else if (Input.GetAxis("Mouse ScrollWheel") != 0f)
		{
			if (Distance >= (float)MouseZoomMin && Distance <= (float)MouseZoomMax)
			{
				Distance -= Input.GetAxis("Mouse ScrollWheel") * (float)MouseWheelSensitivity;
			}
			if (Distance < (float)MouseZoomMin)
			{
				Distance = MouseZoomMin;
			}
			if (Distance > (float)MouseZoomMax)
			{
				Distance = MouseZoomMax;
			}
			_ = base.transform.rotation;
			base.transform.position = storeRotation * new Vector3(0f, 0f, 0f - Distance) + CameraTargetPosition;
		}
		if (Input.GetMouseButtonDown(2))
		{
			cameraX = base.transform.right;
			cameraY = base.transform.up;
			cameraZ = base.transform.forward;
			initScreenPos = new Vector3(Input.mousePosition.x, Input.mousePosition.y, targetOnScreenPosition.z);
			Debug.Log("downOnce");
			targetOnScreenPosition = Camera.main.WorldToScreenPoint(CameraTargetPosition);
			initPosition = CameraTargetPosition;
		}
		if (Input.GetMouseButton(2))
		{
			curScreenPos = new Vector3(Input.mousePosition.x, Input.mousePosition.y, targetOnScreenPosition.z);
			Vector3 vector = initPosition - 0.01f * ((curScreenPos.x - initScreenPos.x) * cameraX + (curScreenPos.y - initScreenPos.y) * cameraY);
			Vector3 position2 = storeRotation * new Vector3(0f, 0f, 0f - Distance) + vector;
			base.transform.position = position2;
		}
		if (Input.GetMouseButtonUp(2))
		{
			Debug.Log("upOnce");
			CameraTargetPosition = target.position;
		}
	}

	private static float ClampAngle(float angle, float min, float max)
	{
		if (angle < -360f)
		{
			angle += 360f;
		}
		if (angle > 360f)
		{
			angle -= 360f;
		}
		return Mathf.Clamp(angle, min, max);
	}

	private void testScreenToWorldPoint()
	{
		Vector3 vector = Camera.main.WorldToScreenPoint(CameraTargetPosition);
		Vector3 vector2 = vector;
		Debug.Log("ScreenPoint: " + vector2.ToString());
	}
}
