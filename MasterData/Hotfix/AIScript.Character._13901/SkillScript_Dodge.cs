using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._13901;

public class SkillScript_Dodge : SkillAdvancedBase
{
	private Dodge _dodge;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 513911, out var _))
		{
			_actor.buffComponent.AddBuff(13911011, _actor);
		}
	}

	public void OnStart()
	{
		ComboInputBuffer.ActionKey[] comboKeys_Dodge = Config.comboKeys_Dodge;
		Action onActivationEnd = OnActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(comboKeys_Dodge, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		if (_dodge == null)
		{
			_dodge = new Dodge();
		}
		_dodge.Begin(_actor, tSVector, Config.duration_Dodge, Config.distance_Dodge, null, comboWithAttack: true);
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

	private void OnActivationEnd()
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

	private void OnFinish()
	{
		_skill?.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_dodge?.Interrupte();
	}
}
