using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_RanSe : SkillSimpleBase
{
	private FP interval = 4;

	private FP spawnDelay = 0.5f;

	private bool isRed;

	private bool isAtk;

	private int phase;

	private int lv;

	private int spawnCount;

	private int summonCount;

	private int BallAmount;

	private int SummonBallID;

	private string Color;

	private string WeaponFXName;

	private string RanSeFXName;

	private List<TSVector2> FixedPositionInP3;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		summonCount = 0;
		spawnCount = 0;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		isAtk = GetLogicTagToggleValue(_actor, "Attack");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		ChessInitialize();
		SummonBallID = GetTeammateIdByIndex(5);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_CUSTOM_EVENT", OnCustomEvent);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		SetLogicTagToggleValue(_actor, Config.Skill_RanSe_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SummonBall", flushInputedKeys: true, forceInterruptAttack: true);
		long ChargeFX1 = PlayEffect(WeaponFXName);
		long ChargeFX2 = PlayEffect(RanSeFXName);
		yield return WaitCombo(ComboAttackType.isAnticipationEnd);
		if (phase <= 2)
		{
			BallAmount = ((lv <= 2) ? Config.BallCount_ez : Config.BallCount_hd);
		}
		else
		{
			BallAmount = 4;
		}
		summonCount = BallAmount;
		List<(int, int)> randomList = SelectRandomPositions(isRed);
		int curCount = 0;
		int curXCount = 0;
		if (phase <= 2)
		{
			while (curXCount < 5 && curCount < BallAmount)
			{
				int item = randomList.get_Item(curXCount).Item1;
				TSVector2 cellPosByIndex = Config.GetCellPosByIndex(randomList.get_Item(curXCount).Item1, randomList.get_Item(curXCount).Item2);
				if (item != 0 && item != 4)
				{
					ILRuntimeAPI.SummonMonster(_actor, 0, SummonBallID, cellPosByIndex, default, null, null, (MonsterAdventureActor monster) =>
					{
						SetLogicTagToggleValue(monster, "Attack", isAtk);
						SetLogicTagToggleValue(monster, "Red", isRed);
						SetLogicTagFpValue(monster, "Phase", phase);
						SetLogicTagFpValue(monster, "Level", lv);
						SetLogicTagFpValue(monster, "BlastCountDown", 2);
						SetLogicTagToggleValue(monster, "IsSneak", value: true);
						StartCor(DispathGanrao(monster));
					});
					curCount++;
					yield return WaitTime(interval);
				}
				curXCount++;
				if (curXCount >= Config.cellCount - 1)
				{
					break;
				}
			}
		}
		else
		{
			if (GetLogicTagFpValue(_actor, "UltraCastTime") % 2 == 0)
			{
				FixedPositionInP3 = Config.BallPosition_P3_1;
			}
			else
			{
				FixedPositionInP3 = Config.BallPosition_P3_2;
			}
			for (; curCount < summonCount; curCount++)
			{
				TSVector2 cellPosByIndex2 = Config.GetCellPosByIndex(FixedPositionInP3.get_Item(curCount));
				ILRuntimeAPI.SummonMonster(_actor, 0, SummonBallID, cellPosByIndex2, default, null, null, (MonsterAdventureActor monster) =>
				{
					SetLogicTagToggleValue(monster, "Attack", isAtk);
					SetLogicTagToggleValue(monster, "Red", isRed);
					SetLogicTagFpValue(monster, "Phase", phase);
					SetLogicTagFpValue(monster, "Level", lv);
					SetLogicTagFpValue(monster, "BlastCountDown", Config.UltraSkillTotalTime.get_Item(lv - 1));
				});
			}
		}
		if (phase < 3)
		{
			yield return WaitUntil(() => summonCount <= 0);
		}
		CancelAttack();
		StopEffect(ChargeFX1);
		StopEffect(ChargeFX2);
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.dataID == SummonBallID)
		{
			summonCount--;
		}
	}

	private List<(int, int)> SelectRandomPositions(bool leftToRight)
	{
		int[] array = new int[5] { 3438156, 905969664, 1666402625, 1953524082, 1935757358 };
		int num = 1000;
		for (int i = 0; i < num; i++)
		{
			List<int> list = new List<int>(array);
			FisherYatesShuffle(list);
			if (list.get_Item(0) != 2 && list.get_Item(4) != 2)
			{
				array = list.ToArray();
				break;
			}
		}
		List<(int, int)> list2 = new List<(int, int)>();
		for (int j = 0; j < 5; j++)
		{
			list2.Add((j, array[j]));
		}
		if (!leftToRight)
		{
			list2.Reverse();
		}
		return list2;
	}

	private static void FisherYatesShuffle<T>(IList<T> columns)
	{
		for (int num = columns.Count - 1; num > 0; num--)
		{
			int num2 = TSRandom.instance.Next(0, num + 1);
			int index = num;
			int index2 = num2;
			T val = columns.get_Item(num2);
			T val2 = columns.get_Item(num);
			T val3;
			columns.set_Item(index, val3 = val);
			columns.set_Item(index2, val3 = val2);
		}
	}

	private void OnCustomEvent(IEvent evt)
	{
		_ = (evt as AdventureActorCustomEvent).sender;
	}

	private void OnActorStateSwitch(IEvent evt)
	{
		if (evt is AdventureActorStateSwitchEvent adventureActorStateSwitchEvent && adventureActorStateSwitchEvent.dataId == SummonBallID && adventureActorStateSwitchEvent._acState == ActorState.Action)
		{
			spawnCount++;
		}
	}

	private IEnumerator DispathGanrao(LogicEntity targetEntity)
	{
		yield return WaitTime(spawnDelay);
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.bollSpawnEvt;
		adventureActorCustomEvent.target = targetEntity;
		adventureActorCustomEvent.intParam = BallAmount;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	private void ChessInitialize()
	{
		if (isRed)
		{
			Color = "Red";
		}
		else
		{
			Color = "Green";
		}
		WeaponFXName = "fx_m72001_loop_Skill05_" + Color + "_show_self_weapon";
		RanSeFXName = "fx_m72001_loop_Skill05_" + Color + "_show_self_ranse";
	}
}
