#define LOG_DEBUG
using System;

namespace AIScript.Character._11701;

public class SkillScript_B2T24_Skill : SkillScript_B2_Skill
{
	private const string _customEventName = "_Skill";

	private readonly string bulletAlias = "Bullet_11701_B2_Skill_Thunder_AoE";

	private const string _customEventName_for_second = "_Skill2_4";

	private readonly string bulletAlias_for_second = "Bullet_11701_B2_Skill_Thunder_AoE";

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1634882679,
		(ComboInputBuffer.ActionKey)1766023024,
		(ComboInputBuffer.ActionKey)1663990132
	};

	private bool _doubleAttack;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11701 Skill_2_24 OnDisable");
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11701 Skill_2_24 OnEnable");
		base.OnSkillEnable();
	}

	public new void OnStart()
	{
		NovaLogger.Debug("11701 Skill_2_24 OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			if (_actor.logicVariable.GetLogicTagToggle("SkillDoubleAttack"))
			{
				_doubleAttack = true;
			}
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			BeginAttack(actionKeys, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (!(eventName == "_Skill"))
		{
			if (eventName == "_Skill2_4")
			{
				if (_doubleAttack)
				{
					_actor.logicVariable.ToggleLogicTag("SkillDoubleAttack", value: false);
					Shoot(bulletAlias_for_second);
				}
			}
			else
			{
				NovaLogger.Debug("no match custom event name: " + eventName);
			}
		}
		else
		{
			_actor.logicVariable.ToggleLogicTag("beginLightning", value: true);
			Shoot(bulletAlias);
		}
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11701 Skill_2_24 onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11701 Skill_2_24 onInterrupt");
		_skill.Clear();
	}
}
