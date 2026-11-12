using UnityEngine;
using UnityEngine.Rendering.Universal;

[DisallowMultipleComponent]
public class BossIndicator : MonoBehaviour
{
	public Transform Rot;

	public GameObject Image;

	private Transform _target;

	private RectTransform _transform;

	private Vector3 _positionOffset;

	private RectTransform _parent;

	private static readonly Vector2 center = new Vector2(0.5f, 0.5f);

	private void Awake()
	{
		_transform = GetComponent<RectTransform>();
		_parent = transform.parent.GetComponent<RectTransform>();
	}

	public void SetFollowTarget(Transform target, Vector3 positionOffset)
	{
		_target = target;
		_positionOffset = positionOffset;
	}

	private void Update()
	{
		if (null == _target || _transform == null)
		{
			return;
		}
		Vector3 vector = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToViewportPointAsHFOV(_target.position + _positionOffset);
		if (vector.x < 0f || vector.y < 0f || vector.x > 1f || vector.y > 1f)
		{
			Image.SetActive(value: true);
			if (vector.z < 0f)
			{
				vector = -1f * vector;
			}
			Vector2 vector2 = (Vector2)vector - center;
			float num = Mathf.Abs(vector2.x);
			float num2 = Mathf.Abs(vector2.y);
			if (num > num2)
			{
				num2 = Mathf.Sign(vector2.y) * num2 * 0.5f / num;
				num = Mathf.Sign(vector2.x) * 0.5f;
			}
			else
			{
				num = Mathf.Sign(vector2.x) * num * 0.5f / num2;
				num2 = Mathf.Sign(vector2.y) * 0.5f;
			}
			Vector3 vector3 = new Vector3(num, num2, 0f);
			vector3.Normalize();
			Vector3 vector4 = Vector3.Cross(vector3, Vector3.down);
			float num3 = Vector2.Angle(vector3, Vector2.down);
			if (vector4.z > 0f)
			{
				num3 = 0f - num3;
			}
			Rot.localEulerAngles = new Vector3(0f, 0f, num3);
			vector.x = center.x + num;
			vector.y = center.y + num2;
			Vector3 vector5 = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.ViewportToScreenPoint(vector);
			RectTransformUtility.ScreenPointToLocalPointInRectangle(_parent, vector5, MonoSingleton<GameCameraStackManager>.Instance.uiCamera, out var localPoint);
			_transform.anchoredPosition = localPoint;
		}
		else
		{
			Image.SetActive(value: false);
		}
	}
}
