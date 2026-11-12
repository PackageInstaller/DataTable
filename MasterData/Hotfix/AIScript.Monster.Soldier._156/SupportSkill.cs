using System;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._156;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	private readonly string eventName_Summon = "Fire";

	private readonly int summonedChessId = 100002;

	private readonly TSVector2 summonOffset = new TSVector2(0, 2);

	private readonly int shieldId_Potential = 250100801;

	private readonly string areaEffectKey_Potenial = "AreaEffect_Support";

	private int _potentialLv;

	private readonly List<SoldierActor> _targetSoldierActors = new List<SoldierActor>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		if (_potentialLv < 3 || !(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		soldierLevelController.GetBattleActors(_actor, _targetSoldierActors);
		List<SoldierActor> targetSoldierActors = _targetSoldierActors;
		if (targetSoldierActors != null && targetSoldierActors.Count > 0)
		{
			for (int i = 0; i < _targetSoldierActors.Count; i++)
			{
				_targetSoldierActors.get_Item(i).actorShield?.AddShield(shieldId_Potential, _actor);
			}
		}
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (!string.Equals(eventName, eventName_Summon) || !(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		if (_potentialLv >= 3)
		{
			soldierLevelController.GetBattleActors(_actor.attackTarget as SoldierActor, _targetSoldierActors);
			List<SoldierActor> targetSoldierActors = _targetSoldierActors;
			if (targetSoldierActors != null && targetSoldierActors.Count > 0)
			{
				for (int i = 0; i < _targetSoldierActors.Count; i++)
				{
					ILRuntimeAPI.PlayAreaEffect(_actor, areaEffectKey_Potenial, _targetSoldierActors.get_Item(i).tsTransform.Position);
				}
			}
		}
		else
		{
			TSVector2 result = _actor.tsTransform.Position + _actor.tsTransform.Left * summonOffset.x + _actor.tsTransform.Forward * summonOffset.y;
			if (!_actor.QueryPositionWalkable(result))
			{
				_actor.QueryClosestPositionWalkable(result, out result);
			}
			TSVector2 normalized = ((_actor.attackTarget != null) ? (_actor.attackTarget.tsTransform.Position - _actor.tsTransform.Position) : _actor.tsTransform.Forward).normalized;
			soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, summonedChessId, result, normalized.GetAngle());
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
	}
}
