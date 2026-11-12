using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._31701MoFaZhen;

public class Summon : SkillSimpleBase
{
	private string tag1 = "Mark1";

	private string tag2 = "Mark2";

	private string tag3 = "Mark3";

	private string tag4 = "Mark4";

	private const float SPAWN_CYCLE = 3.5f;

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	protected override void OnSkillDisable()
	{
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvt);
	}

	private void OnCustomEvt(IEvent evt)
	{
		if (!(evt is AdventureActorCustomEvent { eventName: not null } adventureActorCustomEvent))
		{
			return;
		}
		if (adventureActorCustomEvent.eventName.Equals("OnCustomEvt"))
		{
			TSVector2 position = GetPosition();
			TSVector2 entityPosition = GetEntityPosition(GetCurrentPlayer());
			if (Distance(position, entityPosition) <= 14f && GetMonsterTagValue(_actor, 1) != tag1)
			{
				KillActors(new List<LogicEntity> { _actor });
			}
		}
		else if (adventureActorCustomEvent.eventName.Equals("OnCustomEvt1"))
		{
			KillActors(new List<LogicEntity> { _actor });
		}
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
					if (Distance(position, entityPosition) <= 16.5)
					{
						DoSpawn(currentPlayer, entityPosition);
					}
				}
				yield return WaitTime(3.5f);
			}
		}
		if (monsterTagValue == tag2)
		{
			bool isFirstTime = true;
			TSVector2 fixedPos1 = new TSVector2(-5.6, 39.9);
			TSVector2 fixedPos3 = new TSVector2(5.21, 39.9);
			TSVector2[][] groups = new TSVector2[3][]
			{
				new TSVector2[2]
				{
					new TSVector2(-11.58, 30.72),
					new TSVector2(-2.4, 22.89)
				},
				new TSVector2[2]
				{
					new TSVector2(3.31, 27.1),
					new TSVector2(-1.77, 41.91)
				},
				new TSVector2[2]
				{
					new TSVector2(-15.05, 35.38),
					new TSVector2(-3.66, 22.79)
				}
			};
			List<int> bag = new List<int>();
			int lastUsedGroup = -1;
			while (true)
			{
				LogicEntity currentPlayer2 = GetCurrentPlayer();
				if (currentPlayer2 != null)
				{
					TSVector2 position2 = GetPosition();
					TSVector2 playerPos = GetEntityPosition(currentPlayer2);
					if (Distance(position2, playerPos) <= 17.5)
					{
						TSVector2 p1;
						TSVector2 p2;
						if (isFirstTime)
						{
							p1 = fixedPos1;
							p2 = fixedPos3;
							isFirstTime = false;
							yield return WaitTime(0.1);
						}
						else
						{
							if (bag.Count == 0)
							{
								bag.Add(0);
								bag.Add(1);
								bag.Add(2);
								for (int num = bag.Count - 1; num > 0; num--)
								{
									int index = TSRandom.Range(0, num + 1);
									int value = bag.get_Item(num);
									bag.set_Item(num, bag.get_Item(index));
									bag.set_Item(index, value);
								}
								if (lastUsedGroup != -1 && bag.get_Item(0) == lastUsedGroup)
								{
									int index2 = TSRandom.Range(1, bag.Count);
									int value2 = bag.get_Item(0);
									bag.set_Item(0, bag.get_Item(index2));
									bag.set_Item(index2, value2);
								}
							}
							int num2 = bag.get_Item(0);
							bag.RemoveAt(0);
							lastUsedGroup = num2;
							p1 = groups[num2][0];
							p2 = groups[num2][1];
						}
						SummonTeammate(3, p1, playerPos - p1);
						yield return WaitTime(0.5);
						SummonTeammate(3, p2, playerPos - p2);
					}
				}
				yield return WaitTime(4.6);
			}
		}
		if (monsterTagValue == tag3)
		{
			TSVector2[][] groups = new TSVector2[3][]
			{
				new TSVector2[2]
				{
					new TSVector2(-37.6, 36),
					new TSVector2(-45, 36)
				},
				new TSVector2[2]
				{
					new TSVector2(-50.83, 35.57),
					new TSVector2(-40, 31)
				},
				new TSVector2[2]
				{
					new TSVector2(-52.76, 41),
					new TSVector2(-35, 32.5)
				}
			};
			List<int> bag = new List<int>();
			int lastUsedGroup = -1;
			while (true)
			{
				LogicEntity currentPlayer3 = GetCurrentPlayer();
				if (currentPlayer3 != null)
				{
					TSVector2 position3 = GetPosition();
					TSVector2 fixedPos3 = GetEntityPosition(currentPlayer3);
					if (Distance(position3, fixedPos3) <= 17.5)
					{
						if (bag.Count == 0)
						{
							bag.Add(0);
							bag.Add(1);
							bag.Add(2);
							for (int num3 = bag.Count - 1; num3 > 0; num3--)
							{
								int index3 = TSRandom.Range(0, num3 + 1);
								int value3 = bag.get_Item(num3);
								bag.set_Item(num3, bag.get_Item(index3));
								bag.set_Item(index3, value3);
							}
							if (lastUsedGroup != -1 && bag.get_Item(0) == lastUsedGroup)
							{
								int index4 = TSRandom.Range(1, bag.Count);
								int value4 = bag.get_Item(0);
								bag.set_Item(0, bag.get_Item(index4));
								bag.set_Item(index4, value4);
							}
						}
						int num4 = bag.get_Item(0);
						bag.RemoveAt(0);
						lastUsedGroup = num4;
						TSVector2 tSVector = groups[num4][0];
						TSVector2 fixedPos1 = groups[num4][1];
						SummonTeammate(3, tSVector, fixedPos3 - tSVector);
						yield return WaitTime(0.5);
						SummonTeammate(3, fixedPos1, fixedPos3 - fixedPos1);
					}
				}
				yield return WaitTime(4.6);
			}
		}
		if (monsterTagValue == tag4)
		{
			TSVector2[][] groups = new TSVector2[3][]
			{
				new TSVector2[3]
				{
					new TSVector2(-37.6, 36),
					new TSVector2(-50, 38.5),
					new TSVector2(-45, 36)
				},
				new TSVector2[3]
				{
					new TSVector2(-50.83, 35.57),
					new TSVector2(-43, 37.16),
					new TSVector2(-40, 31)
				},
				new TSVector2[3]
				{
					new TSVector2(-52.76, 41),
					new TSVector2(-48.7, 33.23),
					new TSVector2(-35, 32.5)
				}
			};
			List<int> bag = new List<int>();
			int lastUsedGroup = -1;
			while (true)
			{
				LogicEntity currentPlayer4 = GetCurrentPlayer();
				if (currentPlayer4 != null)
				{
					TSVector2 position4 = GetPosition();
					TSVector2 fixedPos3 = GetEntityPosition(currentPlayer4);
					if (Distance(position4, fixedPos3) <= 17.5)
					{
						if (bag.Count == 0)
						{
							bag.Add(0);
							bag.Add(1);
							bag.Add(2);
							for (int num5 = bag.Count - 1; num5 > 0; num5--)
							{
								int index5 = TSRandom.Range(0, num5 + 1);
								int value5 = bag.get_Item(num5);
								bag.set_Item(num5, bag.get_Item(index5));
								bag.set_Item(index5, value5);
							}
							if (lastUsedGroup != -1 && bag.get_Item(0) == lastUsedGroup)
							{
								int index6 = TSRandom.Range(1, bag.Count);
								int value6 = bag.get_Item(0);
								bag.set_Item(0, bag.get_Item(index6));
								bag.set_Item(index6, value6);
							}
						}
						int num6 = bag.get_Item(0);
						bag.RemoveAt(0);
						lastUsedGroup = num6;
						TSVector2 tSVector2 = groups[num6][0];
						TSVector2 fixedPos1 = groups[num6][1];
						TSVector2 playerPos = groups[num6][2];
						SummonTeammate(3, tSVector2, fixedPos3 - tSVector2);
						yield return WaitTime(0.5);
						SummonTeammate(3, fixedPos1, fixedPos3 - fixedPos1);
						yield return WaitTime(0.5);
						SummonTeammate(3, playerPos, fixedPos3 - playerPos);
					}
				}
				yield return WaitTime(4.6);
			}
		}
		yield return WaitTime(9999f);
	}

	private void DoSpawn(object player, TSVector2 playerPos)
	{
		FP radius = 5;
		FP innerRadius = 4;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, playerPos, default, default, radius, innerRadius);
		TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
		SummonTeammate(3, shapeRandomPoint, playerPos - shapeRandomPoint);
	}
}
