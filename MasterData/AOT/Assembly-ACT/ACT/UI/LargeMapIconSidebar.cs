using System;
using System.Collections.Generic;
using System.Linq;
using ACT.Battle;
using ACT.Battle.ECS.System.SystemNPC;
using ACT.Config;
using ACT.Core;
using ACT.EventTrack;
using ACT.Game.Data;
using ACT.MissionSystem;
using ACT.Model;
using ACT.MultiPlayer;
using ACT.UI.DataProxy;
using ACT.Utility;
using ACT.ViewControl;
using ACT.World;
using ACT.World.Asset;
using Bamboo.Chronos;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using TMPro;
using Unity.Mathematics;
using UnityEngine;
using UnityEngine.Localization.Components;
using UnityEngine.Localization.Settings;
using UnityEngine.UI;
using frame8.Logic.Misc.Other.Extensions;

namespace ACT.UI;

public class LargeMapIconSidebar : MonoBehaviour, ILifeCycleUIComponent
{
	public LargeMapView view;

	public BetterAnimation betterAnimation;

	public LocalizeStringEvent topNameLocalize;

	public BImage topIconAtlasImage;

	public GameObject missionRoot;

	public LocalizeStringEvent subMissionNameLocalize;

	public LocalizeStringEvent subMissionDescLocalize;

	public GridLayoutGroup missionRewardGridLayoutGroup;

	public GameObject missionRewardRoot;

	public GameObject npcRoot;

	public LocalizeStringEvent npcDescLocalize;

	public GameObject lightHouseRoot;

	public LocalizeStringEvent lightHouseDescLocalize;

	public GameObject transferRoot;

	public LocalizeStringEvent transferDescLocalize;

	public GameObject templeRoot;

	public LocalizeStringEvent templeDescLocalize;

	public GridLayoutGroup templeGridLayoutGroup;

	public StartList templeStartList;

	public StartList elementStartList;

	public TextMeshProUGUI txtLevelRecommendNum;

	public GameObject templeTreasureBox;

	public TextMeshProUGUI templeTreasureBoxCount;

	public GameObject abyssRoot;

	public GameObject monsterPointRoot;

	public GridLayoutGroup monsterPointRewardGridLayoutGroup;

	public Transform monsterPlaceContent;

	public GameObject monsterPlaceCell;

	public GameObject worldBossRoot;

	public LocalizeStringEvent worldBossDescLocalize;

	public GridLayoutGroup worldBossRewardGridLayoutGroup;

	public TextMeshProUGUI worldBossName;

	public TextMeshProUGUI worldBossLocation;

	public BImage worldBossHeadIcon;

	public TextMeshProUGUI worldBossCountDownText;

	public TextMeshProUGUI RemainRewardCountText;

	public GameObject IsDisabled;

	public GameObject IsExplored;

	public ActButton rewardTipsButton;

	public ActButton buyRewardCountButton;

	public GameObject BossRefreshRoot;

	public GameObject normalRoot;

	public LocalizeStringEvent normalDescLocalize;

	public GameObject selfNodeRoot;

	public LocalizeStringEvent selfNodeNameLocalize;

	public Transform selfIconTypeRoot;

	public GameObject selfIconTypePrefab;

	public LocalizeStringEvent selfIconTraceLocalize;

	public TextMeshProUGUI selfIconPointNum;

	public ActButton selfNodeDeleteBtn;

	public ActButton placeNodeBtn;

	public ActButton traceNodeBtn;

	public GameObject collectionPointRoot;

	public GridLayoutGroup collectionPointRewardGridLayoutGroup;

	public Transform collectionPlaceContent;

	public GameObject collectionPlaceCell;

	public LocalizeStringEvent bottomDescLocalize;

	public GameObject customPointBottom;

	public GameObject bottomRoot;

	public ActButton trackBtn;

	public ActButton unTrackBtn;

	public ActButton transferBtn;

	public ActButton wait4RefreshBtn;

	public LocalizeStringEvent wait4RefreshLocalize;

	public GameObject rewardCellPrefab;

	public GameObject commonInfoGroup;

	public GameObject detailInfoGroup;

	public Transform bottomTransform;

	private LargeMapIcon icon;

	private List<ItemKv> missionRewardItemKvs = new List<ItemKv>();

	private CommonUILifeCycle lifeCycle;

	private List<Vector2> bottomPositionList = new List<Vector2>
	{
		new Vector2(-596f, 0f),
		new Vector2(-554.5f, 0f)
	};

	private List<Vector2> topPositionList = new List<Vector2>
	{
		new Vector2(-13.5f, -108f),
		new Vector2(75.5f, -133f)
	};

	private bool activeCommonInfo;

	private MapSubArea curSelectSubArea;

	private List<int> _commonReward;

	private Looper wait4RefreshLooper;

	public bool IsOperating
	{
		get
		{
			CommonUILifeCycle commonUILifeCycle = lifeCycle;
			return commonUILifeCycle == CommonUILifeCycle.Opening || commonUILifeCycle == CommonUILifeCycle.Closing;
		}
	}

	public bool IsOpening => lifeCycle == CommonUILifeCycle.Opening;

	public bool IsClosing => lifeCycle == CommonUILifeCycle.Closing;

	public bool IsNormal => lifeCycle == CommonUILifeCycle.Normal;

	public bool IsHidden => lifeCycle == CommonUILifeCycle.Hidden;

	public void SetIcon(LargeMapIcon icon)
	{
		this.icon = icon;
	}

	public void Show()
	{
		if (icon == null || !IsHidden)
		{
			return;
		}
		ResetAllRoot();
		ActiveCommonInfoGroup(active: false);
		MapIconType type = icon.type;
		if (type == MapIconType.Transfer || type == MapIconType.LightHouse || type == MapIconType.Abyss || type == MapIconType.Raid || type == MapIconType.TemporaryPortal || type == MapIconType.BlockInteract || type == MapIconType.OneWayDoor || type == MapIconType.OneWayDoorOpposite)
		{
			ActiveCommonInfoGroup(active: true);
			InteractObjInit();
		}
		else
		{
			type = icon.type;
			if (type == MapIconType.MainMission || type == MapIconType.SideMission || type == MapIconType.DailyMission || type == MapIconType.LegendMission)
			{
				MissionInit();
			}
			else if (icon.type == MapIconType.MonsterPoint)
			{
				MonsterPointInit();
			}
			else if (icon.type == MapIconType.CollectionPoint)
			{
				CollectionPointInit();
			}
			else if (icon.type == MapIconType.Npc)
			{
				ActiveCommonInfoGroup(active: true);
				NpcInfoInit();
			}
			else if (icon.type == MapIconType.WorldBoss)
			{
				WorldBossInit();
			}
			else if (icon.type == MapIconType.Temple)
			{
				TempleInteractObjInit();
			}
			else if (icon.type == MapIconType.SelfPoint)
			{
				SelfNodeInit();
			}
			else if (LuminApplication.LogEnabled)
			{
				Debug.LogError("图标非法，不允许在侧边栏显示");
			}
		}
		PlayShowAnimation();
	}

	private void ResetSideBarGroupPos()
	{
		bottomTransform.GetComponent<RectTransform>().anchoredPosition = (activeCommonInfo ? bottomPositionList[1] : bottomPositionList[0]);
	}

	private void ActiveCommonInfoGroup(bool active)
	{
		activeCommonInfo = active;
		commonInfoGroup.SetActive(active);
		detailInfoGroup.SetActive(!active);
	}

	public ScrollRect GetActiveScrollView()
	{
		if (commonInfoGroup.activeSelf)
		{
			return commonInfoGroup.GetComponent<ScrollRect>();
		}
		if (detailInfoGroup.activeSelf)
		{
			return detailInfoGroup.GetComponent<ScrollRect>();
		}
		return null;
	}

	public void PlayShowAnimation()
	{
		gameObject.SetActive(value: true);
		betterAnimation.GetSequence("Show").OnPlay((AnimationBuilder _) =>
		{
			lifeCycle = CommonUILifeCycle.Opening;
		}).OnComplete((AnimationBuilder _) =>
		{
			lifeCycle = CommonUILifeCycle.Normal;
		})
			.Play();
	}

	public void Hide()
	{
		betterAnimation.StopAnimation();
		DestroySelfNodeInfo();
		DestroyMissionReward();
		DestroyMonsterPointReward();
		DestroyWorldBossReward();
		DestroyCollectionPointReward();
		DestroyTempleReward();
		PlayHideAnimation();
		icon = null;
		if (wait4RefreshLooper.IsValid())
		{
			wait4RefreshLooper.Cancel();
		}
	}

	public void CloseMe()
	{
		view.UnSelectCurAccurateSelectIcon();
	}

	public void PlayHideAnimation()
	{
		betterAnimation.GetSequence("Hide").OnPlay((AnimationBuilder _) =>
		{
			lifeCycle = CommonUILifeCycle.Closing;
		}).OnComplete((AnimationBuilder _) =>
		{
			lifeCycle = CommonUILifeCycle.Hidden;
			gameObject.SetActive(value: false);
		})
			.Play();
	}

	public void HideImmediately()
	{
		betterAnimation.StopAnimation();
		DestroySelfNodeInfo();
		DestroyMissionReward();
		DestroyMonsterPointReward();
		DestroyCollectionPointReward();
		DestroyWorldBossReward();
		DestroyTempleReward();
		gameObject.SetActive(value: false);
		lifeCycle = CommonUILifeCycle.Hidden;
		icon = null;
		if (wait4RefreshLooper.IsValid())
		{
			wait4RefreshLooper.Cancel();
		}
	}

	public void SetHide()
	{
		gameObject.SetActive(value: false);
		lifeCycle = CommonUILifeCycle.Hidden;
	}

	void ILifeCycleUIComponent.ShowStart()
	{
		lifeCycle = CommonUILifeCycle.Opening;
	}

	void ILifeCycleUIComponent.ShowEnd()
	{
		lifeCycle = CommonUILifeCycle.Normal;
	}

	void ILifeCycleUIComponent.HideStart()
	{
		lifeCycle = CommonUILifeCycle.Closing;
	}

	void ILifeCycleUIComponent.HideEnd()
	{
		lifeCycle = CommonUILifeCycle.Hidden;
		gameObject.SetActive(value: false);
	}

	private void InteractObjInit()
	{
		LargeMapInteractObjIcon largeMapInteractObjIcon = icon as LargeMapInteractObjIcon;
		IconData data = CoreUtils.GetData(largeMapInteractObjIcon.GetIconDataId(), RuntimeConfigs.data.iconDatas);
		topNameLocalize.StringReference.TableEntryReference = data.nameLocal;
		topIconAtlasImage.icon.sprite = largeMapInteractObjIcon.normalAtlasImage.icon.sprite;
		switch (largeMapInteractObjIcon.type)
		{
		case MapIconType.LightHouse:
			lightHouseRoot.SetActive(value: true);
			lightHouseDescLocalize.StringReference.TableEntryReference = data.mapDescription;
			break;
		case MapIconType.Transfer:
		case MapIconType.TemporaryPortal:
			transferRoot.SetActive(value: true);
			transferDescLocalize.StringReference.TableEntryReference = data.mapDescription;
			break;
		case MapIconType.Raid:
			lightHouseRoot.SetActive(value: true);
			lightHouseDescLocalize.StringReference.TableEntryReference = data.mapDescription;
			break;
		default:
			normalRoot.SetActive(value: true);
			normalDescLocalize.StringReference.TableEntryReference = data.mapDescription;
			break;
		}
		ResetBottom();
		transferBtn.OnClick.RemoveAllListeners();
		trackBtn.OnClick.RemoveAllListeners();
		if (largeMapInteractObjIcon.type == MapIconType.Transfer)
		{
			if (largeMapInteractObjIcon.GetStateId() == -2)
			{
				bottomDescLocalize.gameObject.SetActive(value: false);
				SetTransferState(largeMapInteractObjIcon);
			}
			else
			{
				bottomDescLocalize.gameObject.SetActive(value: true);
				LockedStatusIconInit();
			}
		}
		else if (largeMapInteractObjIcon.type == MapIconType.Raid)
		{
			if (largeMapInteractObjIcon.GetStateId() == 1)
			{
				bottomDescLocalize.gameObject.SetActive(value: false);
				SetTransferState(largeMapInteractObjIcon);
			}
			else
			{
				bottomDescLocalize.gameObject.SetActive(value: true);
				LockedStatusIconInit();
			}
		}
		else if (largeMapInteractObjIcon.type == MapIconType.TemporaryPortal)
		{
			if (largeMapInteractObjIcon.GetStateId() == 0)
			{
				bottomDescLocalize.gameObject.SetActive(value: false);
				SetTransferState(largeMapInteractObjIcon);
			}
		}
		else
		{
			bottomDescLocalize.gameObject.SetActive(value: false);
			LockedStatusIconInit();
		}
	}

	private void NpcInfoInit()
	{
		if (!(icon is LargeMapNpcIcon largeMapNpcIcon))
		{
			return;
		}
		NpcConfig data = CoreUtils.GetData(largeMapNpcIcon.GetSwId(), RuntimeConfigs.data.npcConfigs);
		npcDescLocalize.StringReference.TableEntryReference = data.content;
		topNameLocalize.StringReference.TableEntryReference = data.name;
		topIconAtlasImage.icon.sprite = largeMapNpcIcon.normalAtlasImage.icon.sprite;
		npcRoot.SetActive(value: true);
		ResetBottom();
		transferBtn.OnClick.RemoveAllListeners();
		trackBtn.OnClick.RemoveAllListeners();
		bottomDescLocalize.gameObject.SetActive(value: false);
		bottomRoot.SetActive(value: true);
		trackBtn.gameObject.SetActive(value: false);
		if (Singleton<RuntimeNpcManager>.instance.AllNpcDataDic.TryGetValue(largeMapNpcIcon.GetId(), out var value))
		{
			transferBtn.gameObject.SetActive(value: true);
			transferBtn.interactable = !Model<MapModel>.Interface.DisableTPButton;
			int chunkId = value.ChunkID;
			float mapAreaZOffset = MapUtility.ConfigWorldMapGraph.GetMapAreaZOffset(icon.mapArea);
			Vector3 teleportPos = new Vector3(icon.worldPos.x, icon.worldPos.y + 0.2f, mapAreaZOffset);
			transferBtn.OnClick.AddListener(() =>
			{
				Transfer(teleportPos, chunkId);
			});
		}
	}

	private void LockedStatusIconInit()
	{
		bottomRoot.SetActive(value: true);
		trackBtn.gameObject.SetActive(!IsTracedIcon());
		unTrackBtn.gameObject.SetActive(IsTracedIcon());
		unTrackBtn.OnClick.AddListener(() =>
		{
			MapSetupTracePoint(icon, isCancel: true, () =>
			{
				trackBtn.gameObject.SetActive(value: true);
				unTrackBtn.gameObject.SetActive(value: false);
			});
		});
		trackBtn.OnClick.AddListener(() =>
		{
			MapSetupTracePoint(icon, isCancel: false, () =>
			{
				trackBtn.gameObject.SetActive(value: false);
				unTrackBtn.gameObject.SetActive(value: true);
			});
		});
	}

	private void SetTransferState(LargeMapInteractObjIcon interactObjIcon)
	{
		bottomRoot.SetActive(value: true);
		trackBtn.gameObject.SetActive(value: false);
		transferBtn.gameObject.SetActive(value: true);
		transferBtn.interactable = !Model<MapModel>.Interface.DisableTPButton;
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		switch (interactObjIcon.type)
		{
		case MapIconType.Raid:
			if (interactObjIcon.GetStateId() == 1)
			{
				RaidEnterData transfer2 = worldManager.GetWorldStateAssetDataBySGOID(interactObjIcon.GetSwId()) as RaidEnterData;
				int chunkId2 = worldManager.GetChunkIdBySGOID(transfer2.stateWorldAssetUid);
				transferBtn.OnClick.AddListener(() =>
				{
					Transfer(transfer2.GetTeleportPos(), chunkId2);
				});
			}
			break;
		case MapIconType.Temple:
			if (interactObjIcon.GetStateId() == 1)
			{
				TempleEnterData transfer3 = worldManager.GetWorldStateAssetDataBySGOID(interactObjIcon.GetSwId()) as TempleEnterData;
				transferBtn.OnClick.AddListener(() =>
				{
					TransToTemple(transfer3.stateWorldAssetUid);
				});
			}
			break;
		case MapIconType.TemporaryPortal:
			if (interactObjIcon.GetStateId() == 0)
			{
				TemporaryPortalData transfer = worldManager.GetWorldStateAssetDataBySGOID(interactObjIcon.GetSwId()) as TemporaryPortalData;
				int chunkId = worldManager.GetChunkIdBySGOID(transfer.stateWorldAssetUid);
				transferBtn.OnClick.AddListener(() =>
				{
					Transfer(transfer.GetTeleportPos(), chunkId);
				});
			}
			break;
		default:
			transferBtn.OnClick.AddListener(() =>
			{
				Transfer(interactObjIcon);
			});
			break;
		}
	}

	private void MissionInit()
	{
		if (!(icon is LargeMapNormalIcon largeMapNormalIcon))
		{
			return;
		}
		int missionId;
		if (icon is LargeMapMissionIcon largeMapMissionIcon)
		{
			missionId = largeMapMissionIcon.GetMissionId();
		}
		else
		{
			if (!(icon is LargeMapReceiveSideMissionIcon largeMapReceiveSideMissionIcon))
			{
				return;
			}
			missionId = largeMapReceiveSideMissionIcon.GetMissionId();
		}
		MissionConfig missionConfig = Singleton<MissionManager>.instance.GetMissionConfig(missionId);
		MissionBase missionBase = missionConfig.MissionBase;
		Collection data = CoreUtils.GetData(missionConfig.RewardId, RuntimeConfigs.data.collections);
		topNameLocalize.StringReference.TableEntryReference = missionBase.name;
		topIconAtlasImage.icon.sprite = largeMapNormalIcon.normalAtlasImage.icon.sprite;
		missionRoot.SetActive(value: true);
		subMissionNameLocalize.StringReference.TableEntryReference = missionBase.titleDesc;
		subMissionDescLocalize.SetReference(LocalizeTable.LongCommon, missionBase.contentDesc);
		List<ItemKv> list = ((data != null) ? data.certain : missionRewardItemKvs);
		foreach (ItemKv item2 in list)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(rewardCellPrefab, missionRewardGridLayoutGroup.transform);
			gameObject.SetActive(value: true);
			Item item = new Item
			{
				Id = item2.id,
				Count = item2.count
			};
			gameObject.GetComponent<LiteItemUIComponent>().SetData(item, 0L, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
			gameObject.GetComponent<LiteItemUIComponent>().UpdatePerformance();
		}
		missionRewardRoot.SetActive(list.Count > 0);
		view.ViewControlLayers[SubControllerType.sideBarSelectItem].SetTargetTransform(missionRewardGridLayoutGroup.transform);
		ResetBottom();
		bottomDescLocalize.gameObject.SetActive(value: false);
		bottomRoot.SetActive(value: false);
		trackBtn.gameObject.SetActive(value: false);
		transferBtn.gameObject.SetActive(value: false);
	}

	private void MonsterPointInit()
	{
		LargeMapMonsterPointIcon largeMapMonsterPointIcon = icon as LargeMapMonsterPointIcon;
		if (largeMapMonsterPointIcon == null)
		{
			return;
		}
		int enemyId = largeMapMonsterPointIcon.GetEnemyId();
		topNameLocalize.StringReference.TableEntryReference = Model<MaterialTrackModel>.Interface.GetMonsterTypeName(enemyId);
		this.GetImageStation().LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, Model<MaterialTrackModel>.Interface.GetMonsterTypeIconAtlasId(enemyId), topIconAtlasImage);
		Model<MaterialTrackModel>.Interface.GetMonsterTypeReward(enemyId, out _commonReward);
		if (_commonReward != null)
		{
			foreach (int item2 in _commonReward)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(rewardCellPrefab, monsterPointRewardGridLayoutGroup.transform);
				gameObject.SetActive(value: true);
				LiteItemUIComponent component = gameObject.GetComponent<LiteItemUIComponent>();
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2, 0L);
				component.SetData(item, long.MinValue, ItemUIComponentBase.InitType.RewardItem);
				component.UpdatePerformance();
			}
		}
		view.ViewControlLayers[SubControllerType.sideBarSelectItem].SetTargetTransform(monsterPointRewardGridLayoutGroup.transform);
		monsterPointRoot.SetActive(value: true);
		MonsterPointBottomInit(largeMapMonsterPointIcon);
	}

	private void DestroyMonsterPointReward()
	{
		if (icon is LargeMapMonsterPointIcon)
		{
			for (int i = 0; i < monsterPointRewardGridLayoutGroup.transform.childCount; i++)
			{
				UnityEngine.Object.Destroy(monsterPointRewardGridLayoutGroup.transform.GetChild(i).gameObject);
			}
			if (!Model<TrackModel>.Interface.IsTrackingMonsterPoint)
			{
				view.RecycleWantTrackMonsterPointIcon();
			}
		}
	}

	private void CollectionPointInit()
	{
		LargeMapCollectionPointIcon largeMapCollectionPointIcon = icon as LargeMapCollectionPointIcon;
		if (largeMapCollectionPointIcon == null)
		{
			return;
		}
		int configId = largeMapCollectionPointIcon.GetConfigId();
		CollectionPoint data = CoreUtils.GetData(configId, RuntimeConfigs.data.collectionPoints);
		topNameLocalize.StringReference.TableEntryReference = data.pointName;
		this.GetImageStation().LoadSprite(GameLoader.meta.mapIconNameAssetID, Model<TrackModel>.Interface.GetTrackCollectionSpriteId(), topIconAtlasImage);
		Model<MaterialTrackModel>.Interface.GetCollectionPointRewardType(configId, out _commonReward);
		foreach (int item2 in _commonReward)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(rewardCellPrefab, collectionPointRewardGridLayoutGroup.transform);
			gameObject.SetActive(value: true);
			LiteItemUIComponent component = gameObject.GetComponent<LiteItemUIComponent>();
			ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2, 0L);
			component.SetData(item, long.MinValue, ItemUIComponentBase.InitType.RewardItem);
			component.UpdatePerformance();
		}
		view.ViewControlLayers[SubControllerType.sideBarSelectItem].SetTargetTransform(monsterPointRewardGridLayoutGroup.transform);
		collectionPointRoot.SetActive(value: true);
		CollectionPointBottomInit(largeMapCollectionPointIcon);
	}

	private void CollectionPointBottomInit(LargeMapCollectionPointIcon collectionPointIcon)
	{
		if (collectionPointIcon == null)
		{
			return;
		}
		ResetBottom();
		CleanContentRoot(MapIconType.CollectionPoint);
		Dictionary<MapSubArea, List<CollectionTrackPointData>> collectionPointDataByConfigIdAndArea = Model<MaterialTrackModel>.Interface.GetCollectionPointDataByConfigIdAndArea(collectionPointIcon.GetConfigId(), collectionPointIcon.mapArea);
		curSelectSubArea = collectionPointIcon.GetSubArea();
		foreach (KeyValuePair<MapSubArea, List<CollectionTrackPointData>> keyValueData in collectionPointDataByConfigIdAndArea)
		{
			LargeMapTargetPlaceCell component = UnityEngine.Object.Instantiate(collectionPlaceCell, collectionPlaceContent).GetComponent<LargeMapTargetPlaceCell>();
			component.Init(keyValueData.Key, keyValueData.Value.Count);
			component.SetSelected(collectionPointIcon.GetSubArea() == keyValueData.Key);
			component.BindClick(() =>
			{
				if (curSelectSubArea != keyValueData.Key)
				{
					HideImmediately();
					view.ShowSubAreaCollectionPoints(keyValueData.Key);
					RefreshContentRoot(keyValueData.Key, MapIconType.CollectionPoint);
				}
			});
		}
		bottomRoot.SetActive(value: true);
		if (MonoECS.instance.ruleManager.SharedGetState(collectionPointIcon.GetId()) != -2)
		{
			unTrackBtn.OnClick.AddListener(() =>
			{
				Model<MaterialTrackModel>.Interface.UnTrackCollectionPoint(canSendEvents: false);
				trackBtn.gameObject.SetActive(value: true);
				unTrackBtn.gameObject.SetActive(value: false);
				icon.SetIsTrack(isTrack: false);
			});
			trackBtn.OnClick.AddListener(() =>
			{
				Model<MaterialTrackModel>.Interface.TrackCollectionPoint(collectionPointIcon);
				trackBtn.gameObject.SetActive(value: false);
				unTrackBtn.gameObject.SetActive(value: true);
				CheckTransferStatus();
			});
			if (Model<TrackModel>.Interface.IsTrackingCollectionPoint && Model<TrackModel>.Interface.GetTrackCollectionPointId() == collectionPointIcon.GetId())
			{
				unTrackBtn.gameObject.SetActive(value: true);
			}
			else
			{
				trackBtn.gameObject.SetActive(value: true);
			}
		}
	}

	private void DestroyCollectionPointReward()
	{
		if (icon is LargeMapCollectionPointIcon)
		{
			for (int i = 0; i < collectionPointRewardGridLayoutGroup.transform.childCount; i++)
			{
				UnityEngine.Object.Destroy(collectionPointRewardGridLayoutGroup.transform.GetChild(i).gameObject);
			}
			if (!Model<TrackModel>.Interface.IsTrackingCollectionPoint)
			{
				view.RecycleWantTrackCollectionPointIcon();
			}
		}
	}

	private void WorldBossInit()
	{
		LargeMapWorldBossIcon worldBossIcon = icon as LargeMapWorldBossIcon;
		if (worldBossIcon == null)
		{
			return;
		}
		worldBossRoot.SetActive(value: true);
		IsDisabled.SetActive(worldBossIcon.IsDisabled.activeSelf);
		IsExplored.SetActive(worldBossIcon.IsExplored.activeSelf);
		int id = CoreUtils.DetermineActualMonster(worldBossIcon.GetWorldBossId());
		EntityEnemyData data = CoreUtils.GetData(id, RuntimeConfigs.data.entityEnemyDatas);
		EntityData data2 = CoreUtils.GetData(id, RuntimeConfigs.data.entityDatas);
		string localizeString = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data2.nameLocal);
		string localizeString2 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_Common, 2899);
		topNameLocalize.StringReference.TableEntryReference = 0L;
		worldBossName.text = (worldBossIcon.IsExplored.activeSelf ? localizeString : localizeString2);
		BossRefreshRoot.SetActive(worldBossIcon.IsExplored.activeSelf && !Model<WildBossModel>.Interface.CheckWildBossCanBattle(worldBossIcon.GetWorldBossId()));
		worldBossCountDownText.text = ((!Model<WildBossModel>.Interface.CheckWildBossCanBattle(worldBossIcon.GetWorldBossId())) ? Model<WildBossModel>.Interface.GetRemainTime(worldBossIcon.GetWorldBossId()) : "");
		int spriteId = (worldBossIcon.IsExplored.activeSelf ? data.monsterIcon : 99);
		this.GetImageStation().LoadSprite(GameLoader.meta.MonsterCircleHeadAtlasAssetID, spriteId, worldBossHeadIcon);
		RemainRewardCountText.text = $"{Model<WildBossModel>.Interface.CanTakeRewardCount}/{Model<WildBossModel>.Interface.BaseTakeRewardCount}";
		ACT.Config.MapArea data3 = CoreUtils.GetData((int)worldBossIcon.mapArea, RuntimeConfigs.data.mapAreas);
		string localizeString3 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data3.name);
		SubMapArea data4 = CoreUtils.GetData((int)worldBossIcon.GetSubArea(), RuntimeConfigs.data.subMapAreas);
		string localizeString4 = LocalizationUtility.GetLocalizeString(LocalizationUtility.localizeTableName_shortcommon, data4.name);
		worldBossLocation.text = (worldBossIcon.IsExplored.activeSelf ? $"{localizeString3}-{localizeString4}" : string.Format("{0}-{1}", localizeString3, "???"));
		WildBossUse wildBossUse = null;
		foreach (KeyValuePair<int, WildBossUse> wildBossUse2 in RuntimeConfigs.data.wildBossUses)
		{
			if (wildBossUse2.Value.monsterID == worldBossIcon.GetWorldBossId())
			{
				wildBossUse = wildBossUse2.Value;
				break;
			}
		}
		if (wildBossUse != null)
		{
			if (worldBossIcon.IsExplored.activeSelf)
			{
				worldBossDescLocalize.SetReference(LocalizeTable.LongCommon, wildBossUse.bossMessage);
			}
			else
			{
				worldBossDescLocalize.SetReference(LocalizeTable.Common, 2900);
			}
			int curWorldLevel = Model<WorldLevelModel>.Interface.GetCurWorldLevel();
			foreach (ItemKv item2 in CoreUtils.GetData(wildBossUse.rewards[math.clamp(curWorldLevel - 1, 0, 8)], RuntimeConfigs.data.collections).certain)
			{
				GameObject gameObject = UnityEngine.Object.Instantiate(rewardCellPrefab, worldBossRewardGridLayoutGroup.transform);
				gameObject.SetActive(value: true);
				LiteItemUIComponent component = gameObject.GetComponent<LiteItemUIComponent>();
				ItemUnifierProxy item = ItemUnifierProxy.ItemUnifierPool.Get<Item>(item2.id, item2.count);
				component.SetData(item, long.MinValue, ItemUIComponentBase.InitType.RewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				component.UpdatePerformance();
			}
			rewardTipsButton.OnClick.RemoveAllListeners();
			rewardTipsButton.OnClick.AddListener(() =>
			{
				Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_LARGEMAPBOSSREWARD, new LargeMapBossRewardViewData
				{
					monsterId = worldBossIcon.GetWorldBossId()
				});
			});
			buyRewardCountButton.OnClick.RemoveAllListeners();
			buyRewardCountButton.OnClick.AddListener(() =>
			{
				Model<WildBossModel>.Interface.BuyRewardCountView(() =>
				{
					RemainRewardCountText.text = $"{Model<WildBossModel>.Interface.CanTakeRewardCount}/{Model<WildBossModel>.Interface.BaseTakeRewardCount + Model<WildBossModel>.Interface.ExtraCount}";
					Singleton<NewUIManager>.instance.CloseUI(UI_TYPE.UI_POPUPWILDBOSSBUYREWARD);
				});
			});
		}
		view.ViewControlLayers[SubControllerType.sideBarSelectItem].SetTargetTransform(worldBossRewardGridLayoutGroup.transform);
		WorldBossBottomInit(worldBossIcon);
	}

	private void SelfNodeInit()
	{
		LargeMapSelfNodeIcon selfNodeIcon = icon as LargeMapSelfNodeIcon;
		if (selfNodeIcon == null)
		{
			return;
		}
		if (selfNodeRoot != null)
		{
			selfNodeRoot.SetActive(value: true);
		}
		selfNodeNameLocalize.StringReference.TableEntryReference = CoreUtils.GetData(selfNodeIcon.GetSelfNodeIconTypeId(), RuntimeConfigs.data.subIconDatas).name;
		if (selfNodeIcon.selfNodeIcon != null && selfNodeIcon.selfNodeIcon.icon != null)
		{
			topIconAtlasImage.icon.sprite = selfNodeIcon.selfNodeIcon.icon.sprite;
		}
		foreach (SubIconData subIconData in RuntimeConfigs.data.subIconDatas.Values)
		{
			GameObject gameObject = UnityEngine.Object.Instantiate(selfIconTypePrefab, selfIconTypeRoot.transform);
			gameObject.SetActive(value: true);
			LargeMapSelfNodeCell component = gameObject.GetComponent<LargeMapSelfNodeCell>();
			if (!(component != null))
			{
				continue;
			}
			component.Init(subIconData.iconAddress, view.Station);
			component.SetSelected(selfNodeIcon.GetSelfNodeIconTypeId() == subIconData.iconAddress);
			if (component.selected.activeSelf)
			{
				ACT.ViewControl.SelectableEx component2 = gameObject.GetComponent<ACT.ViewControl.SelectableEx>();
				view.ViewControlLayers[SubControllerType.sideBar].SetDefaultSelect(component2);
			}
			component.BindClick(() =>
			{
				if (selfNodeIcon.GetSelfNodeIconTypeId() != subIconData.iconAddress)
				{
					if (selfNodeIcon.GetSelfNodeId() == 0)
					{
						view.UpdateTempSelfNodeIcon(subIconData.iconAddress);
						RefreshSelfNodeIcon();
					}
					else
					{
						view.ModifySelfNodeIconType(selfNodeIcon.GetSelfNodeId(), subIconData.iconAddress, RefreshSelfNodeIcon);
					}
				}
			});
		}
		view.ViewControlLayers[SubControllerType.sideBar].SetTargetTransform(selfIconTypeRoot.transform);
		SelfNodeBottomInit(selfNodeIcon);
	}

	private void RefreshSelfNodeIcon()
	{
		LargeMapSelfNodeIcon largeMapSelfNodeIcon = icon as LargeMapSelfNodeIcon;
		if (!(largeMapSelfNodeIcon == null))
		{
			topIconAtlasImage.icon.sprite = largeMapSelfNodeIcon.selfNodeIcon.icon.sprite;
			RefreshSelfNodeList();
		}
	}

	private void RefreshSelfNodeList()
	{
		LargeMapSelfNodeIcon largeMapSelfNodeIcon = icon as LargeMapSelfNodeIcon;
		if (!(largeMapSelfNodeIcon == null))
		{
			for (int i = 0; i < selfIconTypeRoot.transform.childCount; i++)
			{
				LargeMapSelfNodeCell component = selfIconTypeRoot.GetChild(i).gameObject.GetComponent<LargeMapSelfNodeCell>();
				component.SetSelected(largeMapSelfNodeIcon.GetSelfNodeIconTypeId() == component.IconTypeId);
			}
		}
	}

	private void SelfNodeBottomInit(LargeMapSelfNodeIcon selfNodeIcon)
	{
		ResetBottom();
		customPointBottom.gameObject.SetActive(value: true);
		bottomRoot.SetActive(value: true);
		bottomDescLocalize.gameObject.SetActive(value: false);
		placeNodeBtn.gameObject.SetActive(selfNodeIcon.GetSelfNodeId() == 0);
		traceNodeBtn.gameObject.SetActive(selfNodeIcon.GetSelfNodeId() != 0);
		selfNodeDeleteBtn.gameObject.SetActive(selfNodeIcon.GetSelfNodeId() != 0);
		selfIconPointNum.text = $"区域标记{Model<MapSelfNodeModel>.Interface.GetSelfNodesNumByArea(view.CurShowArea)}/{RuntimeConfigs.data.game.mapSpotLimit}";
		if (traceNodeBtn.gameObject.activeSelf)
		{
			SetLocaliztionTraceBtn();
		}
		if (selfNodeDeleteBtn != null)
		{
			selfNodeDeleteBtn.OnClick.RemoveAllListeners();
			selfNodeDeleteBtn.OnClick.AddListener(() =>
			{
				view.UnSelectCurAccurateSelectIcon();
				view.DeleteSelfNode(selfNodeIcon.GetSelfNodeId(), HideImmediately);
			});
		}
		if (placeNodeBtn != null)
		{
			placeNodeBtn.OnClick.RemoveAllListeners();
			placeNodeBtn.OnClick.AddListener(() =>
			{
				view.PlaceMarkerAtWorldPos();
			});
		}
		if (traceNodeBtn != null)
		{
			traceNodeBtn.OnClick.RemoveAllListeners();
			traceNodeBtn.OnClick.AddListener(() =>
			{
				MapSetupTracePoint(icon, IsTracedIcon(), SetLocaliztionTraceBtn);
			});
		}
	}

	private void SetLocaliztionTraceBtn()
	{
		selfIconTraceLocalize.StringReference.TableEntryReference = (IsTracedIcon() ? 20000013 : 1051);
	}

	public bool IsTracedIcon()
	{
		if (icon != null && Model<MapModel>.Interface.CurrentTraceMapPoint != null)
		{
			MapPointTraceInfo currentTraceMapPoint = Model<MapModel>.Interface.CurrentTraceMapPoint;
			if (icon.type == currentTraceMapPoint.iconType && icon.mapArea == currentTraceMapPoint.mapArea && icon.GetId() == currentTraceMapPoint.pointId)
			{
				return true;
			}
		}
		return false;
	}

	private void DestroySelfNodeInfo()
	{
		if (icon is LargeMapSelfNodeIcon largeMapSelfNodeIcon)
		{
			if (largeMapSelfNodeIcon.GetSelfNodeId() == 0)
			{
				view.ExitPlaceMarkerMode();
			}
			for (int i = 0; i < selfIconTypeRoot.transform.childCount; i++)
			{
				UnityEngine.Object.Destroy(selfIconTypeRoot.transform.GetChild(i).gameObject);
			}
		}
	}

	private void DestroyWorldBossReward()
	{
		for (int i = 0; i < worldBossRewardGridLayoutGroup.transform.childCount; i++)
		{
			UnityEngine.Object.Destroy(worldBossRewardGridLayoutGroup.transform.GetChild(i).gameObject);
		}
	}

	private async void TempleInteractObjInit()
	{
		LargeMapInteractObjIcon interactObjIcon = icon as LargeMapInteractObjIcon;
		CoreUtils.GetData(interactObjIcon.GetIconDataId(), RuntimeConfigs.data.iconDatas);
		topIconAtlasImage.icon.sprite = interactObjIcon.normalAtlasImage.icon.sprite;
		templeRoot.SetActive(value: true);
		ResetBottom();
		transferBtn.OnClick.RemoveAllListeners();
		trackBtn.OnClick.RemoveAllListeners();
		bool isActive = interactObjIcon.GetStateId() == 1;
		int id = interactObjIcon.GetDataId();
		int area = CoreUtils.GetData(id, RuntimeConfigs.data.instanceDungeons).area;
		TempleData data = Model<TempleModel>.Interface.areaTempleDatas[area].FirstOrDefault((TempleData i) => i.templeId == id);
		_ = data?.isComplate;
		TextMeshProUGUI textMeshProUGUI = txtLevelRecommendNum;
		int recommendedLevel = data.staticData.recommendedLevel;
		textMeshProUGUI.text = recommendedLevel.ToString() ?? "";
		topNameLocalize.StringReference.TableEntryReference = data.staticData.name;
		templeDescLocalize.StringReference.TableEntryReference = data.staticData.desc;
		templeStartList.QualityInit(data.gotStars.Count((bool s) => s));
		List<int> limitElements = Model<TempleModel>.Interface.GetLimitElements(id);
		elementStartList.SetElementActive(limitElements);
		int totalTreasureBox = await Model<TempleModel>.Interface.GetTotalTreasureBoxCount(id);
		int num = await Model<TempleModel>.Interface.GetTreasureBoxCount(id);
		templeTreasureBox.SetActive(totalTreasureBox > 0);
		templeTreasureBoxCount.text = $"{num}/{totalTreasureBox}";
		InstanceDungeon data2 = CoreUtils.GetData(interactObjIcon.GetDataId(), RuntimeConfigs.data.instanceDungeons);
		bool value2 = default;
		for (int num2 = 0; num2 < data2.reward.Count; num2++)
		{
			int id2 = data2.reward[num2].id;
			int count = data2.reward[num2].count;
			if (!RuntimeConfigs.data.collections.TryGetValue(count, out var value))
			{
				continue;
			}
			bool flag = (data.stageChallengeTarget != null && data.stageChallengeTarget.TargetReward.TryGetValue(id2, out value2)) & value2;
			foreach (ItemKv item in value.certain)
			{
				int id3 = item.id;
				int count2 = item.count;
				ItemUnifierProxy itemUnifierProxy = ItemUnifierProxy.ItemUnifierPool.Get<Item>(id3, count2);
				itemUnifierProxy.RewardTag = (UniversalItemTag)(num2 + 2);
				GameObject gameObject = UnityEngine.Object.Instantiate(rewardCellPrefab, templeGridLayoutGroup.transform);
				gameObject.SetActive(value: true);
				LiteItemUIComponent component = gameObject.GetComponent<LiteItemUIComponent>();
				component.SetData(itemUnifierProxy, long.MinValue, flag ? ItemUIComponentBase.InitType.RewardItemReceived : ItemUIComponentBase.InitType.WorldSettlementRewardItem, ItemUIComponentBase.ItemCountShowType.OneSide);
				component.UpdatePerformance();
			}
		}
		view.ViewControlLayers[SubControllerType.sideBarSelectItem].SetTargetTransform(templeGridLayoutGroup.transform);
		if (isActive)
		{
			bottomDescLocalize.gameObject.SetActive(value: false);
			SetTransferState(interactObjIcon);
		}
		else
		{
			bottomDescLocalize.gameObject.SetActive(value: true);
			ResetBottom();
			LockedStatusIconInit();
		}
	}

	private void DestroyTempleReward()
	{
		if (view.templeMapScrollRect.lastSelect != null)
		{
			view.templeMapScrollRect.lastSelect.isSelect = false;
			view.templeMapScrollRect.lastSelect = null;
		}
		for (int i = 0; i < templeGridLayoutGroup.transform.childCount; i++)
		{
			UnityEngine.Object.Destroy(templeGridLayoutGroup.transform.GetChild(i).gameObject);
		}
	}

	private void ResetAllRoot()
	{
		missionRoot.SetActive(value: false);
		npcRoot.SetActive(value: false);
		lightHouseRoot.SetActive(value: false);
		transferRoot.SetActive(value: false);
		templeRoot.SetActive(value: false);
		abyssRoot.SetActive(value: false);
		normalRoot.SetActive(value: false);
		monsterPointRoot.SetActive(value: false);
		collectionPointRoot.SetActive(value: false);
		worldBossRoot.SetActive(value: false);
		if (selfNodeRoot != null)
		{
			selfNodeRoot.SetActive(value: false);
		}
	}

	private void ResetBottom()
	{
		bottomRoot.SetActive(value: false);
		trackBtn.OnClick.RemoveAllListeners();
		trackBtn.gameObject.SetActive(value: false);
		unTrackBtn.OnClick.RemoveAllListeners();
		unTrackBtn.gameObject.SetActive(value: false);
		transferBtn.OnClick.RemoveAllListeners();
		transferBtn.gameObject.SetActive(value: false);
		wait4RefreshBtn.OnClick.RemoveAllListeners();
		wait4RefreshBtn.gameObject.SetActive(value: false);
		customPointBottom.gameObject.SetActive(value: false);
		curSelectSubArea = MapSubArea.Unknow;
	}

	private void CleanContentRoot(MapIconType iconType)
	{
		Transform transform = iconType switch
		{
			MapIconType.MonsterPoint => monsterPlaceContent, 
			MapIconType.CollectionPoint => collectionPlaceContent, 
			_ => null, 
		};
		if (!(transform != null))
		{
			return;
		}
		Transform[] children = transform.GetChildren();
		foreach (Transform transform2 in children)
		{
			if ((bool)transform2)
			{
				UnityEngine.Object.Destroy(transform2.gameObject);
			}
		}
	}

	private void RefreshContentRoot(MapSubArea subArea, MapIconType iconType)
	{
		curSelectSubArea = subArea;
		Transform transform = iconType switch
		{
			MapIconType.MonsterPoint => monsterPlaceContent, 
			MapIconType.CollectionPoint => collectionPlaceContent, 
			_ => null, 
		};
		if (!(transform != null))
		{
			return;
		}
		Transform[] children = transform.GetChildren();
		foreach (Transform transform2 in children)
		{
			if ((bool)transform2)
			{
				LargeMapTargetPlaceCell component = transform2.GetComponent<LargeMapTargetPlaceCell>();
				component.SetSelected(subArea == component.GetSubArea());
			}
		}
	}

	private void MonsterPointBottomInit(LargeMapMonsterPointIcon monsterPointIcon)
	{
		ResetBottom();
		CleanContentRoot(MapIconType.MonsterPoint);
		Dictionary<MapSubArea, List<MonsterTrackPointData>> showMonsterTrackPointDataGroupBySubArea = Model<MaterialTrackModel>.Interface.GetShowMonsterTrackPointDataGroupBySubArea(monsterPointIcon.GetEnemyId(), monsterPointIcon.mapArea);
		curSelectSubArea = monsterPointIcon.GetSubArea();
		foreach (KeyValuePair<MapSubArea, List<MonsterTrackPointData>> keyValueData in showMonsterTrackPointDataGroupBySubArea)
		{
			LargeMapTargetPlaceCell component = UnityEngine.Object.Instantiate(monsterPlaceCell, monsterPlaceContent).GetComponent<LargeMapTargetPlaceCell>();
			component.Init(keyValueData.Key, keyValueData.Value.Count);
			component.SetSelected(monsterPointIcon.GetSubArea() == keyValueData.Key);
			component.BindClick(() =>
			{
				if (curSelectSubArea != keyValueData.Key)
				{
					HideImmediately();
					view.ShowSubAreaMonsterPoints(keyValueData.Key);
					RefreshContentRoot(keyValueData.Key, MapIconType.MonsterPoint);
				}
			});
		}
		bottomRoot.SetActive(value: true);
		if (MonoECS.instance.ruleManager.SharedGetState(monsterPointIcon.GetUid()) != -2)
		{
			unTrackBtn.OnClick.AddListener(() =>
			{
				Model<MaterialTrackModel>.Interface.UnTrackEnemyType(canSendEvents: false);
				trackBtn.gameObject.SetActive(value: true);
				unTrackBtn.gameObject.SetActive(value: false);
				icon.SetIsTrack(isTrack: false);
			});
			trackBtn.OnClick.AddListener(() =>
			{
				Model<MaterialTrackModel>.Interface.TrackEnemyPoint(monsterPointIcon);
				trackBtn.gameObject.SetActive(value: false);
				unTrackBtn.gameObject.SetActive(value: true);
				CheckTransferStatus();
			});
			if (Model<TrackModel>.Interface.IsTrackingMonsterPoint && Model<TrackModel>.Interface.GetTrackMonsterPointId() == monsterPointIcon.GetUid())
			{
				unTrackBtn.gameObject.SetActive(value: true);
			}
			else
			{
				trackBtn.gameObject.SetActive(value: true);
			}
		}
	}

	private void WeekBossBottomInit(int enterRecordUid)
	{
		ResetBottom();
		if (MonoECS.instance.ruleManager.SharedGetState(enterRecordUid) == -2)
		{
			bottomRoot.SetActive(value: true);
			transferBtn.gameObject.SetActive(value: true);
			int chunkId = Singleton<GameManager>.instance.worldManager.GetChunkIdBySGOID(enterRecordUid);
			transferBtn.OnClick.AddListener(() =>
			{
				Transfer(MonoECS.instance.ruleManager.GetStateWorldAssetInitPos(enterRecordUid), chunkId);
			});
		}
	}

	private void WorldBossBottomInit(LargeMapWorldBossIcon worldBossIcon)
	{
		ResetBottom();
		transferBtn.OnClick.RemoveAllListeners();
		trackBtn.OnClick.RemoveAllListeners();
		bottomDescLocalize.gameObject.SetActive(value: false);
		bottomRoot.SetActive(value: true);
		trackBtn.gameObject.SetActive(!IsTracedIcon());
		unTrackBtn.gameObject.SetActive(IsTracedIcon());
		unTrackBtn.OnClick.AddListener(() =>
		{
			MapSetupTracePoint(icon, isCancel: true, () =>
			{
				trackBtn.gameObject.SetActive(value: true);
				unTrackBtn.gameObject.SetActive(value: false);
			});
		});
		trackBtn.OnClick.AddListener(() =>
		{
			if (worldBossIcon.IsExplored.activeSelf)
			{
				WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
				bool flag = icon.mapArea != (ACT.World.MapArea)worldManager.ActiveMapId;
				if (!Model<MapModel>.Interface.DisableTPButton)
				{
					if (!flag)
					{
						TeleportUtility.OpenCoverBeforeTransfer(Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(icon.GetId()));
						Model<MapModel>.Interface.MapSetupTracePoint((int)icon.mapArea, icon.GetId(), (int)icon.type, isCancel: false, () =>
						{
							trackBtn.gameObject.SetActive(value: false);
							unTrackBtn.gameObject.SetActive(value: true);
							MonsterPointData monsterPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(icon.GetId()) as MonsterPointData;
							Transfer(monsterPointData);
						});
					}
					else
					{
						ACT.Config.MapArea data = CoreUtils.GetData((int)icon.mapArea, RuntimeConfigs.data.mapAreas);
						Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
						{
							commonId = 2391,
							texts = new string[1] { LocalizationSettings.StringDatabase.GetLocalizedString("shortcommon", data.name, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null) },
							OnCancel = () =>
							{
								Model<MapModel>.Interface.MapSetupTracePoint((int)icon.mapArea, icon.GetId(), (int)icon.type, isCancel: false, () =>
								{
									trackBtn.gameObject.SetActive(value: false);
									unTrackBtn.gameObject.SetActive(value: true);
								});
							},
							OnConfirm = () =>
							{
								TeleportUtility.OpenCoverBeforeTransfer(Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(icon.GetId()));
								Model<MapModel>.Interface.MapSetupTracePoint((int)icon.mapArea, icon.GetId(), (int)icon.type, isCancel: false, () =>
								{
									trackBtn.gameObject.SetActive(value: false);
									unTrackBtn.gameObject.SetActive(value: true);
									MonsterPointData monsterPointData = Singleton<GameManager>.instance.worldManager.GetWorldStateAssetDataBySGOID(icon.GetId()) as MonsterPointData;
									Transfer(monsterPointData);
								});
							}
						});
					}
				}
				else
				{
					Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
					{
						tableName = LocalizationUtility.localizeTableName_Common,
						localizeId = 2660
					});
				}
			}
			else
			{
				MapSetupTracePoint(icon, isCancel: false, () =>
				{
					trackBtn.gameObject.SetActive(value: false);
					unTrackBtn.gameObject.SetActive(value: true);
				});
			}
		});
	}

	private void DestroyMissionReward()
	{
		for (int i = 0; i < missionRewardGridLayoutGroup.transform.childCount; i++)
		{
			UnityEngine.Object.Destroy(missionRewardGridLayoutGroup.transform.GetChild(i).gameObject);
		}
	}

	private void Transfer(LargeMapInteractObjIcon interactObjIcon)
	{
		if (CoreUtils.TryGetServiceSaveStateId(Singleton<GameManager>.instance.worldManager.ActiveWorldId, interactObjIcon.GetSwId(), out var stateId) && stateId == -2)
		{
			int swId = interactObjIcon.GetSwId();
			Transfer(swId);
		}
		GameUtility.SendFinshStepGuideEvent(GuideConsts.GuideType.LargeMapIconTransfer);
	}

	private void Transfer(Vector3 pos, int chunkId)
	{
		TPEvt evt = EventTrackSolver.Instance.GetEvt<TPEvt>();
		evt.currentPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		evt.targetPosition = pos;
		EventTrackSolver.Instance.Dispatch(evt);
		TeleportParams teleportParams = new TeleportParams
		{
			targetPos = pos,
			faceLeft = false,
			forceToFloor = true,
			revive = false
		};
		TeleportUtility.TeleportWithLoader(chunkId, teleportParams);
		CloseViewNextFrame();
	}

	private void Transfer(MonsterPointData monsterPointData)
	{
		TPEvt evt = EventTrackSolver.Instance.GetEvt<TPEvt>();
		evt.currentPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
		evt.targetPosition = monsterPointData.GetTeleportPos();
		EventTrackSolver.Instance.Dispatch(evt);
		TeleportUtility.TeleportWithInteractObject(monsterPointData).Forget();
		CloseViewNextFrame();
	}

	private void Transfer(int transferId)
	{
		if (MonoECS.instance.ruleManager.SharedGetState(transferId) != -2)
		{
			Singleton<LoadManager>.instance.FinishLoading();
			TeleportUtility.CloseSameChunkTeleportBlackScreen();
			return;
		}
		StateWorldAssetData stateWorldAssetData = MonoECS.instance.ruleManager.GetStateWorldAssetData(transferId);
		if (stateWorldAssetData != null)
		{
			TPEvt evt = EventTrackSolver.Instance.GetEvt<TPEvt>();
			evt.currentPosition = MonoECS.instance.mainEntity.GetCompTransform().physicsPosition;
			evt.targetPosition = ((PortalData)stateWorldAssetData).SitPos;
			EventTrackSolver.Instance.Dispatch(evt);
			TeleportUtility.TeleportWithInteractObject(stateWorldAssetData).Forget();
			Singleton<BloodBottleHandler>.instance.RecoverItems();
			if (MPPlayer.local.CurrentActiveBattlePotionId != 0)
			{
				Singleton<BloodBottleHandler>.instance.SendBottleChangeUpdateHudComponent(MPPlayer.local.CurrentActiveBattlePotionId);
			}
			Singleton<AchievementSyncBattleTypeManager>.instance.DispatchAnchorTransfer();
			CloseViewNextFrame();
		}
		else
		{
			_ = LuminApplication.LogEnabled;
			Singleton<LoadManager>.instance.FinishLoading();
			TeleportUtility.CloseSameChunkTeleportBlackScreen();
		}
	}

	private void TransToTemple(int templeUid)
	{
		if (MonoECS.instance.ruleManager.SharedGetState(templeUid) == 1)
		{
			StateWorldAssetData stateWorldAssetData = MonoECS.instance.ruleManager.GetStateWorldAssetData(templeUid);
			if (stateWorldAssetData != null)
			{
				TeleportUtility.TeleportWithInteractObject(stateWorldAssetData).Forget();
				CloseViewNextFrame();
			}
			else
			{
				_ = LuminApplication.LogEnabled;
			}
		}
	}

	private void CloseViewNextFrame()
	{
		CloseViewNextFrameAsync().Forget();
	}

	private async UniTaskVoid CloseViewNextFrameAsync()
	{
		await UniTask.NextFrame();
		if (!(view == null))
		{
			view.Close();
		}
	}

	public void MapSetupTracePoint(LargeMapIcon icon, bool isCancel, Action callback = null, bool forceTransfer = false)
	{
		WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
		if (((icon.mapArea != (ACT.World.MapArea)worldManager.ActiveMapId) | forceTransfer) && !isCancel && !Model<MapModel>.Interface.DisableTPButton)
		{
			List<BakeStaticMapIconData> mapIconDataByAreaAndType = MapUtility.GetMapIconDataByAreaAndType(icon.mapArea, MapIconType.Transfer);
			if (mapIconDataByAreaAndType.Count > 0)
			{
				int targetId = 0;
				float num = float.MaxValue;
				foreach (BakeStaticMapIconData item in mapIconDataByAreaAndType)
				{
					float num2 = Vector3.Distance(item.initPos, icon.worldPos);
					if (CoreUtils.TryGetServiceSaveStateId(worldManager.ActiveWorldId, item.uid, out var stateId) && stateId == -2 && num2 < num)
					{
						num = num2;
						targetId = item.uid;
					}
				}
				if (targetId != 0)
				{
					bool needLoadingView = !TeleportUtility.IsSameChunkTeleport(worldManager.GetChunkIdBySGOID(targetId));
					if (forceTransfer)
					{
						if (needLoadingView)
						{
							Singleton<LoadManager>.instance.StartLoading();
						}
						else
						{
							TeleportUtility.OpenSameChunkTeleportBlackScreen();
						}
						Model<MapModel>.Interface.MapSetupTracePoint((int)icon.mapArea, icon.GetId(), (int)icon.type, isCancel, () =>
						{
							Transfer(targetId);
							callback?.Invoke();
						});
					}
					else
					{
						ACT.Config.MapArea data = CoreUtils.GetData((int)icon.mapArea, RuntimeConfigs.data.mapAreas);
						Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
						{
							commonId = 2391,
							texts = new string[1] { LocalizationSettings.StringDatabase.GetLocalizedString("shortcommon", data.name, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null) },
							OnCancel = () =>
							{
								Model<MapModel>.Interface.MapSetupTracePoint((int)icon.mapArea, icon.GetId(), (int)icon.type, isCancel, callback);
							},
							OnConfirm = () =>
							{
								if (needLoadingView)
								{
									Singleton<LoadManager>.instance.StartLoading();
								}
								else
								{
									TeleportUtility.OpenSameChunkTeleportBlackScreen();
								}
								Model<MapModel>.Interface.MapSetupTracePoint((int)icon.mapArea, icon.GetId(), (int)icon.type, isCancel, () =>
								{
									Transfer(targetId);
									callback?.Invoke();
								});
							}
						});
					}
				}
				else
				{
					Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
					{
						tableName = LocalizationUtility.localizeTableName_Common,
						localizeId = 2395
					});
				}
			}
			else
			{
				Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
				{
					tableName = LocalizationUtility.localizeTableName_Common,
					localizeId = 2395
				});
			}
		}
		Model<MapModel>.Interface.MapSetupTracePoint((int)icon.mapArea, icon.GetId(), (int)icon.type, isCancel, callback);
	}

	private void CheckTransferStatus()
	{
		if (Model<MapModel>.Interface.DisableTPButton || MapUtility.playerMapArea == icon.mapArea)
		{
			return;
		}
		List<BakeStaticMapIconData> mapIconDataByAreaAndType = MapUtility.GetMapIconDataByAreaAndType(icon.mapArea, MapIconType.Transfer);
		if (mapIconDataByAreaAndType.Count > 0)
		{
			int targetId = 0;
			float num = float.MaxValue;
			WorldManager worldManager = Singleton<GameManager>.instance.worldManager;
			foreach (BakeStaticMapIconData item in mapIconDataByAreaAndType)
			{
				float num2 = Vector3.Distance(item.initPos, icon.worldPos);
				if (CoreUtils.TryGetServiceSaveStateId(worldManager.ActiveWorldId, item.uid, out var stateId) && stateId == -2 && num2 < num)
				{
					num = num2;
					targetId = item.uid;
				}
			}
			if (targetId != 0)
			{
				ACT.Config.MapArea data = CoreUtils.GetData((int)icon.mapArea, RuntimeConfigs.data.mapAreas);
				Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_TEXTPANEL, new TextPanel.Param
				{
					commonId = 2391,
					texts = new string[1] { LocalizationSettings.StringDatabase.GetLocalizedString("shortcommon", data.name, LocalizationSettings.ProjectLocale, FallbackBehavior.DontUseFallback, null) },
					OnConfirm = () =>
					{
						Transfer(targetId);
					}
				});
			}
			else
			{
				Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
				{
					tableName = LocalizationUtility.localizeTableName_Common,
					localizeId = 2395
				});
			}
		}
		else
		{
			Singleton<TipManager>.instance.GetTip(TIP_TYPE.TIP_COMMONTIP, new CommonTipData
			{
				tableName = LocalizationUtility.localizeTableName_Common,
				localizeId = 2395
			});
		}
	}

	public ActButton GetCurActiveButton()
	{
		if (trackBtn.gameObject.activeSelf)
		{
			return trackBtn;
		}
		if (unTrackBtn.gameObject.activeSelf)
		{
			return unTrackBtn;
		}
		if (transferBtn.gameObject.activeSelf)
		{
			return transferBtn;
		}
		if (wait4RefreshBtn.gameObject.activeSelf)
		{
			return wait4RefreshBtn;
		}
		if (placeNodeBtn.gameObject.activeSelf)
		{
			return placeNodeBtn;
		}
		if (traceNodeBtn.gameObject.activeSelf)
		{
			return traceNodeBtn;
		}
		return null;
	}
}
