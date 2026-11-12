using System.Collections;
using TrueSync;

namespace AIScript.Monster._31101GeLeiHuoEn;

public class Skill03_Investigate : SkillSimpleBase
{
	private readonly string combo_key1 = "DogHunting";

	private TSVector2 SkillPos;

	private TSVector2 DogPoint;

	private TSVector2 DogPoint1;

	private TSVector2 DogPoint2;

	private TSVector2 DogPoint3;

	private TSVector2 DogPoint4;

	private TSVector2 DogPoint5;

	private FP SkillTimes01;

	private LogicEntity Targetenemy;

	protected override void OnSkillEnable()
	{
		SkillPos = GetPlaceHolderPosition("CenterPoint");
		DogPoint = GetPlaceHolderPosition("DogPoint");
		DogPoint1 = GetPlaceHolderPosition("DogPoint_1");
		DogPoint2 = GetPlaceHolderPosition("DogPoint_2");
		DogPoint3 = GetPlaceHolderPosition("DogPoint_3");
		DogPoint4 = GetPlaceHolderPosition("DogPoint_4");
		DogPoint5 = GetPlaceHolderPosition("DogPoint_5");
		SkillTimes01 = GetRandomValue(0, 1.5, isInt: true);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		GetEnemy();
		BeginLookAt_NotWait(Targetenemy, 1.2, 72000);
		yield return WaitTime(0.1);
		BeginAttack(1, combo_key1, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.5);
		if (SkillTimes01 == 0)
		{
			SummonTeammate(3, DogPoint1, TSVector2.right);
			SummonTeammate(3, DogPoint2, TSVector2.left);
			SummonTeammate(2, DogPoint, TSVector2.down);
		}
		else
		{
			SummonTeammate(3, DogPoint4, TSVector2.up);
			SummonTeammate(3, DogPoint5, TSVector2.down);
			SummonTeammate(2, DogPoint3, TSVector2.left);
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void GetEnemy()
	{
		Targetenemy = GetAttackTarget();
		if (Targetenemy == null)
		{
			Targetenemy = GetCurrentPlayer();
		}
	}
}
