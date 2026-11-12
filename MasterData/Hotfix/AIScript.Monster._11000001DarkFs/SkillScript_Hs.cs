using System.Collections;
using AIScript.Utils;

namespace AIScript.Monster._11000001DarkFs;

public class SkillScript_Hs : SkillSimpleBase
{
	private string atkTagHS1 = "SanLianZhan";

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		_actor.attackTarget = CommonUtils.GetAssistantAttackTarget(_actor, useInputDirection: false, activeActorTargetFirst: true);
		if (_actor.attackTarget != null)
		{
			_actor.AimAtTarget(_actor.attackTarget);
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	private string GetAtkTag()
	{
		return atkTagHS1;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, GetAtkTag(), flushInputedKeys: true);
		yield return WaitFrame(1);
		_actor.CancelAiming();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
