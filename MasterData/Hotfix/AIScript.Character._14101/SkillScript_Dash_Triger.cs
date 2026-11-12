using System;
using TrueSync;

namespace AIScript.Character._14101;

public class SkillScript_Dash_Triger : SkillAdvancedBase
{
	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.EnableCloseBlock();
	}

	public void OnStart()
	{
		TSVector2 tSVector = _actor.tsTransform.Forward;
		FP fP = Config_Support.minDistance_DashSkill_Tiger;
		if (_actor.monsterTarget != null)
		{
			tSVector = (_actor.monsterTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
			fP = TSMath.Clamp(_actor.DistanceWithRadius(_actor.monsterTarget), Config_Support.minDistance_DashSkill_Tiger, Config_Support.maxDistance_DashSkill_Tiger);
		}
		TSVector2 result = _actor.tsTransform.Position + fP * tSVector;
		if (!_actor.QueryPositionWalkable(result))
		{
			_actor.QueryClosestPositionWalkable(result, out result);
			tSVector = (result - _actor.tsTransform.Position).normalized;
			fP = TSVector2.Distance(result, _actor.tsTransform.Position);
		}
		_actor.LookAtDir(tSVector, 0);
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("14101_Summon_Tiger_Rush", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
		FP duration = fP / Config_Support.speed_DashSkill_Tiger;
		_actor.ToJump(result, Config_Support.speed_DashSkill_Tiger, duration, null, comboWithAttack: true, forbiddenHeight: true);
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		OnFinish();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableCloseBlock();
		if (_actor.movementState == ActorState.Jump)
		{
			_actor.StandBy();
		}
	}
}
