using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._17021;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private static readonly FP supportDelaySec = 1.5;

	private const string fxAlias = "AreaEffect_Support";

	private const int energyAdd_base = 30;

	private const int energyAdd_high = 50;

	private int _potentialLv = 1;

	private bool _aborted;

	private readonly List<SoldierActor> _allyBuffer = new List<SoldierActor>();

	private readonly List<int> _pickIndices = new List<int>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_aborted = false;
		_potentialLv = (_actor as SoldierActor).GetPotentialLv();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aborted = true;
	}

	public void OnStart()
	{
		DoMainLogic();
	}

	protected void OnFinish()
	{
		_skill.Clear();
	}

	protected void OnInterrupt()
	{
		_aborted = true;
		_skill.Clear();
	}

	public void OnUpdate()
	{
	}

	private void DoMainLogic()
	{
		_actor.StartLogicCoroutine(ApplyAfterDelay());
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt);
	}

	private IEnumerator ApplyAfterDelay()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(supportDelaySec));
		if (!_aborted)
		{
			ApplyToRandomAllies();
		}
	}

	private void ApplyToRandomAllies()
	{
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
		if (soldierLevelController == null)
		{
			return;
		}
		soldierLevelController.GetBattleActors(_actor, _allyBuffer);
		if (_allyBuffer.Count == 0)
		{
			return;
		}
		int num = ((_potentialLv < 3) ? 1 : 2);
		int num2 = ((num < _allyBuffer.Count) ? num : _allyBuffer.Count);
		int num3 = ((_potentialLv >= 2) ? 50 : 30);
		_pickIndices.Clear();
		for (int i = 0; i < _allyBuffer.Count; i++)
		{
			_pickIndices.Add(i);
		}
		for (int j = 0; j < num2; j++)
		{
			int index = TSRandom.Range(0, _pickIndices.Count);
			SoldierActor soldierActor = _allyBuffer.get_Item(_pickIndices.get_Item(index));
			_pickIndices.RemoveAt(index);
			if (!(soldierActor == null) && !soldierActor.isDead)
			{
				ILRuntimeAPI.PlayAreaEffect(_actor, "AreaEffect_Support", soldierActor.tsTransform.Position);
				soldierActor.SetEnergy(soldierActor.energy + num3);
			}
		}
	}
}
