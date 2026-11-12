using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._70022HuaYuan;

public class Skill_T_DashArea : SkillSimpleBase
{
	private static string LineFx = "fx_70022_laser_STrow";

	private static List<long> LineFxList = new List<long>();

	private static long IndexFxDogde;

	private static readonly string Fx_Dogde = "fx_70022_loop_Dodge_Shukuchi";

	private static readonly TSVector2 ZeroPOS = new TSVector2(0, 0);

	private static readonly string WarningFx_Actor = "fx_common_base_charge_fire_actor";

	private static readonly int ActionIndex = 0;

	private static readonly string ActionKey = "Dash";

	private static readonly int JumpIndex = 1;

	private static readonly string JumpKey = "Jump";

	private static readonly int DashLoopIndex = 2;

	private static readonly string DashLoopKey = "DashLoop";

	private static int DashIndex = 10;

	private static TSVector2 Direction;

	private static FP Speed;

	private static FP DIST;

	private static FP AngleLimit = 999;

	private static TSVector2 TargetPOS = default;

	private static TSVector2 SelfPOS = default;

	private static bool Select;

	private static List<TSVector2> DashPOS = new List<TSVector2>();

	private static DeterministicShape Attackshape01;

	private static TSVector2 RandomPOS01 = new TSVector2(-5.5, -5.5);

	private static List<TSVector2> AttackPOS01 = new List<TSVector2>();

	private static DeterministicShape Attackshape02;

	private static TSVector2 RandomPOS02 = new TSVector2(5.5, 5.5);

	private static List<TSVector2> AttackPOS02 = new List<TSVector2>();

	private static readonly string AreaEffectAlias01 = "AreaAttack_Warning";

	protected override void OnSkillEnable()
	{
		Select = false;
		DashPOS.Clear();
		AttackPOS01.Clear();
		LineFxList.Clear();
		AttackPOS02.Clear();
	}

	protected override void OnSkillDisable()
	{
		DashPOS.Clear();
		LineFxList.Clear();
		AttackPOS01.Clear();
		AttackPOS02.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		int i = 0;
		int num = 1;
		for (; i < 8; i++)
		{
			if (!Select)
			{
				if (num == 0)
				{
					DashPOS.Add(new TSVector2(GetRandomValue(-7, 7), 10));
					num++;
				}
				else
				{
					DashPOS.Add(new TSVector2(GetRandomValue(-7, 7), -10));
					num = 0;
					Select = true;
				}
			}
			else if (num == 0)
			{
				DashPOS.Add(new TSVector2(10, GetRandomValue(-7, 7)));
				num++;
			}
			else
			{
				DashPOS.Add(new TSVector2(-10, GetRandomValue(-7, 7)));
				num = 0;
				Select = false;
			}
		}
		BeginAttack(ActionIndex, ActionKey, flushInputedKeys: true, forceInterruptAttack: true);
		BeginLookAtByPos_NotWait(new TSVector2(0, -5), 0.1, 9999);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		for (int j = 0; j < DashPOS.Count; j++)
		{
			if (j == 0)
			{
				LineFxList.Add(PlayLinkEffect(LineFx, useCustomSource: true, null, GetPosition(), 0.5, null, DashPOS.get_Item(0), 0.5, breakWhenLostSourceOrTarget: false, 1f, actorScale: true));
			}
			else
			{
				LineFxList.Add(PlayLinkEffect(LineFx, useCustomSource: true, null, DashPOS.get_Item(j - 1), 0.5, null, DashPOS.get_Item(j), 0.5, breakWhenLostSourceOrTarget: false, 1f, actorScale: true));
			}
		}
		yield return WaitTime(0.5);
		PlayEffect(WarningFx_Actor, 1f, 1.5, GetPosition(), default, 1.4f);
		yield return WaitTime(0.4);
		StartCor(AreaAttack());
		SetSearchedImmunityEnable();
		IndexFxDogde = PlayEffect(Fx_Dogde);
		for (int k = 0; k < DashPOS.Count; k++)
		{
			TargetPOS = DashPOS.get_Item(k);
			if (k == 0)
			{
				CancelAttack();
			}
			else
			{
				BeginAttack(DashLoopIndex, DashLoopKey, flushInputedKeys: true, forceInterruptAttack: true);
			}
			yield return StartCor(DashOnce());
		}
		StopEffect(IndexFxDogde);
		for (int l = 0; l < LineFxList.Count; l++)
		{
			StopEffect(LineFxList.get_Item(l));
		}
	}

	protected IEnumerator DashOnce()
	{
		BeginLookAtByPos_NotWait(TargetPOS, 0.05, 9999);
		SelfPOS = GetPosition();
		Direction = TargetPOS - SelfPOS;
		DIST = Distance(TargetPOS, SelfPOS);
		Speed = DIST / 0.25;
		yield return WaitTime(0.08);
		BeginDash(DashIndex, Direction, Speed, DIST, AngleLimit, comboWithAttack: true, isAngle: true, notChangeForward: true, triggerObstacleStop: true, triggerEnemyStop: false);
		yield return WaitDashFinish();
		yield return WaitTime(0.15);
	}

	protected IEnumerator BackPOS()
	{
		RemoveBuffFromTarget(_actor, 0, 0, CommonHelper.StringToHash("DeBuff"));
		BeginAttack(JumpIndex, JumpKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		Teleport(ZeroPOS);
		yield return WaitTime(0.8);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator AreaAttack()
	{
		Attackshape01 = GetShapeData(DeterministicShape.ShapeType.Circle, RandomPOS01, default, default, 7, 0);
		Attackshape02 = GetShapeData(DeterministicShape.ShapeType.Circle, RandomPOS02, default, default, 7, 0);
		for (int i = 0; i < 3; i++)
		{
			AttackPOS01.Add(GetShapeRandomPoint(Attackshape01, _actor));
			AttackPOS02.Add(GetShapeRandomPoint(Attackshape02, _actor));
		}
		for (int j = 0; j < AttackPOS01.Count; j++)
		{
			PlayAreaEffect(AreaEffectAlias01, AttackPOS01.get_Item(j));
			yield return WaitTime(GetRandomValue(0.1, 0.3));
			PlayAreaEffect(AreaEffectAlias01, AttackPOS02.get_Item(j));
			yield return WaitTime(0.5);
		}
	}
}
