using AIScript.Utils;
using AdventureBehaviour;

namespace AIScript.Character._13201;

public class ActionScript_Support : ActionScript
{
	private const int perkId_29 = 513229;

	private const int perkId_31 = 513231;

	private const int buffId_P31 = 13231011;

	private readonly int buffTag_P31 = CommonHelper.StringToHash("132_Perk31");

	protected override void OnCastSkill()
	{
		if (ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.B), _actor, SkillPhaseFeatureFlag.Skill1, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnSkillFinish))
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513229, out var perkLevel))
			{
				_actor.logicVariable.ToggleLogicTag("CanTrigger_P29", value: true);
				_actor.logicVariable.SetLogicTagValue("TriggerTimes_P29", 0);
			}
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513231, out perkLevel))
			{
				_actor.buffComponent?.AddBuff(13231011, _actor);
			}
		}
	}

	private void OnSkillFinish(bool success)
	{
		if (success)
		{
			((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		}
	}

	protected override void OnCastUltimate()
	{
		ILRuntimeAPI.CreateSkill(_playerSkillCd.GetCurrentBindSkillId(ActionKey.D), _actor, SkillPhaseFeatureFlag.Ultimate, SkillLauncherType.Character, isInterruptAttack: true, isBreakable: false, SkillCountdownTiming.Start, OnUltraSkillFinish);
	}

	private void OnUltraSkillFinish(bool success)
	{
		if (success)
		{
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, 513231, out var _))
			{
				_actor.buffComponent?.RemoveBuffByTag(buffTag_P31);
			}
			((PlayerAdventureActor)_actor).isAssistAIFinish = true;
		}
	}

	public void OnUpdate()
	{
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor);
	}
}
