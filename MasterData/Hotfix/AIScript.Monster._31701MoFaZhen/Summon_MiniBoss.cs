using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31701MoFaZhen;

public class Summon_MiniBoss : SkillSimpleBase
{
	private string tag1 = "Mark1";

	private string tag2 = "Mark2";

	private string tag3 = "Mark3";

	private const float RANGE = 22f;

	private const float SPAWN_CYCLE = 8f;

	private const int SUMMON_COUNT = 1;

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		if (monsterTagValue == tag1)
		{
			while (true)
			{
				LogicEntity currentPlayer = GetCurrentPlayer();
				if (currentPlayer != null)
				{
					TSVector2 position = GetPosition();
					TSVector2 entityPosition = GetEntityPosition(currentPlayer);
					if (Distance(position, entityPosition) <= 22f)
					{
						List<LogicEntity> targetByDataIDs = GetTargetByDataIDs(new List<int> { 1900604, 1900611 });
						if (targetByDataIDs == null || targetByDataIDs.Count == 0)
						{
							DoSpawn(currentPlayer, entityPosition);
						}
					}
				}
				yield return WaitTime(8f);
			}
		}
		if (!(monsterTagValue == tag2))
		{
			_ = monsterTagValue == tag3;
		}
		yield return WaitTime(9999f);
	}

	private void DoSpawn(object player, TSVector2 playerPos)
	{
		FP radius = 7;
		FP innerRadius = 6;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, playerPos, default, default, radius, innerRadius);
		for (int i = 0; i < 1; i++)
		{
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			SummonTeammate(3, shapeRandomPoint, playerPos - shapeRandomPoint);
		}
	}
}
