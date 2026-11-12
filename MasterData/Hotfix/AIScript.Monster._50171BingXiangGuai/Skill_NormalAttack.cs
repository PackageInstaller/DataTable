#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class Skill_NormalAttack : SkillSimpleBase
{
	private readonly string combo_normal = "NormalAtk";

	private readonly string combo_near = "NormalAtkFaster";

	private readonly FP turnAngle_limit = 100;

	private readonly string event_start = "StartToTurn";

	private readonly string even_end = "StopTurn";

	private readonly int loopCount_Normal = 1;

	private readonly int loopCount_Near = 1;

	private int index;

	private int loopCount;

	protected override void OnSkillEnable()
	{
		NovaLogger.Debug("Skill_NormalAttack==OnSkillEnable");
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("Skill_NormalAttack==OnSkillDisable");
	}

	protected override IEnumerator DoMainLogic()
	{
		index = 0;
		FP logicTagFpValue = GetLogicTagFpValue(_actor, "state");
		string actionKey = ((logicTagFpValue == 1) ? combo_normal : combo_near);
		loopCount = ((logicTagFpValue == 1) ? loopCount_Normal : loopCount_Near);
		BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(event_start);
		CoroutineNode lookCor = null;
		if (Parallel_1.toRot)
		{
			Parallel_1.toRot = false;
			Skill_NormalAttack skill_NormalAttack = this;
			TSVector2 targetPos = Parallel_1.targetPos;
			FP rotateSpeed = turnAngle_limit;
			lookCor = skill_NormalAttack.BeginLookAtByPos(targetPos, default, rotateSpeed);
		}
		else if (turnAngle_limit > 0)
		{
			lookCor = BeginLookAtMonsterTarget(999, turnAngle_limit);
		}
		yield return WaitCustomEvent(even_end);
		if (lookCor != null)
		{
			StopCor(lookCor);
			StopLookAt();
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		index++;
		if (index >= loopCount)
		{
			CancelAttack();
		}
	}
}
