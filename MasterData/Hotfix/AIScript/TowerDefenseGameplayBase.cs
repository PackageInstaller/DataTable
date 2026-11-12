#define LOG_ERROR
using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.CompilerServices;
using AIScript.DynamicLevel;
using AIScript.Utils;
using Nova.Hotfix;
using TrueSync;
using UnityEngine;
using UnityEngine.Rendering.Universal;
using XLua;

namespace AIScript;

internal abstract class TowerDefenseGameplayBase : ITowerDefenseGameplayHost
{
	private enum TipQuadState
	{
		None,
		OnPointerEnter,
		OnSelect,
		OnSuitable,
		OnSetable
	}

	private enum DragState
	{
		None,
		Role,
		Item
	}

	internal enum TowerDefense_SpawnState
	{
		DeActived,
		Actived,
		Completed,
		MonsterCleard
	}

	internal class TowerDefense_SpawnActionInfo
	{
		internal TowerDefense_SpawnState state;

		internal int id;
	}

	internal class TowerDefense_MonsterSpawnGroup
	{
		internal int id;

		internal int spawnPointId;

		internal int monsterTotalNum;

		internal List<int> monsterIDs;

		internal FP refDuration;

		internal FP refRotation;

		internal int routeID;

		internal TowerDefense_SpawnState spawnState;

		private FP duration;

		private int curSpawnIndex;

		private int curSpawnCount;

		private bool cycle;

		private Action<TowerDefense_SpawnActionInfo> action;

		private Action<TowerDefense_MonsterSpawnGroup, int> fixedAction;

		private List<long> mSpawnList;

		internal TowerDefense_MonsterSpawnGroup(int id, bool cycle)
		{
			this.id = id;
			spawnPointId = 1;
			monsterTotalNum = 1;
			monsterIDs = new List<int>();
			refDuration = 1f;
			refRotation = 0;
			routeID = 1;
			spawnState = TowerDefense_SpawnState.DeActived;
			this.cycle = cycle;
		}

		internal void RegisterAction(Action<TowerDefense_SpawnActionInfo> action)
		{
			this.action = action;
		}

		internal void RegisterFixedAction(Action<TowerDefense_MonsterSpawnGroup, int> fixedAction)
		{
			this.fixedAction = fixedAction;
		}

		internal void Active()
		{
			spawnState = TowerDefense_SpawnState.Actived;
			curSpawnIndex = 0;
			duration = 0;
			Debug.Log($"怪物组:{id}已激活");
			Spawn();
		}

		internal void DeActive()
		{
			spawnState = TowerDefense_SpawnState.DeActived;
		}

		internal void Complete()
		{
			spawnState = TowerDefense_SpawnState.Completed;
			Debug.Log($"怪物组:{id}已完成");
			action?.Invoke(new TowerDefense_SpawnActionInfo
			{
				id = id,
				state = TowerDefense_SpawnState.Completed
			});
		}

		internal void UpdateLogic()
		{
			if (spawnState == TowerDefense_SpawnState.Actived)
			{
				duration += LockStepManager.deltaTime;
				if (duration >= refDuration)
				{
					duration -= refDuration;
					Spawn();
				}
			}
		}

		private void Spawn()
		{
			int iD = GetID();
			if (iD == 0)
			{
				return;
			}
			fixedAction?.Invoke(this, iD);
			if (++curSpawnCount >= monsterTotalNum)
			{
				if (cycle)
				{
					Reset();
				}
				else
				{
					Complete();
				}
			}
		}

		internal void SpawnComplete(long mID)
		{
			if (mSpawnList == null)
			{
				mSpawnList = new List<long>();
			}
			mSpawnList.Add(mID);
		}

		internal bool Contains(long mid)
		{
			if (mSpawnList == null || mSpawnList.Count == 0)
			{
				return false;
			}
			return mSpawnList.Contains(mid);
		}

		private void Reset()
		{
			curSpawnCount = 0;
			curSpawnIndex = 0;
			action?.Invoke(new TowerDefense_SpawnActionInfo
			{
				id = id,
				state = TowerDefense_SpawnState.Completed
			});
			Debug.Log($"怪物组{id}重置");
		}

		private int GetID()
		{
			if (monsterIDs.Count == 0)
			{
				Debug.LogError($"怪物ID列表为空，组ID:{id}");
				return 0;
			}
			if (curSpawnIndex >= monsterIDs.Count)
			{
				curSpawnIndex = 0;
			}
			return monsterIDs.get_Item(curSpawnIndex++);
		}

		internal void MonsterDied(long mID)
		{
			mSpawnList.Remove(mID);
			if (!cycle && mSpawnList.Count == 0 && spawnState == TowerDefense_SpawnState.Completed)
			{
				MonsterCleared();
			}
		}

		private void MonsterCleared()
		{
			spawnState = TowerDefense_SpawnState.MonsterCleard;
			action?.Invoke(new TowerDefense_SpawnActionInfo
			{
				id = id,
				state = TowerDefense_SpawnState.MonsterCleard
			});
		}

		internal void Clear()
		{
			monsterIDs?.Clear();
			monsterIDs = null;
			action = null;
			fixedAction = null;
		}
	}

	internal class TowerDefense_MonsterSpawnWave
	{
		private class SpawnActionData
		{
			internal TowerDefense_SpawnActionInfo info;

			internal Action<TowerDefense_SpawnActionInfo> action;
		}

		public int id;

		public TowerDefense_SpawnState spawnState;

		private bool cycle;

		private List<SpawnActionData> actionDatas;

		private Action<TowerDefense_MonsterSpawnWave, TowerDefense_MonsterSpawnGroup, int> fixedAction;

		public List<TowerDefense_MonsterSpawnGroup> groups { get; private set; }

		public TowerDefense_MonsterSpawnWave(int id, bool cycle)
		{
			this.id = id;
			groups = new List<TowerDefense_MonsterSpawnGroup>();
			this.cycle = cycle;
			Reset();
		}

		internal void RegisterFixedAction(Action<TowerDefense_MonsterSpawnWave, TowerDefense_MonsterSpawnGroup, int> fixedAction)
		{
			this.fixedAction = fixedAction;
		}

		internal void RegisterAction(TowerDefense_SpawnActionInfo actionInfo, Action<TowerDefense_SpawnActionInfo> action)
		{
			if (actionDatas == null)
			{
				actionDatas = new List<SpawnActionData>();
			}
			if (actionInfo.id == -1)
			{
				if (actionInfo.state == spawnState)
				{
					action?.Invoke(actionInfo);
					return;
				}
				actionDatas.Add(new SpawnActionData
				{
					info = actionInfo,
					action = action
				});
				return;
			}
			TowerDefense_MonsterSpawnGroup towerDefense_MonsterSpawnGroup = GetGroup(actionInfo.id);
			if (towerDefense_MonsterSpawnGroup == null)
			{
				Debug.LogError($"没有目标组:波次{id}_组{actionInfo.id}");
				action?.Invoke(actionInfo);
			}
			else if (towerDefense_MonsterSpawnGroup.spawnState == actionInfo.state)
			{
				action?.Invoke(actionInfo);
			}
			else
			{
				actionDatas.Add(new SpawnActionData
				{
					info = actionInfo,
					action = action
				});
			}
		}

		internal void Reset()
		{
			spawnState = TowerDefense_SpawnState.DeActived;
		}

		internal void UpdateLogic()
		{
			if (spawnState == TowerDefense_SpawnState.Actived && groups != null)
			{
				for (int i = 0; i < groups.Count; i++)
				{
					groups.get_Item(i).UpdateLogic();
				}
			}
		}

		internal void Active(int groupID = -1)
		{
			if (groupID == -1)
			{
				spawnState = TowerDefense_SpawnState.Actived;
				return;
			}
			TowerDefense_MonsterSpawnGroup towerDefense_MonsterSpawnGroup = GetGroup(groupID);
			if (towerDefense_MonsterSpawnGroup != null && towerDefense_MonsterSpawnGroup.spawnState == TowerDefense_SpawnState.DeActived)
			{
				towerDefense_MonsterSpawnGroup.RegisterFixedAction(GroupFixedActionCallback);
				towerDefense_MonsterSpawnGroup.Active();
			}
		}

		internal void Complete(int groupID = -1)
		{
			if (groupID == -1)
			{
				if (!cycle)
				{
					spawnState = TowerDefense_SpawnState.Completed;
				}
				return;
			}
			TowerDefense_MonsterSpawnGroup towerDefense_MonsterSpawnGroup = GetGroup(groupID);
			if (towerDefense_MonsterSpawnGroup != null && towerDefense_MonsterSpawnGroup.spawnState != TowerDefense_SpawnState.Completed)
			{
				towerDefense_MonsterSpawnGroup.Complete();
			}
		}

		internal void AddGroup(int groupID, int spawnPointID, int routeID, int monsterTotalNum, List<int> monsters, FP refRotation, FP refDuration)
		{
			if (groups == null)
			{
				Debug.LogError($"当前怪物波次:{id}的怪物组为空");
				return;
			}
			for (int i = 0; i < groups.Count; i++)
			{
				if (groups.get_Item(i).id == groupID)
				{
					Debug.LogError($"波次{id}中已存在目标组：{groupID}");
					return;
				}
			}
			TowerDefense_MonsterSpawnGroup towerDefense_MonsterSpawnGroup = new TowerDefense_MonsterSpawnGroup(groupID, cycle);
			towerDefense_MonsterSpawnGroup.routeID = routeID;
			towerDefense_MonsterSpawnGroup.refRotation = refRotation;
			towerDefense_MonsterSpawnGroup.monsterTotalNum = monsterTotalNum;
			towerDefense_MonsterSpawnGroup.monsterIDs.AddRange(monsters);
			towerDefense_MonsterSpawnGroup.spawnPointId = spawnPointID;
			towerDefense_MonsterSpawnGroup.refDuration = refDuration;
			towerDefense_MonsterSpawnGroup.RegisterAction(GroupStateChanged);
			groups.Add(towerDefense_MonsterSpawnGroup);
		}

		private void GroupFixedActionCallback(TowerDefense_MonsterSpawnGroup g, int monsterID)
		{
			fixedAction?.Invoke(this, g, monsterID);
		}

		internal TowerDefense_MonsterSpawnGroup GetGroup_MID(long mID)
		{
			if (groups == null)
			{
				Debug.LogError($"当前怪物波次:{id}的怪物组为空");
				return null;
			}
			for (int i = 0; i < groups.Count; i++)
			{
				TowerDefense_MonsterSpawnGroup towerDefense_MonsterSpawnGroup = groups.get_Item(i);
				if (towerDefense_MonsterSpawnGroup != null && towerDefense_MonsterSpawnGroup.Contains(mID))
				{
					return towerDefense_MonsterSpawnGroup;
				}
			}
			return null;
		}

		internal TowerDefense_MonsterSpawnGroup GetGroup(int groupID)
		{
			if (groups == null)
			{
				Debug.LogError($"当前怪物波次:{id}的怪物组为空");
				return null;
			}
			for (int i = 0; i < groups.Count; i++)
			{
				TowerDefense_MonsterSpawnGroup towerDefense_MonsterSpawnGroup = groups.get_Item(i);
				if (towerDefense_MonsterSpawnGroup != null && towerDefense_MonsterSpawnGroup.id == groupID)
				{
					return towerDefense_MonsterSpawnGroup;
				}
			}
			return null;
		}

		private void GroupStateChanged(TowerDefense_SpawnActionInfo spawnActionInfo)
		{
			TriggerAction(spawnActionInfo);
			bool flag = true;
			for (int i = 0; i < groups.Count; i++)
			{
				if (groups.get_Item(i).spawnState != spawnActionInfo.state)
				{
					flag = false;
					break;
				}
			}
			if (flag)
			{
				spawnState = spawnActionInfo.state;
				TriggerAction(new TowerDefense_SpawnActionInfo
				{
					id = -1,
					state = spawnState
				});
			}
		}

		private void TriggerAction(TowerDefense_SpawnActionInfo info)
		{
			if (actionDatas == null)
			{
				return;
			}
			for (int num = actionDatas.Count - 1; num >= 0; num--)
			{
				SpawnActionData spawnActionData = actionDatas.get_Item(num);
				if (spawnActionData.info.id == info.id && spawnActionData.info.state == info.state)
				{
					spawnActionData.action?.Invoke(spawnActionData.info);
					actionDatas.RemoveAt(num);
				}
			}
		}

		internal void Clear()
		{
			if (groups != null)
			{
				for (int i = 0; i < groups.Count; i++)
				{
					groups.get_Item(i)?.Clear();
				}
				groups.Clear();
				groups = null;
			}
		}
	}

	private class MonsterMoveInfo
	{
		public int routeID;

		public int targetGridIndex;

		public int reachedPathIndex;

		public MonsterAdventureActor actor;

		public bool dropInPothole;

		public bool finishAction = true;

		public List<int> doneActionIndexs;

		public bool HasDoneAction(int gridID)
		{
			if (doneActionIndexs == null)
			{
				return false;
			}
			return doneActionIndexs.Contains(gridID);
		}

		public void DoneAction(int gridID)
		{
			if (doneActionIndexs == null)
			{
				doneActionIndexs = new List<int>();
			}
			doneActionIndexs.Add(gridID);
		}
	}

	private List<TowerDefense_MonsterSpawnWave> normalSpawnWaves;

	private TowerDefense_MonsterSpawnWave specialSpawnWave;

	private TowerDefense_MonsterSpawnWave curActivedWave;

	private bool startLogic;

	private bool levelComplete;

	private TowerDefenseMapData mapData;

	private TowerDefensePathFinding_Hotfix pathFinder;

	private FP duration;

	private CoroutineNode coroutine;

	private FP expSpeed = 0f;

	private int teamLvTotal;

	private int totalExp;

	private FP extUpdateSpd = 0;

	private FP curExp = 0;

	private int curTeamLv;

	private int[] teamExps;

	private int curLevelUpNum;

	private FP expUpdateDuration = 0;

	private FP expUpdateSpd = 0.5f;

	private int levelDurabilityTotal;

	private int curLevelDurability;

	private int monsterNumTotal;

	private int curMonsterNum;

	private FP waitSettleTime = 2f;

	private readonly string[] levelupFxPaths = new string[3] { "Assets/AssetBundles/FX/TowerDefence/fx_td_base_high_lvup.prefab", "Assets/AssetBundles/FX/TowerDefence/fx_td_base_mid_lvup.prefab", "Assets/AssetBundles/FX/TowerDefence/fx_td_base_low_lvup.prefab" };

	private const string INDICATOR_PATH = "Assets/AssetBundles/Adventure/Indicators/TowerDefenseBlobIndicators.prefab";

	private const string MONSTER_SPAWN_POINTE_EFFECT_PATH = "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_monster_born_block.prefab";

	private const string END_POINTE_EFFECT_PATH = "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_monster_die_block.prefab";

	private const string MONSTER_MOVE_END_EFFECT_PATH = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_monster_die_light.prefab";

	private const string MONSTER_MOVE_END_EFFECT_PATH2 = "Assets/AssetBundles/FX/ScreenEffect/fx_screen_actor_hit.prefab";

	private const string ROLE_LEVEL_UP_POINT_EFFECT = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_exp_point.prefab";

	private const string DROP_IN_WATER_EFFECT = "Assets/AssetBundles/FX/TowerDefence/fx_td_base_monster_die_water.prefab";

	private TowerDefenseIndicatorController indicator;

	private Dictionary<int, int> endPoints = new Dictionary<int, int>();

	private const string EFFECT_GRASS = "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_grass.prefab";

	private Dictionary<int, AdventureFXPlayer> grasses;

	private List<TowerDefenseMapLineController> routeLines;

	private const string ROUTE_LINE_PATH = "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_line.prefab";

	private const string ROUTE_ARROW_PATH = "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_arrow.prefab";

	private const string TOWERDEFENSE_CARDOUTAREA = "TOWERDEFENSE_CARDOUTAREA";

	private const string TOWERDEFENSE_DRAG_ITEMCARD_BEGIN = "TOWERDEFENSE_DRAG_ITEMCARD_BEGIN";

	private const string TOWERDEFENSE_CHARACTER_LEVELUP = "TOWERDEFENSE_CHARACTER_LEVELUP";

	private const string TowerDefenseShowFullScreenPanel = "TowerDefenseShowFullScreenPanel";

	private const string TowerDefenseShowHideScreenPanel = "TowerDefenseShowHideScreenPanel";

	private const string TOWERDEFENSE_CARDPOINTENTER = "TOWERDEFENSE_CARDPOINTENTER";

	private const string TOWERDEFENSE_CARDPOINTEXIT = "TOWERDEFENSE_CARDPOINTEXIT";

	private const string TOWERDEFENSE_HANDLE_CONTROL_L1R1 = "TOWERDEFENSE_HANDLE_CONTROL_L1R1";

	private const string TOWERDEFENSE_HANDLE_CONTROL_L2R2 = "TOWERDEFENSE_HANDLE_CONTROL_L2R2";

	private const string TOWERDEFENSE_CANCEL_SELECT_STATE = "TOWERDEFENSE_CANCEL_SELECT_STATE";

	private const string TOWERDEFENSE_CANCEL_DRAG_STATE = "TOWERDEFENSE_CANCEL_DRAG_STATE";

	private const string TOWERDEFENSE_SELECTED_BTN = "TowerDefenseSelectedBtn";

	private const string TOWERDEFENSE_SELECTED_POTENTIAL = "TOWERDEFENSE_SELECTED_POTENTIAL";

	private const string TOWERDEFENSE_TIMESCALE_CHANGED = "TOWERDEFENSE_TIMESCALE_CHANGED";

	private const string TOWERDEFENSE_MONSTER_STATE = "TOWERDEFENSE_MONSTER_STATE";

	private const string TOWERDEFENSE_SHOW_ROLE_ICON = "TOWERDEFENSE_SHOW_ROLE_ICON";

	private const string TOWERDEFENSE_UPDATE_LEVEL_DURABILITTY = "TOWERDEFENSE_UPDATE_LEVEL_DURABILITTY";

	private const string TOWERDEFENSE_UPDATE_MONSTER_NUM = "TOWERDEFENSE_UPDATE_MONSTER_NUM";

	private const string TOWERDEFENSE_UPDATE_EXP = "TOWERDEFENSE_UPDATE_EXP";

	private const string TOWERDEFENSE_UPDATE_LEVELUP = "TOWERDEFENSE_UPDATE_LEVELUP";

	private const string TOWERDEFENSE_GIVE_A_ROLE_CARD = "TOWERDEFENSE_GIVE_A_ROLE_CARD";

	private const string TOWERDEFENSE_SET_ROLE_ON_STAGE_RESULT = "TOWERDEFENSE_SET_ROLE_ON_STAGE_RESULT";

	private const string TOWERDEFENSE_UPDATE_ITEM_CARD = "TOWERDEFENSE_UPDATE_ITEM_CARD";

	private const string TOWERDEFENSE_USE_ITEM_CARD_RESULT = "TOWERDEFENSE_USE_ITEM_CARD_RESULT";

	private const string TOWERDEFENSE_LEVEL_RESULT = "TOWERDEFENSE_LEVEL_RESULT";

	private const string TOWERDEFENSE_SHOW_MONSTER_INFO = "TOWERDEFENSE_SHOW_MONSTER_INFO";

	private const string TOWERDEFENSE_HOLDCARD = "TOWERDEFENSE_HOLDCARD";

	private const string TOWERDEFENSE_HOLDCARDCHANGE = "TOWERDEFENSE_HOLDCARDCHANGE";

	private const string TOWERDEFENSE_SHOW_TIP = "TOWERDEFENSE_SHOW_TIP";

	private const string TOWERDEFENSE_SHOW_OPERATE_UI = "TOWERDEFENSE_SHOW_OPERATE_UI";

	private const string TOWERDEFENSE_SHOW_DIC_TOPBAR = "TOWERDEFENSE_SHOW_DIC_TOPBAR";

	private const string TOWERDEFENSE_CHAR_LEVELUP = "TOWERDEFENSE_CHAR_LEVELUP";

	private const string TOWERDEFENSE_HAS_DIC = "TOWERDEFENSE_HAS_DIC";

	public const string TOWERDEFENSE_REC_GET_NEXT_GRID_INFO = "TOWERDEFENSE_REC_GET_NEXT_GRID_INFO";

	public const string TOWERDEFENSE_REC_GET_GRID_INFO_IN_CIRCLE = "TOWERDEFENSE_REC_GET_GRID_INFO_IN_CIRCLE";

	public const string TOWERDEFENSE_DIS_GET_NEXT_GRID_INFO = "TOWERDEFENSE_DIS_GET_NEXT_GRID_INFO";

	public const string TOWERDEFENSE_REC_GET_NEXT_N_GRID_INFO = "TOWERDEFENSE_REC_GET_NEXT_N_GRID_INFO";

	public const string TOWERDEFENSE_DIS_GET_NEXT_N_GRID_INFO = "TOWERDEFENSE_DIS_GET_NEXT_N_GRID_INFO";

	public const string TOWERDEFENSE_REC_CREATE_GRASS = "TOWERDEFENSE_REC_CREATE_GRASS";

	public const string TOWERDEFENSE_REC_CLEAR_GRASS = "TOWERDEFENSE_REC_CLEAR_GRASS";

	public const string TOWERDEFENSE_REC_CREATE_FIRE = "TOWERDEFENSE_REC_CREATE_FIRE";

	public const string TOWERDEFENSE_REC_GET_GRID_INFO_BY_POS = "TOWERDEFENSE_REC_GET_GRID_INFO_BY_POS";

	public const string TOWERDEFENSE_DIS_GET_GRID_INFO_BY_POS = "TOWERDEFENSE_DIS_GET_GRID_INFO_BY_POS";

	public const string TOWERDEFENSE_DIS_GET_GRID_INFO_IN_CIRCLE = "TOWERDEFENSE_DIS_GET_GRID_INFO_IN_CIRCLE";

	public const string TOWERDEFENSE_REC_IS_DARK_LEVEL = "TOWERDEFENSE_REC_IS_DARK_LEVEL";

	public const string TOWERDEFENSE_DIS_IS_DARK_LEVEL = "TOWERDEFENSE_DIS_IS_DARK_LEVEL";

	public const string TOWERDEFENSE_ITEM_SPRAY_EFFECT_START = "TOWERDEFENSE_ITEM_SPRAY_EFFECT_START";

	public const string TOWERDEFENSE_ITEM_SPRAY_EFFECT = "TOWERDEFENSE_ITEM_SPRAY_EFFECT";

	public const string TOWERDEFENSE_UPDATE_GRID_FIRE_COUNT = "TOWERDEFENSE_UPDATE_GRID_FIRE_COUNT";

	public const string TOWERDEFENSE_SPRAY_UPDATE_ROLE_FIRE_COUNT = "TOWERDEFENSE_SPRAY_UPDATE_ROLE_FIRE_COUNT";

	public const string TOWERDEFENSE_REC_DARKEN_ITEM_GRID = "TOWERDEFENSE_REC_DARKEN_ITEM_GRID";

	public const string TOWERDEFENSE_REC_DARKEN_ROLE_GRID = "TOWERDEFENSE_REC_DARKEN_ROLE_GRID";

	public const string TOWERDEFENSE_REC_GET_ITEM_GRID_INFO = "TOWERDEFENSE_REC_GET_ITEM_GRID_INFO";

	public const string TOWERDEFENSE_DIS_GET_ITEM_GRID_INFO = "TOWERDEFENSE_DIS_GET_ITEM_GRID_INFO";

	public const string TOWERDEFENSE_ITEM_FLARE_START = "TOWERDEFENSE_ITEM_FLARE_START";

	public const string TOWERDEFENSE_ITEM_FLARE_END = "TOWERDEFENSE_ITEM_FLARE_END";

	public const string TOWERDEFENSE_REC_DARKEN_LIGHTHOUSE = "TOWERDEFENSE_REC_DARKEN_LIGHTHOUSE";

	public const string TOWERDEFENSE_REC_DARKEN_LIGHT_SOURCES = "TOWERDEFENSE_REC_DARKEN_LIGHT_SOURCES";

	private int cacheRoleID;

	private int cacheRoleLevel;

	private Vector2 cachePosition;

	private bool lowSpdTimeScale;

	private const string TOWERDEFENSE_GM_GIVE_EXP = "TowerdefenseGM_AddExp";

	private const string TOWERDEFENSE_GM_GIVE_POINT = "TowerdefenseGM_AddPoint";

	private const string TOWERDEFENSE_GM_GIVE_CARD = "TowerdefenseGM_AddCharCard";

	private const string TOWERDEFENSE_GM_FAST_CD = "TowerdefenseGM_FastCD";

	private const string TOWERDEFENSE_GM_CHANGE_HP = "TowerdefenseGM_ChangeHP";

	private const string TOWERDEFENSE_GM_ADD_ITEM = "TowerdefenseGM_AddItem";

	private const string TowerdefenseGM_AddCharBuff = "TowerdefenseGM_AddCharBuff";

	private const string TowerdefenseGM_ChangeGrid = "TowerdefenseGM_ChangeGrid";

	private Dictionary<int, GridDeployType> tmpGridDeployTypes = new Dictionary<int, GridDeployType>();

	private GameObject gridPointerEventsParent;

	private List<TowerDefensePointerEvent> gridPointerEvents;

	private int selectRoleID;

	private const string TIP_QUAD_PATH = "Assets/AssetBundles/FX/TowerDefence/fx_td_block_tips.prefab";

	private List<TowerDefenseTipQuad> tipQuads;

	private GameObject tipQuadAsset;

	private GameObject tipQuadParentNode;

	private const string TIP_QUAD_STATE_ON_POINTERENTER = "pass";

	private const string TIP_QUAD_STATE_ON_SELECT = "select";

	private const string TIP_QUAD_STATE_ON_SUITABLE = "set";

	private const string TIP_QUAD_STATE_ON_SETABLE = "self";

	private List<int> markForCreateGrass = new List<int>();

	private TowerDefenseMouseFollower mouseFollower;

	private bool startDragRoleModel;

	private TowerDefenseCharacterActor dragRole;

	private int dragRoleID;

	private Camera camera;

	private LayerMask followLayer = 1;

	private float heightOffset;

	private float maxDistance = 100f;

	private float smoothness = 0.35f;

	private DragState dragState;

	private TowerDefenseMapData.TowerGrid pressupGrid;

	private int preShowPointerGridIndex = -1;

	private bool blockInput;

	private Vector3 worldPosition;

	private bool selectUIBtn;

	private TowerDefenseCharacterActor indicatorRole;

	private static Color roleOutlineColor = Color.green;

	private TowerDefenseItemBase itemTemplete;

	private int itemID;

	private int itemNum;

	private FP itemCD;

	private FP cdDuration;

	private Dictionary<long, MonsterMoveInfo> mMoveInfos;

	private Dictionary<long, int> mReachedPointIndex;

	private int mUpdateFrame = 10;

	private const int GRASS_BUFF_ID = 809001210;

	private List<int> roles;

	private int isHodingRoleCardId;

	private Dictionary<int, TowerDefenseCharacterActor> curRoles = new Dictionary<int, TowerDefenseCharacterActor>();

	private Dictionary<int, int> tokenGridIndex;

	private FP roleRotation = 180;

	private int[] levelups;

	private bool isHotLevel;

	private TowerDefenseThemeEnvironmentBase themeEnvironment;

	public TowerDefenseMapData MapData => mapData;

	private static LuaManager lua => MonoSingleton<LuaManager>.Instance;

	private FP ItemIndicatorRng
	{
		get
		{
			if (itemTemplete != null)
			{
				return itemTemplete.IndicatorRng;
			}
			return 0;
		}
	}

	private bool ItemNumLimitless => itemNum == 0;

	private int curItemNum
	{
		get
		{
			if (itemTemplete != null)
			{
				return itemTemplete.curItemNum;
			}
			return 0;
		}
	}

	public List<LogicEntity> roleList
	{
		get
		{
			if (curRoles == null)
			{
				return null;
			}
			List<LogicEntity> list = new List<LogicEntity>();
			foreach (TowerDefenseCharacterActor value in curRoles.Values)
			{
				list.Add(value);
			}
			return list;
		}
	}

	public List<LogicEntity> onStageEntities
	{
		get
		{
			if (tokenGridIndex == null)
			{
				return null;
			}
			List<LogicEntity> list = new List<LogicEntity>();
			foreach (int value2 in tokenGridIndex.Values)
			{
				if (curRoles.TryGetValue(value2, out var value))
				{
					list.Add(value);
				}
			}
			return list;
		}
	}

	internal bool IsDarkThemeLevel => themeEnvironment is TowerDefenseThemeEnvironment_Dark;

	internal abstract IEnumerator DoMainLogic();

	internal void InitMapData(TowerDefenseMapData mapData)
	{
		this.mapData = mapData;
		InitMapPathFinding();
	}

	private void InitMapPathFinding()
	{
		mapData.InitPathFinding();
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
			if (towerGrid.gridWalkableType != 0)
			{
				GridDeployType gridDeployType = (GridDeployType)towerGrid.gridDeployType;
				if (gridDeployType == GridDeployType.Pothole || gridDeployType == GridDeployType.Deephole)
				{
					mapData.SetWeight(towerGrid.x, towerGrid.y, 0);
				}
				else
				{
					mapData.SetWeight(towerGrid.x, towerGrid.y, -1);
				}
			}
		}
		List<TowerDefenseMapData.TowerDefenseRoute> routes = mapData.routes;
		pathFinder = new TowerDefensePathFinding_Hotfix(mapData.sizeX, mapData.sizeY);
		for (int j = 0; j < towerGrids.Count; j++)
		{
			TowerDefenseMapData.TowerGrid towerGrid2 = towerGrids.get_Item(j);
			if (towerGrid2.gridWalkableType == 0)
			{
				pathFinder.SetObstacle(towerGrid2.x, towerGrid2.y, isObstacle: true);
				continue;
			}
			pathFinder.SetObstacle(towerGrid2.x, towerGrid2.y, isObstacle: false);
			pathFinder.SetWeight(towerGrid2.x, towerGrid2.y, 0);
		}
		for (int k = 0; k < towerGrids.Count; k++)
		{
			TowerDefenseMapData.TowerGrid grid = towerGrids.get_Item(k);
			if (grid.gridWalkableType != 0)
			{
				GridDeployType gridDeployType = (GridDeployType)grid.gridDeployType;
				if (gridDeployType == GridDeployType.Pothole || gridDeployType == GridDeployType.Deephole)
				{
					pathFinder.SetWeight(grid.x, grid.y, 99);
				}
				else
				{
					pathFinder.SetWeight(grid.x, grid.y, 0);
				}
			}
			if (!tmpGridDeployTypes.TryAdd(grid.index, (GridDeployType)grid.gridDeployType))
			{
				Debug.LogError($"x:{grid.x}_y:{grid.y}");
			}
			if (grid.gridDeployType == 3)
			{
				CreateGrassGrid(grid.index);
			}
			SeedThemeEnvironmentGrid(grid);
		}
		for (int l = 0; l < routes.Count; l++)
		{
			TowerDefenseMapData.TowerDefenseRoute value = routes.get_Item(l);
			List<TowerDefenseMapData.RouteGridInfo> routePoints = value.routePoints;
			if (routePoints != null && routePoints.Count != 0)
			{
				for (int m = 0; m < routePoints.Count; m++)
				{
					TowerDefenseMapData.RouteGridInfo value2 = routePoints.get_Item(m);
					value2.path2Grid = null;
					routePoints.set_Item(m, value2);
				}
				for (int n = 0; n < routePoints.Count - 1; n++)
				{
					TowerDefenseMapData.RouteGridInfo routeGridInfo = routePoints.get_Item(n);
					TowerDefenseMapData.RouteGridInfo value3 = routePoints.get_Item(n + 1);
					List<int> path2Grid = FindPath(routeGridInfo.gridID, value3.gridID);
					value3.path2Grid = path2Grid;
					routePoints.set_Item(n + 1, value3);
				}
				value.routePoints = routePoints;
				routes.set_Item(l, value);
			}
		}
	}

	private List<int> FindPath(int startIndex, int endIndex)
	{
		TowerDefenseMapData.TowerGrid grid = GetGrid(startIndex);
		TowerDefenseMapData.TowerGrid grid2 = GetGrid(endIndex);
		List<TowerDefensePathFinding_Hotfix.Point> list = pathFinder.FindPath(grid.x, grid.y, grid2.x, grid2.y);
		if (list == null)
		{
			return null;
		}
		if (list.Count > 0)
		{
			List<int> list2 = new List<int>();
			for (int i = 0; i < list.Count; i++)
			{
				TowerDefensePathFinding_Hotfix.Point point = list.get_Item(i);
				list2.Add(GetGrid(point.x, point.y).index);
			}
			return list2;
		}
		return null;
	}

	internal void InitGameplay()
	{
		levelComplete = false;
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null != instance)
		{
			instance.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDiedEvent);
			instance.AddEventListener("TOWERDEFENSE_MONSTER_ACTION_CALLBACK_EVT", MonsterActionCallback);
			instance.AddEventListener("TOWERDEFENSE_REC_GET_NEXT_GRID_INFO", RecEventFromMonsterAI_GetNextGridInfo);
			instance.AddEventListener("TOWERDEFENSE_REC_GET_NEXT_N_GRID_INFO", RecEventFromMonsterAI_GetNextNGridInfo);
			instance.AddEventListener("TOWERDEFENSE_REC_CREATE_GRASS", RecEventFromCS_CreateGrass);
			instance.AddEventListener("TOWERDEFENSE_REC_CLEAR_GRASS", RecEventFromCS_ClearGrass);
			instance.AddEventListener("TOWERDEFENSE_REC_GET_GRID_INFO_IN_CIRCLE", RecEventFromCS_GetGridInfoInCircle);
			instance.AddEventListener("TOWERDEFENSE_REC_GET_GRID_INFO_BY_POS", RecEventFromCS_GetGridInfoByPos);
			instance.AddEventListener("TOWERDEFENSE_REC_IS_DARK_LEVEL", RecEventFromCS_IsDarkLevel);
		}
		EventDispatchManager instance2 = Singleton<EventDispatchManager>.Instance;
		if (instance2 != null)
		{
			instance2.AddEventListener("TOWERDEFENSE_CARDOUTAREA", RecEventFromLua_HoldRoleCardOut);
			instance2.AddEventListener("TOWERDEFENSE_DRAG_ITEMCARD_BEGIN", RecEventFromLua_HoldItemCardOut);
			instance2.AddEventListener("TOWERDEFENSE_CHARACTER_LEVELUP", RecEventFromLua_RoleLevelUp);
			instance2.AddEventListener("TowerDefenseShowFullScreenPanel", RecEventFromLua_ShowFullScreenPanel);
			instance2.AddEventListener("TowerDefenseShowHideScreenPanel", RecEventFromLua_HideFullScreenPanel);
			instance2.AddEventListener("TOWERDEFENSE_CARDPOINTENTER", RecEventFromLua_CardPointEnter);
			instance2.AddEventListener("TOWERDEFENSE_CARDPOINTEXIT", RecEventFromLua_CardPointExit);
			instance2.AddEventListener("TOWERDEFENSE_HANDLE_CONTROL_L1R1", RecEventFromLua_L1R1);
			instance2.AddEventListener("TOWERDEFENSE_HANDLE_CONTROL_L2R2", RecEventFromLua_L2R2);
			instance2.AddEventListener("TOWERDEFENSE_CANCEL_SELECT_STATE", RecEventFromLua_CancelSelectState);
			instance2.AddEventListener("TOWERDEFENSE_CANCEL_DRAG_STATE", RecEventFromLua_CancelDragState);
			instance2.AddEventListener("TowerDefenseSelectedBtn", RecEventFromLua_SelectedBtn);
			instance2.AddEventListener("TOWERDEFENSE_SELECTED_POTENTIAL", RecEventFromLua_SelectedPotential);
			instance2.AddEventListener("TOWERDEFENSE_TIMESCALE_CHANGED", RecEventFromLua_TimeScaleChanged);
			instance2.AddEventListener("TowerdefenseGM_AddExp", GM_GiveExp);
			instance2.AddEventListener("TowerdefenseGM_AddPoint", GM_GivePoint);
			instance2.AddEventListener("TowerdefenseGM_AddCharCard", GM_GiveCard);
			instance2.AddEventListener("TowerdefenseGM_FastCD", GM_FastCD);
			instance2.AddEventListener("TowerdefenseGM_ChangeHP", GM_ChangeHP);
			instance2.AddEventListener("TowerdefenseGM_AddItem", GM_AddItem);
			instance2.AddEventListener("TowerdefenseGM_AddCharBuff", GM_AddCharBuff);
			instance2.AddEventListener("TowerdefenseGM_ChangeGrid", GM_ChageGridDarkAttri);
		}
		normalSpawnWaves = new List<TowerDefense_MonsterSpawnWave>();
		specialSpawnWave = new TowerDefense_MonsterSpawnWave(0, cycle: true);
		InitSpawnContainer();
		InitInputController();
		InitRouteLines();
		InitTipQuads();
		InitIndicator();
	}

	internal virtual void OnLevelStart()
	{
		specialSpawnWave.RegisterFixedAction(SpawnFixedAction);
		specialSpawnWave.Active();
		startLogic = true;
		duration = 0f;
		coroutine = StartCoroutine(DoMainLogic());
		InitSceneEffect();
		ItemLogicStart();
		StartThemeEnvironment();
	}

	internal virtual void OnLevelEnd()
	{
		AdventureModuleController instance = ModuleController<AdventureModuleController>.Instance;
		if (null != instance)
		{
			instance.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDiedEvent);
			instance.RemoveEventListener("TOWERDEFENSE_MONSTER_ACTION_CALLBACK_EVT", MonsterActionCallback);
			instance.RemoveEventListener("TOWERDEFENSE_REC_GET_NEXT_GRID_INFO", RecEventFromMonsterAI_GetNextGridInfo);
			instance.RemoveEventListener("TOWERDEFENSE_REC_GET_NEXT_N_GRID_INFO", RecEventFromMonsterAI_GetNextNGridInfo);
			instance.RemoveEventListener("TOWERDEFENSE_REC_CREATE_GRASS", RecEventFromCS_CreateGrass);
			instance.RemoveEventListener("TOWERDEFENSE_REC_CLEAR_GRASS", RecEventFromCS_ClearGrass);
			instance.RemoveEventListener("TOWERDEFENSE_REC_GET_GRID_INFO_IN_CIRCLE", RecEventFromCS_GetGridInfoInCircle);
			instance.RemoveEventListener("TOWERDEFENSE_REC_GET_GRID_INFO_BY_POS", RecEventFromCS_GetGridInfoByPos);
			instance.RemoveEventListener("TOWERDEFENSE_REC_IS_DARK_LEVEL", RecEventFromCS_IsDarkLevel);
		}
		EventDispatchManager instance2 = Singleton<EventDispatchManager>.Instance;
		if (instance2 != null)
		{
			instance2.RemoveEventListener("TOWERDEFENSE_CARDOUTAREA", RecEventFromLua_HoldRoleCardOut);
			instance2.RemoveEventListener("TOWERDEFENSE_DRAG_ITEMCARD_BEGIN", RecEventFromLua_HoldItemCardOut);
			instance2.RemoveEventListener("TOWERDEFENSE_CHARACTER_LEVELUP", RecEventFromLua_RoleLevelUp);
			instance2.RemoveEventListener("TowerDefenseShowFullScreenPanel", RecEventFromLua_ShowFullScreenPanel);
			instance2.RemoveEventListener("TowerDefenseShowHideScreenPanel", RecEventFromLua_HideFullScreenPanel);
			instance2.RemoveEventListener("TOWERDEFENSE_CARDPOINTENTER", RecEventFromLua_CardPointEnter);
			instance2.RemoveEventListener("TOWERDEFENSE_CARDPOINTEXIT", RecEventFromLua_CardPointExit);
			instance2.RemoveEventListener("TOWERDEFENSE_HANDLE_CONTROL_L1R1", RecEventFromLua_L1R1);
			instance2.RemoveEventListener("TOWERDEFENSE_HANDLE_CONTROL_L2R2", RecEventFromLua_L2R2);
			instance2.RemoveEventListener("TOWERDEFENSE_CANCEL_SELECT_STATE", RecEventFromLua_CancelSelectState);
			instance2.RemoveEventListener("TOWERDEFENSE_CANCEL_DRAG_STATE", RecEventFromLua_CancelDragState);
			instance2.RemoveEventListener("TowerDefenseSelectedBtn", RecEventFromLua_SelectedBtn);
			instance2.RemoveEventListener("TOWERDEFENSE_SELECTED_POTENTIAL", RecEventFromLua_SelectedPotential);
			instance2.RemoveEventListener("TOWERDEFENSE_TIMESCALE_CHANGED", RecEventFromLua_TimeScaleChanged);
			instance2.RemoveEventListener("TowerdefenseGM_AddExp", GM_GiveExp);
			instance2.RemoveEventListener("TowerdefenseGM_AddPoint", GM_GivePoint);
			instance2.RemoveEventListener("TowerdefenseGM_AddCharCard", GM_GiveCard);
			instance2.RemoveEventListener("TowerdefenseGM_FastCD", GM_FastCD);
			instance2.RemoveEventListener("TowerdefenseGM_ChangeHP", GM_ChangeHP);
			instance2.RemoveEventListener("TowerdefenseGM_AddItem", GM_AddItem);
			instance2.RemoveEventListener("TowerdefenseGM_AddCharBuff", GM_AddCharBuff);
			instance2.RemoveEventListener("TowerdefenseGM_ChangeGrid", GM_ChageGridDarkAttri);
		}
		startLogic = false;
		duration = 0f;
		if (normalSpawnWaves != null)
		{
			for (int i = 0; i < normalSpawnWaves.Count; i++)
			{
				normalSpawnWaves.get_Item(i)?.Clear();
			}
			normalSpawnWaves?.Clear();
			normalSpawnWaves = null;
		}
		specialSpawnWave?.Clear();
		specialSpawnWave = null;
		curActivedWave = null;
		mReachedPointIndex?.Clear();
		mReachedPointIndex = null;
		if (coroutine != null)
		{
			StopCoroutine(coroutine);
		}
		ClearInputController();
		ClearGrids();
		ClearRoles();
		ClearRouteLines();
		ClearTipQuads();
		ClearEffects();
		ClearItems();
		ClearThemeEnvironment();
		ClearMonsterMoveInfos();
		lowSpdTimeScale = false;
	}

	internal virtual void OnUpdateLogic()
	{
		if (startLogic)
		{
			duration += LockStepManager.deltaTime;
			if (curActivedWave != null)
			{
				curActivedWave.UpdateLogic();
			}
			if (specialSpawnWave != null)
			{
				specialSpawnWave.UpdateLogic();
			}
			UpdateExp();
			UpdateMonsters();
			UpdateItemLogic();
			UpdateThemeEnvironment();
		}
	}

	internal bool IsLevelComplete()
	{
		return levelComplete;
	}

	internal void InitExpInfo(FP expSpeed, int[] teamExps)
	{
		this.expSpeed = expSpeed;
		this.teamExps = teamExps;
		teamLvTotal = teamExps.Length + 1;
		curTeamLv = 1;
		totalExp = teamExps[curTeamLv - 1];
		curExp = 0;
		expUpdateDuration = 0;
		curLevelUpNum = 0;
		extUpdateSpd = expSpeed * totalExp;
		lua.FireEvent("TOWERDEFENSE_UPDATE_EXP", (float)curExp, totalExp);
		lua.FireEvent("TOWERDEFENSE_UPDATE_LEVELUP", curLevelUpNum, teamLvTotal - curTeamLv);
	}

	private void UpdateExp()
	{
		if (curTeamLv < teamLvTotal)
		{
			expUpdateDuration += LockStepManager.deltaTime;
			if (expUpdateDuration >= expUpdateSpd)
			{
				expUpdateDuration -= expUpdateSpd;
				GiveEXP(extUpdateSpd);
			}
		}
	}

	private void GiveEXP(FP exp)
	{
		if (curTeamLv < teamLvTotal)
		{
			curExp += exp;
			if (curExp >= totalExp)
			{
				curExp -= (FP)totalExp;
				LevelUp();
			}
			if (curTeamLv >= teamLvTotal)
			{
				curExp = 0;
			}
			lua.FireEvent("TOWERDEFENSE_UPDATE_EXP", (float)curExp, totalExp);
		}
	}

	private void LevelUp()
	{
		if (curTeamLv >= teamLvTotal)
		{
			curTeamLv = teamLvTotal;
			return;
		}
		curTeamLv++;
		curLevelUpNum++;
		lua.FireEvent("TOWERDEFENSE_UPDATE_LEVELUP", curLevelUpNum, teamLvTotal - curTeamLv);
		if (curTeamLv < teamLvTotal)
		{
			totalExp = teamExps[curTeamLv - 1];
			extUpdateSpd = expSpeed * totalExp;
		}
	}

	private void ReduceLevelUp(int num)
	{
		curLevelUpNum -= num;
		lua.FireEvent("TOWERDEFENSE_UPDATE_LEVELUP", curLevelUpNum);
	}

	internal void InitLevelInfo(int levelDurability, int monsterTotalNum)
	{
		levelDurabilityTotal = levelDurability;
		curLevelDurability = levelDurability;
		monsterNumTotal = monsterTotalNum;
		curMonsterNum = monsterTotalNum;
		lua.FireEvent("TOWERDEFENSE_UPDATE_LEVEL_DURABILITTY", curLevelDurability, levelDurabilityTotal);
		lua.FireEvent("TOWERDEFENSE_UPDATE_MONSTER_NUM", curMonsterNum, monsterNumTotal);
		Debug.Log($"关卡耐久度:{curLevelDurability}_怪物总数{monsterTotalNum}");
	}

	private void ResetLevelDurability(int value)
	{
		curLevelDurability = value;
		if (curLevelDurability > levelDurabilityTotal)
		{
			levelDurabilityTotal = curLevelDurability;
		}
		lua.FireEvent("TOWERDEFENSE_UPDATE_LEVEL_DURABILITTY", curLevelDurability, levelDurabilityTotal);
		if (curLevelDurability == 0)
		{
			Failed();
		}
	}

	private void ReduceLevelDurabiliity(int value)
	{
		Debug.Log($"耐久度减少{value}");
		curLevelDurability -= value;
		if (curLevelDurability <= 0)
		{
			curLevelDurability = 0;
		}
		lua.FireEvent("TOWERDEFENSE_UPDATE_LEVEL_DURABILITTY", curLevelDurability, levelDurabilityTotal);
		if (curLevelDurability == 0)
		{
			Failed();
		}
	}

	private void ReduceMonsterNum(int value)
	{
		curMonsterNum -= value;
		if (curMonsterNum <= 0)
		{
			curMonsterNum = 0;
		}
		lua.FireEvent("TOWERDEFENSE_UPDATE_MONSTER_NUM", curMonsterNum, monsterNumTotal);
		if (curMonsterNum == 0)
		{
			Success();
		}
		Debug.Log($"当前怪物数量:{curMonsterNum}_怪物总数{monsterNumTotal}");
	}

	private void Success()
	{
		if (startLogic)
		{
			levelComplete = true;
			Debug.Log("成功");
			StopLogic(isSuc: true, curLevelDurability);
		}
	}

	private void Failed()
	{
		if (startLogic)
		{
			levelComplete = true;
			Debug.Log("失败");
			StopLogic(isSuc: false, curLevelDurability);
		}
	}

	private void StopLogic(bool isSuc, int durability)
	{
		startLogic = false;
		StartCoroutine(IEStopLogic(isSuc, durability));
	}

	private IEnumerator IEStopLogic(bool isSuc, int durability)
	{
		StopAllMonstersMove();
		yield return WaitTime(waitSettleTime);
		lua.FireEvent("TOWERDEFENSE_LEVEL_RESULT", isSuc, durability);
	}

	public AdventureFXPlayer PlayEffect(string path, Vector3 position)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, path, typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("塔防特效为空:" + path);
			return null;
		}
		return AdventureFXPlayer.PlayFX(gameObject, 1f, position, Quaternion.identity);
	}

	private void PlayRoleLevelUpUITipEffect(int roleID)
	{
		lua.FireEvent("TOWERDEFENSE_CHAR_LEVELUP", roleID);
	}

	private void PlayRoleLevelUpEffect(int level, Vector3 position)
	{
		for (int i = 0; i < levelups.Length; i++)
		{
			if (level >= levelups[i])
			{
				GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, levelupFxPaths[i], typeof(GameObject)) as GameObject;
				if (null == gameObject)
				{
					Debug.LogError("角色升级特效为空:" + levelupFxPaths[i]);
				}
				else
				{
					AdventureFXPlayer.PlayFX(gameObject, 1f, position, Quaternion.identity).SetIndependentUpdate(value: true);
				}
				break;
			}
		}
	}

	private void PlayRoleLevelUpEffect(Vector2 from, Vector3 to, Action callback = null)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Actor, "Assets/AssetBundles/FX/TowerDefence/fx_td_base_exp_point.prefab", typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("角色升级拖尾特效为空:Assets/AssetBundles/FX/TowerDefence/fx_td_base_exp_point.prefab");
		}
		else
		{
			mouseFollower.PlayRoleLevelUpEffect(gameObject, from, to, 0.1f, callback);
		}
	}

	private void InitIndicator()
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/Adventure/Indicators/TowerDefenseBlobIndicators.prefab", typeof(GameObject)) as GameObject;
		if (null != gameObject && UnityEngine.Object.Instantiate(gameObject).TryGetComponent<TowerDefenseIndicatorController>(out var component))
		{
			indicator = component;
			indicator.Hide();
			indicator.InitIndicator();
		}
	}

	private bool IsRouteEndPoint(int routeID, int gridID)
	{
		if (endPoints.TryGetValue(routeID, out var value))
		{
			return value == gridID;
		}
		return false;
	}

	private void InitSceneEffect()
	{
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
			if (towerGrid.gridDeployType == 1)
			{
				PlayMonsterSpawnPointEffect(new Vector3(towerGrid.position.x, 0f, towerGrid.position.y));
			}
		}
		endPoints.Clear();
		List<TowerDefenseMapData.TowerDefenseRoute> routes = mapData.routes;
		for (int j = 0; j < routes.Count; j++)
		{
			TowerDefenseMapData.TowerDefenseRoute towerDefenseRoute = routes.get_Item(j);
			List<TowerDefenseMapData.RouteGridInfo> routePoints = towerDefenseRoute.routePoints;
			if (routePoints != null && routePoints.Count != 0)
			{
				TowerDefenseMapData.TowerGrid grid = GetGrid(routePoints.get_Item(routePoints.Count - 1).gridID);
				endPoints.TryAdd(towerDefenseRoute.id, grid.index);
				PlayEndPointEffect(new Vector3(grid.position.x, 0f, grid.position.y));
			}
		}
	}

	private void PlayMonsterSpawnPointEffect(Vector3 position)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_monster_born_block.prefab", typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("塔防怪物出生地特效为空:Assets/AssetBundles/FX/TowerDefence/fx_td_loop_monster_born_block.prefab");
		}
		else
		{
			AdventureFXPlayer.PlayFX(gameObject, 1f, position, Quaternion.identity);
		}
	}

	private void PlayEndPointEffect(Vector3 position)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_monster_die_block.prefab", typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("塔防终点地特效为空:Assets/AssetBundles/FX/TowerDefence/fx_td_loop_monster_die_block.prefab");
		}
		else
		{
			AdventureFXPlayer.PlayFX(gameObject, 1f, position, Quaternion.identity);
		}
	}

	private void PlayMonsterMove2EndPointEffect(Vector3 position)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/FX/TowerDefence/fx_td_base_monster_die_light.prefab", typeof(GameObject)) as GameObject;
		if (null != gameObject)
		{
			AdventureFXPlayer.PlayFX(gameObject, 1f, position, Quaternion.identity);
		}
		else
		{
			Debug.LogError("塔防怪物抵达终点特效为空:Assets/AssetBundles/FX/TowerDefence/fx_td_base_monster_die_light.prefab");
		}
		GameObject gameObject2 = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/FX/ScreenEffect/fx_screen_actor_hit.prefab", typeof(GameObject)) as GameObject;
		if (null != gameObject2)
		{
			AdventureFXPlayer.PlayFX(gameObject2, 1f, Vector3.zero, Quaternion.identity);
		}
		else
		{
			Debug.LogError("塔防怪物抵达终点特效为空:Assets/AssetBundles/FX/ScreenEffect/fx_screen_actor_hit.prefab");
		}
	}

	private void PlayDropInWaterEffect(Vector3 position)
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/FX/TowerDefence/fx_td_base_monster_die_water.prefab", typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("塔防掉落入水特效为空:Assets/AssetBundles/FX/TowerDefence/fx_td_base_monster_die_water.prefab");
		}
		else
		{
			AdventureFXPlayer.PlayFX(gameObject, 1f, position, Quaternion.identity);
		}
	}

	private void CreateGrassEffect(int gridIndex)
	{
		TowerDefenseMapData.TowerGrid grid = GetGrid(gridIndex);
		if (grid.IsNull)
		{
			return;
		}
		if (grasses == null)
		{
			grasses = new Dictionary<int, AdventureFXPlayer>();
		}
		if (grasses.TryGetValue(gridIndex, out var value))
		{
			Debug.Log($"生成草坪失败，已存在草坪:{gridIndex}");
			return;
		}
		Vector3 position = new Vector3(grid.position.x, 0f, grid.position.y);
		value = PlayEffect("Assets/AssetBundles/FX/TowerDefence/fx_td_loop_grass.prefab", position);
		if (null == value)
		{
			Debug.LogError(string.Format("生成草坪失败，草坪为空:{0}_{1}", gridIndex, "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_grass.prefab"));
			return;
		}
		if (!grasses.TryAdd(gridIndex, value))
		{
			Debug.Log(string.Format("生成草坪失败:{0}_{1}", gridIndex, "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_grass.prefab"));
			value.Stop();
			return;
		}
		MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_TD_grass");
		if (lowSpdTimeScale)
		{
			MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_TD_grass_pause");
		}
	}

	private bool RemoveGrassEffect(int gridIndex)
	{
		if (grasses == null)
		{
			Debug.Log($"尝试移除不存在的草坪：{gridIndex}");
			return false;
		}
		if (!grasses.TryGetValue(gridIndex, out var value))
		{
			Debug.Log($"尝试移除不存在的草坪：{gridIndex}");
			return false;
		}
		value.Stop();
		grasses.Remove(gridIndex);
		return true;
	}

	private void InitRouteLines()
	{
		GameObject gameObject = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_line.prefab", typeof(GameObject)) as GameObject;
		if (null == gameObject)
		{
			Debug.LogError("没有找到路线资源:Assets/AssetBundles/FX/TowerDefence/fx_td_loop_line.prefab");
			return;
		}
		GameObject gameObject2 = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/FX/TowerDefence/fx_td_loop_arrow.prefab", typeof(GameObject)) as GameObject;
		if (null == gameObject2)
		{
			Debug.LogError("没有找到路线资源:Assets/AssetBundles/FX/TowerDefence/fx_td_loop_line.prefab");
			return;
		}
		if (routeLines == null)
		{
			routeLines = new List<TowerDefenseMapLineController>();
		}
		List<TowerDefenseMapData.TowerDefenseRoute> routes = mapData.routes;
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseMapData.TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			TowerDefenseMapLineController towerDefenseMapLineController = new GameObject($"TowerDefenseMapLineController_{towerDefenseRoute.id}").AddComponent<TowerDefenseMapLineController>();
			GameObject lineObj = UnityEngine.Object.Instantiate(gameObject);
			GameObject arrowObj = UnityEngine.Object.Instantiate(gameObject2);
			towerDefenseMapLineController.Init(towerDefenseRoute.id, lineObj, arrowObj);
			towerDefenseMapLineController.Hide();
			routeLines.Add(towerDefenseMapLineController);
		}
		RefreshRoutelines();
	}

	private void RefreshRoutelines()
	{
		if (routeLines == null || routeLines.Count == 0)
		{
			return;
		}
		List<TowerDefenseMapData.TowerDefenseRoute> routes = mapData.routes;
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseMapData.TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			TowerDefenseMapLineController towerDefenseMapLineController = null;
			for (int j = 0; j < routeLines.Count; j++)
			{
				TowerDefenseMapLineController towerDefenseMapLineController2 = routeLines.get_Item(j);
				if (towerDefenseMapLineController2.id == towerDefenseRoute.id)
				{
					towerDefenseMapLineController = towerDefenseMapLineController2;
					break;
				}
			}
			if (null == towerDefenseMapLineController)
			{
				continue;
			}
			if (!towerDefenseRoute.Reachable2End())
			{
				towerDefenseMapLineController.Hide();
				continue;
			}
			List<int> list = new List<int>();
			List<TowerDefenseMapData.RouteGridInfo> routePoints = towerDefenseRoute.routePoints;
			for (int k = 0; k < routePoints.Count; k++)
			{
				List<int> path2Grid = routePoints.get_Item(k).path2Grid;
				if (path2Grid != null)
				{
					int num = ((k == routePoints.Count - 1) ? path2Grid.Count : (path2Grid.Count - 1));
					for (int l = 0; l < num; l++)
					{
						int item = path2Grid.get_Item(l);
						list.Add(item);
					}
				}
			}
			if (list.Count != 0)
			{
				List<Vector3> list2 = new List<Vector3>();
				for (int m = 0; m < list.Count; m++)
				{
					TowerDefenseMapData.TowerGrid grid = GetGrid(list.get_Item(m));
					list2.Add(new Vector3(grid.position.x, 0f, grid.position.y));
				}
				towerDefenseMapLineController.RefreshLine(list2.ToArray());
			}
		}
	}

	private void ClearRouteLines()
	{
		if (routeLines != null)
		{
			for (int i = 0; i < routeLines.Count; i++)
			{
				TowerDefenseMapLineController towerDefenseMapLineController = routeLines.get_Item(i);
				UnityEngine.Object.Destroy(towerDefenseMapLineController.gameObject);
				UnityEngine.Object.Destroy(towerDefenseMapLineController);
			}
			routeLines.Clear();
			routeLines = null;
		}
	}

	private void ClearEffects()
	{
		if (null != indicator)
		{
			indicator.Clear();
			UnityEngine.Object.Destroy(indicator.gameObject);
			UnityEngine.Object.Destroy(indicator);
			indicator = null;
		}
		if (grasses == null)
		{
			return;
		}
		foreach (AdventureFXPlayer value in grasses.Values)
		{
			if (null != value)
			{
				value.Stop();
			}
		}
		grasses.Clear();
		grasses = null;
	}

	private void RecEventFromLua_HoldRoleCardOut(IEvent ievent)
	{
		if (ievent is GeneralEvent generalEvent && CommonHelper.TryParseStringParamToInt((generalEvent.data as LuaTable).get_Item((object)1).ToString(), out var intValue))
		{
			OnStartDragRole(intValue);
		}
	}

	private void RecEventFromLua_HoldItemCardOut(IEvent ievent)
	{
		OnStartDragItem();
	}

	private void RecEventFromLua_ShowFullScreenPanel(IEvent ievent)
	{
		BlockInput(block: true);
		TryCancelHold();
	}

	private void RecEventFromLua_HideFullScreenPanel(IEvent ievent)
	{
		BlockInput(block: false);
	}

	private void RecEventFromLua_CardPointEnter(IEvent ievent)
	{
		OnCardPointer(enter: true);
	}

	private void RecEventFromLua_CardPointExit(IEvent ievent)
	{
		OnCardPointer(enter: false);
	}

	private void RecEventFromLua_L1R1(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		bool flag = false;
		if (ievent is GeneralEvent generalEvent)
		{
			LuaTable obj = generalEvent.data as LuaTable;
			int intValue = 0;
			if (CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out intValue))
			{
				flag = intValue == 1;
			}
		}
		if (flag)
		{
			TowerDefenseMapData.TowerGrid towerGrid = Move2NextGrid();
			if (!towerGrid.IsNull)
			{
				Vector3 targetPos = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPointAsHFOV(new Vector3(towerGrid.position.x, 0f, towerGrid.position.y));
				MonoSingleton<InputManager>.Instance?.MoveMouse(targetPos);
			}
		}
		else
		{
			TowerDefenseMapData.TowerGrid towerGrid2 = Move2PreGrid();
			if (!towerGrid2.IsNull)
			{
				Vector3 targetPos2 = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPointAsHFOV(new Vector3(towerGrid2.position.x, 0f, towerGrid2.position.y));
				MonoSingleton<InputManager>.Instance?.MoveMouse(targetPos2);
			}
		}
	}

	private void RecEventFromLua_L2R2(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		bool flag = false;
		if (ievent is GeneralEvent generalEvent)
		{
			LuaTable obj = generalEvent.data as LuaTable;
			int intValue = 0;
			if (CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out intValue))
			{
				flag = intValue == 1;
			}
		}
		if (flag)
		{
			TowerDefenseMapData.TowerGrid towerGrid = Move2NextRoleGrid();
			if (!towerGrid.IsNull)
			{
				Vector3 targetPos = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPointAsHFOV(new Vector3(towerGrid.position.x, 0f, towerGrid.position.y));
				MonoSingleton<InputManager>.Instance?.MoveMouse(targetPos);
			}
		}
		else
		{
			TowerDefenseMapData.TowerGrid towerGrid2 = Move2PreRoleGrid();
			if (!towerGrid2.IsNull)
			{
				Vector3 targetPos2 = MonoSingleton<GameCameraStackManager>.Instance.mainCamera.WorldToScreenPointAsHFOV(new Vector3(towerGrid2.position.x, 0f, towerGrid2.position.y));
				MonoSingleton<InputManager>.Instance?.MoveMouse(targetPos2);
			}
		}
	}

	private void RecEventFromLua_CancelSelectState(IEvent ievent)
	{
		if (selectRoleID != 0)
		{
			TryUnSelectRole();
		}
	}

	private void RecEventFromLua_CancelDragState(IEvent ievent)
	{
		CancelHoldState();
	}

	private void RecEventFromLua_SelectedBtn(IEvent ievent)
	{
		selectUIBtn = true;
	}

	private void RecEventFromMonsterAI_GetNextGridInfo(IEvent ievent)
	{
		if (ievent != null && long.TryParse(((GeneralEvent)ievent).data.ToString(), out var result) && mMoveInfos.TryGetValue(result, out var value))
		{
			TSVector2 position = value.actor.tsTransform.Position;
			GetMonsterMinDistanceGrid(position, out var _, out var minDisGridID);
			TowerDefenseMapData.TowerGrid nextGrid = GetNextGrid(value.routeID, minDisGridID, value.reachedPathIndex, out var _);
			MonsterRecGridInfo data = BuildMonsterRecGridInfo(result, minDisGridID, nextGrid.index);
			ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_DIS_GET_NEXT_GRID_INFO", value.actor, data);
		}
	}

	private void RecEventFromMonsterAI_GetNextNGridInfo(IEvent ievent)
	{
		if (ievent == null || !(((GeneralEvent)ievent).data is NextGridQueryParam nextGridQueryParam) || !mMoveInfos.TryGetValue(nextGridQueryParam.monsterID, out var value))
		{
			return;
		}
		TSVector2 position = value.actor.tsTransform.Position;
		GetMonsterMinDistanceGrid(position, out var _, out var minDisGridID);
		int num = ((nextGridQueryParam.step < 1) ? 1 : nextGridQueryParam.step);
		int reachedPointIndex = value.reachedPathIndex;
		int curIndex = minDisGridID;
		int nextGridIndex = -1;
		for (int i = 0; i < num; i++)
		{
			TowerDefenseMapData.TowerGrid nextGrid = GetNextGrid(value.routeID, curIndex, reachedPointIndex, out var curReachedPointIndex);
			nextGridIndex = nextGrid.index;
			if (nextGrid.IsNull)
			{
				break;
			}
			curIndex = nextGrid.index;
			reachedPointIndex = curReachedPointIndex;
		}
		MonsterRecGridInfo data = BuildMonsterRecGridInfo(nextGridQueryParam.monsterID, minDisGridID, nextGridIndex);
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_DIS_GET_NEXT_N_GRID_INFO", value.actor, data);
	}

	private MonsterRecGridInfo BuildMonsterRecGridInfo(long monsterID, int curGridIndex, int nextGridIndex)
	{
		int sizeX = mapData.sizeX;
		MonsterRecGridInfo monsterRecGridInfo = new MonsterRecGridInfo();
		monsterRecGridInfo.monsterID = monsterID;
		TowerDefenseMapData.TowerGrid grid = GetGrid(curGridIndex);
		monsterRecGridInfo.curGridIndex = grid.index;
		if (tmpGridDeployTypes.TryGetValue(grid.index, out var value))
		{
			monsterRecGridInfo.curGridDeployType = value;
		}
		monsterRecGridInfo.curGridWalkableType = (GridWalkableType)grid.gridWalkableType;
		TowerDefenseMapData.TowerGrid grid2 = GetGrid(nextGridIndex);
		monsterRecGridInfo.ccIndex = grid2.index;
		if (tmpGridDeployTypes.TryGetValue(grid2.index, out value))
		{
			monsterRecGridInfo.ccDeployType = value;
		}
		monsterRecGridInfo.ccWalkableType = (GridWalkableType)grid2.gridWalkableType;
		monsterRecGridInfo.ccPosition = new TSVector2(grid2.position.x, grid2.position.y);
		grid = GetGrid(grid2.index - 1);
		monsterRecGridInfo.lcIndex = grid.index;
		if (tmpGridDeployTypes.TryGetValue(grid.index, out value))
		{
			monsterRecGridInfo.lcDeployType = value;
		}
		monsterRecGridInfo.lcWalkableType = (GridWalkableType)grid.gridWalkableType;
		grid = GetGrid(grid2.index + 1);
		monsterRecGridInfo.rcIndex = grid.index;
		if (tmpGridDeployTypes.TryGetValue(grid.index, out value))
		{
			monsterRecGridInfo.rcDeployType = value;
		}
		monsterRecGridInfo.rcWalkableType = (GridWalkableType)grid.gridWalkableType;
		grid = GetGrid(grid2.index + sizeX);
		monsterRecGridInfo.cuIndex = grid.index;
		if (tmpGridDeployTypes.TryGetValue(grid.index, out value))
		{
			monsterRecGridInfo.cuDeployType = value;
		}
		monsterRecGridInfo.cuWalkableType = (GridWalkableType)grid.gridWalkableType;
		grid = GetGrid(grid2.index - sizeX);
		monsterRecGridInfo.cdIndex = grid.index;
		if (tmpGridDeployTypes.TryGetValue(grid.index, out value))
		{
			monsterRecGridInfo.cdDeployType = value;
		}
		monsterRecGridInfo.cdWalkableType = (GridWalkableType)grid.gridWalkableType;
		grid = GetGrid(grid2.index + sizeX - 1);
		monsterRecGridInfo.luIndex = grid.index;
		if (tmpGridDeployTypes.TryGetValue(grid.index, out value))
		{
			monsterRecGridInfo.luDeployType = value;
		}
		monsterRecGridInfo.luWalkableType = (GridWalkableType)grid.gridWalkableType;
		grid = GetGrid(grid2.index + sizeX + 1);
		monsterRecGridInfo.ruIndex = grid.index;
		if (tmpGridDeployTypes.TryGetValue(grid.index, out value))
		{
			monsterRecGridInfo.ruDeployType = value;
		}
		monsterRecGridInfo.ruWalkableType = (GridWalkableType)grid.gridWalkableType;
		grid = GetGrid(grid2.index - sizeX - 1);
		monsterRecGridInfo.ldIndex = grid.index;
		if (tmpGridDeployTypes.TryGetValue(grid.index, out value))
		{
			monsterRecGridInfo.ldDeployType = value;
		}
		monsterRecGridInfo.ldWalkableType = (GridWalkableType)grid.gridWalkableType;
		grid = GetGrid(grid2.index - sizeX + 1);
		monsterRecGridInfo.rdIndex = grid.index;
		if (tmpGridDeployTypes.TryGetValue(grid.index, out value))
		{
			monsterRecGridInfo.rdDeployType = value;
		}
		monsterRecGridInfo.rdWalkableType = (GridWalkableType)grid.gridWalkableType;
		return monsterRecGridInfo;
	}

	private void RecEventFromCS_CreateGrass(IEvent ievent)
	{
		if (ievent != null && CommonUtils.TryParseStringParamToInt(((GeneralEvent)ievent).data.ToString(), out var intValue))
		{
			CreateGrassGrid(intValue);
		}
	}

	private void RecEventFromCS_ClearGrass(IEvent ievent)
	{
		if (ievent != null && CommonUtils.TryParseStringParamToInt(((GeneralEvent)ievent).data.ToString(), out var intValue))
		{
			MonsterClearGrassEvt(intValue);
		}
	}

	private void RecEventFromCS_GetGridInfoInCircle(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		GeneralEvent generalEvent = (GeneralEvent)ievent;
		GridQueryParam gridQueryParam = (GridQueryParam)generalEvent.data;
		if (gridQueryParam == null)
		{
			return;
		}
		List<TowerDefenseMapData.TowerGrid> list = mapData?.towerGrids;
		if (list == null)
		{
			return;
		}
		TSVector2 center = gridQueryParam.center;
		FP range = gridQueryParam.range;
		List<int> list2 = new List<int>();
		for (int i = 0; i < list.Count; i++)
		{
			TowerDefenseMapData.TowerGrid towerGrid = list.get_Item(i);
			if (towerGrid.gridDeployType == 2 && !(TSVector2.Distance(center, towerGrid.position.ToTSVector2()) > range))
			{
				list2.Add(towerGrid.index);
			}
		}
		if (list2.Count == 0)
		{
			return;
		}
		List<GridInfoData> list3 = new List<GridInfoData>();
		List<GridInfoData> list4 = (gridQueryParam.preferNonFlame ? new List<GridInfoData>() : null);
		for (int j = 0; j < list2.Count; j++)
		{
			int num = list2.get_Item(j);
			TowerDefenseMapData.TowerGrid grid = GetGrid(num);
			if (!grid.IsNull)
			{
				int value = 0;
				tokenGridIndex.TryGetValue(num, out value);
				bool flag = themeEnvironment?.IsGridSprayed(num) ?? false;
				bool flag2 = themeEnvironment?.IsGridOnFire(num) ?? false;
				GridInfoData item = new GridInfoData(num, flag, flag2, value, new TSVector2(grid.position.x, grid.position.y));
				list3.Add(item);
				if (list4 != null && !flag && !flag2)
				{
					list4.Add(item);
				}
			}
		}
		List<GridInfoData> data = ((list4 != null && list4.Count > 0) ? list4 : list3);
		ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_DIS_GET_GRID_INFO_IN_CIRCLE", generalEvent.sender, data);
	}

	private void RecEventFromCS_GetGridInfoByPos(IEvent ievent)
	{
		if (ievent == null)
		{
			return;
		}
		GeneralEvent generalEvent = (GeneralEvent)ievent;
		if (generalEvent.data is TSVector2 tSVector)
		{
			GridInfoData data = null;
			TowerDefenseMapData.TowerGrid grid = GetGrid(new Vector3((float)tSVector.x, 0f, (float)tSVector.y));
			if (!grid.IsNull)
			{
				int index = grid.index;
				tokenGridIndex.TryGetValue(index, out var value);
				bool isSprayed = themeEnvironment?.IsGridSprayed(index) ?? false;
				bool isOnFire = themeEnvironment?.IsGridOnFire(index) ?? false;
				bool isLit = themeEnvironment?.IsGridLit(index) ?? false;
				data = new GridInfoData(index, isSprayed, isOnFire, value, new TSVector2(grid.position.x, grid.position.y), isLit);
			}
			ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_DIS_GET_GRID_INFO_BY_POS", generalEvent.sender, data);
		}
	}

	private void RecEventFromCS_IsDarkLevel(IEvent ievent)
	{
		if (ievent != null)
		{
			GeneralEvent generalEvent = (GeneralEvent)ievent;
			ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_DIS_IS_DARK_LEVEL", generalEvent.sender, IsDarkThemeLevel);
		}
	}

	private void RecEventFromLua_RoleLevelUp(IEvent ievent)
	{
		if (ievent == null || !(ievent is GeneralEvent generalEvent))
		{
			return;
		}
		LuaTable obj = generalEvent.data as LuaTable;
		int intValue = 0;
		int intValue2 = 0;
		float floatValue = 0f;
		float floatValue2 = 0f;
		bool result = false;
		CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out intValue);
		CommonHelper.TryParseStringParamToInt(obj.get_Item((object)2).ToString(), out intValue2);
		CommonHelper.TryParseStringParamToFloat(obj.get_Item((object)3).ToString(), out floatValue);
		CommonHelper.TryParseStringParamToFloat(obj.get_Item((object)4).ToString(), out floatValue2);
		bool.TryParse(obj.get_Item((object)5).ToString(), out result);
		if (intValue > 0 && intValue2 > 0)
		{
			if (result)
			{
				CacheRoleLevelup(intValue, intValue2, new Vector2(floatValue, floatValue2));
			}
			else
			{
				RoleLevelUp(intValue, intValue2, new Vector2(floatValue, floatValue2));
			}
		}
	}

	private void CacheRoleLevelup(int roleID, int level, Vector2 position)
	{
		cacheRoleID = roleID;
		cacheRoleLevel = level;
		cachePosition = position;
	}

	private void RecEventFromLua_SelectedPotential(IEvent ievent)
	{
		if (cacheRoleID != 0)
		{
			RoleLevelUp(cacheRoleID, cacheRoleLevel, cachePosition);
		}
	}

	private void RecEventFromLua_TimeScaleChanged(IEvent ievent)
	{
		if (ievent == null || !(ievent is GeneralEvent generalEvent))
		{
			return;
		}
		LuaTable obj = generalEvent.data as LuaTable;
		int intValue = 0;
		if (!CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out intValue))
		{
			return;
		}
		if (intValue == 1)
		{
			lowSpdTimeScale = true;
		}
		else
		{
			lowSpdTimeScale = false;
		}
		for (int i = 0; i < markForCreateGrass.Count; i++)
		{
			if (lowSpdTimeScale)
			{
				MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mode_TD_grass_pause");
			}
			else
			{
				MonoSingleton<WwiseAudioManager>.Instance.PlaySound("mode_TD_grass_resume");
			}
		}
	}

	private void MonsterDiedEvent(IEvent ievent)
	{
		if (ievent != null)
		{
			AdventureMonsterDiedEvent adventureMonsterDiedEvent = (AdventureMonsterDiedEvent)ievent;
			if (adventureMonsterDiedEvent.summonId == 0L)
			{
				MonsterDied(adventureMonsterDiedEvent.monsterID, adventureMonsterDiedEvent.id, kill: true);
			}
		}
	}

	private void MonsterActionCallback(IEvent ievent)
	{
		if (ievent != null)
		{
			TowerDefenseMonsterActionCallbackEvent towerDefenseMonsterActionCallbackEvent = (TowerDefenseMonsterActionCallbackEvent)ievent;
			if (mMoveInfos.TryGetValue(towerDefenseMonsterActionCallbackEvent.monsterID, out var value))
			{
				value.finishAction = true;
				value.DoneAction(towerDefenseMonsterActionCallbackEvent.gridIndex);
			}
		}
	}

	private void GM_GiveExp(IEvent ievent)
	{
		if (ievent != null && ievent is GeneralEvent generalEvent)
		{
			LuaTable obj = generalEvent.data as LuaTable;
			int intValue = 0;
			if (CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out intValue))
			{
				GiveEXP(intValue);
			}
		}
	}

	private void GM_GivePoint(IEvent ievent)
	{
		if (ievent == null || !(ievent is GeneralEvent generalEvent))
		{
			return;
		}
		LuaTable obj = generalEvent.data as LuaTable;
		int intValue = 0;
		if (CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out intValue))
		{
			for (int i = 0; i < intValue; i++)
			{
				LevelUp();
			}
		}
	}

	private void GM_GiveCard(IEvent ievent)
	{
		if (ievent != null && ievent is GeneralEvent generalEvent)
		{
			LuaTable obj = generalEvent.data as LuaTable;
			int intValue = 0;
			if (CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out intValue))
			{
				GiveARoleCard(intValue);
			}
		}
	}

	private void GM_FastCD(IEvent ievent)
	{
	}

	private void GM_ChangeHP(IEvent ievent)
	{
		if (ievent != null && ievent is GeneralEvent generalEvent)
		{
			LuaTable obj = generalEvent.data as LuaTable;
			int intValue = 0;
			if (CommonHelper.TryParseStringParamToInt(obj.get_Item((object)1).ToString(), out intValue))
			{
				ResetLevelDurability(intValue);
			}
		}
	}

	private void GM_AddItem(IEvent ievent)
	{
		itemTemplete?.AddItemNum();
	}

	private void GM_AddCharBuff(IEvent ievent)
	{
		if (ievent is GeneralEvent { data: LuaTable data } && data.get_Item((object)1) != null && data.get_Item((object)2) != null && CommonHelper.TryParseStringParamToInt(data.get_Item((object)1).ToString(), out var intValue) && CommonHelper.TryParseStringParamToInt(data.get_Item((object)2).ToString(), out var intValue2) && curRoles.TryGetValue(intValue, out var value) && !(value == null))
		{
			value.buffComponent.AddBuff(intValue2, value);
			if (intValue2 == TowerDefenseConfig.buffId_RoleDarken)
			{
				GM_ApplyRoleDarken(intValue);
			}
		}
	}

	private void GM_ApplyRoleDarken(int roleId)
	{
		if (themeEnvironment is TowerDefenseThemeEnvironment_Dark && TryGetGridIndexByRoleId(roleId, out var _))
		{
			ModuleController<AdventureModuleController>.Instance.DispatchEventWithData("TOWERDEFENSE_REC_DARKEN_ROLE_GRID", this, roleId.ToString());
		}
	}

	private void GM_ChageGridDarkAttri(IEvent ievent)
	{
		if (ievent != null && themeEnvironment is TowerDefenseThemeEnvironment_Dark towerDefenseThemeEnvironment_Dark && ievent is GeneralEvent { data: LuaTable data } && CommonHelper.TryParseStringParamToInt(data.get_Item((object)1).ToString(), out var intValue))
		{
			towerDefenseThemeEnvironment_Dark.GM_ToggleGridDarkAttri(intValue);
		}
	}

	public TowerDefenseMapData.TowerGrid GetGrid(int id)
	{
		if (null == mapData)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		return mapData.GetGrid(id);
	}

	public TowerDefenseMapData.TowerGrid GetGrid(int x, int y)
	{
		if (null == mapData)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		return mapData.GetGrid(x, y);
	}

	private TowerDefenseMapData.TowerGrid GetNextGrid(int route, int curIndex, int reachedPointIndex, out int curReachedPointIndex)
	{
		curReachedPointIndex = 0;
		if (null == mapData)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		return mapData.GetNextGrid(route, curIndex, reachedPointIndex, out curReachedPointIndex);
	}

	public int GetReachedPointIndex(int routeID, int gridID, int reachedPointIndex)
	{
		if (null == mapData)
		{
			return -1;
		}
		return mapData.GetReachedPointIndex(routeID, gridID, reachedPointIndex);
	}

	public TowerDefenseMapData.TowerGrid GetGrid(Vector3 worldPosition)
	{
		if (null == mapData)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		return mapData.GetGrid(worldPosition);
	}

	private TowerDefenseMapData.TowerDefenseRoute GetRoute(int routeID)
	{
		if (null == mapData)
		{
			return new TowerDefenseMapData.TowerDefenseRoute
			{
				id = -1
			};
		}
		List<TowerDefenseMapData.TowerDefenseRoute> routes = mapData.routes;
		if (routes == null)
		{
			return new TowerDefenseMapData.TowerDefenseRoute
			{
				id = -1
			};
		}
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseMapData.TowerDefenseRoute result = routes.get_Item(i);
			if (result.id == routeID)
			{
				return result;
			}
		}
		return new TowerDefenseMapData.TowerDefenseRoute
		{
			id = -1
		};
	}

	private TowerDefenseMapData.RouteAction GetRouteAction(int routeID, int gridID)
	{
		if (null == mapData)
		{
			return TowerDefenseMapData.RouteAction.Null;
		}
		return mapData.GetRouteAction(routeID, gridID);
	}

	private TowerDefenseMapData.RouteAction GetRouteAction(int routeID, int gridID, int reachedPointIndex)
	{
		if (null == mapData)
		{
			return TowerDefenseMapData.RouteAction.Null;
		}
		return mapData.GetRouteAction(routeID, gridID, reachedPointIndex);
	}

	private int Length2End(int routeID, int gridIndex, int reachedPointIndex)
	{
		if (null == mapData)
		{
			return 0;
		}
		return mapData.Length2End(routeID, gridIndex, reachedPointIndex);
	}

	private bool GridIsMustArrive(int routeID, int gridIndex)
	{
		if (null == mapData)
		{
			return false;
		}
		return mapData.GridIsMustArrive(routeID, gridIndex);
	}

	private bool IsGridOnTheRoute(int routeID, int gridIndex)
	{
		TowerDefenseMapData.TowerDefenseRoute route = GetRoute(routeID);
		if (route.IsNUll)
		{
			return false;
		}
		List<TowerDefenseMapData.RouteGridInfo> routePoints = route.routePoints;
		if (routePoints == null || routePoints.Count == 0)
		{
			return false;
		}
		for (int i = 0; i < routePoints.Count; i++)
		{
			if (routePoints.get_Item(i).ContainsGrid(gridIndex))
			{
				return true;
			}
		}
		return false;
	}

	private int FindMustArriveGrid(int routeID, int reachedPathIndex, List<int> downActionIndexs)
	{
		TowerDefenseMapData.TowerDefenseRoute route = GetRoute(routeID);
		if (route.IsNUll)
		{
			return -1;
		}
		List<TowerDefenseMapData.RouteGridInfo> routePoints = route.routePoints;
		if (routePoints == null || routePoints.Count == 0)
		{
			return -1;
		}
		if (reachedPathIndex < routePoints.Count)
		{
			int gridID = routePoints.get_Item(reachedPathIndex).gridID;
			if (downActionIndexs == null || !downActionIndexs.Contains(gridID))
			{
				return gridID;
			}
		}
		if (reachedPathIndex < routePoints.Count)
		{
			TowerDefenseMapData.RouteGridInfo routeGridInfo = routePoints.get_Item(reachedPathIndex);
			if (reachedPathIndex == routePoints.Count - 1)
			{
				List<int> path2Grid = routeGridInfo.path2Grid;
				if (path2Grid == null || path2Grid.Count == 0)
				{
					return -1;
				}
				return path2Grid.get_Item(path2Grid.Count - 1);
			}
			return routePoints.get_Item(reachedPathIndex + 1).gridID;
		}
		return -1;
	}

	private void UpdateGridInfo(TowerDefenseMapData.TowerGrid grid)
	{
		if (grid.IsNull)
		{
			return;
		}
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		if (towerGrids == null)
		{
			return;
		}
		for (int i = 0; i < towerGrids.Count; i++)
		{
			if (grid.index == towerGrids.get_Item(i).index)
			{
				towerGrids.set_Item(i, grid);
			}
		}
	}

	private TowerDefenseMapData.TowerGrid Move2PreGrid()
	{
		if (null == mapData)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		if (towerGrids == null || towerGrids.Count == 0)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		Vector2 vector = Vector2.zero;
		TowerDefenseMapData.TowerGrid grid = GetGrid(worldPosition);
		if (!grid.IsNull)
		{
			vector = grid.position;
		}
		float num = (float)(-mapData.sizeX) * 0.5f * mapData.gridScale.x;
		float num2 = mapData.gridScale.x * 0.5f;
		bool flag = true;
		while (vector.x > num)
		{
			List<int> list = new List<int>();
			for (int i = 0; i < towerGrids.Count; i++)
			{
				TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
				if (towerGrid.gridDeployType != 2 || towerGrid.index == grid.index || !(towerGrid.position.x <= vector.x) || !(towerGrid.position.x - vector.x >= 0f - num2))
				{
					continue;
				}
				if (flag)
				{
					if (towerGrid.position.y - vector.y >= 0f)
					{
						list.Add(towerGrid.index);
					}
				}
				else
				{
					list.Add(towerGrid.index);
				}
			}
			flag = false;
			if (list.Count == 0)
			{
				vector.x -= mapData.gridScale.x;
				continue;
			}
			if (list.Count == 1)
			{
				return GetGrid(list.get_Item(0));
			}
			return GetGrid(list.Min());
		}
		return TowerDefenseMapData.TowerGrid.Null;
	}

	private TowerDefenseMapData.TowerGrid Move2NextGrid()
	{
		if (null == mapData)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		if (towerGrids == null || towerGrids.Count == 0)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		Vector2 vector = Vector2.zero;
		TowerDefenseMapData.TowerGrid grid = GetGrid(worldPosition);
		if (!grid.IsNull)
		{
			vector = grid.position;
		}
		float num = (float)mapData.sizeX * 0.5f * mapData.gridScale.x;
		float num2 = mapData.gridScale.x * 0.5f;
		bool flag = true;
		while (vector.x < num)
		{
			List<int> list = new List<int>();
			for (int i = 0; i < towerGrids.Count; i++)
			{
				TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
				if (towerGrid.gridDeployType != 2 || towerGrid.index == grid.index || !(towerGrid.position.x >= vector.x) || !(towerGrid.position.x - vector.x <= num2))
				{
					continue;
				}
				if (flag)
				{
					if (towerGrid.position.y - vector.y <= 0f)
					{
						list.Add(towerGrid.index);
					}
				}
				else
				{
					list.Add(towerGrid.index);
				}
			}
			flag = false;
			if (list.Count == 0)
			{
				vector.x += mapData.gridScale.x;
				continue;
			}
			if (list.Count == 1)
			{
				return GetGrid(list.get_Item(0));
			}
			return GetGrid(list.Max());
		}
		return TowerDefenseMapData.TowerGrid.Null;
	}

	private TowerDefenseMapData.TowerGrid Move2PreRoleGrid()
	{
		if (null == mapData)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		if (towerGrids == null || towerGrids.Count == 0)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		Vector2 vector = Vector2.zero;
		TowerDefenseMapData.TowerGrid grid = GetGrid(worldPosition);
		if (!grid.IsNull)
		{
			vector = grid.position;
		}
		float num = (float)(-mapData.sizeX) * 0.5f * mapData.gridScale.x;
		float num2 = mapData.gridScale.x * 0.5f;
		bool flag = true;
		while (vector.x > num)
		{
			List<int> list = new List<int>();
			for (int i = 0; i < towerGrids.Count; i++)
			{
				TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
				if (towerGrid.gridDeployType != 2 || !tokenGridIndex.ContainsKey(towerGrid.index) || towerGrid.index == grid.index || !(towerGrid.position.x <= vector.x) || !(towerGrid.position.x - vector.x >= 0f - num2))
				{
					continue;
				}
				if (flag)
				{
					if (towerGrid.position.y - vector.y >= 0f)
					{
						list.Add(towerGrid.index);
					}
				}
				else
				{
					list.Add(towerGrid.index);
				}
			}
			flag = false;
			if (list.Count == 0)
			{
				vector.x -= mapData.gridScale.x;
				continue;
			}
			if (list.Count == 1)
			{
				return GetGrid(list.get_Item(0));
			}
			return GetGrid(list.Min());
		}
		return TowerDefenseMapData.TowerGrid.Null;
	}

	private TowerDefenseMapData.TowerGrid Move2NextRoleGrid()
	{
		if (null == mapData)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		if (towerGrids == null || towerGrids.Count == 0)
		{
			return TowerDefenseMapData.TowerGrid.Null;
		}
		Vector2 vector = Vector2.zero;
		TowerDefenseMapData.TowerGrid grid = GetGrid(worldPosition);
		if (!grid.IsNull)
		{
			vector = grid.position;
		}
		float num = (float)mapData.sizeX * 0.5f * mapData.gridScale.x;
		float num2 = mapData.gridScale.x * 0.5f;
		bool flag = true;
		while (vector.x < num)
		{
			List<int> list = new List<int>();
			for (int i = 0; i < towerGrids.Count; i++)
			{
				TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
				if (towerGrid.gridDeployType != 2 || !tokenGridIndex.ContainsKey(towerGrid.index) || towerGrid.index == grid.index || !(towerGrid.position.x >= vector.x) || !(towerGrid.position.x - vector.x <= num2))
				{
					continue;
				}
				if (flag)
				{
					if (towerGrid.position.y - vector.y <= 0f)
					{
						list.Add(towerGrid.index);
					}
				}
				else
				{
					list.Add(towerGrid.index);
				}
			}
			flag = false;
			if (list.Count == 0)
			{
				vector.x += mapData.gridScale.x;
				continue;
			}
			if (list.Count == 1)
			{
				return GetGrid(list.get_Item(0));
			}
			return GetGrid(list.Max());
		}
		return TowerDefenseMapData.TowerGrid.Null;
	}

	private TowerDefensePointerEvent CreatePointerEventGrid(int gridIndex)
	{
		if (null == gridPointerEventsParent)
		{
			gridPointerEventsParent = new GameObject("TowerDefensePointerEventNode");
		}
		if (gridPointerEvents == null)
		{
			gridPointerEvents = new List<TowerDefensePointerEvent>();
		}
		for (int i = 0; i < gridPointerEvents.Count; i++)
		{
			TowerDefensePointerEvent towerDefensePointerEvent = gridPointerEvents.get_Item(i);
			if (gridIndex == towerDefensePointerEvent.index)
			{
				return towerDefensePointerEvent;
			}
		}
		TowerDefensePointerEvent towerDefensePointerEvent2 = null;
		for (int j = 0; j < gridPointerEvents.Count; j++)
		{
			TowerDefensePointerEvent towerDefensePointerEvent3 = gridPointerEvents.get_Item(j);
			if (towerDefensePointerEvent3.index == -1)
			{
				towerDefensePointerEvent2 = towerDefensePointerEvent3;
				break;
			}
		}
		if (null == towerDefensePointerEvent2)
		{
			towerDefensePointerEvent2 = CreateNewPointerEventGrid();
			gridPointerEvents.Add(towerDefensePointerEvent2);
		}
		towerDefensePointerEvent2.name = $"TowerDefensePointerEventGrid_{gridIndex}";
		Vector2 position = GetGrid(gridIndex).position;
		towerDefensePointerEvent2.transform.position = new Vector3(position.x, 0f, position.y);
		towerDefensePointerEvent2.Init(gridIndex);
		return towerDefensePointerEvent2;
	}

	private void OnClickPointerEventGrid(TowerDefensePointerEvent.TowerDefensePointerEventData obj)
	{
		TowerDefenseMapData.TowerGrid grid = GetGrid(obj.index);
		int value;
		if (grid.IsNull)
		{
			Debug.LogError($"未知错误，格子为空{obj.index}");
		}
		else if (tokenGridIndex.TryGetValue(grid.index, out value))
		{
			Debug.LogError($"选中角色{value}");
			SelectRole(value, grid.index);
		}
	}

	private TowerDefensePointerEvent CreateNewPointerEventGrid()
	{
		GameObject gameObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
		gameObject.transform.localScale = new Vector3(mapData.gridScale.x, 0.1f, mapData.gridScale.y);
		MeshRenderer component = gameObject.GetComponent<MeshRenderer>();
		if (null != component)
		{
			component.enabled = false;
		}
		gameObject.transform.SetParent(gridPointerEventsParent.transform);
		return gameObject.AddComponent<TowerDefensePointerEvent>();
	}

	private void ClearGrids()
	{
		if (gridPointerEvents != null)
		{
			for (int i = 0; i < gridPointerEvents.Count; i++)
			{
				TowerDefensePointerEvent towerDefensePointerEvent = gridPointerEvents.get_Item(i);
				towerDefensePointerEvent.Clear();
				UnityEngine.Object.Destroy(towerDefensePointerEvent.gameObject);
				UnityEngine.Object.Destroy(towerDefensePointerEvent);
			}
			gridPointerEvents.Clear();
			gridPointerEvents = null;
			if (null != gridPointerEventsParent)
			{
				UnityEngine.Object.Destroy(gridPointerEventsParent);
				gridPointerEventsParent = null;
			}
		}
	}

	private void InitTipQuads()
	{
		tipQuadAsset = GameResourceLoader.LoadAsset(GameResourceLoader.ResourceType.Any, "Assets/AssetBundles/FX/TowerDefence/fx_td_block_tips.prefab", typeof(GameObject)) as GameObject;
		if (null == tipQuadAsset)
		{
			Debug.LogError("没有找到提示格子资源:Assets/AssetBundles/FX/TowerDefence/fx_td_block_tips.prefab");
			return;
		}
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		int num = 0;
		int num2 = 0;
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
			if (towerGrid.gridWalkableType == 1)
			{
				num++;
			}
			if (towerGrid.gridDeployType == 2)
			{
				num2++;
			}
		}
		if (null == tipQuadParentNode)
		{
			tipQuadParentNode = new GameObject("TipQuadsParentNode");
		}
		if (tipQuads == null)
		{
			tipQuads = new List<TowerDefenseTipQuad>();
		}
		int num3 = Math.Max(num, num2);
		for (int j = 0; j < num3; j++)
		{
			CreateNewTipQuad();
		}
	}

	private void OnPointerEnterGrid(TowerDefensePointerEvent.TowerDefensePointerEventData obj)
	{
		Debug.LogError($"on enter {obj.index}");
	}

	private void OnPointerExitGrid(TowerDefensePointerEvent.TowerDefensePointerEventData obj)
	{
		Debug.LogError($"on exit {obj.index}");
	}

	private void ShowDragRoleTipQuads()
	{
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
			if (towerGrid.gridDeployType == 2 && !tokenGridIndex.ContainsKey(towerGrid.index))
			{
				GetTipQuad(towerGrid.index)?.UpdateState(GetStateNameByState(TipQuadState.OnSuitable));
			}
		}
	}

	private void ShowDragItemTipQuads()
	{
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid grid = towerGrids.get_Item(i);
			if (!GridSatisItem_CanUse(grid))
			{
				FindTipQuad(grid.index)?.UpdateState(GetStateNameByState(TipQuadState.None));
			}
			else
			{
				GetTipQuad(grid.index)?.UpdateState(GetStateNameByState(TipQuadState.OnSuitable));
			}
		}
	}

	private void HideAllDragTipQuads()
	{
		if (tipQuads != null)
		{
			for (int i = 0; i < tipQuads.Count; i++)
			{
				tipQuads.get_Item(i).UpdateState(GetStateNameByState(TipQuadState.None));
			}
		}
	}

	private void UpdateTipQuadState(int index, TipQuadState state)
	{
		TowerDefenseTipQuad tipQuad = GetTipQuad(index);
		if (tipQuad == null)
		{
			Debug.LogError($"没有找到合适的表现格子:{index}");
		}
		else
		{
			tipQuad.UpdateState(GetStateNameByState(state));
		}
	}

	private void UpdateTipQuadsState_Item(int index, TipQuadState state)
	{
		List<int> itemTakeEffectGrids = GetItemTakeEffectGrids(index);
		if (itemTakeEffectGrids == null || itemTakeEffectGrids.Count == 0)
		{
			return;
		}
		for (int i = 0; i < itemTakeEffectGrids.Count; i++)
		{
			TowerDefenseTipQuad tipQuad = GetTipQuad(itemTakeEffectGrids.get_Item(i));
			if (tipQuad == null)
			{
				Debug.LogError($"没有找到合适的表现格子:{index}");
				break;
			}
			tipQuad.UpdateState(GetStateNameByState(state));
		}
	}

	private string GetStateNameByState(TipQuadState state)
	{
		string result = string.Empty;
		switch (state)
		{
		case TipQuadState.OnPointerEnter:
			result = "pass";
			break;
		case TipQuadState.OnSelect:
			result = "select";
			break;
		case TipQuadState.OnSuitable:
			result = "set";
			break;
		case TipQuadState.OnSetable:
			result = "self";
			break;
		}
		return result;
	}

	private TowerDefenseTipQuad FindTipQuad(int index)
	{
		if (tipQuads == null || index < 0)
		{
			return null;
		}
		for (int i = 0; i < tipQuads.Count; i++)
		{
			TowerDefenseTipQuad towerDefenseTipQuad = tipQuads.get_Item(i);
			if (towerDefenseTipQuad.Index == index)
			{
				return towerDefenseTipQuad;
			}
		}
		return null;
	}

	private TowerDefenseTipQuad GetTipQuad(int index)
	{
		if (tipQuads == null)
		{
			return null;
		}
		TowerDefenseTipQuad towerDefenseTipQuad;
		for (int i = 0; i < tipQuads.Count; i++)
		{
			towerDefenseTipQuad = tipQuads.get_Item(i);
			if (towerDefenseTipQuad.Index == index)
			{
				return towerDefenseTipQuad;
			}
		}
		TowerDefenseMapData.TowerGrid grid = GetGrid(index);
		Vector3 position = new Vector3(grid.position.x, 0f, grid.position.y);
		for (int j = 0; j < tipQuads.Count; j++)
		{
			towerDefenseTipQuad = tipQuads.get_Item(j);
			if (towerDefenseTipQuad.Index == -1)
			{
				towerDefenseTipQuad.UpdateIndex(index);
				towerDefenseTipQuad.UpdatePosition(position);
				return towerDefenseTipQuad;
			}
		}
		towerDefenseTipQuad = CreateNewTipQuad();
		towerDefenseTipQuad.UpdateIndex(index);
		towerDefenseTipQuad.UpdatePosition(position);
		return towerDefenseTipQuad;
	}

	private TowerDefenseTipQuad CreateNewTipQuad()
	{
		TowerDefenseTipQuad towerDefenseTipQuad = new TowerDefenseTipQuad();
		GameObject gameObject = UnityEngine.Object.Instantiate(tipQuadAsset);
		gameObject.name = "TowerDefenseTipQuad";
		gameObject.transform.SetParent(tipQuadParentNode.transform);
		towerDefenseTipQuad.Init(gameObject);
		tipQuads.Add(towerDefenseTipQuad);
		return towerDefenseTipQuad;
	}

	private void ClearTipQuads()
	{
		tipQuadAsset = null;
		if (tipQuads != null)
		{
			for (int i = 0; i < tipQuads.Count; i++)
			{
				tipQuads.get_Item(i).Clear();
			}
			tipQuads.Clear();
			tipQuads = null;
		}
		if (null != tipQuadParentNode)
		{
			UnityEngine.Object.Destroy(tipQuadParentNode);
			tipQuadParentNode = null;
		}
		tmpGridDeployTypes?.Clear();
	}

	private void CreateGrassGrid(int index)
	{
		if (GetGrid(index).IsNull)
		{
			return;
		}
		CreateGrassEffect(index);
		if (tmpGridDeployTypes.TryGetValue(index, out var value) && value == GridDeployType.TrapSpawnPoint)
		{
			return;
		}
		if (markForCreateGrass == null)
		{
			markForCreateGrass = new List<int>();
		}
		if (!markForCreateGrass.Contains(index))
		{
			markForCreateGrass.Add(index);
		}
		StartCoroutine(WaitUnitEffectComplete(3f, () =>
		{
			if (markForCreateGrass.Contains(index))
			{
				if (tmpGridDeployTypes.ContainsKey(index))
				{
					tmpGridDeployTypes.set_Item(index, GridDeployType.TrapSpawnPoint);
				}
				markForCreateGrass.Remove(index);
				MonoSingleton<WwiseAudioManager>.Instance?.PlaySound("mode_TD_grass_stop");
			}
		}));
	}

	private IEnumerator WaitUnitEffectComplete(FP waitTime, Action callback)
	{
		yield return WaitTime(waitTime);
		callback?.Invoke();
	}

	private bool RemoveGrassGrid(int index)
	{
		TowerDefenseMapData.TowerGrid grid = GetGrid(index);
		if (grid.IsNull)
		{
			return false;
		}
		UpdateGridInfo(grid);
		if (tmpGridDeployTypes.get_Item(index) == GridDeployType.TrapSpawnPoint)
		{
			tmpGridDeployTypes.set_Item(index, GridDeployType.Default);
		}
		if (markForCreateGrass != null && markForCreateGrass.Contains(index))
		{
			markForCreateGrass.Remove(index);
		}
		return RemoveGrassEffect(index);
	}

	private void InitInputController()
	{
		camera = MonoSingleton<GameCameraStackManager>.Instance.mainCamera;
		mouseFollower = TowerDefenseMouseFollower.Create();
		mouseFollower.InitConfig(camera, followLayer, heightOffset, maxDistance, smoothness);
		TowerDefenseMouseFollower towerDefenseMouseFollower = mouseFollower;
		towerDefenseMouseFollower.onPressDown = (Action<Vector2>)Delegate.Combine(towerDefenseMouseFollower.onPressDown, new Action<Vector2>(OnPressDown));
		TowerDefenseMouseFollower towerDefenseMouseFollower2 = mouseFollower;
		towerDefenseMouseFollower2.onPressUp = (Action<Vector3>)Delegate.Combine(towerDefenseMouseFollower2.onPressUp, new Action<Vector3>(OnPressUp));
		TowerDefenseMouseFollower towerDefenseMouseFollower3 = mouseFollower;
		towerDefenseMouseFollower3.onHold = (Action<Vector2, Vector3>)Delegate.Combine(towerDefenseMouseFollower3.onHold, new Action<Vector2, Vector3>(OnHold));
		TowerDefenseMouseFollower towerDefenseMouseFollower4 = mouseFollower;
		towerDefenseMouseFollower4.onHoldChange = (Action<Vector3, bool>)Delegate.Combine(towerDefenseMouseFollower4.onHoldChange, new Action<Vector3, bool>(OnHoldChange));
		TowerDefenseMouseFollower towerDefenseMouseFollower5 = mouseFollower;
		towerDefenseMouseFollower5.onMove = (Action<Vector3>)Delegate.Combine(towerDefenseMouseFollower5.onMove, new Action<Vector3>(OnPointerMove));
	}

	private void OnPressDown(Vector2 screenPosition)
	{
		_ = blockInput;
	}

	private void OnPointerMove(Vector3 worldPosition)
	{
		if (blockInput)
		{
			return;
		}
		this.worldPosition = worldPosition;
		if (dragState != DragState.None)
		{
			indicator.UpdateIndicator(worldPosition);
		}
		TowerDefenseMapData.TowerGrid grid = GetGrid(worldPosition);
		TowerDefenseMapData.TowerGrid grid2 = GetGrid(preShowPointerGridIndex);
		if (!grid2.IsNull)
		{
			if (tokenGridIndex.TryGetValue(grid2.index, out var value))
			{
				if (value != selectRoleID)
				{
					UpdateTipQuadState(grid2.index, TipQuadState.None);
				}
			}
			else
			{
				UpdateTipQuadState(grid2.index, TipQuadState.None);
			}
		}
		if (dragState == DragState.Item)
		{
			ShowDragItemTipQuads();
			if (GridSatisItem_CanUse(grid))
			{
				UpdateTipQuadsState_Item(grid.index, TipQuadState.OnSelect);
				UpdateTipQuadState(grid.index, TipQuadState.OnSetable);
			}
		}
		else if (dragState == DragState.Role)
		{
			dragRole.SyncMovementLocation(new TSVector2(worldPosition.x, worldPosition.z), worldPosition.y, roleRotation);
			ShowDragRoleTipQuads();
			if (grid.gridDeployType == 2 && !tokenGridIndex.ContainsKey(grid.index) && IsGridDeployableByTheme(grid.index))
			{
				UpdateTipQuadState(grid.index, TipQuadState.OnSetable);
			}
		}
		else
		{
			bool flag = false;
			if (tokenGridIndex.TryGetValue(grid.index, out var value2))
			{
				if (value2 != selectRoleID)
				{
					flag = true;
				}
			}
			else
			{
				flag = true;
			}
			if (flag && (grid.gridDeployType != 0 || grid.gridWalkableType != 0))
			{
				UpdateTipQuadState(grid.index, TipQuadState.OnPointerEnter);
			}
		}
		preShowPointerGridIndex = grid.index;
	}

	private void TryCancelHold()
	{
		if (dragState == DragState.Item)
		{
			UseItemCardFailed();
			HideAllDragTipQuads();
			BindIndicator(DragState.None);
			dragState = DragState.None;
		}
		else if (dragState == DragState.Role)
		{
			DeActiveRoleOutline(dragRoleID);
			SetRoleOnStageFailed(dragRoleID);
			HideAllDragTipQuads();
			BindIndicator(DragState.None);
			dragState = DragState.None;
			dragRoleID = 0;
			dragRole = null;
		}
		else
		{
			TryUnSelectRole();
		}
	}

	private void OnPressUp(Vector3 worldPosition)
	{
		this.worldPosition = worldPosition;
		if (selectUIBtn)
		{
			selectUIBtn = false;
		}
		else
		{
			if (blockInput || (dragState == DragState.None && null != mouseFollower && mouseFollower.IsPointerOverClickableUI()))
			{
				return;
			}
			pressupGrid = GetGrid(worldPosition);
			int value2;
			if (dragState == DragState.Item)
			{
				UseItemCard(pressupGrid.index);
				HideAllDragTipQuads();
				BindIndicator(DragState.None);
				dragState = DragState.None;
			}
			else if (dragState == DragState.Role)
			{
				DeActiveRoleOutline(dragRoleID);
				SetRoleOnStage(pressupGrid.index, dragRoleID);
				HideAllDragTipQuads();
				BindIndicator(DragState.None);
				dragState = DragState.None;
				dragRoleID = 0;
				dragRole = null;
			}
			else if (selectRoleID != 0)
			{
				if (tokenGridIndex.TryGetValue(pressupGrid.index, out var value))
				{
					if (value == selectRoleID)
					{
						return;
					}
					foreach (KeyValuePair<int, int> item in tokenGridIndex)
					{
						if (item.Value == selectRoleID)
						{
							UnSelectRole(selectRoleID, item.Key);
							break;
						}
					}
					SelectRole(value, pressupGrid.index);
				}
				else
				{
					TryUnSelectRole();
				}
			}
			else if (tokenGridIndex.TryGetValue(pressupGrid.index, out value2))
			{
				SelectRole(value2, pressupGrid.index);
			}
		}
	}

	public void OnHold(Vector2 screenPosition, Vector3 worldPosition)
	{
		lua.FireEvent("TOWERDEFENSE_HOLDCARD", screenPosition);
		this.worldPosition = worldPosition;
		OnPointerMove(worldPosition);
	}

	public void OnHoldChange(Vector3 worldPosition, bool isHold)
	{
		this.worldPosition = worldPosition;
		lua.FireEvent("TOWERDEFENSE_HOLDCARDCHANGE", isHold);
	}

	protected void OnStartDragRole(int roleID)
	{
		TryUnSelectRole();
		if (curRoles.TryGetValue(roleID, out var value))
		{
			dragState = DragState.Role;
			dragRoleID = roleID;
			dragRole = value;
			mouseFollower.StartFollow();
			dragRole.Visible();
			ActiveRoleOutline(roleID);
			ShowDragRoleTipQuads();
			BindIndicator(DragState.Role, dragRoleID, dragRole.gameObject);
		}
	}

	private void BindIndicator(DragState state, int roleID = 0, GameObject bindObj = null)
	{
		switch (state)
		{
		case DragState.Item:
			SetIndicatorRole(null);
			indicator.BindValue(ItemIndicatorRng.AsFloat());
			break;
		case DragState.Role:
		{
			FP fP = FP.One;
			FP fP2 = FP.One;
			TowerDefenseCharacter towerDefenseCharacter = Singleton<HotfixDataController>.Instance.GetTowerDefenseCharacter(roleID);
			if (towerDefenseCharacter != null)
			{
				fP = FP.FromMyriad(towerDefenseCharacter.SearchRadius);
				fP2 = FP.FromMyriad(towerDefenseCharacter.SkillRadius);
			}
			curRoles.TryGetValue(roleID, out var value);
			if (null != value)
			{
				fP = value.EffectiveSearchRange;
			}
			SetIndicatorRole(value);
			indicator.BindValue((float)fP, (float)fP2, bindObj);
			break;
		}
		default:
			SetIndicatorRole(null);
			indicator.Hide();
			break;
		}
	}

	private void SetIndicatorRole(TowerDefenseCharacterActor role)
	{
		if (!(indicatorRole == role))
		{
			if (null != indicatorRole)
			{
				TowerDefenseCharacterActor towerDefenseCharacterActor = indicatorRole;
				towerDefenseCharacterActor.onEffectiveSearchRangeChanged = (Action<TowerDefenseCharacterActor>)Delegate.Remove(towerDefenseCharacterActor.onEffectiveSearchRangeChanged, new Action<TowerDefenseCharacterActor>(OnRoleEffectiveSearchRangeChanged));
			}
			indicatorRole = role;
			if (null != indicatorRole)
			{
				TowerDefenseCharacterActor towerDefenseCharacterActor2 = indicatorRole;
				towerDefenseCharacterActor2.onEffectiveSearchRangeChanged = (Action<TowerDefenseCharacterActor>)Delegate.Combine(towerDefenseCharacterActor2.onEffectiveSearchRangeChanged, new Action<TowerDefenseCharacterActor>(OnRoleEffectiveSearchRangeChanged));
			}
		}
	}

	private void OnRoleEffectiveSearchRangeChanged(TowerDefenseCharacterActor role)
	{
		if (!(role != indicatorRole) && !(null == indicator))
		{
			indicator.RefreshRange1((float)role.EffectiveSearchRange);
		}
	}

	private void OnStartDragItem()
	{
		TryUnSelectRole();
		dragState = DragState.Item;
		BindIndicator(DragState.Item);
		ShowDragItemTipQuads();
	}

	private void OnCardPointer(bool enter)
	{
		mouseFollower.PointCard(enter);
	}

	private void BlockInput(bool block)
	{
		blockInput = block;
	}

	private void CancelHoldState(bool cancel = true)
	{
		if (!worldPosition.Equals(Vector3.zero))
		{
			OnPressUp(worldPosition);
		}
		if (cancel)
		{
			mouseFollower?.CancelHoldState();
		}
	}

	private void ClearInputController()
	{
		SetIndicatorRole(null);
		TowerDefenseMouseFollower towerDefenseMouseFollower = mouseFollower;
		towerDefenseMouseFollower.onPressDown = (Action<Vector2>)Delegate.Remove(towerDefenseMouseFollower.onPressDown, new Action<Vector2>(OnPressDown));
		TowerDefenseMouseFollower towerDefenseMouseFollower2 = mouseFollower;
		towerDefenseMouseFollower2.onPressUp = (Action<Vector3>)Delegate.Remove(towerDefenseMouseFollower2.onPressUp, new Action<Vector3>(OnPressUp));
		TowerDefenseMouseFollower towerDefenseMouseFollower3 = mouseFollower;
		towerDefenseMouseFollower3.onHold = (Action<Vector2, Vector3>)Delegate.Remove(towerDefenseMouseFollower3.onHold, new Action<Vector2, Vector3>(OnHold));
		TowerDefenseMouseFollower towerDefenseMouseFollower4 = mouseFollower;
		towerDefenseMouseFollower4.onHoldChange = (Action<Vector3, bool>)Delegate.Remove(towerDefenseMouseFollower4.onHoldChange, new Action<Vector3, bool>(OnHoldChange));
		TowerDefenseMouseFollower towerDefenseMouseFollower5 = mouseFollower;
		towerDefenseMouseFollower5.onMove = (Action<Vector3>)Delegate.Remove(towerDefenseMouseFollower5.onMove, new Action<Vector3>(OnPointerMove));
		mouseFollower.Clear();
		UnityEngine.Object.Destroy(mouseFollower.gameObject);
		UnityEngine.Object.Destroy(mouseFollower);
		mouseFollower = null;
		camera = null;
		dragRole = null;
		dragRoleID = 0;
	}

	protected CoroutineNode WaitFrame(int f)
	{
		return StartCoroutine(WaitFrameIE(f));
	}

	protected CoroutineNode WaitUntil_GroupComplete(int groupID)
	{
		return StartCoroutine(WaitUntil_GroupCompleteIE(groupID));
	}

	protected CoroutineNode WaitUntil_SpecialGroupComplete(int groupID)
	{
		return StartCoroutine(WaitUntil_SpecialGroupCompleteIE(groupID));
	}

	protected CoroutineNode WaitUntil_WaveComplete()
	{
		return StartCoroutine(WaitUntil_WaveCompleteIE());
	}

	protected CoroutineNode WaitUntil_GroupClear(int groupID)
	{
		return StartCoroutine(WaitUntil_GroupClearIE(groupID));
	}

	protected CoroutineNode WaitUtil_LevelTime(FP s)
	{
		return StartCoroutine(WaitUtil_LevelTimeIE(s));
	}

	protected abstract void InitSpawnContainer();

	protected void PreloadMonster(int mID)
	{
		MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.PreloadMonster(mID, isRoguelikeMonster: false);
	}

	protected void PreloadMonster(List<int> mIDs)
	{
		if (mIDs != null)
		{
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.PreloadMonsters_IDList(mIDs, isRoguelikeMonster: false);
		}
	}

	protected void CompleteCurWave()
	{
		if (curActivedWave != null)
		{
			curActivedWave.Complete();
			curActivedWave = null;
		}
	}

	protected void CompleteNormalGroup(int groupID)
	{
		if (curActivedWave == null)
		{
			Debug.LogError("当前没有已激活的波次，无法执行关闭组的行为!");
		}
		else
		{
			curActivedWave.Active(groupID);
		}
	}

	protected void ActiveSpecialGroup(int groupID)
	{
		if (specialSpawnWave == null)
		{
			Debug.LogError("当前没有永续怪物组，无法执行激活组的行为!");
		}
		else
		{
			specialSpawnWave.Active(groupID);
		}
	}

	protected void CompleteSpecialGroup(int groupID)
	{
		if (specialSpawnWave == null)
		{
			Debug.LogError("当前没有永续怪物组，无法执行激活组的行为!");
		}
		else
		{
			specialSpawnWave.Complete(groupID);
		}
	}

	protected TowerDefense_MonsterSpawnWave GetWave(int waveID)
	{
		if (normalSpawnWaves == null || normalSpawnWaves.Count == 0)
		{
			Debug.LogError("常规波次为空!");
			return null;
		}
		for (int i = 0; i < normalSpawnWaves.Count; i++)
		{
			TowerDefense_MonsterSpawnWave towerDefense_MonsterSpawnWave = normalSpawnWaves.get_Item(i);
			if (towerDefense_MonsterSpawnWave.id == waveID)
			{
				return towerDefense_MonsterSpawnWave;
			}
		}
		Debug.LogError($"没有找到目标常规波次:{waveID}");
		return null;
	}

	protected TowerDefense_MonsterSpawnGroup GetGroup(int waveID, int groupID)
	{
		return GetWave(waveID)?.GetGroup(groupID);
	}

	protected void AddGroupToWave_Special(int groupID, int spawnPointID, int routeID, int monsterTotalNum, List<int> monsters, FP refRotation, FP refDuration)
	{
		if (specialSpawnWave != null)
		{
			specialSpawnWave.AddGroup(groupID, spawnPointID, routeID, monsterTotalNum, monsters, refRotation, refDuration);
		}
	}

	protected void AddWave(int waveID)
	{
		for (int i = 0; i < normalSpawnWaves.Count; i++)
		{
			if (normalSpawnWaves.get_Item(i).id == waveID)
			{
				Debug.LogError($"已存在同样ID的怪物波次:{waveID}");
				return;
			}
		}
		normalSpawnWaves.Add(new TowerDefense_MonsterSpawnWave(waveID, cycle: false));
	}

	protected void AddGroupToWave(int waveID, int groupID, int spawnPointID, int routeID, int monsterTotalNum, List<int> monsters, FP refRotation, FP refDuration)
	{
		GetWave(waveID)?.AddGroup(groupID, spawnPointID, routeID, monsterTotalNum, monsters, refRotation, refDuration);
	}

	protected bool ActiveWave(int waveID)
	{
		for (int i = 0; i < normalSpawnWaves.Count; i++)
		{
			TowerDefense_MonsterSpawnWave towerDefense_MonsterSpawnWave = normalSpawnWaves.get_Item(i);
			if (towerDefense_MonsterSpawnWave.id == waveID && towerDefense_MonsterSpawnWave.spawnState == TowerDefense_SpawnState.DeActived)
			{
				curActivedWave = towerDefense_MonsterSpawnWave;
			}
		}
		if (curActivedWave == null)
		{
			return false;
		}
		curActivedWave.RegisterFixedAction(SpawnFixedAction);
		curActivedWave.Active();
		return true;
	}

	protected void ActiveGroup(int groupID)
	{
		if (curActivedWave == null)
		{
			Debug.LogError("当前没有已激活的波次，无法执行激活组的行为!");
		}
		else
		{
			curActivedWave.Active(groupID);
		}
	}

	protected void GiveARoleCard()
	{
		if (roles == null || roles.Count == 0)
		{
			Debug.Log("没有角色卡了");
			return;
		}
		GiveARoleCard(roles.get_Item(0));
		roles.RemoveAt(0);
	}

	protected void SetRoleOnStage(int gridIndex, int roleID, Action<bool> callback = null)
	{
		if (roleID <= 0)
		{
			callback?.Invoke(obj: false);
			return;
		}
		TowerDefenseMapData.TowerGrid grid = GetGrid(gridIndex);
		int value;
		if (grid.IsNull || grid.gridDeployType != 2)
		{
			callback?.Invoke(obj: false);
			SetRoleOnStageFailed(roleID);
		}
		else if (!IsGridDeployableByTheme(gridIndex))
		{
			callback?.Invoke(obj: false);
			SetRoleOnStageFailed(roleID);
		}
		else if (tokenGridIndex.TryGetValue(gridIndex, out value) && value > 0)
		{
			callback?.Invoke(obj: false);
			SetRoleOnStageFailed(roleID);
		}
		else
		{
			SetRoleOnStageSuccess(grid, roleID);
		}
	}

	protected void GiveARoleCard(int role, bool tip = true)
	{
		lua.FireEvent("TOWERDEFENSE_GIVE_A_ROLE_CARD", role, tip);
	}

	protected void ShowRoutes(float duration = 1f, int showCount = 1)
	{
		if (routeLines == null)
		{
			return;
		}
		List<TowerDefenseMapData.TowerDefenseRoute> routes = mapData.routes;
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseMapData.TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			if (!towerDefenseRoute.Reachable2End())
			{
				continue;
			}
			for (int j = 0; j < routeLines.Count; j++)
			{
				TowerDefenseMapLineController towerDefenseMapLineController = routeLines.get_Item(j);
				if (towerDefenseMapLineController.id == towerDefenseRoute.id)
				{
					towerDefenseMapLineController.Show(duration, showCount);
					break;
				}
			}
		}
	}

	protected void HideRoutes()
	{
		if (routeLines != null)
		{
			for (int i = 0; i < routeLines.Count; i++)
			{
				routeLines.get_Item(i).Hide();
			}
		}
	}

	protected void ShowRoute(int id, float duration = 1f, int showCount = 1)
	{
		if (routeLines == null)
		{
			return;
		}
		List<TowerDefenseMapData.TowerDefenseRoute> routes = mapData.routes;
		for (int i = 0; i < routes.Count; i++)
		{
			TowerDefenseMapData.TowerDefenseRoute towerDefenseRoute = routes.get_Item(i);
			if (id != routes.get_Item(i).id)
			{
				continue;
			}
			if (!towerDefenseRoute.Reachable2End())
			{
				break;
			}
			for (int j = 0; j < routeLines.Count; j++)
			{
				if (routeLines.get_Item(j).id == id)
				{
					routeLines.get_Item(j).Show(duration, showCount);
				}
			}
		}
	}

	protected void HideRoute(int id)
	{
		if (routeLines == null)
		{
			return;
		}
		for (int i = 0; i < routeLines.Count; i++)
		{
			if (routeLines.get_Item(i).id == id)
			{
				routeLines.get_Item(i).Hide();
			}
		}
	}

	protected void MarkHasDicTopBar()
	{
		lua.FireEvent("TOWERDEFENSE_HAS_DIC");
	}

	protected void ShowMonsterInfoUI(int mDataID)
	{
		lua.FireEvent("TOWERDEFENSE_SHOW_MONSTER_INFO", mDataID);
	}

	protected void ShowUITip(string id, float duration)
	{
		lua.FireEvent("TOWERDEFENSE_SHOW_TIP", id, duration);
	}

	protected void ShowOperateUI(bool showOrClose)
	{
		lua.FireEvent("TOWERDEFENSE_SHOW_OPERATE_UI", showOrClose);
	}

	protected void ShowDicTopbar(int dicID)
	{
		lua.FireEvent("TOWERDEFENSE_SHOW_DIC_TOPBAR", dicID);
	}

	protected void InitItemNum(int initNum, int maxNum)
	{
	}

	protected bool GridSatisItem_CanUse(TowerDefenseMapData.TowerGrid grid)
	{
		if (itemTemplete == null)
		{
			return false;
		}
		return itemTemplete.GridSatisItem_CanUse(grid);
	}

	protected bool GridSatisItem_TakeEffect(TowerDefenseMapData.TowerGrid grid)
	{
		if (itemTemplete == null)
		{
			return false;
		}
		return itemTemplete.GridSatisItem_TakeEffect(grid);
	}

	public void InitItems(TowerDefenseItem itemData)
	{
		if (itemData != null)
		{
			itemID = itemData.Id;
			itemNum = itemData.Amount;
			itemCD = itemData.Cd;
			cdDuration = -99;
			itemTemplete = CreateItemInstance(itemData.Script);
			itemTemplete.InitHost(this);
			itemTemplete.InitConfig(itemData);
		}
	}

	private void ItemLogicStart()
	{
		itemTemplete?.StartChargeLogic();
	}

	private TowerDefenseItemBase CreateItemInstance(string path)
	{
		LocalTypeCache localTypeCache = MonoSingleton<HybridCLRManager>.Instance.LoadLocalTypes(path);
		if (localTypeCache == null)
		{
			return null;
		}
		return Activator.CreateInstance(localTypeCache.type) as TowerDefenseItemBase;
	}

	private void UpdateItemLogic()
	{
		itemTemplete?.UpdateLogic();
	}

	protected void UseItemCard(int gridIndex)
	{
		if (curItemNum <= 0 && !ItemNumLimitless)
		{
			return;
		}
		TowerDefenseMapData.TowerGrid grid = GetGrid(gridIndex);
		if (grid.IsNull || !GridSatisItem_CanUse(grid))
		{
			UseItemCardFailed();
			return;
		}
		if (duration - cdDuration < itemCD)
		{
			UseItemCardFailed();
			return;
		}
		cdDuration = duration;
		itemTemplete.ActOnEntities(onStageEntities);
		if (itemTemplete is TowerDefenseItem_Herbicide)
		{
			List<Vector3> list = new List<Vector3>();
			List<int> nineGrids = GetNineGrids(gridIndex);
			for (int i = 0; i < nineGrids.Count; i++)
			{
				TowerDefenseMapData.TowerGrid grid2 = GetGrid(nineGrids.get_Item(i));
				if (!grid2.IsNull && tmpGridDeployTypes.TryGetValue(grid2.index, out var _) && RemoveGrassGrid(grid2.index))
				{
					list.Add(new Vector3(grid2.position.x, 0f, grid2.position.y));
				}
			}
			(itemTemplete as TowerDefenseItem_Herbicide).TakeEffectPositions(list.ToArray());
		}
		itemTemplete.StartLogic(grid.position.ToTSVector2());
		itemTemplete.MinusItemNum();
		UseItemCardSuccess();
	}

	private List<int> GetNineGrids(int curGridIndex)
	{
		List<int> list = new List<int>();
		TowerDefenseMapData.TowerGrid grid = GetGrid(curGridIndex);
		if (grid.IsNull)
		{
			list.Add(curGridIndex);
			return list;
		}
		int sizeX = mapData.sizeX;
		int sizeY = mapData.sizeY;
		for (int i = -1; i <= 1; i++)
		{
			for (int j = -1; j <= 1; j++)
			{
				int num = grid.x + j;
				int num2 = grid.y + i;
				if (num >= 0 && num < sizeX && num2 >= 0 && num2 < sizeY)
				{
					TowerDefenseMapData.TowerGrid grid2 = GetGrid(num, num2);
					if (!grid2.IsNull)
					{
						list.Add(grid2.index);
					}
				}
			}
		}
		return list;
	}

	private void MonsterClearGrassEvt(int gridIndex)
	{
		if (!GetGrid(gridIndex).IsNull)
		{
			RemoveGrassGrid(gridIndex);
		}
	}

	private void UseItemCardFailed()
	{
		lua.FireEvent("TOWERDEFENSE_USE_ITEM_CARD_RESULT", a1: false);
	}

	private void UseItemCardSuccess()
	{
		lua.FireEvent("TOWERDEFENSE_USE_ITEM_CARD_RESULT", a1: true);
		lua.FireEvent("TOWERDEFENSE_UPDATE_ITEM_CARD", itemID, curItemNum);
	}

	private void ClearItems()
	{
		itemTemplete = null;
	}

	public List<int> GetItemTakeEffectGrids(int index)
	{
		return itemTemplete?.GetItemTakeEffectGrids(index);
	}

	private void UpdateMonsters()
	{
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		if (towerGrids == null || towerGrids.Count == 0 || mMoveInfos == null || mMoveInfos.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<long, MonsterMoveInfo> mMoveInfo in mMoveInfos)
		{
			MonsterMoveInfo value = mMoveInfo.Value;
			MonsterAdventureActor monster = value.actor;
			if (null == monster || value.dropInPothole)
			{
				continue;
			}
			FP minDistance = FP.MaxValue;
			int minDisGridID = -1;
			GetMonsterMinDistanceGrid(monster.tsTransform.Position, out minDistance, out minDisGridID);
			TowerDefenseMapData.TowerGrid grid = GetGrid(minDisGridID);
			if (grid.IsNull || !tmpGridDeployTypes.TryGetValue(grid.index, out var value2))
			{
				continue;
			}
			switch (value2)
			{
			case GridDeployType.Pothole:
			{
				value.dropInPothole = true;
				TowerDefensePauseMonsterMoveEvent towerDefensePauseMonsterMoveEvent2 = TowerDefensePauseMonsterMoveEvent.Generate();
				towerDefensePauseMonsterMoveEvent2.monsterID = mMoveInfo.Key;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(towerDefensePauseMonsterMoveEvent2);
				monster.EnterSceneMove(new TSVector(0, -1, 0), 20, 2, 5, () =>
				{
					monster.DestroySelf();
				});
				PlayDropInWaterEffect(new Vector3(monster.transform.position.x, 0f, monster.transform.position.z));
				break;
			}
			case GridDeployType.Deephole:
			{
				value.dropInPothole = true;
				TowerDefensePauseMonsterMoveEvent towerDefensePauseMonsterMoveEvent = TowerDefensePauseMonsterMoveEvent.Generate();
				towerDefensePauseMonsterMoveEvent.monsterID = mMoveInfo.Key;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(towerDefensePauseMonsterMoveEvent);
				monster.EnterSceneMove(new TSVector(0, -1, 0), 20, 2, 5, () =>
				{
					monster.DestroySelf();
				});
				break;
			}
			case GridDeployType.TrapSpawnPoint:
				MonsterEnterGrass(monster);
				break;
			default:
				MonsterExitGrass(monster);
				break;
			}
		}
		foreach (KeyValuePair<long, MonsterMoveInfo> mMoveInfo2 in mMoveInfos)
		{
			MonsterMoveInfo value3 = mMoveInfo2.Value;
			if (value3 == null || value3.dropInPothole || !value3.finishAction)
			{
				continue;
			}
			MonsterAdventureActor actor = value3.actor;
			if (null == actor)
			{
				continue;
			}
			int routeID = value3.routeID;
			long key = mMoveInfo2.Key;
			int targetGridIndex = value3.targetGridIndex;
			TowerDefenseMapData.TowerGrid grid2 = GetGrid(targetGridIndex);
			FP fP = actor.actorInfo.runSpeed * actor.LogicDeltaTime * 2;
			if (TSVector2.Distance(grid2.position.ToTSVector2(), actor.tsTransform.Position) <= fP)
			{
				if (IsRouteEndPoint(routeID, targetGridIndex))
				{
					LogicEntity logicEntity = ModuleController<AdventureModuleController>.Instance.QueryMonsterEntityByID(key);
					if (null != logicEntity)
					{
						int dataID = actor.dataID;
						actor.ClearSelf();
						MonsterDied(dataID, key, kill: false);
					}
					TowerDefenseMapData.TowerGrid grid3 = GetGrid(targetGridIndex);
					PlayMonsterMove2EndPointEffect(new Vector3(grid3.position.x, 0f, grid3.position.y));
					continue;
				}
				TowerDefenseMapData.TowerGrid nextGrid = GetNextGrid(routeID, targetGridIndex, value3.reachedPathIndex, out var curReachedPointIndex);
				if (nextGrid.IsNull)
				{
					int num = FindMustArriveGrid(routeID, value3.reachedPathIndex, value3.doneActionIndexs);
					if (num != -1)
					{
						MonsterMoveAlongPath(key, routeID, value3, FindPath(targetGridIndex, num), num);
					}
					continue;
				}
				value3.reachedPathIndex = curReachedPointIndex;
				value3.targetGridIndex = nextGrid.index;
				if (GetRouteAction(routeID, targetGridIndex, value3.reachedPathIndex).action <= 0 || value3.finishAction)
				{
					TowerDefenseMapData.RouteAction routeAction = GetRouteAction(routeID, nextGrid.index, curReachedPointIndex);
					MonsterMove(key, routeID, nextGrid, routeAction, nextGrid.index);
				}
				continue;
			}
			FP minDistance2 = FP.MaxValue;
			int minDisGridID2 = -1;
			GetMonsterMinDistanceGrid(actor.tsTransform.Position, out minDistance2, out minDisGridID2);
			if (minDisGridID2 == targetGridIndex)
			{
				continue;
			}
			if (!IsGridOnTheRoute(routeID, minDisGridID2))
			{
				int num2 = FindMustArriveGrid(routeID, value3.reachedPathIndex, value3.doneActionIndexs);
				if (num2 != -1)
				{
					MonsterMoveAlongPath(key, routeID, value3, FindPath(minDisGridID2, num2), num2);
				}
				continue;
			}
			int num3 = Length2End(routeID, minDisGridID2, value3.reachedPathIndex);
			int num4 = Length2End(routeID, targetGridIndex, value3.reachedPathIndex);
			if (num3 <= num4)
			{
				int num5 = FindMustArriveGrid(routeID, value3.reachedPathIndex, value3.doneActionIndexs);
				if (num5 != -1)
				{
					MonsterMoveAlongPath(key, routeID, value3, FindPath(minDisGridID2, num5), num5);
				}
			}
			else
			{
				MonsterMoveAlongPath(key, routeID, value3, FindPath(minDisGridID2, targetGridIndex), targetGridIndex);
			}
		}
	}

	private void MonsterMoveAlongPath(long mID, int routeID, MonsterMoveInfo info, List<int> path, int destGridIndex)
	{
		if (info != null)
		{
			TowerDefenseMapData.TowerGrid to = ((path != null && path.Count > 1) ? GetGrid(path.get_Item(1)) : GetGrid(destGridIndex));
			if (!to.IsNull)
			{
				TowerDefenseMapData.RouteAction routeAction = GetRouteAction(routeID, destGridIndex, info.reachedPathIndex);
				info.targetGridIndex = destGridIndex;
				MonsterMove(mID, routeID, to, routeAction, destGridIndex);
			}
		}
	}

	private void StopAllMonstersMove()
	{
		if (mMoveInfos == null || mMoveInfos.Count == 0)
		{
			return;
		}
		foreach (KeyValuePair<long, MonsterMoveInfo> mMoveInfo in mMoveInfos)
		{
			MonsterAdventureActor actor = mMoveInfo.Value.actor;
			if (!(null == actor))
			{
				TowerDefensePauseMonsterMoveEvent towerDefensePauseMonsterMoveEvent = TowerDefensePauseMonsterMoveEvent.Generate();
				towerDefensePauseMonsterMoveEvent.monsterID = mMoveInfo.Key;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(towerDefensePauseMonsterMoveEvent);
			}
		}
	}

	private void GetMonsterMinDistanceGrid(TSVector2 mPosition, out FP minDistance, out int minDisGridID)
	{
		minDistance = FP.MaxValue;
		minDisGridID = -1;
		List<TowerDefenseMapData.TowerGrid> towerGrids = mapData.towerGrids;
		if (towerGrids == null || towerGrids.Count == 0)
		{
			return;
		}
		for (int i = 0; i < towerGrids.Count; i++)
		{
			TowerDefenseMapData.TowerGrid towerGrid = towerGrids.get_Item(i);
			FP fP = TSVector2.Distance(mPosition, towerGrid.position.ToTSVector2());
			if (fP < minDistance)
			{
				minDistance = fP;
				minDisGridID = towerGrid.index;
			}
		}
	}

	private void MonsterEnterGrass(MonsterAdventureActor monster)
	{
		if (!monster.buffComponent.CheckBuffByBuffID(809001210))
		{
			monster?.buffComponent?.AddBuff(809001210, monster);
		}
	}

	private void MonsterExitGrass(MonsterAdventureActor monster)
	{
		if (monster.buffComponent.CheckBuffByBuffID(809001210))
		{
			monster.buffComponent.RemoveBuffByBuffId(809001210);
		}
	}

	private void MonsterDied(int dataID, long id, bool kill)
	{
		TowerDefenseMonster towerDefenseMonster = Singleton<HotfixDataController>.Instance.GetTowerDefenseMonster(dataID);
		if (towerDefenseMonster != null)
		{
			SearchGroupByMonsterID(id)?.MonsterDied(id);
			if (kill)
			{
				GiveEXP(FP.FromMyriad(towerDefenseMonster.ExpGive));
			}
			else
			{
				ReduceLevelDurabiliity(towerDefenseMonster.HpReduce);
			}
			ReduceMonsterNum(towerDefenseMonster.AmountReduce);
			lua.FireEvent("TOWERDEFENSE_MONSTER_STATE", id, a2: false);
		}
	}

	private void SpawnFixedAction(TowerDefense_MonsterSpawnWave wave, TowerDefense_MonsterSpawnGroup group, int monsterID)
	{
		Debug.Log($"111波次{wave.id}组{group.id}出生怪物{monsterID}");
		int spawnPointId = group.spawnPointId;
		TowerDefenseMapData.TowerGrid grid = GetGrid(spawnPointId);
		Vector2 position = grid.position;
		ActorSpawnInfo spawnInfo = new ActorSpawnInfo(monsterID);
		spawnInfo.position = position.ToTSVector2();
		spawnInfo.positionY = 0;
		spawnInfo.rotation = group.refRotation;
		spawnInfo.spawnGizmo = null;
		spawnInfo.isRoguelikeMonster = false;
		spawnInfo.monsterLevel = 1;
		spawnInfo.enterActionWhenSpawn = true;
		ModuleController<AdventureModuleController>.Instance.SpawnMonster(spawnInfo, (AdventureLevelObjPoolMgr.PoolObj obj, bool b) =>
		{
			MonsterAdventureActor component = obj.gameObject.GetComponent<MonsterAdventureActor>();
			if (!(null == component))
			{
				MonsterSpawned(group, component, grid.index);
			}
		});
	}

	private void MonsterSpawned(TowerDefense_MonsterSpawnGroup group, MonsterAdventureActor monster, int curGridIndex)
	{
		if (mReachedPointIndex == null)
		{
			mReachedPointIndex = new Dictionary<long, int>();
		}
		long id = monster.Id;
		group.SpawnComplete(id);
		int value = 0;
		TowerDefenseMapData.TowerGrid grid = GetGrid(curGridIndex);
		mReachedPointIndex.Add(id, value);
		if (mMoveInfos == null)
		{
			mMoveInfos = new Dictionary<long, MonsterMoveInfo>();
		}
		if (!mMoveInfos.ContainsKey(id))
		{
			MonsterMoveInfo monsterMoveInfo = new MonsterMoveInfo();
			monsterMoveInfo.routeID = group.routeID;
			monsterMoveInfo.targetGridIndex = grid.index;
			monsterMoveInfo.actor = monster;
			mMoveInfos.Add(id, monsterMoveInfo);
		}
		TowerDefenseMapData.RouteAction routeAction = GetRouteAction(group.routeID, curGridIndex);
		MonsterMove(id, group.routeID, grid, routeAction, grid.index);
		lua.FireEvent("TOWERDEFENSE_MONSTER_STATE", id, a2: true);
	}

	private TowerDefense_MonsterSpawnGroup SearchGroupByMonsterID(long mID)
	{
		TowerDefense_MonsterSpawnGroup group_MID = specialSpawnWave.GetGroup_MID(mID);
		if (group_MID != null)
		{
			return group_MID;
		}
		for (int i = 0; i < normalSpawnWaves.Count; i++)
		{
			group_MID = normalSpawnWaves.get_Item(i).GetGroup_MID(mID);
			if (group_MID != null)
			{
				return group_MID;
			}
		}
		return null;
	}

	private void MonsterMove(long mID, int routeID, TowerDefenseMapData.TowerGrid to, TowerDefenseMapData.RouteAction routeAction, int routeActionGridIndex = -1)
	{
		if (!mReachedPointIndex.TryGetValue(mID, out var value))
		{
			return;
		}
		TowerDefenseMonsterActionEvent towerDefenseMonsterActionEvent = TowerDefenseMonsterActionEvent.Generate();
		if (mMoveInfos.TryGetValue(mID, out var value2))
		{
			if (routeAction.action > 0)
			{
				if (routeActionGridIndex == to.index)
				{
					if (value2.HasDoneAction(to.index))
					{
						value2.finishAction = true;
						towerDefenseMonsterActionEvent.actionParam = "0";
						towerDefenseMonsterActionEvent.actionIndex = 0;
					}
					else
					{
						value2.finishAction = false;
						towerDefenseMonsterActionEvent.actionParam = routeAction.param;
						towerDefenseMonsterActionEvent.actionIndex = routeAction.action;
					}
				}
				else
				{
					value2.finishAction = true;
					towerDefenseMonsterActionEvent.actionParam = "0";
					towerDefenseMonsterActionEvent.actionIndex = 0;
				}
			}
			else
			{
				value2.finishAction = true;
				towerDefenseMonsterActionEvent.actionParam = "0";
				towerDefenseMonsterActionEvent.actionIndex = 0;
			}
		}
		towerDefenseMonsterActionEvent.monsterID = mID;
		towerDefenseMonsterActionEvent.nextGridIndex = to.index;
		towerDefenseMonsterActionEvent.nextPoint = to.position.ToTSVector2();
		towerDefenseMonsterActionEvent.routeID = routeID;
		towerDefenseMonsterActionEvent.leftRouteLen = Length2End(routeID, to.index, value);
		ModuleController<AdventureModuleController>.Instance.DispatchEvent(towerDefenseMonsterActionEvent);
	}

	private void ClearMonsterMoveInfos()
	{
		if (mMoveInfos != null)
		{
			mMoveInfos.Clear();
			mMoveInfos = null;
		}
	}

	internal void InitRoles(List<int> roles, List<int> initRoles)
	{
		this.roles = roles;
		tokenGridIndex = new Dictionary<int, int>();
		for (int i = 0; i < initRoles.Count; i++)
		{
			GiveARoleCard(initRoles.get_Item(i), tip: false);
		}
		InitRoleAssets(roles, initRoles);
	}

	private void SetRoleOnStageSuccess(TowerDefenseMapData.TowerGrid grid, int roleID)
	{
		if (curRoles.TryGetValue(roleID, out var value))
		{
			value.SyncMovementLocation(grid.position.ToTSVector2(), 0, roleRotation);
			value.Visible();
			tokenGridIndex.Add(grid.index, roleID);
			lua.FireEvent("TOWERDEFENSE_SET_ROLE_ON_STAGE_RESULT", a1: true, value.Id, roleID, camera.WorldToScreenPointAsHFOV(new Vector3(grid.position.x, value.transform.localScale.y * 0.75f, grid.position.y)));
			value.LogicActive();
			TowerDefenseSetRoleOnStageEvent towerDefenseSetRoleOnStageEvent = TowerDefenseSetRoleOnStageEvent.Generate();
			towerDefenseSetRoleOnStageEvent.dataID = roleID;
			towerDefenseSetRoleOnStageEvent.entityID = value.Id;
			ModuleController<AdventureModuleController>.Instance.DispatchEvent(towerDefenseSetRoleOnStageEvent);
			NotifyThemeRolePlaced(grid.index);
		}
	}

	private void SetRoleOnStageFailed(int roleID)
	{
		if (curRoles.TryGetValue(roleID, out var value))
		{
			value.Hide();
			value.SyncMovementLocation(new TSVector2(999, 999), 999, 0);
			lua.FireEvent("TOWERDEFENSE_SET_ROLE_ON_STAGE_RESULT", a1: false);
		}
	}

	private void SpawnRole(int roleID, TSVector2 pos, FP posY, FP rot, Action<TowerDefenseCharacterActor> callback)
	{
		TowerDefenseCharacter towerDefenseCharacter = Singleton<HotfixDataController>.Instance.GetTowerDefenseCharacter(roleID);
		if (towerDefenseCharacter == null)
		{
			Debug.LogError($"塔防角色没有找到数据:{roleID}");
			return;
		}
		MonsterSkin monsterSkin = Singleton<HotfixDataController>.Instance.GetMonsterSkin(towerDefenseCharacter.SkinId);
		if (monsterSkin == null)
		{
			Debug.LogError($"{roleID}角色皮肤没有找到数据:{towerDefenseCharacter.SkinId}");
			return;
		}
		string model = monsterSkin.Model;
		if (string.IsNullOrEmpty(model))
		{
			return;
		}
		string loadPath = "Assets/AssetBundles/" + model + ".prefab";
		AdventureLevelObjPoolMgr.PoolBase poolBase = SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Player(loadPath);
		if (poolBase == null)
		{
			NovaLogger.Error($"ID={roleID}的角色资源不存在");
			return;
		}
		poolBase.Enabled(enable: true);
		AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
		GameObject gameObject = poolObj.gameObject;
		if (gameObject == null)
		{
			NovaLogger.Error($"ID={roleID}的角色资源不存在");
			return;
		}
		TowerDefenseCharacterActor towerDefenseCharacterActor = gameObject.AddOrGetComponent<TowerDefenseCharacterActor>();
		towerDefenseCharacterActor.SyncMovementLocation(pos, posY, rot);
		towerDefenseCharacterActor.enabled = true;
		towerDefenseCharacterActor.isDeclareDead = false;
		towerDefenseCharacterActor.LoadData(towerDefenseCharacter, monsterSkin, isHotLevel);
		towerDefenseCharacterActor.spawnPoolObj = poolObj;
		towerDefenseCharacterActor.LevelStart();
		towerDefenseCharacterActor.Hide();
		towerDefenseCharacterActor.SyncMovementLocation(new TSVector2(999, 999), 999, 0);
		callback(towerDefenseCharacterActor);
	}

	private void PreloadPlayer(int actorID, TSVector2 pos, FP posY, FP rot, Action<TowerDefenseCharacterActor> callback)
	{
		TowerDefenseCharacter towerDefenseCharacter = Singleton<HotfixDataController>.Instance.GetTowerDefenseCharacter(actorID);
		if (towerDefenseCharacter == null)
		{
			Debug.LogError($"塔防角色没有找到数据:{actorID}");
			return;
		}
		MonsterSkin monsterSkin = Singleton<HotfixDataController>.Instance.GetMonsterSkin(towerDefenseCharacter.SkinId);
		if (monsterSkin == null)
		{
			Debug.LogError($"{actorID}角色皮肤没有找到数据:{towerDefenseCharacter.SkinId}");
			return;
		}
		string model = monsterSkin.Model;
		if (string.IsNullOrEmpty(model))
		{
			return;
		}
		string text = "Assets/AssetBundles/" + model + ".prefab";
		AdventureLevelObjPoolMgr.PoolBase poolBase = SceneSingleton<AdventureLevelObjPoolMgr>.Instance.De_Player(text);
		if (poolBase == null)
		{
			NovaLogger.Error($"ID={actorID}的角色资源不存在");
			return;
		}
		poolBase.Enabled(enable: true);
		AdventureLevelObjPoolMgr.PoolObj poolObj = poolBase as AdventureLevelObjPoolMgr.PoolObj;
		GameObject gameObject = poolObj.gameObject;
		if (gameObject == null)
		{
			NovaLogger.Error($"ID={actorID}的角色资源不存在");
			return;
		}
		TowerDefenseCharacterActor towerDefenseCharacterActor = gameObject.AddOrGetComponent<TowerDefenseCharacterActor>();
		towerDefenseCharacterActor.SyncMovementLocation(pos, posY, rot);
		towerDefenseCharacterActor.enabled = true;
		towerDefenseCharacterActor.isDeclareDead = false;
		towerDefenseCharacterActor.LoadData(towerDefenseCharacter, monsterSkin, isHotLevel);
		towerDefenseCharacterActor.spawnPoolObj = poolObj;
		towerDefenseCharacterActor.LevelStart();
		towerDefenseCharacterActor.Hide();
		towerDefenseCharacterActor.SyncMovementLocation(new TSVector2(999, 999), 999, 0);
		ComboGroup comboGroup = towerDefenseCharacterActor.comboGroup;
		if (null == comboGroup)
		{
			Debug.LogError("没有找到角色comboGroup" + text);
			return;
		}
		ActorRelatedResourceConfig relatedResourceConfig = comboGroup.relatedResourceConfig;
		if (null != relatedResourceConfig)
		{
			MonoSingleton<AdventureModulePreloadAssetsMrg>.Instance.PreloadAssets_RelatedRes(relatedResourceConfig, doPreload: true);
		}
		callback(towerDefenseCharacterActor);
	}

	private void InitRoleAssets(List<int> initRoles1, List<int> initRoles2)
	{
		curRoles = new Dictionary<int, TowerDefenseCharacterActor>();
		for (int i = 0; i < initRoles1.Count; i++)
		{
			int role = initRoles1.get_Item(i);
			PreloadPlayer(role, TSVector2.zero, 0, roleRotation, (TowerDefenseCharacterActor actor) =>
			{
				curRoles.Add(role, actor);
			});
		}
		for (int num = 0; num < initRoles2.Count; num++)
		{
			int role2 = initRoles2.get_Item(num);
			PreloadPlayer(role2, TSVector2.zero, 0, roleRotation, (TowerDefenseCharacterActor actor) =>
			{
				curRoles.Add(role2, actor);
			});
		}
	}

	protected void RoleLevelUp(int id, int level, Vector2 screenPosition)
	{
		foreach (KeyValuePair<int, int> item in tokenGridIndex)
		{
			if (item.Value != id)
			{
				continue;
			}
			TowerDefenseCharacter towerDefenseCharacter = Singleton<HotfixDataController>.Instance.GetTowerDefenseCharacter(id);
			if (towerDefenseCharacter == null)
			{
				continue;
			}
			int num = towerDefenseCharacter.PointNeeded.ToArray()[level - 2];
			if (curLevelUpNum >= num)
			{
				ReduceLevelUp(num);
				TowerDefenseMapData.TowerGrid grid = GetGrid(item.Key);
				Vector3 gridPosition = new Vector3(grid.position.x, 0f, grid.position.y);
				PlayRoleLevelUpEffect(screenPosition, gridPosition + Vector3.up * 0.5f, () =>
				{
					PlayRoleLevelUpEffect(level, gridPosition);
					PlayRoleLevelUpUITipEffect(id);
				});
			}
			break;
		}
	}

	private void SelectRole(int roleID, int gridIndex)
	{
		GetGrid(gridIndex);
		if (selectRoleID != roleID)
		{
			selectRoleID = roleID;
			ActiveRoleOutline(selectRoleID);
			UpdateTipQuadState(gridIndex, TipQuadState.OnSelect);
			lua.FireEvent("TOWERDEFENSE_SHOW_ROLE_ICON", selectRoleID, a2: true);
			if (curRoles.TryGetValue(selectRoleID, out var value))
			{
				BindIndicator(DragState.Role, selectRoleID, value.gameObject);
				indicator.UpdateIndicator(value.gameObject.transform.position);
			}
		}
		else
		{
			selectRoleID = 0;
		}
	}

	private void TryUnSelectRole()
	{
		if (tokenGridIndex == null)
		{
			return;
		}
		foreach (KeyValuePair<int, int> item in tokenGridIndex)
		{
			if (item.Value == selectRoleID)
			{
				UnSelectRole(selectRoleID, item.Key);
				break;
			}
		}
	}

	private void UnSelectRole(int roleID, int gridIndex)
	{
		selectRoleID = 0;
		DeActiveRoleOutline(roleID);
		UpdateTipQuadState(gridIndex, TipQuadState.None);
		lua.FireEvent("TOWERDEFENSE_SHOW_ROLE_ICON", selectRoleID, a2: false);
		BindIndicator(DragState.None);
	}

	private void ActiveRoleOutline(int roleID)
	{
		if (curRoles.TryGetValue(roleID, out var value))
		{
			SceneSingleton<AdventureIndicatorController>.Instance.ActiveHighlightOutline(value.gameObject, roleOutlineColor);
		}
	}

	private void DeActiveRoleOutline(int roleID)
	{
		if (curRoles.TryGetValue(roleID, out var value))
		{
			SceneSingleton<AdventureIndicatorController>.Instance.DeactiveHighlightOutline(value.gameObject);
		}
	}

	private void ClearRoles()
	{
		tokenGridIndex?.Clear();
		tokenGridIndex = null;
		curRoles?.Clear();
		curRoles = null;
	}

	private static string GetThemeEnvironmentScriptPath(int gamePlayType)
	{
		return (HotfixEnum.TDLevelGamePlayType)gamePlayType switch
		{
			HotfixEnum.TDLevelGamePlayType.Hot => "AIScript.TowerDefenseThemeEnvironment_Hot", 
			HotfixEnum.TDLevelGamePlayType.Dark => "AIScript.TowerDefenseThemeEnvironment_Dark", 
			_ => null, 
		};
	}

	internal void InitLevelGamePlayType(int gamePlayType)
	{
		isHotLevel = gamePlayType == 2;
		InitThemeEnvironment(gamePlayType);
	}

	private void InitThemeEnvironment(int gamePlayType)
	{
		string themeEnvironmentScriptPath = GetThemeEnvironmentScriptPath(gamePlayType);
		if (!string.IsNullOrEmpty(themeEnvironmentScriptPath))
		{
			themeEnvironment = CreateThemeEnvironmentInstance(themeEnvironmentScriptPath);
			if (themeEnvironment == null)
			{
				Debug.LogError("主题环境加载失败:" + themeEnvironmentScriptPath);
			}
			else
			{
				themeEnvironment.Init(this);
			}
		}
	}

	private TowerDefenseThemeEnvironmentBase CreateThemeEnvironmentInstance(string path)
	{
		LocalTypeCache localTypeCache = MonoSingleton<HybridCLRManager>.Instance.LoadLocalTypes(path);
		if (localTypeCache == null)
		{
			return null;
		}
		return Activator.CreateInstance(localTypeCache.type) as TowerDefenseThemeEnvironmentBase;
	}

	private void SeedThemeEnvironmentGrid(TowerDefenseMapData.TowerGrid grid)
	{
		themeEnvironment?.SeedGrid(grid);
	}

	private void StartThemeEnvironment()
	{
		themeEnvironment?.OnStart();
	}

	private void UpdateThemeEnvironment()
	{
		themeEnvironment?.OnUpdate();
	}

	private void ClearThemeEnvironment()
	{
		themeEnvironment?.Clear();
		themeEnvironment = null;
	}

	private void NotifyThemeRolePlaced(int gridIndex)
	{
		themeEnvironment?.OnRolePlaced(gridIndex);
	}

	private bool IsGridDeployableByTheme(int gridIndex)
	{
		return themeEnvironment?.IsGridDeployable(gridIndex) ?? true;
	}

	protected void SetLighthouseActive(int gridIndex, bool active)
	{
		if (themeEnvironment is TowerDefenseThemeEnvironment_Dark towerDefenseThemeEnvironment_Dark)
		{
			towerDefenseThemeEnvironment_Dark.SetLighthouseActive(gridIndex, active);
		}
	}

	public bool TryGetRoleIdByGrid(int gridIndex, out int roleId)
	{
		roleId = 0;
		if (tokenGridIndex != null)
		{
			return tokenGridIndex.TryGetValue(gridIndex, out roleId);
		}
		return false;
	}

	public bool TryGetGridIndexByRoleId(int roleId, out int gridIndex)
	{
		gridIndex = -1;
		if (tokenGridIndex == null)
		{
			return false;
		}
		foreach (KeyValuePair<int, int> item in tokenGridIndex)
		{
			if (item.Value == roleId)
			{
				gridIndex = item.Key;
				return true;
			}
		}
		return false;
	}

	public bool TryGetRoleEffectiveSearchRange(int roleId, out FP range)
	{
		range = FP.Zero;
		if (curRoles == null || !curRoles.TryGetValue(roleId, out var value) || value == null)
		{
			return false;
		}
		range = value.EffectiveSearchRange;
		return true;
	}

	public void RemoveRoleBuff(int roleId, int buffId)
	{
		if (curRoles != null && curRoles.TryGetValue(roleId, out var value) && value != null)
		{
			value.buffComponent.RemoveBuffByBuffId(buffId);
		}
	}

	protected CoroutineNode StartCoroutine(IEnumerator e)
	{
		return SceneSingleton<AdventurePlayerController>.Instance.StartLogicCoroutine(e);
	}

	protected void StopCoroutine(CoroutineNode c)
	{
		SceneSingleton<AdventurePlayerController>.Instance.StopLogicCoroutine(c);
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

	private IEnumerator WaitFrameIE(FP f)
	{
		if (f <= 0)
		{
			yield return null;
		}
		while (f > 0)
		{
			yield return null;
			f -= (FP)1;
		}
	}

	private IEnumerator WaitUtil_LevelTimeIE(FP s)
	{
		while (duration < s)
		{
			yield return null;
		}
	}

	private IEnumerator WaitUntil_GroupCompleteIE(int groupID)
	{
		bool flag = true;
		WaitUntil_GroupComplete(groupID, () =>
		{
			flag = false;
		});
		while (flag)
		{
			yield return null;
		}
	}

	protected void WaitUntil_GroupComplete(int groupID, Action callback)
	{
		if (curActivedWave != null)
		{
			curActivedWave.RegisterAction(new TowerDefense_SpawnActionInfo
			{
				state = TowerDefense_SpawnState.Completed,
				id = groupID
			}, (TowerDefense_SpawnActionInfo info) =>
			{
				callback?.Invoke();
			});
		}
	}

	private IEnumerator WaitUntil_SpecialGroupCompleteIE(int groupID)
	{
		bool flag = true;
		WaitUntil_SpecilGroupComplete(groupID, () =>
		{
			flag = false;
		});
		while (flag)
		{
			yield return null;
		}
	}

	protected void WaitUntil_SpecilGroupComplete(int groupID, Action callback)
	{
		if (specialSpawnWave != null)
		{
			specialSpawnWave.RegisterAction(new TowerDefense_SpawnActionInfo
			{
				state = TowerDefense_SpawnState.Completed,
				id = groupID
			}, (TowerDefense_SpawnActionInfo info) =>
			{
				callback?.Invoke();
			});
		}
	}

	private IEnumerator WaitUntil_WaveCompleteIE()
	{
		bool flag = true;
		WaitUntil_WaveComplete(() =>
		{
			flag = false;
		});
		while (flag)
		{
			yield return null;
		}
	}

	protected void WaitUntil_WaveComplete(Action callback)
	{
		if (curActivedWave != null)
		{
			curActivedWave.RegisterAction(new TowerDefense_SpawnActionInfo
			{
				state = TowerDefense_SpawnState.Completed,
				id = -1
			}, (TowerDefense_SpawnActionInfo info) =>
			{
				callback?.Invoke();
			});
		}
	}

	private IEnumerator WaitUntil_GroupClearIE(int groupID)
	{
		bool flag = true;
		WaitUntil_GroupClear(groupID, () =>
		{
			flag = false;
		});
		while (flag)
		{
			yield return null;
		}
	}

	protected void WaitUntil_GroupClear(int groupID, Action callback)
	{
		if (curActivedWave != null)
		{
			curActivedWave.RegisterAction(new TowerDefense_SpawnActionInfo
			{
				state = TowerDefense_SpawnState.MonsterCleard,
				id = groupID
			}, (TowerDefense_SpawnActionInfo info) =>
			{
				callback?.Invoke();
			});
		}
	}

	protected CoroutineNode WaitUntil_WaveClear()
	{
		return StartCoroutine(WaitUntil_WaveClearIE());
	}

	private IEnumerator WaitUntil_WaveClearIE()
	{
		bool flag = true;
		WaitUntil_WaveClear(() =>
		{
			flag = false;
		});
		while (flag)
		{
			yield return null;
		}
	}

	protected void WaitUntil_WaveClear(Action callback)
	{
		if (curActivedWave != null)
		{
			curActivedWave.RegisterAction(new TowerDefense_SpawnActionInfo
			{
				state = TowerDefense_SpawnState.MonsterCleard,
				id = -1
			}, (TowerDefense_SpawnActionInfo info) =>
			{
				callback?.Invoke();
			});
		}
	}

	protected TowerDefenseGameplayBase()
	{
		//IL_00f2: Field data (rva=0x710) could not be found in any section!
		//IL_00f2: Field data (rva=0x710) could not be found in any section!
		int[] array = new int[3];
		RuntimeHelpers.InitializeArray(array, __ldtoken(_003CPrivateImplementationDetails_003E._30196F6F797A6F6C6FABDF0656041580AD09AC07A643F1C6D1A346B2FD60B21E));
		levelups = array;
		base._002Ector();
	}
}
