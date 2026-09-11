using UnityEngine;
using UnityEngine.EventSystems;

public class AimSightMoveScript : MonoBehaviour, IPointerDownHandler, IEventSystemHandler, IPointerMoveHandler
{
	public Vector2 mPosition;

	public Camera targetCamera;

	public GameObject AimSight;

	public float distance = 20f;

	public void Init(GameObject go, float distance = 20f)
	{
		AimSight = go;
		this.distance = distance;
		mPosition = new Vector2(Screen.width / 2, Screen.height / 2);
		targetCamera = Camera.main;
	}

	private void Update()
	{
		AimSight.transform.position = GetWorldPositionAtDistance(mPosition, distance);
	}

	public Vector3 GetWorldPositionAtDistance(Vector3 screenPoint, float distance)
	{
		Ray ray = targetCamera.ScreenPointToRay(screenPoint);
		return ray.origin + ray.direction * distance;
	}

	public void ClampInScreen(Vector2 delta)
	{
		Vector2 vector = mPosition + delta;
		float x = Mathf.Clamp(vector.x, 0f, Screen.width);
		float y = Mathf.Clamp(vector.y, 0f, Screen.height);
		mPosition = new Vector2(x, y);
	}

	public void OnPointerDown(PointerEventData eventData)
	{
		mPosition = eventData.position;
	}

	public void OnPointerMove(PointerEventData eventData)
	{
		mPosition = eventData.position;
	}
}
