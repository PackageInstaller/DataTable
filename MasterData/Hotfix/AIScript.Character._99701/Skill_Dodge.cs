#define LOG_DEBUG
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._99701;

public class Skill_Dodge : SkillAdvancedBase
{
	protected ComboAttack _comboAttack;

	protected Dodge _dodge;

	protected FP _dodgeDuration = 0.2;

	protected FP _dodgeDistance = 5;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_99701 Skill_Dodge OnDisable");
		base.OnSkillDisable();
		_comboAttack?.Clear();
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_99701 Skill_Dodge OnEnable");
		base.OnSkillEnable();
	}

	public void OnStart()
	{
		NovaLogger.Debug("_99701 Skill_Dodge OnStart");
		if (_skill != null)
		{
			SetSkillPhaseConfig(SkillPhaseFeatureFlag.Ultimate, null, SkillPhaseFeatureFlag.Ultimate, null);
			if (_dodge == null)
			{
				_dodge = new Dodge();
			}
			TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
			if (tSVector == TSVector2.zero)
			{
				tSVector = _actor.tsTransform.Forward.normalized;
			}
			_dodge.Begin(_actor, tSVector, _dodgeDuration, _dodgeDistance, OnFinish, comboWithAttack: true);
		}
	}

	protected void OnAnticipationEnd()
	{
	}

	protected void OnRecoveryBegin()
	{
		NovaLogger.Debug("_99701 OnRecoveryBegin");
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_99701Skill1 onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_99701Skill1 onInterrupt");
		OnFinish();
	}
}
