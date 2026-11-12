using System.Collections;
using System.Collections.Generic;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._10005JiaMianYeZhu;

public class Skill_ThousandDash_Lv3 : SkillSimpleBase
{
	private static readonly ComboInputBuffer.ActionKey[] Summon_Combo = new ComboInputBuffer.ActionKey[1] { ComboInputBuffer.ActionKey.F };

	private static readonly FP SkillWaitInterval = 1f;

	private static readonly FP SummonDistanceMin = 12;

	private static readonly FP SummonDistanceMax = 17;

	private static readonly int SummonAmount = 12;

	private static readonly FP CameraWaitTime = 7;

	private static readonly FP SummonAngleAmount = 10;

	private int SummonCount;

	private DeterministicShape SummonShape;

	private List<LogicEntity> SummonMonsterList = new List<LogicEntity>();

	private FP SummonShapeRotation;

	private TSVector2 SummonPoint;

	private FP SummonPointDirectionAngle;

	private int SummonIndex;

	private TSVector2 PlayerCurrentPosition;

	private GameObject VirtualCamera;

	private bool IsNotInterrupt;

	private FP AngryTimes;

	protected override void OnSkillEnable()
	{
		IsNotInterrupt = false;
		SummonIndex = 0;
		ModuleController<AdventureModuleController>.Instance.AddEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonMonsterSpawn);
	}

	protected override void OnSkillDisable()
	{
		if (!IsNotInterrupt)
		{
			SummonMonsterList = GetTargetByTeammateIndex(2);
			KillActors(SummonMonsterList);
			SwitchCameraSetting(active: false, "Summon");
			SwitchCameraSetting(active: false, "Summon_Start");
		}
		else
		{
			AngryTimes = GetLogicTagFpValue(_actor, "AngryTimes");
			SetLogicTagFpValue(_actor, "AngryTimes", AngryTimes + 1);
		}
		SetLogicTagToggleValue(_actor, "ThousandDashInterrupt", !IsNotInterrupt);
		ModuleController<AdventureModuleController>.Instance.RemoveEventListener("BATTLE_MONSTER_SUMMONER_SPAWNED", OnSummonMonsterSpawn);
	}

	protected override IEnumerator DoMainLogic()
	{
		BeginAttack(1, Summon_Combo, flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCombo(ComboAttackType.isComboFinish);
		PlayerCurrentPosition = GetEntityPositionObsoleted(GetCurrentPlayer());
		VirtualCamera = GameObject.Find("Summon_Start");
		if (VirtualCamera != null)
		{
			VirtualCamera.transform.position = new Vector3((float)PlayerCurrentPosition.x, 0f, (float)PlayerCurrentPosition.y);
		}
		SwitchCameraSetting(active: true, "Summon_Start");
		PlayWwiseSound("mon_10005_Angry_L_Begin");
		SwitchCameraSetting(active: true, "Summon");
		yield return WaitTime(1);
		AddBuffToTarget(_actor, 100050110);
		SetLogicTagFpValue(_actor, "AngryBuffStartTime", _actor.LogicTime);
		SwitchCameraSetting(active: false, "Summon_Start");
		Summon();
		yield return WaitTime(0.5);
		IsNotInterrupt = true;
	}

	private void Summon()
	{
		SummonCount = 0;
		SummonShapeRotation = 0;
		TSVector2 entityPositionObsoleted = GetEntityPositionObsoleted(GetCurrentPlayer());
		FP summonDistanceMax = SummonDistanceMax;
		FP summonDistanceMin = SummonDistanceMin;
		FP angle = 360 / SummonAngleAmount;
		FP summonShapeRotation = SummonShapeRotation;
		SummonShape = GetShapeData(DeterministicShape.ShapeType.Fan, entityPositionObsoleted, default, default, summonDistanceMax, summonDistanceMin, angle, summonShapeRotation);
		while (SummonCount < SummonAmount)
		{
			SummonPoint = GetShapeRandomPoint(SummonShape, _actor, isReachable: true);
			SummonPointDirectionAngle = AngleBetween2TSVector(TSVector2.down, SummonPoint - GetEntityPositionObsoleted(GetCurrentPlayer()), signed: true);
			if (SummonPoint != GetEntityPositionObsoleted(GetCurrentPlayer()) && SummonPointDirectionAngle < 150 && SummonPointDirectionAngle > -150)
			{
				SummonTeammate(2, SummonPoint, GetEntityPositionObsoleted(GetCurrentPlayer()) - SummonPoint);
				SummonCount++;
			}
			SummonShapeRotation += 360 / SummonAngleAmount;
			TSVector2 entityPositionObsoleted2 = GetEntityPositionObsoleted(GetCurrentPlayer());
			summonShapeRotation = SummonDistanceMax;
			angle = SummonDistanceMin;
			summonDistanceMin = 360 / SummonAngleAmount;
			summonDistanceMax = SummonShapeRotation;
			SummonShape = GetShapeData(DeterministicShape.ShapeType.Fan, entityPositionObsoleted2, default, default, summonShapeRotation, angle, summonDistanceMin, summonDistanceMax);
		}
	}

	protected void OnSummonMonsterSpawn(IEvent evt)
	{
		AdventureMonsterSummonerSpawnedEvent adventureMonsterSummonerSpawnedEvent = evt as AdventureMonsterSummonerSpawnedEvent;
		if (adventureMonsterSummonerSpawnedEvent.summonerId == _actor.Id)
		{
			MonsterAdventureActor monsterAdventureActor = ModuleController<AdventureModuleController>.Instance.QueryEntityByID(adventureMonsterSummonerSpawnedEvent.id) as MonsterAdventureActor;
			if (monsterAdventureActor != null && monsterAdventureActor.dataID == GetTeammateIdByIndex(2))
			{
				SetLogicTagFpValue(monsterAdventureActor, "WaitTime", SummonIndex * SkillWaitInterval);
				SetLogicTagFpValue(monsterAdventureActor, "MasterID", _actor.Id);
				SummonIndex++;
			}
		}
	}
}
