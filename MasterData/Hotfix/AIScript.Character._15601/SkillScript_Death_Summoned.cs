using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Character._15601;

public class SkillScript_Death_Summoned : SkillAdvancedBase
{
	private AdventureActor _summoner;

	private Dash _dash;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.PlayDeathAnim();
		_summoner = ((MonsterAdventureActor)_actor).monsterSummonInfo.SummonActor;
	}

	public void OnStart()
	{
		if (CommonUtils.HavePersonalPerk(_summoner.dataID, 515605, out var _))
		{
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("Dead", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
			TSVector2 direction = _actor.tsTransform.Forward;
			FP fP = Config_MainControl.maxDistance_Rush_P5;
			LogicEntity attackTarget = _summoner.attackTarget;
			if (attackTarget != null)
			{
				direction = (attackTarget.tsTransform.Position - _actor.tsTransform.Position).normalized;
				fP = TSMath.Clamp(_actor.DistanceWithRadius(attackTarget), 0, fP);
			}
			if (_dash == null)
			{
				_dash = new Dash();
			}
			else
			{
				_dash.Clear();
			}
			_dash.BeginDash(_actor, direction, fP / Config_MainControl.duration_Rush_P5, fP, default, null, null, null, comboWithAttack: true, isAngle: false, notChangeForward: false, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		}
		else
		{
			Action onInterrupt = OnFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack("Dead", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onInterrupt, onComboFinish);
		}
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
		_dash?.Interrupte();
		_dash?.Clear();
		_summoner = null;
	}
}
