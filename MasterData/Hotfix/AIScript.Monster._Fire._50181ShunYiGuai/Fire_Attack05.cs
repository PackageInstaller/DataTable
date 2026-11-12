using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._Fire._50181ShunYiGuai;

public class Fire_Attack05 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Attack05 = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.E };

	private static readonly ComboInputBuffer.ActionKey[] Teleport01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._1
	};

	private static readonly ComboInputBuffer.ActionKey[] Teleport02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.T,
		ComboInputBuffer.ActionKey._2
	};

	protected override void OnInterrupt(int comboIndex)
	{
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(2);
		ClearActors(targetByTeammateIndex);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), new TSVector2(0, 0)) > 0.1)
		{
			BeginAttack(1, Teleport01, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Disappear");
			SetHideModelEnable();
			SetUnparalleledEnable();
			Teleport(new TSVector2(0, 0));
			BeginLookAtCameraDir_NotWait(DirectionType.Down, 0.1, 360);
			yield return WaitTime(0.15);
			BeginAttack(1, Teleport02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Appear");
			SetUnparalleledDisable();
			SetHideModelDisable();
		}
		BeginAttack(3, Attack05, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity attackTarget = GetAttackTarget();
		yield return BeginLookAt(attackTarget, 0.1, 3600);
		yield return WaitCustomEvent("Summon");
		if (GetBuffNum(_actor, 501810003) >= 1)
		{
			SummonTeammatesInCircle1();
		}
		else
		{
			SummonTeammatesInCircle2();
		}
		yield return WaitFrame(30);
		BeginRotateAngle_NotWait(-720, 50);
		yield return WaitFrame(340);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void SummonTeammatesInCircle1()
	{
		TSVector2 tSVector = new TSVector2(0, 10);
		TSVector2 tSVector2 = RotateTo(tSVector, 72);
		TSVector2 tSVector3 = RotateTo(tSVector2, 72);
		TSVector2 tSVector4 = RotateTo(tSVector3, 72);
		TSVector2 tSVector5 = RotateTo(tSVector4, 72);
		SummonTeammate(2, tSVector, new TSVector2(0, 0) - tSVector);
		SummonTeammate(2, tSVector2, new TSVector2(0, 0) - tSVector2);
		SummonTeammate(2, tSVector3, new TSVector2(0, 0) - tSVector3);
		SummonTeammate(2, tSVector4, new TSVector2(0, 0) - tSVector4);
		SummonTeammate(2, tSVector5, new TSVector2(0, 0) - tSVector5);
	}

	private void SummonTeammatesInCircle2()
	{
		TSVector2 tSVector = new TSVector2(0, 8);
		TSVector2 tSVector2 = RotateTo(tSVector, 120);
		TSVector2 tSVector3 = RotateTo(tSVector2, 120);
		SummonTeammate(2, tSVector, new TSVector2(0, 0) - tSVector);
		SummonTeammate(2, tSVector2, new TSVector2(0, 0) - tSVector2);
		SummonTeammate(2, tSVector3, new TSVector2(0, 0) - tSVector3);
	}
}
