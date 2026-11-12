using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12501;

public class ActionScript_MainControl : ActionScript
{
	private int _triggerTimes_P11;

	private FP _lastTriggerTime_P13;

	protected override void OnActionEnable()
	{
		base.OnActionEnable();
		FP holdTime = Config_MainControl.holdButtonTime_AutoBattle_Skill;
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 512502, out var perkLevel))
		{
			holdTime = 0;
		}
		((PlayerAdventureActor)_actor).SetActionCondition(ActionKey.B, canCast: true, holdTime);
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512513, out perkLevel))
		{
			_playerSkillCd.BindSkillIdToButton(ActionKey.A, 12520002);
		}
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ELEMENT_MARK_TRIGGER", OnTriggerElementMark);
	}

	protected override void OnButtonAPress()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.A), _actor, SkillPhaseFeatureFlag.Dodge, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
	}

	protected override void OnButtonBPress()
	{
		_actor.logicVariable.ToggleLogicTag("OnButtonBPress", value: true);
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.End))
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
	}

	protected override void OnButtonBCancel()
	{
		_actor.logicVariable.ToggleLogicTag("OnButtonBPress", value: false);
	}

	protected override void OnButtonDPress()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false))
		{
			_actor.logicVariable.SetLogicTagValue("NormalAttackStage", 0);
		}
	}

	public override void OnUpdate()
	{
		_actor.attackTarget = _actor.actorSearchTargetInfo.GetLockingConfrontActor(useInputDirection: true);
		if (_actor.attackTarget != null && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
		{
			ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.Normal), _actor, SkillPhaseFeatureFlag.Normal, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false);
		}
		base.OnUpdate();
	}

	protected override void OnEnterBerserk()
	{
		base.OnEnterBerserk();
		_triggerTimes_P11 = 0;
	}

	private void OnTriggerElementMark(IEvent evt)
	{
		if (!(evt is AdventureElementMarkTriggerEvent adventureElementMarkTriggerEvent) || !(adventureElementMarkTriggerEvent.triggerActor == _actor))
		{
			return;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512511, out var perkLevel) && _triggerTimes_P11 < CommonUtils.GetScriptValue(_actor, 12511002) && InBerserkState)
		{
			int timingBuffCount = CommonUtils.GetScriptValue(_actor, 12511001).AsInt();
			AddBerserkTime(timingBuffCount);
			_triggerTimes_P11++;
		}
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 512513, out perkLevel))
		{
			FP scriptValue = CommonUtils.GetScriptValue(_actor, 12513012);
			if (_lastTriggerTime_P13 <= 0 || _actor.LogicTime - _lastTriggerTime_P13 > scriptValue)
			{
				_playerSkillCd.AddEnergy(CommonUtils.GetScriptValue(_actor, 12513001));
				_lastTriggerTime_P13 = _actor.LogicTime;
			}
		}
	}

	protected override void OnActionDisable()
	{
		base.OnActionDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ELEMENT_MARK_TRIGGER", OnTriggerElementMark);
		_triggerTimes_P11 = 0;
		_lastTriggerTime_P13 = 0;
	}
}
