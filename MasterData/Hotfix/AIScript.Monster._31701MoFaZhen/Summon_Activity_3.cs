using System.Collections;
using System.Collections.Generic;
using AIScript.Monster._73001KuiLeiShi;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._31701MoFaZhen;

public class Summon_Activity_3 : SkillSimpleBase
{
	private string tag1 = "Mark1";

	private string tag2 = "Mark2";

	private string tag3 = "Mark3";

	private const float SPAWN_CYCLE = 8f;

	private const float FIRST_SPAWN_DELAY = 5f;

	private const int SUMMON_COUNT = 2;

	private const float SYNC_ATTACK_DELAY = 0.5f;

	private readonly int[] SUMMON_IDS = new int[2] { 3170006, 3170007 };

	private readonly int[] SUMMON_WEIGHTS = new int[2] { 1, 1 };

	protected override void OnSkillEnable()
	{
		SetHideModelEnable(autoDisableWhenSkillDisable: false);
		SetUnparalleledEnable(autoDisableWhenSkillDisable: false);
		SetSearchedImmunityEnable(autoDisableWhenSkillDisable: false);
		SetCloseBlockEnable(autoDisableWhenSkillDisable: false);
	}

	protected override void OnSkillDisable()
	{
	}

	protected override IEnumerator DoMainLogic()
	{
		string monsterTagValue = GetMonsterTagValue(_actor, 1);
		if (monsterTagValue == tag1)
		{
			yield return WaitTime(5f);
			while (true)
			{
				LogicEntity currentPlayer = GetCurrentPlayer();
				if (currentPlayer != null)
				{
					bool inBattleState = ModuleController<AdventureModuleController>.Instance.InBattleState;
					Debug.Log($"[Summon_Activity_3] 检查 InBattleState={inBattleState}");
					if (inBattleState)
					{
						TSVector2 entityPosition = GetEntityPosition(currentPlayer);
						List<LogicEntity> targetByDataIDs = GetTargetByDataIDs(new List<int> { 3170006, 3170007 });
						Debug.Log($"[Summon_Activity_3] 场上幻影人偶数量={targetByDataIDs?.Count ?? 0}");
						if (targetByDataIDs == null || targetByDataIDs.Count == 0)
						{
							DoSpawn(currentPlayer, entityPosition);
						}
					}
				}
				yield return WaitTime(8f);
			}
		}
		if (!(monsterTagValue == tag2))
		{
			_ = monsterTagValue == tag3;
		}
		yield return WaitTime(9999f);
	}

	private void DoSpawn(object player, TSVector2 playerPos)
	{
		if (ModuleController<AdventureModuleController>.Instance.InBattleState)
		{
			TSVector2 position = playerPos;
			FP radius = 7;
			FP innerRadius = 6;
			DeterministicShape shapeData = GetShapeData(DeterministicShape.ShapeType.Circle, position, default, default, radius, innerRadius);
			for (int i = 0; i < 2; i++)
			{
				TSVector2 shapeRandomPoint = GetShapeRandomPoint(shapeData, player as LogicEntity, isReachable: true);
				int num = PickMonsterIdByWeight();
				Debug.Log($"[Summon_Activity_3] 召唤 monsterId={num} 玩家位置=({playerPos.x},{playerPos.y}) 召唤位置=({shapeRandomPoint.x},{shapeRandomPoint.y})");
				SummonMonster(num, 0, shapeRandomPoint, playerPos - shapeRandomPoint);
			}
			StartCor(DispatchPuppetSyncAttack());
		}
	}

	private int PickMonsterIdByWeight()
	{
		int num = 0;
		for (int i = 0; i < SUMMON_WEIGHTS.Length; i++)
		{
			num += SUMMON_WEIGHTS[i];
		}
		int num2 = Random.Range(0, num);
		for (int j = 0; j < SUMMON_IDS.Length; j++)
		{
			num2 -= SUMMON_WEIGHTS[j];
			if (num2 < 0)
			{
				return SUMMON_IDS[j];
			}
		}
		return SUMMON_IDS[0];
	}

	private IEnumerator DispatchPuppetSyncAttack()
	{
		yield return WaitTime(0.5f);
		DispatchCustomEvent(Common_73001.evt_PuppetSyncAttack);
	}
}
