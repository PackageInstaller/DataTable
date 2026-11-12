namespace AIScript.Character._11201;

public class Skill : SkillAdvancedBase
{
	protected PlayerSkillCd _skillManager;

	protected int comboStep;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (_isDisableByLostControl)
		{
			_actor.logicVariable.ToggleLogicTag("DogeSkill", value: false);
		}
	}

	protected virtual void OnCustomEvent(string eventName)
	{
		if (eventName.Equals("ChenShaZaDi"))
		{
			_actor.logicVariable.ToggleLogicTag("ChenShaZaDi", value: true);
			if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, Parallel.personalPerkId_8, out var _))
			{
				_actor.logicVariable.ToggleLogicTag("p8_cdin", value: true);
			}
		}
	}

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_skillManager == null)
		{
			_skillManager = (_actor as PlayerAdventureActor).playerSkillCd;
		}
	}

	public virtual void OnStart()
	{
	}

	public virtual void OnStepBegain()
	{
		_actor.logicVariable.SetLogicTagValue("skillStage", 1);
	}

	protected virtual void OnStepOneFinish()
	{
		_actor.logicVariable.SetLogicTagValue("skillStage", 2);
	}

	protected virtual void OnStepTwoFinish()
	{
		_actor.logicVariable.SetLogicTagValue("skillStage", 0);
	}
}
