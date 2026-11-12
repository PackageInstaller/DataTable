using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._72001ShuangZiQi;

public class Skill_Knights : SkillSimpleBase
{
	private bool isRed;

	private int phase;

	private int lv;

	private int spawnCount;

	private int summonCount;

	private int SummonMonsterID;

	private bool IsLv6SkillEnd;

	private List<LogicEntity> monsters = new List<LogicEntity>();

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		summonCount = 0;
		spawnCount = 0;
		monsters.Clear();
		IsLv6SkillEnd = false;
		isRed = GetLogicTagToggleValue(_actor, "Red");
		phase = GetLogicTagFpValue(_actor, "Phase").AsInt();
		lv = GetLogicTagFpValue(_actor, "Level").AsInt();
		SummonMonsterID = GetTeammateIdByIndex(4);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ACTOR_STATE_SWITCH", OnActorStateSwitch);
		SetLogicTagToggleValue(_actor, Config.Skill_General3_Finish, value: true);
		monsters.Clear();
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, "SummonGeneral", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("SummonStart");
		if (lv == 6 && phase < 3)
		{
			StartCor(Lv6BallSummonaAndBlast());
		}
		List<TSVector2> list = GenerateSpawnPositions();
		TSVector2 dir = (isRed ? TSVector2.right : TSVector2.left);
		summonCount = list.Count;
		for (int i = 0; i < list.Count; i++)
		{
			TSVector2 cellPosByIndex = Config.GetCellPosByIndex(list.get_Item(i));
			ILRuntimeAPI.SummonMonster(_actor, 0, SummonMonsterID, cellPosByIndex, dir, null, null, (MonsterAdventureActor monster) =>
			{
				SetLogicTagToggleValue(monster, "Red", isRed);
				SetLogicTagFpValue(monster, "Phase", phase);
				SetLogicTagFpValue(monster, "Level", lv);
				SetLogicTagFpValue(monster, "Type", 2);
				monsters.Add(monster);
			});
		}
		yield return WaitUntil(() => spawnCount >= summonCount);
		FP interval = ((phase <= 2) ? Config.General1AttackInterval : Config.General1AttackInterval_P3);
		for (int i2 = 0; i2 < monsters.Count; i2++)
		{
			DispatchAtkCmd(monsters.get_Item(i2), Config.general1AtkEvt);
			yield return WaitTime(interval);
		}
		yield return WaitUntil(() => summonCount <= 0);
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
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

	private List<TSVector2> GenerateSpawnPositions()
	{
		if (phase <= 2)
		{
			return Config.KnightsPositionList.get_Item(0);
		}
		return Config.KnightsPositionList.get_Item(isRed ? 12 : 11);
	}

	private void DispatchAtkCmd(LogicEntity target, int eventHash)
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = eventHash;
		adventureActorCustomEvent.target = target;
		_actor.DispatchEvent(adventureActorCustomEvent);
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
