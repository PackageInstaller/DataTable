using System.Collections;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_Smash : SkillSimpleBase
{
	private static readonly string combo_Smash_LeftRotate = "Smash_LeftRotate";

	private static readonly string combo_Smash_RightRotate = "Smash_RightRotate";

	private static readonly string evt_BuffArea1 = "evt_BuffArea1";

	private static readonly string evt_BuffArea2 = "evt_BuffArea2";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private long BuffArea1;

	private long BuffArea2;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopAreaEffect(BuffArea1);
		StopAreaEffect(BuffArea2);
		SetLogicTagToggleValue(_actor, Config.Skill_Smash_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		FP fP = CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true);
		bool playerOnRight = fP > 0 && fP <= 180;
		string actionKey = (playerOnRight ? combo_Turn_Left : combo_Turn_Right);
		BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		if (logicEntity != null)
		{
			TSVector2 position = GetPosition();
			TSVector2 tSVector = GetEntityPosition(logicEntity) - position;
			FP x = (playerOnRight ? (-(FP)80) : ((FP)80)) * FP.Deg2Rad;
			FP fP2 = FP.Cos(x);
			FP fP3 = FP.Sin(x);
			TSVector2 tSVector2 = new TSVector2(tSVector.x * fP2 - tSVector.y * fP3, tSVector.x * fP3 + tSVector.y * fP2);
			BeginLookAtByPos_NotWait(position + tSVector2, 0.3, 600);
		}
		yield return WaitTime(0.3);
		if (playerOnRight)
		{
			BeginAttack(2, combo_Smash_LeftRotate, flushInputedKeys: true, forceInterruptAttack: true);
			BuffArea1 = PlayAreaEffect("Area_31301JiJuXie_Buff_circular_4_1_Damge", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-5.65, 1.53)));
			yield return WaitCustomEvent(evt_BuffArea2);
			BuffArea2 = PlayAreaEffect("Area_31301JiJuXie_Buff_circular_4_2_Damge", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(-3.18, 1.44)));
		}
		else
		{
			BeginAttack(2, combo_Smash_RightRotate, flushInputedKeys: true, forceInterruptAttack: true);
			BuffArea1 = PlayAreaEffect("Area_31301JiJuXie_Buff_circular_4_1_Damge", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(5.65, 1.53)));
			yield return WaitCustomEvent(evt_BuffArea2);
			BuffArea2 = PlayAreaEffect("Area_31301JiJuXie_Buff_circular_4_2_Damge", TransLocalPosToWorldPos(GetPosition(), GetForward(), new TSVector2(3.18, 1.44)));
		}
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}
}
