using System.Collections;
using TrueSync;

namespace AIScript.Monster._FanRong_Light._10012FanRongZhiShiTi;

public class FanRong_Light_Attack_06 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] Attack01 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._0
	};

	private readonly ComboInputBuffer.ActionKey[] Attack02 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._1
	};

	private TSVector2 AreaPos;

	protected override IEnumerator DoMainLogic()
	{
		if (GetBuffNum(_actor, 100129910) >= 1)
		{
			BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
			CancelAttack();
			BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Wave");
			StartCor(AttackCombo02());
			yield return WaitTime(2);
			CancelAttack();
			yield return WaitCustomEvent("T3");
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 150);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
		else
		{
			BeginAttack(1, Attack01, flushInputedKeys: true, forceInterruptAttack: true);
			CancelAttack();
			BeginAttack(2, Attack02, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("Wave");
			StartCor(AttackCombo01());
			yield return WaitTime(1);
			CancelAttack();
			yield return WaitCustomEvent("T3");
			BeginLookAt_NotWait(GetCurrentPlayer(), 0.3, 150);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	private IEnumerator AttackCombo01()
	{
		AreaPos = GetPosition() + TSVector2.Rotate(new TSVector2(0.08, 3.75f), _actor.tsTransform.Rotation);
		yield return WaitFrame(1);
		PlayAreaEffect("AreaEffect_Light_Skill06_02_1", AreaPos, GetRotation());
		PlayAreaEffect("AreaEffect_Light_Skill06_02_1", AreaPos, GetRotation() + 120);
		PlayAreaEffect("AreaEffect_Light_Skill06_02_1", AreaPos, GetRotation() - 120);
		yield return WaitFrame(30);
		PlayAreaEffect("AreaEffect_Light_Skill06_02_2", AreaPos, GetRotation());
		PlayAreaEffect("AreaEffect_Light_Skill06_02_2", AreaPos, GetRotation() + 120);
		PlayAreaEffect("AreaEffect_Light_Skill06_02_2", AreaPos, GetRotation() - 120);
	}

	private IEnumerator AttackCombo02()
	{
		AreaPos = GetPosition() + TSVector2.Rotate(new TSVector2(0.08, 3.75f), _actor.tsTransform.Rotation);
		yield return WaitFrame(1);
		PlayAreaEffect("AreaEffect_Light_Skill06_02_1", AreaPos, GetRotation());
		PlayAreaEffect("AreaEffect_Light_Skill06_02_1", AreaPos, GetRotation() + 120);
		PlayAreaEffect("AreaEffect_Light_Skill06_02_1", AreaPos, GetRotation() - 120);
		yield return WaitFrame(30);
		PlayAreaEffect("AreaEffect_Light_Skill06_02_2", AreaPos, GetRotation());
		PlayAreaEffect("AreaEffect_Light_Skill06_02_2", AreaPos, GetRotation() + 120);
		PlayAreaEffect("AreaEffect_Light_Skill06_02_2", AreaPos, GetRotation() - 120);
		yield return WaitFrame(1);
		PlayAreaEffect("AreaEffect_Light_Skill06_03_1", AreaPos, GetRotation() + 60);
		PlayAreaEffect("AreaEffect_Light_Skill06_03_1", AreaPos, GetRotation() + 180);
		PlayAreaEffect("AreaEffect_Light_Skill06_03_1", AreaPos, GetRotation() - 60);
		yield return WaitFrame(15);
		PlayAreaEffect("AreaEffect_Light_Skill06_03_2", AreaPos, GetRotation() + 60);
		PlayAreaEffect("AreaEffect_Light_Skill06_03_2", AreaPos, GetRotation() + 180);
		PlayAreaEffect("AreaEffect_Light_Skill06_03_2", AreaPos, GetRotation() - 60);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "T1")
		{
			BeginLookAt_NotWait(GetCurrentPlayer(), 1, 200, 0);
		}
		else if (eventName == "T2")
		{
			StopWaitLookAt();
		}
	}
}
