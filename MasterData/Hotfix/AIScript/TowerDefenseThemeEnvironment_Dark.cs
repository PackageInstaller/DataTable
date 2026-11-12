using System.Collections.Generic;
using AIScript.Utils;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;

namespace AIScript;

public class TowerDefenseThemeEnvironment_Dark : TowerDefenseThemeEnvironmentBase
{
	private class RoleGridDarkenEntry
	{
		public int roleDataID;

		public List<int> grids;

		public FP remaining;
	}

	private class LighthouseState
	{
		public int gridIndex;

		public int x;

		public int y;

		public bool active;

		public AdventureFXPlayer fx;

		public GameObject lampObj;

		public readonly List<int> areaGrids = new List<int>();
	}

	private Dictionary<int, int> gridsIsLit = new Dictionary<int, int>();

	private Dictionary<int, int> tempLitRefCount = new Dictionary<int, int>();

	private List<int> deployGrids = new List<int>();

	private Dictionary<int, AdventureFXPlayer> sealEffects = new Dictionary<int, AdventureFXPlayer>();

	private HashSet<TowerDefenseItem_Flare.FlareEffectData> activeFlares = new HashSet<TowerDefenseItem_Flare.FlareEffectData>();

	private List<RoleGridDarkenEntry> roleGridDarkens = new List<RoleGridDarkenEntry>();

	private Dictionary<int, bool> deployGridLit = new Dictionary<int, bool>();

	private Dictionary<int, LighthouseState> lighthouses = new Dictionary<int, LighthouseState>();

	private TowerDefenseFogOfWar fog;

	private const string LAMP_PREFAB_PATH = "Assets/AssetBundles/Environment/TowerDefence/Perfab/TowerDefence_Lamp01.prefab";

	private const string FX_DEPLOY_LIGHT_UP = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_light_up_block.prefab";

	private const string FX_DEPLOY_DARK_DOWN = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_dark_down_block.prefab";

	private const string FX_SEAL_LOOP = "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_block_seal_start.prefab";

	private const string FX_SEAL_END = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_block_seal_end.prefab";

	private const string FX_LAMP_ACTIVE = "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_lamp_start.prefab";

	private const string FX_LAMP_END = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_lamp_end.prefab";

	private const string FX_LAMP_FAULT = "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_lamp_fault.prefab";

	public override void Init(ITowerDefenseGameplayHost host)
	{
		base.Init(host);
		TowerDefenseMapData mapData = host.MapData;
		fog = new TowerDefenseFogOfWar();
		fog.Init(host);
		fog.InitGrid(mapData.sizeX, mapData.sizeY, mapData.gridScale.x, mapData.gridScale.x, 0.05f, 0.05f);
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
			if (towerGrid.gridDeployType == 2)
			{
				deployGrids.Add(towerGrid.index);
			}
			if (towerGrid.gridDeployType == 6)
			{
				Vector3 position = new Vector3(towerGrid.position.x, 0f, towerGrid.position.y);
				LighthouseState lighthouseState = new LighthouseState
				{
					gridIndex = towerGrid.index,
					x = towerGrid.x,
					y = towerGrid.y,
					active = true,
					lampObj = CreateLampObject(position),
					fx = host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_loop_lamp_start.prefab", position)
				};
				lighthouses.set_Item(towerGrid.index, lighthouseState);
				LightLighthouseArea(lighthouseState);
			}
		}
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null != instance)
		{
			instance.AddEventListener("TOWERDEFENSE_ITEM_FLARE_START", RecEventFromCS_FlareStart);
			instance.AddEventListener("TOWERDEFENSE_ITEM_FLARE_END", RecEventFromCS_FlareEnd);
			instance.AddEventListener("TOWERDEFENSE_REC_GET_ITEM_GRID_INFO", RecEventFromMonster_GetItemGridInfo);
			instance.AddEventListener("TOWERDEFENSE_REC_DARKEN_ITEM_GRID", RecEventFromMonster_DarkenItemGrid);
			instance.AddEventListener("TOWERDEFENSE_REC_DARKEN_ROLE_GRID", RecEventFromMonster_DarkenRoleGrid);
			instance.AddEventListener("TOWERDEFENSE_REC_DARKEN_LIGHTHOUSE", RecEventFromMonster_DarkenLighthouse);
			instance.AddEventListener("TOWERDEFENSE_REC_DARKEN_LIGHT_SOURCES", RecEventFromMonster_DarkenLightSourcesInRange);
		}
		RefreshSealEffects();
	}

	public override void Clear()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null != instance)
		{
			instance.RemoveEventListener("TOWERDEFENSE_ITEM_FLARE_START", RecEventFromCS_FlareStart);
			instance.RemoveEventListener("TOWERDEFENSE_ITEM_FLARE_END", RecEventFromCS_FlareEnd);
			instance.RemoveEventListener("TOWERDEFENSE_REC_GET_ITEM_GRID_INFO", RecEventFromMonster_GetItemGridInfo);
			instance.RemoveEventListener("TOWERDEFENSE_REC_DARKEN_ITEM_GRID", RecEventFromMonster_DarkenItemGrid);
			instance.RemoveEventListener("TOWERDEFENSE_REC_DARKEN_ROLE_GRID", RecEventFromMonster_DarkenRoleGrid);
			instance.RemoveEventListener("TOWERDEFENSE_REC_DARKEN_LIGHTHOUSE", RecEventFromMonster_DarkenLighthouse);
			instance.RemoveEventListener("TOWERDEFENSE_REC_DARKEN_LIGHT_SOURCES", RecEventFromMonster_DarkenLightSourcesInRange);
		}
		foreach (AdventureFXPlayer value in sealEffects.Values)
		{
			if (null != value)
			{
				value.Stop();
			}
		}
		sealEffects.Clear();
		deployGrids.Clear();
		foreach (LighthouseState value2 in lighthouses.Values)
		{
			if (null != value2.fx)
			{
				value2.fx.Stop();
			}
			if (null != value2.lampObj)
			{
				Object.Destroy(value2.lampObj);
			}
		}
		lighthouses.Clear();
		fog?.Clear();
		fog = null;
		gridsIsLit?.Clear();
		tempLitRefCount?.Clear();
		activeFlares?.Clear();
		roleGridDarkens?.Clear();
		deployGridLit?.Clear();
	}

	public override bool IsGridDeployable(int gridIndex)
	{
		return IsGridLit(gridIndex);
	}

	public override void OnRolePlaced(int gridIndex)
	{
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (grid.IsNull)
		{
			return;
		}
		int deployLightRange = GetDeployLightRange(gridIndex);
		for (int i = -deployLightRange; i <= deployLightRange; i++)
		{
			for (int j = -deployLightRange; j <= deployLightRange; j++)
			{
				if (Mathf.Abs(i) + Mathf.Abs(j) <= deployLightRange)
				{
					LightPermanentGrid(grid.x + i, grid.y + j);
				}
			}
		}
		RefreshSealEffects();
	}

	private int GetDeployLightRange(int gridIndex)
	{
		if (host.TryGetRoleIdByGrid(gridIndex, out var roleId))
		{
			if (!host.TryGetRoleEffectiveSearchRange(roleId, out var range))
			{
				TowerDefenseCharacter towerDefenseCharacter = Singleton<HotfixDataController>.Instance.GetTowerDefenseCharacter(roleId);
				range = ((towerDefenseCharacter != null) ? FP.FromMyriad(towerDefenseCharacter.SearchRadius) : FP.Zero);
			}
			if (range >= TowerDefenseConfig.DarkDeployLightRangeThreshold)
			{
				return TowerDefenseConfig.DarkDeployLightRangeFar;
			}
		}
		return TowerDefenseConfig.DarkDeployLightRangeNear;
	}

	private void RecEventFromCS_FlareStart(IEvent ievent)
	{
		if (ievent == null || !(((GeneralEvent)ievent).data is TowerDefenseItem_Flare.FlareEffectData flareEffectData))
		{
			return;
		}
		if (flareEffectData.isLighthouse)
		{
			ReactivateLighthouse(flareEffectData.targetGridIndex);
		}
		if (flareEffectData.litGrids != null)
		{
			for (int i = 0; i < flareEffectData.litGrids.Count; i++)
			{
				int num = flareEffectData.litGrids.get_Item(i);
				if (host.TryGetRoleIdByGrid(num, out var roleId))
				{
					LightTempGrid(num);
					flareEffectData.tempLitGrids.Add(num);
					CancelRoleGridDarkenByRoleId(roleId);
				}
				else
				{
					LightTempGrid(num);
					flareEffectData.tempLitGrids.Add(num);
				}
			}
		}
		activeFlares.Add(flareEffectData);
		RefreshSealEffects();
	}

	private void RecEventFromCS_FlareEnd(IEvent ievent)
	{
		if (ievent != null && ((GeneralEvent)ievent).data is TowerDefenseItem_Flare.FlareEffectData data)
		{
			ExtinguishFlare(data);
		}
	}

	private void ExtinguishFlare(TowerDefenseItem_Flare.FlareEffectData data)
	{
		if (data == null || !activeFlares.Remove(data))
		{
			return;
		}
		data.forceEnded = true;
		if (data.tempLitGrids != null)
		{
			for (int i = 0; i < data.tempLitGrids.Count; i++)
			{
				DarkenTempGrid(data.tempLitGrids.get_Item(i));
			}
		}
		RefreshSealEffects();
	}

	private void RecEventFromMonster_GetItemGridInfo(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		GeneralEvent generalEvent = (GeneralEvent)ievent;
		List<GridInfoData> list = new List<GridInfoData>();
		foreach (TowerDefenseItem_Flare.FlareEffectData activeFlare in activeFlares)
		{
			TowerDefenseMapData.TowerGrid grid = host.GetGrid(activeFlare.targetGridIndex);
			if (!grid.IsNull)
			{
				list.Add(new GridInfoData(grid.index, isSprayed: false, isOnFire: false, 0, new TSVector2(grid.position.x, grid.position.y)));
			}
		}
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_DIS_GET_ITEM_GRID_INFO", generalEvent.sender, list);
	}

	private void RecEventFromMonster_DarkenItemGrid(IEvent ievent)
	{
		if (ievent == null || !CommonUtils.TryParseStringParamToInt(((GeneralEvent)ievent).data.ToString(), out var intValue))
		{
			return;
		}
		List<TowerDefenseItem_Flare.FlareEffectData> list = null;
		foreach (TowerDefenseItem_Flare.FlareEffectData activeFlare in activeFlares)
		{
			if (activeFlare.targetGridIndex == intValue && !activeFlare.invincible)
			{
				if (list == null)
				{
					list = new List<TowerDefenseItem_Flare.FlareEffectData>();
				}
				list.Add(activeFlare);
			}
		}
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				ExtinguishFlare(list.get_Item(i));
			}
		}
	}

	private void RecEventFromMonster_DarkenRoleGrid(IEvent ievent)
	{
		if (ievent != null && CommonUtils.TryParseStringParamToInt(((GeneralEvent)ievent).data.ToString(), out var intValue))
		{
			DarkenRoleGridByDataId(intValue);
		}
	}

	private void DarkenRoleGridByDataId(int roleDataID)
	{
		if (!host.TryGetGridIndexByRoleId(roleDataID, out var gridIndex))
		{
			return;
		}
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (grid.IsNull)
		{
			return;
		}
		if (IsGridProtectedByHigherPriority(grid.index))
		{
			if (!CancelRoleGridDarkenByRoleId(roleDataID))
			{
				host.RemoveRoleBuff(roleDataID, TowerDefenseConfig.buffId_RoleDarken);
			}
			RefreshSealEffects();
			return;
		}
		int deployLightRange = GetDeployLightRange(gridIndex);
		RoleGridDarkenEntry roleGridDarkenEntry = null;
		for (int i = 0; i < roleGridDarkens.Count; i++)
		{
			if (roleGridDarkens.get_Item(i).roleDataID == roleDataID)
			{
				roleGridDarkenEntry = roleGridDarkens.get_Item(i);
				break;
			}
		}
		List<int> list = roleGridDarkenEntry?.grids ?? new List<int>();
		for (int j = -deployLightRange; j <= deployLightRange; j++)
		{
			for (int k = -deployLightRange; k <= deployLightRange; k++)
			{
				if (Mathf.Abs(j) + Mathf.Abs(k) <= deployLightRange)
				{
					TowerDefenseMapData.TowerGrid grid2 = host.MapData.GetGrid(grid.x + j, grid.y + k);
					if (!grid2.IsNull && !list.Contains(grid2.index) && !IsGridProtectedByHigherPriority(grid2.index) && DarkenPermanentGrid(grid.x + j, grid.y + k, out var gridIndex2))
					{
						list.Add(gridIndex2);
					}
				}
			}
		}
		if (roleGridDarkenEntry != null)
		{
			roleGridDarkenEntry.remaining = TowerDefenseConfig.DarkRoleGridDarkenDuration;
		}
		else if (list.Count > 0)
		{
			roleGridDarkens.Add(new RoleGridDarkenEntry
			{
				roleDataID = roleDataID,
				grids = list,
				remaining = TowerDefenseConfig.DarkRoleGridDarkenDuration
			});
		}
		RefreshSealEffects();
	}

	private void RecEventFromMonster_DarkenLighthouse(IEvent ievent)
	{
		if (ievent != null && CommonUtils.TryParseStringParamToInt(((GeneralEvent)ievent).data.ToString(), out var intValue))
		{
			ExtinguishLighthouse(intValue);
		}
	}

	private void RecEventFromMonster_DarkenLightSourcesInRange(IEvent ievent)
	{
		if (ievent == null || !(((GeneralEvent)ievent).data is GridQueryParam { center: var center, range: var range }))
		{
			return;
		}
		foreach (LighthouseState value in lighthouses.Values)
		{
			if (value.active)
			{
				TowerDefenseMapData.TowerGrid grid = host.GetGrid(value.gridIndex);
				if (!grid.IsNull && !(TSVector2.Distance(center, new TSVector2(grid.position.x, grid.position.y)) > range))
				{
					ExtinguishLighthouse(value.gridIndex);
				}
			}
		}
		List<TowerDefenseItem_Flare.FlareEffectData> list = null;
		foreach (TowerDefenseItem_Flare.FlareEffectData activeFlare in activeFlares)
		{
			TowerDefenseMapData.TowerGrid grid2 = host.GetGrid(activeFlare.targetGridIndex);
			if (!grid2.IsNull && !(TSVector2.Distance(center, new TSVector2(grid2.position.x, grid2.position.y)) > range))
			{
				if (list == null)
				{
					list = new List<TowerDefenseItem_Flare.FlareEffectData>();
				}
				list.Add(activeFlare);
			}
		}
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				ExtinguishFlare(list.get_Item(i));
			}
		}
		for (int j = 0; j < deployGrids.Count; j++)
		{
			int num = deployGrids.get_Item(j);
			if (host.TryGetRoleIdByGrid(num, out var roleId))
			{
				TowerDefenseMapData.TowerGrid grid3 = host.GetGrid(num);
				if (!grid3.IsNull && !(TSVector2.Distance(center, new TSVector2(grid3.position.x, grid3.position.y)) > range))
				{
					DarkenRoleGridByDataId(roleId);
				}
			}
		}
	}

	public override void OnUpdate()
	{
		bool flag = false;
		for (int num = roleGridDarkens.Count - 1; num >= 0; num--)
		{
			RoleGridDarkenEntry roleGridDarkenEntry = roleGridDarkens.get_Item(num);
			roleGridDarkenEntry.remaining -= LockStepManager.deltaTime;
			if (!(roleGridDarkenEntry.remaining > 0))
			{
				RestoreRoleGridDarken(roleGridDarkenEntry);
				roleGridDarkens.RemoveAt(num);
				flag = true;
			}
		}
		if (flag)
		{
			RefreshSealEffects();
		}
	}

	private void RestoreRoleGridDarken(RoleGridDarkenEntry entry)
	{
		for (int i = 0; i < entry.grids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid grid = host.GetGrid(entry.grids.get_Item(i));
			if (!grid.IsNull)
			{
				LightPermanentGrid(grid.x, grid.y);
			}
		}
		host.RemoveRoleBuff(entry.roleDataID, TowerDefenseConfig.buffId_RoleDarken);
	}

	private bool CancelRoleGridDarkenByRoleId(int roleDataID)
	{
		for (int i = 0; i < roleGridDarkens.Count; i++)
		{
			if (roleGridDarkens.get_Item(i).roleDataID == roleDataID)
			{
				RestoreRoleGridDarken(roleGridDarkens.get_Item(i));
				roleGridDarkens.RemoveAt(i);
				return true;
			}
		}
		return false;
	}

	private void LightLighthouseArea(LighthouseState state)
	{
		if (state.areaGrids.Count == 0)
		{
			CollectLighthouseAreaGrids(state.x, state.y, state.areaGrids);
		}
		for (int i = 0; i < state.areaGrids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid grid = host.GetGrid(state.areaGrids.get_Item(i));
			if (!grid.IsNull)
			{
				LightPermanentGrid(grid.x, grid.y);
			}
		}
	}

	private void CollectLighthouseAreaGrids(int x, int y, List<int> outGrids)
	{
		outGrids.Clear();
		for (int i = -1; i <= 1; i++)
		{
			for (int j = -1; j <= 1; j++)
			{
				TowerDefenseMapData.TowerGrid grid = host.MapData.GetGrid(x + i, y + j);
				if (!grid.IsNull)
				{
					outGrids.Add(grid.index);
				}
			}
		}
	}

	private void LightPermanentGrid(int x, int y)
	{
		TowerDefenseMapData.TowerGrid grid = host.MapData.GetGrid(x, y);
		if (!grid.IsNull)
		{
			gridsIsLit.TryGetValue(grid.index, out var value);
			gridsIsLit.set_Item(grid.index, value + 1);
			if (value == 0)
			{
				fog.SetGridLit(x, y, lit: true);
			}
		}
	}

	private bool DarkenPermanentGrid(int x, int y, out int gridIndex)
	{
		gridIndex = -1;
		TowerDefenseMapData.TowerGrid grid = host.MapData.GetGrid(x, y);
		if (grid.IsNull)
		{
			return false;
		}
		if (!gridsIsLit.TryGetValue(grid.index, out var value) || value <= 0)
		{
			return false;
		}
		value--;
		gridIndex = grid.index;
		if (value > 0)
		{
			gridsIsLit.set_Item(grid.index, value);
			return true;
		}
		gridsIsLit.Remove(grid.index);
		if (!IsGridLit(grid.index))
		{
			fog.SetGridLit(x, y, lit: false);
		}
		return true;
	}

	private void LightTempGrid(int gridIndex)
	{
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (!grid.IsNull)
		{
			tempLitRefCount.TryGetValue(gridIndex, out var value);
			tempLitRefCount.set_Item(gridIndex, value + 1);
			if (value == 0 && !IsPermanentLit(gridIndex))
			{
				fog.SetGridLit(grid.x, grid.y, lit: true);
			}
		}
	}

	private void DarkenTempGrid(int gridIndex)
	{
		if (!tempLitRefCount.TryGetValue(gridIndex, out var value))
		{
			return;
		}
		value--;
		if (value > 0)
		{
			tempLitRefCount.set_Item(gridIndex, value);
			return;
		}
		tempLitRefCount.Remove(gridIndex);
		if (!IsPermanentLit(gridIndex))
		{
			TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
			if (!grid.IsNull)
			{
				fog.SetGridLit(grid.x, grid.y, lit: false);
			}
		}
	}

	private void ExtinguishFlaresTargeting(int gridIndex)
	{
		List<TowerDefenseItem_Flare.FlareEffectData> list = null;
		foreach (TowerDefenseItem_Flare.FlareEffectData activeFlare in activeFlares)
		{
			if (activeFlare.targetGridIndex == gridIndex)
			{
				if (list == null)
				{
					list = new List<TowerDefenseItem_Flare.FlareEffectData>();
				}
				list.Add(activeFlare);
			}
		}
		if (list != null)
		{
			for (int i = 0; i < list.Count; i++)
			{
				ExtinguishFlare(list.get_Item(i));
			}
		}
	}

	private void ForceClearTempLit(int gridIndex)
	{
		if (tempLitRefCount.Remove(gridIndex) && !IsPermanentLit(gridIndex))
		{
			TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
			if (!grid.IsNull)
			{
				fog.SetGridLit(grid.x, grid.y, lit: false);
			}
		}
	}

	private bool IsPermanentLit(int gridIndex)
	{
		if (gridsIsLit.TryGetValue(gridIndex, out var value))
		{
			return value > 0;
		}
		return false;
	}

	public override bool IsGridLit(int gridIndex)
	{
		if (gridsIsLit.TryGetValue(gridIndex, out var value) && value > 0)
		{
			return true;
		}
		if (tempLitRefCount.TryGetValue(gridIndex, out var value2))
		{
			return value2 > 0;
		}
		return false;
	}

	private bool IsGridLitByActiveLighthouse(int gridIndex)
	{
		foreach (LighthouseState value in lighthouses.Values)
		{
			if (value.active && value.areaGrids.Contains(gridIndex))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsGridLitByActiveFlare(int gridIndex)
	{
		foreach (TowerDefenseItem_Flare.FlareEffectData activeFlare in activeFlares)
		{
			if (activeFlare.litGrids != null && activeFlare.litGrids.Contains(gridIndex))
			{
				return true;
			}
		}
		return false;
	}

	private bool IsGridProtectedByHigherPriority(int gridIndex)
	{
		if (!IsGridLitByActiveLighthouse(gridIndex))
		{
			return IsGridLitByActiveFlare(gridIndex);
		}
		return true;
	}

	public void SetLighthouseActive(int gridIndex, bool active)
	{
		if (active)
		{
			ReactivateLighthouse(gridIndex);
		}
		else
		{
			ExtinguishLighthouse(gridIndex, playTransition: false);
		}
	}

	private void ExtinguishLighthouse(int gridIndex, bool playTransition = true)
	{
		if (!lighthouses.TryGetValue(gridIndex, out var value) || !value.active)
		{
			return;
		}
		Vector3 gridPosition = GetGridPosition(gridIndex);
		if (null != value.fx)
		{
			value.fx.Stop();
		}
		if (playTransition)
		{
			host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_base_lamp_end.prefab", gridPosition);
		}
		value.fx = host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_loop_lamp_fault.prefab", gridPosition);
		value.active = false;
		for (int i = 0; i < value.areaGrids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid grid = host.GetGrid(value.areaGrids.get_Item(i));
			if (!grid.IsNull)
			{
				DarkenPermanentGrid(grid.x, grid.y, out var _);
			}
		}
		RefreshSealEffects();
	}

	private void ReactivateLighthouse(int gridIndex)
	{
		if (lighthouses.TryGetValue(gridIndex, out var value) && !value.active)
		{
			Vector3 gridPosition = GetGridPosition(gridIndex);
			if (null != value.fx)
			{
				value.fx.Stop();
			}
			value.fx = host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_loop_lamp_start.prefab", gridPosition);
			value.active = true;
			LightLighthouseArea(value);
			LiftRoleDarkenInLighthouseArea(value);
			RefreshSealEffects();
		}
	}

	private void LiftRoleDarkenInLighthouseArea(LighthouseState state)
	{
		for (int num = roleGridDarkens.Count - 1; num >= 0; num--)
		{
			RoleGridDarkenEntry roleGridDarkenEntry = roleGridDarkens.get_Item(num);
			if (host.TryGetGridIndexByRoleId(roleGridDarkenEntry.roleDataID, out var gridIndex) && state.areaGrids.Contains(gridIndex))
			{
				RestoreRoleGridDarken(roleGridDarkenEntry);
				roleGridDarkens.RemoveAt(num);
			}
		}
	}

	private Vector3 GetGridPosition(int gridIndex)
	{
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (grid.IsNull)
		{
			return Vector3.zero;
		}
		return new Vector3(grid.position.x, 0f, grid.position.y);
	}

	public void GM_ToggleGridDarkAttri(int gridIndex)
	{
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (grid.IsNull)
		{
			return;
		}
		bool flag = IsGridLit(gridIndex);
		if (flag)
		{
			ExtinguishFlaresTargeting(gridIndex);
		}
		switch ((GridDeployType)grid.gridDeployType)
		{
		case GridDeployType.LighterTower:
		{
			SetLighthouseActive(gridIndex, !flag);
			if (!flag)
			{
				break;
			}
			if (lighthouses.TryGetValue(gridIndex, out var value))
			{
				for (int i = 0; i < value.areaGrids.Count; i++)
				{
					ForceClearTempLit(value.areaGrids.get_Item(i));
				}
			}
			RefreshSealEffects();
			break;
		}
		case GridDeployType.PlayerSpawnPoint:
			if (flag)
			{
				DarkenDeployArea(gridIndex);
			}
			else
			{
				LightDeployArea(gridIndex);
			}
			break;
		default:
			if (flag)
			{
				DarkenPermanentGrid(grid.x, grid.y, out var _);
				ForceClearTempLit(gridIndex);
			}
			else
			{
				LightPermanentGrid(grid.x, grid.y);
			}
			RefreshSealEffects();
			break;
		}
	}

	private void LightDeployArea(int gridIndex)
	{
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (grid.IsNull)
		{
			return;
		}
		if (!host.TryGetRoleIdByGrid(gridIndex, out var _))
		{
			LightPermanentGrid(grid.x, grid.y);
			RefreshSealEffects();
			return;
		}
		int deployLightRange = GetDeployLightRange(gridIndex);
		for (int i = -deployLightRange; i <= deployLightRange; i++)
		{
			for (int j = -deployLightRange; j <= deployLightRange; j++)
			{
				if (Mathf.Abs(i) + Mathf.Abs(j) <= deployLightRange)
				{
					LightPermanentGrid(grid.x + i, grid.y + j);
				}
			}
		}
		RefreshSealEffects();
	}

	private void DarkenDeployArea(int gridIndex)
	{
		TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
		if (grid.IsNull)
		{
			return;
		}
		if (!host.TryGetRoleIdByGrid(gridIndex, out var roleId))
		{
			DarkenPermanentGrid(grid.x, grid.y, out roleId);
			ForceClearTempLit(gridIndex);
			RefreshSealEffects();
			return;
		}
		int deployLightRange = GetDeployLightRange(gridIndex);
		for (int i = -deployLightRange; i <= deployLightRange; i++)
		{
			for (int j = -deployLightRange; j <= deployLightRange; j++)
			{
				if (Mathf.Abs(i) + Mathf.Abs(j) <= deployLightRange)
				{
					DarkenPermanentGrid(grid.x + i, grid.y + j, out roleId);
					TowerDefenseMapData.TowerGrid grid2 = host.MapData.GetGrid(grid.x + i, grid.y + j);
					if (!grid2.IsNull)
					{
						ForceClearTempLit(grid2.index);
					}
				}
			}
		}
		RefreshSealEffects();
	}

	private GameObject CreateLampObject(Vector3 position)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/Environment/TowerDefence/Perfab/TowerDefence_Lamp01.prefab", typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("灯塔预制体为空:Assets/AssetBundles/Environment/TowerDefence/Perfab/TowerDefence_Lamp01.prefab");
			return null;
		}
		GameObject gameObject2 = Object.Instantiate(gameObject);
		gameObject2.transform.position = position;
		return gameObject2;
	}

	private void RefreshSealEffects()
	{
		for (int i = 0; i < deployGrids.Count; i++)
		{
			int num = deployGrids.get_Item(i);
			bool flag = IsGridLit(num);
			if (!deployGridLit.TryGetValue(num, out var value))
			{
				if (flag)
				{
					RemoveSealEffect(num);
				}
				else
				{
					ShowSealEffect(num);
				}
				deployGridLit.set_Item(num, flag);
			}
			else if (value != flag)
			{
				Vector3 gridPosition = GetGridPosition(num);
				if (flag)
				{
					RemoveSealEffect(num);
					host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_base_block_seal_end.prefab", gridPosition);
					host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_base_light_up_block.prefab", gridPosition);
				}
				else
				{
					ShowSealEffect(num);
					host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_base_dark_down_block.prefab", gridPosition);
				}
				deployGridLit.set_Item(num, flag);
			}
		}
	}

	private void ShowSealEffect(int gridIndex)
	{
		if (!sealEffects.ContainsKey(gridIndex))
		{
			TowerDefenseMapData.TowerGrid grid = host.GetGrid(gridIndex);
			if (!grid.IsNull)
			{
				AdventureFXPlayer value = host.PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_loop_block_seal_start.prefab", new Vector3(grid.position.x, 0f, grid.position.y));
				sealEffects.Add(gridIndex, value);
			}
		}
	}

	private void RemoveSealEffect(int gridIndex)
	{
		if (sealEffects.TryGetValue(gridIndex, out var value))
		{
			if (null != value)
			{
				value.Stop();
			}
			sealEffects.Remove(gridIndex);
		}
	}
}
