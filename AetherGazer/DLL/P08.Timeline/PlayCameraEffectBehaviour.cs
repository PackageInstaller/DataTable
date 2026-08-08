using Cinemachine;
using UnityEngine;
using UnityEngine.Playables;

public class PlayCameraEffectBehaviour : PlayableBehaviour
{
	public string m_effectPath = string.Empty;

	public float m_time = 1f;

	public Vector3 m_offset = Vector3.zero;

	public float m_fieldOfView = 55f;

	public Vector2 m_aspectRate = new Vector2(1920f, 1080f);

	public float m_nearValue = 0.3f;

	private bool _played;

	public bool m_stopIfDestroy;

	private EffectController _effectController;

	public override void OnPlayableDestroy(Playable playable)
	{
		if (m_stopIfDestroy && (bool)_effectController && _effectController.mIsRunning)
		{
			_effectController.Stop();
			_effectController = null;
		}
	}

	public override void OnBehaviourPause(Playable playable, FrameData info)
	{
		if (Application.isPlaying && _played)
		{
			_played = false;
		}
	}

	public override void ProcessFrame(Playable playable, FrameData info, object playerData)
	{
		if (!Application.isPlaying || _played || string.IsNullOrEmpty(m_effectPath))
		{
			return;
		}
		_played = true;
		EffectController effectController = null;
		if (m_nearValue != 0.3f)
		{
			CinemachineVirtualCamera virtualCamera = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.virtualCamera;
			if (virtualCamera != null)
			{
				virtualCamera.m_Lens.NearClipPlane = 0.3f;
			}
			effectController = CommonEffectClipPlayer.PlayEffect(null, m_effectPath, string.Empty, Vector3.zero, Vector3.one, Vector3.zero, Vector3.forward, isAttach: false, isLoop: false, 1f, 0f, m_time, usePosition: false, Vector3.zero, isLockEffectRotation: false, delegate
			{
				CinemachineVirtualCamera virtualCamera2 = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam.virtualCamera;
				if (virtualCamera2 != null)
				{
					virtualCamera2.m_Lens.NearClipPlane = 0.3f;
				}
			}, isCameraEffect: true);
		}
		else
		{
			effectController = CommonEffectClipPlayer.PlayEffect(null, m_effectPath, string.Empty, Vector3.zero, Vector3.one, Vector3.zero, Vector3.forward, isAttach: false, isLoop: false, 1f, 0f, m_time, usePosition: false, Vector3.zero, isLockEffectRotation: false, null, isCameraEffect: true);
		}
		effectController.m_CameraEffectController = U3DUtil.Get<CameraEffectController>(effectController.gameObject);
		effectController.m_CameraEffectController.m_effectController = effectController;
		effectController.m_CameraEffectController.Initalization(Vector3.one, m_fieldOfView, m_aspectRate);
		CommonEffectClipPlayer.SetVirtualCameraEffect(effectController.gameObject, null, useVirtualCameraFirst: false);
		_effectController = effectController;
		if (m_offset != Vector3.zero)
		{
			effectController.transform.localPosition = m_offset;
		}
	}
}
