using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._HardLevel._50101YinYing;

public class HardLevel_Spawn_Skill : SkillSimpleBase
{
	private static readonly int Monster0 = 5000903;

	private static readonly int Monster1 = 5000900;

	private static readonly int Monster2 = 5001300;

	private static readonly int Monster3 = 5001600;

	private static readonly int Monster4 = 5001613;

	private DeterministicShape Shape01;

	private TSVector2 SpawnPos;

	private LogicEntity WaterWitch;

	private LogicEntity DarkWitch;

	protected override IEnumerator DoMainLogic()
	{
		if (GetTargetByTeammateIndex(1).Count != 0 && GetTargetByTeammateIndex(2).Count != 0)
		{
			GetTargetByTeammateIndexes(new List<int> { 1, 2 });
			WaterWitch = GetTargetByTeammateIndex(2).get_Item(0);
			DarkWitch = GetTargetByTeammateIndex(1).get_Item(0);
			if (GetRandomValue(0, 1, isInt: true) == 1)
			{
				HardLevel_Spawn_Skill hardLevel_Spawn_Skill = this;
				HardLevel_Spawn_Skill hardLevel_Spawn_Skill2 = this;
				TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(WaterWitch);
				FP radius = 3;
				FP innerRadius = 2;
				hardLevel_Spawn_Skill.Shape01 = hardLevel_Spawn_Skill2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius);
				SpawnPos = GetShapeRandomPoint(Shape01, WaterWitch, isReachable: true);
				if (GetTargetsByFaction(isFriend: true).Count < 6)
				{
					SpawnMon();
					SpawnMon();
				}
			}
			else
			{
				HardLevel_Spawn_Skill hardLevel_Spawn_Skill3 = this;
				HardLevel_Spawn_Skill hardLevel_Spawn_Skill4 = this;
				TSVector2 entityPositionObsoleted2 = GetEntityPositionObsoleted(DarkWitch);
				FP innerRadius = 3;
				FP radius = 2;
				hardLevel_Spawn_Skill3.Shape01 = hardLevel_Spawn_Skill4.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted2, default, default, innerRadius, radius);
				SpawnPos = GetShapeRandomPoint(Shape01, DarkWitch, isReachable: true);
				if (GetTargetsByFaction(isFriend: true).Count < 6)
				{
					SpawnMon();
					SpawnMon();
				}
			}
		}
		else if (GetTargetByTeammateIndex(2).Count != 0)
		{
			WaterWitch = GetTargetByTeammateIndex(2).get_Item(0);
			HardLevel_Spawn_Skill hardLevel_Spawn_Skill5 = this;
			HardLevel_Spawn_Skill hardLevel_Spawn_Skill6 = this;
			TSVector2 entityPositionObsoleted3 = GetEntityPositionObsoleted(DarkWitch);
			FP radius = 3;
			FP innerRadius = 2;
			hardLevel_Spawn_Skill5.Shape01 = hardLevel_Spawn_Skill6.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted3, default, default, radius, innerRadius);
			SpawnPos = GetShapeRandomPoint(Shape01, WaterWitch, isReachable: true);
			if (GetTargetsByFaction(isFriend: true).Count < 6)
			{
				SpawnMon();
			}
		}
		else
		{
			DarkWitch = GetTargetByTeammateIndex(1).get_Item(0);
			HardLevel_Spawn_Skill hardLevel_Spawn_Skill7 = this;
			HardLevel_Spawn_Skill hardLevel_Spawn_Skill8 = this;
			TSVector2 entityPositionObsoleted4 = GetEntityPositionObsoleted(DarkWitch);
			FP innerRadius = 3;
			FP radius = 2;
			hardLevel_Spawn_Skill7.Shape01 = hardLevel_Spawn_Skill8.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted4, default, default, innerRadius, radius);
			SpawnPos = GetShapeRandomPoint(Shape01, DarkWitch, isReachable: true);
			if (GetTargetsByFaction(isFriend: true).Count < 6)
			{
				SpawnMon();
			}
		}
		yield return null;
	}

	protected void SpawnMon()
	{
		FP randomValue = GetRandomValue(0, 4, isInt: true);
		if (randomValue == 0)
		{
			SummonMonster(Monster0, Monster0, GetForward(), SpawnPos);
		}
		else if (randomValue == 1)
		{
			SummonMonster(Monster1, Monster1, GetForward(), SpawnPos);
		}
		else if (randomValue == 2)
		{
			SummonMonster(Monster2, Monster2, GetForward(), SpawnPos);
		}
		else if (randomValue == 3)
		{
			SummonMonster(Monster3, Monster3, GetForward(), SpawnPos);
		}
		else
		{
			SummonMonster(Monster4, Monster4, GetForward(), SpawnPos);
		}
	}
}
