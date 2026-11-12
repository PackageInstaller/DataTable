using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_SummonTraceTornado_BossRush : SkillSimpleBase
{
	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private static FP TraceTornado_SpawnRadius = 3;

	private static readonly TSVector2 SceneForward = new TSVector2(0, 1);

	private static FP Ring_RadiusMin = 6;

	private static FP Ring_RadiusMax = 6.5;

	private static FP loopTime = 0.6;

	private int summonMonsterID;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		summonMonsterID = GetTeammateIdByIndex(3);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		SetLogicTagToggleValue(_actor, Config.Skill_TraceTornado_Finish, value: true);
		StopWaitLookAt();
	}

	protected override IEnumerator DoMainLogic()
	{
		string actionKey = ((CalcAngleBetweenSelfAndAttackTarget(isSingleAngle: true) > 0) ? combo_Turn_Left : combo_Turn_Right);
		BeginAttack(1, actionKey, flushInputedKeys: true, forceInterruptAttack: true);
		LogicEntity logicEntity = GetAttackTarget();
		if (logicEntity == null)
		{
			logicEntity = GetCurrentPlayer();
		}
		TSVector2 entityPosition = GetEntityPosition(logicEntity);
		BeginLookAtByPos(entityPosition, 0.66, (FP)90 / (FP)0.66);
		MonsterAdventureActor monster = SpawnTornado();
		if (monster != null)
		{
			int timeoutFrames = 0;
			yield return WaitUntil(() =>
			{
				timeoutFrames++;
				return monster.state == ActorState.Action || timeoutFrames > 300;
			});
			DispatchAttackCmd();
		}
		yield return WaitTime(loopTime);
	}

	private MonsterAdventureActor SpawnTornado()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 entityPosition = GetEntityPosition(currentPlayer);
		TSVector2 traceTornadoSpawnPos = GetTraceTornadoSpawnPos(entityPosition, TraceTornado_SpawnRadius);
		TSVector2 spawnFacingPlayer = GetSpawnFacingPlayer(traceTornadoSpawnPos, entityPosition);
		MonsterAdventureActor temp = null;
		ILRuntimeAPI.SummonMonster(_actor, 0, summonMonsterID, traceTornadoSpawnPos, spawnFacingPlayer, null, null, (MonsterAdventureActor entity) =>
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
		adventureActorCustomEvent.eventHashCode = Config.evt_TraceTornadoAttack;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}

	private TSVector2 GetTraceTornadoSpawnPos(TSVector2 playerPos, FP spawnRadius)
	{
		FP ring_RadiusMax = Ring_RadiusMax;
		FP ring_RadiusMin = Ring_RadiusMin;
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, playerPos, default, default, ring_RadiusMax, ring_RadiusMin);
		return GetShapeRandomPoint(shapeData, _actor, isReachable: true);
	}

	private TSVector2 GetSpawnFacingPlayer(TSVector2 spawnPos, TSVector2 playerPos)
	{
		TSVector2 tSVector = playerPos - spawnPos;
		if (tSVector.magnitude <= 0)
		{
			tSVector = SceneForward;
		}
		return tSVector.normalized;
	}
}
