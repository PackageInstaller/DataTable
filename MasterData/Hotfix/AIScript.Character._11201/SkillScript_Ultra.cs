#define LOG_DEBUG
using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._11201;

public class SkillScript_Ultra : SkillAdvancedBase
{
	private readonly string Ultra_NoTL_1Hit = "Ultra_NoTL_ErLianZhan";

	private readonly string Ultra_TL_1Hit = "Ultra_TL_ErLianZhan";

	private readonly string Ultra_NoTL_6Hit = "Ultra_NoTL_ErLianZhan_H6";

	private readonly string Ultra_TL_6Hit = "Ultra_TL_ErLianZhan_H6";

	protected PlayTimeline _playTimeline;

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("_11201 Skill_Ultra OnDisable");
		base.OnSkillDisable();
		_actor.CancelAiming();
		_actor.DisableInvincible();
		_actor.logicVariable.ToggleLogicTag("UltraAtk_Clear", value: true);
	}

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("_11201 Skill_Ultra OnEnable");
		base.OnSkillEnable();
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
		_actor.EnableInvincible();
		if (ModuleController<AdventureModuleController>.Instance.GetPersonalPerkLevel(_actor.dataID, Parallel.personalPerkId_42, out var _))
		{
			for (int i = 0; i < SceneSingleton<AdventurePlayerController>.Instance.ActorLs.Count; i++)
			{
				SceneSingleton<AdventurePlayerController>.Instance.ActorLs.get_Item(i).buffComponent.AddBuff(11254211, _actor);
			}
		}
	}

	public void aimDirec()
	{
		if ((_actor as PlayerAdventureActor).isAssist)
		{
			_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		}
		if (_actor.attackTarget != null)
		{
			_actor.Aim(_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position);
			return;
		}
		TSVector2 movementInputDirection = SceneSingleton<AdventurePlayerController>.Instance.GetMovementInputDirection();
		if (movementInputDirection != TSVector2.zero)
		{
			_actor.Aim(movementInputDirection);
		}
		else
		{
			_actor.Aim(_actor.tsTransform.Forward);
		}
	}

	public void OnStart()
	{
		_actor.logicVariable.SetLogicTagValue("normalCount", 0);
		if (_skill != null)
		{
			Parallel.num_p41 = 0;
			if (_playTimeline == null)
			{
				_playTimeline = new PlayTimeline();
			}
			_playTimeline.Play(_actor, () =>
			{
				aimDirec();
				string ultra_TL_1Hit = Ultra_TL_1Hit;
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				System.Action onComboLoop = OnComboLoop;
				BeginAttack(ultra_TL_1Hit, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
			}, () =>
			{
				aimDirec();
				string ultra_NoTL_1Hit = Ultra_NoTL_1Hit;
				System.Action onComboFinish = OnFinish;
				System.Action onInterrupt = OnInterrupt;
				System.Action onComboLoop = OnComboLoop;
				BeginAttack(ultra_NoTL_1Hit, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: false, onComboLoop);
			});
		}
	}

	protected virtual void OnActivationEnd()
	{
		_actor.DisableInvincible();
	}

	protected void OnFinish()
	{
		NovaLogger.Debug("_11201 Skill_Ultra onFinish");
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		NovaLogger.Debug("_11201 Skill_Ultra OnInterrupt");
		OnFinish();
	}

	protected void OnComboLoop()
	{
	}
}
