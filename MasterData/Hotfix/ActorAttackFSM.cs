#define LOG_ERROR
using System;
using System.Collections.Generic;
using System.Linq;
using TrueSync;
using UnityEngine;

public class ActorAttackFSM : ActorFSM
{
	internal Combo currentCombo;

	internal ComboClip currentComboClip;

	internal ComboClip prevComboClip;

	internal Action onComboComplete;

	internal Action onComboInterupt;

	internal FP _comboTimer;

	internal FP _comboPlaySpeedMultiplier = 1f;

	internal FP _rootMotionScale = 1f;

	protected readonly List<Combo> _consumedCombos = new List<Combo>();

	private Dictionary<string, ComboClip> _variantComboClipDictForSkin;

	protected static readonly FP TRIGGER_EVENT_TIMER_NO_START = -1f;

	protected static readonly FP TRIGGER_EVENT_TIMER_FINISH = 1f;

	protected List<FP> _triggerEventTimers = new List<FP>(10);

	protected List<int> _triggerEventTriggerIndexes = new List<int>(10);

	protected List<Combo.Event> _triggeredEventsInLoopCombo = new List<Combo.Event>(10);

	protected Combo _processingCombo;

	protected ComboClip _processingComboClip;

	protected List<AdventureFXPlayer> _triggeredEventEffects = new List<AdventureFXPlayer>(10);

	protected List<long> _triggeredEventEffectTokens = new List<long>(10);

	protected AdventurePlayerFeedbackEffectConfigureData _currentPlayerFeedbackEffectConfigureData;

	protected long _cameraShakeUniqueId;

	protected long _racialBlurUniqueId;

	protected bool _interruptPlayerFeedbackEffect;

	private DeterministicShape _deterministicShape;

	private List<DeterministicCollider> _bulletCollider;

	protected int _currentFeaturePhaseIndex;

	protected int _nextFeaturePhaseIndex;

	protected FP _nextFeaturePhaseActiveNormalizedTime;

	private List<Combo.FeaturePhase> _phases = new List<Combo.FeaturePhase>();

	public Combo.FeaturePhase currentFeaturePhase;

	protected FP _lastRootMotionNormalizedTime;

	protected TSVector2 _lastRootMotionTranslate;

	protected TSVector2 _deltaRootMotionTranslate;

	protected FP _lastRootMotionRotateAngle;

	protected FP _deltaRootMotionRotateAngle;

	protected TSQuaternion _lastRootMotionRotation;

	public bool isPlayingCombo
	{
		get
		{
			if (currentCombo != null)
			{
				return currentComboClip != null;
			}
			return false;
		}
	}

	public bool isPlayingLoopCombo
	{
		get
		{
			if (isPlayingCombo)
			{
				return currentCombo.comboClipMode == Combo.ComboClipMode.Loop;
			}
			return false;
		}
	}

	protected bool isComboClipTool { get; set; }

	public bool isPlayingActionAnimation
	{
		get
		{
			if (currentCombo == null)
			{
				return currentComboClip != null;
			}
			return false;
		}
	}

	public bool applyRootMotion => iEnableRootMotion();

	private bool _applyRootMotion
	{
		get
		{
			if (currentComboClip != null)
			{
				return currentComboClip.enableRootMotion;
			}
			return false;
		}
	}

	public bool applyRootMotionRotate
	{
		get
		{
			if (currentComboClip != null)
			{
				return currentComboClip.enableRootMotionRotate;
			}
			return false;
		}
	}

	public FP lastRootMotionNormalizedTime => _lastRootMotionNormalizedTime;

	public TSVector2 lastRootMotionTranslate => _lastRootMotionTranslate;

	public TSVector2 deltaRootMotionTranslate => _deltaRootMotionTranslate;

	public FP lastRootMotionRotateAngle => _lastRootMotionRotateAngle;

	public FP deltaRootMotionRotateAngle => _deltaRootMotionRotateAngle;

	public ActorAttackFSM(GameObject actor)
		: base(actor)
	{
		_rootMotionScale = _actor.actorScaleInfo.modelScale;
	}

	public void SetRootMotionScale(FP scale)
	{
		_rootMotionScale = scale;
	}

	public override void Disable()
	{
		prevComboClip = null;
		StopCombo(fadeOutAnim: false);
		StopActionAnimation(fadeOutAnim: false);
		base.Disable();
	}

	public override void OnUpdate()
	{
		if (_actor.isControllable)
		{
			LogicEntity attackTarget = _actor.attackTarget;
			if (null != attackTarget)
			{
				_actor.lastAttackTargetDeterministicPosition = attackTarget.tsTransform.Position;
			}
			base.OnUpdate();
		}
	}

	public Combo SelectCombo()
	{
		if (_actor.comboGroup == null)
		{
			return null;
		}
		Combo combo = null;
		int i = 0;
		if (string.IsNullOrEmpty(_actor._actionTag))
		{
			for (; i < _actor.comboGroup.combos.Length; i++)
			{
				Combo combo2 = _actor.comboGroup.combos[i];
				if (combo2.useActionKeys && !_consumedCombos.Contains(combo2) && _actor._comboInputBuffer.ValidateKeys(combo2.requestKeys))
				{
					combo = combo2;
					i++;
					break;
				}
			}
		}
		else
		{
			for (; i < _actor.comboGroup.combos.Length; i++)
			{
				Combo combo3 = _actor.comboGroup.combos[i];
				if (!combo3.useActionKeys && !(combo3.actionTag != _actor._actionTag))
				{
					combo = combo3;
					break;
				}
			}
			_actor._actionTag = "";
		}
		if (_actor.comboGroup.comboMode == Combo.ComboMode.Normal && combo != null)
		{
			_consumedCombos.Add(combo);
		}
		return combo;
	}

	public void StartCombo(Combo combo, Action onComplete, Action onInterrupt)
	{
		onComboComplete = onComplete;
		onComboInterupt = onInterrupt;
		if (combo != null)
		{
			PlayCombo(combo);
		}
	}

	internal void PlayCombo(Combo combo)
	{
		if (isPlayingActionAnimation)
		{
			StopActionAnimation();
		}
		currentCombo = combo;
		_actor.comboTriggerExitTime = false;
		_comboTimer = 0f;
		ResetEvents();
		currentComboClip = null;
		_actor.ResetActorHitedTimeout();
		if (_actor.comboGroup.comboMode == Combo.ComboMode.Endless)
		{
			_actor._comboInputBuffer.Flush();
		}
		AdventureActorPlayComboEvent adventureActorPlayComboEvent = AdventureActorPlayComboEvent.Generate();
		adventureActorPlayComboEvent.sender = _actor;
		adventureActorPlayComboEvent.comboTag = currentCombo.actionTag;
		adventureActorPlayComboEvent.comboSkillType = currentCombo.comboSkillType;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorPlayComboEvent);
		SwitchState(13);
	}

	protected ComboClip SelectComboClip(Combo combo, Combo.Phase comboPhase, out float transitionIn, out float transitionOut, out bool loopAnimation, out bool animationPauseOnEnd, out FP inputTimeWindow)
	{
		transitionIn = 0f;
		transitionOut = 0f;
		loopAnimation = false;
		animationPauseOnEnd = false;
		inputTimeWindow = -1f;
		ComboClip comboClip = null;
		switch (combo.comboClipMode)
		{
		case Combo.ComboClipMode.Once:
			if (combo.compositeComboClips == null || combo.compositeComboClips.Length == 0)
			{
				_actor.LogError("Combo中没有配置ComboClip");
				return null;
			}
			if (combo.compositeComboClips.Length > 1)
			{
				int num2 = TSRandom.Range(0, combo.compositeComboClips.Length);
				comboClip = combo.compositeComboClips[num2].comboClip;
				GetEventsByTag(comboClip, combo.compositeComboClips[num2].eventGroupTag, _actor.skinID);
			}
			else
			{
				comboClip = combo.compositeComboClips[0].comboClip;
				GetEventsByTag(comboClip, combo.compositeComboClips[0].eventGroupTag, _actor.skinID);
			}
			if (comboClip.animationClip != null)
			{
				transitionIn = Mathf.Min((float)comboClip.transitionIn, comboClip.animationClip.length);
				transitionOut = Mathf.Min((float)comboClip.transitionOut, comboClip.animationClip.length);
			}
			else
			{
				transitionIn = (float)comboClip.transitionIn;
				transitionOut = (float)comboClip.transitionOut;
			}
			loopAnimation = false;
			animationPauseOnEnd = false;
			inputTimeWindow = comboClip.animationLength;
			break;
		case Combo.ComboClipMode.Loop:
			if (combo.compositeComboClips == null || combo.compositeComboClips.Length < 3)
			{
				_actor.LogError("Combo中没有配置ComboClip");
				return null;
			}
			switch (comboPhase)
			{
			case Combo.Phase.Anticipation:
				comboClip = combo.compositeComboClips[0].comboClip;
				GetEventsByTag(comboClip, combo.compositeComboClips[0].eventGroupTag, _actor.skinID);
				if (comboClip.animationClip != null)
				{
					transitionIn = Mathf.Min((float)comboClip.transitionIn, comboClip.animationClip.length);
				}
				else
				{
					transitionIn = (float)comboClip.transitionIn;
				}
				transitionOut = 0f;
				loopAnimation = false;
				animationPauseOnEnd = true;
				inputTimeWindow = comboClip.animationLength;
				break;
			case Combo.Phase.Activation:
				if (combo.compositeComboClips.Length > 3)
				{
					int num = TSRandom.Range(1, combo.compositeComboClips.Length - 1);
					comboClip = combo.compositeComboClips[num].comboClip;
					GetEventsByTag(comboClip, combo.compositeComboClips[num].eventGroupTag, _actor.skinID);
				}
				else
				{
					comboClip = combo.compositeComboClips[1].comboClip;
					GetEventsByTag(comboClip, combo.compositeComboClips[1].eventGroupTag, _actor.skinID);
				}
				transitionIn = 0f;
				transitionOut = 0f;
				loopAnimation = true;
				animationPauseOnEnd = false;
				inputTimeWindow = -1f;
				break;
			case Combo.Phase.Recovery:
				comboClip = combo.compositeComboClips[combo.compositeComboClips.Length - 1].comboClip;
				GetEventsByTag(comboClip, combo.compositeComboClips[combo.compositeComboClips.Length - 1].eventGroupTag, _actor.skinID);
				transitionIn = 0f;
				if (comboClip.animationClip != null)
				{
					transitionOut = Mathf.Min((float)comboClip.transitionOut, comboClip.animationClip.length);
				}
				else
				{
					transitionOut = (float)comboClip.transitionOut;
				}
				loopAnimation = false;
				animationPauseOnEnd = false;
				inputTimeWindow = comboClip.animationLength;
				break;
			}
			break;
		}
		return comboClip;
		static void CombineSkinClipEvents(ComboClip baseComboClip, ComboClip skinComboClip, int index)
		{
			if (!(skinComboClip == null))
			{
				List<Combo.Event> list = null;
				if (index > 0 && skinComboClip.enableExtraEventGroup)
				{
					if (skinComboClip.EventGroups != null && skinComboClip.EventGroups.Length > index - 1)
					{
						list = ((skinComboClip.EventGroups[index - 1].ComboEventSkins.Length != 0) ? skinComboClip.EventGroups[index - 1].ComboEventSkins[0].comboEvents.ToList() : null);
					}
					else
					{
						NovaLogger.Error("comboclip事件组索引超出范围，请检查配置:" + skinComboClip.name);
					}
				}
				else
				{
					list = ((skinComboClip.comboEventSkins.Length != 0) ? skinComboClip.comboEventSkins[0].comboEvents.ToList() : null);
				}
				if (list != null && list.Count != 0)
				{
					foreach (Combo.Event item in list)
					{
						if (item.playerSkinEventOverrideType == Combo.Event.PlayerSkinEventOverrideType.Add)
						{
							baseComboClip.selectedComboEvents.Add(item);
						}
						else if (item.playerSkinEventOverrideType == Combo.Event.PlayerSkinEventOverrideType.Remove)
						{
							for (int num3 = baseComboClip.selectedComboEvents.Count - 1; num3 >= 0; num3--)
							{
								if (baseComboClip.selectedComboEvents.get_Item(num3).uniqueID.Equals(item.uniqueID))
								{
									baseComboClip.selectedComboEvents.Remove(baseComboClip.selectedComboEvents.get_Item(num3));
									break;
								}
							}
						}
						else if (item.playerSkinEventOverrideType == Combo.Event.PlayerSkinEventOverrideType.Replace)
						{
							for (int num4 = baseComboClip.selectedComboEvents.Count - 1; num4 >= 0; num4--)
							{
								if (baseComboClip.selectedComboEvents.get_Item(num4).uniqueID.Equals(item.uniqueID))
								{
									baseComboClip.selectedComboEvents.set_Item(num4, item);
									break;
								}
							}
						}
					}
				}
			}
		}
		void GetEventsByTag(ComboClip clip, string tag, int skinId)
		{
			clip.selectedComboEvents.Clear();
			CommonHelper.TryParseStringParamToInt(tag.Split(':')[0], out var intValue);
			if (intValue > 0 && clip.enableExtraEventGroup)
			{
				if (clip.EventGroups != null && clip.EventGroups.Length > intValue - 1)
				{
					if (clip.EventGroups[intValue - 1].ComboEventSkins.Length != 0 && clip.EventGroups[intValue - 1].ComboEventSkins[0].comboEvents.Length != 0)
					{
						clip.selectedComboEvents.AddRange(clip.EventGroups[intValue - 1].ComboEventSkins[0].comboEvents);
					}
				}
				else
				{
					NovaLogger.Error("comboclip事件组索引超出范围，请检查配置:" + clip.name);
				}
			}
			else if (clip.comboEventSkins.Length != 0 && clip.comboEventSkins[0].comboEvents.Length != 0)
			{
				clip.selectedComboEvents.AddRange(clip.comboEventSkins[0].comboEvents);
			}
			if (_actor is PlayerAdventureActor { isSkin: not false })
			{
				if (_variantComboClipDictForSkin == null)
				{
					_variantComboClipDictForSkin = new Dictionary<string, ComboClip>();
				}
				if (_variantComboClipDictForSkin.TryGetValue(clip.name, out var value))
				{
					CombineSkinClipEvents(clip, value, intValue);
				}
				else
				{
					string text = $"Actor/Character/{skinId}/Combos/{clip.name}";
					string assetName = "Assets/AssetBundles/" + text + ".asset";
					value = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, assetName, typeof(ComboClip)) as ComboClip;
					_variantComboClipDictForSkin.set_Item(clip.name, value);
					CombineSkinClipEvents(clip, value, intValue);
				}
			}
		}
	}

	internal void PlayComboClip(Combo combo, Combo.Phase comboPhase, bool phaseLooping = false)
	{
		if (combo.comboClipMode == Combo.ComboClipMode.Loop)
		{
			switch (comboPhase)
			{
			case Combo.Phase.Activation:
				ResetEvents(resetLoopComboEvents: false);
				_comboTimer = (phaseLooping ? (_comboTimer - CalcComboClipDuration()) : ((FP)0f));
				break;
			case Combo.Phase.Recovery:
				ResetEvents(resetLoopComboEvents: false);
				_comboTimer = 0f;
				break;
			}
		}
		if (prevComboClip != currentComboClip)
		{
			prevComboClip = currentComboClip;
		}
		currentComboClip = SelectComboClip(combo, comboPhase, out var transitionIn, out var transitionOut, out var loopAnimation, out var animationPauseOnEnd, out var inputTimeWindow);
		if (currentComboClip == null)
		{
			return;
		}
		if (currentComboClip.animationClip != null && _actor.animatorController != null)
		{
			float num = 1f;
			if (combo.comboSkillType == ComboSkillType.Normal)
			{
				num = (float)_actor.actorInfo.normalAttackSpd;
			}
			num *= (float)_actor.actorInfo.ComboSpdMultiplier;
			num = Mathf.Clamp(num, 0.2f, 5f);
			if (!phaseLooping || !(prevComboClip == currentComboClip))
			{
				PlayAnimation(currentComboClip.animationClip, currentComboClip.actionAnimType, (float)currentComboClip.playSpeed, num, transitionIn, transitionOut, (!loopAnimation) ? 1 : (-1), animationPauseOnEnd);
			}
			else
			{
				UpdateAnimationSpeed(currentComboClip.actionAnimType, (float)currentComboClip.playSpeed, num);
			}
		}
		InitRootMotion();
		InitEvents();
		InitFeaturePhases();
		InitChangeCurrentAttackTargetTriggers();
		_actor._comboInputBuffer.lastInputTime = _actor.LogicTime;
		FP fP = currentComboClip.playSpeed * _comboPlaySpeedMultiplier;
		_actor._comboInputBuffer.timeWindow = inputTimeWindow * fP - _comboTimer;
	}

	public FP GetComboPlayedTime()
	{
		return _comboTimer;
	}

	public FP CalcComboClipDuration()
	{
		if (currentComboClip == null)
		{
			return 0f;
		}
		FP fP = currentComboClip.playSpeed * _comboPlaySpeedMultiplier;
		return currentComboClip.animationLength / fP;
	}

	public FP CalcComboClipNormalizedTime()
	{
		if (currentComboClip != null)
		{
			return _comboTimer / CalcComboClipDuration();
		}
		return 0f;
	}

	internal void ReloadCombo()
	{
		_actor._comboInputBuffer.Flush();
		_actor._comboInputBuffer.timeWindow = -1f;
		_consumedCombos.Clear();
	}

	public void StopLoopingCombo()
	{
		if (isPlayingLoopCombo && (GetCurStateID() == 13 || GetCurStateID() == 14))
		{
			SwitchState(15);
		}
	}

	public void StopCombo(bool fadeOutAnim = true)
	{
		if (isPlayingCombo)
		{
			if (currentComboClip.animationClip != null && _actor.animatorController != null)
			{
				StopAnimation(currentComboClip.actionAnimType, fadeOutAnim ? ((float)currentComboClip.transitionOut) : 0f);
			}
			InterruptEvents();
			onComboInterupt?.Invoke();
			SwitchState(12);
		}
		else if (GetCurStateID() == 16)
		{
			SwitchState(12);
		}
	}

	internal void FinishCombo()
	{
		Action action = onComboComplete;
		SwitchState(12);
		action?.Invoke();
		prevComboClip = null;
	}

	internal void ResetCombo()
	{
		ReloadCombo();
		ResetRootMotion();
		ResetEvents();
		ResetFeaturePhases();
		currentCombo = null;
		currentComboClip = null;
		onComboComplete = null;
		onComboInterupt = null;
		_comboTimer = 0f;
	}

	public bool IsComboCurStateEnd()
	{
		if (GetCurState() is ActorAttackComboPhaseBaseState actorAttackComboPhaseBaseState)
		{
			return actorAttackComboPhaseBaseState.ComboNormalizedTime >= 1;
		}
		return true;
	}

	public void PlayActionAnimation(ComboClip comboClip, int loopCount = 1, float playSpeedMultiplier = 1f, bool isClipTool = false)
	{
		if (isPlayingCombo)
		{
			SwitchState(12);
		}
		currentComboClip = comboClip;
		isComboClipTool = isClipTool;
		if (!isComboClipTool && currentComboClip.comboEventSkins.Length != 0 && currentComboClip.comboEventSkins[0].comboEvents.Length != 0)
		{
			currentComboClip.selectedComboEvents = currentComboClip.comboEventSkins[0].comboEvents.ToList();
		}
		if (currentComboClip.animationClip != null && _actor.animatorController != null)
		{
			PlayAnimation(currentComboClip.animationClip, currentComboClip.actionAnimType, (float)currentComboClip.playSpeed, playSpeedMultiplier, (float)comboClip.transitionIn, (float)comboClip.transitionOut, loopCount, pauseOnEnd: false);
		}
		InitEvents();
		InitRootMotion();
		InitChangeCurrentAttackTargetTriggers();
	}

	public void StopActionAnimation(bool fadeOutAnim = true)
	{
		if (isPlayingActionAnimation)
		{
			if (currentComboClip.animationClip != null && _actor.animatorController != null)
			{
				StopAnimation(currentComboClip.actionAnimType, fadeOutAnim ? ((float)currentComboClip.transitionOut) : 0f);
			}
			FinishActionAnimation();
		}
	}

	internal void FinishActionAnimation()
	{
		ResetEvents();
		ResetRootMotion();
		_comboTimer = 0f;
		currentComboClip = null;
	}

	protected void PlayAnimation(AnimationClip animationClip, HybirdAnimatorController.ActionAnimationType actionAnimType, float playSpeed, float comboPlaySpeedMultiplier, float transitionIn, float transitionOut, int maxLoopCount, bool pauseOnEnd)
	{
		_comboPlaySpeedMultiplier = comboPlaySpeedMultiplier;
		playSpeed *= comboPlaySpeedMultiplier;
		switch (actionAnimType)
		{
		case HybirdAnimatorController.ActionAnimationType.ActionOverride:
			if (_actor.animatorController.IsPlaying(HybirdAnimatorController.ActionAnimationType.ActionWithMask))
			{
				StopAnimation(HybirdAnimatorController.ActionAnimationType.ActionWithMask, transitionIn);
			}
			break;
		case HybirdAnimatorController.ActionAnimationType.ActionWithMask:
			if (_actor.animatorController.IsPlaying(HybirdAnimatorController.ActionAnimationType.ActionOverride))
			{
				StopAnimation(HybirdAnimatorController.ActionAnimationType.ActionOverride, transitionIn);
			}
			break;
		}
		_actor.animatorController.PlayActionAnimation(animationClip, actionAnimType, transitionIn, transitionOut, playSpeed, maxLoopCount, pauseOnEnd);
	}

	protected void StopAnimation(HybirdAnimatorController.ActionAnimationType actionAnimType, float transitionOut)
	{
		if (transitionOut > float.Epsilon)
		{
			_actor.animatorController.StopActionAnimation(actionAnimType, transitionOut);
		}
		else
		{
			_actor.animatorController.ForceStopActionAnimation(actionAnimType);
		}
	}

	protected void UpdateAnimationSpeed(HybirdAnimatorController.ActionAnimationType actionAnimType, float playSpeed, float comboPlaySpeedMultiplier)
	{
		_comboPlaySpeedMultiplier = comboPlaySpeedMultiplier;
		playSpeed *= comboPlaySpeedMultiplier;
		_actor.animatorController.SetActionAnimationPlaybackSpeed(actionAnimType, playSpeed);
	}

	private void InitChangeCurrentAttackTargetTriggers()
	{
		_actor.enableChangeCurrentAttackTarget = false;
		if (currentComboClip != null && currentComboClip.changeCurrentAttackTargetCfgs.Count > 0)
		{
			currentComboClip.changeCurrentAttackTargetTriggerDict.Clear();
			for (int i = 0; i < currentComboClip.changeCurrentAttackTargetCfgs.Count; i++)
			{
				currentComboClip.changeCurrentAttackTargetTriggerDict.Add(i, value: false);
			}
		}
	}

	protected void InitEvents()
	{
		if (currentComboClip != null && currentComboClip.selectedComboEvents != null && currentComboClip.selectedComboEvents.Count != _triggerEventTimers.Count)
		{
			for (int i = 0; i < currentComboClip.selectedComboEvents.Count; i++)
			{
				_triggerEventTimers.Add(TRIGGER_EVENT_TIMER_NO_START);
				_triggerEventTriggerIndexes.Add(0);
				_triggeredEventEffects.Add(null);
				_triggeredEventEffectTokens.Add(-1L);
			}
		}
		_currentPlayerFeedbackEffectConfigureData = null;
		_cameraShakeUniqueId = -1L;
		_racialBlurUniqueId = -1L;
		_interruptPlayerFeedbackEffect = false;
	}

	internal void TriggerEvents(FP comboClipNormalizedTime, bool onlyTriggerEffectEvents = false)
	{
		if (!(currentComboClip != null) || currentComboClip.selectedComboEvents == null || currentComboClip.selectedComboEvents.Count != _triggerEventTimers.Count)
		{
			return;
		}
		_processingCombo = currentCombo;
		_processingComboClip = currentComboClip;
		for (int i = 0; i < currentComboClip.selectedComboEvents.Count; i++)
		{
			Combo.Event obj = currentComboClip.selectedComboEvents.get_Item(i);
			if (((!(_triggerEventTimers.get_Item(i) < 0f) || !(obj.activeNormalizedTimeRange.x <= comboClipNormalizedTime)) && (!(_triggerEventTimers.get_Item(i) >= 0f) || !(_triggerEventTimers.get_Item(i) < 1f))) || (currentCombo != null && currentCombo.comboClipMode == Combo.ComboClipMode.Loop && obj.playOnceInLoopMode && _triggeredEventsInLoopCombo.Contains(obj)) || !CheckEventPreconditions(i, obj))
			{
				continue;
			}
			FP value;
			FP triggeredEventDuration;
			if (!obj.isInstantEvent)
			{
				FP fP = obj.activeNormalizedTimeRange.y - obj.activeNormalizedTimeRange.x;
				value = (comboClipNormalizedTime - obj.activeNormalizedTimeRange.x) / fP;
				value = TSMath.Clamp01(value);
				triggeredEventDuration = currentComboClip.animationLength * fP;
			}
			else
			{
				value = 1f;
				triggeredEventDuration = 0f;
			}
			if (!(value > _triggerEventTimers.get_Item(i)))
			{
				continue;
			}
			switch (obj.type)
			{
			case Combo.Event.EventType.Custom:
				if (!onlyTriggerEffectEvents && _triggerEventTimers.get_Item(i) < 0f)
				{
					OnComboCustomEvent(currentComboClip, obj);
				}
				break;
			case Combo.Event.EventType.Hit:
				if (!onlyTriggerEffectEvents)
				{
					OnComboHitEvent(currentComboClip, obj, i, comboClipNormalizedTime, value, triggeredEventDuration);
				}
				break;
			case Combo.Event.EventType.Shoot:
				if (!onlyTriggerEffectEvents)
				{
					OnComboShootEvent(currentComboClip, obj, i, comboClipNormalizedTime, value, triggeredEventDuration);
				}
				break;
			case Combo.Event.EventType.TriggerCharGamePlayLogicCommonEvent:
				if (!onlyTriggerEffectEvents && _triggerEventTimers.get_Item(i) < 0f)
				{
					OnComboTriggerCharGamePlayLogicCommonEvent(currentComboClip, obj);
				}
				break;
			case Combo.Event.EventType.Effect:
				if (_triggerEventTimers.get_Item(i) < 0f)
				{
					OnComboEffectEvent(currentComboClip, obj, i);
				}
				else if (value >= 1f)
				{
					OnComboEffectEventEnd(currentComboClip, obj, i);
				}
				else
				{
					OnComboEffectEventUpdate(currentComboClip, obj, i, comboClipNormalizedTime, value, triggeredEventDuration);
				}
				break;
			case Combo.Event.EventType.StopEffect:
				if (_triggerEventTimers.get_Item(i) < 0f)
				{
					OnComboStopEffectEvent(currentComboClip, obj);
				}
				break;
			case Combo.Event.EventType.AddBuff:
				if (!onlyTriggerEffectEvents && _triggerEventTimers.get_Item(i) < 0f)
				{
					OnAddBuffEvent(currentComboClip, obj);
				}
				break;
			case Combo.Event.EventType.AreaEffect:
				if (!onlyTriggerEffectEvents && _triggerEventTimers.get_Item(i) < 0f)
				{
					OnAreaEffectEvent(currentComboClip, obj);
				}
				break;
			case Combo.Event.EventType.AddShield:
				if (!onlyTriggerEffectEvents && _triggerEventTimers.get_Item(i) < 0f)
				{
					OnAddShieldEvent(obj);
				}
				break;
			case Combo.Event.EventType.PlayWwiseEvent:
				if (_triggerEventTimers.get_Item(i) < 0f)
				{
					OnPlayWwiseEvent(currentComboClip, obj);
				}
				break;
			case Combo.Event.EventType.FrozenTime:
				if (!onlyTriggerEffectEvents && _triggerEventTimers.get_Item(i) < 0f)
				{
					OnFrozenTimeEvent(currentComboClip, obj);
				}
				break;
			}
			if (IsProcessingComboClipChanged())
			{
				break;
			}
			_triggerEventTimers.set_Item(i, value);
			if (currentCombo != null && currentCombo.comboClipMode == Combo.ComboClipMode.Loop && obj.playOnceInLoopMode && value >= 1f && !_triggeredEventsInLoopCombo.Contains(obj))
			{
				_triggeredEventsInLoopCombo.Add(obj);
			}
		}
	}

	protected bool IsProcessingComboClipChanged()
	{
		if (!(currentComboClip == null) && _processingCombo == currentCombo)
		{
			return _processingComboClip != currentComboClip;
		}
		return true;
	}

	protected void TrySetTriggerEventTriggerIndex(int eventIndex, int triggerIndex)
	{
		if (!IsProcessingComboClipChanged() && eventIndex >= 0 && eventIndex < _triggerEventTriggerIndexes.Count)
		{
			_triggerEventTriggerIndexes.set_Item(eventIndex, triggerIndex);
		}
	}

	public List<Combo.Event> GetEvent(FP startNormalizedTime, FP endNormalizedTime, Combo.Event.EventType eventType)
	{
		if (currentComboClip != null && currentComboClip.selectedComboEvents != null && currentComboClip.selectedComboEvents.Count == _triggerEventTimers.Count)
		{
			List<Combo.Event> list = new List<Combo.Event>(5);
			for (int i = 0; i < currentComboClip.selectedComboEvents.Count; i++)
			{
				Combo.Event obj = currentComboClip.selectedComboEvents.get_Item(i);
				if (obj.activeNormalizedTimeRange.x >= startNormalizedTime && obj.activeNormalizedTimeRange.x <= endNormalizedTime && obj.type == eventType)
				{
					list.Add(obj);
				}
			}
			return list;
		}
		return null;
	}

	protected void OnComboCustomEvent(ComboClip comboClip, Combo.Event comboEvent)
	{
		if (_actor._onAttackCustomEvent != null)
		{
			_actor._onAttackCustomEvent(_actor, comboEvent);
		}
		if (comboEvent.triggerFateCardTheme)
		{
			OnComboTriggerCharGamePlayLogicCommonEvent(comboClip, comboEvent);
		}
	}

	protected void OnAddBuffEvent(ComboClip comboClip, Combo.Event comboEvent)
	{
		if (comboEvent.buffIds == null || comboEvent.buffIds.Count == 0)
		{
			return;
		}
		BuffCom buffComponent = _actor.buffComponent;
		if (!(buffComponent == null))
		{
			for (int i = 0; i < comboEvent.buffIds.Count; i++)
			{
				buffComponent.AddBuff(comboEvent.buffIds.get_Item(i), _actor);
			}
		}
	}

	protected void OnAddShieldEvent(Combo.Event comboEvent)
	{
		if (comboEvent.shiledID <= 0)
		{
			return;
		}
		if (_actor is PlayerAdventureActor && comboEvent.toTeam)
		{
			List<PlayerAdventureActor> actorLs = SceneSingleton<AdventurePlayerController>.Instance.ActorLs;
			for (int i = 0; i < actorLs.Count; i++)
			{
				ActorShield actorShield = actorLs.get_Item(i).actorShield;
				if (actorShield != null)
				{
					actorShield.AddShield(comboEvent.shiledID, _actor);
				}
			}
		}
		else
		{
			_actor.actorShield.AddShield(comboEvent.shiledID, _actor);
		}
	}

	private WwiseAudioManager.RTPC_MonsterType GetRTPC_Type()
	{
		if (_actor is MonsterAdventureActor monsterAdventureActor)
		{
			if (monsterAdventureActor.monsterInfo.originEpicType == HotfixEnum.monsterEpicType.LEADER)
			{
				return WwiseAudioManager.RTPC_MonsterType.Boss;
			}
			return WwiseAudioManager.RTPC_MonsterType.Normal;
		}
		return WwiseAudioManager.RTPC_MonsterType.None;
	}

	protected void OnPlayWwiseEvent(ComboClip comboClip, Combo.Event comboEvent)
	{
		if (comboEvent._audioPlayType == Combo.Event.audioPlayType.eventPlay)
		{
			if (comboEvent._audioEvetType == Combo.Event.audioEvetType.eventName)
			{
				if (!string.IsNullOrEmpty(comboEvent.wwiseEventName))
				{
					MonoSingleton<WwiseAudioManager>.Instance.PlaySound(comboEvent.wwiseEventName, _owner, temporaryRes: true, GetRTPC_Type());
				}
			}
			else if (comboEvent._audioEvetType == Combo.Event.audioEvetType.eventSource && comboEvent._wwiseEvent != null && !(comboEvent._wwiseEvent.WwiseObjectReference == null))
			{
				MonoSingleton<WwiseAudioManager>.Instance.PlaySound(comboEvent._wwiseEvent.Name, _owner, temporaryRes: true, GetRTPC_Type());
			}
		}
		else if ((_actor as PlayerAdventureActor).isAssist)
		{
			MonoSingleton<WwiseAudioManager>.Instance.WwiseVoice_Play(_actor.dataID, comboEvent.asseitVoice);
		}
		else
		{
			MonoSingleton<WwiseAudioManager>.Instance.WwiseVoice_Play(_actor.dataID, comboEvent.mainVoice);
		}
	}

	protected void OnFrozenTimeEvent(ComboClip comboClip, Combo.Event comboEvent)
	{
		FP activeNormaliedDuration = comboEvent.activeNormaliedDuration;
		if (activeNormaliedDuration > 0 && _actor is PlayerAdventureActor)
		{
			_actor.EnterWitchTime(activeNormaliedDuration * comboClip.animationLength, comboEvent._includeSelf);
		}
	}

	protected void OnAreaEffectEvent(ComboClip comboClip, Combo.Event comboEvent)
	{
		if (comboEvent.AreaEffectPrefab != null && _owner.TryGetComponent<AdventureActor>(out var component))
		{
			Quaternion spawnRotation = Quaternion.identity;
			if (comboEvent.useOwnerDirection)
			{
				TSVector2 v = component.tsTransform.Forward;
				if (comboEvent.rotationAngleOffset != 0)
				{
					v = TSVector2.Rotate(v, comboEvent.rotationAngleOffset);
				}
				spawnRotation = Quaternion.Euler(0f, 0f - v.GetAngle().AsFloat(), 0f);
			}
			if (comboEvent.lockTarget && component.attackTarget != null)
			{
				SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(component, comboEvent.AreaEffectPrefab, component.attackTarget.transform.position, spawnRotation);
			}
			else
			{
				Vector3 spawnPosition = component.transform.position + component.transform.forward * comboEvent.distance + component.transform.right * comboEvent.offset;
				SceneSingleton<AreaEffectManager>.Instance.PlayAreaEffect(component, comboEvent.AreaEffectPrefab, spawnPosition, spawnRotation);
			}
		}
		if (comboEvent.triggerFateCardTheme)
		{
			OnComboTriggerCharGamePlayLogicCommonEvent(comboClip, comboEvent);
		}
	}

	protected void OnComboHitEvent(ComboClip comboClip, Combo.Event comboEvent, int eventIndex, FP comboClipNormalizedTime, FP triggeredEventNormalizedTimer, FP triggeredEventDuration)
	{
		CalcEventPositionAndRotation(comboEvent, triggeredEventNormalizedTimer, out var pos, out var posY, out var rot);
		FP areaScale = comboEvent.GetAreaScale(_actor);
		FP hitBoxWidth = comboEvent.hitBoxWidth * areaScale;
		FP hitBoxLength = comboEvent.hitBoxLength * areaScale;
		FP hitBoxRadius = comboEvent.hitBoxRadius * areaScale;
		FP hitBoxInnerRadius = comboEvent.hitBoxInnerRadius * areaScale;
		FP hitBoxAngle = comboEvent.hitBoxAngle;
		if (comboEvent.hitBoxConfigureWithGameData != Combo.Event.HitBoxConfigureWithGameData.Disable)
		{
			HitBoxConfigureWithGameData(comboEvent.hitBoxConfigureWithGameData, comboEvent.hitBoxShape, ref hitBoxWidth, ref hitBoxLength, ref hitBoxRadius, ref hitBoxInnerRadius, ref hitBoxAngle);
		}
		_actor.hitBox.hitDamageId = comboEvent.hitDamageId;
		_actor.hitBox.featureFlags = comboEvent.hitFlags;
		_actor.hitBox.featureData = comboEvent.hitFeatureData;
		_actor.hitBox.hurtAnimType = comboEvent.hurtAnimType;
		FP fP = comboEvent.damageDetectInterval;
		if (fP == 0)
		{
			fP = AdventureModuleController.Config.Combat_HitboxContinuousDamageDetectInterval;
		}
		int damageCount = 0;
		bool flag = false;
		int hittedCount;
		switch (comboEvent.hitBoxShape)
		{
		case HitBox.Shape.Rectangle:
			if (triggeredEventDuration > FP.Epsilon)
			{
				int num3 = _triggerEventTriggerIndexes.get_Item(eventIndex);
				if (num3 <= (int)(long)(triggeredEventNormalizedTimer * triggeredEventDuration / fP))
				{
					_actor.hitBox.RectangleAreaHit(hitBoxWidth, hitBoxLength, pos, rot, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), comboEvent.hittedEffectPrefab, comboEvent.isHittedEffectScale, -5, comboEvent.damageImmuneDuration, randomHit: false, null, comboEvent.effectIgnoreTimeScale);
					TrySetTriggerEventTriggerIndex(eventIndex, ++num3);
					flag = true;
				}
			}
			else
			{
				_actor.hitBox.RectangleAreaHit(hitBoxWidth, hitBoxLength, pos, rot, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), comboEvent.hittedEffectPrefab, comboEvent.isHittedEffectScale, -5, comboEvent.damageImmuneDuration, randomHit: false, null, comboEvent.effectIgnoreTimeScale);
				flag = true;
			}
			break;
		case HitBox.Shape.Circle:
			if (triggeredEventDuration > FP.Epsilon)
			{
				int num2 = _triggerEventTriggerIndexes.get_Item(eventIndex);
				if (num2 <= (int)(long)(triggeredEventNormalizedTimer * triggeredEventDuration / fP))
				{
					_actor.hitBox.CircleAreaHit(hitBoxRadius, hitBoxInnerRadius, pos, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), comboEvent.hittedEffectPrefab, comboEvent.isHittedEffectScale, -5, comboEvent.damageImmuneDuration, randomHit: false, comboEvent.effectIgnoreTimeScale);
					TrySetTriggerEventTriggerIndex(eventIndex, ++num2);
					flag = true;
				}
			}
			else
			{
				_actor.hitBox.CircleAreaHit(hitBoxRadius, hitBoxInnerRadius, pos, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), comboEvent.hittedEffectPrefab, comboEvent.isHittedEffectScale, -5, comboEvent.damageImmuneDuration, randomHit: false, comboEvent.effectIgnoreTimeScale);
				flag = true;
			}
			break;
		case HitBox.Shape.Fan:
			if (triggeredEventDuration > FP.Epsilon)
			{
				int num = _triggerEventTriggerIndexes.get_Item(eventIndex);
				if (num <= (int)(long)(triggeredEventNormalizedTimer * triggeredEventDuration / fP))
				{
					_actor.hitBox.FanAreaHit(hitBoxAngle, hitBoxRadius, hitBoxInnerRadius, pos, rot, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), comboEvent.hittedEffectPrefab, comboEvent.isHittedEffectScale, comboEvent.damageImmuneDuration, comboEvent.effectIgnoreTimeScale);
					TrySetTriggerEventTriggerIndex(eventIndex, ++num);
					flag = true;
				}
			}
			else
			{
				_actor.hitBox.FanAreaHit(hitBoxAngle, hitBoxRadius, hitBoxInnerRadius, pos, rot, out hittedCount, out damageCount, SceneSingleton<AdventurePlayerController>.Instance.GetUniqueAttackId(), comboEvent.hittedEffectPrefab, comboEvent.isHittedEffectScale, comboEvent.damageImmuneDuration, comboEvent.effectIgnoreTimeScale);
				flag = true;
			}
			break;
		default:
			throw new ArgumentOutOfRangeException();
		}
		if (flag)
		{
			if (comboEvent.blockBullet)
			{
				if (_bulletCollider == null)
				{
					_bulletCollider = new List<DeterministicCollider>(10);
				}
				else
				{
					_bulletCollider.Clear();
				}
				switch (comboEvent.hitBoxShape)
				{
				case HitBox.Shape.Rectangle:
					_deterministicShape.shapeType = DeterministicShape.ShapeType.Rectangle;
					break;
				case HitBox.Shape.Circle:
					_deterministicShape.shapeType = DeterministicShape.ShapeType.Circle;
					break;
				case HitBox.Shape.Fan:
					_deterministicShape.shapeType = DeterministicShape.ShapeType.Fan;
					break;
				}
				_deterministicShape.position = pos;
				_deterministicShape.rotation = rot;
				_deterministicShape.width = hitBoxWidth;
				_deterministicShape.length = hitBoxLength;
				_deterministicShape.radius = hitBoxRadius;
				_deterministicShape.innerRadius = hitBoxInnerRadius;
				_deterministicShape.angle = hitBoxAngle;
				bool drawGizmos = false;
				SceneSingleton<DeterministicCollisionManager>.Instance.GetTargetByShape(_bulletCollider, _deterministicShape, 33280, drawGizmos);
				for (int i = 0; i < _bulletCollider.Count; i++)
				{
					AdventureWeapon adventureWeapon = _bulletCollider.get_Item(i).Entity as AdventureWeapon;
					if (adventureWeapon.canBeBlock && _actor.CheckTarget(adventureWeapon.owner, comboEvent.blockBulletTargetType))
					{
						GameObject blockFinishFx = comboEvent.blockFinishFx;
						if (blockFinishFx != null)
						{
							AdventureFXPlayer.PlayFX(blockFinishFx, (float)_actor.logicTimeScale, adventureWeapon.transform.position, adventureWeapon.transform.rotation);
						}
						adventureWeapon.Finish(cancel: true);
					}
				}
			}
			if (comboEvent.triggerFateCardTheme)
			{
				OnComboTriggerCharGamePlayLogicCommonEvent(comboClip, comboEvent);
			}
		}
		if (damageCount > 0 && comboEvent.haveFeedbackEffect && comboEvent.playerfeedbackEffectConfigureData != null)
		{
			Vector3 effectPosition = new Vector3((float)pos.x, (float)posY, (float)pos.y);
			AdventurePlayerFeedbackEffectConfigureData.PlayerFeedbackEffectInfo playerFeedbackEffectInfo = comboEvent.playerfeedbackEffectConfigureData.Play(effectPosition, _actor.gameObject, GetCameraShakeSort());
			_currentPlayerFeedbackEffectConfigureData = comboEvent.playerfeedbackEffectConfigureData;
			long cameraShakeUniqueId = playerFeedbackEffectInfo.cameraShakeUniqueId;
			long racialBlurUniqueId = playerFeedbackEffectInfo.racialBlurUniqueId;
			_cameraShakeUniqueId = cameraShakeUniqueId;
			_racialBlurUniqueId = racialBlurUniqueId;
			_interruptPlayerFeedbackEffect = comboEvent.interruptCancelPlayerFeedbackEffect;
		}
		if (triggeredEventNormalizedTimer >= 1f && (!isPlayingLoopCombo || triggeredEventDuration <= FP.Epsilon))
		{
			_actor.ResetActorHitedTimeout();
		}
	}

	private int GetCameraShakeSort()
	{
		if (_actor == null)
		{
			return 0;
		}
		if (_actor is PlayerAdventureActor playerAdventureActor)
		{
			if (playerAdventureActor.isAssist)
			{
				return -1;
			}
			return 1;
		}
		return 2;
	}

	protected void OnComboShootEvent(ComboClip comboClip, Combo.Event comboEvent, int eventIndex, FP comboClipNormalizedTime, FP triggeredEventNormalizedTimer, FP triggeredEventDuration)
	{
		CalcEventPositionAndRotation(comboEvent, triggeredEventNormalizedTimer, out var pos, out var _, out var rot);
		FP areaScale = comboEvent.GetAreaScale(_actor);
		FP hitBoxWidth = comboEvent.hitBoxWidth * areaScale;
		FP hitBoxLength = comboEvent.hitBoxLength * areaScale;
		FP hitBoxRadius = comboEvent.hitBoxRadius * areaScale;
		FP hitBoxInnerRadius = comboEvent.hitBoxInnerRadius * areaScale;
		FP hitBoxAngle = comboEvent.hitBoxAngle;
		if (comboEvent.hitBoxConfigureWithGameData != Combo.Event.HitBoxConfigureWithGameData.Disable)
		{
			HitBoxConfigureWithGameData(comboEvent.hitBoxConfigureWithGameData, comboEvent.hitBoxShape, ref hitBoxWidth, ref hitBoxLength, ref hitBoxRadius, ref hitBoxInnerRadius, ref hitBoxAngle);
		}
		GameObject bulletPrefab = comboEvent.bulletPrefab;
		int num = Mathf.Max(1, comboEvent.bulletCount);
		bool flag = false;
		TSVector2 tSVector = TSVector2.Rotate(TSVector2.up, rot);
		FP fP = comboEvent.hitBoxOffsetY * areaScale;
		if (comboEvent.multipleShootStyle == AdventureWeapon.MultipleShootStyle.OneShot)
		{
			TSVector2? position = pos;
			TSVector2? targetPosition = null;
			LogicEntity target = null;
			if (comboEvent.aimType == AimType.Default)
			{
				targetPosition = position.Value + tSVector * comboEvent.range;
			}
			else if (comboEvent.aimType == AimType.Position)
			{
				tSVector = comboEvent.bulletDirectionType switch
				{
					BulletDirectionType.BulletToTarget => (_actor.shootBehaviour.aimTargetPosition - position.Value).normalized, 
					BulletDirectionType.ActorToBullet => (position.Value - _actor.tsTransform.Position).normalized, 
					_ => throw new ArgumentOutOfRangeException(), 
				};
				targetPosition = _actor.shootBehaviour.aimTargetPosition;
			}
			else if (comboEvent.aimType == AimType.Target)
			{
				LogicEntity aimTarget = _actor.shootBehaviour.aimTarget;
				if (aimTarget != null)
				{
					tSVector = comboEvent.bulletDirectionType switch
					{
						BulletDirectionType.BulletToTarget => (aimTarget.tsTransform.Position - position.Value).normalized, 
						BulletDirectionType.ActorToBullet => (position.Value - _actor.tsTransform.Position).normalized, 
						_ => throw new ArgumentOutOfRangeException(), 
					};
					targetPosition = aimTarget.tsTransform.Position;
					target = aimTarget;
				}
				else
				{
					Debug.LogError("瞄准模式为'攻击目标'时，目标不能为空");
				}
			}
			if (triggeredEventDuration <= FP.Epsilon)
			{
				int num2 = num;
				for (int i = 0; i < num2; i++)
				{
					_actor.shootBehaviour.Shoot(bulletPrefab, position, fP, tSVector, targetPosition, target, comboEvent.useShootDeviationCalcScatteringRadius, comboEvent.shootScatteringRadius, comboEvent.aimType, null, targetNullUseActorTarget: true, comboEvent.ControlIndex);
				}
				flag = true;
			}
			else
			{
				int num3 = _triggerEventTriggerIndexes.get_Item(eventIndex);
				int num4 = num;
				if (num3 <= (int)(long)(triggeredEventNormalizedTimer * (num4 - 1)))
				{
					_actor.shootBehaviour.Shoot(bulletPrefab, position, fP, tSVector, targetPosition, target, comboEvent.useShootDeviationCalcScatteringRadius, comboEvent.shootScatteringRadius, comboEvent.aimType, null, targetNullUseActorTarget: true, comboEvent.ControlIndex);
					TrySetTriggerEventTriggerIndex(eventIndex, ++num3);
					flag = true;
				}
			}
		}
		else
		{
			hitBoxLength = (hitBoxRadius = comboEvent.range);
			hitBoxInnerRadius = comboEvent.innerRadius;
			if (triggeredEventDuration > FP.Epsilon)
			{
				int waveIndex = _triggerEventTriggerIndexes.get_Item(eventIndex);
				int num5 = _actor.shootBehaviour.QueryMultipleShootWaveCount(comboEvent.hitBoxShape, comboEvent.multipleShootStyle, num);
				if (waveIndex <= (int)(long)(triggeredEventNormalizedTimer * (num5 - 1)))
				{
					_actor.shootBehaviour.MultipleShoot(comboEvent.hitBoxShape, bulletPrefab, num, hitBoxWidth, hitBoxLength, hitBoxAngle, hitBoxRadius, hitBoxInnerRadius, pos, fP, tSVector, comboEvent.multipleShootBulletDirectionOffset, comboEvent.multipleShootStyle, ref waveIndex, triggeredEventDuration, comboEvent.alignShoot, comboEvent.alignShootDelay, comboEvent.aimType, comboEvent.bulletDirectionType, _actor.shootBehaviour.aimTargetPosition, _actor.shootBehaviour.aimTarget);
					TrySetTriggerEventTriggerIndex(eventIndex, waveIndex);
					flag = true;
				}
			}
			else
			{
				int num6 = _actor.shootBehaviour.QueryRectangleMultipleShootWaveCount(comboEvent.multipleShootStyle, num);
				int waveIndex2 = 0;
				while (waveIndex2 < num6)
				{
					_actor.shootBehaviour.MultipleShoot(comboEvent.hitBoxShape, bulletPrefab, num, hitBoxWidth, hitBoxLength, hitBoxAngle, hitBoxRadius, hitBoxInnerRadius, pos, fP, tSVector, comboEvent.multipleShootBulletDirectionOffset, comboEvent.multipleShootStyle, ref waveIndex2, triggeredEventDuration, comboEvent.alignShoot, comboEvent.alignShootDelay, comboEvent.aimType, comboEvent.bulletDirectionType, _actor.shootBehaviour.aimTargetPosition, _actor.shootBehaviour.aimTarget);
				}
				flag = true;
			}
		}
		if (flag)
		{
			PlayEffect(oneShot: true, eventIndex, comboEvent, pos, _actor.tsTransform.PositionY + comboEvent.hitBoxOffsetY * comboEvent.GetAreaScale(_actor), rot);
			if (comboEvent.reduceAmmoCount > 0)
			{
				_actor.ammoInfo?.RefreshAmmoCost(-comboEvent.reduceAmmoCount);
			}
			if (comboEvent.triggerFateCardTheme)
			{
				OnComboTriggerCharGamePlayLogicCommonEvent(comboClip, comboEvent);
			}
		}
	}

	protected void OnComboTriggerCharGamePlayLogicCommonEvent(ComboClip comboClip, Combo.Event comboEvent)
	{
		if (!(_actor as PlayerAdventureActor == null) && (comboEvent.normalAttackTriggerForFateCard || comboEvent.dodgeTriggerForFateCard || comboEvent.skillTriggerForFateCard || comboEvent.ultimateTriggerForFateCard))
		{
			TriggerCharGamePlayLogicCommonEvent triggerCharGamePlayLogicCommonEvent = TriggerCharGamePlayLogicCommonEvent.Generate();
			triggerCharGamePlayLogicCommonEvent.normalAttackTrigger = comboEvent.normalAttackTriggerForFateCard;
			triggerCharGamePlayLogicCommonEvent.dodgeTrigger = comboEvent.dodgeTriggerForFateCard;
			triggerCharGamePlayLogicCommonEvent.skillTrigger = comboEvent.skillTriggerForFateCard;
			triggerCharGamePlayLogicCommonEvent.ultimateTrigger = comboEvent.ultimateTriggerForFateCard;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(triggerCharGamePlayLogicCommonEvent);
		}
	}

	protected void OnComboEffectEvent(ComboClip comboClip, Combo.Event comboEvent, int eventIndex)
	{
		CalcEventPositionAndRotation(comboEvent, 0f, out var pos, out var posY, out var rot);
		float value = comboEvent.effectPlaySpeed * (float)_comboPlaySpeedMultiplier;
		Combo.Phase comboPhase = (comboEvent.cancelEffectWhenLoopStop ? (Combo.Phase.Anticipation | Combo.Phase.Activation) : Combo.Phase.All);
		_actor.PlayFX(comboEvent.name, value, ActorState.Null, _actor.playingCombo, comboPhase, comboEvent.interruptCancelEffect);
		PlayEffect(oneShot: false, eventIndex, comboEvent, pos, posY, rot);
	}

	protected void OnComboEffectEventUpdate(ComboClip comboClip, Combo.Event comboEvent, int eventIndex, FP comboClipNormalizedTime, FP triggeredEventNormalizedTimer, FP triggeredEventDuration)
	{
		AdventureFXPlayer adventureFXPlayer = _triggeredEventEffects.get_Item(eventIndex);
		if (adventureFXPlayer != null && _triggeredEventEffectTokens.get_Item(eventIndex) == adventureFXPlayer.token)
		{
			CalcEventPositionAndRotation(comboEvent, triggeredEventNormalizedTimer, out var pos, out var posY, out var rot);
			var (position, rotation) = ConvertEventPositionAndRotationToTransformSpace(pos, posY, rot);
			adventureFXPlayer.transform.SetPositionAndRotation(position, rotation);
		}
	}

	protected void OnComboEffectEventEnd(ComboClip comboClip, Combo.Event comboEvent, int eventIndex)
	{
		_actor.StopFX(comboEvent.name);
		AdventureFXPlayer adventureFXPlayer = _triggeredEventEffects.get_Item(eventIndex);
		if (adventureFXPlayer != null && _triggeredEventEffectTokens.get_Item(eventIndex) == adventureFXPlayer.token)
		{
			if (!isComboClipTool || adventureFXPlayer.isLoop)
			{
				adventureFXPlayer.Stop();
			}
			_triggeredEventEffects.set_Item(eventIndex, (AdventureFXPlayer)null);
		}
	}

	protected void OnComboStopEffectEvent(ComboClip comboClip, Combo.Event comboEvent)
	{
		_actor.StopFX(comboEvent.name);
	}

	protected void ResetEvents(bool resetLoopComboEvents = true)
	{
		CloseUnEndedEvents();
		_triggerEventTimers.Clear();
		_triggerEventTriggerIndexes.Clear();
		_triggeredEventEffects.Clear();
		_triggeredEventEffectTokens.Clear();
		if (resetLoopComboEvents)
		{
			_triggeredEventsInLoopCombo.Clear();
		}
	}

	protected void CloseUnEndedEvents()
	{
		if (!(currentComboClip != null) || currentComboClip.selectedComboEvents == null || currentComboClip.selectedComboEvents.Count != _triggerEventTimers.Count)
		{
			return;
		}
		for (int i = 0; i < currentComboClip.selectedComboEvents.Count; i++)
		{
			Combo.Event obj = currentComboClip.selectedComboEvents.get_Item(i);
			if (obj.type == Combo.Event.EventType.Effect && ((_triggerEventTimers.get_Item(i) >= 0f && _triggerEventTimers.get_Item(i) < 1f) || isComboClipTool))
			{
				OnComboEffectEventEnd(currentComboClip, obj, i);
				_triggerEventTimers.set_Item(i, (FP)1f);
			}
		}
	}

	protected void InterruptEvents()
	{
		if (_interruptPlayerFeedbackEffect)
		{
			_currentPlayerFeedbackEffectConfigureData?.Stop(_cameraShakeUniqueId, _racialBlurUniqueId);
		}
	}

	protected bool CheckEventPreconditions(int eventIndex, Combo.Event comboEvent)
	{
		if (_triggerEventTimers.get_Item(eventIndex) >= 0f)
		{
			return true;
		}
		switch (comboEvent.clipPreconditionType)
		{
		case Combo.Event.ClipPreconditionType.Only:
			if (!(prevComboClip != comboEvent.preconditionClip))
			{
				break;
			}
			goto IL_0062;
		case Combo.Event.ClipPreconditionType.Except:
			{
				if (!(prevComboClip == comboEvent.preconditionClip))
				{
					break;
				}
				goto IL_0062;
			}
			IL_0062:
			return false;
		}
		return true;
	}

	protected void CalcEventPositionAndRotation(Combo.Event comboEvent, FP triggeredEventNormalizedTimer, out TSVector2 pos, out FP posY, out FP rot)
	{
		TSVector2 posOffset = comboEvent.hitBoxOffset;
		FP posOffsetY = comboEvent.hitBoxOffsetY;
		FP fP = comboEvent.hitBoxRotation;
		if (!comboEvent.offsetFollowActor)
		{
			if (!comboEvent.lockHitBoxTransformOnEnd && triggeredEventNormalizedTimer > FP.Epsilon)
			{
				if (comboEvent.enableHitBoxCurveMotion)
				{
					posOffset = TSBezierCurve2D.CalcPoint(posOffset, comboEvent.hitBoxCurveMotionControlPoint1, comboEvent.hitBoxCurveMotionControlPoint2, comboEvent.hitBoxOffsetOnEnd, triggeredEventNormalizedTimer);
					fP = TSMath.Lerp(fP, comboEvent.hitBoxRotationOnEnd, triggeredEventNormalizedTimer);
				}
				else
				{
					posOffset = TSVector2.Lerp(posOffset, comboEvent.hitBoxOffsetOnEnd, triggeredEventNormalizedTimer);
					fP = TSMath.Lerp(fP, comboEvent.hitBoxRotationOnEnd, triggeredEventNormalizedTimer);
				}
			}
			ProcessOffsetByScale();
			posOffset -= _lastRootMotionTranslate;
			fP -= _lastRootMotionRotateAngle;
			ApplyRootMotionRotateToRootMotionTranslate(ref posOffset);
		}
		else
		{
			ProcessOffsetByScale();
		}
		pos = _actor.tsTransform.TransformLocalPointToWorldSpace(posOffset);
		posY = _actor.tsTransform.PositionY + posOffsetY;
		rot = _actor.tsTransform.Rotation + fP;
		void ProcessOffsetByScale()
		{
			FP areaScale = comboEvent.GetAreaScale(_actor);
			posOffset *= areaScale;
			posOffsetY *= areaScale;
		}
	}

	protected (Vector3, Quaternion) ConvertEventPositionAndRotationToTransformSpace(TSVector2 pos, FP posY, FP rot)
	{
		Vector3 item = new Vector3((float)pos.x, (float)posY, (float)pos.y);
		Quaternion item2 = Quaternion.Euler(0f, 0f - (float)rot, 0f);
		return (item, item2);
	}

	public void HitBoxConfigureWithGameData(Combo.Event.HitBoxConfigureWithGameData hitBoxConfigureWithGameData, HitBox.Shape hitBoxShape, ref FP hitBoxWidth, ref FP hitBoxLength, ref FP hitBoxRadius, ref FP hitBoxInnerRadius, ref FP hitBoxAngle)
	{
		ActorSearchTarget logicComponent = _actor.GetLogicComponent<ActorSearchTarget>();
		switch (hitBoxShape)
		{
		case HitBox.Shape.Rectangle:
			switch (hitBoxConfigureWithGameData)
			{
			case Combo.Event.HitBoxConfigureWithGameData.VisionData:
			case Combo.Event.HitBoxConfigureWithGameData.VisionDataWithDistanceOnly:
				hitBoxLength = logicComponent.visionRange;
				break;
			case Combo.Event.HitBoxConfigureWithGameData.HearData:
				hitBoxLength = logicComponent.hearRange;
				break;
			case Combo.Event.HitBoxConfigureWithGameData.BodyDataWithSize:
				hitBoxLength = _actor.dtCollider.Radius * 2f;
				hitBoxWidth = _actor.dtCollider.Radius * 2f;
				break;
			default:
				throw new ArgumentOutOfRangeException("hitBoxConfigureWithGameData", hitBoxConfigureWithGameData, null);
			case Combo.Event.HitBoxConfigureWithGameData.Disable:
			case Combo.Event.HitBoxConfigureWithGameData.VisionDataWithAngleOnly:
				break;
			}
			break;
		case HitBox.Shape.Circle:
			switch (hitBoxConfigureWithGameData)
			{
			case Combo.Event.HitBoxConfigureWithGameData.VisionData:
			case Combo.Event.HitBoxConfigureWithGameData.VisionDataWithDistanceOnly:
				hitBoxRadius = logicComponent.visionRange;
				break;
			case Combo.Event.HitBoxConfigureWithGameData.HearData:
				hitBoxRadius = logicComponent.hearRange;
				break;
			case Combo.Event.HitBoxConfigureWithGameData.BodyDataWithSize:
				hitBoxRadius = _actor.dtCollider.Radius;
				break;
			default:
				throw new ArgumentOutOfRangeException("hitBoxConfigureWithGameData", hitBoxConfigureWithGameData, null);
			case Combo.Event.HitBoxConfigureWithGameData.Disable:
			case Combo.Event.HitBoxConfigureWithGameData.VisionDataWithAngleOnly:
				break;
			}
			break;
		case HitBox.Shape.Fan:
			switch (hitBoxConfigureWithGameData)
			{
			case Combo.Event.HitBoxConfigureWithGameData.VisionData:
				hitBoxRadius = logicComponent.visionRange;
				hitBoxAngle = logicComponent.visionDeg;
				break;
			case Combo.Event.HitBoxConfigureWithGameData.VisionDataWithDistanceOnly:
				hitBoxRadius = logicComponent.visionRange;
				break;
			case Combo.Event.HitBoxConfigureWithGameData.VisionDataWithAngleOnly:
				hitBoxAngle = logicComponent.visionDeg;
				break;
			case Combo.Event.HitBoxConfigureWithGameData.HearData:
				hitBoxRadius = logicComponent.hearRange;
				break;
			case Combo.Event.HitBoxConfigureWithGameData.BodyDataWithSize:
				hitBoxRadius = _actor.dtCollider.Radius;
				break;
			default:
				throw new ArgumentOutOfRangeException("hitBoxConfigureWithGameData", hitBoxConfigureWithGameData, null);
			case Combo.Event.HitBoxConfigureWithGameData.Disable:
				break;
			}
			break;
		default:
			throw new ArgumentOutOfRangeException("hitBoxShape", hitBoxShape, null);
		}
	}

	public void PlayEffect(bool oneShot, int eventIndex, Combo.Event comboEvent, TSVector2 pos, FP posY, FP rot, bool bindActor = true)
	{
		var (vector, spawnRotation) = ConvertEventPositionAndRotationToTransformSpace(pos, posY, rot);
		if (comboEvent.effectPrefab != null)
		{
			AdventureFXPlayer adventureFXPlayer;
			if (comboEvent.isEarlyWarningEffect)
			{
				FP effectDuration = comboEvent.effectDuration;
				adventureFXPlayer = AdventureEarlyWarningFXPlayer.PlayFX(comboEvent.effectPrefab, (float)effectDuration, vector, spawnRotation, comboEvent.effectScale);
				oneShot = true;
			}
			else
			{
				float playbackSpeed = comboEvent.effectPlaySpeed * (float)_comboPlaySpeedMultiplier;
				adventureFXPlayer = AdventureFXPlayer.PlayFX(comboEvent.effectPrefab, playbackSpeed, vector, spawnRotation, comboEvent.effectScale);
			}
			if (adventureFXPlayer == null)
			{
				NovaLogger.Error("comboclip event play effect error: fx is null, " + comboEvent.effectPrefab.name);
				return;
			}
			adventureFXPlayer.ownerActor = _actor;
			if (comboEvent.actorScale)
			{
				adventureFXPlayer.sizeScale = owner.transform.localScale.x;
			}
			if (bindActor)
			{
				if (_actor.playingCombo != null)
				{
					Combo.Phase comboPhase = (comboEvent.cancelEffectWhenLoopStop ? (Combo.Phase.Anticipation | Combo.Phase.Activation) : Combo.Phase.All);
					adventureFXPlayer.Bind(_actor.gameObject, null, ActorState.Null, _actor.playingCombo, comboPhase, comboEvent.interruptCancelEffect);
				}
				else
				{
					adventureFXPlayer.Bind(_actor.gameObject, null, _actor.state);
				}
			}
			if (!oneShot && eventIndex >= 0)
			{
				_triggeredEventEffects.set_Item(eventIndex, adventureFXPlayer);
				_triggeredEventEffectTokens.set_Item(eventIndex, adventureFXPlayer.token);
			}
		}
		if (comboEvent.playerfeedbackEffectConfigureData != null)
		{
			AdventurePlayerFeedbackEffectConfigureData.PlayerFeedbackEffectInfo playerFeedbackEffectInfo = comboEvent.playerfeedbackEffectConfigureData.Play(vector, _actor.gameObject, GetCameraShakeSort());
			_currentPlayerFeedbackEffectConfigureData = comboEvent.playerfeedbackEffectConfigureData;
			long cameraShakeUniqueId = playerFeedbackEffectInfo.cameraShakeUniqueId;
			long racialBlurUniqueId = playerFeedbackEffectInfo.racialBlurUniqueId;
			_cameraShakeUniqueId = cameraShakeUniqueId;
			_racialBlurUniqueId = racialBlurUniqueId;
			_interruptPlayerFeedbackEffect = comboEvent.interruptCancelPlayerFeedbackEffect;
		}
	}

	protected bool SoundEventCanPost(Combo.Event comboEvent)
	{
		return false;
	}

	public Combo.FeaturePhase QueryCurrentActivedFeaturePhase()
	{
		if (_phases.Count > 0 && _currentFeaturePhaseIndex != -1)
		{
			return _phases.get_Item(_currentFeaturePhaseIndex);
		}
		return null;
	}

	protected void InitFeaturePhases()
	{
		ResetFeaturePhases();
		ProcessFeathurePhases();
	}

	private void ProcessFeathurePhases()
	{
		if (!(currentComboClip != null) || currentComboClip.featurePhases == null || currentComboClip.featurePhases.Length == 0)
		{
			return;
		}
		Dictionary<float, Combo.FeaturePhase> dictionary = new Dictionary<float, Combo.FeaturePhase>();
		for (int i = 0; i < currentComboClip.featurePhases.Length; i++)
		{
			if (currentComboClip.animationClip != null)
			{
				Combo.FeaturePhase featurePhase = currentComboClip.featurePhases[i];
				float key = Mathf.Round(currentComboClip.animationClip.length * (float)featurePhase.activeNormalizedTime * 60f);
				if (dictionary.ContainsKey(key))
				{
					if (dictionary.get_Item(key).autoGenerate && !featurePhase.autoGenerate)
					{
						dictionary.set_Item(key, featurePhase);
					}
				}
				else
				{
					dictionary.set_Item(key, featurePhase);
				}
				_phases = dictionary.Values.ToList();
			}
			else
			{
				_phases.Add(currentComboClip.featurePhases[i]);
			}
		}
		_phases.Sort((Combo.FeaturePhase x, Combo.FeaturePhase y) => x.activeNormalizedTime.CompareTo(y.activeNormalizedTime));
		_nextFeaturePhaseActiveNormalizedTime = _phases.get_Item(0).activeNormalizedTime;
	}

	internal void UpdateFeaturePhase(FP comboClipNormalizedTime)
	{
		if (_phases.Count > 0 && _nextFeaturePhaseIndex < _phases.Count && comboClipNormalizedTime >= _nextFeaturePhaseActiveNormalizedTime)
		{
			_currentFeaturePhaseIndex = _nextFeaturePhaseIndex;
			_nextFeaturePhaseIndex++;
			currentFeaturePhase = _phases.get_Item(_currentFeaturePhaseIndex);
			_actor._onFeaturePhaseActive?.Invoke(_actor, _currentFeaturePhaseIndex, currentFeaturePhase);
			if (_nextFeaturePhaseIndex < _phases.Count)
			{
				Combo.FeaturePhase featurePhase = _phases.get_Item(_nextFeaturePhaseIndex);
				_nextFeaturePhaseActiveNormalizedTime = featurePhase.activeNormalizedTime;
			}
		}
	}

	internal void ResetFeaturePhases()
	{
		_currentFeaturePhaseIndex = -1;
		_nextFeaturePhaseIndex = 0;
		_nextFeaturePhaseActiveNormalizedTime = FP.Zero;
		_phases.Clear();
	}

	private bool iEnableRootMotion()
	{
		if (currentComboClip == null || !currentComboClip.enableRootMotion)
		{
			return false;
		}
		FP rootMotionCheckDistance = currentComboClip.rootMotionCheckDistance;
		FP rootMotionCheckDistanceLimitUp = currentComboClip.rootMotionCheckDistanceLimitUp;
		bool flag = rootMotionCheckDistance > 0;
		bool flag2 = rootMotionCheckDistanceLimitUp > 0;
		if ((!flag && !flag2) || ((flag & flag2) && rootMotionCheckDistance > rootMotionCheckDistanceLimitUp))
		{
			return true;
		}
		if (_actor?.attackTarget == null)
		{
			return true;
		}
		FP fP = TSVector2.Angle(_actor.tsTransform.Forward, (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized);
		if (fP <= 315 && fP >= 45)
		{
			return true;
		}
		FP fP2 = _actor.DistanceWithRadius(_actor.attackTarget);
		if (flag && fP2 <= rootMotionCheckDistance)
		{
			return false;
		}
		if (flag2 && fP2 >= rootMotionCheckDistanceLimitUp)
		{
			return false;
		}
		return true;
	}

	protected void InitRootMotion()
	{
		ResetRootMotion();
		if (_applyRootMotion || applyRootMotionRotate)
		{
			currentComboClip.CalcRootMotion(0f, out var rootMotionTranslate, out _lastRootMotionRotation, out var rootMotionRotateAngle);
			_lastRootMotionTranslate = new TSVector2(rootMotionTranslate.x, rootMotionTranslate.z) * _rootMotionScale;
			_lastRootMotionRotateAngle = rootMotionRotateAngle;
		}
	}

	internal void UpdateRootMotion(FP normalizedTime)
	{
		if (normalizedTime > _lastRootMotionNormalizedTime)
		{
			if (_applyRootMotion || applyRootMotionRotate)
			{
				FP time = normalizedTime * currentComboClip.animationLength;
				currentComboClip.CalcRootMotion(time, out var rootMotionTranslate, out _lastRootMotionRotation, out var rootMotionRotateAngle);
				TSVector2 tSVector = new TSVector2(rootMotionTranslate.x, rootMotionTranslate.z) * _rootMotionScale;
				_deltaRootMotionTranslate = tSVector - _lastRootMotionTranslate;
				_lastRootMotionTranslate = tSVector;
				_deltaRootMotionRotateAngle = rootMotionRotateAngle - _lastRootMotionRotateAngle;
				_lastRootMotionRotateAngle = rootMotionRotateAngle;
				ApplyRootMotionRotateToRootMotionTranslate(ref _deltaRootMotionTranslate);
			}
			_lastRootMotionNormalizedTime = normalizedTime;
		}
		else
		{
			_deltaRootMotionTranslate = TSVector2.zero;
			_deltaRootMotionRotateAngle = FP.Zero;
		}
	}

	internal void ApplyRootMotionRotateToRootMotionTranslate(ref TSVector2 deltaTranslate)
	{
		if (applyRootMotionRotate)
		{
			TSVector tSVector = new TSVector(deltaTranslate.x, FP.Zero, deltaTranslate.y);
			tSVector = TSQuaternion.Inverse(_lastRootMotionRotation) * tSVector;
			deltaTranslate.x = tSVector.x;
			deltaTranslate.y = tSVector.z;
		}
	}

	protected void ResetRootMotion()
	{
		_lastRootMotionNormalizedTime = FP.Zero;
		_lastRootMotionTranslate = TSVector2.zero;
		_deltaRootMotionTranslate = TSVector2.zero;
		_lastRootMotionRotateAngle = FP.Zero;
		_deltaRootMotionRotateAngle = FP.Zero;
		_lastRootMotionRotation = TSQuaternion.identity;
	}
}
