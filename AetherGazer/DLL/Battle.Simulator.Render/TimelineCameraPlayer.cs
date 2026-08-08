using System;
using System.Collections.Generic;
using Cinemachine;
using UnityEngine;

public class TimelineCameraPlayer
{
	private int _lastIndex;

	private int _shakeCounter;

	private bool _needShake;

	private bool _isInitialize;

	private NAgent _agent;

	private Transform _target;

	private BBHumanoid _blackboard;

	private List<TimelineCameraClip> _clips;

	private List<TimelineCameraClip> _running = new List<TimelineCameraClip>(8);

	private List<int> _ForceRemove = new List<int>(8);

	private List<MonoBehaviour> _virtualCamera = new List<MonoBehaviour>(8);

	private CinemachineBrain _cameraBrain;

	private CameraParamComponent _freeLookCamera;

	private ComponentCameraAnimation _componentCameraAnimation;

	private CinemachineAdditionCurve _additionCurve;

	private AttachPointSetup _attachPoints;

	private CinemachineBasicMultiChannelPerlin _trackPerlin;

	private CinemachineBasicMultiChannelPerlin _commonCameraPerlin;

	private TimelineCameraClip _waitToShakeClip;

	private bool _waitToShakePerlin;

	public void Initialize(Transform target, NAgent agent)
	{
		_agent = agent;
		NAgent playerAgent = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetPlayerAgent();
		if (playerAgent != null)
		{
			_componentCameraAnimation = playerAgent.GetComponent<ComponentCameraAnimation>();
		}
		if (null != _agent)
		{
			_blackboard = (BBHumanoid)_agent.Blackboard;
			_attachPoints = _agent.GetComponent<AttachPointSetup>();
		}
		_target = target;
		if (!_isInitialize)
		{
			ClientSimulator.Instance.GetSimToPresentation().AddHandler<HitTargetEvent>(OnHitTarget);
			_cameraBrain = Camera.main.GetComponent<CinemachineBrain>();
			_freeLookCamera = (NScene.GetCurrentScene() as BattleScene).virtualCameraParam;
			_additionCurve = U3DUtil.Get<CinemachineAdditionCurve>(_freeLookCamera.gameObject);
			_freeLookCamera.virtualCamera.AddExtension(_additionCurve);
			CinemachineBasicMultiChannelPerlin cinemachineBasicMultiChannelPerlin = _freeLookCamera.virtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			if (null == cinemachineBasicMultiChannelPerlin)
			{
				cinemachineBasicMultiChannelPerlin = _freeLookCamera.virtualCamera.AddCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			}
			_commonCameraPerlin = cinemachineBasicMultiChannelPerlin;
			_isInitialize = true;
			AgentManager.OnSpawnHandler = (OnVoidHandler<NAgent, EntitySpawnedEvent>)Delegate.Combine(AgentManager.OnSpawnHandler, new OnVoidHandler<NAgent, EntitySpawnedEvent>(OnSpawnUnitRenderEventHandler));
		}
	}

	public void OnSpawnUnitRenderEventHandler(NAgent nAgent, EntitySpawnedEvent eventReceived)
	{
		if (eventReceived.mIsPlayer)
		{
			if (nAgent != null)
			{
				_componentCameraAnimation = nAgent.GetComponent<ComponentCameraAnimation>();
			}
		}
	}

	private void OnHitTarget(HitTargetEvent eventReceived)
	{
		if (null != _agent && eventReceived.mAttackerID == _agent.AgentID)
		{
			NAgent agent = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(eventReceived.mTargetID);
			_needShake = _agent.IsLocalPlayer || ((bool)agent && agent.IsLocalPlayer);
			if (_needShake && _waitToShakePerlin)
			{
				SetCameraShake(_waitToShakeClip);
				_needShake = false;
				_waitToShakePerlin = false;
			}
		}
	}

	public void Initialize(List<TimelineCameraClip> clips)
	{
		_clips = clips;
	}

	public void SetCameraShake(TimelineCameraClip clip)
	{
		if (null != _trackPerlin)
		{
			if (_componentCameraAnimation != null)
			{
				_componentCameraAnimation.SetCameraShake(_trackPerlin, clip);
			}
		}
		else if (_cameraBrain.ActiveVirtualCamera is CinemachineVirtualCamera)
		{
			CinemachineBasicMultiChannelPerlin cinemachineComponent = (_cameraBrain.ActiveVirtualCamera as CinemachineVirtualCamera).GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
			if (!(cinemachineComponent == null) && _componentCameraAnimation != null)
			{
				_componentCameraAnimation.SetCameraShake(cinemachineComponent, clip);
			}
		}
		else if (_componentCameraAnimation != null)
		{
			_componentCameraAnimation.SetCameraShake(_commonCameraPerlin, clip);
		}
	}

	private void InitializeCamera(TimelineCameraClip clip)
	{
		bool flag = null != _agent && _agent.IsLocalPlayer;
		bool isGameOver = (NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager().isGameOver;
		GameObject gameObject = null;
		CinemachineVirtualCamera cinemachineVirtualCamera = null;
		MonoBehaviour item = null;
		bool useMapCameraParam = ((BattleScene)NScene.GetCurrentScene()).GetMapTriggerManager().useMapCameraParam;
		switch (clip.type)
		{
		default:
			return;
		case E_TimelineCinemachineType.Track:
			gameObject = Asset.Instantiate(clip.cameraPath);
			if (null == gameObject)
			{
				Debug.LogError("Camera " + clip.cameraPath + " Is Null");
				return;
			}
			cinemachineVirtualCamera = gameObject.GetComponentInChildren<CinemachineVirtualCamera>();
			if (!useMapCameraParam || clip.foreceShake)
			{
				CinemachineDollyTrackExtend component2 = cinemachineVirtualCamera.GetComponent<CinemachineDollyTrackExtend>();
				gameObject.transform.position = _blackboard.CurrentFramePosition;
				gameObject.transform.forward = _blackboard.CurrentFaceDirection;
				if (component2.HandToRoot)
				{
					gameObject.transform.SetParent(_agent.transform, worldPositionStays: true);
					gameObject.transform.localPosition = Vector3.zero;
					gameObject.transform.localRotation = Quaternion.identity;
				}
				cinemachineVirtualCamera.Follow = _target;
				if (component2.LookAtType == E_LookAtType.TPOSE)
				{
					cinemachineVirtualCamera.LookAt = _attachPoints.transform;
				}
				else if (component2.LookAtType == E_LookAtType.BIP)
				{
					cinemachineVirtualCamera.LookAt = _attachPoints.GetAttachPoint("Bip001");
				}
				else if (component2.LookAtType == E_LookAtType.ROOT)
				{
					cinemachineVirtualCamera.LookAt = _attachPoints.GetAttachPoint("root");
				}
				else
				{
					cinemachineVirtualCamera.LookAt = _attachPoints.transform;
				}
				cinemachineVirtualCamera.enabled = true;
				item = component2;
				if (_agent.IsLocalPlayer)
				{
					_cameraBrain.m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.Cut, 0f);
				}
				else
				{
					_cameraBrain.m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseIn, 0.5f);
				}
				if (null == _trackPerlin)
				{
					_trackPerlin = cinemachineVirtualCamera.GetCinemachineComponent<CinemachineBasicMultiChannelPerlin>();
				}
				if (!(null == _trackPerlin))
				{
					_commonCameraPerlin = _trackPerlin;
					CinemachineBasicMultiChannelPerlin commonCameraPerlin = _commonCameraPerlin;
					_trackPerlin.m_NoiseProfile = commonCameraPerlin.m_NoiseProfile;
					_trackPerlin.m_AmplitudeGain = commonCameraPerlin.m_AmplitudeGain;
					_trackPerlin.m_FrequencyGain = commonCameraPerlin.m_FrequencyGain;
					commonCameraPerlin.m_NoiseProfile = null;
					commonCameraPerlin.m_AmplitudeGain = 0f;
					commonCameraPerlin.m_FrequencyGain = 0f;
				}
			}
			break;
		case E_TimelineCinemachineType.Addiction:
			gameObject = Asset.Instantiate(clip.cameraPath);
			if (null == gameObject)
			{
				Debug.LogError("Camera " + clip.cameraPath + " Is Null");
				return;
			}
			cinemachineVirtualCamera = gameObject.GetComponentInChildren<CinemachineVirtualCamera>();
			if ((!((BattleScene)NScene.GetCurrentScene()).GetMapTriggerManager().useMapCameraParam & flag) || clip.foreceShake)
			{
				CinemachineAdditionCurve component = cinemachineVirtualCamera.GetComponent<CinemachineAdditionCurve>();
				_additionCurve.SetCurvesFromOtherAddictionCurve(component, clip.ForwardType);
				item = _additionCurve;
				PooledAsset.DestroyOrReturn(gameObject);
				break;
			}
			PooledAsset.DestroyOrReturn(gameObject);
			return;
		case E_TimelineCinemachineType.Noise:
			if ((clip.foreceShake || (!clip.shakeOnHit & flag) || (clip.shakeOnHit && _needShake)) && !isGameOver)
			{
				_needShake = false;
				_shakeCounter++;
				SetCameraShake(clip);
			}
			else if (clip.shakeOnHit && !_needShake && !isGameOver)
			{
				_waitToShakeClip = clip;
				_waitToShakePerlin = true;
			}
			break;
		}
		_running.Add(clip);
		_virtualCamera.Add(item);
	}

	private void TickCamera(float normalize, TimelineCameraClip clip, MonoBehaviour camera, int runningIndex)
	{
		switch (clip.type)
		{
		case E_TimelineCinemachineType.Track:
		{
			(camera as CinemachineDollyTrackExtend).Tick(clip.curve.Evaluate(normalize), normalize);
			GameMode mGameMode = (NScene.GetCurrentScene() as BattleScene).mGameMode;
			bool flag = mGameMode == GameMode.Multiplayer || mGameMode == GameMode.EditorMultiPlayer || mGameMode == GameMode.ReplayMultiPlayer;
			if (!_agent.IsLocalPlayer && (flag || (clip.SwitchCameraNormalized > 0f && normalize >= clip.SwitchCameraNormalized)))
			{
				_ForceRemove.Add(runningIndex);
			}
			break;
		}
		case E_TimelineCinemachineType.Addiction:
			(camera as CinemachineAdditionCurve).Tick(clip.curve.Evaluate(normalize / (clip.end - clip.begin)));
			break;
		case E_TimelineCinemachineType.Noise:
			if ((NScene.GetCurrentScene() as BattleScene).GetWorldSatetManager().isGameOver && _commonCameraPerlin != null)
			{
				_commonCameraPerlin.enabled = false;
			}
			break;
		}
	}

	private void FinishCamera(E_TimelineCinemachineType type, MonoBehaviour camera)
	{
		switch (type)
		{
		case E_TimelineCinemachineType.Track:
		{
			CinemachineBasicMultiChannelPerlin commonCameraPerlin = _commonCameraPerlin;
			if (_trackPerlin != null && commonCameraPerlin != null)
			{
				commonCameraPerlin.m_NoiseProfile = _trackPerlin.m_NoiseProfile;
				commonCameraPerlin.m_AmplitudeGain = _trackPerlin.m_AmplitudeGain;
				commonCameraPerlin.m_FrequencyGain = _trackPerlin.m_FrequencyGain;
				_trackPerlin.m_NoiseProfile = null;
				_trackPerlin.m_AmplitudeGain = 0f;
				_trackPerlin.m_FrequencyGain = 0f;
			}
			_trackPerlin = null;
			(camera as CinemachineDollyTrackExtend).OnFinish(_cameraBrain);
			PooledAsset.DestroyOrReturn(camera.transform.parent.gameObject);
			if (_agent.IsLocalPlayer)
			{
				if (_componentCameraAnimation != null)
				{
					_componentCameraAnimation.RotateCameraToRoleaBack();
				}
			}
			else
			{
				_cameraBrain.m_DefaultBlend = new CinemachineBlendDefinition(CinemachineBlendDefinition.Style.EaseIn, 0.5f);
			}
			break;
		}
		case E_TimelineCinemachineType.Noise:
			_shakeCounter = Mathf.Clamp(_shakeCounter--, 0, _shakeCounter--);
			break;
		case E_TimelineCinemachineType.Addiction:
			(camera as CinemachineAdditionCurve).OnFinish();
			break;
		}
	}

	public void Update(float normalize)
	{
		for (int i = _lastIndex; i < _clips.Count; i++)
		{
			if (normalize >= _clips[i].begin)
			{
				_lastIndex = i + 1;
				InitializeCamera(_clips[i]);
			}
		}
		for (int j = 0; j < _running.Count; j++)
		{
			TimelineCameraClip clip = _running[j];
			TickCamera(normalize, clip, _virtualCamera[j], j);
		}
		if (_ForceRemove.Count > 0)
		{
			for (int k = 0; k < _ForceRemove.Count; k++)
			{
				TimelineCameraClip timelineCameraClip = _running[k];
				_running.RemoveAt(k);
				FinishCamera(timelineCameraClip.type, _virtualCamera[k]);
				_virtualCamera.RemoveAt(k);
			}
			_ForceRemove.Clear();
		}
		for (int num = _running.Count - 1; num >= 0; num--)
		{
			TimelineCameraClip timelineCameraClip2 = _running[num];
			if (timelineCameraClip2.end < normalize)
			{
				_running.RemoveAt(num);
				FinishCamera(timelineCameraClip2.type, _virtualCamera[num]);
				_virtualCamera.RemoveAt(num);
			}
		}
		if (_waitToShakePerlin && _waitToShakeClip.end < normalize)
		{
			_waitToShakePerlin = false;
		}
	}

	public void Pause(bool isPause)
	{
	}

	private void CleanRunningCamera(bool isForceClean)
	{
		for (int num = _running.Count - 1; num >= 0; num--)
		{
			FinishCamera(_running[num].type, _virtualCamera[num]);
			_running.RemoveAt(num);
			_virtualCamera.RemoveAt(num);
		}
	}

	public void Stop(bool isForceClean)
	{
		CleanRunningCamera(isForceClean);
		_lastIndex = 0;
		_needShake = false;
		_waitToShakePerlin = false;
	}

	public void Shutdown()
	{
		if (_componentCameraAnimation != null)
		{
			_componentCameraAnimation.StopCameraShake();
		}
		if (_isInitialize)
		{
			ClientSimulator.Instance.GetSimToPresentation().RemoveHandler<HitTargetEvent>(OnHitTarget);
			AgentManager.OnSpawnHandler = (OnVoidHandler<NAgent, EntitySpawnedEvent>)Delegate.Remove(AgentManager.OnSpawnHandler, new OnVoidHandler<NAgent, EntitySpawnedEvent>(OnSpawnUnitRenderEventHandler));
		}
		CleanRunningCamera(isForceClean: true);
		_running.Clear();
		_clips = null;
		_lastIndex = 0;
		_target = null;
		_isInitialize = false;
	}

	public void SetTimeScale(float timescale)
	{
		Pause(timescale == 0f);
	}
}
