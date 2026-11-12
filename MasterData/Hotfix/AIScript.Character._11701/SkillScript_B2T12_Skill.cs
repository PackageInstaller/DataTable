#define LOG_DEBUG
using System;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_B2T12_Skill : SkillScript_B2_Skill
{
	private const string _customEventName = "_Skill";

	private readonly string bulletAlias_level1 = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv1";

	private readonly string bulletAlias_level2 = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv2";

	private readonly string bulletAlias_level3 = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv3";

	private readonly string bulletAlias_level4 = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv4";

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1634882679,
		(ComboInputBuffer.ActionKey)1766023024,
		(ComboInputBuffer.ActionKey)1663990132
	};

	private FP _skillLevel;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11701 Skill_2_12 OnDisable");
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11701 Skill_2_12 OnEnable");
		base.OnSkillEnable();
	}

	public new void OnStart()
	{
		NovaLogger.Debug("11701 Skill_2_12 OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			_skillLevel = _actor.logicVariable.GetLogicTagValue("skillUseCount");
			ComboInputBuffer.ActionKey[] actionKeys = _actionKeys;
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			BeginAttack(actionKeys, flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
	}

	private void OnCustomEvent(string eventName)
	{
		if (eventName.Equals("_Skill"))
		{
			string text = bulletAlias_level1;
			if (_skillLevel == 1)
			{
				text = bulletAlias_level2;
			}
			else if (_skillLevel == 2)
			{
				text = bulletAlias_level3;
			}
			else if (_skillLevel == 3)
			{
				text = bulletAlias_level4;
			}
			_actor.logicVariable.ToggleLogicTag("beginLightning", value: true);
			Shoot(text);
			if (_skillLevel < 3)
			{
				_actor.logicVariable.SetLogicTagValue("skillUseCount", _skillLevel + 1);
			}
			else
			{
				_actor.logicVariable.SetLogicTagValue("skillUseCount", 0);
			}
		}
		else
		{
			NovaLogger.Debug("no match custom event name: " + eventName);
		}
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11701 Skill_2_12 onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11701 Skill_2_12 onInterrupt");
		_skill.Clear();
	}
}
