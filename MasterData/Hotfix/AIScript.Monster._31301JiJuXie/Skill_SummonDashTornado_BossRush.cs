using System.Collections;
using System.Collections.Generic;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_SummonDashTornado_BossRush : SkillSimpleBase
{
	private static readonly string Tornado_Charge = "Tornado_Charge";

	private static List<TSVector2> DashTornado_SpawnPoints = new List<TSVector2>
	{
		new TSVector2(-8.55, 4.59),
		new TSVector2(0, -9.7),
		new TSVector2(8.25, 5.11)
	};

	private static FP DashTornado_SpawnTime = 1;

	private static readonly TSVector2 SceneForward = new TSVector2(0, 1);

	private int summonMonsterID;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		summonMonsterID = GetTeammateIdByIndex(4);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopMove();
		CancelAim();
		SetLogicTagToggleValue(_actor, Config.Skill_DashTornado_Finish, value: true);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Tornado_Charge, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitTime(0.6);
		List<MonsterAdventureActor> monsters = new List<MonsterAdventureActor>();
		for (int i = 0; i < DashTornado_SpawnPoints.Count; i++)
		{
			MonsterAdventureActor monsterAdventureActor = SpawnTornado(DashTornado_SpawnPoints.get_Item(i));
			if (monsterAdventureActor != null)
			{
				monsters.Add(monsterAdventureActor);
			}
			yield return WaitTime(DashTornado_SpawnTime);
		}
		if (monsters.Count > 0)
		{
			int timeoutFrames = 0;
			yield return WaitUntil(() => monsters.TrueForAll((MonsterAdventureActor x) => x == null || x.state == ActorState.Action) || ++timeoutFrames > 300);
			DispatchAttackCmd();
		}
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	private MonsterAdventureActor SpawnTornado(TSVector2 spawnPos)
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 playerPos = ((currentPlayer != null) ? GetEntityPosition(currentPlayer) : (spawnPos + SceneForward));
		TSVector2 spawnFacingPlayer = GetSpawnFacingPlayer(spawnPos, playerPos);
		MonsterAdventureActor temp = null;
		ILRuntimeAPI.SummonMonster(_actor, 0, summonMonsterID, spawnPos, spawnFacingPlayer, null, null, (MonsterAdventureActor entity) =>
		{
			temp = entity;
		});
		return temp;
	}

	private void DispatchAttackCmd()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.evt_DashTornadoAttack;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private static TSVector2 GetSpawnFacingPlayer(TSVector2 spawnPos, TSVector2 playerPos)
	{
		TSVector2 tSVector = playerPos - spawnPos;
		if (tSVector.magnitude <= 0)
		{
			tSVector = SceneForward;
		}
		return tSVector.normalized;
	}
}
