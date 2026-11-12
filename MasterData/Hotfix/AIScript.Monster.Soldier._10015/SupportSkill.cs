using System;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster.Soldier._10015;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Support";

	private readonly FP addBuffDelay = 1.2;

	private readonly int buffId_Default = 250103601;

	private readonly int buffId_Partner = 250103602;

	private readonly int buffId_Partner_Potential2 = 250103603;

	private readonly int buffId_Partner_Potential3 = 250103604;

	private FP _addBuffDelay;

	private bool _hasAddBuff;

	private readonly List<SoldierActor> _targetSoldierActors = new List<SoldierActor>();

	private int _potentialLv;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_potentialLv = ((SoldierActor)_actor).GetPotentialLv();
		_hasAddBuff = false;
		_addBuffDelay = addBuffDelay;
	}

	public void OnStart()
	{
		string actionTag = comboTag;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	public void OnUpdate()
	{
		if (!_hasAddBuff)
		{
			if (_addBuffDelay > 0)
			{
				_addBuffDelay -= _actor.LogicDeltaTime;
			}
			else
			{
				AddBuff();
			}
		}
	}

	private void AddBuff()
	{
		if (_hasAddBuff)
		{
			return;
		}
		_hasAddBuff = true;
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return;
		}
		soldierLevelController.GetBattleActors(_actor, _targetSoldierActors);
		List<SoldierActor> targetSoldierActors = _targetSoldierActors;
		if (targetSoldierActors == null || targetSoldierActors.Count <= 0)
		{
			return;
		}
		for (int i = 0; i < _targetSoldierActors.Count; i++)
		{
			int buffID = buffId_Default;
			if (_targetSoldierActors.get_Item(i).HasPartnerType(HotfixEnum.ChessPartnerType.SenLinPengYou))
			{
				buffID = buffId_Partner;
				if (_potentialLv >= 3)
				{
					buffID = buffId_Partner_Potential3;
				}
				else if (_potentialLv >= 2)
				{
					buffID = buffId_Partner_Potential2;
				}
			}
			_targetSoldierActors.get_Item(i).buffComponent?.AddBuff(buffID, _actor);
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
		_hasAddBuff = false;
		_addBuffDelay = 0;
	}
}
