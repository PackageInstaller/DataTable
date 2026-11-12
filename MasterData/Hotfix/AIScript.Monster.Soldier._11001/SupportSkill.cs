using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._11001;

public class SupportSkill : SkillAdvancedBase
{
	private const string actionKey = "Support";

	private static readonly FP supportDelaySec = 0.16;

	private const int buffNormal = 250103701;

	private const int buffForestFriend = 250103702;

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.SenLinPengYou;

	private const int buffPotential_2Star = 250103703;

	private const int buffPotential_3Star = 250103704;

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
		_actor.StartLogicCoroutine(AddBuffToAlliesAfterDelay());
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Support", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string evt)
	{
	}

	private IEnumerator AddBuffToAlliesAfterDelay()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(supportDelaySec));
		if (!_aborted)
		{
			AddBuffToAllies();
		}
	}

	private void AddBuffToAllies()
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
				int buffID = (HasForestFriendTag(soldierActor) ? GetPotentialBuffId() : 250103701);
				soldierActor.buffComponent?.AddBuff(buffID, _actor);
			}
		}
	}

	private int GetPotentialBuffId()
	{
		if (_potentialLv >= 3)
		{
			return 250103704;
		}
		if (_potentialLv >= 2)
		{
			return 250103703;
		}
		if (_potentialLv >= 1)
		{
			return 250103702;
		}
		return 0;
	}

	private bool HasForestFriendTag(SoldierActor ally)
	{
		return ally.HasPartnerType(HotfixEnum.ChessPartnerType.SenLinPengYou);
	}
}
