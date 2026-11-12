using System;
using System.Collections;
using System.Collections.Generic;
using AIScript.Monster._73001KuiLeiShi;
using TrueSync;
using UnityEngine;

namespace AIScript.Monster._31701MoFaZhen;

public class Summon_Activity_5 : SkillSimpleBase
{
	private string tag1 = "Mark1";

	private string tag2 = "Mark2";

	private string tag3 = "Mark3";

	private const float RANGE = 15f;

	private const float SPAWN_CYCLE = 8f;

	private const float FIRST_SPAWN_DELAY = 5f;

	private const int SUMMON_COUNT = 3;

	private const float SPAWN_INNER_R = 6f;

	private const float SPAWN_OUTER_R = 7f;

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
					TSVector2 position = GetPosition();
					TSVector2 entityPosition = GetEntityPosition(currentPlayer);
					if (Distance(position, entityPosition) <= 15f && ModuleController<AdventureModuleController>.Instance.InBattleState)
					{
						List<LogicEntity> targetByDataIDs = GetTargetByDataIDs(new List<int> { 3170006, 3170007 });
						if (targetByDataIDs == null || targetByDataIDs.Count == 0)
						{
							StartCor(DoSpawn(currentPlayer, entityPosition));
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

	private IEnumerator DoSpawn(object player, TSVector2 playerPos)
	{
		if (ModuleController<AdventureModuleController>.Instance.InBattleState)
		{
			float baseAngle = UnityEngine.Random.Range(0f, MathF.PI * 2f);
			for (int i = 0; i < 3; i++)
			{
				float f = baseAngle + (float)i * (MathF.PI * 2f / 3f);
				float num = UnityEngine.Random.Range(6f, 7f);
				TSVector2 tSVector = new TSVector2(num * Mathf.Cos(f), num * Mathf.Sin(f));
				TSVector2 tSVector2 = playerPos + tSVector;
				int summonActorID = PickMonsterIdByWeight();
				SummonMonster(summonActorID, 0, tSVector2, playerPos - tSVector2);
				yield return null;
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
		int num2 = UnityEngine.Random.Range(0, num);
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
