#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._50171BingXiangGuai;

public class Skill_Wait : SkillSimpleBase
{
	private readonly string combo_key_Short = "SpecialIdleShort";

	private readonly string combo_key_Long = "SpecialIdleLong";

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		NovaLogger.Debug("冰箱怪.Wait.窗口.结束");
	}

	protected override IEnumerator DoMainLogic()
	{
		FP logicTagFpValue = GetLogicTagFpValue(_actor, "state");
		FP fP = Parallel_1.waitTimes[(int)(long)logicTagFpValue];
		if (!(fP <= 0))
		{
			NovaLogger.Debug("冰箱怪.Wait.窗口.开始");
			string actionKey = combo_key_Short;
			if (fP > Parallel_1.waitTime_Normal)
			{
				actionKey = combo_key_Long;
			}
			BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}
}
