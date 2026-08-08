using System;
using System.Collections.Generic;
using UnityEngine;

public class TimelineEffectClipPlayer
{
	public Transform target;

	public AgentHuman agent;

	public BBHumanoid mBBHumanoid;

	public int mCreationIndex;

	private bool _isPause;

	private bool _usePosition;

	private int _currentIndex;

	private float _lastNormalize;

	private Vector3 _forward = Vector3.zero;

	private Vector3 _position = Vector3.zero;

	private float _timeScale = 1f;

	private List<EffectController> _effects = new List<EffectController>(64);

	private List<TimelineEffectClip> _clips;

	private Dictionary<EffectController, ThrownEffectOffset> _thrownEffectOffsets = new Dictionary<EffectController, ThrownEffectOffset>(64);

	private List<EffectController> _effectsDestory = new List<EffectController>(4);

	public void Initialize(List<TimelineEffectClip> clips, float timeScale)
	{
		_clips = clips;
		_currentIndex = 0;
		_lastNormalize = 0f;
		_forward = Vector3.forward;
		_position = Vector3.zero;
		_usePosition = false;
		_timeScale = timeScale;
		if (agent != null)
		{
			mBBHumanoid = agent.Blackboard as BBHumanoid;
		}
		AgentManager.OnSpawnHandler = (OnVoidHandler<NAgent, EntitySpawnedEvent>)Delegate.Combine(AgentManager.OnSpawnHandler, new OnVoidHandler<NAgent, EntitySpawnedEvent>(OnSpawnUnitRenderEventHandler));
	}

	public void OnSpawnUnitRenderEventHandler(NAgent nAgent, EntitySpawnedEvent eventReceived)
	{
		if (!(agent != null) && eventReceived.mIsPlayer)
		{
			agent = nAgent as AgentHuman;
			if (agent != null)
			{
				mBBHumanoid = agent.Blackboard as BBHumanoid;
			}
		}
	}

	public void Initialize(List<TimelineEffectClip> clips, Vector3 position, Vector3 forward, float timeScale)
	{
		_clips = clips;
		_currentIndex = 0;
		_lastNormalize = 0f;
		_forward = forward;
		_position = position;
		_usePosition = true;
		_timeScale = timeScale;
		if (agent != null)
		{
			mBBHumanoid = agent.Blackboard as BBHumanoid;
		}
	}

	public void SetTimeScale(float timeScale)
	{
		_timeScale = timeScale;
		List<EffectController>.Enumerator enumerator = _effects.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (!(enumerator.Current == null))
			{
				enumerator.Current.SetTimeScale(_timeScale);
			}
		}
	}

	public void Update(float normalizeTime)
	{
		if (_isPause)
		{
			return;
		}
		if (_lastNormalize > normalizeTime)
		{
			int num = _currentIndex - 1;
			while (num >= 0 && _clips[num].normalizedEnd >= normalizeTime)
			{
				_currentIndex = num;
				_currentIndex = ((_currentIndex >= 0) ? _currentIndex : 0);
				num--;
			}
		}
		_lastNormalize = normalizeTime;
		if (_currentIndex >= _clips.Count)
		{
			return;
		}
		for (int i = _currentIndex; i < _clips.Count; i++)
		{
			TimelineEffectClip timelineEffectClip = _clips[i];
			if (timelineEffectClip.begin <= normalizeTime && normalizeTime < timelineEffectClip.normalizedEnd)
			{
				float currentNormalize = (normalizeTime - timelineEffectClip.begin) / (timelineEffectClip.normalizedEnd - timelineEffectClip.begin);
				PlayEffect(timelineEffectClip, currentNormalize);
				_currentIndex++;
			}
			if (timelineEffectClip.begin > normalizeTime)
			{
				break;
			}
		}
	}

	public void Shutdown()
	{
		target = null;
		agent = null;
		mBBHumanoid = null;
		_isPause = false;
		_usePosition = false;
		_currentIndex = 0;
		_lastNormalize = 0f;
		_forward = Vector3.forward;
		_position = Vector3.zero;
		_timeScale = 1f;
		_clips = null;
		_effects.Clear();
		_thrownEffectOffsets.Clear();
		AgentManager.OnSpawnHandler = (OnVoidHandler<NAgent, EntitySpawnedEvent>)Delegate.Remove(AgentManager.OnSpawnHandler, new OnVoidHandler<NAgent, EntitySpawnedEvent>(OnSpawnUnitRenderEventHandler));
	}

	private void PlayEffect(TimelineEffectClip timelineEffectClip, float currentNormalize)
	{
		string text = timelineEffectClip.effectPath;
		if (mBBHumanoid != null && mBBHumanoid.m_NextSimFrameData != null && mCreationIndex > 0 && timelineEffectClip.condition == EffectCondition.CanBeParry && mBBHumanoid.m_NextSimFrameData.mAbilityCanBeParry)
		{
			text = timelineEffectClip.conditionEffectPath;
		}
		if (mCreationIndex < 0 && ((BattleScene)NScene.GetCurrentScene()).GetBattleSimulatorSystem().ThrownManager.TryGetThrown(mCreationIndex, out var thrownStateOfRender) && timelineEffectClip.condition == EffectCondition.CanBeParry && thrownStateOfRender.m_ThrownState.mCanBeParry)
		{
			text = timelineEffectClip.conditionEffectPath;
		}
		if (string.IsNullOrEmpty(text))
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene.IsGameOver() && timelineEffectClip.IsCameraEffect)
		{
			return;
		}
		Vector3 vector = _forward;
		if (!_usePosition && mBBHumanoid != null && mBBHumanoid.m_NextSimFrameData != null)
		{
			vector = mBBHumanoid.CurrentFaceDirection;
		}
		if (vector == Vector3.zero)
		{
			vector = Vector3.forward;
		}
		int mPlayerAgentID = battleScene.GetAgentManager().mPlayerAgentID;
		Vector3 scale = timelineEffectClip.scale;
		if (timelineEffectClip.IsCameraEffect && !timelineEffectClip.botherOthers && (agent == null || mPlayerAgentID != agent.AgentID))
		{
			return;
		}
		bool isMainPlayerOrBossOrElitel = false;
		bool isFriend = false;
		if (null != mBBHumanoid)
		{
			isMainPlayerOrBossOrElitel = CommonEffectClipPlayer.IsMainPlayeOrBossOrElitel(mBBHumanoid);
			isFriend = CommonEffectClipPlayer.IsFriend(mBBHumanoid);
		}
		float num = ((timelineEffectClip.playTimeScale == 0f) ? 1f : timelineEffectClip.playTimeScale);
		EffectController effectController = CommonEffectClipPlayer.PlayEffect(target, text, timelineEffectClip.handPoint, timelineEffectClip.offset, scale, timelineEffectClip.rotation, vector, timelineEffectClip.isAttach, isLoop: false, num, currentNormalize * num, timelineEffectClip.duration * num, _usePosition, _position, timelineEffectClip.isLockRotaion, OnEffectStop, timelineEffectClip.IsCameraEffect, isMainPlayerOrBossOrElitel, isFriend);
		effectController.SetTimeScale(_timeScale);
		if (timelineEffectClip.IsCameraEffect)
		{
			effectController.m_CameraEffectController = U3DUtil.Get<CameraEffectController>(effectController.gameObject);
			effectController.m_CameraEffectController.m_effectController = effectController;
			effectController.m_CameraEffectController.Initalization(scale, timelineEffectClip.FieldOfView, timelineEffectClip.AspectRate);
			if (timelineEffectClip.IsMainCameraEffect)
			{
				if (Camera.main != null)
				{
					effectController.gameObject.transform.SetParent(Camera.main.transform);
				}
			}
			else if (timelineEffectClip.IsFollowCameraEffect)
			{
				CommonEffectClipPlayer.SetVirtualCameraEffect(effectController.gameObject, battleScene.virtualCameraParam.lockTargetCinemachine.gameObject, useVirtualCameraFirst: true);
			}
			else
			{
				CommonEffectClipPlayer.SetVirtualCameraEffect(effectController.gameObject, null, useVirtualCameraFirst: true);
			}
		}
		if (agent != null && (mPlayerAgentID == agent.AgentID || timelineEffectClip.botherOthers))
		{
			effectController.EnableVirtualCameras();
		}
		_effects.Add(effectController);
		if (_usePosition)
		{
			ThrownEffectOffset value = new ThrownEffectOffset(timelineEffectClip.IsCameraEffect ? new Vector3(float.MaxValue, float.MaxValue) : timelineEffectClip.offset, timelineEffectClip.rotation);
			_thrownEffectOffsets.Add(effectController, value);
		}
		if (timelineEffectClip.destoryOnTimelineClean)
		{
			_effectsDestory.Add(effectController);
		}
	}

	public void Pause(bool isPause = true)
	{
		if (_isPause == isPause)
		{
			return;
		}
		List<EffectController>.Enumerator enumerator = _effects.GetEnumerator();
		while (enumerator.MoveNext())
		{
			if (!(enumerator.Current == null))
			{
				enumerator.Current.Pause(isPause);
			}
		}
		_isPause = isPause;
	}

	public void Clean(bool forceReturn = true)
	{
		List<EffectController>.Enumerator enumerator = _effects.GetEnumerator();
		if (forceReturn)
		{
			while (enumerator.MoveNext())
			{
				if (enumerator.Current != null)
				{
					enumerator.Current.Clean();
				}
				else
				{
					Debug.Log("特效被销毁了！不能重复销毁(bug)");
				}
			}
			_thrownEffectOffsets.Clear();
			_effects.Clear();
			_effectsDestory.Clear();
			return;
		}
		for (int num = _effectsDestory.Count - 1; num >= 0; num--)
		{
			EffectController effectController = _effectsDestory[num];
			if (effectController != null)
			{
				effectController.Stop();
			}
		}
		_effectsDestory.Clear();
	}

	public void OnEffectStop(EffectController effectController)
	{
		_thrownEffectOffsets.Remove(effectController);
		_effects.Remove(effectController);
	}

	internal void UpdateTransform(Vector3 position, Vector3 forward)
	{
		_position = position;
		_forward = forward;
		for (int i = 0; i < _effects.Count; i++)
		{
			Transform transform = _effects[i].transform;
			Vector3 position2 = position;
			if (forward == Vector3.zero)
			{
				forward = Vector3.forward;
			}
			Vector3 eulerAngles = Quaternion.LookRotation(forward).eulerAngles;
			if (_thrownEffectOffsets.TryGetValue(_effects[i], out var value))
			{
				if (value.PosOffset.x == float.MaxValue)
				{
					continue;
				}
				position2 = (Vector3)IntMath.Transform((Int3)value.PosOffset, (Int3)forward, (Int3)position);
				eulerAngles += value.RotOffset;
			}
			transform.transform.position = position2;
			transform.transform.eulerAngles = eulerAngles;
		}
	}

	public void PlayClosingAnimation()
	{
		BuffItemRenderController buffItemRenderController = null;
		for (int i = 0; i < _effects.Count; i++)
		{
			buffItemRenderController = _effects[i].GetComponent<BuffItemRenderController>();
			if (buffItemRenderController != null)
			{
				buffItemRenderController.SetTrigger("End");
			}
		}
	}

	internal void DisableRenders()
	{
		if (_effects == null || _effects.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _effects.Count; i++)
		{
			if (_effects[i] != null)
			{
				_effects[i].Hide(v: true);
			}
			else
			{
				Debug.LogError("特效中播放存在bug！");
			}
		}
	}

	internal void EnableRenders()
	{
		if (_effects == null || _effects.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _effects.Count; i++)
		{
			if (_effects[i] != null)
			{
				_effects[i].Hide(v: false);
			}
			else
			{
				Debug.LogError("特效中播放存在bug！");
			}
		}
	}

	public List<EffectController> GetTargetEffectByName(string name)
	{
		List<EffectController> list = new List<EffectController>();
		foreach (EffectController effect in _effects)
		{
			string[] array = effect.name.Split("(Clone)");
			if (array.Length != 0 && array[0].Equals(name))
			{
				list.Add(effect);
			}
		}
		return list;
	}
}
