using System.Collections;
using System.Collections.Generic;
using TrueSync;

namespace AIScript.Monster._73001KuiLeiShi_Mainline;

public class Skill_PuppetControl : SkillSimpleBase
{
	private const string combo_PuppetControl = "PuppetControl";

	private const string WaveEventName = "Wave";

	private static readonly int[] monsterIds_ChongFeng = new int[6] { 1094057984, 1919112009, 779382889, 1936941392, 1399158377, 1819044203 };

	private static readonly int[] monsterIds_TiaoYue = new int[6] { 1953450079, 1551395174, 1885434452, 858796380, 1767387440, 1702189422 };

	private static readonly int[] monsterIds_XuanFeng = new int[6] { 1953450079, 1551395174, 1885434452, 858796380, 1767387440, 1702189422 };

	private static readonly List<string> placeHolderNames = new List<string> { "SummonPoint_1", "SummonPoint_2", "SummonPoint_3", "SummonPoint_4", "SummonPoint_5" };

	private static readonly int[] puppetMinCount = new int[6] { 1600352851, 1718906696, 1415346281, 1701668200, 1802659152, 1701336156 };

	private static readonly int[] puppetMaxCount = new int[6] { 1465869677, 1819437416, 1684957527, 7562030, 65536, 1546518528 };

	private const string castCountTag = "PuppetControlCastCount";

	private FP turnTime = 0.5;

	private bool finished;

	private int _lastSummonedMonsterId;

	private int _summonLevel;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		finished = false;
		_lastSummonedMonsterId = 0;
		_summonLevel = (int)(long)GetLogicTagFpValue(_actor, Common_73001.SummonLevel_Tag);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		ClearOwnerBullet();
		if (_lastSummonedMonsterId != 0)
		{
			ClearActors(GetTargetByDataID(_lastSummonedMonsterId));
		}
	}

	protected override IEnumerator DoMainLogic()
	{
		LogicEntity target = GetAttackTarget();
		if (target == null)
		{
			target = GetCurrentPlayer();
		}
		BeginLookAt_NotWait(target, turnTime, GetRotSpdInSkill());
		BeginAttack(1, "PuppetControl", flushInputedKeys: true);
		int castCount = (int)(long)GetLogicTagFpValue(_actor, "PuppetControlCastCount");
		if (castCount >= 3)
		{
			castCount = 0;
		}
		yield return WaitCustomEvent("Summon");
		SpawnPuppets(castCount, target);
		SetLogicTagFpValue(_actor, "PuppetControlCastCount", castCount + 1);
		yield return WaitTime(2.5f);
		CancelAttack();
		yield return WaitCustomEvent("Wave");
		DispatchPuppetSyncAttack();
		finished = true;
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnSkillDisable()
	{
		base.OnSkillDisable();
		if (!finished)
		{
			ClearOwnerBullet();
			if (_lastSummonedMonsterId != 0)
			{
				ClearActors(GetTargetByDataID(_lastSummonedMonsterId));
			}
		}
	}

	private void SpawnPuppets(int castCount, LogicEntity target)
	{
		int summonActorID = (_lastSummonedMonsterId = GetPuppetMonsterId(castCount));
		int puppetCount = GetPuppetCount(castCount);
		SetLogicTagFpValue(_actor, Common_73001.PuppetSeqCounter_Tag, 0);
		TSVector2 entityPosition = GetEntityPosition(target);
		for (int i = 0; i < puppetCount; i++)
		{
			TSVector2 placeHolderPosition = GetPlaceHolderPosition(placeHolderNames.get_Item(i % placeHolderNames.Count));
			FP radius = 3;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, placeHolderPosition, default, default, radius);
			TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, _actor, isReachable: true);
			TSVector2 spawnDirection = entityPosition - shapeRandomPoint;
			SummonMonster(summonActorID, 0, shapeRandomPoint, spawnDirection);
		}
	}

	private int GetPuppetMonsterId(int castCount)
	{
		int[] ids;
		if (castCount <= 0)
		{
			ids = monsterIds_ChongFeng;
		}
		else
		{
			ids = ((_summonLevel <= 2) ? monsterIds_TiaoYue : monsterIds_XuanFeng);
		}
		return Common_73001.GetMonsterIdByLevel(_summonLevel, ids);
	}

	private int GetPuppetCount(int castCount)
	{
		int num = ((_summonLevel >= 0) ? ((_summonLevel >= puppetMinCount.Length) ? (puppetMinCount.Length - 1) : _summonLevel) : 0);
		int num2 = puppetMinCount[num] + castCount;
		if (num2 > puppetMaxCount[num])
		{
			num2 = puppetMaxCount[num];
		}
		return num2;
	}

	private void DispatchPuppetSyncAttack()
	{
		AdventureActorCustomEvent adventureActorCustomEvent = AdventureActorCustomEvent.Generate();
		adventureActorCustomEvent.sender = _actor;
		adventureActorCustomEvent.actor = _actor;
		adventureActorCustomEvent.eventHashCode = Common_73001.evt_PuppetSyncAttack;
		_actor.DispatchEvent(adventureActorCustomEvent);
	}
}
