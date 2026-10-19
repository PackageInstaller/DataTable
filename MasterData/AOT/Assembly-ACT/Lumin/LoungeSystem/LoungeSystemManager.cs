using System;
using System.Collections.Generic;
using System.Linq;
using ACT;
using ACT.Config;
using ACT.Core;
using ACT.Drama;
using ACT.Error;
using ACT.Event;
using ACT.Game.Data;
using ACT.Model;
using ACT.Net;
using ACT.Rendering;
using ACT.UI;
using Bamboo.AssetField;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf;
using Lumin.LoungeSystem.UI;
using Pb;
using Runtime.Model;
using UnityEngine;
using UnityEngine.Scripting;

namespace Lumin.LoungeSystem;

public class LoungeSystemManager : Singleton<LoungeSystemManager>
{
	private CharacterLoungeManager characterManager;

	private InteractionManager interactionManager;

	private RoomManager roomManager;

	private LoungeMusicManager loungeMusicManager;

	private LoungeMainView _loungeMain;

	private bool isInitialized;

	private float updateTimer;

	private const float UPDATE_INTERVAL = 1f;

	public LoungeConfig loungeConfig => GameLoader.meta.LoungeConfig;

	public CharacterLoungeManager CharacterManager => characterManager;

	public InteractionManager InteractionManager => interactionManager;

	public RoomManager RoomManager => roomManager;

	public LoungeMusicManager LoungeMusicManager => loungeMusicManager;

	public int CurRoomIndex { get; set; }

	public event Action OnSystemInitialized;

	public event Action<float> OnSystemUpdate;

	public override void Init()
	{
		base.Init();
		if (!isInitialized)
		{
			characterManager = new CharacterLoungeManager();
			interactionManager = new InteractionManager(characterManager);
			roomManager = new RoomManager(characterManager);
			loungeMusicManager = new LoungeMusicManager(loungeConfig.GetDefaultMusic());
			SubscribeToEvents();
			isInitialized = true;
			OnSystemInitialized?.Invoke();
			Debug.Log("后宅系统初始化完成");
		}
	}

	public void SetCurrentLoungePoint(Dictionary<int, Dictionary<int, Transform>> points)
	{
		roomManager.SetRoomPoint(points);
		CurRoomIndex = points.Keys.Min();
	}

	private void SubscribeToEvents()
	{
		interactionManager.OnInteractionStarted += OnInteractionStarted;
		interactionManager.OnInteractionCompleted += OnInteractionCompleted;
		interactionManager.OnTouchInteraction += OnTouchInteraction;
		roomManager.OnRoomUnlocked += OnRoomUnlocked;
		roomManager.OnCharacterEnterRoom += OnCharacterEnterRoom;
		roomManager.OnCharacterLeaveRoom += OnCharacterLeaveRoom;
	}

	public void SubscribeLoungeMainViewEvents(LoungeMainView loungeMainView, bool isSubscribe)
	{
		if (!(loungeMainView == null))
		{
			_loungeMain = loungeMainView;
			if (isSubscribe)
			{
				interactionManager.OnInteractionEnd += _loungeMain.RefreshCharacterInteractions;
				return;
			}
			interactionManager.OnInteractionEnd -= _loungeMain.RefreshCharacterInteractions;
			_loungeMain = null;
		}
	}

	private void Update()
	{
		if (isInitialized)
		{
			updateTimer += Time.deltaTime;
			if (updateTimer >= 1f)
			{
				updateTimer = 0f;
				UpdateSystem();
			}
		}
	}

	private void UpdateSystem()
	{
		OnSystemUpdate?.Invoke(Time.time);
	}

	private void OnInteractionStarted(int characterId, InteractionData interaction)
	{
		Debug.Log($"[后宅系统] 开始互动: 角色 {characterId}, 类型 {interaction.InteractionType}");
	}

	private void OnInteractionCompleted(int characterId, InteractionData interaction, bool success)
	{
		if (success)
		{
			Debug.Log($"[后宅系统] 互动完成: 角色 {characterId}, 类型 {interaction.InteractionType}");
		}
	}

	private void OnTouchInteraction(int characterId, string zone, TouchInteractionData touchData)
	{
		Debug.Log($"[后宅系统] 触摸互动: 角色 {characterId}, 区域 {zone}");
	}

	private void OnRoomUnlocked(int roomId)
	{
		Debug.Log($"[后宅系统] 房间解锁: {roomId}");
	}

	private void OnCharacterEnterRoom(int roomId, int characterId)
	{
		Debug.Log($"[后宅系统] 角色 {characterId} 进入房间 {roomId}");
	}

	private void OnCharacterLeaveRoom(int roomId, int characterId)
	{
		Debug.Log($"[后宅系统] 角色 {characterId} 离开房间 {roomId}");
	}

	public void RefreshCharacterInteractions()
	{
		List<InteractionData> list = new List<InteractionData>();
		foreach (LoungePoint value in Model<LoungeModel>.Interface.IndexToCharacter.Values)
		{
			list.Clear();
			if (value.character.Count <= 0)
			{
				continue;
			}
			foreach (int item in value.character)
			{
				if (value.waitStory != 0)
				{
					LoungeStory data = CoreUtils.GetData(value.waitStory, RuntimeConfigs.data.loungeStorys);
					if (data != null && data.type == 102)
					{
						list.Add(new InteractionData(LoungeDefine.InteractionType.TriggerGlobalStory, value.waitStory));
						list.Add(new InteractionData(LoungeDefine.InteractionType.BackToMain));
						interactionManager.AddCharacterInteraction(item, list);
						break;
					}
					if (data != null && data.type == 201)
					{
						list.Add(new InteractionData(LoungeDefine.InteractionType.PersonalStory, value.waitStory));
					}
				}
				if (value.performID != 0)
				{
					list.Add(new InteractionData(LoungeDefine.InteractionType.Chat, value.performID));
				}
				list.Add(new InteractionData(LoungeDefine.InteractionType.Gift));
				list.Add(new InteractionData(LoungeDefine.InteractionType.BackToMain));
				interactionManager.AddCharacterInteraction(item, list);
			}
		}
	}

	public void InitLoungeStoryTimeline()
	{
		RefreshImmediatelyGloablStory();
		foreach (KeyValuePair<int, bool> triggeredStory in Model<LoungeModel>.Interface.TriggeredStories)
		{
			if (interactionManager.GetGlobalStoryTimelineGo(triggeredStory.Key) != null && triggeredStory.Value)
			{
				LoungeUIScene.instance.RemoveGlobalStoryCharacterModel(triggeredStory.Key);
				interactionManager.RemoveGlobalStoryTimelineHandle(triggeredStory.Key);
			}
		}
		foreach (LoungePoint value in Model<LoungeModel>.Interface.IndexToCharacter.Values)
		{
			if (value.waitStory != 0)
			{
				AddStoryTimeline(value);
			}
		}
		LoungeUIScene.instance.RefreshMainViewInfo();
	}

	private void AddStoryTimeline(LoungePoint loungePoint)
	{
		LoungeStory data = CoreUtils.GetData(loungePoint.waitStory, RuntimeConfigs.data.loungeStorys);
		if (data.type == 102 && data.storyType == 1)
		{
			if (!(interactionManager.GetGlobalStoryTimelineGo(loungePoint.waitStory) == null) || interactionManager.GetGlobalStoryTimelineIndex(loungePoint.waitStory) != 0)
			{
				return;
			}
			int[] pointIds = CoreUtils.GetData(data.areaId, RuntimeConfigs.data.areaLists)?.pointId;
			Vector3 centerPoint = LoungeUIScene.GetCenterPoint(LoungeUIScene.instance.GetPointInfoByIndexs(pointIds));
			AssetLoadHandle handle = Model<RuntimeTimelineModel>.Interface.GetTimelineByDramaId(loungePoint.waitStory, centerPoint);
			interactionManager.AddGlobalStoryTimelineIndex(loungePoint.waitStory, loungePoint.id);
			handle.Completed += (AssetLoadHandle result) =>
			{
				if (handle.IsValid)
				{
					interactionManager.AddGlobalStoryTimelineHandle(loungePoint.waitStory, handle);
					LoungeUIScene.instance.ShowGlobalStoryCharacterModel(loungePoint.waitStory, data.characterId);
				}
			};
		}
		else if (data.type == 201 && data.storyType == 1 && loungePoint.character.Count > 0 && interactionManager.GetCharacterStoryTimelineGo(loungePoint.character[0], loungePoint.waitStory) == null)
		{
			Vector3 position = LoungeUIScene.instance.GetPointInfoByIndex(loungePoint.id).position;
			AssetLoadHandle timelineByDramaId = Model<RuntimeTimelineModel>.Interface.GetTimelineByDramaId(loungePoint.waitStory, position);
			if (timelineByDramaId.IsValid)
			{
				interactionManager.AddCharacterStoryTimelineHandle(loungePoint.character[0], loungePoint.waitStory, timelineByDramaId);
			}
		}
	}

	public void RefreshImmediatelyGloablStory()
	{
		if (Model<LoungeModel>.Interface.CurGlobalStoryId == 0 || !(interactionManager.GetGlobalStoryTimelineGo(Model<LoungeModel>.Interface.CurGlobalStoryId) == null))
		{
			return;
		}
		LoungeStory data = CoreUtils.GetData(Model<LoungeModel>.Interface.CurGlobalStoryId, RuntimeConfigs.data.loungeStorys);
		if (data.type == 101 && data.storyType == 1)
		{
			Vector3 areaMiddlePointByIndex = LoungeUIScene.instance.GetAreaMiddlePointByIndex();
			AssetLoadHandle timelineByDramaId = Model<RuntimeTimelineModel>.Interface.GetTimelineByDramaId(Model<LoungeModel>.Interface.CurGlobalStoryId, areaMiddlePointByIndex);
			if (timelineByDramaId.IsValid)
			{
				interactionManager.AddGlobalStoryTimelineHandle(Model<LoungeModel>.Interface.CurGlobalStoryId, timelineByDramaId);
			}
		}
	}

	public async UniTask CheckGlobalStoryPlay()
	{
		int globalStoryId = Model<LoungeModel>.Interface.CurGlobalStoryId;
		if (globalStoryId != 0 && interactionManager.GetGlobalStoryTimelineGo(globalStoryId) != null)
		{
			await Singleton<TimelineConversationManager>.instance.PlayTimeline(globalStoryId, interactionManager.GetGlobalStoryTimelineGo(globalStoryId));
			Model<LoungeModel>.Interface.TriggeredStories.Add(globalStoryId, value: true);
		}
	}

	public void InteractWithCharacter(int characterId, int pointId)
	{
		LoungeTriggerPointReq loungeTriggerPointReq = new LoungeTriggerPointReq();
		loungeTriggerPointReq.PointID = pointId;
		loungeTriggerPointReq.CharacterID = characterId;
		loungeTriggerPointReq.TriggerType = LoungeTriggerPointType.InteractCharacter;
		Singleton<NetManager>.instance.Request(loungeTriggerPointReq, async (IMessage msg) =>
		{
			if (msg is LoungeTriggerPointAck loungeTriggerPointAck)
			{
				InteractionData interactionData = (interactionManager?.GetAvailableInteractions(characterId))?.Find((InteractionData i) => i.InteractionType == LoungeDefine.InteractionType.Chat);
				if (interactionData != null)
				{
					Model<LoungeModel>.Interface.OnLoungeNtf(loungeTriggerPointAck.LoungeInfo);
					RefreshCharacterInteractions();
					interactionManager.OnEndInteraction();
					interactionManager.PerformInteraction(characterId, interactionData);
					InitLoungeStoryTimeline();
					Model<FavorabilityModel>.Interface.UpdateCharacterFavorInfoDic(characterId, loungeTriggerPointAck.CurLikeabilityLv, loungeTriggerPointAck.CurLikeabilityExp, loungeTriggerPointAck.GotLikeability);
					Model<FavorabilityModel>.Interface.GotLikeability = loungeTriggerPointAck.GotLikeability;
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.SendGiftGotLikeability, null);
				}
			}
		});
	}

	public void TriggerCharacterStory(int characterId, int pointId)
	{
		LoungeTriggerPointReq loungeTriggerPointReq = new LoungeTriggerPointReq();
		loungeTriggerPointReq.PointID = pointId;
		loungeTriggerPointReq.CharacterID = characterId;
		loungeTriggerPointReq.TriggerType = LoungeTriggerPointType.Story;
		int dramaId = Model<LoungeModel>.Interface.IndexToCharacter[pointId].waitStory;
		LoungeStory data = CoreUtils.GetData(dramaId, RuntimeConfigs.data.loungeStorys);
		bool isTimeline = data.storyType == 1;
		Singleton<NetManager>.instance.Request(loungeTriggerPointReq, async (IMessage msg) =>
		{
			if (msg is LoungeTriggerPointAck loungeTriggerPointAck)
			{
				Model<LoungeModel>.Interface.OnLoungeNtf(loungeTriggerPointAck.LoungeInfo);
				if (isTimeline)
				{
					GameObject timelineInstance = ((characterId != 0) ? interactionManager.GetCharacterStoryTimelineGo(characterId, dramaId) : interactionManager.GetGlobalStoryTimelineGo(dramaId));
					RefreshCharacterInteractions();
					interactionManager.OnEndInteraction();
					await Singleton<TimelineConversationManager>.instance.PlayTimeline(dramaId, timelineInstance);
				}
				else
				{
					DialogueStoryGroupData dramaGroup = CoreUtils.GetData(dramaId, RuntimeConfigs.data.dialogueStoryGroupDatas);
					if (dramaGroup != null && dramaGroup.mode == 4)
					{
						DisableSceneMainLight().Forget();
					}
					RefreshCharacterInteractions();
					interactionManager.OnEndInteraction();
					await Singleton<ConversationManager>.instance.BeginConversation(dramaId);
					if (dramaGroup != null && dramaGroup.mode == 4)
					{
						LoungeUIScene.instance.EnableMainLight(enable: true);
						GameRenderScene.Set(GameRenderScene.Scene.Room);
					}
					LoungeUIScene.instance.SetCharacterAnimState(characterId, "LoungeEnterInteract");
				}
				InitLoungeStoryTimeline();
			}
		});
	}

	private async UniTask DisableSceneMainLight()
	{
		await UniTask.WaitForSeconds(0.5f);
		LoungeUIScene.instance.EnableMainLight(enable: false);
	}

	[Preserve]
	public bool TouchCharacter(int characterId, string zone)
	{
		return interactionManager?.PerformTouchInteraction(characterId, zone) ?? false;
	}

	public void GiveGift(int characterId, List<Item> gifts)
	{
		GiftToCharacterReq giftToCharacterReq = new GiftToCharacterReq();
		giftToCharacterReq.Gifts.AddRange(gifts);
		giftToCharacterReq.CharacterID = characterId;
		Singleton<NetManager>.instance.Request(giftToCharacterReq, async (IMessage msg) =>
		{
			if (msg is GiftToCharacterAck giftToCharacterAck)
			{
				if (gifts != null)
				{
					interactionManager.GiveGift(giftToCharacterAck.CharacterID, gifts, giftToCharacterAck.GotLikeability);
					Model<FavorabilityModel>.Interface.UpdateCharacterFavorInfoDic(giftToCharacterAck.CharacterID, giftToCharacterAck.CurLikeabilityLv, giftToCharacterAck.CurLikeabilityExp);
					Model<FavorabilityModel>.Interface.GotLikeability = giftToCharacterAck.GotLikeability;
					Model<FavorabilityModel>.Interface.CurLikeabilityLv = giftToCharacterAck.CurLikeabilityLv;
					Model<FavorabilityModel>.Interface.CurLikeabilityExp = giftToCharacterAck.CurLikeabilityExp;
					Model<FavorabilityModel>.Interface.CurSendGiftCount = giftToCharacterAck.TodayGiftCount;
					LoungeUIScene.instance.SetCharacterAnimState(characterId, "LoungeReceiveGift");
					Singleton<EventManager>.instance.EventDispatch(ClientEvent.SendGiftGotLikeability, null);
				}
			}
			else if (msg is ErrorAck errorAck)
			{
				LuminError.Handle(errorAck, new ErrorHandleOptions(ErrorPresentation.None));
			}
		});
	}

	public void InviteCharacter(int characterId, int pointId, Action callback)
	{
		CharacterLoungeData characterLoungeData = Singleton<LoungeSystemManager>.instance.characterManager.InitializeCharacter(characterId);
		if ((characterLoungeData != null && characterLoungeData.Irreplaceable) || (Model<LoungeModel>.Interface.IndexToCharacter.ContainsKey(pointId) && Model<LoungeModel>.Interface.IndexToCharacter[pointId].character.Count != 0))
		{
			return;
		}
		LoungeTriggerPointReq loungeTriggerPointReq = new LoungeTriggerPointReq();
		loungeTriggerPointReq.PointID = pointId;
		loungeTriggerPointReq.CharacterID = characterId;
		loungeTriggerPointReq.TriggerType = LoungeTriggerPointType.InviteCharacter;
		Singleton<NetManager>.instance.Request(loungeTriggerPointReq, async (IMessage msg) =>
		{
			if (msg is LoungeTriggerPointAck loungeTriggerPointAck)
			{
				Model<LoungeModel>.Interface.OnLoungeNtf(loungeTriggerPointAck.LoungeInfo);
				InitLoungeStoryTimeline();
				Singleton<LoungeSystemManager>.instance.characterManager.InitializeCharacter(characterId).Irreplaceable = true;
				LoungeUIScene.instance.ReplaceModel(loungeTriggerPointAck.PointID, characterId);
				RefreshCharacterInteractions();
				callback?.Invoke();
			}
		});
	}

	[Preserve]
	public bool UnlockRoom(int roomId)
	{
		return roomManager?.UnlockRoom(roomId) ?? false;
	}

	[Preserve]
	public CharacterLoungeData GetCharacterData(int characterId)
	{
		return characterManager?.GetCharacterData(characterId);
	}

	public override void UnInit()
	{
		if (Singleton<LoungeSystemManager>.instance == this)
		{
			interactionManager?.RemoveStoryTimelineHandle();
			characterManager = null;
			interactionManager = null;
			roomManager = null;
			isInitialized = false;
		}
	}
}
