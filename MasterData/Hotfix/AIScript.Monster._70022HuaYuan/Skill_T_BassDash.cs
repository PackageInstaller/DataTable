using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_BassDash : SkillSimpleBase
{
	private readonly string WarningFx_Actor = "fx_common_base_charge_fire_actor";

	private string LineFx = "fx_70022_laser_STrow";

	private List<long> LineFxList = new List<long>();

	private readonly int ActionIndex;

	private readonly string ActionKey = "Dash";

	private readonly string DashBaseFx = "fx_70022_loop_Dodge_Shukuchi";

	private long DashBaseIndex;

	private int DashIndex = 10;

	private TSVector2 Direction;

	private FP Speed;

	private FP DIST;

	private FP AngleLimit = 999;

	private LogicEntity Target;

	private TSVector2 TargetPOS;

	private TSVector2 SelfPOS;

	private readonly int FlashIndex;

	private readonly string FlashKey = "Flash";

	private readonly string Fx_Flash = "fx_70022_loop_Substitute_StandIn";

	private long FxIndex;

	private readonly FP Wait = 1;

	private readonly FP RadiusLimit = 8;

	private readonly TSVector2 ZeroPOS = new TSVector2(0, 0);

	private TSVector2 TeleportPOS;

	protected override void OnSkillEnable()
	{
	}

	protected override void OnSkillDisable()
	{
		LineFxList.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		SelfPOS = GetPosition();
		Target = GetCurrentPlayer();
		if (Distance(SelfPOS, GetEntityPosition(Target)) <= 5)
		{
			yield return StartCor(FlashMove());
		}
		BeginLookAtByPos_NotWait(GetEntityPosition(GetCurrentPlayer()), 0.1, 9999);
		BeginAttack(ActionIndex, ActionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.4);
		TargetPOS = GetEntityPosition(Target);
		SelfPOS = GetPosition();
		Direction = TargetPOS - SelfPOS;
		DIST = Distance(TargetPOS, SelfPOS) + 7;
		LineFxList.Add(PlayLinkEffect(LineFx, useCustomSource: true, null, SelfPOS, 1, null, TransLocalPosToWorldPos(TargetPOS, Direction, new TSVector2(0, DIST)), 0, breakWhenLostSourceOrTarget: false, 1f, actorScale: true));
		yield return WaitTime(0.3);
		PlayEffect(WarningFx_Actor, 1f, 1.5, GetPosition(), default, 1.4f);
		yield return WaitTime(0.4);
		StopEffect(LineFxList.get_Item(0));
		CancelAttack();
		Speed = DIST / 0.25;
		BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		DashBaseIndex = PlayEffect(DashBaseFx);
		yield return WaitDashFinish();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator FlashMove()
	{
		BeginAttack(FlashIndex, FlashKey, flushInputedKeys: true, forceInterruptAttack: true);
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		SetHideModelEnable();
		SetSearchedImmunityEnable();
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
		SetUnparalleledDisable();
		SetCloseBlockDisable();
		SetHideModelDisable();
		SetSearchedImmunityDisable();
		CancelAttack();
		BeginLookAt_NotWait(Target, 0.3, 999);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		StopEffect(FxIndex);
		StopLookAt();
	}
}
