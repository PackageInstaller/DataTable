using System.Collections;
using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;

namespace AIScript.Monster.TowerDefense.Skill;

public class Skill_Blink_Fire_2 : TowerMonsterSkillBase
{
	private FP searchRange = 999;

	private int fireGridCount = 2;

	private string areaEffect = "Area_SkyFire";

	private List<GridInfoData> cachedGrids;

	protected override void OnSkillEnable()
	{
		base.OnSkillEnable();
		cachedGrids = null;
	}

	protected override IEnumerator DoMainLogic()
	{
		Dispatch_GetGridsInfoInCircle(_actor.tsTransform.Position, searchRange, preferNonFlame: true, (List<GridInfoData> grids) =>
		{
			cachedGrids = grids;
		});
		if (cachedGrids.Count == 0)
		{
			_skill?.Clear();
			yield break;
		}
		BeginAttack(1, "SkyFire", flushInputedKeys: true, forceInterruptAttack: true);
		yield return WaitCustomEvent("Fire");
		List<GridInfoData> list = new List<GridInfoData>();
		List<GridInfoData> list2 = new List<GridInfoData>();
		for (int num = 0; num < cachedGrids.Count; num++)
		{
			if (cachedGrids.get_Item(num).isSprayed)
			{
				list2.Add(cachedGrids.get_Item(num));
			}
			else
			{
				list.Add(cachedGrids.get_Item(num));
			}
		}
		int count = fireGridCount;
		count = PickAndCreateFire(list, count);
		if (count > 0)
		{
			PickAndCreateFire(list2, count);
		}
		yield return WaitCustomEvent("End");
		CancelAttack();
		yield return WaitCombo(ComboAttackType.isComboFinish);
	}

	protected override void OnInterrupt(int comboIndex)
	{
		base.OnInterrupt(comboIndex);
		_skill?.Clear();
	}

	private int PickAndCreateFire(List<GridInfoData> pool, int count)
	{
		while (count > 0 && pool.Count > 0)
		{
			int index = TSRandom.Range(0, pool.Count);
			StartCor(DoCreateFire(pool.get_Item(index).gridIndex, pool.get_Item(index).position));
			pool.RemoveAt(index);
			count--;
		}
		return count;
	}

	private IEnumerator DoCreateFire(int gridId, TSVector2 pos)
	{
		PlayAreaEffect(areaEffect, pos);
		yield return _actor.WaitTime(1.3f);
		Dispatch_CreateFire(gridId);
	}
}
