using System;
using System.Collections.Generic;
using AIScript.Utils;

namespace AIScript.Monster.Soldier._110;

public class SummonSkill1 : SkillAdvancedBase
{
	private readonly ComboInputBuffer.ActionKey[] actionKeys = new ComboInputBuffer.ActionKey[4];

	private readonly string comboTag_Broadcast = "ComboSummonSkill2";

	private readonly List<LogicEntity> _searchEntities = new List<LogicEntity>();

	public void OnStart()
	{
		_actor.attackTarget = FindNearestEnemy();
		if (_actor.logicVariable != null && _actor.logicVariable.GetLogicTagToggle("110_UseCombo2"))
		{
			string actionTag = comboTag_Broadcast;
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt);
			_actor.logicVariable.ToggleLogicTag("110_UseCombo2", value: false);
		}
		else
		{
			ComboInputBuffer.ActionKey[] keys = actionKeys;
			Action onInterrupt = OnFinish;
			Action onComboFinish = OnInterrupt;
			BeginAttack(keys, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onInterrupt, onComboFinish);
		}
	}

	private LogicEntity FindNearestEnemy()
	{
		_searchEntities.Clear();
		CommonUtils.SearchNearTargetsByCircle(_actor, _actor.actorSearchTargetInfo.monsterSearchRange, isConfront: true, includeSelf: false, _searchEntities);
		for (int i = 0; i < _searchEntities.Count; i++)
		{
			if (_searchEntities.get_Item(i) is AdventureActor { actorHealthInfo: { isAlive: not false } } adventureActor && !adventureActor.IsSearchedImmunity() && !(adventureActor is SoldierActor { isSupport: not false }))
			{
				return _searchEntities.get_Item(i);
			}
		}
		return _actor.attackTarget;
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
		_searchEntities.Clear();
	}
}
