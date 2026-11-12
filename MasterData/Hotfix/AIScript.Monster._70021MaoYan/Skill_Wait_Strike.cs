#define LOG_DEBUG
using System.Collections;
using TrueSync;

namespace AIScript.Monster._70021MaoYan;

public class Skill_Wait_Strike : SkillSimpleBase
{
	private readonly FP Time = 0.5;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		RemoveBuffFromTarget(_actor, 700210000);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "Switch", flushInputedKeys: true, forceInterruptAttack: true);
		long fx_1 = PlayEffect("fx_70021_buff_Switch_Strike", 1f, default, default, default, 1f, actorScale: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		NovaLogger.Debug("等待" + Time.ToString() + "秒");
		yield return WaitTime(Time);
		NovaLogger.Debug("突袭切换结束");
		StopEffect(fx_1, stopSubFx: true);
	}
}
