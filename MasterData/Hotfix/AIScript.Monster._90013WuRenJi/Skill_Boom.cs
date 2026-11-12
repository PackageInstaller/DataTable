using System.Collections;
using TrueSync;

namespace AIScript.Monster._90013WuRenJi;

public class Skill_Boom : SkillSimpleBase
{
	private const string ComboKey = "Skill_Boom";

	private const string HideEvent = "Hide";

	private static readonly FP DeathHideWaitTime = 0.5f;

	private bool _success;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_success = false;
		_actor.EnableImmuneControl();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.DisableImmuneControl();
		if (_success && _actor.actorHealthInfo.isAlive)
		{
			_actor.ClearMonsterSelf();
		}
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		base.OnCustomEvent(comboIndex, eventName);
		if (eventName == "Hide")
		{
			_actor.EnableHideModel();
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity attackTarget = GetAttackTarget();
		if (attackTarget != null)
		{
			BeginLookAt_NotWait(attackTarget, 0.1, 360);
		}
		_actor.EnableCloseBlock();
		BeginAttack(0, "Skill_Boom", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		_success = true;
		yield return WaitTime(DeathHideWaitTime);
		_actor.ClearMonsterSelf();
	}
}
