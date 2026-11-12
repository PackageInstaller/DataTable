#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._2nd._70031Huochui;

public class Skill_SiWangJianZhen_01 : SkillSimpleBase
{
	private readonly ComboInputBuffer.ActionKey[] _actionKey1 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.J,
		ComboInputBuffer.ActionKey._1
	};

	private readonly ComboInputBuffer.ActionKey[] _actionKey2 = new ComboInputBuffer.ActionKey[2]
	{
		ComboInputBuffer.ActionKey.G,
		ComboInputBuffer.ActionKey._1
	};

	private LogicEntity AttackTarget;

	private DeterministicShape TargetCircle;

	private TSVector2 TargetPos;

	private static readonly string StopAttack_Event = "StopAttack";

	private readonly TSVector2 centerPosition = new TSVector2(0, 0);

	private TSVector2 Direction;

	private static readonly string AreaEffectAlias = "2nd_Skill_02_SiWangJianZhen_AreaEffect";

	private static readonly string WariningEffect = "FX/Warning/fx_common_base_Fire_YuJing_circular_3";

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		yield return StartCor(Move());
		BeginAttack(2, _actionKey1, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAt_NotWait(AttackTarget, 8, 360);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		StartCor(AreaDamage1());
		StartCor(AreaDamage2());
		yield return WaitTime(3);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator Move()
	{
		BeginAttack(1, _actionKey2, flushInputedKeys: true);
		if (Distance(GetPosition(), centerPosition) >= 4)
		{
			BeginLookAtByPos_NotWait(new TSVector2(0, 0), 1, 9999, 0);
			SetCloseBlockEnable();
			TSVector2 forward = GetForward();
			int num = TSRandom.Range(0, 100);
			int num2 = 50;
			if (num < num2)
			{
				Direction = RotateTo(forward, GetRandomValue(-50, -90, isInt: true));
			}
			else
			{
				Direction = RotateTo(forward, GetRandomValue(50, 90, isInt: true));
			}
			FP fP = 5;
			FP speed = fP / 0.2;
			Dash Dash = BeginDash(1, Direction, speed, fP, 9999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
			for (int i = 0; i < 5; i++)
			{
				Dash._direction = Direction;
				yield return WaitTime(0.01);
			}
			StopDash();
			FP fP2 = Distance(GetPosition(), centerPosition);
			TSVector2 forward2 = GetForward();
			TSVector2 direction = RotateTo(forward2, 0);
			FP speed2 = fP2 / 0.3;
			BeginDash(1, direction, speed2, fP2, 9999, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false, triggerFriendStop: false);
			StopLookAt();
			NovaLogger.Debug("+++++++++++++++++++++++++++++++++++++++++++++++++++++");
			SetCloseBlockDisable();
			BeginLookAt_NotWait(AttackTarget, 0.1, 9999);
			yield return WaitTime(0.1);
			yield return WaitCombo(ComboAttackType.isComboFinish);
		}
	}

	protected IEnumerator AreaDamage1()
	{
		for (int a = 0; a < 2; a++)
		{
			int num = 8;
			if (GetLogicTagToggleValue(_actor, "SkillTag_LightBlade"))
			{
				num = 12;
			}
			int num2 = 360 / num;
			int num3 = 99;
			FP fP = 7;
			FP fP2 = 1;
			FP fP3 = num2;
			TSVector2 normalized = GetForward().normalized;
			List<TSVector2> list = new List<TSVector2>();
			for (int i = 0; i < num; i++)
			{
				TSVector2 tSVector = RotateTo(normalized, fP3 * i);
				int num4;
				for (num4 = TSRandom.Range(-4, 6); num4 == num3; num4 = TSRandom.Range(-4, 6))
				{
				}
				list.Add((fP + fP2 * TSRandom.Range(-4, 6)) * tSVector + centerPosition);
				num3 = num4;
			}
			foreach (TSVector2 item in list)
			{
				PlayAreaEffect(AreaEffectAlias, item, GetRandomValue(0, 360, isInt: true));
				yield return WaitTime(GetRandomValue(0.1, 0.2));
			}
		}
	}

	protected IEnumerator AreaDamage2()
	{
		int areacount = 4;
		if (GetLogicTagToggleValue(_actor, "SkillTag_LightBlade"))
		{
			areacount = 6;
		}
		for (int i = 0; i < areacount; i++)
		{
			Skill_SiWangJianZhen_01 skill_SiWangJianZhen_ = this;
			Skill_SiWangJianZhen_01 skill_SiWangJianZhen_2 = this;
			TSVector2 entityPosition = GetEntityPosition(AttackTarget);
			FP randomValue = GetRandomValue(0.5, 2);
			FP innerRadius = 0;
			skill_SiWangJianZhen_.TargetCircle = skill_SiWangJianZhen_2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPosition, default, default, randomValue, innerRadius);
			TargetPos = GetShapeRandomPoint(TargetCircle, _actor, isReachable: true);
			PlayAreaEffect(AreaEffectAlias, TargetPos);
			yield return WaitTime(GetRandomValue(0.5, 0.7));
		}
	}

	protected override void OnSkillDisable()
	{
		SetCloseBlockDisable();
	}
}
