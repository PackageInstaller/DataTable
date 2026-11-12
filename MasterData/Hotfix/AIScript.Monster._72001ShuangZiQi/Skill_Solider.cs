using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Solider : SkillSimpleBase
{
	private bool isRed;

	private bool isAtk;

	private int phase;

	private int lv;

	private int spawnCount;

	private int summonCount;

	private int SummonMonsterID;

	private int SummonBallID;

	private TSVector2 JumpDirection;

	private bool IsLv6SkillEnd;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		summonCount = 0;
		spawnCount = 0;
		IsLv6SkillEnd = false;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		SummonMonsterID = GetTeammateIdByIndex(1);
		SummonBallID = GetTeammateIdByIndex(5);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetLogicTagToggleValue(_actor, Config.Skill_Solider_Finish, value: true);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SummonSoldier", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SummonStart");
		if (lv == 6 && phase < 3)
		{
			StartCor(Lv6BallSummonaAndBlast());
		}
		new List<TSVector2>();
		List<TSVector2> list;
		if (phase < 3)
		{
			list = (isRed ? Config.RedSoldierPositionList.get_Item(phase) : Config.GreenSoldierPositionList.get_Item(phase));
			JumpDirection = (isRed ? TSVector2.right : TSVector2.left);
		}
		else if (GetLogicTagFpValue(_actor, "SoilderCastTime") % 2 == 0)
		{
			list = Config.SoldierPositionListP3_1;
			JumpDirection = TSVector2.down;
		}
		else
		{
			list = Config.SoldierPositionListP3_2;
			JumpDirection = TSVector2.up;
		}
		summonCount = list.Count;
		for (int i = 0; i < summonCount; i++)
		{
			TSVector2 chesspos = list.get_Item(i);
			TSVector2 cellPosByIndex = Config.GetCellPosByIndex(chesspos);
			ILRuntimeAPI.SummonMonster(_actor, 0, SummonMonsterID, cellPosByIndex, JumpDirection, null, null, (MonsterAdventureActor monster) =>
			{
				SetLogicTagToggleValue(monster, "Red", isRed);
				SetLogicTagFpValue(monster, "Phase", phase);
				SetLogicTagFpValue(monster, "Level", lv);
				SetLogicTagFpValue(monster, "InitialScaleLevel", 1);
				SetLogicTagToggleValue(monster, "SpawnRanse", value: true);
				if (Config.rowList.Contains(chesspos.x.AsInt()))
				{
					FP modelScale = monster.actorScaleInfo.modelScale;
					monster.actorScaleInfo.modelScale = modelScale + Config.spawnScale;
					SetLogicTagFpValue(monster, "InitialScaleLevel", 2);
				}
				if (phase == 3)
				{
					monster.actorScaleInfo.modelScale = Config.maxScale;
					SetLogicTagFpValue(monster, "InitialScaleLevel", 4);
				}
			});
		}
		yield return WaitUntil(() => spawnCount >= summonCount);
		DispatchCustomEvent(Config.soldierAtkEvt);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		if (phase == 2)
		{
			yield return WaitTime(1);
		}
		else
		{
			yield return WaitUntil(() => summonCount <= 0);
		}
		IsLv6SkillEnd = true;
		yield return WaitTime(0.5);
	}

	protected override void OnActorDied(IEvent evt)
	{
		base.OnActorDied(evt);
		if (evt is AdventureActorDiedEvent adventureActorDiedEvent && adventureActorDiedEvent.actor.dataID == SummonMonsterID)
		{
			summonCount--;
		}
	}

	private void OnActorStateSwitch(IEvent evt)
	{
		if (evt is AdventureActorStateSwitchEvent adventureActorStateSwitchEvent && adventureActorStateSwitchEvent.dataId == SummonMonsterID && adventureActorStateSwitchEvent._acState == ActorState.Action)
		{
			spawnCount++;
		}
	}

	private IEnumerator Lv6BallSummonaAndBlast()
	{
		TSVector2 cellPosByIndex = Config.GetCellPosByIndex(isRed ? Config.RedLv6BallPositionList.get_Item(phase).get_Item(0) : Config.GreenLv6BallPositionList.get_Item(phase).get_Item(0));
		int teammateIdByIndex = GetTeammateIdByIndex(5);
		List<LogicEntity> balls = new List<LogicEntity>();
		ILRuntimeAPI.SummonMonster(_actor, 0, teammateIdByIndex, cellPosByIndex, default, null, null, (MonsterAdventureActor monster) =>
		{
			SetLogicTagToggleValue(monster, "Red", isRed);
			SetLogicTagFpValue(monster, "Phase", phase);
			SetLogicTagFpValue(monster, "Level", lv);
			SetLogicTagToggleValue(monster, "Lv6Common", value: true);
			SetLogicTagToggleValue(monster, "Lv6CommonWaiting", value: true);
			SetLogicTagToggleValue(monster, "IsSneak", value: true);
			balls.Add(monster);
		});
		while (!IsLv6SkillEnd)
		{
			yield return null;
		}
		for (int num = 0; num < balls.Count; num++)
		{
			SetLogicTagToggleValue(balls.get_Item(num), "Lv6CommonWaiting", value: false);
		}
	}
}
