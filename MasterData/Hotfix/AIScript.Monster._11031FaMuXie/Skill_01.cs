using System.Collections;
using TrueSync;

namespace AIScript.Monster._11031FaMuXie;

public class Skill_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack = new ComboInputBuffer.ActionKey[1];

	private LogicEntity Target;

	private TSVector2 TargetPos;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Shoot");
		StartCor(Spawn());
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Spawn()
	{
		Gettarget();
		TargetPos = GetEntityPosition(Target);
		PlayAreaEffect("Area_11031FaMuXie_Skill01_Warn", TargetPos);
		yield return WaitFrame(8);
		Gettarget();
		Getpos();
		PlayAreaEffect("Area_11031FaMuXie_Skill01_Warn", TargetPos);
		yield return WaitFrame(9);
		Gettarget();
		Getpos();
		PlayAreaEffect("Area_11031FaMuXie_Skill01_Warn", TargetPos);
		yield return WaitFrame(8);
		Gettarget();
		Getpos();
		PlayAreaEffect("Area_11031FaMuXie_Skill01_Warn", TargetPos);
	}

	protected void Gettarget()
	{
		Target = GetAttackTarget(isUpToDate: true);
		if (Target == null)
		{
			Target = GetCurrentPlayer();
		}
	}

	protected void Getpos()
	{
		TSVector2 entityPosition = GetEntityPosition(Target);
		FP radius = 3;
		FP innerRadius = 1.5;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, radius, innerRadius);
		if (Distance(entityPosition, TargetPos) >= 1.5)
		{
			TargetPos = GetEntityPosition(Target);
		}
		else
		{
			TargetPos = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		}
	}
}
