using System;
using TrueSync;

namespace AIScript.Monster.Soldier._141;

public class MainSkill : SkillAdvancedBase
{
	private readonly string comboTag = "Skill";

	private readonly FP loopDuration = 3;

	private readonly HotfixEnum.ChessPartnerType partnerType = HotfixEnum.ChessPartnerType.QiLiMoFa;

	private readonly FP[] loopDurationPct_Partner = new FP[3] { 0.8, 0.6, 0.4 };

	private bool _beginLoop;

	private FP _loopDuration;

	private int _comboIndex;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_beginLoop = false;
		_loopDuration = 0;
		_comboIndex = 0;
	}

	public void OnStart()
	{
		BeginCombo(0);
	}

	private void BeginCombo(int comboIndex)
	{
		_comboIndex = comboIndex;
		_beginLoop = false;
		_loopDuration = 0;
		string actionTag = comboTag;
		Action onAnticipationEnd = OnAnticipationEnd;
		Action onComboFinish = OnComboFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, onAnticipationEnd, null, onComboFinish, onInterrupt);
	}

	private void OnAnticipationEnd()
	{
		_loopDuration = loopDuration;
		if (_comboIndex > 0)
		{
			FP loopDurationPct = GetLoopDurationPct(GetPartnerLv());
			if (loopDurationPct > 0)
			{
				_loopDuration = loopDuration * loopDurationPct;
			}
		}
		_beginLoop = true;
	}

	public void OnUpdate()
	{
		if (_beginLoop)
		{
			if (_loopDuration > 0)
			{
				_loopDuration -= _actor.LogicDeltaTime;
				return;
			}
			_beginLoop = false;
			comboAttack.CancelAttack();
		}
	}

	private void OnComboFinish()
	{
		if (_comboIndex == 0 && GetPartnerLv() >= 1)
		{
			BeginCombo(1);
		}
		else
		{
			OnFinish();
		}
	}

	private int GetPartnerLv()
	{
		if (!(ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController))
		{
			return 0;
		}
		return soldierLevelController.GetPartnerLv(partnerType);
	}

	private FP GetLoopDurationPct(int partnerLv)
	{
		if (partnerLv < 1 || loopDurationPct_Partner.Length == 0)
		{
			return 0;
		}
		int num = partnerLv - 1;
		if (num >= loopDurationPct_Partner.Length)
		{
			num = loopDurationPct_Partner.Length - 1;
		}
		return loopDurationPct_Partner[num];
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
		_beginLoop = false;
		_loopDuration = 0;
		_comboIndex = 0;
	}
}
