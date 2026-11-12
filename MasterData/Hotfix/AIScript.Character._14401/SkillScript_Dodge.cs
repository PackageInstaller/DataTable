using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._14401;

public class SkillScript_Dodge : SkillAdvancedBase
{
	private Dodge _dodge;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514411, out var _))
		{
			_actor.EnableDodgeCrossObstacle();
			_actor.buffComponent.AddBuff(14411011, _actor);
		}
	}

	public void OnStart()
	{
		CommonUtils.CheckAndSetDodgeCrossObstacleMode(_actor, Config.realDistance_Dodge, Config.crossAdditionDistance_Dodge, Config.crossKeepAwayNavmeshEdgeDistance_Dodge);
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

	private void OnActivationEnd()
	{
		CommonUtils.ClearDodgeCrossObstacleMode(_actor);
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
		CommonUtils.ClearDodgeCrossObstacleMode(_actor);
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514405, out var perkLevel))
		{
			_actor.logicVariable.ToggleLogicTag("TriggerPerk_P5", value: true);
		}
		if (CommonUtils.HavePersonalPerk(_actor.dataID, 514411, out perkLevel))
		{
			_actor.DisableDodgeCrossObstacle();
		}
		_dodge?.Interrupte();
	}
}
