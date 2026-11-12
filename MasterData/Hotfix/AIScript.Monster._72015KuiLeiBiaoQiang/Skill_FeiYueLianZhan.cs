using System.Collections;
using System.Collections.Generic;
using AIScript.Monster._73001KuiLeiShi;
using TrueSync;

namespace AIScript.Monster._72015KuiLeiBiaoQiang;

public class Skill_FeiYueLianZhan : SkillSimpleBase
{
	private const string combo_Summon = "Summon";

	private const string event_Summon = "Summon";

	private const string combo_Sweep = "Skill2";

	private FP summonRadius = 3;

	private FP sweepRadius = 4f;

	private FP sweepAngle = 180f;

	private int loopCount = 1;

	private bool _syncDispatched;

	private int loopIndex;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ClearUndispatchedPhantoms();
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		ClearUndispatchedPhantoms();
	}

	private void ClearUndispatchedPhantoms()
	{
		if (!_syncDispatched)
		{
			ClearActors(GetTargetByDataID(1900704));
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (target == null)
		{
			yield break;
		}
		if (GetLogicTagFpValue(_actor, "NeedChase") == 1)
		{
			MoveToPosition(GetEntityPosition(target), 6, AdventureActor.MovementMode.Run, 5);
			yield return WaitMoveStatus();
			StopMove();
		}
		_syncDispatched = false;
		BeginAttack(1, "Summon", flushInputedKeys: true);
		yield return WaitCustomEvent("Summon");
		SetLogicTagFpValue(_actor, Common_73001.PuppetSeqCounter_Tag, 0);
		SummonPhantoms(target);
		int timeoutFrames = 0;
		yield return WaitUntil(() =>
		{
			List<LogicEntity> targetByDataID = GetTargetByDataID(1900704);
			if (targetByDataID == null || targetByDataID.Count == 0)
			{
				return ++timeoutFrames > 300;
			}
			return targetByDataID.TrueForAll((LogicEntity x) =>
			{
				AdventureActor adventureActor = x as AdventureActor;
				return adventureActor == null || adventureActor.state == ActorState.Action;
			}) || ++timeoutFrames > 300;
		});
		DispatchPuppetSyncAttack();
		MoveToPosition(GetEntityPosition(target), 2.5, AdventureActor.MovementMode.Run, 3);
		yield return WaitMoveStatus();
		StopMove();
		loopIndex = 0;
		BeginLookAt_NotWait(target, 999, GetRotSpdInSkill());
		BeginAttack(2, "Skill2", flushInputedKeys: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnComboLoop(int comboIndex)
	{
		if (comboIndex == 2)
		{
			loopIndex++;
			if (loopIndex >= loopCount)
			{
				StopLookAt();
				CancelAttack();
			}
		}
	}

	private void SummonPhantoms(LogicEntity target)
	{
		TSVector2 position = GetPosition();
		TSVector2 entityPosition = GetEntityPosition(target);
		TSVector2 normalized = (position - entityPosition).normalized;
		FP fP = FP.Atan2(normalized.y, normalized.x);
		FP fP2 = 35;
		FP fP3 = summonRadius;
		int num = ((GetBuffNum(_actor, 720140110) <= 0) ? 1 : 2);
		for (int i = 0; i < num; i++)
		{
			FP fP4;
			if (num != 1)
			{
				fP4 = ((i == 0) ? (-fP2) : fP2);
			}
			else
			{
				fP4 = ((TSRandom.Range(0, 2) == 0) ? (-fP2) : fP2);
			}
			FP value = fP + fP4 * FP.Deg2Rad;
			TSVector2 tSVector = new TSVector2(TSMath.Cos(value), TSMath.Sin(value));
			TSVector2 tSVector2 = position + tSVector * fP3;
			TSVector2 spawnDirection = entityPosition - tSVector2;
			SummonMonster(1900704, 0, tSVector2, spawnDirection);
		}
	}

	private void DispatchPuppetSyncAttack()
	{
		DispatchCustomEvent(Common_73001.evt_PuppetSyncAttack);
		_syncDispatched = true;
	}
}
