using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_General_P3 : SkillSimpleBase
{
	private bool isRed;

	private bool isAtk;

	private int phase;

	private int lv;

	private int AttackCount;

	private int summonCount;

	private MonsterAdventureActor general_1;

	private MonsterAdventureActor general_2;

	private int SummonSoldierID;

	private int SummonBallID;

	private int SummonGeneralID;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		AttackCount = 0;
		summonCount = 2;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		SummonSoldierID = GetTeammateIdByIndex(1);
		SummonGeneralID = GetTeammateIdByIndex(4);
		SummonBallID = GetTeammateIdByIndex(5);
		AttackCount = Config.GeneralAttackTime_P3;
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetLogicTagToggleValue(_actor, Config.Skill_General_Finish, value: true);
		general_1 = null;
		general_2 = null;
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SummonGeneral", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SummonStart");
		SummonGeneral();
		yield return WaitTime(2.5);
		yield return StartCor(SearchPlayer());
		yield return WaitUntil(() => summonCount <= 0);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private void SummonGeneral()
	{
		ILRuntimeAPI.SummonMonster(_actor, 0, SummonGeneralID, Config.GetCellPosByIndex(isRed ? Config.GeneralPosition_Red_P3.get_Item(0) : Config.GeneralPosition_Green_P3.get_Item(0)), isRed ? TSVector2.right : TSVector2.left, null, null, (MonsterAdventureActor monster) =>
		{
			SetLogicTagToggleValue(monster, "Attack", isAtk);
			SetLogicTagToggleValue(monster, "Red", isRed);
			SetLogicTagFpValue(monster, "Phase", phase);
			SetLogicTagFpValue(monster, "Level", lv);
			SetLogicTagFpValue(monster, "Type", 1);
			general_1 = monster;
			int num = ((Config.GeneralAttackTime_P3 % 2 == 0) ? (Config.GeneralAttackTime_P3 / 2) : (Config.GeneralAttackTime_P3 / 2 + 1));
			SetLogicTagFpValue(monster, "SoldierCount", num);
		});
		ILRuntimeAPI.SummonMonster(_actor, 0, SummonGeneralID, Config.GetCellPosByIndex(isRed ? Config.GeneralPosition_Red_P3.get_Item(1) : Config.GeneralPosition_Green_P3.get_Item(1)), isRed ? TSVector2.right : TSVector2.left, null, null, (MonsterAdventureActor monster) =>
		{
			SetLogicTagToggleValue(monster, "Attack", isAtk);
			SetLogicTagToggleValue(monster, "Red", isRed);
			SetLogicTagFpValue(monster, "Phase", phase);
			SetLogicTagFpValue(monster, "Level", lv);
			SetLogicTagFpValue(monster, "Type", 1);
			general_2 = monster;
			int num = Config.GeneralAttackTime_P3 / 2;
			SetLogicTagFpValue(monster, "SoldierCount", num);
		});
	}

	private IEnumerator SearchPlayer()
	{
		for (int i = 0; i < Config.GeneralAttackTime_P3; i++)
		{
			TSVector2 curIndexByPos = Config.GetCurIndexByPos(GetCurrentPlayer().tsTransform.Position);
			TSVector2 cellPosByIndex = Config.GetCellPosByIndex(curIndexByPos.x.AsInt(), curIndexByPos.y.AsInt());
			bool flag = i % 2 == 0;
			_ = Config.GeneralAttackTime_P3 % 2;
			MonsterAdventureActor monsterAdventureActor = (flag ? general_1 : general_2);
			cellPosByIndex = CheckPosValid(cellPosByIndex, monsterAdventureActor);
			SetLogicTagTSVector2Value(monsterAdventureActor, "GeneralAttackPositionP3", cellPosByIndex);
			SetLogicTagToggleValue(monsterAdventureActor, "GeneralToAttackP3", value: true);
			yield return WaitTime(Config.GeneralAttackIntervalTime_P3);
		}
	}

	private TSVector2 CheckPosValid(TSVector2 pos, MonsterAdventureActor targetGeneral)
	{
		TSVector2 curIndexByPos = Config.GetCurIndexByPos(general_1.tsTransform.Position);
		TSVector2 curIndexByPos2 = Config.GetCurIndexByPos(general_2.tsTransform.Position);
		TSVector2 curIndexByPos3 = Config.GetCurIndexByPos(pos);
		if (curIndexByPos != curIndexByPos3 && curIndexByPos2 != curIndexByPos3)
		{
			return pos;
		}
		int num = curIndexByPos3.x.AsInt();
		int num2 = curIndexByPos3.y.AsInt();
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
					if (i != num && j != num2 && (!(i == Config.redBossPos.x) || !(j == Config.redBossPos.y)) && (!(i == Config.greenBossPos.x) || !(j == Config.greenBossPos.y)) && (i != curIndexByPos.x.AsInt() || j != curIndexByPos.y.AsInt()) && (i != curIndexByPos2.x.AsInt() || j != curIndexByPos2.y.AsInt()) && !Config.IsOutOfRange(i, j))
					{
						int num7 = (j - num2) / (i - num);
						int num8 = (j - num2) % (i - num);
						if ((num7 == -1 || num7 == 1) && num8 == 0)
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
		int num9 = 3;
		int num10 = 3;
		int num11 = num - 1;
		int num12 = num2 - 1;
		for (int k = num11; k < num11 + num9; k++)
		{
			for (int l = num12; l < num12 + num10; l++)
			{
				if ((k != num || l != num2) && (!(k == Config.redBossPos.x) || !(l == Config.redBossPos.y)) && (!(k == Config.greenBossPos.x) || !(l == Config.greenBossPos.y)) && (k != curIndexByPos.x.AsInt() || l != curIndexByPos.y.AsInt()) && (k != curIndexByPos2.x.AsInt() || l != curIndexByPos2.y.AsInt()) && !Config.IsOutOfRange(k, l) && (k == num || l == num2))
				{
					list2.Add((k, l));
				}
			}
		}
		int index2 = TSRandom.Range(0, list2.Count);
		return Config.GetCellPosByIndex(list2.get_Item(index2).Item1, list2.get_Item(index2).Item2);
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && (adventureActorDiedEvent.actor.dataID == SummonGeneralID || adventureActorDiedEvent.actor.dataID == SummonSoldierID))
		{
			summonCount--;
		}
	}
}
