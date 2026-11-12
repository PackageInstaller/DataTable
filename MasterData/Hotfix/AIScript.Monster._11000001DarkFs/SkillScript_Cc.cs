#define LOG_DEBUG
using System.Collections;
using AIScript.Utils;

namespace AIScript.Monster._11000001DarkFs;

public class SkillScript_Cc : SkillSimpleBase
{
	private string atkTagNrm = "Main_ChongCi";

	private string atkTagIasset = "Support_ChongCi";

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
		NovaLogger.Debug("_11000001DarkFs_SkillScript_Cc_OnSkillDisable");
		base.OnSkillDisable();
		_actor.CancelAiming();
	}

	private string GetAtkTag()
	{
		if (_actor.logicVariable.GetLogicTagToggle("iAsset"))
		{
			return atkTagIasset;
		}
		return atkTagNrm;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, GetAtkTag(), flushInputedKeys: true);
		yield return WaitFrame(1);
		_actor.CancelAiming();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
