#define LOG_DEBUG
using System;
using TrueSync;

namespace AIScript.Character._11701;

public class SkillScript_B2T14_Skill : SkillScript_B2_Skill
{
	protected const string _customEventName = "_Skill";

	private readonly string bulletAlias_level1 = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv1";

	private readonly string bulletAlias_level2 = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv2";

	private readonly string bulletAlias_level3 = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv3";

	private readonly string bulletAlias_level4 = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv4";

	private const string _customEventName_for_second = "_Skill2_4";

	private readonly string bulletAlias_level1_2nd = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv1";

	private readonly string bulletAlias_level2_2nd = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv2";

	private readonly string bulletAlias_level3_2nd = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv3";

	private readonly string bulletAlias_level4_2nd = "Bullet_11701_B2T1_Skill_Thunder_AoE_Lv4";

	private readonly ComboInputBuffer.ActionKey[] _actionKeys = new ComboInputBuffer.ActionKey[3]
	{
		(ComboInputBuffer.ActionKey)1634882679,
		(ComboInputBuffer.ActionKey)1766023024,
		(ComboInputBuffer.ActionKey)1663990132
	};

	private FP _skillLevel;

	private bool _doubleAttack;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11701 Skill_2_14 OnDisable");
		base.OnSkillDisable();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11701 Skill_2_14 OnEnable");
		base.OnSkillEnable();
	}

	public new void OnStart()
	{
		NovaLogger.Debug("11701 Skill_2_14 OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			_doubleAttack = false;
			if (_actor.logicVariable.GetLogicTagToggle("SkillDoubleAttack"))
			{
				_doubleAttack = true;
			}
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
		_skillLevel = _actor.logicVariable.GetLogicTagValue("skillUseCount");
		_ = (AdventureActor)_actor.aimLockedTarget;
		string text = bulletAlias_level1;
		string text2 = bulletAlias_level1_2nd;
		if (_skillLevel == 1)
		{
			text = bulletAlias_level2;
			text2 = bulletAlias_level2_2nd;
		}
		else if (_skillLevel == 2)
		{
			text = bulletAlias_level3;
			text2 = bulletAlias_level3_2nd;
		}
		else if (_skillLevel == 3)
		{
			text = bulletAlias_level4;
			text2 = bulletAlias_level4_2nd;
		}
		if (!(eventName == "_Skill"))
		{
			if (eventName == "_Skill2_4")
			{
				if (_doubleAttack)
				{
					_actor.logicVariable.ToggleLogicTag("SkillDoubleAttack", value: false);
					Shoot(text2);
					AddSkillLevel();
				}
			}
			else
			{
				NovaLogger.Debug("no match custom event name: " + eventName);
			}
		}
		else
		{
			Shoot(text);
			AddSkillLevel();
		}
	}

	private void AddSkillLevel()
	{
		if (_skillLevel < 3)
		{
			_actor.logicVariable.SetLogicTagValue("skillUseCount", _skillLevel + 1);
			_skillLevel += (FP)1;
		}
		else
		{
			_actor.logicVariable.SetLogicTagValue("skillUseCount", 0);
			_skillLevel = 0;
		}
	}

	private void OnFinish()
	{
		NovaLogger.Debug("11701 Skill_2_14 onFinish");
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		NovaLogger.Debug("11701 Skill_2_14 onInterrupt");
		_skill.Clear();
	}
}
