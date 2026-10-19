using System;
using System.Collections.Generic;
using System.Threading;
using ACT.Battle.Configs;
using ACT.Event;
using ACT.EventTrack;
using AOT.Animation;
using Bamboo.ECS;
using Cysharp.Threading.Tasks;
using Fundamental;
using UnityEngine;
using UnityEngine.Animations;
using UnityEngine.Playables;
using UnityEngine.Rendering;

namespace ACT.Battle;

public class CompMotion : EcsComponent
{
	public struct VolumePlayParam
	{
		public float duration;

		public bool useSpeedLine;

		public bool useSpeedLineWithDirection;

		public Vector3 speedLineDir;
	}

	public const int MAX_LAYER = 3;

	public List<FSMRuntimeState>[] layerMotionQueue;

	public Dictionary<string, ConfigAnimParameter> parameters;

	public List<StateTransition> possibleAnyStateTransitions;

	public string lastConflictTrigger;

	public float lastConflictTriggerTimer;

	public List<string> resetTriggerList;

	public ConfigMotion[] moveMotions;

	public ConfigMotion[] attackMotions;

	public int layerCount;

	public Animator animator;

	public PlayableGraph playable;

	public AnimationMixerPlayable[] mixers;

	public AnimationLayerMixerPlayable layerMix;

	public Dictionary<string, int> effectMotions;

	public StateController moveController;

	public StateAttackController attackController;

	public ConfigAttackStateMachine currentAttackFSM;

	public ConfigAttackFSMOverlay currentAttackFSMOverlay;

	public ConfigAttackStateMachine pendingAttackFSM;

	public ConfigAttackFSMOverlay pendingAttackFSMOverlay;

	public AnimationSchema animationSchema;

	public List<FSMRuntimeState> toReleaseFsmRuntimeStates;

	public Dictionary<int, bool> timelineStateFinished = new Dictionary<int, bool>();

	private MotionState _curMotionState;

	private StateTag _curStateTag;

	public FSMRuntimeState layer0Peak;

	public ConfigMotion layer0PeakConfig;

	public FSMRuntimeState lastLayer0Peak;

	public ConfigMotion lastLayer0PeakConfig;

	[NonSerialized]
	public bool suppressSwitchOutAreaAttack;

	private int _jumpInAirCount;

	private int m_dodgeInAirCount;

	private int m_AirAttackCount;

	private int m_AirAIndex;

	public ActionList<int> jumpCountChange;

	public ActionList<int> dodgeCountChange;

	public ActionList<int> airAttackCountChange;

	public ActionList<int> airAIndexChange;

	public int weaponACount;

	public int weaponBCount;

	public List<Skill> skills;

	public Dictionary<string, Skill> skillLookup;

	public HashSet<string> banedMotions;

	public GameObject ultimetaTimeline;

	public YooAssetReference currentUltimetaTimelineReference;

	public Animator volumeAnimator;

	public float volumeTime;

	public float volumeSpeed;

	public readonly string volumeAnimatorEndStateName = "VolumeEnd";

	public Action<FSMRuntimeState, ConfigMotion> OnSwitchIn;

	public Action<FSMRuntimeState, ConfigMotion> OnSwitchOut;

	public Action<MotionState, MotionState> onMotionChange;

	public int montageExclusiveRefCount;

	private float m_RunDuration;

	public EndureType endureLevel;

	public ulong runtimeMotionTags;

	public ulong motionTags;

	public ulong lastMotionTags;

	public long chasingEnterTimeStamp;

	public bool isChasingSuccess;

	private bool m_IsRemain;

	private bool m_isRemainShowCharacter;

	public bool DieAnimationEnd;

	private EntityTag m_entityTags;

	private (float, float) m_existenceTime;

	public bool IsHaveHitLayer;

	public CancellationTokenSource volumePlayCts;

	public CancellationToken volumePlayCt;

	public AnimationScriptPlayable globalYScalePlayable;

	public MotionState curMotionState
	{
		get
		{
			return _curMotionState;
		}
		set
		{
			_curMotionState = value;
		}
	}

	public StateTag curStateTag
	{
		get
		{
			return _curStateTag;
		}
		set
		{
			_curStateTag = value;
		}
	}

	public int JumpInAirCount
	{
		get
		{
			return _jumpInAirCount;
		}
		set
		{
			if (_jumpInAirCount != value)
			{
				owner.SetInt("jumpInAirCount", value);
				jumpCountChange?.Invoke(value);
			}
			_jumpInAirCount = value;
		}
	}

	public int dodgeInAirCount
	{
		get
		{
			return m_dodgeInAirCount;
		}
		set
		{
			if (m_dodgeInAirCount != value)
			{
				owner.SetInt("dodgeInAirCount", value);
				dodgeCountChange?.Invoke(value);
			}
			m_dodgeInAirCount = value;
		}
	}

	public int airAttackCount
	{
		get
		{
			return m_AirAttackCount;
		}
		set
		{
			if (m_AirAttackCount != value)
			{
				m_AirAttackCount = value;
				airAttackCountChange?.Invoke(value);
			}
		}
	}

	public int AirAIndex
	{
		get
		{
			return m_AirAIndex;
		}
		set
		{
			if (m_AirAIndex != value)
			{
				m_AirAIndex = value;
				airAIndexChange?.Invoke(value);
			}
		}
	}

	public bool IsMontageExclusiveLocked => montageExclusiveRefCount > 0;

	public float RunDuration
	{
		get
		{
			return m_RunDuration;
		}
		set
		{
			if (m_RunDuration != value)
			{
				m_RunDuration = value;
				SetFloat("RunDuration", value);
			}
		}
	}

	public bool IsRemain
	{
		get
		{
			return m_IsRemain;
		}
		set
		{
			m_IsRemain = value;
		}
	}

	public bool IsRemainShowCharacter
	{
		get
		{
			return m_isRemainShowCharacter;
		}
		set
		{
			m_isRemainShowCharacter = value;
		}
	}

	public EntityTag entityTags
	{
		get
		{
			return m_entityTags;
		}
		set
		{
			m_entityTags = value;
		}
	}

	public (float, float) existenceTime
	{
		get
		{
			return m_existenceTime;
		}
		set
		{
			m_existenceTime = value;
		}
	}

	public bool InTag(MotionTag_backUp tag)
	{
		return (motionTags & (ulong)(1L << (int)tag)) != 0;
	}

	public void AddRuntimeMotionTag(MotionTag_backUp tag)
	{
		runtimeMotionTags |= (ulong)(1L << (int)tag);
	}

	public void RemoveRuntimeMotionTag(MotionTag_backUp tag)
	{
		runtimeMotionTags &= (ulong)(~(1L << (int)tag));
	}

	public CompMotion()
	{
		layerMotionQueue = new List<FSMRuntimeState>[3];
		for (int i = 0; i < 3; i++)
		{
			layerMotionQueue[i] = new List<FSMRuntimeState>();
		}
		mixers = new AnimationMixerPlayable[3];
		effectMotions = new Dictionary<string, int>();
		parameters = new Dictionary<string, ConfigAnimParameter>();
		possibleAnyStateTransitions = new List<StateTransition>();
		resetTriggerList = new List<string>(10);
		lastConflictTrigger = string.Empty;
		banedMotions = new HashSet<string>();
		skills = new List<Skill>();
		skillLookup = new Dictionary<string, Skill>();
		jumpCountChange = new ActionList<int>();
		dodgeCountChange = new ActionList<int>();
		airAttackCountChange = new ActionList<int>();
		airAIndexChange = new ActionList<int>();
		toReleaseFsmRuntimeStates = new List<FSMRuntimeState>();
	}

	protected override void OnGet()
	{
	}

	protected override void OnRelease()
	{
		CompBehave compBehave = owner.GetCompBehave();
		if (compBehave != null)
		{
			compBehave.EntityTags.onEntityTagCountChange -= OnEntityTagCountChange;
		}
		DeActiveVolume();
		dodgeCountChange.Clear();
		jumpCountChange.Clear();
		airAttackCountChange.Clear();
		airAIndexChange.Clear();
		if (playable.IsValid())
		{
			playable.Destroy();
		}
		AnimationMixerPlayable[] array = mixers;
		foreach (AnimationMixerPlayable animationMixerPlayable in array)
		{
			if (animationMixerPlayable.IsValid())
			{
				animationMixerPlayable.Destroy();
			}
		}
		SystemBehave behaveSystem = GameManager.behaveSystem;
		List<FSMRuntimeState>[] array2 = layerMotionQueue;
		foreach (List<FSMRuntimeState> list in array2)
		{
			foreach (FSMRuntimeState item in list)
			{
				behaveSystem.motionStatePool.Release(item);
			}
			list.Clear();
		}
		parameters.Clear();
		timelineStateFinished.Clear();
		possibleAnyStateTransitions.Clear();
		lastConflictTrigger = string.Empty;
		lastConflictTriggerTimer = 0f;
		resetTriggerList.Clear();
		moveController = null;
		attackController = null;
		currentAttackFSM = null;
		currentAttackFSMOverlay = null;
		pendingAttackFSM = null;
		pendingAttackFSMOverlay = null;
		curMotionState = MotionState.Born;
		m_RunDuration = 0f;
		JumpInAirCount = 0;
		dodgeInAirCount = 0;
		airAttackCount = 0;
		AirAIndex = 0;
		layer0Peak = null;
		lastLayer0Peak = null;
		layer0PeakConfig = null;
		lastLayer0PeakConfig = null;
		suppressSwitchOutAreaAttack = false;
		skills.Clear();
		skillLookup.Clear();
		banedMotions.Clear();
		OnSwitchIn = null;
		OnSwitchOut = null;
		onMotionChange = null;
		montageExclusiveRefCount = 0;
		endureLevel = EndureType.None;
		motionTags = 0uL;
		runtimeMotionTags = 0uL;
		moveMotions = null;
		attackMotions = null;
		effectMotions.Clear();
		IsHaveHitLayer = false;
		volumeAnimator = null;
		if ((bool)ultimetaTimeline)
		{
			AssetStationManager.BattleStation.ReleaseInstance(ultimetaTimeline);
		}
		ultimetaTimeline = null;
		currentUltimetaTimelineReference = null;
		foreach (FSMRuntimeState toReleaseFsmRuntimeState in toReleaseFsmRuntimeStates)
		{
			if (toReleaseFsmRuntimeState != null)
			{
				behaveSystem.motionStatePool.Release(toReleaseFsmRuntimeState);
			}
		}
		toReleaseFsmRuntimeStates.Clear();
		IsRemain = false;
		m_isRemainShowCharacter = false;
		DieAnimationEnd = false;
	}

	private void OnEntityTagCountChange(EntityTag tag, int count)
	{
		switch (tag)
		{
		case EntityTag.SystemControl:
			owner.SetBool("SystemControl", count > 0);
			break;
		case EntityTag.None:
		case EntityTag.IgnoreAttack:
		case EntityTag.IgnoreTrap:
		case EntityTag.IgnoreControl:
		case EntityTag.UnHatable:
			break;
		}
	}

	public void InitRobots(Animator animator)
	{
		this.animator = animator;
		ConfigCharacter config = owner.GetConfig();
		for (int i = 0; i < config.moveFSM.parameters.Length; i++)
		{
			parameters[config.moveFSM.parameters[i].name] = config.moveFSM.parameters[i].Clone();
		}
		layerCount = Mathf.Max(config.moveFSM.layers.Length);
		playable = PlayableGraph.Create();
		playable.SetTimeUpdateMode(DirectorUpdateMode.Manual);
		AnimationPlayableOutput output = AnimationPlayableOutput.Create(playable, "Animator", animator);
		AnimationLayerMixerPlayable animationLayerMixerPlayable = AnimationLayerMixerPlayable.Create(playable, layerCount);
		output.SetSourcePlayable(animationLayerMixerPlayable);
		for (int j = 0; j < layerCount; j++)
		{
			mixers[j] = AnimationMixerPlayable.Create(playable);
			playable.Connect(mixers[j], 0, animationLayerMixerPlayable, j);
		}
	}

	public void Init(Animator animator)
	{
		this.animator = animator;
		ConfigCharacter config = owner.GetConfig();
		for (int i = 0; i < config.moveFSM.parameters.Length; i++)
		{
			parameters[config.moveFSM.parameters[i].name] = config.moveFSM.parameters[i].Clone();
		}
		for (int j = 0; j < config.attackFSM.parameters.Length; j++)
		{
			parameters[config.attackFSM.parameters[j].name] = config.attackFSM.parameters[j].Clone();
		}
		layerCount = 3;
		playable = PlayableGraph.Create(owner.GetMono().name);
		playable.SetTimeUpdateMode(DirectorUpdateMode.Manual);
		AnimationPlayableOutput output = AnimationPlayableOutput.Create(playable, owner.GetCompBehave().Animator.name, animator);
		layerMix = AnimationLayerMixerPlayable.Create(playable, layerCount);
		output.SetSourcePlayable(layerMix);
		SetLayer(0, null);
		ConfigAnimLayer[] layers = config.moveFSM.layers;
		ConfigAnimLayer[] layers2 = config.attackFSM.layers;
		if (layers.Length > 1)
		{
			ConfigAnimLayer layer = layers[1];
			SetLayer(1, layer, ResolveMoveLayerAvatarMask(layers, config.moveLayerOverrides, 1));
		}
		if (layers2.Length > 1)
		{
			ConfigAnimLayer layer2 = layers2[1];
			SetLayer(2, layer2);
		}
		for (int k = 0; k < layerCount; k++)
		{
			layerMix.SetInputWeight(k, 1f);
		}
		if (layers.Length > 1)
		{
			layerMix.SetInputWeight(1, 0f);
		}
		SkillConfig[] array = config.skills;
		foreach (SkillConfig skillConfig in array)
		{
			Skill skill = new Skill(owner, skillConfig, 0f, skillConfig.maxCount, (Skill s, int count) =>
			{
				if (count == 0)
				{
					string[] motions2 = s.config.motions;
					foreach (string text2 in motions2)
					{
						banedMotions.Add(text2);
						skillLookup[text2] = s;
					}
				}
				else
				{
					string[] motions2 = s.config.motions;
					foreach (string item in motions2)
					{
						banedMotions.Remove(item);
					}
				}
			});
			skills.Add(skill);
			string[] motions = skillConfig.motions;
			foreach (string text in motions)
			{
				if (skillConfig.maxCount == 0)
				{
					banedMotions.Add(text);
				}
				skillLookup[text] = skill;
			}
		}
		owner.GetCompBehave().EntityTags.onEntityTagCountChange += OnEntityTagCountChange;
	}

	public Skill GetSkill(string motionName)
	{
		if (skillLookup.TryGetValue(motionName, out var value))
		{
			return value;
		}
		return null;
	}

	public Skill GetSkillCd(string cdName)
	{
		foreach (Skill skill in skills)
		{
			if (skill.Name == cdName)
			{
				return skill;
			}
		}
		return null;
	}

	private void SetLayer(int index, ConfigAnimLayer layer, AvatarMask overrideAvatarMask = null)
	{
		if (layer != null)
		{
			layerMix.SetLayerAdditive((uint)index, layer.isAdditive);
			AvatarMask avatarMask = overrideAvatarMask ?? layer.avatarMask;
			if (avatarMask != null)
			{
				layerMix.SetLayerMaskFromAvatarMask((uint)index, avatarMask);
			}
		}
		mixers[index] = AnimationMixerPlayable.Create(playable);
		playable.Connect(mixers[index], 0, layerMix, index);
	}

	public void ApplyKnockLayerWeightByStateTag(StateTag tag)
	{
		if (layerMix.IsValid())
		{
			layerMix.SetInputWeight(1, (tag == StateTag.knockLayer) ? 1f : 0f);
		}
	}

	private static AvatarMask ResolveMoveLayerAvatarMask(ConfigAnimLayer[] layers, OverrideLayer[] overrides, int layerIndex)
	{
		AvatarMask result = null;
		if (layers != null && layerIndex >= 0 && layerIndex < layers.Length)
		{
			result = layers[layerIndex].avatarMask;
		}
		if (overrides == null)
		{
			return result;
		}
		for (int i = 0; i < overrides.Length; i++)
		{
			OverrideLayer overrideLayer = overrides[i];
			if (overrideLayer.layerIndex == layerIndex && overrideLayer.overrideMask != null)
			{
				result = overrideLayer.overrideMask;
			}
		}
		return result;
	}

	public void RecoverMotionCount()
	{
		ConfigCharacter config = owner.GetConfig();
		JumpInAirCount = config.jumpInAirCount;
		dodgeInAirCount = config.dogeInAirCount;
		airAttackCount = config.airAttackCount;
		AirAIndex = 0;
	}

	public void ReplaceMotionCount(Entity fromEntity)
	{
		CompMotion compMotion = fromEntity.GetCompMotion();
		JumpInAirCount = compMotion.JumpInAirCount;
		dodgeInAirCount = compMotion.dodgeInAirCount;
		AirAIndex = 0;
	}

	internal void SyncSkillCount(int skillCount, int index)
	{
		skills[index].SetSkillCount(skillCount);
	}

	internal void ConsumeSkillCount(Skill skill, bool useall)
	{
		if (useall)
		{
			skill.SetSkillCount(0);
		}
		else
		{
			skill.SetSkillCount(skill.NowCount - 1);
		}
	}

	internal void SetTrigger(string v)
	{
		if (!parameters.TryGetValue(v, out var value) || value.defaultBool)
		{
			return;
		}
		value.defaultBool = true;
		value.onParaChange?.Invoke(value);
		if (SystemBehave.InstantResetTriggers.Contains(v))
		{
			resetTriggerList.Add(v);
		}
		if (SystemBehave.ConflictTriggers.Contains(v))
		{
			if (lastConflictTriggerTimer >= 0f && v != lastConflictTrigger)
			{
				ResetTrigger(lastConflictTrigger);
			}
			lastConflictTrigger = v;
			if (GameManager.timeSystem.globalTimer.changing)
			{
				lastConflictTriggerTimer = 0.3f + GameLoader.meta.lastConflictTriggerTimer;
			}
			else
			{
				lastConflictTriggerTimer = 0.3f;
			}
		}
	}

	internal void ResetTrigger(string v)
	{
		if (parameters.TryGetValue(v, out var value) && value.type == ConfigAnimParameterType.Trigger && value.defaultBool)
		{
			value.defaultBool = false;
			value.onParaChange?.Invoke(value);
		}
	}

	internal void ResetBool(string v)
	{
		if (parameters.TryGetValue(v, out var value) && value.type == ConfigAnimParameterType.Bool && value.defaultBool)
		{
			value.defaultBool = false;
			value.onParaChange?.Invoke(value);
			MotionBoolParamChangeEvt evt = Singleton<EventManager>.instance.GetEvt<MotionBoolParamChangeEvt>();
			evt.entity = owner;
			evt.name = v;
			evt.value = false;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Motion_BoolParamChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	internal void ChangeRestBool()
	{
		string[] instantRestBool = SystemBehave.InstantRestBool;
		foreach (string v in instantRestBool)
		{
			ResetBool(v);
		}
	}

	public void ResetTriggerInput()
	{
		foreach (string resetTrigger in resetTriggerList)
		{
			ConfigAnimParameter configAnimParameter = parameters[resetTrigger];
			configAnimParameter.defaultBool = false;
			configAnimParameter.onParaChange?.Invoke(configAnimParameter);
		}
		resetTriggerList.Clear();
		if (lastConflictTriggerTimer >= 0f && lastConflictTrigger != string.Empty)
		{
			lastConflictTriggerTimer -= owner.GetCompTime()?.fixedDeltaTime ?? Time.fixedDeltaTime;
			if (lastConflictTriggerTimer < 0f)
			{
				ResetTrigger(lastConflictTrigger);
			}
		}
	}

	internal void SetBool(string v, bool b)
	{
		if (parameters.TryGetValue(v, out var value) && value.defaultBool != b)
		{
			value.defaultBool = b;
			value.onParaChange?.Invoke(value);
			MotionBoolParamChangeEvt evt = Singleton<EventManager>.instance.GetEvt<MotionBoolParamChangeEvt>();
			evt.entity = owner;
			evt.name = v;
			evt.value = b;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Motion_BoolParamChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	internal void SetFloat(string v, float f)
	{
		if (parameters.TryGetValue(v, out var value) && value.defaultFloat != f)
		{
			value.defaultFloat = f;
			value.onParaChange?.Invoke(value);
		}
	}

	internal void SetInt(string v, int i)
	{
		if (parameters.TryGetValue(v, out var value) && value.defaultInt != i)
		{
			value.defaultInt = i;
			value.onParaChange?.Invoke(value);
			MotionIntParamChangeEvt evt = Singleton<EventManager>.instance.GetEvt<MotionIntParamChangeEvt>();
			evt.entity = owner;
			evt.name = v;
			evt.value = i;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Motion_IntParamChange, evt);
			Singleton<EventManager>.instance.ReleaseEvt(evt);
		}
	}

	private void CheckAnyStateTransitions(string v)
	{
	}

	private bool CheckAnyStateTransitions(string v, StateController stateController, out List<StateTransition> transitions)
	{
		if (stateController == null)
		{
			transitions = null;
			return false;
		}
		bool result = stateController.CheckAnyStateTransitions(v, out var transitions2);
		transitions = transitions2;
		return result;
	}

	public void VolumePlay(Animator animator, VolumePlayParam volumePlayParam, Vector3 pos)
	{
		if (!(animator == null))
		{
			if (volumePlayCts != null && volumeAnimator != null)
			{
				volumePlayCts.Cancel();
				VolumeEnd(volumeAnimator);
			}
			animator.transform.position = pos;
			volumePlayCts = new CancellationTokenSource();
			PlayVolumeClip(animator, volumePlayParam, volumePlayCts.Token);
		}
	}

	private async void PlayVolumeClip(Animator animator, VolumePlayParam volumePlayParam, CancellationToken ct)
	{
		if (ct.IsCancellationRequested)
		{
			return;
		}
		if (volumeAnimator != null)
		{
			volumeAnimator.GetComponent<Volume>().enabled = false;
			volumeAnimator.gameObject.SetActive(value: false);
		}
		animator.gameObject.SetActive(value: true);
		volumeAnimator = animator;
		animator.speed = 1f;
		volumeTime = 0f;
		float num = float.MinValue;
		AnimationClip[] animationClips = animator.runtimeAnimatorController.animationClips;
		foreach (AnimationClip animationClip in animationClips)
		{
			if (num < animationClip.length)
			{
				num = Mathf.Max(volumeTime, animationClip.length);
			}
		}
		volumeTime = ((volumePlayParam.duration > 0f) ? volumePlayParam.duration : num);
		volumeSpeed = num / volumeTime;
		animator.speed = volumeSpeed;
		Volume volume = animator.GetComponent<Volume>();
		volume.enabled = true;
		if (volume == null)
		{
			if (LuminApplication.LogEnabled)
			{
				Debug.LogError("没有 Volume 组件");
			}
			return;
		}
		SetSpeedLineVolumeComponent(volume, volumePlayParam);
		await UniTask.WaitUntil(() => animator == null || animator.GetCurrentAnimatorStateInfo(0).IsName(volumeAnimatorEndStateName), PlayerLoopTiming.Update, ct).SuppressCancellationThrow();
		if (!ct.IsCancellationRequested && animator != null)
		{
			volume.enabled = false;
			VolumeEnd(animator);
		}
	}

	public static void SetSpeedLineVolumeComponent(Volume volume, VolumePlayParam volumePlayParam)
	{
	}

	public void VolumeEnd(Animator animator)
	{
		if (!(animator == null) && volumeAnimator == animator)
		{
			volumeAnimator.gameObject.SetActive(value: false);
			volumeAnimator = null;
		}
	}

	public void DeActiveVolume()
	{
		if (volumePlayCts != null)
		{
			volumePlayCts.Cancel();
		}
		if ((bool)volumeAnimator)
		{
			volumeAnimator.GetComponent<Volume>().enabled = false;
			VolumeEnd(volumeAnimator);
		}
	}

	public void UpdateTagParameters()
	{
		if (owner.IsCharacter())
		{
			SetBool("MotionForbidUltra", InTag(MotionTag_backUp.ForbidUltra));
			SetBool("MotionForbidDodgeAndGrab", InTag(MotionTag_backUp.ForbidDodgeAndGrab));
			SetBool("MotionForbidJump", InTag(MotionTag_backUp.ForbidJump));
			SetBool("MotionForbidWeapon1", InTag(MotionTag_backUp.ForbidWeapon1));
			SetBool("MotionForbidWeapon2", InTag(MotionTag_backUp.ForbidWeapon2));
			SetBool("UltraState", InTag(MotionTag_backUp.UltraState));
		}
	}

	public void UpdateMotionTags()
	{
		motionTags = 0uL;
		ConfigMotionTag[] array = layer0PeakConfig.motionTags;
		if (array != null)
		{
			foreach (ConfigMotionTag configMotionTag in array)
			{
				if (layer0Peak.DoByPercentPeriod(configMotionTag.start, configMotionTag.end, mustDo: false, canDoPeriod: true))
				{
					motionTags |= configMotionTag.FinalTagMask;
				}
			}
		}
		motionTags |= runtimeMotionTags;
		if (lastMotionTags != motionTags)
		{
			if (!InTag(MotionTag_backUp.TenacityImmune) && chasingEnterTimeStamp <= 0)
			{
				chasingEnterTimeStamp = TimeManager.LocalTime.NowTimestamp;
			}
			OnMotionTagChangeEvt evt = EventTrackSolver.Instance.GetEvt<OnMotionTagChangeEvt>();
			evt.lastTag = lastMotionTags;
			evt.newTag = motionTags;
			evt.entity = owner;
			EventTrackSolver.Instance.Dispatch(evt);
			if (InTag(MotionTag_backUp.TenacityImmune))
			{
				chasingEnterTimeStamp = 0L;
				isChasingSuccess = false;
			}
		}
		lastMotionTags = motionTags;
	}

	public void UpdateEndureLevel()
	{
		endureLevel = EndureType.None;
		ConfigEndureLevel[] endureLevels = layer0PeakConfig.endureLevels;
		if (endureLevels != null)
		{
			foreach (ConfigEndureLevel configEndureLevel in endureLevels)
			{
				if (layer0Peak.DoByPercentPeriod(configEndureLevel.start, configEndureLevel.end, mustDo: false, canDoPeriod: true))
				{
					endureLevel = (EndureType)Mathf.Max((int)endureLevel, (int)configEndureLevel.endureLevel);
				}
			}
		}
		CompAbility compAbility = owner.GetCompAbility();
		if (compAbility != null)
		{
			compAbility.motionEndureLevel = (int)endureLevel;
		}
	}

	private void MotionChange(MotionState curMotionState, MotionState nextMotionState)
	{
	}

	public void UpdateEntityTag()
	{
		if (Mathf.Approximately(m_existenceTime.Item1, 0f) && Mathf.Approximately(m_existenceTime.Item2, 0f))
		{
			return;
		}
		EntityTags entityTags = owner.GetCompBehave().EntityTags;
		if (layer0Peak.DoByPercentPeriod(m_existenceTime.Item1, m_existenceTime.Item2, mustDo: false, canDoPeriod: true))
		{
			if (!entityTags.InTag(m_entityTags))
			{
				entityTags.AddTag(m_entityTags);
			}
		}
		else
		{
			entityTags.RemoveTag(m_entityTags);
			m_entityTags = EntityTag.None;
			m_existenceTime = default;
		}
	}

	public void UpdateYScale()
	{
		if (Physics.Raycast(owner.GetBip001().position, Vector3.up, out var hitInfo, 5f, BattleConsts.enviromentMask) && globalYScalePlayable.IsValid())
		{
			YCurveScaleJob jobData = globalYScalePlayable.GetJobData<YCurveScaleJob>();
			float originalYDis = jobData.originalYDis;
			float distance = hitInfo.distance;
			if (distance < originalYDis)
			{
				jobData.yScale = distance / originalYDis;
				jobData.yScale *= 0.6f;
				globalYScalePlayable.SetJobData(jobData);
			}
		}
	}
}
