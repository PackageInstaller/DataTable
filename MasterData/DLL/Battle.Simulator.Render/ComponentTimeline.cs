using System;
using System.Collections.Generic;
using Config;
using Google.Protobuf.Collections;
using NetProcol;
using UnityEngine;
using UnityEngine.Pipelines.SimPipeline;

[RequireComponent(typeof(AttachPointSetup))]
[RequireComponent(typeof(ComponentCameraAnimation))]
[RequireComponent(typeof(CharacterEffect))]
public class ComponentTimeline : CMonoBehaviour
{
	public const string INT_CONDITION = "ActionId";

	public const string FLOAT_LEAN = "lean";

	public const string FLOAT_ANIMATION_STATE_SPEED_MULTIPLIER = "speed";

	public const string EMPTY_STATE_NAME = "Empty";

	public const string GROUND_LAYER_NAME = "ground";

	public string ChangeHitEffectPathByFlowCanvas = string.Empty;

	public bool ChangeHitEffectLockRotationByFlowCanvas;

	public const float ENTER_RELAX_TIME = 8f;

	public float EnterRelaxTime = 8f;

	public const float KeepBattleIdleTime = 2f;

	public const string HIT_FEEDBACK_LAYER_NAME = "HitFeedbackLayer";

	public const string MOVEMENT_LAYER_NAME = "Movement";

	protected Animator _animator;

	protected BBHumanoid m_Character;

	private AttachPointSetup _attachPointSetup;

	private List<Collider> _attachColliders;

	protected float _enterRelaxTimer;

	private int _frameCount;

	private int _lastHitCount;

	private float _currentHitHeight;

	private float _baseHeight;

	private Vector3 _localMovement = new Vector3(0f, 0f, 0f);

	protected E_DirectorStatus _status;

	protected TimelinePlayer _timelinePlayer = new TimelinePlayer();

	protected Vector3 _lastInput;

	private ComponentHealth _ComponentHealth;

	private Transform _shadow;

	private MeshRenderer m_shadowRenderer;

	private Transform _shadowPosition;

	protected CharacterEffect _characterEffect;

	private AutoGroundPointController _AutoGroundPointController;

	public ComponentPendant m_componentPendant;

	public ComponentIndicator m_componentIndicator;

	private ComponentCameraAnimation _componentCameraAnimation;

	private RangeIndicator m_rangeIndicator;

	public string RangeIndicatorPrefabPath = string.Empty;

	public LayerMask layerMaskGround;

	private Behaviour rigBuilder;

	private const float HIT_UP_BEGIN = 0f;

	private const float HIT_UP_PERCENT = 0.35f;

	private const float HIT_AIR_BEGIN = 0.35f;

	private const float HIT_AIR_PERCENT = 0.3f;

	private const float HIT_DOWN_BEGIN = 0.65f;

	private const float HIT_DOWN_PERCENT = 0.35f;

	protected int _lastMoveFrameNum;

	private bool m_relaxTimerActive = true;

	private int m_inDisableRender;

	public TimelinePlayer TimelinePlayer => _timelinePlayer;

	public E_DirectorStatus Status
	{
		get
		{
			return _status;
		}
		set
		{
			_status = value;
		}
	}

	public RangeIndicator RangeIndicatorCom
	{
		get
		{
			if (m_rangeIndicator == null)
			{
				GameObject gameObject = null;
				gameObject = ((!string.IsNullOrEmpty(RangeIndicatorPrefabPath)) ? Asset.Instantiate(RangeIndicatorPrefabPath) : Asset.Instantiate("Effect/tongyong/fx_aim_indicator"));
				m_rangeIndicator = gameObject.GetComponent<RangeIndicator>();
			}
			return m_rangeIndicator;
		}
	}

	public override void Initialize()
	{
		base.Initialize();
		m_Character = mAgent.Blackboard as BBHumanoid;
		_animator = base.transform.GetComponent<Animator>();
		_attachPointSetup = base.transform.GetComponent<AttachPointSetup>();
		InitializeColliders();
		BBCommom blackboard = mAgent.Blackboard;
		blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Combine(blackboard.ActionHandler, new BBCommom.AgentActionHandler(HandleAction));
		RoleRenderConfig role = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().GetRole(m_Character.mAgent.AgentConfigID);
		if (null == role)
		{
			Debug.LogError("Can't Find Role RenderConfig by " + m_Character.mAgent.AgentConfigID);
		}
		_AutoGroundPointController = base.transform.GetComponentInChildren<AutoGroundPointController>();
		if (role.LineConnectionConfigs != null && role.LineConnectionConfigs.Count > 0)
		{
			U3DUtil.Get<CharacterWeaponLinesHelper>(base.gameObject).Initialize(role.LineConnectionConfigs, _attachPointSetup);
		}
		_timelinePlayer.Initialize(base.transform, m_Character.mAgent, m_Character.mAgent.AgentID);
		_baseHeight = 0f;
		_frameCount = 0;
		_lastHitCount = 0;
		_localMovement = new Vector3(0f, 0f, 0f);
		_status = E_DirectorStatus.Idle;
		_characterEffect = base.transform.GetComponent<CharacterEffect>();
		if (null == _shadow && null != _characterEffect && !_characterEffect.shadowEnabled)
		{
			_shadowPosition = _attachPointSetup.GetAttachPoint(En_BaseAttachPointType.HitPoint);
			if (null != _shadowPosition)
			{
				_shadow = Asset.Instantiate("Char/Shadow").transform;
				m_shadowRenderer = _shadow.GetComponent<MeshRenderer>();
				m_shadowRenderer.material.SetColor("_TintColor", UnityEngine.Pipelines.SimPipeline.RenderSettings.groundShadowColor);
				float num = (float)m_Character.RoleLogicConfig.Radius.get_Item(0) / 1000f * 2.8f;
				_shadow.localScale = new Vector3(num, num, num);
			}
		}
		if ((int)layerMaskGround == 0)
		{
			layerMaskGround = LayerMask.NameToLayer("ground");
		}
		_timelinePlayer.Play((m_Character.m_NextSimFrameData.mAbilityID != 0) ? m_Character.m_NextSimFrameData.mAbilityID : m_Character.IdleID);
		_componentCameraAnimation = base.transform.GetComponent<ComponentCameraAnimation>();
		rigBuilder = base.transform.GetComponent("RigBuilder") as Behaviour;
		RegistRenderEnableFunc(OnRenderActive);
	}

	private void InitializeColliders()
	{
		Collider[] componentsInChildren = base.transform.GetComponentsInChildren<Collider>();
		if (componentsInChildren == null)
		{
			return;
		}
		foreach (Collider collider in componentsInChildren)
		{
			if (collider != null)
			{
				if (_attachColliders == null)
				{
					_attachColliders = new List<Collider>();
				}
				_attachColliders.Add(collider);
			}
		}
	}

	public void UnbindHandleAction()
	{
		if (mAgent != null)
		{
			BBCommom blackboard = mAgent.Blackboard;
			blackboard.ActionHandler = (BBCommom.AgentActionHandler)Delegate.Remove(blackboard.ActionHandler, new BBCommom.AgentActionHandler(HandleAction));
		}
	}

	private void HandleAction(AgentAction action)
	{
		if (action is AgentActionAbilityEnter)
		{
			_status = E_DirectorStatus.Attcking;
			AgentActionAbilityEnter agentActionAbilityEnter = action as AgentActionAbilityEnter;
			_frameCount = agentActionAbilityEnter.mFrameCount;
			if (agentActionAbilityEnter.mAblityID == 0)
			{
				_timelinePlayer.Stop(isForceClean: false);
			}
			else
			{
				if (agentActionAbilityEnter.mAblityID <= 0)
				{
					return;
				}
				int mAblityID = agentActionAbilityEnter.mAblityID;
				TimelineInfo timelineInfo = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().Get(mAblityID);
				if (null != timelineInfo)
				{
					if (timelineInfo.UseLastHeight)
					{
						_baseHeight = base.transform.position.y;
					}
					if (timelineInfo.CloseRigBuiderCom && rigBuilder != null)
					{
						rigBuilder.enabled = false;
					}
					else if (!timelineInfo.CloseRigBuiderCom && rigBuilder != null)
					{
						rigBuilder.enabled = true;
					}
					_timelinePlayer.Play(agentActionAbilityEnter.mAblityID, agentActionAbilityEnter.mTimeScale, agentActionAbilityEnter.mFrameCount);
				}
			}
		}
		else if (action is AgentActionHitRecoverEnter)
		{
			if (!m_Character.IsCaught)
			{
				AgentActionHitRecoverEnter obj = action as AgentActionHitRecoverEnter;
				TimelineInfo timelineInfo2 = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().Get(m_Character.m_NextSimFrameData.mHitRecoverActionID);
				if (null != timelineInfo2 && timelineInfo2.CloseRigBuiderCom && rigBuilder != null)
				{
					rigBuilder.enabled = false;
				}
				else if (null != timelineInfo2 && !timelineInfo2.CloseRigBuiderCom && rigBuilder != null)
				{
					rigBuilder.enabled = true;
				}
				if (obj.IsReset)
				{
					_lastHitCount = 0;
					UpdateHitRecoverOriginHeight();
				}
				EnterHitRecover();
			}
		}
		else if (action is AgentActionHitAbilityChange)
		{
			UpdateHitRecoverOriginHeight();
		}
		else if (action is AgentActionHurt)
		{
			ShowHitEffect(action as AgentActionHurt);
		}
		else if (action is AgentActionHitRecoverLeave)
		{
			if (E_DirectorStatus.Recover == _status)
			{
				_status = E_DirectorStatus.RecoverLeave;
			}
			_lastHitCount = 0;
			if (rigBuilder != null && !rigBuilder.enabled)
			{
				rigBuilder.enabled = true;
			}
		}
		else if (action is AgentActionAbilityLeave)
		{
			if (E_DirectorStatus.Attcking == _status)
			{
				_status = E_DirectorStatus.Idle;
			}
			if (rigBuilder != null && !rigBuilder.enabled)
			{
				rigBuilder.enabled = true;
			}
			_timelinePlayer.Stop(isForceClean: false);
		}
		else if (action is AgentActionTimeStepChange)
		{
			AgentActionTimeStepChange agentActionTimeStepChange = action as AgentActionTimeStepChange;
			if (null != _timelinePlayer.TimelineInfo && (agentActionTimeStepChange.mAbilityID == _timelinePlayer.TimelineInfo.ID || agentActionTimeStepChange.mIsIdle))
			{
				_timelinePlayer.CurrentTimelineTimeScale = agentActionTimeStepChange.mTimeScale;
				_timelinePlayer.UpdateWorldAndEntityTimeScale(agentActionTimeStepChange.mTimeScale);
			}
		}
		else if (action is AgentActionSubJoystickCommandEnter)
		{
			AbilityRangeIndicator config = ConfigHelper.GetInstance().GetConfig<AbilityRangeIndicator>(m_Character.m_NextSimFrameData.mSubJoysitckTimelineID);
			RangeIndicatorPrefabPath = config.AssetPath;
		}
		else if (action is AgentActionSubJoystickCommandUpdate)
		{
			AgentActionSubJoystickCommandUpdate agentActionSubJoystickCommandUpdate = action as AgentActionSubJoystickCommandUpdate;
			Vector3 position = (Vector3)SubJoystickCommand.CommandCodeToLocalPosition(agentActionSubJoystickCommandUpdate.CommandCode, agentActionSubJoystickCommandUpdate.TimelineID);
			AbilityRangeIndicator config2 = ConfigHelper.GetInstance().GetConfig<AbilityRangeIndicator>(agentActionSubJoystickCommandUpdate.TimelineID);
			public_skill config3 = ConfigHelper.GetInstance().GetConfig<public_skill>(agentActionSubJoystickCommandUpdate.TimelineID);
			RangeIndicatorCom.DrawIndicatorByPosition(base.transform.position, base.transform.TransformPoint(position), (float)config3.Range / 1000f, (float)config2.DamageIndicatorRadius / 1000f);
			RangeIndicatorCom.Play();
		}
		else if (action is AgentActionSubJoystickCommandExit)
		{
			RangeIndicatorCom.Stop();
			m_rangeIndicator = null;
		}
		else if (action is AgentActionHide)
		{
			if ((action as AgentActionHide).IsHide)
			{
				DisableRenders();
			}
			else
			{
				EnableRenders();
			}
		}
	}

	private void ShowHitEffect(AgentActionHurt hurtAction)
	{
		switch (hurtAction.damageType)
		{
		case DamageType.Damage:
		case DamageType.Crit:
		case DamageType.Skill:
		case DamageType.HighDamage:
		case DamageType.HighDamageCrit:
			if (hurtAction.ThrownID != 0)
			{
				ThrownManager thrownManager = (NScene.GetCurrentScene() as BattleScene).GetBattleSimulatorSystem().ThrownManager;
				if (thrownManager != null && thrownManager.TryGetThrown(hurtAction.ThrownID, out var thrownStateOfRender))
				{
					TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(hurtAction.ActionID);
					PlayHitEffectAndAudio(timelineInfo, thrownStateOfRender.CreationIndex, hurtAction.partID);
				}
			}
			else
			{
				TimelineInfo timelineInfo2 = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(hurtAction.ActionID);
				PlayHitEffectAndAudio(timelineInfo2, hurtAction.SourceID, hurtAction.partID);
			}
			break;
		default:
			Debug.LogError("====>>>>> 来源TimelineID " + hurtAction.ActionID + " 未处理类型:" + hurtAction.damageType);
			break;
		case DamageType.Missing:
		case DamageType.Buff:
		case DamageType.Defense:
		case DamageType.CritRecover:
		case DamageType.Recover:
		case DamageType.Absorb:
		case DamageType.AffixDamage:
		case DamageType.Immune:
			break;
		}
	}

	private void PlayHitEffectAndAudio(TimelineInfo timelineInfo, int sourcerID, int shapePartID)
	{
		int index = 0;
		if (timelineInfo == null || timelineInfo.hitEffects == null || timelineInfo.hitEffects.Count <= 0)
		{
			return;
		}
		if (m_Character.m_NextSimFrameData.HitCount >= 0)
		{
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(timelineInfo.ID);
			if (m_Character.m_NextSimFrameData.HitCount < config.HitTimeList.Count)
			{
				HitCheckInfo hitCheckInfo = config.HitTimeList.get_Item(m_Character.m_NextSimFrameData.HitCount);
				if (hitCheckInfo.HitCheckID < timelineInfo.hitEffects.Count)
				{
					index = hitCheckInfo.HitCheckID;
				}
			}
		}
		TimelineHitRenderClip timelineHitRenderClip = timelineInfo.hitEffects[index];
		public_skill config2 = ConfigHelper.GetInstance().GetConfig<public_skill>(timelineInfo.ID);
		if (config2 == null)
		{
			return;
		}
		SkillDamageType skillDamageType = (SkillDamageType)config2.SkillDamageType;
		if (skillDamageType == SkillDamageType.Random)
		{
			if (sourcerID < 0)
			{
				ThrownManager thrownManager = ((BattleScene)NScene.GetCurrentScene()).GetBattleSimulatorSystem().ThrownManager;
				if (thrownManager != null && thrownManager.TryGetThrown(sourcerID, out var thrownStateOfRender))
				{
					MemberPosition memberPositionByAgentID = AgentManager.GetAgentManager().GetMemberPositionByAgentID(thrownStateOfRender.CasterID);
					RepeatedField<RoleDataForExchangeInfo> roleDataInLua = ((BattleScene)NScene.GetCurrentScene()).ready.SceneDataForExcehange.RoleDataInLua;
					if (memberPositionByAgentID != MemberPosition.None && roleDataInLua.Count > (int)memberPositionByAgentID)
					{
						RoleDataForExchangeInfo roleDataForExchangeInfo = roleDataInLua.get_Item((int)memberPositionByAgentID);
						int num = roleDataForExchangeInfo.AttributeID.IndexOf(2222);
						if (roleDataForExchangeInfo.AttributeValue.Count > num && num >= 0)
						{
							skillDamageType = (SkillDamageType)roleDataForExchangeInfo.AttributeValue.get_Item(num);
						}
					}
				}
			}
			else
			{
				MemberPosition memberPositionByAgentID2 = AgentManager.GetAgentManager().GetMemberPositionByAgentID(sourcerID);
				RepeatedField<RoleDataForExchangeInfo> roleDataInLua2 = ((BattleScene)NScene.GetCurrentScene()).ready.SceneDataForExcehange.RoleDataInLua;
				if (memberPositionByAgentID2 != MemberPosition.None && roleDataInLua2.Count > (int)memberPositionByAgentID2)
				{
					RoleDataForExchangeInfo roleDataForExchangeInfo2 = roleDataInLua2.get_Item((int)memberPositionByAgentID2);
					int num2 = roleDataForExchangeInfo2.AttributeID.IndexOf(2222);
					if (roleDataForExchangeInfo2.AttributeValue.Count > num2 && num2 >= 0)
					{
						skillDamageType = (SkillDamageType)roleDataForExchangeInfo2.AttributeValue.get_Item(num2);
					}
				}
			}
		}
		PlayHitEffect(timelineInfo, sourcerID, skillDamageType, timelineHitRenderClip, shapePartID);
		PlayHitAudio(sourcerID, skillDamageType, timelineHitRenderClip);
	}

	public void PlayHitEffect(TimelineInfo timelineInfo, int sourcerID, SkillDamageType publicSkillData, TimelineHitRenderClip timelineHitRenderClip, int shapePartID)
	{
		string hitEffectPath = timelineHitRenderClip.hitEffectPath;
		if (string.IsNullOrEmpty(hitEffectPath))
		{
			hitEffectPath = GetHitEffectPath(timelineHitRenderClip.WeaponCategory, timelineHitRenderClip.AttackActionCategory, publicSkillData, m_Character.RoleLogicConfig.ArmourCategory);
		}
		bool isLockRotaion = timelineHitRenderClip.isLockRotaion;
		ChangeHitEffectPathByFlowCanvas = hitEffectPath;
		ChangeHitEffectLockRotationByFlowCanvas = isLockRotaion;
		Action<PlayHitEffectData> beforePlayHitEffect = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().BeforePlayHitEffect;
		if (beforePlayHitEffect != null)
		{
			PlayHitEffectData playHitEffectData = FrameObjectPool<PlayHitEffectData>.Claim();
			playHitEffectData.CasterID = sourcerID;
			playHitEffectData.DefenseID = m_Character.mAgent.AgentID;
			playHitEffectData.TimelineID = timelineInfo.ID;
			playHitEffectData.EffectPath = hitEffectPath;
			playHitEffectData.IsLockRotaion = timelineHitRenderClip.isLockRotaion;
			beforePlayHitEffect(playHitEffectData);
			FrameObjectPool<PlayHitEffectData>.Release(playHitEffectData);
		}
		hitEffectPath = ChangeHitEffectPathByFlowCanvas;
		isLockRotaion = ChangeHitEffectLockRotationByFlowCanvas;
		string attachPointPath = _attachPointSetup.GetAttachPointPath(En_BaseAttachPointType.HitPoint);
		if (!string.IsNullOrEmpty(hitEffectPath))
		{
			if (string.IsNullOrEmpty(attachPointPath))
			{
				attachPointPath = _attachPointSetup.GetAttachPointPath("gua_hit");
			}
			bool num = PlayEffectOnCollisionCheck(hitEffectPath, timelineHitRenderClip, sourcerID, out var hitPosition, out var castor, shapePartID);
			if (!num)
			{
				EffectController effectController = CommonEffectClipPlayer.PlayEffect(base.transform, hitEffectPath, attachPointPath, Vector3.zero, timelineHitRenderClip.scale, timelineHitRenderClip.rotation, m_Character.CurrentFaceDirection, timelineHitRenderClip.isAttach, isLoop: false, 1f, 0f, 5f, usePosition: false, Vector3.zero, isLockRotaion, null, isCameraEffect: false, CommonEffectClipPlayer.IsMainPlayeOrBossOrElitel(castor), CommonEffectClipPlayer.IsFriend(castor));
				if (effectController != null)
				{
					effectController.mReuseOldestGameobject = true;
					effectController.IgnoreTimeScale = true;
				}
				PlayHitFeedbackAnimation("gua_Hit");
			}
			if (!num)
			{
				hitPosition = _attachPointSetup.GetAttachPoint(En_BaseAttachPointType.HitPoint).position;
			}
			AddHitTipPosition(timelineInfo.ID, hitPosition);
		}
		else
		{
			Debug.LogError("===>>> CommonHit 未配置受击特效, 武器类型:" + timelineHitRenderClip.WeaponCategory.ToString() + ", 动作类型:" + timelineHitRenderClip.AttackActionCategory.ToString() + ", 伤害类型:" + publicSkillData.ToString() + ", 受击者护甲类型:" + m_Character.RoleLogicConfig.ArmourCategory);
		}
	}

	public void PlayHitFeedbackAnimation(string pEffectAttchPoint)
	{
		if (m_Character == null)
		{
			return;
		}
		int agentConfigID = m_Character.mAgent.AgentConfigID;
		HitFeedback config = null;
		if (!ConfigHelper.GetInstance().TryGetConfig<HitFeedback>(agentConfigID, out config))
		{
			return;
		}
		int layerIndex = _animator.GetLayerIndex("HitFeedbackLayer");
		if (layerIndex == -1)
		{
			Debug.LogError("=====>>>>> 角色:" + agentConfigID + " 的动画机没有配置受击反馈层 HitFeedbackLayer");
			return;
		}
		string text = config.DefaultAnimationName;
		if (string.IsNullOrEmpty(text))
		{
			text = pEffectAttchPoint;
		}
		int num = Animator.StringToHash(text);
		if (_animator.HasState(layerIndex, num))
		{
			_animator.Play(num, layerIndex, 0f);
		}
		else
		{
			Debug.LogError("=====>>>>> 角色:" + agentConfigID + " 受击反馈层 HitFeedbackLayer 中没有配置对应动画状态:" + text);
		}
	}

	private void PlayHitAudio(int pSourceID, SkillDamageType publicSkill, TimelineHitRenderClip timelinehitRenderClip)
	{
		CriwareCueInfo customHitAudioCriwareInfo = timelinehitRenderClip.CustomHitAudioCriwareInfo;
		if (!string.IsNullOrEmpty(timelinehitRenderClip.CustomHitAudioCriwareInfo.mCueSheet) && !string.IsNullOrEmpty(timelinehitRenderClip.CustomHitAudioCriwareInfo.mCueName))
		{
			PlayAudio(customHitAudioCriwareInfo.mCueSheet, customHitAudioCriwareInfo.mCueName, !string.IsNullOrEmpty(customHitAudioCriwareInfo.mCueAwb));
			return;
		}
		string text = string.Empty;
		int num = pSourceID;
		if (pSourceID <= 0 && (NScene.GetCurrentScene() as BattleScene).GetBattleSimulatorSystem().ThrownManager.TryGetThrown(pSourceID, out var thrownStateOfRender))
		{
			num = thrownStateOfRender.CasterID;
		}
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager == null)
		{
			return;
		}
		int id = 0;
		NAgent agent = agentManager.GetAgent(num);
		if (agent != null)
		{
			id = agent.AgentSkinID;
		}
		if (num > 0 && num == agentManager.mPlayerAgentID)
		{
			text = "_1P";
		}
		if (mAgent != null && mAgent.IsLocalPlayer)
		{
			text = "_1P";
		}
		if (ConfigHelper.GetInstance().TryGetConfig<SpCharactorHitAudio>(id, out var config))
		{
			int num2 = m_Character.RoleLogicConfig.ArmourCategory switch
			{
				ArmourCategory.Body => config.AudioIDBody, 
				ArmourCategory.Metal => config.AudioIDMetal, 
				ArmourCategory.LightArmour => config.AudioIDLightArmour, 
				ArmourCategory.HeavyArmour => config.AudioIDHeavyArmour, 
				_ => 0, 
			};
			if (num2 != 0 && ConfigHelper.GetInstance().TryGetConfig<CommonAudio>(num2, out var config2))
			{
				string cueName = (string.IsNullOrEmpty(text) ? config2.CueName : (config2.CueName + text));
				PlayAudio(config2.CueSheet, cueName, config2.UseStream);
				return;
			}
		}
		RunTimeTimelineAndHitCache timelineAndHitCache = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache();
		if (timelineAndHitCache != null && timelineAndHitCache.TryGetHitAudio(timelinehitRenderClip.WeaponCategory, timelinehitRenderClip.AttackActionCategory, publicSkill, m_Character.RoleLogicConfig.ArmourCategory, out var pCueName, out var pSheetName, out var pAwbName))
		{
			PlayAudio(pSheetName, string.IsNullOrEmpty(text) ? pCueName : (pCueName + text), pAwbName);
			return;
		}
		Debug.LogError("===>>> CommonHit 未配置音效, 技能ID:, 武器类型:" + timelinehitRenderClip.WeaponCategory.ToString() + ", 动作类型:" + timelinehitRenderClip.AttackActionCategory.ToString() + ", 伤害类型:" + publicSkill.ToString() + ", 受击者护甲类型:" + m_Character.RoleLogicConfig.ArmourCategory);
	}

	private Vector3 GetShapePosByShapeID(int shapeID)
	{
		if (m_Character == null || m_Character.m_NextSimFrameData == null || m_Character.m_NextSimFrameData.mShapeStates == null)
		{
			return Vector3.zero;
		}
		for (int i = 0; i < m_Character.m_NextSimFrameData.mShapeStates.Count; i++)
		{
			ShapeState shapeState = m_Character.m_NextSimFrameData.mShapeStates[i];
			if (shapeState.mShapeEntityID == shapeID)
			{
				return (Vector3)shapeState.mWorldPos + new Vector3(0f, 1.5f, 0f);
			}
		}
		return Vector3.zero;
	}

	private bool PlayEffectOnCollisionCheck(string hitEffectPath, TimelineHitRenderClip timelinehitRenderClip, int sourceID, out Vector3 hitPosition, out BBHumanoid castor, int shapePartID)
	{
		hitPosition = Vector3.zero;
		castor = m_Character;
		if (!timelinehitRenderClip.NeedUseCollision)
		{
			return false;
		}
		if (mAgent == null)
		{
			return false;
		}
		bool flag = false;
		RaycastHit closestHitInfo = default(RaycastHit);
		Vector3 sourcePosition = base.transform.position;
		Vector3 forward = base.transform.forward;
		if (sourceID < 0)
		{
			ThrownManager thrownManager = ((BattleScene)NScene.GetCurrentScene()).GetBattleSimulatorSystem().ThrownManager;
			if (thrownManager != null && thrownManager.TryGetThrown(sourceID, out var thrownStateOfRender))
			{
				sourcePosition = thrownStateOfRender.LogicPosition;
				flag = EffectOverlapUtil.OverlapCloseHit(thrownStateOfRender.LogicLastPosition.AddY(1.5f), _attachColliders, out closestHitInfo, GetShapePosByShapeID(shapePartID));
				NAgent agent = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(thrownStateOfRender.CasterID);
				if (agent != null)
				{
					castor = agent.Blackboard as BBHumanoid;
				}
			}
		}
		else
		{
			NAgent agent2 = ((BattleScene)NScene.GetCurrentScene()).GetAgentManager().GetAgent(sourceID);
			if (null != agent2)
			{
				sourcePosition = (agent2.Blackboard as BBHumanoid).NextFramePosition;
				forward = agent2.Forward;
				flag = EffectOverlapUtil.OverlapCloseHit(agent2.transform.position.NewY(timelinehitRenderClip.CollisionCheckOffsetY), _attachColliders, out closestHitInfo, GetShapePosByShapeID(shapePartID));
				castor = agent2.Blackboard as BBHumanoid;
			}
		}
		if (flag)
		{
			Vector3 forward2 = FixHitEffectForward(closestHitInfo.normal, forward, sourcePosition, timelinehitRenderClip);
			hitPosition = closestHitInfo.point;
			EffectController effectController = CommonEffectClipPlayer.PlayEffect(hitEffectPath, closestHitInfo.point, timelinehitRenderClip.scale, timelinehitRenderClip.rotation, forward2, CommonEffectClipPlayer.IsMainPlayeOrBossOrElitel(castor), CommonEffectClipPlayer.IsFriend(castor));
			if (effectController != null)
			{
				effectController.mReuseOldestGameobject = true;
			}
			PlayHitFeedbackAnimation(closestHitInfo.transform.name);
		}
		return flag;
	}

	private Vector3 FixHitEffectForward(Vector3 effectForward, Vector3 sourceForward, Vector3 sourcePosition, TimelineHitRenderClip timelinehitRenderClip)
	{
		if (timelinehitRenderClip.IsCannonBallDust || timelinehitRenderClip.isLockRotaion)
		{
			return m_Character.NextFramePosition - sourcePosition;
		}
		return effectForward;
	}

	private void UpdateHitRecoverOriginHeight()
	{
		TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(m_Character.m_NextSimFrameData.HitAbilityID);
		int num = -1;
		Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(m_Character.m_NextSimFrameData.HitAbilityID);
		if (m_Character.m_NextSimFrameData.HitCount >= 0 && m_Character.m_NextSimFrameData.HitCount < config.HitTimeList.Count)
		{
			num = config.HitTimeList.get_Item(m_Character.m_NextSimFrameData.HitCount).HitCheckID;
		}
		if (num >= 0 && num < timelineInfo.hitEffects.Count)
		{
			TimelineHitRenderClip timelineHitRenderClip = timelineInfo.hitEffects[num];
			if (timelineHitRenderClip.UseHitCurve)
			{
				_currentHitHeight = timelineHitRenderClip.hitUpHeight;
			}
			else
			{
				_currentHitHeight = base.transform.position.y;
			}
		}
	}

	protected virtual void EnterHitRecover()
	{
		if (E_HitRecoverStatus.HitFloor == m_Character.m_NextSimFrameData.HitRecoverStatus)
		{
			base.transform.position = base.transform.position.NewY(0f);
		}
		int mHitRecoverActionID = m_Character.m_NextSimFrameData.mHitRecoverActionID;
		_lastHitCount = m_Character.m_NextSimFrameData.HitCount;
		int timelineInfoID = mHitRecoverActionID;
		_status = E_DirectorStatus.Recover;
		_timelinePlayer.Stop(isForceClean: false);
		_timelinePlayer.Play(timelineInfoID, m_Character.m_NextSimFrameData.HitRecoverTimeScale, m_Character.m_NextSimFrameData.HitRecoverFrame);
	}

	protected virtual void UpdateMovement()
	{
		if (null == m_Character)
		{
			return;
		}
		if (m_Character.FrameCount != 0)
		{
			float y = base.transform.position.y;
			if (m_Character.m_NextSimFrameData.IsTeleport)
			{
				base.transform.position = m_Character.NextFramePosition;
			}
			else
			{
				base.transform.position = Vector3.Lerp(m_Character.CurrentFramePosition, m_Character.NextFramePosition, BattleSimulatorSystem.GetSimPercent(m_Character.IsPrediction));
			}
			if (Physics.Raycast(base.transform.position + new Vector3(0f, 0.1f, 0f), Vector3.down, out var hitInfo, 0.5f, layerMaskGround))
			{
				base.transform.position = base.transform.position.NewY(hitInfo.point.y);
			}
			y -= base.transform.position.y;
			m_Character.LastHeight = y;
		}
		m_Character.currentMovement = m_Character.inputMovement;
		Vector3 b;
		if (m_Character.currentMovement.Direction.sqrMagnitude > 0.01f)
		{
			float num = 1f;
			Vector3 vector = Quaternion.Euler(0f, 0f - base.transform.eulerAngles.y, 0f) * m_Character.currentMovement.Direction;
			m_Character.currentMovement.Direction = Quaternion.Euler(0f, base.transform.eulerAngles.y, 0f) * vector;
			b = vector.normalized * m_Character.currentMovement.Magnitude * num;
		}
		else
		{
			b = Vector3.zero;
		}
		_localMovement = Vector3.Lerp(_localMovement, b, Time.deltaTime * 8f);
	}

	protected virtual void UpdateRotation()
	{
		if (!(null == m_Character))
		{
			Vector3 a = m_Character.LastFrameFaceDirection.NewY(0f);
			Vector3 b = m_Character.NextFrameFaceDirection.NewY(0f);
			Vector3 vector = Vector3.Slerp(a, b, BattleSimulatorSystem.GetSimPercent(m_Character.IsPrediction));
			if (!vector.IsTooSmall())
			{
				base.transform.rotation = Quaternion.LookRotation(vector);
			}
		}
	}

	public void EnableShadow(bool enable)
	{
		if (_shadow != null)
		{
			m_shadowRenderer.enabled = enable;
		}
	}

	private void DestroyShadow()
	{
		if (null != _shadow)
		{
			U3DUtil.Get<PooledAsset>(_shadow.gameObject).Return();
			_shadow = null;
		}
	}

	public override void UpdateBehavior()
	{
		base.UpdateBehavior();
		if ((bool)_timelinePlayer.TimelineInfo && _timelinePlayer.TimelineInfo.isFinalAbility)
		{
			DestroyShadow();
		}
		if (!m_Character.IsCaught)
		{
			UpdateMovement();
			UpdateRotation();
			CheckIdleOrMove();
			UpdateRelaxTimer();
		}
		_timelinePlayer.Update();
	}

	public override void ResetBehavior()
	{
		base.ResetBehavior();
		_timelinePlayer.Shutdown();
		_frameCount = 0;
		_lastHitCount = 0;
		_localMovement = new Vector3(0f, 0f, 0f);
		_status = E_DirectorStatus.Idle;
		m_Character = null;
		DestroyShadow();
		UnbindHandleAction();
		UnregistRenderEnableFunc(OnRenderActive);
	}

	private void UpdateRelaxTimer()
	{
		if (_status == E_DirectorStatus.Idle)
		{
			if (!IsInDisableRender() && m_relaxTimerActive && _timelinePlayer != null && !_timelinePlayer.IsPause)
			{
				_enterRelaxTimer += Time.deltaTime * _timelinePlayer.GetTimeScale();
			}
			if (_enterRelaxTimer >= EnterRelaxTime)
			{
				_status = E_DirectorStatus.Relax;
				TimelineInfo timelineInfo = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().Get(m_Character.RelaxID);
				_enterRelaxTimer = timelineInfo.duration;
			}
		}
		else if (E_DirectorStatus.Relax == _status)
		{
			if (_timelinePlayer != null && !_timelinePlayer.IsPause)
			{
				_enterRelaxTimer -= Time.deltaTime * _timelinePlayer.GetTimeScale();
			}
			if (_enterRelaxTimer <= 0f)
			{
				_enterRelaxTimer = 0f;
				_status = E_DirectorStatus.Idle;
			}
		}
		else
		{
			_enterRelaxTimer = 0f;
		}
	}

	private void UpdateHeightCurve()
	{
		if (!(null != _timelinePlayer.TimelineInfo) || !_timelinePlayer.TimelineInfo.UseRootMotionY)
		{
			return;
		}
		if (m_Character.m_NextSimFrameData.HitAbilityID != 0 && m_Character.m_NextSimFrameData.HitRecoverStatus != E_HitRecoverStatus.None)
		{
			TimelineInfo timelineInfo = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().Get(m_Character.m_NextSimFrameData.HitAbilityID);
			Timeline config = ConfigHelper.GetInstance().GetConfig<Timeline>(m_Character.m_NextSimFrameData.HitAbilityID);
			int num = -1;
			if (m_Character.m_NextSimFrameData.HitCount >= 0 && m_Character.m_NextSimFrameData.HitCount < config.HitTimeList.Count)
			{
				num = config.HitTimeList.get_Item(m_Character.m_NextSimFrameData.HitCount).HitCheckID;
			}
			if (num < 0 || num >= timelineInfo.hitEffects.Count)
			{
				return;
			}
			TimelineHitRenderClip timelineHitRenderClip = timelineInfo.hitEffects[num];
			if (timelineHitRenderClip.UseHitCurve)
			{
				float num2 = 0f;
				float num3 = 0f;
				float num4 = (float)m_Character.m_NextSimFrameData.HitRecoverTime / 1000f;
				TimelineInfo timelineInfo2 = ((BattleScene)NScene.GetCurrentScene()).GetTimelineAndHitCache().Get(m_Character.m_NextSimFrameData.mHitRecoverActionID);
				switch (m_Character.m_NextSimFrameData.HitRecoverStatus)
				{
				case E_HitRecoverStatus.HitAir:
					num3 = 0.35f + num4 / timelineInfo2.duration * 0.3f;
					num2 = timelineHitRenderClip.hitUpCurve.Evaluate(num3) * _currentHitHeight;
					break;
				case E_HitRecoverStatus.FloatUp:
					num3 = 0f + num4 / timelineInfo2.duration * 0.35f;
					num2 = timelineHitRenderClip.hitUpCurve.Evaluate(num3) * _currentHitHeight;
					num2 = Math.Max(num2, _timelinePlayer.TimelineInfo.ActionStartOffsetY);
					break;
				case E_HitRecoverStatus.FloatDown:
				{
					float num5 = (timelineHitRenderClip.UseHitDownDuration ? timelineHitRenderClip.HitDownDuration : timelineInfo2.duration);
					num3 = 0.65f + num4 / num5 * 0.35f;
					num2 = timelineHitRenderClip.hitUpCurve.Evaluate(num3) * _currentHitHeight;
					break;
				}
				case E_HitRecoverStatus.HitReocver:
					num3 = num4 / timelineInfo2.duration;
					num2 = timelineHitRenderClip.hitUpCurve.Evaluate(num3);
					break;
				}
				base.transform.position = base.transform.position.NewY(num2 + m_Character.NextFramePosition.y);
			}
			else if (null != _animator)
			{
				base.transform.position = base.transform.position.AddY(m_Character.LastHeight + _animator.deltaPosition.y);
			}
		}
		else
		{
			base.transform.position = base.transform.position.AddY(m_Character.LastHeight + _animator.deltaPosition.y);
		}
	}

	public virtual void CheckIdleOrMove()
	{
		if ((_status == E_DirectorStatus.Idle || E_DirectorStatus.Relax == _status) && null != m_Character)
		{
			if ((m_Character.inputMovement.Magnitude > 0f || m_Character.HasMoveDirectionInput) && m_Character.MovementStatus != EntityActionStatus.E_UNUSED)
			{
				_enterRelaxTimer = 0f;
				if (_lastInput == Vector3.zero)
				{
					_lastInput = base.transform.forward;
				}
				float value = Vector3.Dot(m_Character.MoveDirectionInputDirection.normalized, _lastInput);
				float num = ((!(Vector3.Cross(m_Character.MoveDirectionInputDirection.normalized, _lastInput).y > 0f)) ? 1 : (-1));
				value = Mathf.Clamp(value, -1f, 1f);
				float num2 = num * Mathf.Acos(value) * 57.29578f;
				if (Mathf.Abs(num2) > 1f)
				{
					float value2 = ((num2 > 0f) ? 1 : (-1));
					_animator.SetFloat("lean", value2, Time.deltaTime * 5f, Time.deltaTime);
				}
				else
				{
					_animator.SetFloat("lean", 0f, 1f, Time.deltaTime);
				}
				bool flag = false;
				if (m_Character.m_NextSimFrameData.MoveID == m_Character.m_LastSimFrameData.MoveID && _lastMoveFrameNum > m_Character.m_NextSimFrameData.MovementFrame)
				{
					flag = true;
				}
				if (_timelinePlayer.TimelineInfo != null && _timelinePlayer.TimelineInfo.ID != m_Character.m_NextSimFrameData.MoveID)
				{
					flag = true;
				}
				if (_status == E_DirectorStatus.Relax)
				{
					StopAudio(isVoice: true);
					flag = true;
				}
				if (flag)
				{
					_timelinePlayer.Stop(isForceClean: false);
				}
				if (m_Character.m_NextSimFrameData.MoveID != 0)
				{
					_timelinePlayer.Play(m_Character.m_NextSimFrameData.MoveID, m_Character.m_NextSimFrameData.MovementTimeScale);
				}
			}
			else
			{
				int num3 = m_Character.IdleID;
				switch (m_Character.m_LastSimFrameData.mIdleState)
				{
				case E_IdleType.Normal:
					num3 = ((E_DirectorStatus.Relax == _status) ? m_Character.RelaxID : m_Character.IdleID);
					break;
				case E_IdleType.Battle:
					num3 = m_Character.BattleIdleID;
					break;
				}
				if (_timelinePlayer.TimelineInfo != null && _timelinePlayer.TimelineInfo.ID != num3)
				{
					_timelinePlayer.Stop(isForceClean: false);
				}
				float timeScale = 1f;
				WorldStateManager worldStateManager = WorldStateManager.GetWorldStateManager();
				if (worldStateManager != null)
				{
					timeScale = (float)worldStateManager.worldTimeScale / 100f;
				}
				_timelinePlayer.Play(num3, timeScale);
			}
		}
		else if (_status == E_DirectorStatus.RecoverLeave && m_Character.m_NextSimFrameData.HitRecoverStatus == E_HitRecoverStatus.None && m_Character.m_LastSimFrameData.HitRecoverStatus == E_HitRecoverStatus.None)
		{
			_status = E_DirectorStatus.Idle;
			_animator.SetFloat("lean", 0f);
		}
		else
		{
			_animator.SetFloat("lean", 0f);
		}
		_lastInput = m_Character.MoveDirectionInputDirection.normalized;
		_lastMoveFrameNum = m_Character.m_NextSimFrameData.MovementFrame;
	}

	public void OnAnimatorMove()
	{
		if (m_Character == null)
		{
			return;
		}
		if (!m_Character.IsCaught)
		{
			UpdateHeightCurve();
		}
		if (_AutoGroundPointController != null && m_Character != null)
		{
			_AutoGroundPointController.UpdateHeigh(base.transform.position.NewY(m_Character.CurrentFramePosition.y + 0.02f));
		}
		if (_characterEffect != null)
		{
			_characterEffect.shadowHeight = base.transform.position.y;
		}
		if (_shadow != null && _shadowPosition != null)
		{
			if (m_Character != null)
			{
				_shadow.position = _shadowPosition.position.NewY(m_Character.CurrentFramePosition.y + 0.02f);
			}
			else
			{
				_shadow.position = _shadowPosition.position.NewY(base.transform.position.y + 0.02f);
			}
		}
		if (!(SceneDirector.Instance != null))
		{
			return;
		}
		BattleScene battleScene = NScene.GetCurrentScene() as BattleScene;
		if (battleScene != null && m_Character != null)
		{
			battleScene.GetAgentManager();
			if (battleScene.GetAgentManager().mPlayerAgentID == m_Character.mAgent.AgentID && !Mathf.Approximately(base.transform.position.y, battleScene.sceneSetting.waterSurfaceHeight))
			{
				battleScene.sceneSetting.waterSurfaceHeight = base.transform.position.y;
			}
		}
	}

	private string GetHitEffectPath(WeaponCategory pWeaponCategory, AttackActionCategory pAttackActionCategory, SkillDamageType pSkillDamageType, ArmourCategory pArmourCategory)
	{
		RunTimeTimelineAndHitCache timelineAndHitCache = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache();
		if (timelineAndHitCache != null && timelineAndHitCache.TryGetHitEffectPath(pWeaponCategory, pAttackActionCategory, pSkillDamageType, pArmourCategory, out var pHitEffectPath))
		{
			return pHitEffectPath;
		}
		return string.Empty;
	}

	public EffectController PlayCommonEffect(string pEffectPath, string pParentFullPath, Vector3 pOffsetPos, Vector3 pScale, Vector3 pOffsetRotation, Vector3 pForward, bool pIsAttach = false, bool pIsLoop = false, bool pNeedManager = false, float pNormalize = 0f, float pEffectKeepTime = 5f, bool pUsePosition = false, Vector3 pCenterPos = default(Vector3), bool pIsLockEffectRotation = false, float timeScale = 1f)
	{
		if (_timelinePlayer != null)
		{
			return _timelinePlayer.PlayeCommonEffect(pEffectPath, pParentFullPath, pOffsetPos, pScale, pOffsetRotation, pForward, pIsAttach, pIsLoop, pNeedManager, pNormalize, pEffectKeepTime, pUsePosition, pCenterPos, pIsLockEffectRotation, timeScale);
		}
		return null;
	}

	public EffectController PlayCommonTimeScaleEffect(string pEffectPath, string pParentFullPath, Vector3 pOffsetPos, Vector3 pScale, Vector3 pOffsetRotation, Vector3 pForward, bool pIsAttach = false, bool pIsLoop = false, bool pNeedManager = false, float pNormalize = 0f, float pEffectKeepTime = 5f, bool pUsePosition = false, Vector3 pCenterPos = default(Vector3), bool pIsLockEffectRotation = false, float timeScale = 1f)
	{
		if (_timelinePlayer != null)
		{
			return _timelinePlayer.PlayeCommonEffectWithEntityScale(pEffectPath, pParentFullPath, pOffsetPos, pScale, pOffsetRotation, pForward, pIsAttach, pIsLoop, pNeedManager, pNormalize, pEffectKeepTime, pUsePosition, pCenterPos, pIsLockEffectRotation, timeScale);
		}
		return null;
	}

	public void StopCommonEffect(string effectName)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.StopCommonEffect(effectName);
		}
	}

	public void StopAllCommonEffect()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.StopAllCommonEffect();
		}
	}

	public void StopCommonTimeScaleEffect(string effectName)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.StopCommonTimeScaleEffect(effectName);
		}
	}

	public void StopAllCommonTimeScaleEffect()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.StopAllCommonTimeScaleEffect();
		}
	}

	public EffectController PlayLineEffect(string effectName, Transform startTrans, Transform endTrans, bool needManager = false, float effectKeepTime = 5f, float timeScale = 1f)
	{
		if (_timelinePlayer != null)
		{
			return _timelinePlayer.PlayLineEffect(effectName, startTrans, endTrans, needManager, effectKeepTime, timeScale);
		}
		return null;
	}

	public void StopCommonLineEffect(string effectName)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.StopCommonLineEffect(effectName);
		}
	}

	public void StopAllCommonLineEffect()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.StopAllCommonLineEffect();
		}
	}

	public void StopAllTimelineEffect()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.StopAllTimelineEffect();
		}
	}

	public void OnDisable()
	{
		if (m_rangeIndicator != null)
		{
			RangeIndicatorCom.Stop();
			m_rangeIndicator = null;
		}
	}

	private void AddHitTipPosition(int abilityID, Vector3 position)
	{
		if (_ComponentHealth == null)
		{
			_ComponentHealth = base.gameObject.GetComponent<ComponentHealth>();
		}
		if (_ComponentHealth != null)
		{
			_ComponentHealth.AddHitTipPosition(abilityID, position);
		}
	}

	public void EnableRelaxTimer()
	{
		m_relaxTimerActive = true;
	}

	public void DisableRelaxTimer()
	{
		m_relaxTimerActive = false;
	}

	public void SetEnterRelaxTime(float time = 8f, bool resetCurTime = true)
	{
		EnterRelaxTime = time;
		if (resetCurTime)
		{
			_enterRelaxTimer = 0f;
		}
	}

	public void AddBuffRimLight(int buffID, float ratio, float soft, Color outer, Color inner, int order = 1)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.AddBuffRimLight(buffID, ratio, soft, outer, inner, order);
		}
	}

	public void RemoveBuffRimLight(int buffID)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.RemoveBuffRimLight(buffID);
		}
	}

	public void UpdateBuffRimLight(int buffID, float ratio, float soft)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.UpdateBuffRimLight(buffID, ratio, soft);
		}
	}

	public void ClearBuffRimList()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.ClearRemoveBuffRimList();
		}
	}

	public void FootstepEvent(AnimationEvent animationEvent)
	{
		int id = (int)animationEvent.floatParameter;
		int intParameter = animationEvent.intParameter;
		TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(id);
		if (timelineInfo != null && intParameter < timelineInfo.footstepEffectClips.Count)
		{
			TimelineEffectClip timelineEffectClip = timelineInfo.footstepEffectClips[intParameter];
			bool flag = false;
			if (timelineEffectClip.condition == EffectCondition.CanBeParry && m_Character != null)
			{
				flag = m_Character.m_NextSimFrameData.mAbilityCanBeParry;
			}
			_timelinePlayer.PlayeCommonEffect(flag ? timelineEffectClip.conditionEffectPath : timelineEffectClip.effectPath, timelineEffectClip.handPoint, timelineEffectClip.offset, timelineEffectClip.scale, timelineEffectClip.rotation, m_Character.CurrentFaceDirection, timelineEffectClip.isAttach, isLoop: false, needManager: false, 0f, timelineEffectClip.duration, usePosition: false, default(Vector3), timelineEffectClip.isLockRotaion, (timelineEffectClip.playTimeScale == 0f) ? 1f : timelineEffectClip.playTimeScale);
		}
	}

	public void CustomAnimationEvent(AnimationEvent animationEvent)
	{
		AgentManager agentManager = AgentManager.GetAgentManager();
		if (agentManager != null && agentManager.OnCustomAnimationEvent != null)
		{
			agentManager.OnCustomAnimationEvent(mAgent.AgentID, animationEvent);
		}
	}

	public void FootstepCameraShakeEvent(AnimationEvent animationEvent)
	{
		int id = (int)animationEvent.floatParameter;
		int intParameter = animationEvent.intParameter;
		TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(id);
		if (timelineInfo != null && intParameter < timelineInfo.footstepCameraShakeClips.Count)
		{
			TimelineCameraClip pClip = timelineInfo.footstepCameraShakeClips[intParameter];
			_timelinePlayer.FootstepCameraShakeEvent(pClip);
		}
	}

	public void FootstepAudioEvent(AnimationEvent animationEvent)
	{
		if (!animationEvent.animatorClipInfo.clip.name.Equals("run_turnround_left") && !animationEvent.animatorClipInfo.clip.name.Equals("run_turnround_right"))
		{
			int id = (int)animationEvent.floatParameter;
			int intParameter = animationEvent.intParameter;
			TimelineInfo timelineInfo = (NScene.GetCurrentScene() as BattleScene).GetTimelineAndHitCache().Get(id);
			if (timelineInfo != null && intParameter < timelineInfo.footstepAudioClips.Count)
			{
				AudioPlayActionClip audioPlayActionClip = timelineInfo.footstepAudioClips[intParameter];
				PlayAudio(audioPlayActionClip.CueSheet, audioPlayActionClip.CueName, !string.IsNullOrEmpty(audioPlayActionClip.AwbName), isVoice: false, audioPlayActionClip.StartTimeInMs);
			}
		}
	}

	private void OnRenderActive(bool flag)
	{
		if (mAgent != null)
		{
			mAgent.IsAlpha = !flag;
		}
	}

	public void DisableRenders()
	{
		m_inDisableRender++;
		_timelinePlayer.DisableRenders();
		if (m_componentPendant != null)
		{
			List<IPendant> pendants = m_componentPendant.GetPendants();
			for (int num = pendants.Count - 1; num >= 0; num--)
			{
				RenderPendant renderPendant = pendants[num] as RenderPendant;
				if (renderPendant != null)
				{
					renderPendant.DisableRenders();
				}
			}
		}
		if (m_componentIndicator != null)
		{
			m_componentIndicator.DisableRenders();
			m_componentIndicator.HideHeroIndicator();
		}
	}

	public bool IsInDisableRender()
	{
		return m_inDisableRender > 0;
	}

	public void EnableRenders()
	{
		m_inDisableRender--;
		_timelinePlayer.EnableRenders();
		if (m_componentPendant != null)
		{
			List<IPendant> pendants = m_componentPendant.GetPendants();
			for (int num = pendants.Count - 1; num >= 0; num--)
			{
				RenderPendant renderPendant = pendants[num] as RenderPendant;
				if (renderPendant != null)
				{
					renderPendant.EnableRenders();
				}
			}
		}
		if (m_componentIndicator != null)
		{
			m_componentIndicator.ShowHeroIndicator();
			m_componentIndicator.EnableRenders();
		}
	}

	public void SetRenderActive(int pIndex, bool pEnable)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.SetRenderActive(pIndex, pEnable);
		}
	}

	public void ResetRenderActive()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.ResetRenderActive();
		}
	}

	public void RegistRenderEnableFunc(Action<bool> action)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.RegistRenderEnableFunc(action);
		}
	}

	public void UnregistRenderEnableFunc(Action<bool> action)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.UnregistRenderEnableFunc(action);
		}
	}

	public void SetShadowActive(bool pEnable)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.SetShadowActive(pEnable);
		}
	}

	public void AddBuffCameraAbberationEffect(int buffID, float abberationIntensity)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.AddBuffCameraAbberationEffect(buffID, abberationIntensity);
		}
	}

	public void RemoveBuffCameraAbberationEffect(int buffID)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.RemoveBuffCameraAbberationEffect(buffID);
		}
	}

	public void UpdateBuffCameraAbberationEffect(int buffID, float abberationIntensity)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.UpdateBuffCameraAbberationEffect(buffID, abberationIntensity);
		}
	}

	public void ClearBuffCameraAbberationEffect()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.ClearBuffCameraAbberationEffect();
		}
	}

	public void AddBuffCameraGlitchEffect(int buffID, float glitchIntensity, float glitchFrequency)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.AddBuffCameraGlitchEffect(buffID, glitchIntensity, glitchFrequency);
		}
	}

	public void RemoveBuffCameraGlitchEffect(int buffID)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.RemoveBuffCameraGlitchEffect(buffID);
		}
	}

	public void UpdateBuffCameraGlitchEffect(int buffID, float glitchIntensity)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.UpdateBuffCameraGlitchEffect(buffID, glitchIntensity);
		}
	}

	public void ClearBuffCameraGlitchEffect()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.ClearBuffCameraGlitchEffect();
		}
	}

	public void AddBuffCameraRadialBlurEffect(int buffID, float radialBlurScale)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.AddBuffCameraRadialBlurEffect(buffID, radialBlurScale);
		}
	}

	public void RemoveBuffCameraRadialBlurEffect(int buffID)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.RemoveBuffCameraRadialBlurEffect(buffID);
		}
	}

	public void UpdateBuffCameraRadialBlurEffect(int buffID, float radialBlurScale)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.UpdateBuffCameraRadialBlurEffect(buffID, radialBlurScale);
		}
	}

	public void ClearBuffCameraAbberationList()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.ClearBuffCameraAbberationList();
		}
	}

	public void AddBuffSceneSettingDynamicFogEffect(int buffID, EnMemberPositionOfFog enMemberPositionOfFog, float dynamicFogIntensity, EnMemberPositionOfFog enMemberPositionOfTint, Color fogColor, Color tintColor)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.AddBuffSceneSettingDynamicFogEffect(buffID, dynamicFogIntensity, enMemberPositionOfFog, enMemberPositionOfTint, fogColor, tintColor);
		}
	}

	public void RemoveBuffSceneSettingDynamicFogEffect(int buffID, EnMemberPositionOfFog enMemberPositionOfFog, EnMemberPositionOfFog enMemberPositionOfTint)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.RemoveBuffSceneSettingDynamicFogEffect(buffID, enMemberPositionOfFog, enMemberPositionOfTint);
		}
	}

	public void UpdateBuffSceneSettingDynamicFogEffect(int buffID, EnMemberPositionOfFog enMemberPositionOfFog, float dynamicFogIntensity, EnMemberPositionOfFog enMemberPositionOfTint, Color fogColor, Color tintColor)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.UpdateBuffSceneSettingDynamicFogEffect(buffID, enMemberPositionOfFog, dynamicFogIntensity, enMemberPositionOfTint, fogColor, tintColor);
		}
	}

	public void ClearBuffSceneSettingDynamicFogEffect()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.ClearBuffSceneSettingDynamicFogEffect();
		}
	}

	public void AddBuffCharacterInterenceEffect(int creationIndex, float intensity, int order = 1)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.AddBuffCharacterInterenceEffect(creationIndex, intensity, order);
		}
	}

	public void RemoveBuffCharacterInterenceEffect(int creationIndex)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.RemoveBuffCharacterInterenceEffect(creationIndex);
		}
	}

	public void UpdateBuffCharacterInterenceEffect(int creationIndex, float intensity)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.UpdateBuffCharacterInterenceEffect(creationIndex, intensity);
		}
	}

	public void ClearBuffCharacterInterenceEffect()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.ClearBuffCharacterInterenceEffect();
		}
	}

	public void PlayAudio(string cueSheet, string cueName, bool useStream, bool isVoice = false, int startTime = 0)
	{
		if (string.IsNullOrEmpty(cueSheet))
		{
			Debug.LogError("请策划配置下音乐,角色ID:" + ((mAgent != null) ? mAgent.AgentConfigID : 0));
		}
		else if (_timelinePlayer != null)
		{
			_timelinePlayer.PlayCriwareCue(cueSheet, cueName, useStream, isVoice);
		}
	}

	public void StopAudio(bool isVoice = false)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.StopCriwareCue(isVoice);
		}
	}

	public void StopTimelineEffectAudio()
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.StopTimelineEffectAudio();
		}
	}

	public bool HasVoiceCD(int key)
	{
		if (_timelinePlayer != null)
		{
			return _timelinePlayer.HasVoiceCD(key);
		}
		return false;
	}

	public void AddVoiceCD(int key, float cd)
	{
		if (_timelinePlayer != null)
		{
			_timelinePlayer.AddVoiceCD(key, cd);
		}
	}

	public bool TryPlayRoleVoiceByConfig(int id, out RoleVoice roleVoice, int startTime)
	{
		if (_timelinePlayer != null)
		{
			return _timelinePlayer.TryPlayRoleVoiceByConfig(id, out roleVoice, startTime);
		}
		roleVoice = null;
		return false;
	}

	public void SetHideEffect(bool active)
	{
		if (_componentCameraAnimation != null)
		{
			_componentCameraAnimation.m_hide = active;
		}
	}
}
