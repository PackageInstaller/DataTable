using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._FengCao_2rd._16510FengCao;

public class Skill_WindBall_2rd : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.Q };

	private DeterministicShape Attackshape01;

	private TSVector2 RandomPOS01 = new TSVector2(0, 0);

	private List<TSVector2> AttackPOS01 = new List<TSVector2>();

	private DeterministicShape Attackshape02;

	private TSVector2 RandomPOS02 = new TSVector2(0, 0);

	private List<TSVector2> AttackPOS02 = new List<TSVector2>();

	protected readonly string fxA = "fx_16510FengCao_base_WindsSphere_01";

	private readonly string AreaEffectAlias01 = "Weapon_16510FengCao_Zhadan_Atk_01";

	protected PlayFX fxLoopA;

	private LogicEntity AttackTarget;

	private FP FlashTimes01;

	protected override void OnSkillEnable()
	{
		AttackTarget = GetAttackTarget(isUpToDate: true);
		if (!CheckTargetIsValid(AttackTarget))
		{
			AttackTarget = _actor;
		}
		AttackPOS01.Clear();
		AttackPOS02.Clear();
	}

	protected override void OnSkillDisable()
	{
		AttackPOS01.Clear();
		AttackPOS02.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(startKeyIndex1, startKey);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		BeginLookAt_NotWait(AttackTarget, 3, 120);
		yield return WaitTime(0.5);
		StartCor(AreaAttack1());
		StartCor(AreaAttack2());
		yield return WaitTime(2.2);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected IEnumerator AreaAttack1()
	{
		Attackshape01 = GetShapeData(DeterministicShape.ShapeType.Circle, RandomPOS01, default, default, 11, 0);
		TSVector2 tSVector = GetShapeRandomPoint(Attackshape01, _actor, isReachable: true);
		PlayAreaEffect(AreaEffectAlias01, tSVector);
		FlashTimes01 = 0;
		while (FlashTimes01 < 20)
		{
			FP flashTimes = FlashTimes01;
			TSVector2 RandomPos01 = GetShapeRandomPoint(Attackshape01, _actor, isReachable: true);
			FlashTimes01 = flashTimes + 1;
			while (Distance(RandomPos01, tSVector) < 6)
			{
				RandomPos01 = GetShapeRandomPoint(Attackshape01, _actor, isReachable: true);
			}
			yield return WaitTime(0.25);
			tSVector = RandomPos01;
			PlayAreaEffect(AreaEffectAlias01, tSVector);
		}
	}

	protected IEnumerator AreaAttack2()
	{
		yield return WaitTime(1.5);
		PlayAreaEffect(AreaEffectAlias01, GetEntityPosition(GetAttackTarget()));
		yield return WaitTime(1.5);
		PlayAreaEffect(AreaEffectAlias01, GetEntityPosition(GetAttackTarget()));
	}
}
