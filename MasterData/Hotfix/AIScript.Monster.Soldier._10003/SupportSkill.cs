using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._10003;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private static readonly FP supportDelaySec = 2;

	private const int energyBase = 15;

	private const int energyForestFriend = 30;

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.SenLinPengYou;

	private const int buffForestFriend_2Star = 250103201;

	private const int buffForestFriend_3Star = 250103202;

	private int _potentialLv = 1;

	private bool _aborted;

	private readonly List<SoldierActor> _allyBuffer = new List<SoldierActor>();

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
		ApplyPotentialBuffToForestAllies();
		_actor.StartLogicCoroutine(RecoverEnergyAfterDelay());
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
	}

	private IEnumerator RecoverEnergyAfterDelay()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(supportDelaySec));
		if (!_aborted)
		{
			RecoverEnergyToAllies();
		}
	}

	private void RecoverEnergyToAllies()
	{
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
		if (soldierLevelController == null)
		{
			return;
		}
		soldierLevelController.GetBattleActors(_actor, _allyBuffer);
		for (int i = 0; i < _allyBuffer.Count; i++)
		{
			SoldierActor soldierActor = _allyBuffer.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead)
			{
				int num = (HasForestFriendTag(soldierActor) ? 30 : 15);
				soldierActor.SetEnergy(soldierActor.energy + num);
			}
		}
	}

	private void ApplyPotentialBuffToForestAllies()
	{
		int potentialBuffId = GetPotentialBuffId();
		if (potentialBuffId == 0)
		{
			return;
		}
		SoldierLevelController soldierLevelController = ModuleController<AdventureModuleController>.Instance?.levelInstance as SoldierLevelController;
		if (soldierLevelController == null)
		{
			return;
		}
		soldierLevelController.GetBattleActors(_actor, _allyBuffer);
		for (int i = 0; i < _allyBuffer.Count; i++)
		{
			SoldierActor soldierActor = _allyBuffer.get_Item(i);
			if (!(soldierActor == null) && !soldierActor.isDead && HasForestFriendTag(soldierActor))
			{
				soldierActor.buffComponent?.AddBuff(potentialBuffId, _actor);
			}
		}
	}

	private int GetPotentialBuffId()
	{
		if (_potentialLv >= 3)
		{
			return 250103202;
		}
		if (_potentialLv >= 2)
		{
			return 250103201;
		}
		return 0;
	}

	private bool HasForestFriendTag(SoldierActor ally)
	{
		return ally.HasPartnerType(HotfixEnum.ChessPartnerType.SenLinPengYou);
	}
}
