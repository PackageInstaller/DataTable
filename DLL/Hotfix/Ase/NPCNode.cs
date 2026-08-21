#define ENABLE_ERROR_AND_ABOVE_LOG
using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using Ase.ECS;
using GameFramework;
using UnityEngine;

namespace Ase;

public class NPCNode : BaseMapDataNode, IDialogueEvent
{
	public bool isActive;

	public NPCGroup npcGroup;

	[SerializeField]
	public int npcId;

	[SerializeField]
	private string desc;

	public string InteractiveName;

	private DialogueChainConfig dialogueChainConfig;

	private LevelSaveService.NpcData saveNpcData;

	private List<NpcNodeEventTrigger> npcEventTriggers = new List<NpcNodeEventTrigger>();

	public override void OnInited(object data = null)
	{
		base.OnInited(data);
		if (!((Component)(object)this).TryGetComponent(out dialogueChainConfig))
		{
			Log.Error("NpcNode配置 [DialogueChainConfig] 没有对话配置");
		}
		else if (base.SaveNode)
		{
			saveNpcData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().InitNpcData(sceneSystem.GetLevelId(), this, dialogueChainConfig.GetDialogButtonState(), dialogueChainConfig.GetNormalDialogPrologue(), dialogueChainConfig.GetDialogButtonConfig());
			Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().AddNpcDataOnUpdateAction(sceneSystem.GetLevelId(), saveNpcData, UpdateNodeAction);
			OnNpcDataUpdate(saveNpcData, setParadoxData: true);
		}
	}

	private void OnNpcDataUpdate(LevelSaveService.NpcData npcData, bool setParadoxData)
	{
		if (setParadoxData)
		{
			foreach (KeyValuePair<string, MapDataNodeParadoxParameter> paradoxDatum in npcData.ParadoxData)
			{
				SendParadoxMessage(paradoxDatum.Key, paradoxDatum.Value);
			}
			dialogueChainConfig.UpdateData(npcData.PrologueIds, npcData.DialogButtonConfigs);
			if (npcData.DialogButtonLockState.Count > 0)
			{
				foreach (KeyValuePair<int, string> item in npcData.DialogButtonLockState)
				{
					dialogueChainConfig.ChangeDialogueButtonState(item.Key, item.Value);
					if (entity != null)
					{
						entity.GetComponent<DialogChainComponent>()?.UpdateDialogButtonInstantiate(item.Key, item.Value);
					}
				}
			}
		}
		isActive = npcData.Active;
		if (entity != null && !isActive && entity.IsSurvival)
		{
			entity.DoEntityRelease();
			entity = null;
		}
		bound.center = ((Component)(object)this).transform.position;
		sceneSystem.RemoveObjectInOcTree(this);
		sceneSystem.AddObjectInOcTree(this, bound);
	}

	private void UpdateNodeAction(LevelSaveService.NpcData npcData)
	{
		OnNpcDataUpdate(npcData, setParadoxData: false);
	}

	public override void OnDisposed()
	{
		AddEntityToSystemRelease(isLevelReset: false);
		if (base.SaveNode)
		{
			LevelSaveService.NpcData npcData = Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().GetNpcData(sceneSystem.GetLevelId(), base.Uid);
			if (npcData != null)
			{
				Singleton<ServiceSystem>.Instance.GetService<ILevelSaveService>().RemoveNpcDataOnUpdateAction(npcData);
			}
		}
	}

	protected override bool CheckLoadingCondition()
	{
		if (!base.TaskConditionResult || entity != null || !isActive)
		{
			return false;
		}
		return true;
	}

	protected override void OnForceLoadNode()
	{
		base.OnForceLoadNode();
		LoadNPC();
	}

	protected override void OnLoadNode()
	{
		base.OnLoadNode();
		LoadNPC();
	}

	public override void OnUnLoadNode()
	{
		base.OnUnLoadNode();
		ReleaseNPC();
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
		AddEntityToSystemRelease(isLevelReset: true);
		SetNpcSaveData();
	}

	public void ReleaseNPC()
	{
		AddEntityToSystemRelease(isLevelReset: false);
	}

	public void SetNpcSaveData()
	{
		if (base.SaveNode)
		{
			OnNpcDataUpdate(saveNpcData, setParadoxData: true);
		}
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

	private async Task<BaseEntity> LoadNPC()
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
		DRNPC drNpc = GameEntry.DataTable.GetDataRow<DRNPC>(npcId);
		if (drNpc == null)
		{
			Log.Error($"没有找到编号 = {drNpc.Id}的NPC配置..");
			return null;
		}
		mapDataNodeState = MapDataNodeState.Summoning;
		if (!(await sceneSystem.GetSystem<ParadoxSystem>().PreLoadParadoxGraph(drNpc.AIParadoxId)))
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
			return null;
		}
		GameObject entityObject = await LoadEntityView(drNpc.Id, drNpc.AssetPath);
		entity = sceneSystem.GetSystem<EntitySystem>().CreateEntity<NpcEntity>(drNpc.Id, new EntityData
		{
			pointData = new EntityPositionData
			{
				position = ((Component)(object)this).transform.position,
				scale = ((Component)(object)this).transform.localScale,
				rotation = ((Component)(object)this).transform.eulerAngles
			},
			entityObject = entityObject,
			userData = drNpc,
			updateType = EntityUpdateType.Local,
			logicType = EntityLogicType.None,
			callbacks = callbacks
		});
		entity.SetData(Constant.InteractiveConstant.INTERACTIVE_NAME, InteractiveName);
		return entity;
	}

	protected override async void OnEntityCreated()
	{
		RegisterDialogueCallback();
		mapDataNodeState = MapDataNodeState.Summoned;
	}

	protected override void OnEntityRelease(bool isnormal)
	{
		base.OnEntityRelease(isnormal);
		if (!base.isKilled)
		{
			mapDataNodeState = MapDataNodeState.Unsummoned;
		}
	}

	protected override void OnTaskConditionChanged()
	{
		base.OnTaskConditionChanged();
		if (!base.TaskConditionResult)
		{
			OnUnLoadNode();
		}
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
		NpcDialogueViewModel npcDialogueViewModel = new NpcDialogueViewModel(dialogueViewModel);
		NpcDialogueWindow dialogueWindow = await GameEntry.UI.LoadWindow<NpcDialogueWindow>(AssetUtility.GetUIFormAsset("Dialogue/DialogueWindow"), "DEFAULT", npcDialogueViewModel);
		dialogueWindow.OnDismissed += Handler;
		await dialogueWindow.DoShow();
		npcDialogueViewModel.DialogueInit();
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
	}

	public void PublishMapItemEvent(MapItemEventType eventType)
	{
		for (int i = 0; i < npcEventTriggers.Count; i++)
		{
			npcEventTriggers[i].OnMessage(this, eventType);
		}
	}

	public void RegisterSubscription(NpcNodeEventTrigger npcEventTrigger)
	{
		if (!npcEventTriggers.Contains(npcEventTrigger))
		{
			npcEventTriggers.Add(npcEventTrigger);
		}
	}

	public void UnRegisterSubscription(NpcNodeEventTrigger npcEventTrigger)
	{
		if (npcEventTriggers.Contains(npcEventTrigger))
		{
			npcEventTriggers.Remove(npcEventTrigger);
		}
	}
}
