#define LOG_DEBUG
using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11801.Old;

public class Skill_Dodge : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected Dodge _dodge;

	protected FP _dodgeDuration = 0.4;

	protected FP _dodgeDistance = 3;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("11801 Skill_Dodge OnDisable");
		base.OnSkillDisable();
		_dodge?.Interrupte();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("11801 Skill_Dodge OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("11801 Skill_Dodge OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.None, null, SkillPhaseFeatureFlag.None, null);
			ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };
			if (_comboAttack == null)
			{
				_comboAttack = new ComboAttack();
			}
			ComboAttack comboAttack = _comboAttack;
			AdventureActor actor = _actor;
			AdventureSkill skill = _skill;
			int skillId = ((_skill != null) ? _skill.skillId : 0);
			System.Action onComboFinish = OnFinish;
			System.Action onInterrupt = OnInterrupt;
			comboAttack.BeginAttack(actor, skill, actionKeys, flushInputedKeys: false, skillId, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, null, onComboFinish, onInterrupt);
			if (_dodge == null)
			{
				_dodge = new Dodge();
			}
			TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (tSVector == TSVector2.zero)
			{
				tSVector = _actor.tsTransform.Forward.normalized;
			}
			_dodge.Begin(_actor, tSVector, _dodgeDuration, _dodgeDistance, null, comboWithAttack: true);
		}
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("11801 dodge onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("11801 dodge onInterrupt");
		OnFinish();
	}
}
