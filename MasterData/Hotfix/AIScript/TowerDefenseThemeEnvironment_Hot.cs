using System.Collections.Generic;
using AIScript.Utils;
using TrueSync;
using UnityEngine;

namespace AIScript;

public class TowerDefenseThemeEnvironment_Hot : TowerDefenseThemeEnvironmentBase
{
	private const string FIRE_SCREEN_EFFECT = "Assets/AssetBundles/FX/ScreenEffect/fx_screen_hot.prefab";

	private const string FIRE_GRID_EFFECT = "Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_loop_fire.prefab";

	private const string REMOVE_FIRE_GRID_EFFECT = "Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_base_fireend.prefab";

	private const string CREATE_FIRE_GRID_END_EFFECT = "Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_base_start_end.prefab";

	private Dictionary<int, FP> tmpGridFireEffectCount = new Dictionary<int, FP>();

	private Dictionary<int, GridAttributeType> tmpGridAttributeTypes = new Dictionary<int, GridAttributeType>();

	private Dictionary<int, int> sprayTakeEffectGrids = new Dictionary<int, int>();

	private AdventureFXPlayer fireFullScreenEffect;

	private Dictionary<int, AdventureFXPlayer> fireGridEffectDic;

	private List<AdventureFXPlayer> removeFireGridEffects;

	private List<AdventureFXPlayer> fireStartEndEffects;

	private FP DefaultGridFireEffectNum => TowerDefenseConfig.DefaultGridFireEffectNum;

	private FP FireGridFireEffectNum => TowerDefenseConfig.FireGridFireEffectNum;

	public override void Init(ITowerDefenseGameplayHost host)
	{
		base.Init(host);
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null != instance)
		{
			instance.AddEventListener("TOWERDEFENSE_REC_CREATE_FIRE", RecEventFromCS_CreateFireGrid);
			instance.AddEventListener("TOWERDEFENSE_ITEM_SPRAY_EFFECT_START", RecEventFromCS_StartItemSprayEffectCallback);
			instance.AddEventListener("TOWERDEFENSE_ITEM_SPRAY_EFFECT", RecEventFromCS_ItemSprayEffectCallback);
		}
	}

	public override void SeedGrid(TowerDefenseMapData.TowerGrid grid)
	{
		UpdateFireGrid(grid.index, (GridAttributeType)grid.gridAttribute);
	}

	public override void OnStart()
	{
		PlayFireFullScreenEffect();
	}

	public override void Clear()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null != instance)
		{
			instance.RemoveEventListener("TOWERDEFENSE_REC_CREATE_FIRE", RecEventFromCS_CreateFireGrid);
			instance.RemoveEventListener("TOWERDEFENSE_ITEM_SPRAY_EFFECT_START", RecEventFromCS_StartItemSprayEffectCallback);
			instance.RemoveEventListener("TOWERDEFENSE_ITEM_SPRAY_EFFECT", RecEventFromCS_ItemSprayEffectCallback);
		}
		if (null != fireFullScreenEffect)
		{
			fireFullScreenEffect.Stop();
			fireFullScreenEffect = null;
		}
		if (fireGridEffectDic != null)
		{
			foreach (AdventureFXPlayer value in fireGridEffectDic.Values)
			{
				if (null != value)
				{
					value.Stop();
				}
			}
			fireGridEffectDic.Clear();
			fireGridEffectDic = null;
		}
		if (removeFireGridEffects != null)
		{
			for (int i = 0; i < removeFireGridEffects.Count; i++)
			{
				AdventureFXPlayer adventureFXPlayer = removeFireGridEffects.get_Item(i);
				if (null != adventureFXPlayer && adventureFXPlayer.isPlaying)
				{
					adventureFXPlayer.Stop();
				}
			}
			removeFireGridEffects.Clear();
			removeFireGridEffects = null;
		}
		if (fireStartEndEffects != null)
		{
			for (int j = 0; j < fireStartEndEffects.Count; j++)
			{
				AdventureFXPlayer adventureFXPlayer2 = fireStartEndEffects.get_Item(j);
				if (null != adventureFXPlayer2 && adventureFXPlayer2.isPlaying)
				{
					adventureFXPlayer2.Stop();
				}
			}
			fireStartEndEffects.Clear();
			fireStartEndEffects = null;
		}
		tmpGridFireEffectCount?.Clear();
		tmpGridAttributeTypes?.Clear();
		sprayTakeEffectGrids?.Clear();
	}

	public override void OnRolePlaced(int gridIndex)
	{
		UpdateTokenGridFireEffectCount(gridIndex);
		if (sprayTakeEffectGrids != null && sprayTakeEffectGrids.TryGetValue(gridIndex, out var value) && value > 0 && host.TryGetRoleIdByGrid(gridIndex, out var roleId))
		{
			GeneralEvent generalEvent = new GeneralEvent("TOWERDEFENSE_SPRAY_UPDATE_ROLE_FIRE_COUNT");
			generalEvent.sender = roleId.ToString();
			generalEvent.data = (TowerDefenseConfig.SyaryFireEffectnum * value).ToString();
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(generalEvent);
		}
	}

	public override bool IsGridSprayed(int gridIndex)
	{
		if (sprayTakeEffectGrids != null)
		{
			return sprayTakeEffectGrids.ContainsKey(gridIndex);
		}
		return false;
	}

	public override bool IsGridOnFire(int gridIndex)
	{
		if (tmpGridAttributeTypes != null && tmpGridAttributeTypes.TryGetValue(gridIndex, out var value))
		{
			return value == GridAttributeType.Fire;
		}
		return false;
	}

	private void RecEventFromCS_CreateFireGrid(IEvent ievent)
	{
		if (ievent != null && CommonUtils.TryParseStringParamToInt(((GeneralEvent)ievent).data.ToString(), out var intValue) && !host.GetGrid(intValue).IsNull)
		{
			if (sprayTakeEffectGrids.TryGetValue(intValue, out var value) && value > 0)
			{
				PlayFireStartEndEffect(intValue);
			}
			else
			{
				UpdateFireGrid(intValue, GridAttributeType.Fire);
			}
		}
	}

	private void RecEventFromCS_StartItemSprayEffectCallback(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		TowerDefenseItem_Spray.SprayEffectData sprayEffectData = (TowerDefenseItem_Spray.SprayEffectData)((GeneralEvent)ievent).data;
		if (sprayEffectData == null)
		{
			return;
		}
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(new Vector3((float)sprayEffectData.position.x, 0f, (float)sprayEffectData.position.y));
		if (grid.IsNull)
		{
			return;
		}
		List<int> itemTakeEffectGrids = host.GetItemTakeEffectGrids(grid.index);
		if (itemTakeEffectGrids == null || itemTakeEffectGrids.Count == 0)
		{
			return;
		}
		for (int i = 0; i < itemTakeEffectGrids.Count; i++)
		{
			int num = itemTakeEffectGrids.get_Item(i);
			UpdateFireGrid(num, GridAttributeType.Default);
			if (!sprayTakeEffectGrids.TryGetValue(num, out var value))
			{
				sprayTakeEffectGrids.Add(num, 1);
			}
			sprayTakeEffectGrids.set_Item(num, value + 1);
		}
	}

	private void RecEventFromCS_ItemSprayEffectCallback(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		TowerDefenseItem_Spray.SprayEffectData sprayEffectData = (TowerDefenseItem_Spray.SprayEffectData)((GeneralEvent)ievent).data;
		if (sprayEffectData == null)
		{
			return;
		}
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(new Vector3((float)sprayEffectData.position.x, 0f, (float)sprayEffectData.position.y));
		if (grid.IsNull)
		{
			return;
		}
		List<int> itemTakeEffectGrids = host.GetItemTakeEffectGrids(grid.index);
		if (itemTakeEffectGrids == null || itemTakeEffectGrids.Count == 0)
		{
			return;
		}
		GeneralEvent generalEvent = new GeneralEvent("TOWERDEFENSE_SPRAY_UPDATE_ROLE_FIRE_COUNT");
		for (int i = 0; i < itemTakeEffectGrids.Count; i++)
		{
			int gridIndex = itemTakeEffectGrids.get_Item(i);
			if (host.TryGetRoleIdByGrid(gridIndex, out var roleId))
			{
				generalEvent.sender = roleId.ToString();
				generalEvent.data = sprayEffectData.value.ToString();
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(generalEvent);
			}
		}
		if (!sprayEffectData.isEnd)
		{
			return;
		}
		for (int j = 0; j < itemTakeEffectGrids.Count; j++)
		{
			int key = itemTakeEffectGrids.get_Item(j);
			if (sprayTakeEffectGrids.TryGetValue(key, out var value))
			{
				value--;
				if (value == 0)
				{
					sprayTakeEffectGrids.Remove(key);
				}
				else
				{
					sprayTakeEffectGrids.set_Item(key, value);
				}
			}
		}
	}

	private void UpdateFireGrid(int gridIndex, GridAttributeType newType)
	{
		if (tmpGridAttributeTypes.TryGetValue(gridIndex, out var value))
		{
			if (value != newType)
			{
				tmpGridAttributeTypes.set_Item(gridIndex, newType);
				if (newType == GridAttributeType.Default)
				{
					RemoveGridFireEffect(gridIndex, FireGridFireEffectNum - DefaultGridFireEffectNum);
					RemoveFireEffect(gridIndex);
				}
				else
				{
					AddGridFireEffect(gridIndex, FireGridFireEffectNum - DefaultGridFireEffectNum);
					CreateFireEffect(gridIndex);
				}
			}
		}
		else
		{
			tmpGridAttributeTypes.Add(gridIndex, newType);
			if (newType == GridAttributeType.Fire)
			{
				AddGridFireEffect(gridIndex, FireGridFireEffectNum);
				CreateFireEffect(gridIndex);
			}
			else
			{
				AddGridFireEffect(gridIndex, DefaultGridFireEffectNum);
			}
		}
	}

	private void AddGridFireEffect(int gridIndex, FP count)
	{
		if (!tmpGridFireEffectCount.TryGetValue(gridIndex, out var value))
		{
			tmpGridFireEffectCount.Add(gridIndex, count);
		}
		else
		{
			value += count;
			tmpGridFireEffectCount.set_Item(gridIndex, value);
		}
		UpdateTokenGridFireEffectCount(gridIndex, value);
	}

	private void RemoveGridFireEffect(int gridIndex, FP count)
	{
		if (tmpGridFireEffectCount.TryGetValue(gridIndex, out var value))
		{
			value -= count;
			if (value < 0)
			{
				value = 0;
			}
			tmpGridFireEffectCount.set_Item(gridIndex, value);
			UpdateTokenGridFireEffectCount(gridIndex, value);
		}
	}

	private void UpdateTokenGridFireEffectCount(int gridIndex)
	{
		if (tmpGridFireEffectCount.TryGetValue(gridIndex, out var value))
		{
			UpdateTokenGridFireEffectCount(gridIndex, value);
		}
	}

	private void UpdateTokenGridFireEffectCount(int gridIndex, FP value)
	{
		if (host.TryGetRoleIdByGrid(gridIndex, out var roleId))
		{
			GeneralEventWithReturnData generalEventWithReturnData = new GeneralEventWithReturnData("TOWERDEFENSE_UPDATE_GRID_FIRE_COUNT");
			generalEventWithReturnData.sender = roleId.ToString();
			generalEventWithReturnData.data = value.ToString();
			if (tmpGridAttributeTypes.TryGetValue(gridIndex, out var value2))
			{
				generalEventWithReturnData.returnInt = (int)value2;
			}
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(generalEventWithReturnData);
		}
	}

	private void CreateFireEffect(int index)
	{
		PlayFireGridEffect(index);
	}

	private void RemoveFireEffect(int index)
	{
		RemoveFireGridEffect(index);
	}

	private void PlayFireFullScreenEffect()
	{
		fireFullScreenEffect = host.PlayEffect("Assets/AssetBundles/FX/ScreenEffect/fx_screen_hot.prefab", Vector3.zero);
	}

	private void PlayFireGridEffect(int gridIndex)
	{
		if (fireGridEffectDic == null)
		{
			fireGridEffectDic = new Dictionary<int, AdventureFXPlayer>();
		}
		if (fireGridEffectDic.TryGetValue(gridIndex, out var value))
		{
			value.Play();
			return;
		}
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (!grid.IsNull)
		{
			value = host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_loop_fire.prefab", new Vector3(grid.position.x, 0f, grid.position.y));
			fireGridEffectDic.Add(gridIndex, value);
		}
	}

	private void RemoveFireGridEffect(int gridIndex)
	{
		if (fireGridEffectDic.TryGetValue(gridIndex, out var value))
		{
			value.Stop();
			fireGridEffectDic.Remove(gridIndex);
		}
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (!grid.IsNull)
		{
			if (removeFireGridEffects == null)
			{
				removeFireGridEffects = new List<AdventureFXPlayer>();
			}
			removeFireGridEffects.Add(host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_base_fireend.prefab", new Vector3(grid.position.x, 0f, grid.position.y)));
		}
	}

	private void PlayFireStartEndEffect(int gridIndex)
	{
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (!grid.IsNull)
		{
			if (fireStartEndEffects == null)
			{
				fireStartEndEffects = new List<AdventureFXPlayer>();
			}
			fireStartEndEffects.Add(host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/Items/fx_td_item_base_start_end.prefab", new Vector3(grid.position.x, 0f, grid.position.y)));
		}
	}
}
