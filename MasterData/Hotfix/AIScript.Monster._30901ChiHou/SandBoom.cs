using System.Collections;

namespace AIScript.Monster._30901ChiHou;

public class SandBoom : SkillSimpleBase
{
	private readonly string SandBoom1 = "SandBoom";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		AddBuffToTarget(_actor, 990020140);
		SetBlockPriorityToStatic();
		SetSuperArmorEnable();
		SetImmuneControlEnable();
		SetSearchedImmunityEnable();
		InterruptAttack();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		RemoveBuffFromTarget(_actor, 990020140);
		SendDeclareDeadEvent();
		_actor.ClearMonsterSelf();
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return null;
		InterruptAttack();
		yield return null;
		BeginAttack(1, SandBoom1, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEarlyWarningEffect("fx_warning_circular_2", 1.2f, 0, GetPosition());
		yield return WaitCustomEvent("Disappear");
		SetHideModelEnable();
		SetCloseBlockEnable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(0.5);
	}
}
