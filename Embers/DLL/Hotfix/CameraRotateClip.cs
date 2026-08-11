using Ase.ECS;
using Cinemachine;
using UnityEngine;

[ClipName("相机震动")]
public class CameraRotateClip : TaskClip
{
	public float shakerTime;

	public float shakerIntensity;

	public CinemachineVirtualCamera virtualCamera;

	public NoiseSettings _NoiseSettings;

	private CinemachineFramingTransposer _framingTransposer;

	private CinemachineBasicMultiChannelPerlin _cinemachineBasicMultiChannelPerlin;

	private CinemachinePOV _cinemachinePov;

	private float _time;

	public override void EditorEnter(GameObject context, int fps, int currentFrameID)
	{
		base.EditorEnter(context, fps, currentFrameID);
		_framingTransposer = virtualCamera.GetCinemachineComponent<CinemachineFramingTransposer>();
		_cinemachinePov = virtualCamera.GetCinemachineComponent<CinemachinePOV>();
		_cinemachineBasicMultiChannelPerlin = virtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
		_cinemachineBasicMultiChannelPerlin.m_NoiseProfile = _NoiseSettings;
		_time = shakerTime;
	}

	public override void RunTimeTick(int currentFrameID, int fps, float deltaTime, BaseEntity context)
	{
	}

	public override void EditorTick(int currentFrameID, int fps, float deltaTime, GameObject context)
	{
		if (!(_framingTransposer == null) && !(_cinemachinePov == null))
		{
			_time -= deltaTime * (float)currentFrameID;
			_cinemachinePov.m_HorizontalAxis.Value = 100f;
			_cinemachinePov.m_VerticalAxis.Value = 100f;
		}
	}

	public override void EditorExit(GameObject context, int fps, int currentFrameID)
	{
		base.EditorExit(context, fps, currentFrameID);
		_time = 0f;
	}
}
