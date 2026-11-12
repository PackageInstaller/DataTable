using System.Collections;
using AdventureBehaviour;
using TrueSync;

namespace AIScript.Monster._31301JiJuXie;

public class Skill_SummonSplitTornado : SkillSimpleBase
{
	private static readonly string combo_Tornado_Charge = "Tornado_Charge";

	private static readonly string combo_Turn_Left = "Turn_Left";

	private static readonly string combo_Turn_Right = "Turn_Right";

	private static readonly TSVector2 SceneForward = new TSVector2(0, 1);

	private static FP SpawnForwardDistance = 2;

	private static FP loopTime = 0.6;

	private int summonMonsterID;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		summonMonsterID = GetTeammateIdByIndex(5);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		StopWaitLookAt();
		SetLogicTagToggleValue(_actor, Config.Skill_SplitTornado_Finish, value: true);
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
			yield return WaitUntil(() => monster == null || monster.state == ActorState.Action || ++timeoutFrames > 300);
			if (monster != null)
			{
				DispatchAttackCmd();
			}
		}
		yield return WaitTime(loopTime);
	}

	private MonsterAdventureActor SpawnTornado()
	{
		LogicEntity currentPlayer = GetCurrentPlayer();
		TSVector2 entityPosition = GetEntityPosition(currentPlayer);
		TSVector2 tSVector = new TSVector2(0, 1);
		TSVector2 tSVector2 = entityPosition - tSVector;
		if (tSVector2.magnitude <= 0)
		{
			tSVector2 = SceneForward;
		}
		TSVector2 normalized = tSVector2.normalized;
		MonsterAdventureActor temp = null;
		ILRuntimeAPI.SummonMonster(_actor, 0, summonMonsterID, tSVector, normalized, null, null, (MonsterAdventureActor entity) =>
		{
			temp = entity;
			SetLogicTagToggleValue(entity, Config.LogicTag_IsMiniSplitTornado, value: false);
		});
		return temp;
	}

	private void DispatchAttackCmd()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Config.evt_SplitTornadoAttack;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}
}
