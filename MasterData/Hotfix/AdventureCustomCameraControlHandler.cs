using Cinemachine;
using UnityEngine;

public class AdventureCustomCameraControlHandler : MonoBehaviour
{
	public enum CustomCameraType
	{
		VirtualCamera,
		DollyCameraWithTrack,
		DollyTrackWithCart,
		TargetGroupCamera,
		VirtualCameraByFollow,
		VirtualCameraNoeffect
	}

	public CustomCameraType customCameraType;

	protected CinemachineVirtualCamera _virtualCamera;

	protected CinemachineTargetGroup _targetGroup;

	protected CinemachineTargetGroup.Target[] _targets;

	public Transform vmTarget;

	public Transform vmPlayer;

	public AdventureCameraControlConfigureData configureData;

	public CinemachineVirtualCamera virtualCamera => _virtualCamera;

	public Transform vitrualCm => _virtualCamera.transform;

	protected void Awake()
	{
		_virtualCamera = GetComponentInChildren<CinemachineVirtualCamera>();
		_virtualCamera.m_Lens.NearClipPlane = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.nearClipPlane;
		_virtualCamera.m_Lens.FarClipPlane = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.farClipPlane;
	}

	protected void Start()
	{
		DeActive();
	}

	protected void LateUpdate()
	{
		if (customCameraType == CustomCameraType.TargetGroupCamera)
		{
			Vector3 vector = _targets[0].target.transform.position - _targets[1].target.transform.position;
			vector.y = 0f;
			vector = vector.normalized;
			_targetGroup.transform.forward = vector;
		}
	}

	public void Active()
	{
		switch (customCameraType)
		{
		case CustomCameraType.VirtualCamera:
			_virtualCamera.LookAt = SceneSingleton<AdventurePlayerController>.Instance.cameraBeacon;
			break;
		case CustomCameraType.DollyCameraWithTrack:
			_virtualCamera.Follow = SceneSingleton<AdventurePlayerController>.Instance.cameraBeacon;
			_virtualCamera.LookAt = SceneSingleton<AdventurePlayerController>.Instance.cameraBeacon;
			break;
		case CustomCameraType.DollyTrackWithCart:
			_virtualCamera.LookAt = SceneSingleton<AdventurePlayerController>.Instance.cameraBeacon;
			break;
		case CustomCameraType.TargetGroupCamera:
			_targetGroup = GetComponentInChildren<CinemachineTargetGroup>();
			_targets = _targetGroup.m_Targets;
			_targets[1].target = SceneSingleton<AdventurePlayerController>.Instance.cameraBeacon;
			break;
		case CustomCameraType.VirtualCameraByFollow:
			_virtualCamera.Follow = vmTarget;
			_virtualCamera.LookAt = vmTarget;
			SceneSingleton<AdventurePlayerController>.Instance.ChangeVirtualCamera(enable: true, vmTarget, vmPlayer, _virtualCamera, configureData);
			break;
		}
		gameObject.SetActive(value: true);
	}

	public void DeActive()
	{
		if (customCameraType == CustomCameraType.VirtualCameraByFollow && null != SceneSingleton<AdventurePlayerController>.Instance)
		{
			SceneSingleton<AdventurePlayerController>.Instance.ChangeVirtualCamera(enable: false);
		}
		gameObject.SetActive(value: false);
	}
}
