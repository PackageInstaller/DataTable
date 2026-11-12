using AIScript.Utils;
using TrueSync;

namespace AIScript.Character._13901;

public class SkillScript_Rush : SkillAdvancedBase
{
	private Skill_Rush _skillRush;

	private bool _havePerk_P13;

	private FP _durationTime_P13;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (_skillRush == null)
		{
			_skillRush = new Skill_Rush();
		}
		_skillRush.OnEnable(_actor, _skill, Config.comboKeys_Rush, Config.comboKeys_Rush_Independent, Config.interruptTime_Rush, useSpecialRushEnd: false, Config.comboKeys_SpecialRushEnd);
		_havePerk_P13 = CommonUtils.HavePersonalPerk(_actor.dataID, 513913, out var _);
		_durationTime_P13 = 0;
	}

	public void OnUpdate()
	{
		_skillRush?.OnUpdate();
		if (!_havePerk_P13)
		{
			return;
		}
		if (CheckPerkCanTrigger_P13())
		{
			_durationTime_P13 += _actor.LogicDeltaTime;
			if (_durationTime_P13 > CommonUtils.GetScriptValue(_actor, 13913011))
			{
				_actor.buffComponent.AddBuff(13913012, _actor);
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = _actor;
				adventureActorCustomEvent.actor = _actor;
				adventureActorCustomEvent.eventHashCode = Config_MainControl.eventHashCode_AddSoul;
				adventureActorCustomEvent.intParam = 3;
				_actor.DispatchEvent(adventureActorCustomEvent);
				_durationTime_P13 = 0;
			}
		}
		else
		{
			_durationTime_P13 = 0;
		}
	}

	private bool CheckPerkCanTrigger_P13()
	{
		if (_actor.buffComponent.CheckBuffByBuffID(13913012))
		{
			return false;
		}
		if (_actor.buffComponent.HaveBuffNumMax(0, 0, Config_MainControl.buffTag_Soul))
		{
			return false;
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513903, out var _) && _actor.buffComponent.CheckBuffByBuffTag(Config.buffTag_FirstStage_UltraSkill))
		{
			return false;
		}
		return true;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_skillRush?.OnDisable();
		_havePerk_P13 = false;
		_durationTime_P13 = 0;
	}
}
