using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Attack_IceMaker : SkillSimpleBase
{
	private static readonly string combo_Attack = "Attack";

	private static readonly string combo_Attack_Strong = "Attack_Strong";

	private long BuffArea1;

	private static readonly string evt_BuffArea = "evt_BuffArea";

	private int phase;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopAreaEffect(BuffArea1);
	}

	protected override IEnumerator DoMainLogic()
	{
		string key = ((phase == 3) ? combo_Attack_Strong : combo_Attack);
		BeginAttack(1, key, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent(evt_BuffArea);
		if (key == combo_Attack_Strong)
		{
			BuffArea1 = PlayAreaEffect("Area_31303ZhiBingJi_Skill01_EX", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0)));
		}
		else
		{
			BuffArea1 = PlayAreaEffect("Area_31303ZhiBingJi_Skill01", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0)));
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return WaitTime(2);
	}
}
