using Nova.Hotfix;
using TrueSync;
using UnityEngine;

public class TreasureBoxSpawnPoint : BaseSpawnPointGizmo
{
	public enum TreasureBoxLevel
	{
		Low,
		Medium,
		High
	}

	public enum TreasureBoxRefType
	{
		Fixed,
		Random
	}

	public enum TreasureBoxRewardType
	{
		Basic,
		Extra
	}

	public class TreasureBoxSpawnInfo
	{
		public int indexOfMainline;

		public bool isRdmRef;

		public TreasureBoxLevel boxLv;

		public long uniqueID;

		public string name;

		public InteractiveManager.interactiveState interactiveState;

		public TreasureBoxRewardType reType;

		public int prizeType;

		public int x;

		public int y;
	}

	public HotfixEnum.worldLevelType levelType = HotfixEnum.worldLevelType.Mainline;

	public int boxID;

	public TreasureBoxLevel boxLevel;

	public TreasureBoxRefType boxRefType;

	public TreasureBoxRewardType rewardType;

	public int boxIndex;

	[HideInInspector]
	public int boxPrizeType;

	[HideInInspector]
	public int boxThemeId;

	[HideInInspector]
	public TSVector2 randomCenterPos = TSVector2.zero;

	[HideInInspector]
	public FP RandomRotation = 0;

	[HideInInspector]
	public FP RandomAngle = 45;

	public bool isTriggerActived;

	[ReadOnly]
	public float refRng = 50f;

	public bool isRandomPosition;

	private bool hasRandomPosition;

	protected AdventureLevelObjPoolMgr.PoolObj spawnPoolObj;

	protected TreasureBoxSpawnInfo spawnInfo;

	protected InteractiveBox spawnBox;

	public long spawnBoxUniqueID { get; protected set; }

	public bool isTreasureBoxOpened { get; protected set; }

	protected override void OnActive()
	{
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_LEVEL_END", OnLevelEnd);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("TREASURE_BOX_DESPAWN", TreasureBoxDespawn);
		ModuleController<AdventureModuleController>.Instance?.AddEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
	}

	protected override void OnDeactive()
	{
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_LEVEL_END", OnLevelEnd);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("TREASURE_BOX_DESPAWN", TreasureBoxDespawn);
		ModuleController<AdventureModuleController>.Instance?.RemoveEventListener("ADVENTURE_BATTLE_MONSTER_DIED", MonsterDied);
	}

	private void OnLevelEnd(IEvent ievent)
	{
		Despawn();
		spawnInfo = null;
		spawnBox = null;
	}

	private void TreasureBoxDespawn(IEvent ievent)
	{
		if (ievent != null && ((AdventureTreasureBoxDespawnEvent)ievent).uniqueID == spawnBoxUniqueID)
		{
			isTreasureBoxOpened = true;
			Despawn();
			spawnInfo = null;
			spawnBox = null;
		}
	}

	public void InitTreasureInfo(int id, int index)
	{
		boxID = id;
	}

	public override void EnableSpawnLogic()
	{
		if (!isSpawnEnabled)
		{
			_logger?.LogInfo($"激活宝箱点：{gameObject.scene.name}({x},{y})/{transform.GetHierarchyPath()}，宝箱类型:{boxRefType},宝箱等级:{boxLevel}，宝箱ID:{boxID}");
			isSpawnEnabled = true;
			spawnBoxUniqueID = ModuleController<AdventureModuleController>.Instance.GenerateUniqueID();
		}
	}

	private void Update()
	{
	}

	public override void ExecuteSpawnLogic(AdventureActor summoner = null)
	{
		if (boxID <= 0 || spawnBoxUniqueID <= 0)
		{
			return;
		}
		Chest boxData = null;
		ActorSpawnInfo boxSpawnInfo = GetMonsterSpawnInfo();
		ModuleController<AdventureModuleController>.Instance.SpawnTreasureBox(boxSpawnInfo, out boxData, (AdventureLevelObjPoolMgr.PoolObj obj) =>
		{
			spawnPoolObj = obj;
			spawnBox = obj.gameObject.GetComponent<InteractiveBox>();
			GameObject objIcon;
			string dropIconPath;
			if (null == spawnBox)
			{
				_logger.LogError("box is null!");
			}
			else
			{
				Transform transform = obj.gameObject.transform.FindInChildren("icon");
				if (transform != null)
				{
					objIcon = transform.gameObject;
					objIcon.SetActive(value: false);
					dropIconPath = string.Empty;
					switch (boxPrizeType)
					{
					case 1:
					{
						string empty = string.Empty;
						empty = ((boxThemeId >= 10) ? ("theme_" + boxThemeId) : ("theme_0" + boxThemeId));
						dropIconPath = "Assets/AssetBundles/Environment/Common/Icon/Textures/" + empty + ".png";
						break;
					}
					case 2:
					{
						string text = "awd_chr_" + boxThemeId;
						dropIconPath = "Assets/AssetBundles/Environment/Common/Icon/Textures/" + text + ".png";
						break;
					}
					case 3:
						dropIconPath = "Assets/AssetBundles/Icon/Item/item_90031.png";
						break;
					case 4:
						dropIconPath = "Assets/AssetBundles/Icon/Item/item_90042.png";
						break;
					case 5:
						dropIconPath = "Assets/AssetBundles/Icon/Item/item_11.png";
						break;
					default:
						dropIconPath = "Assets/AssetBundles/Icon/Item/item_11.png";
						break;
					}
					GameResourceLoader.LoadAssetAsync(GameResourceLoader.ResourceType.Env, dropIconPath, typeof(Texture), LoadIconCallback);
				}
				MonoSingleton<LuaManager>.Instance.FireEvent("TreasureBoxTrans", obj.gameObject.transform);
				AdventureTreasureBoxSpawnPosEvent adventureTreasureBoxSpawnPosEvent = AdventureTreasureBoxSpawnPosEvent.Generate();
				adventureTreasureBoxSpawnPosEvent.boxPos = new TSVector2(obj.gameObject.transform.position.x, obj.gameObject.transform.position.z);
				adventureTreasureBoxSpawnPosEvent.boxId = boxID;
				ModuleController<AdventureModuleController>.Instance.DispatchEvent(adventureTreasureBoxSpawnPosEvent);
				if (spawnInfo == null)
				{
					spawnInfo = new TreasureBoxSpawnInfo();
					spawnInfo.interactiveState = InteractiveManager.interactiveState.active0;
					spawnInfo.indexOfMainline = boxID;
					spawnInfo.isRdmRef = boxRefType == TreasureBoxRefType.Random;
					spawnInfo.boxLv = boxLevel;
					spawnInfo.name = name;
					spawnInfo.reType = rewardType;
					spawnInfo.prizeType = boxPrizeType;
					spawnInfo.x = (int)(long)boxSpawnInfo.position.x;
					spawnInfo.y = (int)(long)boxSpawnInfo.position.y;
					if (boxData.TnteractionType == 0)
					{
						spawnInfo.interactiveState = InteractiveManager.interactiveState.deactive0;
					}
					spawnInfo.uniqueID = spawnBoxUniqueID;
				}
				spawnBox.InitInteractiveBox(boxData, spawnInfo);
			}
			void LoadIconCallback(Object asset)
			{
				if (null == asset)
				{
					Debug.LogError("宝箱主题:错误的主题Icon路径" + dropIconPath);
				}
				else
				{
					objIcon.GetComponent<Renderer>().material.mainTexture = asset as Texture;
					objIcon.SetActive(value: true);
				}
			}
		});
		isSpawnActived = true;
		Debug.Log($"宝箱出生点:{gameObject.name}({x},{y})/{transform.GetHierarchyPath()}出生宝箱{boxID}");
	}

	public override void UpdateSpawnLogic()
	{
		if (isActiveAndEnabled && isSpawnEnabled && !isTreasureBoxOpened)
		{
			LogicEntity activedPlayerActor = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor;
			if (null == activedPlayerActor)
			{
				_logger.LogError("已激活的角色对象为空：AdventurePlayerController.Instance.activedPlayerActor");
			}
			else if (!isSpawnActived)
			{
				ExecuteSpawnLogic();
			}
		}
	}

	protected TSVector2 GetRandomPosition()
	{
		if (spawnInfo != null)
		{
			return new TSVector2(spawnInfo.x, spawnInfo.y);
		}
		if (randomCenterPos == TSVector2.zero)
		{
			AdventureActor component = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.GetComponent<AdventureActor>();
			if (component != null)
			{
				for (int i = 0; i < 5; i++)
				{
					TSVector2 tSVector = TrueSyncExtensions.RandomPointInsideFan(component.tsTransform.Position, component.dtCollider.Radius * 2.5f, component.dtCollider.Radius * 6, RandomRotation, RandomAngle);
					if (component.QueryPositionReachable(tSVector))
					{
						return tSVector;
					}
				}
			}
		}
		else
		{
			AdventureActor component2 = SceneSingleton<AdventurePlayerController>.Instance.activedPlayerActor.GetComponent<AdventureActor>();
			for (int j = 0; j < 5; j++)
			{
				TSVector2 tSVector2 = TrueSyncExtensions.RandomPointInsideFan(randomCenterPos, component2.dtCollider.Radius * 3, component2.dtCollider.Radius * 6, RandomRotation, RandomAngle);
				if (component2.QueryPositionReachable(tSVector2))
				{
					return tSVector2;
				}
			}
		}
		return new TSVector2(transform.position.x, transform.position.z);
	}

	protected ActorSpawnInfo GetMonsterSpawnInfo(bool callbackImmediately = false)
	{
		ActorSpawnInfo result = new ActorSpawnInfo(boxID);
		result.position = (isRandomPosition ? GetRandomPosition() : new TSVector2(transform.position.x, transform.position.z));
		result.positionY = transform.position.y;
		result.rotation = 0f - transform.rotation.eulerAngles.y;
		result.spawnGizmo = this;
		result.isRoguelikeMonster = levelType == HotfixEnum.worldLevelType.StarTower;
		result.monsterLevel = 1;
		result.callbackImmediately = callbackImmediately;
		return result;
	}

	protected void MonsterDied(IEvent ievent)
	{
		_ = ModuleController<AdventureModuleController>.Instance.levelLoadParams;
		if (ModuleController<AdventureModuleController>.Instance.levelType == HotfixEnum.worldLevelType.StarTower && ((AdventureMonsterDiedEvent)ievent).epicType == HotfixEnum.monsterEpicType.LORD)
		{
			isSpawnEnabled = true;
			spawnBoxUniqueID = ModuleController<AdventureModuleController>.Instance.GenerateUniqueID();
		}
	}

	public void Recycle()
	{
		if (spawnPoolObj != null)
		{
			SceneSingleton<AdventureLevelObjPoolMgr>.Instance.En_SceneObject(spawnPoolObj);
			spawnPoolObj = null;
		}
	}

	public void Despawn()
	{
		isSpawnActived = false;
		if (spawnInfo != null && null != spawnBox)
		{
			spawnInfo.interactiveState = spawnBox._interactiveState;
		}
		if (null != gameObject)
		{
			gameObject.SetActive(value: false);
		}
	}
}
