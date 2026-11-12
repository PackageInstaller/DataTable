using System.Collections;
using TrueSync;

namespace AIScript.Monster._30281ShengDanTaLou;

public class Skill_07 : SkillSimpleBase
{
	private string Attack = "Skill07";

	private string Fly = "Skill04and05";

	private string Rest = "Skill07_Rest";

	private long WarningFX;

	private long DotArea1;

	private long DotArea2;

	private TSVector2 SpawnPos = new TSVector2(0, -15);

	private TSVector2 CenterPos = new TSVector2(0, 10);

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopAreaEffect(DotArea1);
		StopAreaEffect(DotArea2);
		StopEffect(WarningFX);
	}

	protected override IEnumerator DoMainLogic()
	{
		if (Distance(GetPosition(), SpawnPos) > 3)
		{
			BeginAttack(1, Fly, flushInputedKeys: true, forceInterruptAttack: true);
			yield return WaitCustomEvent("StartDash");
			SetCloseBlockEnable();
			DotArea1 = PlayAreaEffect("Area_30281_Skill04_Dot", GetPosition());
			BeginLookAtByDir_NotWait(SpawnPos, 0.5, 360);
			yield return WaitTime(0.5);
			Dash();
			BeginLookAtByDir_NotWait(CenterPos, 5, 30);
			yield return WaitDashFinish();
			StopWaitLookAt();
			SetCloseBlockDisable();
			StopAreaEffect(DotArea1);
			WarningFX = PlayEarlyWarningEffect("Effect_Skill04_Warning", 1f, default, GetPosition());
			BeginLookAtByDir_NotWait(CenterPos, 0.5, 360);
			yield return WaitTime(0.65);
			CancelAttack();
			yield return WaitFrame(53);
		}
		BeginAttack(2, Attack, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByDir_NotWait(CenterPos, 0.5, 360);
		yield return WaitCustomEvent("StartArea");
		DotArea2 = PlayAreaEffect("Area_30281_Skill07_Dot", GetPosition());
		yield return WaitTime(6);
		StopAreaEffect(DotArea2);
		BeginAttack(3, Rest, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("RestEnd");
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnCustomEvent(int comboIndex, string eventName)
	{
		if (eventName == "AreaAttack1")
		{
			if (GetMonsterTagValue(_actor, 1) == "Lv3")
			{
				AreaAttack3();
			}
			else if (GetMonsterTagValue(_actor, 1) == "Lv2")
			{
				AreaAttack2();
			}
			else
			{
				AreaAttack1();
			}
		}
		if (eventName == "AreaAttack2" && GetMonsterTagValue(_actor, 1) == "Lv3")
		{
			AreaAttack3();
		}
	}

	private void AreaAttack1()
	{
		PlayAreaEffect("Area_30281_Skill07", GetEntityPosition(GetCurrentPlayer()));
	}

	private void AreaAttack2()
	{
		TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
		FP radius = 5;
		FP innerRadius = 4.9;
		FP angle = 60;
		FP entityAngle = GetEntityAngle(GetCurrentPlayer());
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Fan, entityPosition, default, default, radius, innerRadius, angle, entityAngle);
		PlayAreaEffect("Area_30281_Skill07", GetShapeRandomPoint(shapeData, _actor, isReachable: true));
		PlayAreaEffect("Area_30281_Skill07", GetEntityPosition(GetCurrentPlayer()));
	}

	private void AreaAttack3()
	{
		PlayAreaEffect("Area_30281_Skill07_Hard", GetEntityPosition(GetCurrentPlayer()));
	}

	private void Dash()
	{
		BeginDash(1, SpawnPos - GetPosition(), 8, Distance(GetPosition(), SpawnPos), 999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false, 0.5);
	}
}
