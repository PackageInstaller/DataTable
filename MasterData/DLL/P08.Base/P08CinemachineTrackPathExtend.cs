using Cinemachine;
using UnityEngine;

public class P08CinemachineTrackPathExtend : CinemachineExtension
{
	public CinemachineSmoothPath m_path;

	public CinemachineDollyCart m_cart;

	public Transform m_follow;

	private float _previousPathPosition;

	private float _pathPosition;

	protected override void PostPipelineStageCallback(CinemachineVirtualCameraBase vcam, CinemachineCore.Stage stage, ref CameraState state, float deltaTime)
	{
		if (!(m_path == null) && !(m_cart == null) && !(m_follow == null) && stage == CinemachineCore.Stage.Finalize)
		{
			float f = m_path.ToNativePathUnits(_previousPathPosition, CinemachinePathBase.PositionUnits.Distance);
			_pathPosition = m_path.FindClosestPoint(m_follow.position, Mathf.FloorToInt(f), -1, 0);
			_pathPosition = m_path.FromPathNativeUnits(_pathPosition, CinemachinePathBase.PositionUnits.Distance);
			_previousPathPosition = _pathPosition;
			m_cart.m_Position = _pathPosition;
		}
	}
}
