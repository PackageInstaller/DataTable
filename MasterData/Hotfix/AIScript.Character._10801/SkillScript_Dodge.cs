using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._10801;

public class SkillScript_Dodge : SkillAdvancedBase
{
	protected readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.D };

	protected FP duration = 0.25f;

	protected FP distance = 0.1f;

	protected Dodge _dodge;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.logicVariable.ToggleLogicTag("DodgeState", value: true);
	}

	public void OnStart()
	{
		ComboInputBuffer.ActionKey[] keys = actionKeys;
		Action onActivationEnd = OnActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		if (_dodge == null)
		{
			_dodge = new Dodge();
		}
		_dodge.Begin(_actor, tSVector, duration, distance, null, comboWithAttack: true);
	}

	public void OnUpdate()
	{
		if (!(_actor.attackTarget == null) && (!((PlayerAdventureActor)_actor).dodgeButtonHold || _actor.forbiddenRush))
		{
			SkillPhaseConfig currentPhaseBreakConfig = _skill.GetCurrentPhaseBreakConfig();
			if (currentPhaseBreakConfig != null && (currentPhaseBreakConfig.skillPhaseFeatureFlag & SkillPhaseFeatureFlag.Normal) != 0 && _actor.DistanceWithRadius(_actor.attackTarget) <= CommonUtils.GetAttackRange(_actor))
			{
				comboAttack.InterruptAttack();
			}
		}
	}

	protected void OnActivationEnd()
	{
		if (((PlayerAdventureActor)_actor).dodgeButtonHold && !_actor.forbiddenRush)
		{
			int specialSkillId = ((PlayerAdventureActor)_actor).playerAIInfo.SpecialSkillId;
			if (specialSkillId != 0)
			{
				ILRuntimeAPI.CreateSkill(specialSkillId, _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: false);
				OnFinish();
			}
		}
	}

	protected void OnFinish()
	{
		_skill?.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.logicVariable.ToggleLogicTag("DodgeState", value: false);
		_dodge.Interrupte();
	}
}
