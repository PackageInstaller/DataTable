using System.Collections;
using TrueSync;

namespace AIScript.Monster._50521TiaoWuJi;

public class Skill_Move_LD : SkillSimpleBase
{
	private readonly string ActionCombo01 = "Solo_Start_D";

	private readonly int ActionIndex01 = 1;

	private readonly string ActionCombo02 = "Solo_End_D";

	private readonly int ActionIndex02 = 2;

	private readonly TSVector2[,] TeleportPoint = new TSVector2[2, 2]
	{
		{
			new TSVector2(-2.5, 2.5),
			new TSVector2(2.5, 2.5)
		},
		{
			new TSVector2(-2.5, -2.5),
			new TSVector2(2.5, -2.5)
		}
	};

	private readonly int DebuffTag = CommonHelper.StringToHash("DeBuff");

	private TSVector2 TargetPOS;

	private LogicEntity Target;

	protected override IEnumerator DoMainLogic()
	{
		switch (GetRandomValue(0, 4, isInt: true).AsInt())
		{
		case 0:
			TargetPOS = TeleportPoint[0, 0];
			break;
		case 1:
			TargetPOS = TeleportPoint[0, 1];
			break;
		case 2:
			TargetPOS = TeleportPoint[1, 0];
			break;
		case 3:
			TargetPOS = TeleportPoint[1, 1];
			break;
		default:
			TargetPOS = TeleportPoint[1, 1];
			break;
		}
		BeginAttack(ActionIndex01, ActionCombo01, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.55);
		BeginAttack(ActionIndex02, ActionCombo02, flushInputedKeys: true, forceInterruptAttack: true);
		PlayEffect("fx_m50521_base_skill3_start_LD", 1f, -0.3, GetPosition());
		yield return WaitTime(0.3);
		RemoveBuffFromTarget(_actor, 0, 0, DebuffTag);
		SetHideModelEnable();
		SetBattleOutEnable();
		SetCloseBlockEnable();
		yield return WaitTime(0.6);
		Teleport(TargetPOS);
		Target = GetAttackTarget(isUpToDate: true);
		if (CheckTargetIsValid(Target))
		{
			BeginLookAt_NotWait(Target, 0, 360);
		}
		yield return WaitTime(0.1);
		PlayEffect("fx_m50521_base_skill3_start_LD", 1f, -0.3, GetPosition());
		yield return WaitTime(0.4);
		SetHideModelDisable();
		SetBattleOutDisable();
		SetCloseBlockDisable();
		yield return WaitTime(0.55);
	}
}
