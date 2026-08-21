#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using GameFramework;
using GameFramework.Runtime;
using UnityEngine;

namespace Ase;

public class MapItemNode : BaseMapDataNode, IDialogueEvent
{
	public bool isActive;

	public bool openEventListen;

	public int mapItemId;

	[SerializeField]
	public string desc;

	public string InteractiveName;

	private DialogueChainConfig dialogueChainConfig;

	private bool initActive;

	private LevelSaveService.MapItemData mapItemData;

	private DRMapItem drMapItem;

	private ISubscription<MapItemStateChangeMessager> subscription_MapItemStateChangeMessager;

	public static string MAPITEMUID = "MAPITEMUID";

	public static int TreasureMaskType = 1;

	private List<MapItemEventTrigger> mapItemEventTriggers = new List<MapItemEventTrigger>();

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		drMapItem = GameEntry.DataTable.GetDataRow<DRMapItem>(mapItemId);
		if (drMapItem == null)
		{
			Log.Error($"{((UnityEngine.Object)(object)this).name}:没有找到编号 = {mapItemId}的交互物配置..");
		}
		if (openEventListen)
		{
			subscription_MapItemStateChangeMessager = sceneSystem.MapDataMessenger.Subscribe<MapItemStateChangeMessager>(OnMapItemStateChangeMessage);
		}
		dialogueChainConfig = ((Component)(object)this).GetComponent<DialogueChainConfig>();
		initActive = isActive;
		SetMapItemSaveData();
		if (base.SaveNode || drMapItem.MarkType == TreasureMaskType)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().AddMapItemOnUpdateAction(sceneSystem.GetLevelId(), mapItemData, UpdateNodeAction);
		}
		mapItemEventTriggers = new List<MapItemEventTrigger>();
	}

	protected override bool CheckLoadingCondition()
	{
		if (!base.TaskConditionResult || mapItemId == 0 || entity != null || !isActive || base.isKilled)
		{
			return false;
		}
		return true;
	}

	public override void OnReceiveMapDataEvent(LevelMapDataEvent eventType, BaseEntity otherEntity = null)
	{
		base.OnReceiveMapDataEvent(eventType, otherEntity);
		if (eventType == LevelMapDataEvent.RestLevel)
		{
			OnRestLevel();
		}
	}

	public void OnRestLevel()
	{
		entity?.GetComponent<BingMoveComponent>()?.EntityUnLoad();
		AddEntityToSystemRelease(isLevelReset: true);
		isActive = initActive;
		SetMapItemSaveData();
	}

	public void ChangeActiveState()
	{
		isActive = true;
	}

	public override void OnDisposed()
	{
		AddEntityToSystemRelease(isLevelReset: false);
		if (openEventListen && subscription_MapItemStateChangeMessager != null)
		{
			subscription_MapItemStateChangeMessager.Dispose();
			subscription_MapItemStateChangeMessager = null;
		}
		if (mapItemEventTriggers != null)
		{
			mapItemEventTriggers.Clear();
			mapItemEventTriggers = null;
		}
		if ((base.SaveNode || drMapItem.MarkType == TreasureMaskType) && mapItemData != null)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().RemoveMapItemOnUpdateAction(mapItemData);
		}
		drMapItem = null;
	}

	private void OnMapItemStateChangeMessage(MapItemStateChangeMessager message)
	{
		if (message.uid == base.Uid)
		{
			SendParadoxMessage(message.paradoxMsg);
		}
	}

	public void SetMapItemSaveData()
	{
		if (base.SaveNode || drMapItem.MarkType == TreasureMaskType)
		{
			if (mapItemData == null)
			{
				mapItemData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().InitMapItemData(sceneSystem.GetLevelId(), this, base.SaveNode);
			}
			if (mapItemData != null)
			{
				SetMapItemSaveData(mapItemData, setParadoxData: true);
			}
		}
	}

	private void SetMapItemSaveData(LevelSaveService.MapItemData mapItem, bool setParadoxData)
	{
		if (mapItem == null)
		{
			return;
		}
		if (mapItem.Active == 0)
		{
			isActive = true;
		}
		else if (mapItem.Active == 1)
		{
			isActive = false;
		}
		if (setParadoxData)
		{
			foreach (KeyValuePair<string, MapDataNodeParadoxParameter> paradoxDatum in mapItem.ParadoxData)
			{
				SendParadoxMessage(paradoxDatum.Key, paradoxDatum.Value);
			}
		}
		bound.center = ((Component)(object)this).transform.position;
		sceneSystem.RemoveObjectInOcTree(this);
		sceneSystem.AddObjectInOcTree(this, bound);
		if (mapItem.MapDataNodeState == MapDataNodeState.Dead)
		{
			mapDataNodeState = mapItem.MapDataNodeState;
		}
	}

	private void UpdateNodeAction(LevelSaveService.MapItemData mapItem)
	{
		SetMapItemSaveData(mapItem, setParadoxData: false);
	}

	public void ResetPosAndBingMove()
	{
		entity?.GetComponent<BingMoveComponent>()?.CloseComp();
		sceneSystem.RemoveObjectInOcTree(this);
		sceneSystem.AddObjectInOcTree(this, bound);
	}

	public void RegisterDialogueCallback()
	{
		if (entity != null)
		{
			entity.GetComponent<DialogChainComponent>()?.BindingConfig(dialogueChainConfig);
			entity.GetComponent<InteractiveStateComponent>()?.ReigisterCallback(OnEnterInteractiveCallback, OnFinishedInteractiveCallback, OnSendInteractiveEventCallback);
		}
	}

	public async void OnEnterInteractiveCallback(object sender, DialogueViewModel dialogueViewModel)
	{
		base.World.GetSystem<BattleSystem>().ControlView(isShow: false);
		MapItemDialogueViewModel mapItemDialogueViewModel = new MapItemDialogueViewModel(dialogueViewModel);
		MapItemDialogueWindow dialogueWindow = await GameEntry.UI.LoadWindow<MapItemDialogueWindow>(AssetUtility.GetUIFormAsset("Dialogue/DialogueMapItemWindow"), "DEFAULT", mapItemDialogueViewModel);
		dialogueWindow.OnDismissed += Handler;
		await dialogueWindow.DoShow();
		mapItemDialogueViewModel.StartDialogue();
		void Handler(object window, EventArgs args)
		{
			dialogueWindow.OnDismissed -= Handler;
			base.World.GetSystem<BattleSystem>().ControlView(isShow: true);
		}
	}

	public void OnSendInteractiveEventCallback(object sender, MapItemEventType eventType)
	{
		PublishMapItemEvent(eventType);
	}

	public void OnFinishedInteractiveCallback(object sender, EventArgs e)
	{
		sceneSystem.GetSystem<TaskSystem>().UpdateTaskProcess(2, mapItemId, 1);
	}

	protected override void OnTaskConditionChanged()
	{
		base.OnTaskConditionChanged();
		if (!base.TaskConditionResult)
		{
			OnUnLoadNode();
		}
	}

	public void PublishMapItemEvent(MapItemEventType eventType)
	{
		for (int i = 0; i < mapItemEventTriggers.Count; i++)
		{
			mapItemEventTriggers[i].OnMessage(this, eventType);
		}
	}

	public void RegisterSubscription(MapItemEventTrigger mapItemEventTrigger)
	{
		if (!mapItemEventTriggers.Contains(mapItemEventTrigger))
		{
			mapItemEventTriggers.Add(mapItemEventTrigger);
		}
	}

	public void UnRegisterSubscription(MapItemEventTrigger mapItemEventTrigger)
	{
		if (mapItemEventTriggers != null && mapItemEventTriggers.Contains(mapItemEventTrigger))
		{
			mapItemEventTriggers.Remove(mapItemEventTrigger);
		}
	}

	public void OpenChestReport(MapItemNode mapItemNode)
	{
		levelArea.OpenChestReport(mapItemNode);
	}

	protected override void OnForceLoadNode()
	{
		base.OnForceLoadNode();
		LoadMapItem();
	}

	protected override void OnLoadNode()
	{
		base.OnLoadNode();
		LoadMapItem();
	}

	public override void OnUnLoadNode()
	{
		base.OnUnLoadNode();
		base.Entity?.GetComponent<BingMoveComponent>()?.EntityUnLoad();
		AddEntityToSystemRelease(isLevelReset: false);
	}

	private void AddEntityToSystemRelease(bool isLevelReset)
	{
		if (base.isCreating)
		{
			IsNeedDestory = true;
		}
		else if (entity != null && entity.IsSurvival)
		{
			entity.DoEntityRelease();
			entity = null;
			if (!base.isKilled | isLevelReset)
			{
				mapDataNodeState = MapDataNodeState.Destorying;
			}
		}
		else if (!base.isKilled | isLevelReset)
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
		}
	}

	private async Task<BaseEntity> LoadMapItem()
	{
		if (IsNeedDestory)
		{
			IsNeedDestory = false;
		}
		if (mapDataNodeState == MapDataNodeState.Summoning)
		{
			return null;
		}
		if (mapDataNodeState == MapDataNodeState.Destorying)
		{
			IsNeedCreate = true;
			return null;
		}
		if (drMapItem == null)
		{
			Log.Error($"{((UnityEngine.Object)(object)this).name}:没有找到编号 = {mapItemId}的交互物配置..");
			return null;
		}
		mapDataNodeState = MapDataNodeState.Summoning;
		if (!(await sceneSystem.GetSystem<ParadoxSystem>().PreLoadParadoxGraph(drMapItem.AIParadoxId)))
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
			return null;
		}
		GameObject entityObject = await LoadEntityView(mapItemId, drMapItem.AssetPath);
		entity = sceneSystem.GetSystem<EntitySystem>().CreateEntity<InteractiveEntity>(mapItemId, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = ((Component)(object)this).transform.position,
				scale = ((Component)(object)this).transform.localScale,
				rotation = ((Component)(object)this).transform.eulerAngles
			},
			entityObject = entityObject,
			userData = drMapItem,
			updateType = EntityUpdateType.Local,
			logicType = EntityLogicType.None,
			callbacks = callbacks
		});
		entity.SetData(Constant.InteractiveConstant.INTERACTIVE_NAME, InteractiveName);
		entity.SetData(MAPITEMUID, base.Uid);
		return entity;
	}

	protected override async void OnEntityCreated()
	{
		base.OnEntityCreated();
		mapDataNodeState = MapDataNodeState.Summoned;
		RegisterDialogueCallback();
	}

	protected override void OnEntityDead(bool isNormal)
	{
		mapDataNodeState = MapDataNodeState.Dead;
		if (base.SaveNode)
		{
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().UpdateMapDataNodeState(sceneSystem.GetLevelId(), base.Uid, mapDataNodeState);
		}
	}

	protected override void OnEntityRelease(bool isnormal)
	{
		base.OnEntityRelease(isnormal);
		if (!base.isKilled)
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
		}
	}
}
