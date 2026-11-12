using System.Collections;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_Flash : SkillSimpleBase
{
	private static readonly int FlashIndex = 0;

	private static readonly string FlashKey = "Flash";

	private static readonly string Fx_Flash = "fx_70022_loop_Substitute_StandIn";

	private static long FxIndex;

	private static readonly FP Wait = 0.75;

	private static TSVector2 SelfPOS;

	private static TSVector2 TargetPOS;

	private static LogicEntity Target;

	private static readonly FP RadiusLimit = 8;

	private static readonly TSVector2 ZeroPOS = new TSVector2(0, 0);

	private static TSVector2 TeleportPOS;

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(FlashIndex, FlashKey, flushInputedKeys: true, forceInterruptAttack: true);
		SetUnparalleledEnable();
		SetSearchedImmunityEnable();
		SetCloseBlockEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		FxIndex = PlayEffect(Fx_Flash, 1f, default, GetPosition(), GetTSVectToAngle(GetForward(), 0));
		yield return WaitTime(0.4);
		SelfPOS = GetPosition();
		Target = GetCurrentPlayer();
		for (int i = 0; i < 20; i++)
		{
			TeleportPOS = GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Circle, ZeroPOS, default, default, RadiusLimit, 0), _actor, isReachable: true);
			TargetPOS = GetEntityPosition(Target);
			if (Distance(TeleportPOS, TargetPOS) >= 7)
			{
				Teleport(TeleportPOS);
				break;
			}
			if (i == 19)
			{
				Teleport(TeleportPOS);
				break;
			}
		}
		yield return WaitTime(Wait - 0.4);
		SetInvincibleDisable();
		SetSearchedImmunityDisable();
		SetCloseBlockDisable();
		CancelAttack();
		BeginLookAt_NotWait(Target, 0.3, 999);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopEffect(FxIndex);
		StopLookAt();
	}
}
