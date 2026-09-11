using System;
using System.Collections.Generic;
using Config;
using P08.EnvironmentHelper;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

public class TimelinePlayer : IFramePooledObject
{
	private Transform _transform;

	private NAgent _agent;

	private int _lastFrame;

	private bool _isRun;

	private bool _isPause;

	private float _pauseTime;

	private float _pauseBeginTime;

	private int _lastTimelineID;

	private float _passNormalize;

	private float m_lastRealtimeSinceStartup;

	private float _startFrameTime;

	private float _lastNormalize;

	private float _currentNormalize;

	private TimelineInfo _timelineInfo;

	private float m_lastRuntimePoint;

	private float m_currentRuntimePoint;

	private bool _needUpdateTimeScale;

	private bool _isIgnoreEntityTimeScale;

	private float _timeScale = 1f;

	private float _lastWorldTimeScale = 1f;

	private float _lastEntityTimeScale = 1f;

	private float _currentTimelineTimeScale = 1f;

	private TimelineEffectClipPlayer _effectPlayer = new TimelineEffectClipPlayer();

	private CommonEffectClipPlayer _commonEffectPlayer = new CommonEffectClipPlayer();

	private CommonEffectPlayerWithEntityScale _commonEffectPlayerWithEntityScale = new CommonEffectPlayerWithEntityScale();

	private TimelineAnimationClipPlayer _animationPlay = new TimelineAnimationClipPlayer();

	private TimelineCameraPlayer _timelineCameraPlayer = new TimelineCameraPlayer();

	private LineConnectionPlayer _connectionPlayer = new LineConnectionPlayer();

	private CommonLineConnectionPlayer _commonLinePlayer = new CommonLineConnectionPlayer();

	private TimelineCharacterGrabPlayer _grabPlayer = new TimelineCharacterGrabPlayer();

	private Dictionary<Type, IClipPlayer> m_type2Player = new Dictionary<Type, IClipPlayer>(32);

	private TimelineEarlyWarningClipPlayer _timelineEarlyWarningClipPlayer;

	private TimelinePartsActivationPlayer _activePlayer;

	private TimelineCharacterEffectComponentRegulator _characterRimLightClipRegulator;

	private TimelineCharacterInterferenceEffectClipPlayer m_timelineCharacterInterferenceEffectClipPlayer;

	private TimelineCameraGlitchEffectPlayer m_timelineCameraGlitchEffectPlayer;

	private TimelineCameraAbberationEffectPlayer m_timelineCameraAbberationEffectPlayer;

	private TimelineRadialBlurClipPlayer m_timelineRadialBlurClipPlayer;

	private TimelineAudioEffectPlayer _AudioEffectPlayer;

	private TimelineAudioVoicePlayer _AudioVoicePlayer;

	private TimelineAudioCommonPlayer _audioCommonPlayer;

	private TimelineSceneSettingFogClipPlayer m_timelineSceneSettingFogClipPlayer;

	public TimelineCharacterSliceEffectClipPlayer timelineCharacterSliceEffectClipPlayer;

	public float FrameFreezeRecordedTimeScale;

	private bool _isShutdown;

	public TimelineInfo TimelineInfo => _timelineInfo;

	public NAgent NAgent => _agent;

	public bool IsPause => _isPause;

	public float CurrentTimelineTimeScale
	{
		get
		{
			return _currentTimelineTimeScale;
		}
		set
		{
			if (value != _currentTimelineTimeScale)
			{
				_currentTimelineTimeScale = value;
				_needUpdateTimeScale = true;
			}
		}
	}

	public float CurrentNormalize => _currentNormalize;

	private T AddClipPlayer<T>() where T : IClipPlayer, new()
	{
		IClipPlayer value = null;
		Type typeFromHandle = typeof(T);
		if (!m_type2Player.TryGetValue(typeFromHandle, out value))
		{
			value = new T();
			m_type2Player.Add(typeFromHandle, value);
		}
		return (T)value;
	}

	public void Initialize(Transform transform, NAgent nAgent = null, int creationIndex = 0)
	{
		_transform = transform;
		_effectPlayer.target = transform;
		_commonEffectPlayer.target = transform;
		_commonEffectPlayerWithEntityScale.target = transform;
		_animationPlay.animator = transform.GetComponent<Animator>();
		_effectPlayer.agent = nAgent as AgentHuman;
		_effectPlayer.mCreationIndex = creationIndex;
		_animationPlay.agent = nAgent as AgentHuman;
		_agent = nAgent;
		_lastTimelineID = 0;
		_AudioEffectPlayer = AddClipPlayer<TimelineAudioEffectPlayer>();
		_AudioEffectPlayer.Transform = transform;
		Transform transform2 = transform.Find("AudioEffectPlayer");
		if (transform2 == null)
		{
			GameObject gameObject = new GameObject("AudioEffectPlayer");
			gameObject.transform.SetParent(transform, worldPositionStays: false);
			transform2 = gameObject.transform;
		}
		_AudioEffectPlayer.m_CriAtomSource = U3DUtil.Get<CriAtomSource>(transform2.gameObject);
		if (nAgent != null && _AudioEffectPlayer != null)
		{
			string label = (nAgent.IsLocalPlayer ? "1P" : "3P");
			_AudioEffectPlayer.m_CriAtomSource.player.SetSelectorLabel("1P_3P", label);
		}
		_AudioVoicePlayer = AddClipPlayer<TimelineAudioVoicePlayer>();
		_AudioVoicePlayer.Transform = transform;
		_AudioVoicePlayer.m_CreationIndex = creationIndex;
		_AudioVoicePlayer.m_NAgent = nAgent as AgentHuman;
		_AudioVoicePlayer.m_RoleID = ((nAgent != null) ? nAgent.AgentConfigID : 0);
		Transform transform3 = transform.Find("AudioVoicePlayer");
		if (transform3 == null)
		{
			GameObject gameObject2 = new GameObject("AudioVoicePlayer");
			gameObject2.transform.SetParent(transform, worldPositionStays: false);
			transform3 = gameObject2.transform;
		}
		_AudioVoicePlayer.m_CriAtomSource = U3DUtil.Get<CriAtomSource>(transform3.gameObject);
		if (nAgent != null && _AudioVoicePlayer != null)
		{
			string label2 = (nAgent.IsLocalPlayer ? "1P" : "3P");
			_AudioVoicePlayer.m_CriAtomSource.player.SetSelectorLabel("1P_3P", label2);
		}
		VoiceAssetHelper componentInChildren = transform.GetComponentInChildren<VoiceAssetHelper>();
		if (componentInChildren != null)
		{
			_AudioVoicePlayer.m_BattleVoiceConfig = componentInChildren.m_BattleVoiceConfig;
		}
		_audioCommonPlayer = AddClipPlayer<TimelineAudioCommonPlayer>();
		_audioCommonPlayer.Transform = transform;
		Transform transform4 = transform.Find("AudioCommonPlayer");
		if (transform4 == null)
		{
			GameObject gameObject3 = new GameObject("AudioCommonPlayer");
			gameObject3.transform.SetParent(transform, worldPositionStays: false);
			transform4 = gameObject3.transform;
		}
		_audioCommonPlayer.m_CriAtomSource = U3DUtil.Get<CriAtomSource>(transform4.gameObject);
		if (nAgent != null && _audioCommonPlayer != null)
		{
			string label3 = (nAgent.IsLocalPlayer ? "1P" : "3P");
			_audioCommonPlayer.m_CriAtomSource.player.SetSelectorLabel("1P_3P", label3);
		}
		CharacterEffect component = transform.GetComponent<CharacterEffect>();
		if (component != null)
		{
			TimelineCharacterEffectHelper timelineCharacterEffectHelper = U3DUtil.Get<TimelineCharacterEffectHelper>(transform.gameObject);
			timelineCharacterEffectHelper.CharacterEffect = component;
			_characterRimLightClipRegulator = AddClipPlayer<TimelineCharacterEffectComponentRegulator>();
			_characterRimLightClipRegulator.Transform = transform;
			_characterRimLightClipRegulator.CharacterEffect = component;
			_characterRimLightClipRegulator.TimelineCharacterEffectHelper = timelineCharacterEffectHelper;
			TimelineCharacterDissolveEffectClipPlayer timelineCharacterDissolveEffectClipPlayer = AddClipPlayer<TimelineCharacterDissolveEffectClipPlayer>();
			timelineCharacterDissolveEffectClipPlayer.Transform = transform;
			timelineCharacterDissolveEffectClipPlayer.CharacterEffect = component;
			TimelineCharacterDissolveBossEffectClipPlayer timelineCharacterDissolveBossEffectClipPlayer = AddClipPlayer<TimelineCharacterDissolveBossEffectClipPlayer>();
			timelineCharacterDissolveBossEffectClipPlayer.Transform = transform;
			timelineCharacterDissolveBossEffectClipPlayer.CharacterEffect = component;
			TimelineCharacterEmissionLightEffectClipPlayer timelineCharacterEmissionLightEffectClipPlayer = AddClipPlayer<TimelineCharacterEmissionLightEffectClipPlayer>();
			timelineCharacterEmissionLightEffectClipPlayer.Transform = transform;
			timelineCharacterEmissionLightEffectClipPlayer.CharacterEffect = component;
			if (component.ghostEffect != null)
			{
				TimelineCharacterGhostEffectClipPlayer timelineCharacterGhostEffectClipPlayer = AddClipPlayer<TimelineCharacterGhostEffectClipPlayer>();
				timelineCharacterGhostEffectClipPlayer.Transform = transform;
				timelineCharacterGhostEffectClipPlayer.CharacterGhostEffect = component.ghostEffect;
			}
			if (component.sliceEffect != null)
			{
				timelineCharacterSliceEffectClipPlayer = AddClipPlayer<TimelineCharacterSliceEffectClipPlayer>();
				timelineCharacterSliceEffectClipPlayer.Transform = transform;
				timelineCharacterSliceEffectClipPlayer.CharacterSliceEffect = component.sliceEffect;
			}
			if (component.interferenceEffect != null)
			{
				m_timelineCharacterInterferenceEffectClipPlayer = AddClipPlayer<TimelineCharacterInterferenceEffectClipPlayer>();
				m_timelineCharacterInterferenceEffectClipPlayer.Transform = transform;
				m_timelineCharacterInterferenceEffectClipPlayer.CharacterInterferenceEffect = component.interferenceEffect;
				m_timelineCharacterInterferenceEffectClipPlayer.TimelineCharacterEffectHelper = timelineCharacterEffectHelper;
			}
		}
		_activePlayer = AddClipPlayer<TimelinePartsActivationPlayer>();
		_activePlayer.Transform = transform;
		_activePlayer.CharacterEffect = component;
		if (component != null)
		{
			_activePlayer.CharacterShadowEnable = component.shadowEnabled;
		}
		Transform transform5 = transform.Find("Components");
		if (transform5 != null)
		{
			_activePlayer.m_CharacterRenderController = transform5.GetComponent<CharacterRenderController>();
		}
		ComponentTimeline component2 = transform.GetComponent<ComponentTimeline>();
		if (component2 != null)
		{
			_activePlayer.EnableShadowAction = component2.EnableShadow;
		}
		CameraExtension component3 = Camera.main.transform.GetComponent<CameraExtension>();
		if (nAgent != null && component3 != null && creationIndex != 0)
		{
			m_timelineRadialBlurClipPlayer = AddClipPlayer<TimelineRadialBlurClipPlayer>();
			m_timelineRadialBlurClipPlayer.Transform = transform;
			m_timelineRadialBlurClipPlayer.Agent = nAgent;
			m_timelineRadialBlurClipPlayer.AttachPointSetup = transform.GetComponent<AttachPointSetup>();
			m_timelineRadialBlurClipPlayer.CameraExtension = component3;
			m_timelineCameraGlitchEffectPlayer = AddClipPlayer<TimelineCameraGlitchEffectPlayer>();
			m_timelineCameraGlitchEffectPlayer.Transform = transform;
			m_timelineCameraGlitchEffectPlayer.Agent = nAgent;
			m_timelineCameraGlitchEffectPlayer.CreationIndex = creationIndex;
			m_timelineCameraGlitchEffectPlayer.TimelineGlitchEffectHelper = component3.GetComponent<TimelineGlitchEffectHelper>();
			m_timelineCameraAbberationEffectPlayer = AddClipPlayer<TimelineCameraAbberationEffectPlayer>();
			m_timelineCameraAbberationEffectPlayer.Transform = transform;
			m_timelineCameraAbberationEffectPlayer.Agent = nAgent;
			m_timelineCameraAbberationEffectPlayer.CreationIndex = creationIndex;
			m_timelineCameraAbberationEffectPlayer.TimelineAbberationEffectHelper = component3.GetComponent<TimelineAbberationEffectHelper>();
			TimelineCameraDepthOfFieldClipPlayer timelineCameraDepthOfFieldClipPlayer = AddClipPlayer<TimelineCameraDepthOfFieldClipPlayer>();
			timelineCameraDepthOfFieldClipPlayer.Transform = transform;
			timelineCameraDepthOfFieldClipPlayer.Agent = nAgent;
			timelineCameraDepthOfFieldClipPlayer.CameraExtension = component3;
			TimelineCameraDarkCornerClipPlayer timelineCameraDarkCornerClipPlayer = AddClipPlayer<TimelineCameraDarkCornerClipPlayer>();
			timelineCameraDarkCornerClipPlayer.Transform = transform;
			timelineCameraDarkCornerClipPlayer.Agent = nAgent;
			timelineCameraDarkCornerClipPlayer.AttachPointSetup = transform.GetComponent<AttachPointSetup>();
			timelineCameraDarkCornerClipPlayer.CameraExtension = component3;
		}
		TimelineCameraAnimationFBXPlayer timelineCameraAnimationFBXPlayer = AddClipPlayer<TimelineCameraAnimationFBXPlayer>();
		timelineCameraAnimationFBXPlayer.Transform = transform;
		timelineCameraAnimationFBXPlayer.agent = nAgent;
		SceneSetting sceneSetting = (NScene.GetCurrentScene() as BattleScene).sceneSetting;
		if (sceneSetting != null && nAgent != null && creationIndex != 0)
		{
			m_timelineSceneSettingFogClipPlayer = AddClipPlayer<TimelineSceneSettingFogClipPlayer>();
			m_timelineSceneSettingFogClipPlayer.Transform = transform;
			m_timelineSceneSettingFogClipPlayer.Agent = nAgent;
			switch ((NScene.GetCurrentScene() as BattleScene).GetAgentManager().GetMemberPositionByAgentID(nAgent.AgentID))
			{
			case MemberPosition.First:
				m_timelineSceneSettingFogClipPlayer.MemberPosition = EnMemberPositionOfFog.Player;
				break;
			case MemberPosition.Second:
				m_timelineSceneSettingFogClipPlayer.MemberPosition = EnMemberPositionOfFog.Player;
				break;
			case MemberPosition.Third:
				m_timelineSceneSettingFogClipPlayer.MemberPosition = EnMemberPositionOfFog.Player;
				break;
			default:
				m_timelineSceneSettingFogClipPlayer.MemberPosition = EnMemberPositionOfFog.Monster;
				break;
			}
			m_timelineSceneSettingFogClipPlayer.CreationIndex = creationIndex;
			m_timelineSceneSettingFogClipPlayer.TimelineDynamicFogEffectHelper = sceneSetting.GetComponent<TimelineDynamicFogEffectHelper>();
			m_timelineSceneSettingFogClipPlayer.TimelineTintEffectHelper = sceneSetting.GetComponent<TimelineTintEffectHelper>();
			TimelineSceneSettingPostEffectClipPlayer timelineSceneSettingPostEffectClipPlayer = AddClipPlayer<TimelineSceneSettingPostEffectClipPlayer>();
			timelineSceneSettingPostEffectClipPlayer.Transform = transform;
			timelineSceneSettingPostEffectClipPlayer.CreationIndex = creationIndex;
			timelineSceneSettingPostEffectClipPlayer.m_Agent = nAgent;
			timelineSceneSettingPostEffectClipPlayer.TimelinePostEffectHelper = sceneSetting.GetComponent<TimelinePostEffectHelper>();
		}
		CharacterWeaponLinesHelper component4 = transform.GetComponent<CharacterWeaponLinesHelper>();
		if (component4 != null)
		{
			TimelineCharacterWeaponLineClipPlayer timelineCharacterWeaponLineClipPlayer = AddClipPlayer<TimelineCharacterWeaponLineClipPlayer>();
			timelineCharacterWeaponLineClipPlayer.Transform = transform;
			timelineCharacterWeaponLineClipPlayer.CharacterWeaponLinesHelper = component4;
		}
		TimelineEarlyWarningClipPlayer timelineEarlyWarningClipPlayer = AddClipPlayer<TimelineEarlyWarningClipPlayer>();
		timelineEarlyWarningClipPlayer.Transform = transform;
		timelineEarlyWarningClipPlayer.CreationIndex = creationIndex;
		timelineEarlyWarningClipPlayer.mCharacter = ((nAgent != null) ? (nAgent.Blackboard as BBHumanoid) : null);
		timelineEarlyWarningClipPlayer.SceneLevel = (NScene.GetCurrentScene() as BattleScene).ready.SceneDataForExcehange.Difficulty;
		_timelineEarlyWarningClipPlayer = timelineEarlyWarningClipPlayer;
		if (nAgent != null)
		{
			TimelineCameraFOVClipPlayer timelineCameraFOVClipPlayer = AddClipPlayer<TimelineCameraFOVClipPlayer>();
			timelineCameraFOVClipPlayer.Transform = transform;
			timelineCameraFOVClipPlayer.m_Agent = nAgent;
			TimelineCameraDollyShotClipPlayer timelineCameraDollyShotClipPlayer = AddClipPlayer<TimelineCameraDollyShotClipPlayer>();
			timelineCameraDollyShotClipPlayer.Transform = transform;
			timelineCameraDollyShotClipPlayer.m_Agent = nAgent;
			TimelineCameraCraneShotClipPlayer timelineCameraCraneShotClipPlayer = AddClipPlayer<TimelineCameraCraneShotClipPlayer>();
			timelineCameraCraneShotClipPlayer.Transform = transform;
			timelineCameraCraneShotClipPlayer.m_Agent = nAgent;
			TimelineCameraRotateClipPlayer timelineCameraRotateClipPlayer = AddClipPlayer<TimelineCameraRotateClipPlayer>();
			timelineCameraRotateClipPlayer.Transform = transform;
			timelineCameraRotateClipPlayer.m_Agent = nAgent;
			TimelineCameraDampingClipPlayer timelineCameraDampingClipPlayer = AddClipPlayer<TimelineCameraDampingClipPlayer>();
			timelineCameraDampingClipPlayer.Transform = transform;
			timelineCameraDampingClipPlayer.m_agent = nAgent;
		}
		_commonLinePlayer.Target = transform;
		_timelineCameraPlayer.Initialize(transform, _agent);
		_grabPlayer.Initialize(transform, _agent);
		_isShutdown = false;
	}

	public void UpdateWorldAndEntityTimeScale(float currentTimelineTimeScale)
	{
		SimResultType lastSimResult = ((BattleScene)NScene.GetCurrentScene()).GetBattleSimulatorSystem().LastSimResult;
		float num = _lastWorldTimeScale;
		switch (lastSimResult)
		{
		case SimResultType.NoTick:
			num = 0f;
			break;
		case SimResultType.OK:
		{
			WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
			num = ((worldStateManager == null) ? 1f : ((float)worldStateManager.worldTimeScale / 100f));
			break;
		}
		}
		if (num != _lastWorldTimeScale)
		{
			_lastWorldTimeScale = num;
			_needUpdateTimeScale = true;
		}
		float num2 = 1f;
		if (_agent != null && !_isIgnoreEntityTimeScale)
		{
			BBHumanoid bBHumanoid = _agent.Blackboard as BBHumanoid;
			if (bBHumanoid != null)
			{
				if (bBHumanoid.m_NextSimFrameData != null)
				{
					num2 = bBHumanoid.m_NextSimFrameData.EntityTimeScale;
				}
				else
				{
					Debug.Log("====>>>> bBHumanoid.m_NextSimFrameData 为空,agentID:" + _agent.AgentID + ", 配置ID:" + _agent.AgentConfigID);
				}
			}
			else
			{
				Debug.Log("====>>>> bBHumanoid 为空,agentID:" + _agent.AgentID + ", 配置ID:" + _agent.AgentConfigID);
			}
		}
		if (num2 != _lastEntityTimeScale)
		{
			_lastEntityTimeScale = num2;
			_needUpdateTimeScale = true;
		}
		if (!_needUpdateTimeScale)
		{
			return;
		}
		_startFrameTime = m_lastRealtimeSinceStartup;
		_pauseTime = 0f;
		_passNormalize = _currentNormalize;
		_timeScale = currentTimelineTimeScale;
		_animationPlay.SetTimeScale(_timeScale);
		_commonEffectPlayer.SetTimeScale(_lastWorldTimeScale * _lastEntityTimeScale);
		_commonEffectPlayerWithEntityScale.SetTimeScale(_timeScale);
		_effectPlayer.SetTimeScale(_timeScale);
		_timelineCameraPlayer.SetTimeScale(_timeScale);
		_grabPlayer.SetTimeScale(_timeScale);
		Dictionary<Type, IClipPlayer>.Enumerator enumerator = m_type2Player.GetEnumerator();
		while (enumerator.MoveNext())
		{
			IClipPlayer value = enumerator.Current.Value;
			if (value is ITimeScalePlayer)
			{
				(value as ITimeScalePlayer).SetTimeScale(_timeScale);
			}
		}
		_needUpdateTimeScale = false;
	}

	public float GetTimeScale()
	{
		if (!_isIgnoreEntityTimeScale)
		{
			return _timeScale;
		}
		return _lastWorldTimeScale * CurrentTimelineTimeScale;
	}

	public void Update()
	{
		if (((BattleScene)NScene.GetCurrentScene()).GetBattleSimulatorSystem().LastSimResult == SimResultType.NoTick)
		{
			Pause();
			return;
		}
		if (IsPause)
		{
			Pause(isPause: false);
		}
		Dictionary<Type, IClipPlayer>.Enumerator enumerator = m_type2Player.GetEnumerator();
		float realTimeDalta = Time.realtimeSinceStartup - m_lastRealtimeSinceStartup;
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.UpdateWithoutTimeScale(realTimeDalta);
		}
		float num = 1f;
		num = GetTimeScale();
		m_lastRealtimeSinceStartup = Time.realtimeSinceStartup;
		if (!_isRun || _isPause || 0f >= num)
		{
			return;
		}
		m_lastRuntimePoint = m_currentRuntimePoint;
		m_currentRuntimePoint = (m_lastRealtimeSinceStartup - _pauseTime - _startFrameTime) * num;
		_currentNormalize = _passNormalize + m_currentRuntimePoint / _timelineInfo.duration;
		if (NAgent != null && NAgent.Blackboard as BBHumanoid != null && (NAgent.Blackboard as BBHumanoid).m_NextSimFrameData != null && (NAgent.Blackboard as BBHumanoid).m_NextSimFrameData.mAbilityID == _timelineInfo.ID)
		{
			float num2 = 1000f / (float)BattleSimulatorSystem.sTargetLogicFrameRate;
			float min = ((float)(NAgent.Blackboard as BBHumanoid).m_NextSimFrameData.AbilityTime - num2) / (_timelineInfo.duration * 1000f);
			float max = ((float)(NAgent.Blackboard as BBHumanoid).m_NextSimFrameData.AbilityTime + num2) / (_timelineInfo.duration * 1000f);
			_currentNormalize = Mathf.Clamp(_currentNormalize, min, max);
		}
		if (_currentNormalize >= 1f && _timelineInfo.isFinalAbility)
		{
			if (!(m_lastRuntimePoint < _timelineInfo.duration))
			{
				return;
			}
			_currentNormalize = 1f;
		}
		_animationPlay.Update(_currentNormalize);
		_grabPlayer.Update(_currentNormalize);
		float num3 = _currentNormalize;
		if (_timelineInfo.isLoop)
		{
			num3 %= 1f;
		}
		_effectPlayer.Update(num3);
		_commonEffectPlayer.Update(num3);
		_commonEffectPlayerWithEntityScale.Update(_agent);
		_connectionPlayer.Update(_currentNormalize);
		Dictionary<Type, IClipPlayer>.Enumerator enumerator2 = m_type2Player.GetEnumerator();
		while (enumerator2.MoveNext())
		{
			IClipPlayer value = enumerator2.Current.Value;
			if (value is ILoopClipPlayer)
			{
				value.Update(num3);
			}
			else
			{
				value.Update(_currentNormalize);
			}
		}
		_timelineCameraPlayer.Update(_currentNormalize);
		_commonLinePlayer.Update(num3);
		Action<int, int, int, int> onTimelineTick = (NScene.GetCurrentScene() as BattleScene).GetAgentManager().OnTimelineTick;
		if (onTimelineTick != null)
		{
			int num4 = (int)(_currentNormalize * _timelineInfo.duration * 1000f);
			int num5 = (int)(_lastNormalize * _timelineInfo.duration * 1000f);
			if (num5 < num4)
			{
				onTimelineTick((!(_agent == null)) ? _agent.AgentID : 0, _timelineInfo.ID, num5, num4);
			}
		}
		_lastNormalize = _currentNormalize;
	}

	public void Play(int timelineInfoID, Vector3 position, Vector3 forward, bool usePosition, float timeScale = 1f, int frame = -1, bool isIgnoreEntityTimeScale = false)
	{
		if (_isShutdown)
		{
			return;
		}
		bool flag = false;
		if (null != _timelineInfo && -1 != frame)
		{
			flag = _lastFrame - frame >= 5;
		}
		if (0 <= frame)
		{
			_lastFrame = frame;
		}
		if ((null == _timelineInfo || _timelineInfo.ID != timelineInfoID) | flag)
		{
			_isRun = true;
			TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(timelineInfoID);
			if (null == timelineInfo)
			{
				Debug.LogError("Can't find render timeline by " + timelineInfoID);
				return;
			}
			if (_timelineInfo != null)
			{
				_lastTimelineID = _timelineInfo.ID;
			}
			_timelineInfo = timelineInfo;
			bool isForceCleanEffect = false;
			if (ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(timelineInfo.ID, out var config))
			{
				int num = config?.AbilityClass ?? 0;
				if (ConfigHelper.GetInstance().TryGetConfig<AbilityConfig>(_lastTimelineID, out var config2))
				{
					int num2 = config2?.AbilityClass ?? 0;
					isForceCleanEffect = num > num2;
				}
			}
			ResetData(isForceCleanEffect);
			if (timelineInfo.clips.Count > 0 && frame >= 0 && frame < timelineInfo.clips[0].offset.Count && _agent != null)
			{
				float y = _transform.position.y;
				BBHumanoid bBHumanoid = _agent.Blackboard as BBHumanoid;
				bBHumanoid.LastHeight = 0f;
				y = timelineInfo.clips[0].offset[frame].y + bBHumanoid.NextFramePosition.y;
				_transform.position = _transform.position.NewY(y);
			}
			float beginNormalized = 0f;
			if (frame > 1)
			{
				beginNormalized = (float)frame / timelineInfo.frameCount;
			}
			CurrentTimelineTimeScale = timeScale;
			_isIgnoreEntityTimeScale = isIgnoreEntityTimeScale;
			UpdateWorldAndEntityTimeScale(timeScale);
			timeScale = GetTimeScale();
			_grabPlayer.Play(timelineInfo);
			_animationPlay.Initialize(timelineInfo.clips, GetTransitionTime(timelineInfoID), timeScale);
			if (usePosition)
			{
				_effectPlayer.Initialize(timelineInfo.effects, position, forward, timeScale);
			}
			else
			{
				_effectPlayer.Initialize(timelineInfo.effects, timeScale);
			}
			_timelineCameraPlayer.Initialize(timelineInfo.cameras);
			Dictionary<Type, IClipPlayer>.Enumerator enumerator = m_type2Player.GetEnumerator();
			while (enumerator.MoveNext())
			{
				IClipPlayer value = enumerator.Current.Value;
				if (value is TimelineCharacterEffectComponentRegulator)
				{
					(value as TimelineCharacterEffectComponentRegulator).Initialize(timelineInfo.flashActionClips, beginNormalized);
				}
				else if (value is TimelineCharacterDissolveEffectClipPlayer)
				{
					(value as TimelineCharacterDissolveEffectClipPlayer).Initialize(timelineInfo.characterDissolveEffectActionClips, beginNormalized);
				}
				else if (value is TimelineCharacterDissolveBossEffectClipPlayer)
				{
					(value as TimelineCharacterDissolveBossEffectClipPlayer).Initialize(timelineInfo.characterDissolveBossEffectActionClips, beginNormalized);
				}
				else if (value is TimelineCharacterEmissionLightEffectClipPlayer)
				{
					(value as TimelineCharacterEmissionLightEffectClipPlayer).Initialize(timelineInfo.characterEmissionLightEffectClips, beginNormalized);
				}
				else if (value is TimelineRadialBlurClipPlayer)
				{
					(value as TimelineRadialBlurClipPlayer).Initialize(timelineInfo.radialBlurClips, beginNormalized);
				}
				else if (value is TimelineCharacterGhostEffectClipPlayer)
				{
					(value as TimelineCharacterGhostEffectClipPlayer).Initialize(timelineInfo.characterGhostEffectClips, beginNormalized);
				}
				else if (value is TimelineCharacterSliceEffectClipPlayer)
				{
					(value as TimelineCharacterSliceEffectClipPlayer).Initialize(timelineInfo.characterSliceEffectClips, beginNormalized);
				}
				else if (value is TimelineCharacterInterferenceEffectClipPlayer)
				{
					(value as TimelineCharacterInterferenceEffectClipPlayer).Initialize(timelineInfo.characterInterferenceEffectClips, beginNormalized);
				}
				else if (value is TimelineSceneSettingFogClipPlayer)
				{
					(value as TimelineSceneSettingFogClipPlayer).Initialize(timelineInfo.sceneSettingFogClips, beginNormalized);
				}
				else if (value is TimelineSceneSettingPostEffectClipPlayer)
				{
					(value as TimelineSceneSettingPostEffectClipPlayer).Initialize(timelineInfo.sceneSettingPostEffectClips, beginNormalized);
				}
				else if (value is TimelinePartsActivationPlayer)
				{
					(value as TimelinePartsActivationPlayer).Initialize(timelineInfo.hiddenPartsClips, beginNormalized);
				}
				else if (value is TimelineCharacterWeaponLineClipPlayer)
				{
					(value as TimelineCharacterWeaponLineClipPlayer).Initialize(timelineInfo.characterWeaponLineClips, beginNormalized);
				}
				else if (value is TimelineCameraGlitchEffectPlayer)
				{
					(value as TimelineCameraGlitchEffectPlayer).Initialize(timelineInfo.cameraGlitchClips, beginNormalized);
				}
				else if (value is TimelineCameraAbberationEffectPlayer)
				{
					(value as TimelineCameraAbberationEffectPlayer).Initialize(timelineInfo.cameraAbberationClips, beginNormalized);
				}
				else if (value is TimelineAudioEffectPlayer)
				{
					(value as TimelineAudioEffectPlayer).Initialize(timelineInfo.audioPlayActionClips, beginNormalized);
				}
				else if (value is TimelineAudioVoicePlayer)
				{
					(value as TimelineAudioVoicePlayer).Initialize(timelineInfo.audioPlayActionClips, beginNormalized);
				}
				else if (value is TimelineCameraAnimationFBXPlayer)
				{
					(value as TimelineCameraAnimationFBXPlayer).Initialize(timelineInfo.cameraAnimationFBXClips, beginNormalized);
				}
				else if (value is TimelineEarlyWarningClipPlayer)
				{
					(value as TimelineEarlyWarningClipPlayer).Initialize(timelineInfo.earlyWarningClips, beginNormalized);
				}
				else if (value is TimelineCameraDepthOfFieldClipPlayer)
				{
					(value as TimelineCameraDepthOfFieldClipPlayer).Initialize(timelineInfo.cameraDepthOfFieldClips, beginNormalized);
				}
				else if (value is TimelineCameraFOVClipPlayer)
				{
					(value as TimelineCameraFOVClipPlayer).Initialize(timelineInfo.cameraFOVClips, beginNormalized);
				}
				else if (value is TimelineCameraDollyShotClipPlayer)
				{
					(value as TimelineCameraDollyShotClipPlayer).Initialize(timelineInfo.CameraDollyShotClips, beginNormalized);
				}
				else if (value is TimelineCameraCraneShotClipPlayer)
				{
					(value as TimelineCameraCraneShotClipPlayer).Initialize(timelineInfo.CameraCraneShotClips, beginNormalized);
				}
				else if (value is TimelineCameraRotateClipPlayer)
				{
					(value as TimelineCameraRotateClipPlayer).Initialize(timelineInfo.CameraRotateClips, beginNormalized);
				}
				else if (value is TimelineCameraDampingClipPlayer)
				{
					(value as TimelineCameraDampingClipPlayer).Initialize(timelineInfo.CameraDampingClips, beginNormalized);
				}
				else if (value is TimelineCameraDarkCornerClipPlayer)
				{
					(value as TimelineCameraDarkCornerClipPlayer).Initialize(timelineInfo.darkCornerClips, beginNormalized);
				}
			}
			_connectionPlayer.Initialize(timelineInfo.lineConnectionClips, _agent);
			_lastNormalize = 0f;
			_currentNormalize = (float)((frame >= 0) ? frame : 0) / _timelineInfo.frameCount;
			_startFrameTime = Time.realtimeSinceStartup - _currentNormalize * _timelineInfo.duration;
			m_lastRealtimeSinceStartup = Time.realtimeSinceStartup;
			if (_isPause)
			{
				_pauseBeginTime = _startFrameTime;
			}
			(NScene.GetCurrentScene() as BattleScene).GetAgentManager().OnTimelinePlay?.Invoke((!(_agent == null)) ? _agent.AgentID : 0, _lastTimelineID, timelineInfoID);
		}
		if (timeScale != CurrentTimelineTimeScale)
		{
			CurrentTimelineTimeScale = timeScale;
			_needUpdateTimeScale = true;
		}
	}

	public void Play(int timelineInfoID, float timeScale = 1f, int frame = -1)
	{
		Play(timelineInfoID, Vector3.zero, Vector3.forward, usePosition: false, timeScale, frame);
	}

	private void ResetData(bool isForceCleanEffect = true)
	{
		_lastFrame = int.MaxValue;
		_pauseTime = 0f;
		_passNormalize = 0f;
		m_lastRealtimeSinceStartup = 0f;
		_lastNormalize = 0f;
		_currentNormalize = 0f;
		_isIgnoreEntityTimeScale = false;
		m_lastRuntimePoint = 0f;
		m_currentRuntimePoint = 0f;
		_startFrameTime = Time.realtimeSinceStartup;
		_effectPlayer.Clean(isForceCleanEffect);
		_animationPlay.Stop();
		_timelineCameraPlayer.Stop(isForceCleanEffect);
		_grabPlayer.Stop(isForceCleanEffect);
		Dictionary<Type, IClipPlayer>.Enumerator enumerator = m_type2Player.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.Stop(isForceCleanEffect);
		}
		_connectionPlayer.Shutdown();
	}

	public void Stop(bool isForceClean = true)
	{
		if (_isRun)
		{
			if (!isForceClean && _timelineInfo != null && _currentNormalize < _timelineInfo.EffectGiveUpRecoveryNormalized)
			{
				isForceClean = true;
			}
			ResetData(isForceClean);
			if (null != _timelineInfo)
			{
				_lastTimelineID = _timelineInfo.ID;
			}
			_isRun = false;
			_timelineInfo = null;
		}
	}

	public void Pause(bool isPause = true)
	{
		if (_isPause == isPause)
		{
			return;
		}
		_effectPlayer.Pause(isPause);
		_commonEffectPlayer.Pause(isPause);
		_commonEffectPlayerWithEntityScale.Pause(isPause);
		_animationPlay.Pause(isPause);
		_timelineCameraPlayer.Pause(isPause);
		_commonLinePlayer.Pause(isPause);
		_grabPlayer.Pause(isPause);
		Dictionary<Type, IClipPlayer>.Enumerator enumerator = m_type2Player.GetEnumerator();
		while (enumerator.MoveNext())
		{
			IClipPlayer value = enumerator.Current.Value;
			if (value is ITimeScalePlayer)
			{
				(value as ITimeScalePlayer).Pause(isPause);
			}
		}
		_isPause = isPause;
		if (isPause)
		{
			_pauseBeginTime = Time.realtimeSinceStartup;
			return;
		}
		_pauseTime += Time.realtimeSinceStartup - _pauseBeginTime;
		_pauseBeginTime = 0f;
	}

	public EffectController PlayeCommonEffect(string effectName, string handPointPath, Vector3 offset, Vector3 scale, Vector3 rotation, Vector3 forward, bool isAttach = false, bool isLoop = false, bool needManager = false, float normalize = 0f, float effectKeepTime = 5f, bool usePosition = false, Vector3 centerPos = default(Vector3), bool isLockEffectRotation = false, float timeScale = 1f)
	{
		bool isMainPlayeOrBossOrElitel = false;
		bool isFriend = false;
		if (null != _agent)
		{
			isMainPlayeOrBossOrElitel = CommonEffectClipPlayer.IsMainPlayeOrBossOrElitel(_agent.Blackboard as BBHumanoid);
			isFriend = CommonEffectClipPlayer.IsFriend(_agent.Blackboard as BBHumanoid);
		}
		return _commonEffectPlayer.Play(effectName, handPointPath, offset, scale, rotation, forward, isAttach, isLoop, needManager, normalize, effectKeepTime, usePosition, centerPos, isLockEffectRotation, isMainPlayeOrBossOrElitel, isFriend, isCameraEffect: false, timeScale);
	}

	public EffectController PlayeCommonEffectWithEntityScale(string effectName, string handPointPath, Vector3 offset, Vector3 scale, Vector3 rotation, Vector3 forward, bool isAttach = false, bool isLoop = false, bool needManager = false, float normalize = 0f, float effectKeepTime = 5f, bool usePosition = false, Vector3 centerPos = default(Vector3), bool isLockEffectRotation = false, float timeScale = 1f)
	{
		bool isMainPlayeOrBossOrElitel = false;
		bool isFriend = false;
		if (null != _agent)
		{
			isMainPlayeOrBossOrElitel = CommonEffectClipPlayer.IsMainPlayeOrBossOrElitel(_agent.Blackboard as BBHumanoid);
			isFriend = CommonEffectClipPlayer.IsFriend(_agent.Blackboard as BBHumanoid);
		}
		return _commonEffectPlayerWithEntityScale.Play(effectName, handPointPath, offset, scale, rotation, forward, isAttach, isLoop, needManager, normalize, effectKeepTime, usePosition, centerPos, isLockEffectRotation, isMainPlayeOrBossOrElitel, isFriend, isCameraEffect: false, timeScale);
	}

	public EffectController PlayLineEffect(string effectName, Transform startTrans, Transform endTrans, bool needManager = false, float effectKeepTime = 5f, float timeScale = 1f)
	{
		if (null != _agent)
		{
			CommonEffectClipPlayer.IsMainPlayeOrBossOrElitel(_agent.Blackboard as BBHumanoid);
		}
		return _commonLinePlayer.Play(effectName, startTrans, endTrans, needManager, effectKeepTime, timeScale);
	}

	public List<EffectController> GetTargetTimeLineEffectByName(string effectName)
	{
		return _effectPlayer.GetTargetEffectByName(effectName);
	}

	public void SetEarlyWarningPlay(bool active)
	{
		if (_timelineEarlyWarningClipPlayer != null)
		{
			_timelineEarlyWarningClipPlayer.IsPlayWarning = active;
		}
	}

	public void StopCommonEffect(string effectName)
	{
		if (_commonEffectPlayer != null)
		{
			_commonEffectPlayer.Stop(effectName);
		}
	}

	public void StopAllCommonEffect()
	{
		if (_commonEffectPlayer != null)
		{
			_commonEffectPlayer.StopAll();
		}
	}

	public void StopCommonTimeScaleEffect(string effectName)
	{
		if (_commonEffectPlayerWithEntityScale != null)
		{
			_commonEffectPlayerWithEntityScale.Stop(effectName);
		}
	}

	public void StopAllCommonTimeScaleEffect()
	{
		if (_commonEffectPlayerWithEntityScale != null)
		{
			_commonEffectPlayerWithEntityScale.StopAll();
		}
	}

	public void StopCommonLineEffect(string efffectName)
	{
		if (_commonLinePlayer != null)
		{
			_commonLinePlayer.Stop(efffectName);
		}
	}

	public void StopAllCommonLineEffect()
	{
		if (_commonLinePlayer != null)
		{
			_commonLinePlayer.StopAll();
		}
	}

	public void StopAllTimelineEffect()
	{
		if (_effectPlayer != null)
		{
			_effectPlayer.Clean();
		}
	}

	public void PlayCommonLine(string effectPath, Transform start, Transform end, float keepTime)
	{
		_commonLinePlayer.PlayLineEffect(effectPath, start, end, keepTime);
	}

	public float GetTransitionTime(int nextID)
	{
		if (null == _agent)
		{
			return 0f;
		}
		BBHumanoid bBHumanoid = _agent.Blackboard as BBHumanoid;
		RoleRenderConfig roleRenderConfig = ((null != bBHumanoid) ? bBHumanoid.RoleRenderConfig : null);
		if (null == roleRenderConfig)
		{
			return 0f;
		}
		List<AnimationTransitionInfo> animationTransition = roleRenderConfig.AnimationTransition;
		for (int i = 0; i < animationTransition.Count; i++)
		{
			if (animationTransition[i].from == _lastTimelineID % 1000 && animationTransition[i].to == nextID % 1000)
			{
				return animationTransition[i].time;
			}
		}
		return 0f;
	}

	public void UpdateTransform(Vector3 position, Vector3 forward)
	{
		_animationPlay.UpdateTransform(position, forward);
		_effectPlayer.UpdateTransform(position, forward);
		_grabPlayer.UpdateTransform(position, forward);
		Dictionary<Type, IClipPlayer>.Enumerator enumerator = m_type2Player.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.UpdateTransform(position, forward);
		}
	}

	public void Shutdown()
	{
		_effectPlayer.Shutdown();
		_commonEffectPlayer.Shutdown();
		_commonEffectPlayerWithEntityScale.Shutdown();
		_animationPlay.Shutdown();
		_timelineCameraPlayer.Shutdown();
		_grabPlayer.Shutdown();
		Dictionary<Type, IClipPlayer>.Enumerator enumerator = m_type2Player.GetEnumerator();
		while (enumerator.MoveNext())
		{
			enumerator.Current.Value.Shutdown();
		}
		_connectionPlayer.Shutdown();
		_commonLinePlayer.Shutdown();
		_timelineInfo = null;
		_isShutdown = true;
		_lastTimelineID = 0;
	}

	public void OnEnterPool()
	{
	}

	public void PlayCriwareCue(string pCueSheet, string pCueName, bool useStream, bool isVoice = false, int startTime = 0)
	{
		if (isVoice)
		{
			if (_AudioVoicePlayer != null)
			{
				_AudioVoicePlayer.PlayCriwareCue(pCueSheet, pCueName, useStream, out var _, startTime);
			}
		}
		else if (_audioCommonPlayer != null)
		{
			_audioCommonPlayer.PlayCriwareCue(pCueSheet, pCueName, useStream);
		}
	}

	public void StopCriwareCue(bool isVoice = false)
	{
		if (isVoice)
		{
			if (_AudioVoicePlayer != null)
			{
				_AudioVoicePlayer.StopCriwareCue();
			}
		}
		else if (_audioCommonPlayer != null)
		{
			_audioCommonPlayer.StopCriwareCue();
		}
	}

	public void StopTimelineEffectAudio()
	{
		if (_AudioEffectPlayer != null)
		{
			_AudioEffectPlayer.StopCriwareCue();
		}
	}

	public bool HasVoiceCD(int key)
	{
		if (_AudioVoicePlayer != null)
		{
			return _AudioVoicePlayer.HasVoiceCD(key);
		}
		return false;
	}

	public void AddVoiceCD(int key, float cd)
	{
		if (_AudioVoicePlayer != null)
		{
			_AudioVoicePlayer.AddVoiceCD(key, cd);
		}
	}

	public bool TryPlayRoleVoiceByConfig(int id, out RoleVoice roleVoice, int startTime)
	{
		if (_AudioVoicePlayer != null)
		{
			return _AudioVoicePlayer.TryPlayRoleVoiceByConfig(id, out roleVoice, startTime);
		}
		roleVoice = null;
		return false;
	}

	public void AddBuffRimLight(int buffID, float ratio, float soft, Color outer, Color inner, int order = 1)
	{
		if (_characterRimLightClipRegulator != null)
		{
			_characterRimLightClipRegulator.AddBuffRimLight(buffID, ratio, soft, outer, inner, order);
		}
	}

	public void RemoveBuffRimLight(int buffID)
	{
		if (_characterRimLightClipRegulator != null)
		{
			_characterRimLightClipRegulator.RemoveBuffRimLight(buffID);
		}
	}

	public void UpdateBuffRimLight(int buffID, float ratio, float soft)
	{
		if (_characterRimLightClipRegulator != null)
		{
			_characterRimLightClipRegulator.UpdateBuffRimLight(buffID, ratio, soft);
		}
	}

	public void ClearRemoveBuffRimList()
	{
		if (_characterRimLightClipRegulator != null)
		{
			_characterRimLightClipRegulator.ClearRemoveBuffRimList();
		}
	}

	public void DisableRenders()
	{
		if (_activePlayer != null)
		{
			_activePlayer.DisableRenders();
		}
		if (_effectPlayer != null)
		{
			_effectPlayer.DisableRenders();
		}
		if (_commonEffectPlayer != null)
		{
			_commonEffectPlayer.DisableRenders();
		}
		if (_commonEffectPlayerWithEntityScale != null)
		{
			_commonEffectPlayerWithEntityScale.DisableRenders();
		}
		if (_timelineEarlyWarningClipPlayer != null)
		{
			_timelineEarlyWarningClipPlayer.DisableRenders();
		}
		if (_commonLinePlayer != null)
		{
			_commonLinePlayer.DisableRenders();
		}
	}

	public void EnableRenders()
	{
		if (_activePlayer != null)
		{
			_activePlayer.EnableRenders();
		}
		if (_agent == null || _agent.Blackboard == null)
		{
			return;
		}
		BBHumanoid bBHumanoid = _agent.Blackboard as BBHumanoid;
		if (!(bBHumanoid != null) || bBHumanoid.m_NextSimFrameData == null || (bBHumanoid.m_NextSimFrameData.mIsHide & E_EntityHideType.Render) != E_EntityHideType.Render)
		{
			if (_effectPlayer != null)
			{
				_effectPlayer.EnableRenders();
			}
			if (_commonEffectPlayer != null)
			{
				_commonEffectPlayer.EnableRenders();
			}
			if (_commonEffectPlayerWithEntityScale != null)
			{
				_commonEffectPlayerWithEntityScale.EnableRenders();
			}
			if (_timelineEarlyWarningClipPlayer != null)
			{
				_timelineEarlyWarningClipPlayer.EnableRenders();
			}
			if (_commonLinePlayer != null)
			{
				_commonLinePlayer.EnableRenders();
			}
		}
	}

	public void SetRenderActive(int pIndex, bool pEnable)
	{
		if (_activePlayer != null)
		{
			_activePlayer.SetRenderActive(pIndex, pEnable);
		}
	}

	public void ResetRenderActive()
	{
		if (_activePlayer != null)
		{
			_activePlayer.ResetRenderActive();
		}
	}

	public void RegistRenderEnableFunc(Action<bool> action)
	{
		if (_activePlayer != null)
		{
			TimelinePartsActivationPlayer activePlayer = _activePlayer;
			activePlayer.RenderEnableFunc = (Action<bool>)Delegate.Combine(activePlayer.RenderEnableFunc, action);
		}
	}

	public void UnregistRenderEnableFunc(Action<bool> action)
	{
		if (_activePlayer != null)
		{
			TimelinePartsActivationPlayer activePlayer = _activePlayer;
			activePlayer.RenderEnableFunc = (Action<bool>)Delegate.Remove(activePlayer.RenderEnableFunc, action);
		}
	}

	public void SetShadowActive(bool pEnable)
	{
		if (_activePlayer != null)
		{
			_activePlayer.SetShadowActive(pEnable);
		}
	}

	public void AddBuffCameraAbberationEffect(int buffID, float abberationIntensity)
	{
		if (m_timelineCameraAbberationEffectPlayer != null)
		{
			m_timelineCameraAbberationEffectPlayer.AddBuffCameraAbberationEffect(buffID, abberationIntensity);
		}
	}

	public void RemoveBuffCameraAbberationEffect(int buffID)
	{
		if (m_timelineCameraAbberationEffectPlayer != null)
		{
			m_timelineCameraAbberationEffectPlayer.RemoveBuffCameraAbberationEffect(buffID);
		}
	}

	public void UpdateBuffCameraAbberationEffect(int buffID, float abberationIntensity)
	{
		if (m_timelineCameraAbberationEffectPlayer != null)
		{
			m_timelineCameraAbberationEffectPlayer.UpdateBuffCameraAbberationEffect(buffID, abberationIntensity);
		}
	}

	public void ClearBuffCameraAbberationEffect()
	{
		if (m_timelineCameraAbberationEffectPlayer != null)
		{
			m_timelineCameraAbberationEffectPlayer.ClearBuffCameraAbberationEffect();
		}
	}

	public void AddBuffCameraGlitchEffect(int buffID, float glitchIntensity, float glitchFrequency)
	{
		if (m_timelineCameraGlitchEffectPlayer != null)
		{
			m_timelineCameraGlitchEffectPlayer.AddBuffCameraGlitchEffect(buffID, glitchIntensity, glitchFrequency);
		}
	}

	public void RemoveBuffCameraGlitchEffect(int buffID)
	{
		if (m_timelineCameraGlitchEffectPlayer != null)
		{
			m_timelineCameraGlitchEffectPlayer.RemoveBuffCameraGlitchEffect(buffID);
		}
	}

	public void UpdateBuffCameraGlitchEffect(int buffID, float glitchIntensity)
	{
		if (m_timelineCameraGlitchEffectPlayer != null)
		{
			m_timelineCameraGlitchEffectPlayer.UpdateBuffCameraGlitchEffect(buffID, glitchIntensity);
		}
	}

	public void ClearBuffCameraGlitchEffect()
	{
		if (m_timelineCameraGlitchEffectPlayer != null)
		{
			m_timelineCameraGlitchEffectPlayer.ClearBuffCameraGlitchEffect();
		}
	}

	public void AddBuffCameraRadialBlurEffect(int buffID, float radialBlurScale)
	{
		if (m_timelineRadialBlurClipPlayer != null)
		{
			m_timelineRadialBlurClipPlayer.AddBuffCameraRadialBlurEffect(buffID, radialBlurScale);
		}
	}

	public void RemoveBuffCameraRadialBlurEffect(int buffID)
	{
		if (m_timelineRadialBlurClipPlayer != null)
		{
			m_timelineRadialBlurClipPlayer.RemoveBuffCameraRadialBlurEffect(buffID);
		}
	}

	public void UpdateBuffCameraRadialBlurEffect(int buffID, float radialBlurScale)
	{
		if (m_timelineRadialBlurClipPlayer != null)
		{
			m_timelineRadialBlurClipPlayer.UpdateBuffCameraRadialBlurEffect(buffID, radialBlurScale);
		}
	}

	public void ClearBuffCameraAbberationList()
	{
		if (m_timelineRadialBlurClipPlayer != null)
		{
			m_timelineRadialBlurClipPlayer.ClearBuffCameraAbberationList();
		}
	}

	public void AddBuffSceneSettingDynamicFogEffect(int buffID, float dynamicFogIntensity, EnMemberPositionOfFog enMemberPositionOfFog, EnMemberPositionOfFog enMemberPositionOfTintColor, Color fogColor, Color tintColor)
	{
		if (m_timelineSceneSettingFogClipPlayer != null)
		{
			m_timelineSceneSettingFogClipPlayer.AddBuffSceneSettingDynamicFogEffect(buffID, enMemberPositionOfFog, dynamicFogIntensity, enMemberPositionOfTintColor, fogColor, tintColor);
		}
	}

	public void RemoveBuffSceneSettingDynamicFogEffect(int buffID, EnMemberPositionOfFog enMemberPositionOfFog, EnMemberPositionOfFog enMemberPositionOfTintColor)
	{
		if (m_timelineSceneSettingFogClipPlayer != null)
		{
			m_timelineSceneSettingFogClipPlayer.RemoveBuffSceneSettingDynamicFogEffect(buffID, enMemberPositionOfFog, enMemberPositionOfTintColor);
		}
	}

	public void UpdateBuffSceneSettingDynamicFogEffect(int buffID, EnMemberPositionOfFog enMemberPositionOfFog, float dynamicFogIntensity, EnMemberPositionOfFog enMemberPositionOfTintColor, Color fogColor, Color tintColor)
	{
		if (m_timelineSceneSettingFogClipPlayer != null)
		{
			m_timelineSceneSettingFogClipPlayer.UpdateBuffSceneSettingDynamicFogEffect(buffID, enMemberPositionOfFog, dynamicFogIntensity, enMemberPositionOfTintColor, fogColor, tintColor);
		}
	}

	public void ClearBuffSceneSettingDynamicFogEffect()
	{
		if (m_timelineSceneSettingFogClipPlayer != null)
		{
			m_timelineSceneSettingFogClipPlayer.ClearBuffSceneSettingDynamicFogEffect();
		}
	}

	public void AddBuffCharacterInterenceEffect(int creationIndex, float intensity, int order = 1)
	{
		if (m_timelineCharacterInterferenceEffectClipPlayer != null)
		{
			m_timelineCharacterInterferenceEffectClipPlayer.AddBuffCharacterInterenceEffect(creationIndex, intensity, order);
		}
	}

	public void RemoveBuffCharacterInterenceEffect(int creationIndex)
	{
		if (m_timelineCharacterInterferenceEffectClipPlayer != null)
		{
			m_timelineCharacterInterferenceEffectClipPlayer.RemoveBuffCharacterInterenceEffect(creationIndex);
		}
	}

	public void UpdateBuffCharacterInterenceEffect(int creationIndex, float intensity)
	{
		if (m_timelineCharacterInterferenceEffectClipPlayer != null)
		{
			m_timelineCharacterInterferenceEffectClipPlayer.UpdateBuffCharacterInterenceEffect(creationIndex, intensity);
		}
	}

	public void ClearBuffCharacterInterenceEffect()
	{
		if (m_timelineCharacterInterferenceEffectClipPlayer != null)
		{
			m_timelineCharacterInterferenceEffectClipPlayer.ClearBuffCharacterInterenceEffect();
		}
	}

	public void PlayClosingAnimation()
	{
		if (_effectPlayer != null)
		{
			_effectPlayer.PlayClosingAnimation();
		}
	}

	public void FootstepCameraShakeEvent(TimelineCameraClip pClip)
	{
		if (_timelineCameraPlayer != null)
		{
			_timelineCameraPlayer.SetCameraShake(pClip);
		}
	}

	public void PlayCustomAnimation(string animationName, int layerIndex, float normalized)
	{
		if (_animationPlay != null)
		{
			_animationPlay.PlayCustomAnimation(animationName, layerIndex, normalized);
		}
	}

	public void SetTrigger(string triggerName)
	{
		if (_animationPlay != null)
		{
			_animationPlay.SetTrigger(triggerName);
		}
	}
}
