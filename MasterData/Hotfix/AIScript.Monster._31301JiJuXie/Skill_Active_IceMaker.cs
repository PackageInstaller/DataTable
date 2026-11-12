using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Active_IceMaker : SkillSimpleBase
{
	private static readonly string combo_Active = "Active";

	private static readonly string combo_Active_Strong = "Active_Strong";

	private readonly FP IceMaker_ActiveDuration = 10;

	private long BuffArea1;

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
		string text = ((phase == 3) ? combo_Active_Strong : combo_Active);
		BeginAttack(1, text, flushInputedKeys: true, forceInterruptAttack: true);
		if (text == combo_Active_Strong)
		{
			BuffArea1 = PlayAreaEffect("Area_31303ZhiBingJi_Skill02_Debuff_EX", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0)));
		}
		else
		{
			BuffArea1 = PlayAreaEffect("Area_31303ZhiBingJi_Skill02_Debuff", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(0, 0)));
		}
		yield return WaitTime(IceMaker_ActiveDuration);
		StopAreaEffect(BuffArea1);
		CancelAttack();
		yield return WaitTime(0.1);
		SetHideModelEnable();
		yield return WaitTime(0.1);
		_actor.ClearSelf();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
