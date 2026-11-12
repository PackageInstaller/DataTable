using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31801FeiLong;

public class SkillScript_Base : SkillSimpleBase
{
	private DeterministicShape _checkShape_HaveBaoLin = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Circle,
		innerRadius = 0,
		radius = 2
	};

	private DeterministicShape _checkShape_NotHaveBaoLin = new DeterministicShape
	{
		shapeType = DeterministicShape.ShapeType.Circle,
		innerRadius = 0,
		radius = 1.5
	};

	protected IEnumerator GenerateBaoLinLogic(DeterministicShape shape, int totalCount, FP interval)
	{
		bool inBurstState = _actor.buffComponent.CheckBuffByBuffID(318010010);
		for (int i = 0; i < totalCount; i++)
		{
			TSVector2 spawnPosition = default;
			if (inBurstState)
			{
				spawnPosition = GetShapeRandomPoint(shape, _actor, isReachable: true);
			}
			else
			{
				for (int j = 0; j < 3; j++)
				{
					TSVector2 shapeRandomPoint = GetShapeRandomPoint(shape, _actor, isReachable: true);
					spawnPosition = shapeRandomPoint;
					if (CheckPositionSuitable(shapeRandomPoint))
					{
						break;
					}
				}
			}
			SummonTeammate(1, spawnPosition, default);
			if (interval > 0)
			{
				yield return WaitTime(interval);
			}
		}
	}

	private bool CheckPositionSuitable(TSVector2 position)
	{
		bool flag = false;
		_checkShape_HaveBaoLin.position = position;
		_checkShape_NotHaveBaoLin.position = position;
		List<LogicEntity> targetsFromShape = GetTargetsFromShape(_checkShape_HaveBaoLin);
		if (targetsFromShape != null && targetsFromShape.Count > 0)
		{
			foreach (LogicEntity item in targetsFromShape)
			{
				if (item is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.CheckTag(Config.tag_BaoLin))
				{
					flag = true;
					break;
				}
			}
		}
		if (flag)
		{
			targetsFromShape = GetTargetsFromShape(_checkShape_NotHaveBaoLin);
			foreach (LogicEntity item2 in targetsFromShape)
			{
				if (item2 is MonsterAdventureActor monsterAdventureActor2 && monsterAdventureActor2.CheckTag(Config.tag_BaoLin))
				{
					flag = false;
					break;
				}
			}
		}
		return flag;
	}

	protected void DetonateBaoLin(DeterministicShape shape)
	{
		foreach (LogicEntity item in GetTargetsFromShape(shape))
		{
			if (item is MonsterAdventureActor monsterAdventureActor && monsterAdventureActor.CheckTag(Config.tag_BaoLin) && !monsterAdventureActor.IsDead())
			{
				AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
				adventureActorCustomEvent.sender = monsterAdventureActor;
				adventureActorCustomEvent.actor = monsterAdventureActor;
				adventureActorCustomEvent.eventHashCode = Config.eventHashCode_BaoLin_Explosion;
				monsterAdventureActor.DispatchEvent(adventureActorCustomEvent);
			}
		}
	}
}
