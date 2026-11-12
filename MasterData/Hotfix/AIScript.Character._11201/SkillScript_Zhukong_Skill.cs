#define LOG_DEBUG
using System;
using TrueSync;

namespace AIScript.Character._11201;

public class SkillScript_Zhukong_Skill : Skill
{
	private readonly string huiXuanZhan = "Skill_Main_T2_HuiXuanZhan";

	private readonly string huiXuanZhan_p5 = "Skill_Main_T2_HuiXuanZhan_T5";

	private readonly string Skill1_2 = "Skill_Main_XunFengZhan";

	private readonly string Skill1_2_p6 = "Skill_Main_XunFengZhan_T6";

	private readonly string Skill1Sp_1 = "Skill_Main_XunFengZhan";

	private readonly string Skill1Sp_1_p6 = "Skill_Main_XunFengZhan_T6";

	private readonly string Skill1Sp_2 = "Skill_Main_T1_ZaDi";

	private readonly string Skill1Sp_2_p6 = "Skill_Main_T1_ZaDi_T6";

	private readonly string event_start_inv = "ChenShaChuanTouOpen";

	private readonly string event_end_inv = "ChenShaChuanTouClose";

	protected bool skillPerk1;

	protected bool skillPerk2;

	protected bool skillPerk6;

	private bool beRebind;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11201 SkillScript_B1_Skill OnDisable");
		base.OnSkillDisable();
		_actor.CancelAiming();
		_actor.DisableInvincible();
		_actor.movAgent.canBlock = true;
		if (!_isDisableByLostControl)
		{
			ReBindSkill();
		}
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
		_actor.movementFSM.runtimeIgonreRootMotion = false;
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11201 SkillScript_B1_Skill OnEnable");
		base.OnSkillEnable();
		beRebind = false;
		skillPerk1 = ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, Parallel.personalPerkId_1, out var perkLevel);
		skillPerk2 = ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511202, out perkLevel);
		skillPerk6 = ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511206, out perkLevel);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_ACTOR_CASTSKILL", OnCastSkill);
	}

	private void OnCastSkill(IEvent evt)
	{
		AdventureActorCastSkillEvent adventureActorCastSkillEvent = evt as AdventureActorCastSkillEvent;
		if (!(adventureActorCastSkillEvent.sender as PlayerAdventureActor != _actor) && adventureActorCastSkillEvent.skillEventInfo.skillSlotType == HotfixEnum.skillSlotType.A && comboStep == 3 && !_actor.logicVariable.GetLogicTagToggle("DogeSkill"))
		{
			_skillManager.BindSkillIdToButton(ActionKey.B, Parallel.skillId_StageOne);
		}
	}

	public void aimDirec()
	{
		TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (movementInputDirection != TSVector2.zero)
		{
			_actor.CancelAiming();
			_actor.Aim(movementInputDirection);
		}
	}

	private string GetHuiXuanZhan()
	{
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 511205, out var _))
		{
			return huiXuanZhan_p5;
		}
		return huiXuanZhan;
	}

	public string GetActionTag()
	{
		comboStep = 0;
		if (_skill.skillId == Parallel.skillId_StageTwo)
		{
			_actor.logicVariable.ToggleLogicTag("FinishReset", value: true);
		}
		if (_actor.logicVariable.GetLogicTagToggle("DogeSkill") && skillPerk2)
		{
			comboStep = 2;
			if (_skill.skillId == Parallel.skillId_StageTwo)
			{
				comboStep = 4;
			}
			return GetHuiXuanZhan();
		}
		if (skillPerk1)
		{
			_actor.logicVariable.ToggleLogicTag("main_skillEnable", value: true);
			comboStep = 1;
			if (_skill.skillId == Parallel.skillId_StageOne)
			{
				if (skillPerk6)
				{
					return Skill1Sp_1_p6;
				}
				return Skill1Sp_1;
			}
			comboStep = 3;
			if (skillPerk6)
			{
				return Skill1Sp_2_p6;
			}
			return Skill1Sp_2;
		}
		_actor.logicVariable.ToggleLogicTag("main_skillEnable", value: true);
		if (skillPerk6)
		{
			return Skill1_2_p6;
		}
		return Skill1_2;
	}

	public override void OnStart()
	{
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
		LockDirection();
		string actionTag = GetActionTag();
		System.Action onActivationEnd = OnActivationEnd;
		Action<string> onCustomEvent = OnCustomEvent;
		System.Action onAnticipationEnd = OnAnticipationEnd;
		System.Action onInterrupt = OnInterrupt;
		System.Action onComboFinish = OnFinish;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent, onActivationEnd);
		_actor.logicVariable.ToggleLogicTag("DogeSkill", value: false);
	}

	protected void OnAnticipationEnd()
	{
		if (skillPerk2 && comboStep != 2 && comboStep != 4)
		{
			_actor.logicVariable.ToggleLogicTag("DogeSkill", value: true);
		}
		else
		{
			OnStepTwoBegin();
		}
	}

	protected virtual void OnActivationEnd()
	{
		if (!skillPerk2 || comboStep == 2 || comboStep == 4)
		{
			ReBindSkill();
			_actor.logicVariable.ToggleLogicTag("DogeSkill", value: false);
			return;
		}
		string actionTag = GetActionTag();
		System.Action onComboFinish = OnFinish_Two;
		System.Action onInterrupt = OnInterrupt;
		System.Action onAnticipationEnd = OnStepTwoBegin;
		Action<string> onCustomEvent = OnCustomEvent;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt, onCustomEvent);
		_actor.logicVariable.ToggleLogicTag("DogeSkill", value: false);
	}

	protected void OnStepTwoBegin()
	{
		ReBindSkill();
		_actor.logicVariable.ToggleLogicTag("DogeSkill", value: false);
	}

	protected override void OnCustomEvent(string eventName)
	{
		base.OnCustomEvent(eventName);
		if (eventName.Equals(event_start_inv))
		{
			_actor.EnableInvincible();
			_actor.movAgent.canBlock = false;
		}
		else if (eventName.Equals(event_end_inv))
		{
			_actor.DisableInvincible();
			_actor.movAgent.canBlock = true;
		}
		NovaLogger.Debug("_11201 SkillScript_B1_Skill OnCustomEvent: " + eventName);
	}

	protected virtual void OnFinish()
	{
		if (!skillPerk2 || (comboStep != 1 && comboStep != 3))
		{
			OnFinish_Two();
		}
	}

	protected virtual void OnFinish_Two()
	{
		_skill.Clear();
	}

	protected virtual void OnInterrupt()
	{
		ReBindSkill();
		NovaLogger.Debug("===================_11201 SkillScript_B1_Skill onInterrupt");
		_skill.Clear();
	}

	private void ReBindSkill()
	{
		if (beRebind)
		{
			return;
		}
		beRebind = true;
		bool flag = skillPerk1;
		if (flag)
		{
			flag = ((!skillPerk2) ? (comboStep == 1 || comboStep == 3) : (comboStep == 2 || comboStep == 4));
		}
		if (flag)
		{
			if (_skill.skillId == Parallel.skillId_StageOne)
			{
				_skillManager.BindSkillIdToButton(ActionKey.B, Parallel.skillId_StageTwo);
				_actor.logicVariable.ToggleLogicTag("BeginReset", value: true);
				ModuleController<AdventureModuleController>.Instance?.SetLevelLogicValue("112BeginReset", value: true);
			}
			else
			{
				_skillManager.BindSkillIdToButton(ActionKey.B, Parallel.skillId_StageOne);
			}
		}
	}

	public void OnUpdate()
	{
		if (_skill.skillId == Parallel.skillId_StageOne)
		{
			LockDirection();
		}
		if (SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection() != TSVector2.zero)
		{
			_actor.movementFSM.runtimeIgonreRootMotion = true;
		}
		else
		{
			_actor.movementFSM.runtimeIgonreRootMotion = false;
		}
	}
}
