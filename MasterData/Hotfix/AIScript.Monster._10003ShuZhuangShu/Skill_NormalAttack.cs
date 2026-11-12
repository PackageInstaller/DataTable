#define LOG_DEBUG
using System;
using System.Runtime.CompilerServices;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._10003ShuZhuangShu;

public class Skill_NormalAttack : SkillAdvancedBase
{
	protected readonly string selfFx = "fx_10003_base_skill2_start_s";

	protected readonly string eventName1 = "Move";

	protected readonly string eventName2 = "MoveEnd";

	protected FP speed = 4;

	protected FP distance = 1.5;

	protected ComboAttack _comboAttack;

	protected Dash _dash;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_10003ShuZhuangShu Skill_NormalAttack OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
		if (_dash != null)
		{
			_dash.Clear();
			_dash = null;
		}
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_10003ShuZhuangShu Skill_NormalAttack OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		//IL_0062: Field data (rva=0x698) could not be found in any section!
		//IL_0062: Field data (rva=0x698) could not be found in any section!
		//IL_0062: Field data (rva=0x698) could not be found in any section!
		//IL_0062: Field data (rva=0x698) could not be found in any section!
		NovaLogger.Debug("_10003ShuZhuangShu Skill_NormalAttack OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			_actor.PlayFX(selfFx);
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
			RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._2AFC299AE2C44DBAD6B479482D2D7467D7DEFD66041659ED28CA5E8D83236E82));
			ComboInputBuffer.ActionKey[] actionKeys = array;
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			Action<string> onCustomEvent = OnCustomEvent;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt, onCustomEvent);
		}
	}

	protected void OnCustomEvent(string eventName)
	{
		NovaLogger.Debug("_10003ShuZhuangShu Skill_NormalAttack" + eventName);
		if (eventName.Equals(eventName1))
		{
			TSVector2 normalized = _actor.tsTransform.Forward.normalized;
			if (_dash == null)
			{
				_dash = new Dash();
			}
			_dash.BeginDash(_actor, normalized, speed, distance, 0, null, null, null, comboWithAttack: true);
		}
		else if (eventName.Equals(eventName2))
		{
			_dash?.Interrupte();
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_10003ShuZhuangShu Skill_NormalAttack onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_10003ShuZhuangShu Skill_NormalAttack onInterrupt");
		_skill.Clear();
	}
}
