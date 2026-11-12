using System;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster.Soldier._110;

public class SupportSkill : SkillAdvancedBase
{
	private readonly string comboTag = "ComboSupport";

	private readonly string eventName_Summon = "Fire";

	private readonly FP ringInnerRadius = 2;

	private readonly FP ringOuterRadius = 4;

	private readonly int summonCount = 2;

	private readonly int extraSummonCount_Potential2 = 1;

	public static readonly int summonedChessId = 100005;

	public void OnStart()
	{
		if (_actor.attackTarget == null)
		{
			_actor.attackTarget = ((SoldierActor)_actor).soldierAI?.FindNearestConfrontTarget();
		}
		string actionTag = comboTag;
		Action<string> onCustomEvent = OnCustomEvent;
		Action onComboFinish = OnFinish;
		Action onInterrupt = OnInterrupt;
		BeginAttack(actionTag, flushInputedKeys: true, forceInterruptAttack: false, autoLookAtTarget: true, null, null, default, null, null, onComboFinish, onInterrupt, onCustomEvent);
	}

	private void OnCustomEvent(string eventName)
	{
		if (string.Equals(eventName, eventName_Summon))
		{
			DoSummonLogic();
		}
	}

	private void DoSummonLogic()
	{
		LogicEntity attackTarget = _actor.attackTarget;
		TSVector2 center = ((attackTarget != null) ? attackTarget.tsTransform.Position : _actor.tsTransform.Position);
		int num = summonCount;
		if (((SoldierActor)_actor).GetPotentialLv() >= 2)
		{
			num += extraSummonCount_Potential2;
		}
		for (int i = 0; i < num; i++)
		{
			TSVector2 position = PickSummonPosition(center, i, num);
			SpawnSummon(attackTarget, position);
		}
	}

	private TSVector2 PickSummonPosition(TSVector2 center, int index, int totalCount)
	{
		DeterministicShape deterministicCircleShape = CommonUtils.GetDeterministicCircleShape(ringOuterRadius, ringInnerRadius, center);
		TSVector2 randomPointInShape = ILRuntimeAPI.GetRandomPointInShape(_actor, deterministicCircleShape);
		if (randomPointInShape != center || totalCount <= 1)
		{
			return randomPointInShape;
		}
		FP degrees = (FP)index * (FP)360 / totalCount;
		FP fP = (ringInnerRadius + ringOuterRadius) / 2;
		TSVector2 result = center + TSVector2.Rotate(TSVector2.up, degrees) * fP;
		if (!_actor.QueryPositionWalkable(result) && !_actor.QueryClosestPositionWalkable(result, out result))
		{
			return randomPointInShape;
		}
		return result;
	}

	private void SpawnSummon(LogicEntity target, TSVector2 position)
	{
		if (ModuleController<AdventureModuleController>.Instance.levelInstance is SoldierLevelController soldierLevelController)
		{
			if (!_actor.QueryPositionWalkable(position))
			{
				_actor.QueryClosestPositionWalkable(position, out position);
			}
			TSVector2 normalized = ((target != null) ? (target.tsTransform.Position - _actor.tsTransform.Position) : _actor.tsTransform.Forward).normalized;
			soldierLevelController.SpawnSoldierSummon(_actor as SoldierActor, summonedChessId, position, normalized.GetAngle());
		}
	}

	private void OnFinish()
	{
		_skill.Clear();
	}

	private void OnInterrupt()
	{
		_skill.Clear();
	}
}
