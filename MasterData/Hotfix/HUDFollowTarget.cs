using UnityEngine;
using UnityEngine.Rendering.Universal;

[DisallowMultipleComponent]
public class HUDFollowTarget : MonoBehaviour
{
	private Transform _target;

	private Transform _transform;

	private Vector3 _positionOffset;

	private void Awake()
	{
		_transform = transform;
	}

	public void SetFollowTarget(Transform target, Vector3 positionOffset)
	{
		_target = target;
		_positionOffset = positionOffset;
	}

	public void HUDUpdate(float dt)
	{
		if (!(null == _target) && !(_transform == null))
		{
			Vector3 position = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPointAsHFOV(_target.position + _positionOffset);
			position.z = 17f;
			_transform.position = SceneSingleton<AdventurePlayerController>.Instance.hudCamera.ScreenToWorldPointAsHFOV(position);
		}
	}
}
