#define LOG_DEBUG
using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._FengCao_1st._16510FengCao;

public class Skill_WindBall : SkillSimpleBase
{
	private static readonly int startKeyIndex1 = 1;

	private static readonly ComboInputBuffer.ActionKey[] startKey = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.G };

	private static DeterministicShape Attackshape01;

	private static TSVector2 RandomPOS01 = new TSVector2(0, 0);

	private static List<TSVector2> AttackPOS01 = new List<TSVector2>();

	private static DeterministicShape Attackshape02;

	private static TSVector2 RandomPOS02 = new TSVector2(0, 0);

	private static List<TSVector2> AttackPOS02 = new List<TSVector2>();

	protected readonly string fxA = "fx_16510FengCao_base_WindsSphere_01";

	protected PlayFX fxLoopA;

	private LogicEntity AttackTarget;

	private static readonly string Stop_Event = "Stop";

	private static readonly string AreaEffectAlias01 = "AreaAttack_Warning";

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
		Attackshape01 = GetShapeData(DeterministicShape.ShapeType.Circle, RandomPOS01, default, default, 10, 1);
		for (int i = 0; i < 10; i++)
		{
			AttackPOS01.Add(GetShapeRandomPoint(Attackshape01, _actor, isReachable: true));
		}
		for (int j = 0; j < AttackPOS01.Count; j++)
		{
			PlayAreaEffect(AreaEffectAlias01, AttackPOS01.get_Item(j));
			fxLoopA = PlayFxForNeedStop(fxA, 1f, _actor.tsTransform.PositionY, AttackPOS01.get_Item(j), _actor.tsTransform.Rotation);
			NovaLogger.Debug("=======AAAAAAAAAAAAAAAAAAAAAAA==========");
			yield return WaitTime(GetRandomValue(0.1, 0.3));
		}
	}

	protected IEnumerator AreaAttack2()
	{
		for (int i = 0; i < 4; i++)
		{
			Attackshape02 = GetShapeData(DeterministicShape.ShapeType.Circle, GetEntityPositionObsoleted(AttackTarget), default, default, 1, 0.1);
			AttackPOS02.Add(GetShapeRandomPoint(Attackshape02, _actor, isReachable: true));
			PlayAreaEffect(AreaEffectAlias01, AttackPOS02.get_Item(i));
			fxLoopA = PlayFxForNeedStop(fxA, 1f, _actor.tsTransform.PositionY, AttackPOS02.get_Item(i), _actor.tsTransform.Rotation);
			NovaLogger.Debug("=======BBBBBBBBBBBBBBBBBBBBBBBBBBBBBB==========");
			yield return WaitTime(GetRandomValue(0.5, 1));
		}
	}
}
