using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Action_Lv3 : MonsterActionBase
{
	private static readonly int Skill_Turn = 1000508;

	private static readonly int Skill_Impact = 1000501;

	private static readonly int Skill_StrikeFly = 1000503;

	private static readonly int Skill_Dash = 1000512;

	private static readonly int Skill_Crush = 1000504;

	private static readonly int Skill_ThousandDash = 1000511;

	private static readonly int Skill_LighteningDash = 1000507;

	private static readonly FP HpPercentage_Stage1To2 = 0.75;

	private static readonly FP AngryBuffMaxTime = 25;

	private static readonly int Skill_Test = 0;

	private bool IsPhase2;

	private FP Angle;

	private FP AngryContinuousTime;

	private FP AngryTimes;

	private CoroutineNode CloseCameraAfterSecondsNode;

	protected override void SetConfig()
	{
		_monsterAIType = MonsterAIType.POOL;
		SetLogicTagFpValue(_actor, "BattleStage", 1);
		SetLogicTagFpValue(_actor, "AngryTimes", 0);
		SetLogicTagToggleValue(_actor, "CommonSummonning", value: true);
		SetLogicTagToggleValue(_actor, "ThousandDashing", value: false);
		List<PoolBranchesInfo> poolBranches = new List<PoolBranchesInfo>
		{
			new PoolBranchesInfo
			{
				index = 1,
				braches = new List<PoolBranchInfo>
				{
					new PoolBranchInfo(_actor, 1001, 60, 55, 0, active: true, 999, 360, 99, ThousandDashCondition, null, ThousandDashCast),
					new PoolBranchInfo(_actor, 1002, 50, 20, 0, active: true, 99, 360, 99, LighteningDashCondition, null, LighteningDashCast),
					new PoolBranchInfo(_actor, 1003, 40, 6, 0, active: true, 3, 360, 1, CrushCondition, null, CrushCast),
					new PoolBranchInfo(_actor, 1004, 30, 3, 0, active: true, 3, 360, 1, AttackCondition, null, AttackCast),
					new PoolBranchInfo(_actor, 1006, 10, 1, 0, active: true, 13, 360, 5, null, null, DashCast)
				}
			}
		};
		InitPoolBranches(1, poolBranches);
	}

	protected override void OnActionEnable()
	{
		IsPhase2 = false;
		StartCoroutine(AngrySummon());
		CommonSummon();
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonMonsterSpawn);
	}

	protected override void SetListenEvents()
	{
		InitListenEvent(MonsterEventType.SelfToughnessBroken, active: true, InterruptAngry);
		InitListenEvent(MonsterEventType.SelfHpChanged, active: true, PhaseChange);
		InitListenEvent(MonsterEventType.SelfLostControl, active: true, CloseCamera);
	}

	private IEnumerator ThousandDashCast()
	{
		GotoCastSkill(Skill_ThousandDash);
		yield return WaitSkillFinish();
		yield return StartCoroutine(CheckAngry());
		StartCoroutine(ref CloseCameraAfterSecondsNode, CloseCameraAfterSeconds());
	}

	private bool ThousandDashCondition()
	{
		if (GetLogicTagFpValue(_actor, "BattleStage") == 2)
		{
			return true;
		}
		return false;
	}

	private IEnumerator LighteningDashCast()
	{
		GotoCastSkill(Skill_Turn);
		yield return WaitSkillFinish();
		GotoCastSkill(Skill_LighteningDash);
		yield return WaitSkillFinish();
		yield return StartCoroutine(CheckAngry());
	}

	private bool LighteningDashCondition()
	{
		if (GetBuffNum(_actor, 100050110) > 0 && GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) >= 5 && GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 9)
		{
			return true;
		}
		return false;
	}

	private IEnumerator CrushCast()
	{
		GotoCastSkill(Skill_Crush);
		yield return WaitSkillFinish();
		yield return StartCoroutine(CheckAngry());
	}

	private bool CrushCondition()
	{
		TSVector2 position = GetPosition();
		FP width = 8;
		FP length = 2;
		FP rotation = GetRotation();
		DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Rectangle, position, width, length, default, default, default, rotation);
		if (GetLogicTagFpValue(_actor, "BattleStage") == 2 && AreaCheckMonsterTarget(shapeData))
		{
			return true;
		}
		return false;
	}

	private IEnumerator AttackCast()
	{
		Angle = CalcAngleBetweenSelfAndAttackTarget();
		GotoCastSkill(Skill_Turn);
		yield return WaitSkillFinish();
		if (Angle < 90)
		{
			GotoCastSkill(Skill_Impact);
		}
		else
		{
			GotoCastSkill(Skill_StrikeFly);
		}
		yield return WaitSkillFinish();
		yield return StartCoroutine(CheckAngry());
	}

	private bool AttackCondition()
	{
		if (GetDistanceWithTarget(calcDistanceWithoutEntityRadius: true) <= 4)
		{
			return true;
		}
		return false;
	}

	private IEnumerator DashCast()
	{
		GotoCastSkill(Skill_Turn);
		yield return WaitSkillFinish();
		GotoCastSkill(Skill_Dash);
		yield return WaitSkillFinish();
		yield return StartCoroutine(CheckAngry());
	}

	private void InterruptAngry(IEvent evt)
	{
		RemoveBuffFromTarget(_actor, 100050110);
		SetLogicTagToggleValue(_actor, "ThousandDashing", value: false);
		SetPoolBranchCD(1001, 25);
		StartCoroutine(ToughnessBrokenSummon());
	}

	private void PhaseChange(IEvent evt)
	{
		if (_actor.actorHealthInfo.hpPercentage <= HpPercentage_Stage1To2 && !IsPhase2)
		{
			SetLogicTagFpValue(_actor, "BattleStage", 2);
			IsPhase2 = true;
		}
	}

	private void CloseCamera(IEvent evt)
	{
		StopCoroutine(CloseCameraAfterSecondsNode);
		SwitchCameraSetting(active: false, "Summon");
		SwitchCameraSetting(active: false, "Summon_Start");
	}

	private IEnumerator ToughnessBrokenSummon()
	{
		KillActors(GetTargetByTeammateIndex(2));
		KillActors(GetTargetByTeammateIndex(5));
		int SummonCount = 0;
		yield return WaitTime(1);
		for (; SummonCount < 2; SummonCount++)
		{
			Action_Lv3 action_Lv = this;
			TSVector2 position = GetPosition();
			FP radius = 8;
			FP innerRadius = 4;
			DeterministicShape shapeData = action_Lv.GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
			SummonTeammate(1, GetShapeRandomPoint(shapeData, _actor, isReachable: true), GetPosition() - GetEntityPositionObsoleted(GetAttackTarget()));
		}
	}

	private IEnumerator CloseCameraAfterSeconds()
	{
		yield return WaitTime(7);
		SwitchCameraSetting(active: false, "Summon");
		SwitchCameraSetting(active: false, "Summon_Start");
		yield return WaitTime(6);
		SetLogicTagToggleValue(_actor, "ThousandDashing", value: true);
	}

	private void CommonSummon()
	{
		TSVector2 position = GetPosition();
		FP radius = 9;
		FP innerRadius = 7;
		FP angle = 120;
		FP rotation = 0;
		SummonTeammate(4, GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Fan, position, default, default, radius, innerRadius, angle, rotation), _actor, isReachable: true), GetPosition() - GetEntityPositionObsoleted(GetAttackTarget()), 6);
		TSVector2 position2 = GetPosition();
		rotation = 9;
		angle = 7;
		innerRadius = 120;
		radius = 120;
		SummonTeammate(4, GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Fan, position2, default, default, rotation, angle, innerRadius, radius), _actor, isReachable: true), GetPosition() - GetEntityPositionObsoleted(GetAttackTarget()), 6);
		TSVector2 position3 = GetPosition();
		radius = 9;
		innerRadius = 7;
		angle = 120;
		rotation = 240;
		SummonTeammate(4, GetShapeRandomPoint(GetShapeData(DeterministicShape.ShapeType.Fan, position3, default, default, radius, innerRadius, angle, rotation), _actor, isReachable: true), GetPosition() - GetEntityPositionObsoleted(GetAttackTarget()), 6);
	}

	private IEnumerator AngrySummon()
	{
		while (true)
		{
			if (GetLogicTagToggleValue(_actor, "ThousandDashing"))
			{
				Action_Lv3 action_Lv = this;
				Action_Lv3 action_Lv2 = this;
				TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
				FP radius = 8;
				FP innerRadius = 6;
				TSVector2 shapeRandomPoint = action_Lv.GetShapeRandomPoint(action_Lv2.GetShapeData(DeterministicShape.ShapeType.Circle, entityPositionObsoleted, default, default, radius, innerRadius), _actor, isReachable: true);
				SummonTeammate(5, shapeRandomPoint, shapeRandomPoint - GetEntityPositionObsoleted(GetAttackTarget()));
				yield return WaitTime(2);
			}
			else
			{
				yield return null;
			}
		}
	}

	private void OnSummonMonsterSpawn(IEvent evt)
	{
		AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent = evt as AdventureMonsterSummonerSpawnedEvent;
		if (adventureMonsterSummonerSpawnedEvent.summonerId == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(adventureMonsterSummonerSpawnedEvent.id) as MonsterAdventureActor;
			if (monsterAdventureActor != null && monsterAdventureActor.dataID == GetTeammateIdByIndex(5))
			{
				SetLogicTagFpValue(monsterAdventureActor, "WaitTime", 0);
				SetLogicTagFpValue(monsterAdventureActor, "MasterID", _actor.Id);
			}
		}
	}

	private IEnumerator CheckAngry()
	{
		AngryContinuousTime = _actor.LogicTime - GetLogicTagFpValue(_actor, "AngryBuffStartTime");
		AngryTimes = GetLogicTagFpValue(_actor, "AngryTimes");
		if (GetBuffNum(_actor, 100050110) > 0 && AngryContinuousTime > AngryBuffMaxTime && AngryTimes < 3)
		{
			SetLogicTagToggleValue(_actor, "ThousandDashing", value: false);
			RemoveBuffFromTarget(_actor, 100050110);
			GotoCastSkill(Skill_Turn);
			CommonSummon();
			yield return WaitTime(1.5);
		}
		yield return null;
	}

	private void GotoCastSkill(int ID)
	{
		if (Skill_Test != 0)
		{
			ID = Skill_Test;
		}
		CastSkill(ID);
	}
}
