using System.Collections;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

namespace AIScript;

public class TowerDefenseItem_Flare : TowerDefenseItemBase
{
	public class FlareEffectData
	{
		public int targetGridIndex;

		public bool isLighthouse;

		public List<int> litGrids;

		public List<int> tempLitGrids = new List<int>();

		public bool invincible;

		public bool forceEnded;
	}

	private const string TOWERDEFENSE_ITEM_FLARE_START = "TOWERDEFENSE_ITEM_FLARE_START";

	private const string TOWERDEFENSE_ITEM_FLARE_END = "TOWERDEFENSE_ITEM_FLARE_END";

	private const string FLARE_EFFECT = "Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_base_ghost_lamp.prefab";

	private const string FLARE_EFFECT_END = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_ghost_lamp_end.prefab";

	private FP duration = 10f;

	private FP invincibleTime = 0.4;

	public override void InitConfig(TowerDefenseItem itemData)
	{
		base.InitConfig(itemData);
		indicatorRange = 3;
	}

	protected override IEnumerator DoMainLogic(TSVector2 position)
	{
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(new Vector3((float)position.x, 0f, (float)position.y));
		if (grid.IsNull)
		{
			yield break;
		}
		bool flag = grid.gridDeployType == 6;
		FlareEffectData data = new FlareEffectData
		{
			targetGridIndex = grid.index,
			isLighthouse = flag,
			litGrids = GetItemTakeEffectGrids(grid.index),
			invincible = !flag
		};
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(new GeneralEvent("TOWERDEFENSE_ITEM_FLARE_START", data));
		Vector3 worldPos = new Vector3(grid.position.x, 0f, grid.position.y);
		if (flag)
		{
			yield return WaitTimeOrForceEnd(duration, data);
			if (!data.forceEnded)
			{
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(new GeneralEvent("TOWERDEFENSE_ITEM_FLARE_END", data));
			}
			yield break;
		}
		AdventureFXPlayer flareEffect = PlayEffect("Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_base_ghost_lamp.prefab", worldPos);
		long flareEffectToken = ((null != flareEffect) ? flareEffect.token : 0);
		yield return WaitTimeOrForceEnd(invincibleTime, data);
		data.invincible = false;
		yield return WaitTimeOrForceEnd(duration - invincibleTime, data);
		bool forceEnded = data.forceEnded;
		if (!forceEnded)
		{
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(new GeneralEvent("TOWERDEFENSE_ITEM_FLARE_END", data));
		}
		if (forceEnded)
		{
			if (null != flareEffect && flareEffect.token == flareEffectToken)
			{
				flareEffect.Stop(dontPlaySubFX: true);
			}
			PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_base_ghost_lamp_end.prefab", worldPos);
		}
	}

	protected CoroutineNode WaitTime(FP s)
	{
		return StartCoroutine(Wait(s));
	}

	private IEnumerator Wait(FP s)
	{
		if (s <= 0)
		{
			s = FP.Epsilon;
		}
		while (s > 0)
		{
			s -= LockStepManager.deltaTime;
			yield return null;
		}
	}

	private CoroutineNode WaitTimeOrForceEnd(FP s, FlareEffectData data)
	{
		return StartCoroutine(WaitOrForceEnd(s, data));
	}

	private IEnumerator WaitOrForceEnd(FP s, FlareEffectData data)
	{
		if (s <= 0)
		{
			s = FP.Epsilon;
		}
		while (s > 0 && !data.forceEnded)
		{
			s -= LockStepManager.deltaTime;
			yield return null;
		}
	}

	public override bool GridSatisItem_CanUse(TowerDefenseMapData.TowerGrid grid)
	{
		if (grid.IsNull)
		{
			return false;
		}
		if (grid.gridWalkableType != 1 && grid.gridDeployType != 2)
		{
			return grid.gridDeployType == 6;
		}
		return true;
	}

	public override bool GridSatisItem_TakeEffect(TowerDefenseMapData.TowerGrid grid)
	{
		if (grid.IsNull)
		{
			return false;
		}
		return true;
	}
}
