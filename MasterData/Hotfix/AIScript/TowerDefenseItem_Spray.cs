using System.Collections;
using System.Collections.Generic;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

namespace AIScript;

public class TowerDefenseItem_Spray : TowerDefenseItemBase
{
	public class SprayEffectData
	{
		public TSVector2 position;

		public FP value;

		public bool isEnd;
	}

	private const string TOWERDEFENSE_ITEM_SPRAY_EFFECT_START = "TOWERDEFENSE_ITEM_SPRAY_EFFECT_START";

	private const string TOWERDEFENSE_ITEM_SPRAY_EFFECT = "TOWERDEFENSE_ITEM_SPRAY_EFFECT";

	private const string SPRAY_EFFECT = "Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_loop_spray.prefab";

	private const string SPRAY_EFFECT_GROUND = "Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_loop_spray_ground.prefab";

	public override void InitConfig(TowerDefenseItem itemData)
	{
		base.InitConfig(itemData);
		indicatorRange = 5;
	}

	protected override IEnumerator DoMainLogic(TSVector2 position)
	{
		SprayEffectData data = new SprayEffectData
		{
			position = position,
			isEnd = false
		};
		AdventureFXPlayer sprayEffect = PlayEffect("Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_loop_spray.prefab", new Vector3((float)position.x, 0f, (float)position.y));
		List<int> itemTakeEffectGrids = GetItemTakeEffectGrids(host.GetGrid(new Vector3((float)position.x, 0f, (float)position.y)).index);
		List<AdventureFXPlayer> sprayEffectList = new List<AdventureFXPlayer>();
		for (int i = 0; i < itemTakeEffectGrids.Count; i++)
		{
			int index = itemTakeEffectGrids.get_Item(i);
			TowerDefenseMapData.TowerGrid grid = host.GetGrid(index);
			if (!grid.IsNull)
			{
				AdventureFXPlayer item = PlayEffect("Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_loop_spray_ground.prefab", new Vector3(grid.position.x, 0f, grid.position.y));
				sprayEffectList.Add(item);
			}
		}
		GeneralEvent e = new GeneralEvent("TOWERDEFENSE_ITEM_SPRAY_EFFECT", data);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(new GeneralEvent("TOWERDEFENSE_ITEM_SPRAY_EFFECT_START", data));
		data.value = TowerDefenseConfig.SyaryFireEffectnum;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(e);
		yield return WaitTime(TowerDefenseConfig.SyaryTotoleTime);
		data.value = -TowerDefenseConfig.SyaryFireEffectnum;
		data.isEnd = true;
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(e);
		if (null != sprayEffect)
		{
			sprayEffect.Stop();
		}
		for (int j = 0; j < sprayEffectList.Count; j++)
		{
			sprayEffectList.get_Item(j).Stop();
		}
		sprayEffectList.Clear();
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

	public override bool GridSatisItem_CanUse(TowerDefenseMapData.TowerGrid grid)
	{
		if (grid.IsNull)
		{
			return false;
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
