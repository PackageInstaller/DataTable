using System.Collections;
using System.Linq;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._50571FengShanJi;

public class Skill_StormBlade_Zizouqi : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] StormBlade_Combo_Normal = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.I };

	private static readonly ComboInputBuffer.ActionKey[] StormBlade_Combo_BossRush = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.N };

	private static readonly int LoopAmount = 15;

	private static readonly int BalloonAmount = 12;

	private static readonly FP MaxDistance = 12;

	private static readonly FP MinDistance = 11;

	private static readonly FP MoveSpeed = 1.5;

	private readonly int summonedChessId = 100506;

	private int LoopCount;

	private int BalloonCount;

	private FP CurrentRotation;

	private TSVector2 CenterPosition;

	private long AreaEffect_Ultra_Attack;

	private CoroutineNode PullCor;

	private CoroutineNode sumballon;

	private bool IsInterrupted;

	private FP Difficulty;

	private ComboInputBuffer.ActionKey[] StormBlade_Combo;

	protected override void OnSkillEnable()
	{
		CenterPosition = new TSVector2(0, 0);
		Difficulty = GetLogicTagFpValue(_actor, "Difficulty");
		CurrentRotation = 180 / BalloonAmount + 90;
		LoopCount = 0;
		BalloonCount = 0;
		IsInterrupted = true;
		StormBlade_Combo = StormBlade_Combo_BossRush;
	}

	protected override void OnSkillDisable()
	{
		if (IsInterrupted)
		{
			AddBuffToTarget(_actor, 505719913);
			StopAreaEffect(AreaEffect_Ultra_Attack);
			StopCor(PullCor);
			StopCor(sumballon);
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(2, "FlyUp", flushInputedKeys: true);
		yield return WaitCustomEvent("ExitBattle");
		SetUnparalleledEnable();
		SetCloseBlockEnable();
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		yield return WaitTime(0.3);
		Teleport(CenterPosition);
		yield return WaitTime(0.2);
		CancelAttack();
		yield return WaitCustomEvent("InBattle");
		SetUnparalleledDisable();
		SetCloseBlockDisable();
		yield return WaitCombo(ComboAttackType.isComboFinish);
		BeginAttack(1, StormBlade_Combo, flushInputedKeys: true);
		BeginLookAtByDir(TSVector2.down, 0, 200);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (GetLogicTagToggleValue(_actor, "IsFirstInPhase2"))
		{
			AddBuffToTarget(_actor, 505719914);
			SetLogicTagToggleValue(_actor, "IsFirstInPhase2", value: false);
		}
		else
		{
			AddBuffToTarget(_actor, 505719912);
		}
		StartCor(ref PullCor, Pull());
		if (GetLogicTagToggleValue(_actor, "IsBossRush"))
		{
			AreaEffect_Ultra_Attack = PlayAreaEffect("AreaEffect_Ultra_Attack_BossRush", GetPosition());
		}
		else
		{
			AreaEffect_Ultra_Attack = PlayAreaEffect("AreaEffect_Ultra_Attack", GetPosition());
		}
		StartCor(ref sumballon, SummonBalloon());
		while (LoopCount < LoopAmount)
		{
			yield return null;
		}
		yield return WaitCustomEvent("LoopEnd");
		CancelAttack();
		AddBuffToTarget(_actor, 505719913);
		StopAreaEffect(AreaEffect_Ultra_Attack);
		StopCor(PullCor);
		IsInterrupted = false;
		yield return WaitCombo(ComboAttackType.isComboFinish);
		yield return BeginLookAtMonsterTarget(0.5, 180);
		StopCor(sumballon);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		LoopCount++;
	}

	private IEnumerator SummonBalloon()
	{
		while (BalloonCount < BalloonAmount)
		{
			Skill_StormBlade_Zizouqi skill_StormBlade_Zizouqi = this;
			TSVector2 centerPosition = CenterPosition;
			FP maxDistance = MaxDistance;
			FP minDistance = MinDistance;
			FP angle = 360 / BalloonAmount;
			FP currentRotation = CurrentRotation;
			DeterministicShape shapeData = skill_StormBlade_Zizouqi.GetShapeData(DeterministicShape.ShapeType.Fan, centerPosition, default, default, maxDistance, minDistance, angle, currentRotation);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			if (ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController)
			{
				soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, summonedChessId, shapeRandomPoint, RotateTo(TSVector2.down, GetRandomValue(0, 180)).GetAngle(), isClearSelf: false, inheritAttr: false);
			}
			CurrentRotation += (FP)(360 / BalloonAmount);
			BalloonCount++;
			yield return WaitTime(0.4);
		}
	}

	private IEnumerator Pull()
	{
		while (true)
		{
			ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, GetPosition(), GetTargetsByFaction(isFriend: false), MoveSpeed * 0.1, MoveSpeed, 4, 20, isPull: true, withRadius: false, isCoExist: true, isChangeForward: false);
			ILRuntimeAPI.ForceMoveByDistanceToPosition(_actor, GetPosition(), GetTargetsByFaction(isFriend: true).Except(GetTargetByBuffID(505719901)).ToList(), MoveSpeed * 0.1, MoveSpeed, 4, 30, isPull: true, withRadius: false, isCoExist: true, isChangeForward: false);
			yield return WaitTime(0.1);
		}
	}
}
