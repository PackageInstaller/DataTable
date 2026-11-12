using System.Collections;
using System.Runtime.CompilerServices;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_Crush : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Crush_Combo_Left;

	private static readonly ComboInputBuffer.ActionKey[] Crush_Combo_Right;

	private static readonly FP DashSpeed;

	private static readonly FP DashDistance;

	private static readonly FP BrakeDashSpeed;

	private static readonly FP BrakeDashDistance;

	private ComboInputBuffer.ActionKey[] Crush_Combo;

	private TSVector2 CrushDirection;

	protected override void OnSkillEnable()
	{
		if (CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) >= 0)
		{
			Crush_Combo = Crush_Combo_Left;
			CrushDirection = RotateTo(GetForward(), 90);
		}
		else
		{
			Crush_Combo = Crush_Combo_Right;
			CrushDirection = RotateTo(GetForward(), -90);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Crush_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		BeginDash(3, -CrushDirection, 1, 0.5, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		Skill_Crush skill_Crush = this;
		TSVector2 position = GetPosition();
		FP tSVectToAngle = GetTSVectToAngle(CrushDirection, 0);
		skill_Crush.PlayEarlyWarningEffect("CrushWarning", 1f, default, position, tSVectToAngle, 0.75f);
		yield return WaitTime(0.7);
		PlayEffect("CommonFlashWarning", 1f, 1, GetPosition());
		yield return WaitCustomEvent("Dash");
		BeginDash(1, CrushDirection, DashSpeed, DashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitDashFinish();
		BeginDash(2, CrushDirection, BrakeDashSpeed, BrakeDashDistance, 0, comboWithAttack: true, isAngle: false, notChangeForward: true, triggerObstacleStop: false, triggerEnemyStop: false, triggerFriendStop: false);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	static Skill_Crush()
	{
		//IL_0022: Field data (rva=0x698) could not be found in any section!
		//IL_0022: Field data (rva=0x698) could not be found in any section!
		//IL_000c: Field data (rva=0x4a0) could not be found in any section!
		//IL_000c: Field data (rva=0x4a0) could not be found in any section!
		ComboInputBuffer.ActionKey[] array = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._02433989DC22CF3B439520872116A54CD7D45A171AC418FB24BC2594D82FD250));
		Crush_Combo_Left = array;
		ComboInputBuffer.ActionKey[] array2 = new ComboInputBuffer.ActionKey[3];
		RuntimeHelpers.InitializeArray(array2, __ldtoken(_003CPrivateImplementationDetails_003E._2AFC299AE2C44DBAD6B479482D2D7467D7DEFD66041659ED28CA5E8D83236E82));
		Crush_Combo_Right = array2;
		DashSpeed = 20;
		DashDistance = 5;
		BrakeDashSpeed = 3.7;
		BrakeDashDistance = 3;
	}
}
