using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_General : SkillSimpleBase
{
	private FP spawnDelay = 0.5;

	private bool isRed;

	private bool isAtk;

	private int phase;

	private int lv;

	private int summonCount;

	private int SoldierCountTotal;

	private int SummonSoldierID;

	private int SummonBallID;

	private int SummonGeneralID;

	private int SummonGeneralID_AnotherColor;

	private int SummonSoldierID_AnotherColor;

	private FP SoldierIntervalTime;

	private MonsterAdventureActor GeneralActor;

	private bool isAnotherGeneralReady;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		isAnotherGeneralReady = false;
		summonCount = 0;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		isAtk = GetLogicTagToggleValue(_actor, "Attack");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		SummonBallID = GetTeammateIdByIndex(5);
		SummonSoldierID = GetTeammateIdByIndex(1);
		SummonGeneralID = GetTeammateIdByIndex(4);
		List<LogicEntity> targetByTeammateIndex = GetTargetByTeammateIndex(6);
		if (targetByTeammateIndex.Count == 0)
		{
			InterruptSkill();
			return;
		}
		LogicEntity logicEntity = targetByTeammateIndex.get_Item(0);
		SummonGeneralID_AnotherColor = CommonUtils_MonsterAPI.GetTeammateIdByIndex(logicEntity as MonsterAdventureActor, 4);
		SummonSoldierID_AnotherColor = CommonUtils_MonsterAPI.GetTeammateIdByIndex(logicEntity as MonsterAdventureActor, 1);
		SoldierCountTotal = Config.SoldierAmount;
		if (phase == 2)
		{
			SoldierIntervalTime = Config.SoldierIntervalTime_hd;
		}
		else
		{
			SoldierIntervalTime = Config.SoldierIntervalTime_ez;
		}
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetLogicTagToggleValue(_actor, Config.Skill_General_Finish, value: true);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = (isAtk ? "SummonGeneral" : "SummonSoldier");
		BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SummonStart");
		summonCount = SoldierCountTotal;
		if (isAtk)
		{
			ILRuntimeAPI.SummonMonster(_actor, 0, SummonGeneralID, Config.GetCellPosByIndex(isRed ? Config.GeneralPosition_Red : Config.GeneralPosition_Green), isRed ? TSVector2.right : TSVector2.left, null, null, (MonsterAdventureActor monster) =>
			{
				SetLogicTagToggleValue(monster, "Attack", isAtk);
				SetLogicTagToggleValue(monster, "Red", isRed);
				SetLogicTagFpValue(monster, "Phase", phase);
				SetLogicTagFpValue(monster, "Level", lv);
				SetLogicTagFpValue(monster, "SoldierCount", SoldierCountTotal);
				SetLogicTagFpValue(monster, "Type", 1);
			});
		}
		else
		{
			yield return WaitUntil(() => isAnotherGeneralReady);
			TSVector2 dir = (isRed ? TSVector2.right : TSVector2.left);
			for (int i = 0; i < SoldierCountTotal; i++)
			{
				TSVector2 curIndexByPos = Config.GetCurIndexByPos(GetCurrentPlayer().tsTransform.Position);
				TSVector2 cellPosByIndex = Config.GetCellPosByIndex(curIndexByPos.x.AsInt(), curIndexByPos.y.AsInt());
				GeneralActor = GetTargetByDataID(SummonGeneralID_AnotherColor).get_Item(0) as MonsterAdventureActor;
				cellPosByIndex = CheckPosValid(cellPosByIndex, GeneralActor);
				MonsterAdventureActor tempMonster = null;
				ILRuntimeAPI.SummonMonster(_actor, 0, SummonSoldierID, cellPosByIndex, dir, null, null, (MonsterAdventureActor monster) =>
				{
					SetLogicTagToggleValue(monster, "Attack", isAtk);
					SetLogicTagToggleValue(monster, "Red", isRed);
					SetLogicTagFpValue(monster, "Phase", phase);
					SetLogicTagFpValue(monster, "Level", lv);
					SetLogicTagFpValue(monster, "InitialScaleLevel", 2);
					FP modelScale = monster.actorScaleInfo.modelScale;
					monster.actorScaleInfo.modelScale = modelScale + Config.spawnScale;
					tempMonster = monster;
				});
				yield return WaitUntil(() => tempMonster != null && tempMonster.state == ActorState.Action);
				DispathGeneral(tempMonster, SoldierCountTotal);
				if (i < SoldierCountTotal - 1)
				{
					yield return WaitTime(SoldierIntervalTime);
				}
			}
		}
		yield return WaitUntil(() => summonCount <= 0);
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && (adventureActorDiedEvent.actor.dataID == SummonSoldierID || adventureActorDiedEvent.actor.dataID == SummonSoldierID_AnotherColor))
		{
			summonCount--;
		}
	}

	private void DispathGeneral(LogicEntity targetEntity, int count)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.eventHashCode = Config.soldierSpawnEvt;
		adventureActorCustomEvent.target = targetEntity;
		adventureActorCustomEvent.intParam = count;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureActorCustomEvent);
	}

	private void OnActorStateSwitch(IEvent evt)
	{
		if (evt is AdventureActorStateSwitchEvent adventureActorStateSwitchEvent && adventureActorStateSwitchEvent.dataId == SummonGeneralID_AnotherColor && adventureActorStateSwitchEvent._acState == ActorState.Action)
		{
			isAnotherGeneralReady = true;
		}
	}

	private TSVector2 CheckPosValid(TSVector2 pos, MonsterAdventureActor targetGeneral)
	{
		TSVector2 curIndexByPos = Config.GetCurIndexByPos(pos);
		TSVector2 curIndexByPos2 = Config.GetCurIndexByPos(GetLogicTagTSVector2Value(targetGeneral, "NextTargetPosition"));
		if (curIndexByPos != curIndexByPos2)
		{
			return pos;
		}
		int num = curIndexByPos.x.AsInt();
		int num2 = curIndexByPos.y.AsInt();
		if (!GetLogicTagToggleValue(targetGeneral, "SingleAttack"))
		{
			List<(int, int)> list = new List<(int, int)>();
			int num3 = 3;
			int num4 = 3;
			int num5 = num - 1;
			int num6 = num2 - 1;
			for (int i = num5; i < num5 + num3; i++)
			{
				for (int j = num6; j < num6 + num4; j++)
				{
					if (i != num && j != num2 && (!(i == Config.redBossPos.x) || !(j == Config.redBossPos.y)) && (!(i == Config.greenBossPos.x) || !(j == Config.greenBossPos.y)) && !Config.IsOutOfRange(i, j))
					{
						int num7 = (j - num2) / (i - num);
						if (num7 == -1 || num7 == 1)
						{
							list.Add((i, j));
						}
					}
				}
			}
			int index = TSRandom.Range(0, list.Count);
			return Config.GetCellPosByIndex(list.get_Item(index).Item1, list.get_Item(index).Item2);
		}
		List<(int, int)> list2 = new List<(int, int)>();
		int num8 = 3;
		int num9 = 3;
		int num10 = num - 1;
		int num11 = num2 - 1;
		for (int k = num10; k < num10 + num8; k++)
		{
			for (int l = num11; l < num11 + num9; l++)
			{
				if ((k != num || l != num2) && (!(k == Config.redBossPos.x) || !(l == Config.redBossPos.y)) && (!(k == Config.greenBossPos.x) || !(l == Config.greenBossPos.y)) && !Config.IsOutOfRange(k, l) && (k == num || l == num2))
				{
					list2.Add((k, l));
				}
			}
		}
		int index2 = TSRandom.Range(0, list2.Count);
		return Config.GetCellPosByIndex(list2.get_Item(index2).Item1, list2.get_Item(index2).Item2);
	}
}
