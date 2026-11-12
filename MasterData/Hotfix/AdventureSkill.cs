#define LOG_ERROR
#define LOG_TRACE
using System;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class AdventureSkill : LogicEntity
{
	protected AIAdapter _ai;

	protected AdventureSkillPhaseConfig _phaseConfig;

	protected Skill _skillInfo;

	protected Action<bool> _finishCallback;

	protected Action<FP> _beginCDForMonsterCallback;

	protected PlayerSkillCd _playerSkillCd;

	protected bool _alreadyResume;

	protected SkillCountdownTiming _countdownTiming;

	protected SkillLauncherType _skillLauncherType;

	protected SkillPhaseFeatureFlag _skillCastBehaviourType;

	protected Action _setPhaseExecuteConfigCallback;

	protected AdventureLevelObjPoolMgr.PoolObj _poolObj;

	public bool isActivationEnd;

	public bool isDodgeSkill;

	public bool CanExecuteOtherSkillWhenSemiAutoBattle;

	public int skillId { get; private set; }

	public bool checkCdRestore { get; private set; }

	public bool forceRunFinish { get; private set; }

	public List<GameObject> targets { get; private set; }

	public List<int> breakSkillIds { get; private set; }

	public GameObject owner { get; private set; }

	public AdventureActor actor { get; private set; }

	public ActorSkillManage actorSkillManage { get; private set; }

	public SkillPhaseFeatureFlag skillCastBehaviourType => _skillCastBehaviourType;

	public SkillCountdownTiming CountdownTiming => _countdownTiming;

	public bool IsRemoved { get; private set; }

	protected override void OnInit()
	{
	}

	protected override void OnActive()
	{
		EnableLogicUpdate();
	}

	public void InitSkill(int skillId, GameObject owner, List<GameObject> targets, SkillLauncherType skillLauncherType, bool isInterruptAttack, bool isBreakable, SkillPhaseFeatureFlag skillCastBehaviourType, SkillCountdownTiming countdownTiming, Action<bool> finishCallback = null, Action<FP> beginCDForMonsterCallback = null, bool ingoreCDAndEnergy = false)
	{
		this.skillId = skillId;
		this.owner = owner;
		this.targets = targets;
		_finishCallback = finishCallback;
		_beginCDForMonsterCallback = beginCDForMonsterCallback;
		_countdownTiming = countdownTiming;
		_skillLauncherType = skillLauncherType;
		_skillCastBehaviourType = skillCastBehaviourType;
		actor = owner.GetComponent<AdventureActor>();
		if (actor == null)
		{
			actor = owner.GetComponent<AdventureSkill>().actor;
		}
		if (actor == null)
		{
			NovaLogger.Error("init skill actor is null, owner name:" + owner.name);
			return;
		}
		actorSkillManage = actor.GetLogicComponent<ActorSkillManage>();
		Parent = actor;
		isDodgeSkill = skillCastBehaviourType == SkillPhaseFeatureFlag.Dodge;
		switch (skillLauncherType)
		{
		default:
			_phaseConfig = new AdventureSkillPhaseConfig(skillLauncherType != SkillLauncherType.Character, isBreakable);
			if (breakSkillIds == null)
			{
				List<int> list = (breakSkillIds = new List<int>(5));
			}
			breakSkillIds.Clear();
			actorSkillManage.BreakOthers(skillCastBehaviourType, skillId, breakSkillIds);
			if (isInterruptAttack)
			{
				actor.InterruptAttack(force: true);
			}
			actorSkillManage.AddAttachedSkill(this);
			_playerSkillCd = actor.GetLogicComponent<PlayerSkillCd>();
			break;
		case SkillLauncherType.Effect:
			actorSkillManage.AddAttachedPassiveSkill(this);
			break;
		case SkillLauncherType.FakeActor:
			actorSkillManage?.AddAttachedPassiveSkill(this);
			break;
		}
		IsRemoved = false;
		if (_skillInfo == null)
		{
			_skillInfo = Singleton<HotfixDataController>.Instance.GetSkill(skillId);
		}
		checkCdRestore = _skillInfo.CheckCDRestore;
		forceRunFinish = _skillInfo.ForceRunFinish;
		if (_ai == null)
		{
			_ai = new AIAdapter();
			if (!_ai.Initialize(_skillInfo.FCPath, gameObject))
			{
				_ai = null;
			}
		}
		if (_skillLauncherType == SkillLauncherType.Character && _skillCastBehaviourType == SkillPhaseFeatureFlag.Skill1)
		{
			actor.attributeList.ChangeValue(41, 1, AdventureModuleController.Config.CharacterSkillAssignWeight);
		}
		if (_skillLauncherType == SkillLauncherType.Character && actor.actorInfo.attackType == HotfixEnum.characterAttackType.MELEE && _skillCastBehaviourType == SkillPhaseFeatureFlag.Normal)
		{
			actor.attributeList.ChangeValue(41, 1, AdventureModuleController.Config.MeleeCharacterNormalAttackAssignWeight);
		}
		if (skillCastBehaviourType == SkillPhaseFeatureFlag.Dodge && actor.isStiff)
		{
			actor.InterruptStiff();
		}
		if (_countdownTiming == SkillCountdownTiming.Start)
		{
			SetResumeTime();
		}
		if (!ingoreCDAndEnergy)
		{
			_playerSkillCd?.ReduceSkillSection(skillId, beginResume: false);
		}
		if (!ingoreCDAndEnergy)
		{
			_playerSkillCd?.ResetUseInterval(skillId);
		}
		_playerSkillCd?.CloseSkillUseTimeHint(skillId);
		if (skillCastBehaviourType == SkillPhaseFeatureFlag.Ultimate && !ingoreCDAndEnergy)
		{
			_playerSkillCd?.ClearEnergy();
		}
		NovaLogger.Trace("执行技能 script:" + _skillInfo.FCPath + ", actorName:" + actor.name);
		bool flag = false;
		if (skillLauncherType == SkillLauncherType.Character && actor is PlayerAdventureActor)
		{
			if (skillCastBehaviourType == SkillPhaseFeatureFlag.Skill1 || skillCastBehaviourType == SkillPhaseFeatureFlag.Ultimate)
			{
				MonoSingleton<LuaManager>.Instance?.FireEvent("PlayerAdventureActorCastSkill", actor.dataID, skillId);
			}
			flag = true;
		}
		if (flag || (skillLauncherType == SkillLauncherType.Monster && actor.IsPlayerSummoned(out var _, out var _)))
		{
			ModuleController<AdventureModuleController>.Instance.RecordCastSkill(actor.Id, flag, skillId, actor.dataID, skillCastBehaviourType);
		}
		if (skillLauncherType != SkillLauncherType.Effect)
		{
			AdventureActorCastSkillEvent adventureActorCastSkillEvent = AdventureActorCastSkillEvent.Generate();
			adventureActorCastSkillEvent.sender = actor;
			SkillEventInfo skillEventInfo = new SkillEventInfo(CommonHelper.GetSkillSlotType(skillCastBehaviourType), skillId, _skillInfo.CheckSkillInterval);
			adventureActorCastSkillEvent.skillEventInfo = skillEventInfo;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCastSkillEvent);
		}
		_ai?.Start();
	}

	public void Clear(bool isRelease = false)
	{
		if (IsRemoved)
		{
			return;
		}
		IsRemoved = true;
		if (_skillLauncherType == SkillLauncherType.Character && _skillCastBehaviourType == SkillPhaseFeatureFlag.Skill1)
		{
			actor?.attributeList.ChangeValue(41, 1, -AdventureModuleController.Config.CharacterSkillAssignWeight);
		}
		if (_skillLauncherType == SkillLauncherType.Character)
		{
			AdventureActor adventureActor = actor;
			if ((object)adventureActor != null && adventureActor.actorInfo.attackType == HotfixEnum.characterAttackType.MELEE && _skillCastBehaviourType == SkillPhaseFeatureFlag.Normal)
			{
				actor?.attributeList.ChangeValue(41, 1, -AdventureModuleController.Config.MeleeCharacterNormalAttackAssignWeight);
			}
		}
		if (actor != null)
		{
			actor.currentAttackTarget = null;
			if (isDodgeSkill && actorSkillManage != null && !actorSkillManage.HaveRushSkill() && actor is PlayerAdventureActor playerAdventureActor)
			{
				playerAdventureActor.dodgeButtonHold = false;
			}
		}
		if (_countdownTiming == SkillCountdownTiming.End)
		{
			SetResumeTime();
		}
		_ai?.Disable();
		SetCountdownForMonster();
		breakSkillIds?.Clear();
		targets?.Clear();
		targets = null;
		owner = null;
		actorSkillManage = null;
		_phaseConfig = null;
		_alreadyResume = false;
		if (_skillLauncherType != SkillLauncherType.Effect && ModuleController<AdventureModuleController>.Instance != null)
		{
			AdventureActorCastSkillEndEvent adventureActorCastSkillEndEvent = AdventureActorCastSkillEndEvent.Generate();
			adventureActorCastSkillEndEvent.sender = actor;
			SkillEventInfo skillEventInfo = (adventureActorCastSkillEndEvent.skillEventInfo = new SkillEventInfo(CommonHelper.GetSkillSlotType(skillCastBehaviourType), skillId));
			adventureActorCastSkillEndEvent.isRelease = isRelease;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCastSkillEndEvent);
			if (skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.D)
			{
				MonoSingleton<LuaManager>.Instance.FireEvent("SupUltraState", actor.dataID, a2: false);
			}
		}
		_finishCallback?.Invoke(obj: true);
		_finishCallback = null;
		actor = null;
		_setPhaseExecuteConfigCallback = null;
		CanExecuteOtherSkillWhenSemiAutoBattle = false;
		gameObject.SetActive(value: false);
	}

	public void Recycle()
	{
		if (_poolObj != null)
		{
			SceneSingleton<AdventureLevelObjPoolMgr>.Instance?.En_SkillTemplete(_poolObj);
			_poolObj = null;
		}
	}

	public void InitPoolOwner(AdventureLevelObjPoolMgr.PoolObj poolObj)
	{
		_poolObj = poolObj;
	}

	protected override void OnLogicUpdatePaused()
	{
		_ai?.Pause();
	}

	protected override void OnLogicUpdateResumed()
	{
		_ai?.Resume();
	}

	protected override void OnLogicUpdate()
	{
		_ai?.Update();
	}

	public void SetExecuteSkillPhaseConfigCallback(Action callback)
	{
		_setPhaseExecuteConfigCallback = callback;
	}

	public SkillPhaseConfig GetCurrentPhaseExecuteConfig()
	{
		if (_phaseConfig != null)
		{
			return _phaseConfig.ExecuteSkillPhaseConfig;
		}
		return null;
	}

	public void SetCurrentPhaseExecuteConfig(SkillPhaseConfig phaseConfig)
	{
		if (_phaseConfig == null)
		{
			return;
		}
		if (_phaseConfig != null)
		{
			_phaseConfig.ExecuteSkillPhaseConfig.skillPhaseFeatureFlag = phaseConfig.skillPhaseFeatureFlag;
			List<int> skillIds = phaseConfig.skillIds;
			if (skillIds != null && skillIds.Count > 0)
			{
				if (_phaseConfig.ExecuteSkillPhaseConfig.skillIds == null)
				{
					_phaseConfig.ExecuteSkillPhaseConfig.skillIds = new List<int>();
				}
				else
				{
					_phaseConfig.ExecuteSkillPhaseConfig.skillIds.Clear();
				}
				_phaseConfig.ExecuteSkillPhaseConfig.skillIds.AddRange(phaseConfig.skillIds);
			}
			else
			{
				_phaseConfig.ExecuteSkillPhaseConfig.skillIds?.Clear();
			}
		}
		_setPhaseExecuteConfigCallback?.Invoke();
	}

	public SkillPhaseConfig GetCurrentPhaseBreakConfig()
	{
		return _phaseConfig?.BreakSkillPhaseConfig;
	}

	public void SetCurrentPhaseBreakConfig(SkillPhaseConfig phaseConfig)
	{
		if (_phaseConfig == null)
		{
			return;
		}
		_phaseConfig.BreakSkillPhaseConfig.skillPhaseFeatureFlag = phaseConfig.skillPhaseFeatureFlag;
		List<int> skillIds = phaseConfig.skillIds;
		if (skillIds != null && skillIds.Count > 0)
		{
			if (_phaseConfig.BreakSkillPhaseConfig.skillIds == null)
			{
				_phaseConfig.BreakSkillPhaseConfig.skillIds = new List<int>();
			}
			else
			{
				_phaseConfig.BreakSkillPhaseConfig.skillIds.Clear();
			}
			_phaseConfig.BreakSkillPhaseConfig.skillIds.AddRange(phaseConfig.skillIds);
		}
		else
		{
			_phaseConfig.BreakSkillPhaseConfig.skillIds?.Clear();
		}
	}

	public void SetResumeTime()
	{
		if (_skillLauncherType == SkillLauncherType.Character && !_alreadyResume)
		{
			_playerSkillCd?.SetSkillBeginResume(skillId);
			_alreadyResume = true;
		}
	}

	public void SetCountdownForMonster()
	{
		if (_skillLauncherType == SkillLauncherType.Monster && !_alreadyResume)
		{
			_beginCDForMonsterCallback?.Invoke(FP.FromMyriad(_skillInfo.SkillCD));
			_alreadyResume = true;
			_beginCDForMonsterCallback = null;
		}
	}

	protected override void OnDeactive()
	{
		_ai?.Disable();
	}
}
