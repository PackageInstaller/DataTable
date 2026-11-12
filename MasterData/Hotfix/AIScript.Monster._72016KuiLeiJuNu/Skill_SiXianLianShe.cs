using System.Collections;
using TrueSync;

namespace AIScript.Monster._72016KuiLeiJuNu;

public class Skill_SiXianLianShe : SkillSimpleBase
{
	private const string combo_Summon = "Summon";

	private const string event_Summon = "Summon";

	private const string combo_Attack = "NormalAttack";

	private FP summonInnerRadius = 3;

	private FP summonOuterRadius = 4;

	private int roundCount = 1;

	private FP roundInterval = 0.8f;

	private FP phantomShootTime = 2;

	private int loopCount = 1;

	private CoroutineNode _summonCor;

	private int loopIndex;

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopSummonCor();
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		StopSummonCor();
	}

	private void StopSummonCor()
	{
		if (_summonCor != null)
		{
			StopCor(_summonCor);
			_summonCor = null;
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
			MoveToPosition(GetEntityPosition(target), 12, AdventureActor.MovementMode.Run, 5);
			yield return WaitMoveStatus();
			StopMove();
		}
		for (int round = 0; round < roundCount; round++)
		{
			BeginAttack(1, "Summon", flushInputedKeys: true);
			yield return WaitCustomEvent("Summon");
			_summonCor = StartCor(SummonOnePhantom(target));
			yield return _summonCor;
			_summonCor = null;
			yield return WaitTime(phantomShootTime);
			loopIndex = 0;
			BeginLookAt_NotWait(target, 999, GetRotSpdInSkill());
			BeginAttack(2, "NormalAttack", flushInputedKeys: true);
			yield return WaitCombo(ComboAttackType.isComboFinish);
			if (round < roundCount - 1)
			{
				yield return WaitTime(roundInterval);
			}
		}
	}

	private IEnumerator SummonOnePhantom(LogicEntity target)
	{
		TSVector2 position = GetPosition();
		Skill_SiXianLianShe skill_SiXianLianShe = this;
		FP radius = summonOuterRadius;
		FP innerRadius = summonInnerRadius;
		DeterministicShape shapeData = skill_SiXianLianShe.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		TSVector2 spawnDirection = GetEntityPosition(target) - shapeRandomPoint;
		SummonMonster(1900709, 0, shapeRandomPoint, spawnDirection);
		yield break;
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
}
