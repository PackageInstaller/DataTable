using UnityEngine;

public class MinmapObject : MonoBehaviour
{
	private Transform _target;

	private Transform _transform;

	private float _lastRotY;

	private void Awake()
	{
		_transform = transform;
	}

	public void SetTarget(Transform target)
	{
		_target = target;
	}

	private void Update()
	{
		if (!(_transform != null) || !(_target != null))
		{
			return;
		}
		float y = SceneSingleton<AdventurePlayerController>.Instance.playerMainVCam.transform.eulerAngles.y;
		if (!Mathf.Approximately(_lastRotY, y))
		{
			_lastRotY = y;
			Vector3 localEulerAngles = _transform.localEulerAngles;
			localEulerAngles.y = y - 45f;
			while (localEulerAngles.y < 0f)
			{
				localEulerAngles.y += 360f;
			}
			localEulerAngles.z = 0f;
			localEulerAngles.x = 0f;
			_transform.localEulerAngles = localEulerAngles;
		}
		Vector3 position = _target.position;
		position.y = 0f;
		_transform.position = position;
	}
}
