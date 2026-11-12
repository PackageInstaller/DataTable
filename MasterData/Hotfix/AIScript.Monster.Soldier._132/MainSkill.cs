using System;
using System.Collections;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.Soldier._132;

public class MainSkill : SkillAdvancedBase
{
	private const string actionKey = "Skill_1";

	private const string actionKey_ex = "Skill_2";

	private const string actionKey_max = "Skill_3";

	private const HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.HuiFengJuLeBu;

	private const int buffId = 250102001;

	private static readonly FP exLoopDurationSec = 0.73;

	private int PotentialLv = 1;

	private int stackedBuffNum;

	private bool _aborted;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		PotentialLv = (_actor as SoldierActor).GetPotentialLv();
		_aborted = false;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_aborted = true;
		_actor.CancelAiming();
		ClearStackBuff();
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
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	private void DoMainLogic()
	{
		ApplyPartnerStackBuff();
		Action<string> action = onCustomEvent;
		Action onRecoveryBegin = OnComboSkillRecovery;
		Action onComboFinish = OnComboSkillFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack("Skill_1", flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: false, null, null, default, null, onRecoveryBegin, onComboFinish, onInterrupt, action);
	}

	private void OnComboSkillRecovery()
	{
		if (!_aborted && PotentialLv >= 2)
		{
			Action onAnticipationEnd = OnExLoopBegin;
			Action onRecoveryBegin = ((PotentialLv >= 3) ? new Action(OnComboSkillExRecovery) : null);
			Action onComboFinish = OnComboSkillExFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("Skill_2", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, onAnticipationEnd, onRecoveryBegin, onComboFinish, onInterrupt, null, null, fadeOutAnim: true);
		}
	}

	private void OnComboSkillExFinish()
	{
		if (PotentialLv < 3)
		{
			OnFinish();
		}
	}

	private void OnComboSkillFinish()
	{
		if (PotentialLv < 2)
		{
			OnFinish();
		}
	}

	private void OnExLoopBegin()
	{
		_actor.StartLogicCoroutine(StopExLoopAfterDelay());
	}

	private IEnumerator StopExLoopAfterDelay()
	{
		yield return _actor.StartLogicCoroutine(_actor.WaitForSeconds(exLoopDurationSec));
		if (!_aborted)
		{
			comboAttack?.CancelAttack();
		}
	}

	private void OnComboSkillExRecovery()
	{
		if (!_aborted)
		{
			Action onComboFinish = OnFinish;
			Action onInterrupt = OnInterrupt;
			BeginAttack("Skill_3", flushInputedKeys: true, forceInterruptAttack: true, autoLookAtTarget: false, null, null, default, null, null, onComboFinish, onInterrupt, null, null, fadeOutAnim: true);
		}
	}

	private void ApplyPartnerStackBuff()
	{
		if (PotentialLv < 3)
		{
			return;
		}
		stackedBuffNum = 0;
		if (!(_actor.buffComponent == null) && ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController)
		{
			int supportPartnerCount = soldierLevelController.GetSupportPartnerCount(_actor, HotfixEnum.ChessPartnerType.HuiFengJuLeBu);
			if (supportPartnerCount > 0)
			{
				_actor.buffComponent.AddBuffNum(250102001, supportPartnerCount, _actor);
				stackedBuffNum = supportPartnerCount;
			}
		}
	}

	private void ClearStackBuff()
	{
		if (stackedBuffNum > 0 && !(_actor.buffComponent == null))
		{
			_actor.buffComponent.RemoveBuffByBuffId(250102001);
			stackedBuffNum = 0;
		}
	}

	private void onCustomEvent(string evt)
	{
	}
}
