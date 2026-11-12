using System;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._12501;

public class SkillScript_Dodge : SkillAdvancedBase
{
	private Dodge _dodge;

	public void OnStart()
	{
		ComboInputBuffer.ActionKey[] array = Config.comboKeys_Normal;
		FP duration = Config.duration_Normal;
		FP distance = Config.distance_Normal;
		TSVector2 tSVector = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (tSVector == TSVector2.zero)
		{
			tSVector = _actor.tsTransform.Forward.normalized;
		}
		if ((_actor as PlayerAdventureActor).status == ActorStatus.Special)
		{
			if (_actor.attackTarget != null)
			{
				TSVector2 normalized = (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
				FP fP = TSVector2.Angle(normalized, tSVector);
				FP fP2 = _actor.DistanceWithRadius(_actor.attackTarget);
				if (fP < Config.angle_CanUseAttackDodge * 0.5f && fP2 > Config.minDistance_CanUseAttackDodge && fP2 < Config.maxDistance_CanUseAttackDodge)
				{
					tSVector = normalized;
					_actor.LookAt(tSVector, 0);
					array = Config.comboKeys_Berserk_Attack;
					duration = Config.duration_Berserk_Attack;
					distance = ((fP2 <= Config.maxDistance_Berserk_Attack) ? fP2 : Config.maxDistance_Berserk_Attack);
				}
				else
				{
					array = Config.comboKeys_Berserk_Slide;
					duration = Config.duration_Berserk_Slide;
					distance = Config.distance_Berserk_Slide;
				}
			}
			else
			{
				array = Config.comboKeys_Berserk_Slide;
				duration = Config.duration_Berserk_Slide;
				distance = Config.distance_Berserk_Slide;
			}
		}
		ComboInputBuffer.ActionKey[] keys = array;
		Action onActivationEnd = OnActivationEnd;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, onActivationEnd);
		if (_dodge == null)
		{
			_dodge = new Dodge();
		}
		_dodge.Begin(_actor, tSVector, duration, distance, null, comboWithAttack: true);
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
		else if (SceneSingleton<AdventurePlayerController>.Instance.HasMovementInput() && Config.transitionRushSkillId != 0)
		{
			ILRuntimeAPI.CreateSkill(Config.transitionRushSkillId, _actor, SkillPhaseFeatureFlag.Skill2, SkillLauncherType.Character, isInterruptAttack: false);
			OnFinish();
		}
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_dodge?.Interrupte();
	}
}
