using System;
using System.Collections.Generic;
using ACT;
using ACT.Battle;
using ACT.Config;
using ACT.Core;
using ACT.Event;
using ACT.Game;
using ACT.Game.Data;
using ACT.Model;
using ACT.Model.Jump;
using ACT.RichText;
using ACT.UI;
using ACT.Utility;
using ACT.World.StateObject;
using Bamboo.ECS;
using Bamboo.ImageCenter;
using Cysharp.Threading.Tasks;
using Fundamental;
using Google.Protobuf.Collections;
using Pb;

namespace Runtime.Model;

public class RogueNewModel : Model<RogueNewModel>, IJumpable
{
	public enum RogueRoomState
	{
		Challenging,
		ChallengeEnd,
		RoomOver,
		RogueEnd
	}

	public class RogueChallenge
	{
		public int modeId;

		public int coreId;

		public TeamUsage character;

		public int seed;
	}

	private RogueInfo _info;

	public ImageAssetStation RogueStation;

	public Dictionary<int, RogueMode> ListRogueMode = new Dictionary<int, RogueMode>();

	private RogueMode _mode;

	public RogueChallenge RogueChallengeInfo = new RogueChallenge();

	public RogueRoomState CurrentRoomState;

	private Dictionary<int, List<RogueBagItemData>> _rogueBagDic = new Dictionary<int, List<RogueBagItemData>>();

	private List<int> _rogueDiscards = new List<int>();

	private readonly List<InteractRogueChest> _activeRogueChests = new List<InteractRogueChest>(8);

	private int _propMaxCellNum = 8;

	private int _characterMaxCellNum = 2;

	private int _bloodbottleMaxCellNum = 1;

	private RogueFinishGameAck _finshack;

	private RogueFinishType _finishType;

	private Dictionary<int, List<TalentNode>> _talentDic = new Dictionary<int, List<TalentNode>>();

	private Dictionary<int, List<TalentNodeLevelData>> _talentNodeLevelDic = new Dictionary<int, List<TalentNodeLevelData>>();

	private readonly RogueDamageStatistics _damageStatistics = new RogueDamageStatistics();

	private RogueDamageStatisticsSnapshot _settlementStatistics;

	private Dictionary<string, int> _abilityUsage = new Dictionary<string, int>();

	public RogueInfo Info => _info;

	public long RemainRefreshTimeStamp
	{
		get
		{
			if (_info == null)
			{
				return 0L;
			}
			Season data = CoreUtils.GetData(_info.SeasonId, RuntimeConfigs.data.seasons);
			if (data == null)
			{
				return 0L;
			}
			System.DateTime now = TimeManager.ServerTime.Now;
			System.DateTime nextRefreshTime = GetNextRefreshTime(now, data.refreshType);
			return Math.Max(0L, (long)(nextRefreshTime - now).TotalMilliseconds);
		}
	}

	public IReadOnlyList<InteractRogueChest> ActiveRogueChests => _activeRogueChests;

	private long SeedId => _info.GameInfo.Seed;

	public int MagicPoints { get; set; }

	public LuminModelType JumpSourceType => LuminModelType.RogueLike;

	private static System.DateTime GetNextRefreshTime(System.DateTime now, int refreshType)
	{
		System.DateTime dateTime = new System.DateTime(now.Year, now.Month, now.Day, 4, 0, 0);
		switch (refreshType)
		{
		case 1:
			if (!(now < dateTime))
			{
				return dateTime.AddDays(1.0);
			}
			return dateTime;
		case 2:
		{
			int num = (int)(1 - now.DayOfWeek + 7) % 7;
			System.DateTime dateTime3 = dateTime.AddDays(num);
			if (!(now < dateTime3))
			{
				return dateTime3.AddDays(7.0);
			}
			return dateTime3;
		}
		case 3:
		{
			System.DateTime dateTime2 = new System.DateTime(now.Year, now.Month, 1, 4, 0, 0);
			if (!(now < dateTime2))
			{
				return dateTime2.AddMonths(1);
			}
			return dateTime2;
		}
		default:
			return now;
		}
	}

	protected override void Init()
	{
		RogueStation = ImageManager.instance.GetAssetStation();
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueRoomChallengeEnd, RogueRoomChallengeEnd);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.RogueOpenSettlement, OnRogueOpenSettlement);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.OnDamage, OnDamage);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.MonsterDieCount, OnMonsterDie);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.Rogue_Exit, OnRogueExit);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.BeforeLeaveWorld, OnBeforeLeaveWorld);
		Singleton<EventManager>.instance.AddEventListener(ClientEvent.AfterEnterWorld, OnAfterEnterWorld);
	}

	private void OnRogueExit(BaseEventContent obj)
	{
		_activeRogueChests.Clear();
	}

	private void OnRogueOpenSettlement(BaseEventContent obj)
	{
		if (_finshack != null)
		{
			OpenSettlement(_finshack, _finishType);
			_finshack = null;
		}
	}

	private void RogueRoomChallengeEnd(BaseEventContent obj)
	{
		if (_info.GameInfo.Index == _mode.mapNodeList.Length - 1)
		{
			SetRoomState(RogueRoomState.RogueEnd);
		}
		else
		{
			SetRoomState(RogueRoomState.ChallengeEnd);
		}
		if (_info.GameInfo.RoomInfo.RoomStatus != RogueRoomStatus.Finished)
		{
			SendRogueSetRoomFinished();
		}
	}

	private void SendRogueSetRoomFinished()
	{
		G.service.SendRogueSetRoomFinished((RogueSetRoomFinishedAck a) =>
		{
			_info.GameInfo.RoomInfo.RoomStatus = RogueRoomStatus.Finished;
		});
	}

	public void RogueRoomOver()
	{
		SetRoomState(RogueRoomState.RoomOver);
		Entity mainEntity = MonoECS.instance.mainEntity;
		SystemAbility abilitySystem = GameManager.abilitySystem;
		EvtRogueRoomOver evt = abilitySystem.GetEvt<EvtRogueRoomOver>(mainEntity, null);
		evt.mainEntity = mainEntity;
		abilitySystem.FireEvt(evt);
		abilitySystem.ReleaseEvt(evt);
	}

	public void Rest()
	{
		_rogueBagDic.Clear();
		_activeRogueChests.Clear();
		_abilityUsage.Clear();
		_damageStatistics.Clear();
		MagicPoints = 0;
		_settlementStatistics = null;
	}

	public Dictionary<int, List<RogueBagItemData>> GetCurrentRogueBag()
	{
		return _rogueBagDic;
	}

	public List<RogueBagItemData> GetRogueBagByType(int type)
	{
		return _rogueBagDic[type];
	}

	protected override void UnInit()
	{
		ImageManager.instance.UnloadAssetStation(RogueStation);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueRoomChallengeEnd, RogueRoomChallengeEnd);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.RogueOpenSettlement, OnRogueOpenSettlement);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.OnDamage, OnDamage);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.MonsterDieCount, OnMonsterDie);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.Rogue_Exit, OnRogueExit);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.BeforeLeaveWorld, OnBeforeLeaveWorld);
		Singleton<EventManager>.instance.RemoveEventListener(ClientEvent.AfterEnterWorld, OnAfterEnterWorld);
		ListRogueMode.Clear();
		_info = null;
		_finshack = null;
		_activeRogueChests.Clear();
		_abilityUsage.Clear();
		_damageStatistics.Clear();
		MagicPoints = 0;
		_settlementStatistics = null;
	}

	public void RegisterRogueChest(InteractRogueChest chest)
	{
		if (chest != null && !_activeRogueChests.Contains(chest))
		{
			_activeRogueChests.Add(chest);
		}
	}

	public void UnregisterRogueChest(InteractRogueChest chest)
	{
		_activeRogueChests.Remove(chest);
	}

	public void RogueInfo(RogueInfoNtf rogueInfoNtf)
	{
		_info = rogueInfoNtf.RogueInfo;
		GetCurrentRogueModeData(_info.SeasonId);
		InitBag();
		SetTalentNodeDic();
		SetTalentNodeLevelDic();
		SetBattleInfo();
	}

	public void RogueCoinInfo(RogueCoinNtf rogueCoinNtf)
	{
		if (_info != null && _info.GameInfo != null)
		{
			_info.GameInfo.Coin = rogueCoinNtf.Coin;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueCoinUpdate, null);
		}
	}

	private void InitBag()
	{
		_rogueBagDic.Clear();
		_rogueBagDic.Add(3, new List<RogueBagItemData>());
		_rogueBagDic.Add(2, new List<RogueBagItemData>());
		_rogueBagDic.Add(1, new List<RogueBagItemData>());
		foreach (KeyValuePair<int, ACT.Game.Data.RogueItem> item in _info.GameInfo.Item)
		{
			AddRogueDic(item.Value.ItemId, item.Value.Position);
		}
	}

	private int GetCurrentBagNullPos(int type)
	{
		return GetPropOrCharacterNextNullPos(type);
	}

	private int GetPropOrCharacterNextNullPos(int type)
	{
		int result = 0;
		if (type != 1)
		{
			List<RogueBagItemData> list = _rogueBagDic[type];
			int num = ((type == 3) ? _propMaxCellNum : _characterMaxCellNum);
			for (int i = 0; i < num; i++)
			{
				if (IsPosNull(i, list))
				{
					result = i;
					break;
				}
			}
		}
		return result;
	}

	private int GetCharacterNextNullPos()
	{
		List<RogueBagItemData> list = _rogueBagDic[2];
		int result = 0;
		for (int i = 0; i < _characterMaxCellNum; i++)
		{
			if (IsPosNull(i, list))
			{
				result = i;
			}
		}
		return result;
	}

	private bool IsPosNull(int pos, List<RogueBagItemData> list)
	{
		for (int i = 0; i < list.Count; i++)
		{
			if (list[i].RogueItem.Position == pos)
			{
				return false;
			}
		}
		return true;
	}

	private void AddRogueDic(int itemId, int pos = -1)
	{
		RogueElement data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueElements);
		RogueAssistCharacter data2 = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueAssistCharacters);
		int characterId = 0;
		if (data2 != null)
		{
			characterId = data2.entityCharacterDataId;
		}
		if (data != null)
		{
			int num = 0;
			if (_rogueBagDic.ContainsKey(data.elementType))
			{
				num = ((pos != -1) ? pos : GetCurrentBagNullPos(data.elementType));
				_rogueBagDic[data.elementType].Add(new RogueBagItemData(itemId, data.elementType, num, characterId));
				return;
			}
			num = ((pos != -1) ? pos : 0);
			List<RogueBagItemData> list = new List<RogueBagItemData>();
			list.Add(new RogueBagItemData(itemId, data.elementType, num, characterId));
			_rogueBagDic.Add(data.elementType, list);
		}
	}

	private void RemoveRogueDic(int itemId)
	{
		RogueElement data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueElements);
		if (data == null || !_rogueBagDic.TryGetValue(data.elementType, out var value))
		{
			return;
		}
		for (int i = 0; i < value.Count; i++)
		{
			if (itemId == value[i].RogueItem.ItemId)
			{
				value.Remove(value[i]);
			}
		}
	}

	public RogueGameInfo GetRogueGameInfo()
	{
		return _info.GameInfo;
	}

	public int GetBdCore()
	{
		return _info.GameInfo.CoreId;
	}

	public List<BdCore> GetBdCoreList()
	{
		List<BdCore> list = new List<BdCore>();
		Dictionary<int, BdCore> bdCores = RuntimeConfigs.data.bdCores;
		int seasonId = _info.SeasonId;
		foreach (KeyValuePair<int, BdCore> item in bdCores)
		{
			if (item.Value.seasonId == seasonId)
			{
				list.Add(item.Value);
			}
		}
		return list;
	}

	public int GetRogueCoin()
	{
		return _info.GameInfo.Coin;
	}

	public void SendRogueEnterNextRoom(RogueRoomType type)
	{
		MonoECS.instance.SyncGameInfos();
		G.service.SendRogueEnterNextRoom(type, GetCurrentRogueBagData(), GetBattleInfo(), GetAbilityUsage(), (RogueEnterNextRoomAck RogueEnterNextRoomAck) =>
		{
			_info.GameInfo.Coin = RogueEnterNextRoomAck.Coin;
			_info.GameInfo.RoomInfo = RogueEnterNextRoomAck.RoomInfo;
			_info.GameInfo.Index++;
			_rogueDiscards.Clear();
			SetRogueState();
			Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Rogue);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueCoinUpdate, null);
		});
	}

	public void SendRogueGmNextRoom(RogueRoomType type, Action<RogueGmNextRoomAck> callback = null)
	{
		G.service.SendRogueGmNextRoom(type, (RogueGmNextRoomAck ack) =>
		{
			if (ack?.RoomInfo == null || _info?.GameInfo == null)
			{
				callback?.Invoke(ack);
			}
			else
			{
				_info.GameInfo.RoomInfo = ack.RoomInfo;
				_info.GameInfo.Index++;
				_rogueDiscards.Clear();
				SetRogueState();
				Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Rogue);
				callback?.Invoke(ack);
			}
		});
	}

	private Dictionary<int, ACT.Game.Data.RogueItem> GetCurrentRogueBagData()
	{
		Dictionary<int, ACT.Game.Data.RogueItem> dictionary = new Dictionary<int, ACT.Game.Data.RogueItem>();
		foreach (KeyValuePair<int, List<RogueBagItemData>> item in _rogueBagDic)
		{
			for (int i = 0; i < item.Value.Count; i++)
			{
				dictionary.Add(item.Value[i].RogueItem.ItemId, item.Value[i].RogueItem);
			}
		}
		return dictionary;
	}

	public RogueBagItemData GetRogueBagItemByItemId(int itemId)
	{
		RogueElement data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueElements);
		if (data != null && _rogueBagDic.TryGetValue(data.elementType, out var value))
		{
			for (int i = 0; i < value.Count; i++)
			{
				if (itemId == value[i].RogueItem.ItemId)
				{
					return value[i];
				}
			}
		}
		return null;
	}

	public void InteractSendRogueEnterNextRoom(int index)
	{
		RogueRoomType type = _info.GameInfo.RoomInfo.NextRoomTypes[index];
		SendRogueEnterNextRoom(type);
	}

	public void SendRogueCoinReward(Action<RogueCoinRewardAck> callback)
	{
		G.service.SendRogueCoinReward(callback);
	}

	private void SetRogueState()
	{
		if (_info.GameInfo.RoomInfo.RoomType == RogueRoomType.Shop || _info.GameInfo.RoomInfo.RoomType == RogueRoomType.Null)
		{
			SetRoomState(RogueRoomState.RoomOver);
		}
		else
		{
			SetRoomState(RogueRoomState.Challenging);
		}
	}

	private void SetRoomState(RogueRoomState state)
	{
		if (CurrentRoomState != state)
		{
			CurrentRoomState = state;
			RogueRoomStateChangeEvent evt = Singleton<EventManager>.instance.GetEvt<RogueRoomStateChangeEvent>();
			evt.nextState = state;
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.Rogue_RoomStateChange, evt);
		}
	}

	public bool IsInDiscards(int itemId)
	{
		return _rogueDiscards.Contains(itemId);
	}

	public void SendRogueBuyItem(int buyItemId, Action<RogueBuyItemAck> callback, int oldItemId = 0, bool isReplace = false, int ReplacePosition = 0)
	{
		RogueInfo info = _info;
		bool isbuy = info != null && info.GameInfo.RoomInfo.RoomType == RogueRoomType.Shop && !IsInDiscards(buyItemId);
		G.service.SendRogueBuyItem(isbuy, buyItemId, (RogueBuyItemAck rogueBuyItemAck) =>
		{
			var (flag, bagitemId) = IsNeedUpgrade(buyItemId);
			if (flag)
			{
				CharacterUpgrade(bagitemId, buyItemId);
			}
			else
			{
				if (oldItemId != 0)
				{
					RemoveRogueItem(oldItemId);
					_rogueDiscards.Add(oldItemId);
				}
				AddRogueItem(buyItemId);
			}
			callback?.Invoke(rogueBuyItemAck);
		}, isReplace, ReplacePosition);
	}

	private void CharacterUpgrade(int bagitemId, int buyitemId)
	{
		RogueAssistCharacter data = CoreUtils.GetData(bagitemId, RuntimeConfigs.data.rogueAssistCharacters);
		RogueAssistCharacter data2 = CoreUtils.GetData(buyitemId, RuntimeConfigs.data.rogueAssistCharacters);
		if (data != null && data2 != null)
		{
			int tier = data.tier + data2.tier;
			RogueAssistCharacter rogueAssistCharacterByCharacterId = GetRogueAssistCharacterByCharacterId(data.entityCharacterDataId, tier);
			if (rogueAssistCharacterByCharacterId != null)
			{
				RemoveRogueItem(bagitemId);
				AddRogueItem(rogueAssistCharacterByCharacterId.id);
			}
		}
	}

	private RogueAssistCharacter GetRogueAssistCharacterByCharacterId(int characterId, int tier)
	{
		foreach (KeyValuePair<int, RogueAssistCharacter> rogueAssistCharacter in RuntimeConfigs.data.rogueAssistCharacters)
		{
			if (rogueAssistCharacter.Value.entityCharacterDataId == characterId && rogueAssistCharacter.Value.tier == tier)
			{
				return rogueAssistCharacter.Value;
			}
		}
		return null;
	}

	public (bool, int) IsNeedUpgrade(int itemId)
	{
		RogueElement data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueElements);
		if (data != null && data.elementType == 2)
		{
			List<RogueBagItemData> rogueBagByType = GetRogueBagByType(2);
			RogueAssistCharacter data2 = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueAssistCharacters);
			if (data2 != null)
			{
				for (int i = 0; i < rogueBagByType.Count; i++)
				{
					if (data2.entityCharacterDataId == rogueBagByType[i].CharacterId)
					{
						return (true, rogueBagByType[i].RogueItem.ItemId);
					}
				}
			}
		}
		return (false, 0);
	}

	public void SendRogueGmBuyItem(int buyItemId, Action<RogueGmAddItemAck> callback, int oldItemId = 0)
	{
		G.service.SendRogueBuyGmItem(buyItemId, (RogueGmAddItemAck rogueBuyItemAck) =>
		{
			var (flag, bagitemId) = IsNeedUpgrade(buyItemId);
			if (flag)
			{
				CharacterUpgrade(bagitemId, buyItemId);
			}
			else
			{
				if (oldItemId != 0)
				{
					RemoveRogueItem(oldItemId);
					_rogueDiscards.Add(oldItemId);
				}
				AddRogueItem(buyItemId);
			}
			callback?.Invoke(rogueBuyItemAck);
		});
	}

	private void AddRogueItem(int itemId)
	{
		AddRogueDic(itemId);
		CheckIsBloodbottle(itemId, 0);
		RogueAddItemEvent evt = Singleton<EventManager>.instance.GetEvt<RogueAddItemEvent>();
		evt.RogueBagItem = GetRogueBagItemByItemId(itemId);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueAddItem, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	private void CheckIsBloodbottle(int itemId, int type)
	{
		RogueElement data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueElements);
		if (data != null && data.elementType == 1)
		{
			switch (type)
			{
			case 0:
				EquipBottle(itemId);
				break;
			case 1:
				UnloadBottle(itemId);
				break;
			}
		}
	}

	private void EquipBottle(int itemId)
	{
		RogueHealthPotion data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueHealthPotions);
		Singleton<GameManager>.instance.worldManager.ResetTeamPotion(data.potionDataId);
	}

	private void UnloadBottle(int itemId)
	{
		Singleton<GameManager>.instance.worldManager.ResetTeamPotion(0);
	}

	private void RemoveRogueItem(int itemId)
	{
		RogueRemoveItemEvent evt = Singleton<EventManager>.instance.GetEvt<RogueRemoveItemEvent>();
		evt.RogueBagItem = GetRogueBagItemByItemId(itemId);
		CheckIsBloodbottle(itemId, 1);
		RemoveRogueDic(itemId);
		Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueRemoveItem, evt);
		Singleton<EventManager>.instance.ReleaseEvt(evt);
	}

	public bool IsNeedReplace(int itemId)
	{
		RogueElement data = CoreUtils.GetData(itemId, RuntimeConfigs.data.rogueElements);
		int num = 0;
		if (_rogueBagDic.ContainsKey(data.elementType))
		{
			if (data.elementType == 2)
			{
				num = _characterMaxCellNum;
			}
			else if (data.elementType == 3)
			{
				num = _propMaxCellNum;
			}
			else if (data.elementType == 1)
			{
				num = _bloodbottleMaxCellNum;
			}
			return _rogueBagDic[data.elementType].Count >= num;
		}
		return false;
	}

	public void SendOnRecycleItem(int itemId, Action<RogueRecycleItemAck> callback)
	{
		G.service.SendRecycleItem(itemId, (RogueRecycleItemAck RogueRecycleItemAck) =>
		{
			RemoveRogueItem(itemId);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueRecycleItem, null);
			callback?.Invoke(RogueRecycleItemAck);
		});
	}

	public void ReplaceRogueItem(int oldRogueItemId, int newRogueItemid)
	{
		SendRoguePickUpItem(newRogueItemid, isReplace: true, GetRogueBagItemByItemId(oldRogueItemId).RogueItem.Position);
		RemoveRogueItem(oldRogueItemId);
		AddRogueItem(newRogueItemid);
		if (_rogueDiscards.Contains(newRogueItemid))
		{
			_rogueDiscards.Remove(newRogueItemid);
		}
		_rogueDiscards.Add(oldRogueItemId);
	}

	public void SendRoguePickUpItem(int itemId, bool isReplace, int replacePosition, Action<RoguePickUpItemAck> callback = null)
	{
		G.service.SendRoguePickUpItem(itemId, isReplace, replacePosition, (RoguePickUpItemAck ack) =>
		{
			AddRogueItem(itemId);
			if (_rogueDiscards.Contains(itemId))
			{
				_rogueDiscards.Remove(itemId);
			}
			callback?.Invoke(ack);
		});
	}

	public int GetInscriptionById(int id)
	{
		int num = 0;
		foreach (RogueBagItemData item in _rogueBagDic[3])
		{
			if (CoreUtils.GetData(item.RogueItem.ItemId, RuntimeConfigs.data.rogueElements).elementType != 3)
			{
				continue;
			}
			ACT.Config.RogueItem data = CoreUtils.GetData(item.RogueItem.ItemId, RuntimeConfigs.data.rogueItems);
			if (data == null)
			{
				continue;
			}
			for (int i = 0; i < data.inscriptionIds.Length; i++)
			{
				if (id == data.inscriptionIds[i])
				{
					num++;
				}
			}
		}
		return num;
	}

	public void SendRogueHangGame(Action<RogueHangGameAck> callback)
	{
		G.service.SendRogueHangGame((RogueHangGameAck RogueHangGameAck) =>
		{
			callback(RogueHangGameAck);
			_info.GameState = StageStateEnum.StageStateTmpLeave;
		});
	}

	public void SendRogueContinueGame(Action<RogueContinueGameAck> callback = null)
	{
		G.service.SendRogueContinueGame((RogueContinueGameAck RogueContinueGameAck) =>
		{
			callback?.Invoke(RogueContinueGameAck);
			_info.GameState = StageStateEnum.StageStateOngoing;
			_info.GameInfo.Item.Clear();
			foreach (KeyValuePair<int, ACT.Game.Data.RogueItem> bagItem in RogueContinueGameAck.BagItems)
			{
				_info.GameInfo.Item.Add(bagItem.Key, bagItem.Value);
			}
			EnterRogue();
		});
	}

	private void EnterRogue()
	{
		InitBag();
		_rogueDiscards.Clear();
		SetRogueState();
		GetRogueModeData();
		Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Rogue);
	}

	private void OnBeforeLeaveWorld(BaseEventContent obj)
	{
		if (MonoECS.instance.sceneStatus == SceneStatus.Rogue)
		{
			_damageStatistics.PauseRecording();
		}
	}

	private void OnAfterEnterWorld(BaseEventContent obj)
	{
		if (MonoECS.instance.sceneStatus == SceneStatus.Rogue)
		{
			_damageStatistics.ResumeRecording();
		}
	}

	private void SetBattleInfo()
	{
		RogueGameInfo gameInfo = Info.GameInfo;
		_damageStatistics.RestoreFromBattleInfo(gameInfo.BattleInfo);
		_settlementStatistics = null;
		MagicPoints = GetBattleInfoValueOrDefault(gameInfo.BattleInfo, 0);
		SetAbilityUsage(gameInfo.EffectInfo);
	}

	private static int GetBattleInfoValueOrDefault(IDictionary<int, int> battleInfo, int key)
	{
		if (battleInfo == null)
		{
			return 0;
		}
		if (!battleInfo.TryGetValue(key, out var value))
		{
			return 0;
		}
		return value;
	}

	public void SendRogueFinishGame(RogueFinishType finishType, Action<RogueFinishGameAck> callback = null)
	{
		G.service.SendRogueFinishGame(finishType, (RogueFinishGameAck RogueFinishGameAck) =>
		{
			_damageStatistics.Freeze();
			_settlementStatistics = _damageStatistics.CreateSnapshot();
			_damageStatistics.Clear();
			_abilityUsage.Clear();
			MagicPoints = 0;
			_finshack = RogueFinishGameAck;
			_finishType = finishType;
			callback?.Invoke(RogueFinishGameAck);
			_info.GameState = StageStateEnum.StageStateOut;
			_info.WeeklyCoinGain = RogueFinishGameAck.WeeklyCoinGain;
			if (finishType == RogueFinishType.Pass)
			{
				_info.ClearedMode.AddRange(RogueFinishGameAck.ClearedMode);
			}
		});
	}

	private void OpenSettlement(RogueFinishGameAck ack, RogueFinishType finishType)
	{
		RogueGameInfo rogueGameInfo = _info?.GameInfo;
		RogueMode rogueMode = ((rogueGameInfo == null) ? null : CoreUtils.GetData(rogueGameInfo.ModeId, RuntimeConfigs.data.rogueModes));
		RogueDamageStatisticsSnapshot settlementStatistics = GetSettlementStatistics();
		RogueSettlementViewData rogueSettlementViewData = new RogueSettlementViewData
		{
			FinishType = finishType,
			ModeId = (rogueGameInfo?.ModeId ?? 0),
			ModeNameLocalizeId = (rogueMode?.name ?? 0),
			CurrentProgress = ((rogueGameInfo != null) ? (rogueGameInfo.Index + 1) : 0),
			TotalProgress = (rogueMode?.mapNodeList?.Length).GetValueOrDefault(),
			ElapsedSeconds = (settlementStatistics?.ElapsedTime ?? 0f),
			MaxDamage = (settlementStatistics?.MaxDamageDealt ?? 0),
			GainCoin = (rogueGameInfo?.Coin ?? 0),
			NormalKillCount = (settlementStatistics?.NormalKillCount ?? 0),
			EliteKillCount = (settlementStatistics?.EliteKillCount ?? 0),
			TalentTreePoint = (ack?.TalentTreePoint ?? 0),
			OnLeave = Leave,
			OnRetry = Retry
		};
		if (rogueGameInfo?.BattleCharacter?.Characters != null)
		{
			using IEnumerator<KeyValuePair<int, Character>> enumerator = rogueGameInfo.BattleCharacter.Characters.GetEnumerator();
			if (enumerator.MoveNext())
			{
				KeyValuePair<int, Character> current = enumerator.Current;
				rogueSettlementViewData.CharacterIds.Add(current.Key);
			}
		}
		if (_rogueBagDic.TryGetValue(2, out var value))
		{
			foreach (RogueBagItemData item in value)
			{
				if (item.CharacterId != 0 && rogueSettlementViewData.CharacterIds.Count < 3)
				{
					rogueSettlementViewData.CharacterIds.Add(item.CharacterId);
				}
			}
		}
		if (ack != null)
		{
			foreach (Item item2 in ack.Items)
			{
				rogueSettlementViewData.Rewards.Add(new RogueSettlementRewardData
				{
					ItemId = item2.Id,
					Count = item2.Count
				});
			}
		}
		if (_rogueBagDic.TryGetValue(3, out var value2))
		{
			foreach (RogueBagItemData item3 in value2)
			{
				if (CoreUtils.GetData(item3.RogueItem.ItemId, RuntimeConfigs.data.rogueItems) != null)
				{
					rogueSettlementViewData.BuildItems.Add(item3);
				}
			}
			rogueSettlementViewData.BuildItems.Sort((RogueBagItemData left, RogueBagItemData right) =>
			{
				ACT.Config.RogueItem data = CoreUtils.GetData(left.RogueItem.ItemId, RuntimeConfigs.data.rogueItems);
				return (CoreUtils.GetData(right.RogueItem.ItemId, RuntimeConfigs.data.rogueItems)?.rarity ?? 0).CompareTo(data?.rarity ?? 0);
			});
		}
		Singleton<NewUIManager>.instance.OpenUI(UI_TYPE.UI_ROGUESETTLEMENT, rogueSettlementViewData);
	}

	private async void Leave()
	{
		Singleton<GameState>.instance.SetWorldLoadState(WorldLoadState.GiveUp);
		await Singleton<GameManager>.instance.worldManager.EnterWorldWithLoading(SceneStatus.Main);
		Singleton<GameState>.instance.RemoveWorldLoadState(WorldLoadState.GiveUp);
	}

	private void Retry()
	{
		RetryRogueChallenge(0L);
	}

	private void ResetRogueRunStatistics()
	{
		_damageStatistics.Clear();
		MagicPoints = 0;
		ClearAbilityUsage();
		_settlementStatistics = null;
	}

	public void SendRogueChallenge(long seed = 0L)
	{
		G.service.SendRogueChallenge(RogueChallengeInfo.modeId, RogueChallengeInfo.coreId, RogueChallengeInfo.character, seed, (RogueChallengeAck RogueChallengeAck) =>
		{
			ResetRogueRunStatistics();
			_info.GameInfo = RogueChallengeAck.GameInfo;
			InitBag();
			EnterRogue();
		});
	}

	public void RetryRogueChallenge(long seed = 0L)
	{
		TeamUsage teamUsage = new TeamUsage();
		teamUsage.CharacterUsage.Add(new TeamCharacterUsage
		{
			CharacterId = _info.GameInfo.CharacterProbationId,
			IsTrial = false
		});
		G.service.SendRogueChallenge(_info.GameInfo.ModeId, _info.GameInfo.CoreId, teamUsage, seed, (RogueChallengeAck RogueChallengeAck) =>
		{
			ResetRogueRunStatistics();
			_info.GameInfo = RogueChallengeAck.GameInfo;
			InitBag();
			EnterRogue();
		});
	}

	public void SendRogueEnterRoom(int gameworldId)
	{
		G.service.SendRogueEnterRoom(gameworldId, (RogueEnterRoomAck RogueEnterRoomAck) =>
		{
			_info.GameInfo = RogueEnterRoomAck.GameInfo;
			_info.GameInfo.ModeId = 1;
			InitBag();
			EnterRogue();
		});
	}

	private void GetRogueModeData()
	{
		_mode = CoreUtils.GetData(_info.GameInfo.ModeId, RuntimeConfigs.data.rogueModes);
	}

	private void GetCurrentRogueModeData(int seasonId)
	{
		ListRogueMode.Clear();
		foreach (KeyValuePair<int, RogueMode> rogueMode in RuntimeConfigs.data.rogueModes)
		{
			if (rogueMode.Value.seasonId == seasonId)
			{
				ListRogueMode.Add(rogueMode.Key, rogueMode.Value);
			}
		}
	}

	public bool HasRoomReward()
	{
		if (Info.GameInfo.RoomInfo.RoomType != RogueRoomType.Null)
		{
			return Info.GameInfo.RoomInfo.RoomType != RogueRoomType.Shop;
		}
		return false;
	}

	public List<Synergy> GetSynergysByInscriptionId(int InscriptionId)
	{
		List<Synergy> list = new List<Synergy>();
		foreach (KeyValuePair<int, Synergy> synergy in RuntimeConfigs.data.synergys)
		{
			if (synergy.Value.inscriptionId == InscriptionId)
			{
				list.Add(synergy.Value);
			}
		}
		return list;
	}

	public bool GetIsBuyByRogueItemId(int id)
	{
		if (Model<RogueNewModel>.Interface.Info == null)
		{
			return true;
		}
		if (Model<RogueNewModel>.Interface.Info.GameInfo.RoomInfo.RoomType == RogueRoomType.Shop)
		{
			return !Model<RogueNewModel>.Interface.IsInDiscards(id);
		}
		return false;
	}

	public bool CheckItemIsBuy(int id)
	{
		if (IsInDiscards(id) || CheckItemInBag(id))
		{
			return true;
		}
		return false;
	}

	public bool CheckItemInBag(int id)
	{
		foreach (KeyValuePair<int, List<RogueBagItemData>> item in _rogueBagDic)
		{
			for (int i = 0; i < item.Value.Count; i++)
			{
				if (item.Value[i].RogueItem.ItemId == id)
				{
					return true;
				}
			}
		}
		return false;
	}

	private void OnDamage(BaseEventContent obj)
	{
		if (MonoECS.instance.sceneStatus == SceneStatus.Rogue && obj is DamageEvt { AttackData: not null } damageEvt)
		{
			Entity mainEntity = MonoECS.instance.mainEntity;
			if (mainEntity != null && damageEvt.AttackData.attackee == mainEntity)
			{
				int rogueMapnode = GameUtility.GetRogueMapnode();
				_damageStatistics.RecordDamageTaken(rogueMapnode, (int)damageEvt.AttackData.damage);
			}
			if (mainEntity != null && damageEvt.AttackData.attacker == mainEntity)
			{
				_damageStatistics.RecordDamageDealt(damageEvt.AttackData.actualDamage, damageEvt.AttackData.critical);
			}
		}
	}

	public RogueDamageStatisticsSnapshot GetSettlementStatistics()
	{
		return _settlementStatistics ?? _damageStatistics.CreateSnapshot();
	}

	public float GetMapDamage(int mapNodeId)
	{
		return _damageStatistics.GetMapDamage(mapNodeId);
	}

	public float GetCurrentMapDamage()
	{
		int rogueMapnode = GameUtility.GetRogueMapnode();
		return GetMapDamage(rogueMapnode);
	}

	public int GetTotalDamage()
	{
		return _damageStatistics.TotalDamageTaken;
	}

	public Dictionary<int, int> GetAllMapDamage()
	{
		return _damageStatistics.GetAllMapDamage();
	}

	public void ClearDamage()
	{
		_damageStatistics.ClearDamageTaken();
	}

	private void OnMonsterDie(BaseEventContent obj)
	{
		if (MonoECS.instance.sceneStatus == SceneStatus.Rogue && obj is EntityDieEvt { entity: var entity } entityDieEvt && entity != null)
		{
			int rogueMapnode = GameUtility.GetRogueMapnode();
			switch (entityDieEvt.entity.GetEntityType())
			{
			case EntityType.Monster:
				_damageStatistics.RecordMonsterDeath(rogueMapnode, isElite: false);
				break;
			case EntityType.Elite:
				_damageStatistics.RecordMonsterDeath(rogueMapnode, isElite: true);
				break;
			}
		}
	}

	public int GetMapKillCount(int mapNodeId)
	{
		return _damageStatistics.GetMapKillCount(mapNodeId);
	}

	public int GetCurrentMapKillCount()
	{
		int rogueMapnode = GameUtility.GetRogueMapnode();
		return GetMapKillCount(rogueMapnode);
	}

	public int GetTotalKillCount()
	{
		return _damageStatistics.TotalKillCount;
	}

	public Dictionary<int, int> GetAllMapKillCount()
	{
		return _damageStatistics.GetAllMapKillCount();
	}

	public void ClearKillCount()
	{
		_damageStatistics.ClearKillCount();
	}

	private Dictionary<int, int> GetBattleInfo()
	{
		return _damageStatistics.CreateBattleInfo(MagicPoints);
	}

	public void OnAbilityUsed(string abName)
	{
		if (_abilityUsage.ContainsKey(abName))
		{
			_abilityUsage[abName]++;
		}
		else
		{
			_abilityUsage[abName] = 1;
		}
	}

	public int CheckAbilityUsed(string abName)
	{
		if (!_abilityUsage.ContainsKey(abName) || _abilityUsage[abName] <= 0)
		{
			return 0;
		}
		return _abilityUsage[abName];
	}

	private Dictionary<int, int> GetAbilityUsage()
	{
		Dictionary<int, int> dictionary = new Dictionary<int, int>();
		foreach (var (abilityName, value) in _abilityUsage)
		{
			int abilityId = GetAbilityId(abilityName);
			if (abilityId > 0)
			{
				dictionary[abilityId] = value;
			}
		}
		return dictionary;
	}

	public int GetAbilityId(string abilityName)
	{
		return MonoECS.instance.mainEntity.GetCompAbility().GetAbilityByName(abilityName)?.skillLevelInfo.id ?? 0;
	}

	public void SetAbilityUsage(MapField<int, int> usage)
	{
		ClearAbilityUsage();
		foreach (KeyValuePair<int, int> item in usage)
		{
			string text = CoreUtils.GetData(item.Key, RuntimeConfigs.data.combatEffects)?.abilityName;
			if (!string.IsNullOrEmpty(text))
			{
				_abilityUsage[text] = item.Value;
			}
		}
	}

	public void ClearAbilityUsage()
	{
		_abilityUsage.Clear();
	}

	public void SetTalentNodeDic()
	{
		Dictionary<int, TalentNode> talentNodes = RuntimeConfigs.data.talentNodes;
		int seasonId = _info.SeasonId;
		foreach (KeyValuePair<int, TalentNode> item in talentNodes)
		{
			if (item.Value.seasonId == seasonId)
			{
				if (_talentDic.TryGetValue(item.Value.type, out var value))
				{
					value.Add(item.Value);
					continue;
				}
				List<TalentNode> list = new List<TalentNode>();
				list.Add(item.Value);
				_talentDic[item.Value.type] = list;
			}
		}
	}

	private void SetTalentNodeLevelDic()
	{
		Dictionary<int, TalentNodeLevelData> talentNodeLevelDatas = RuntimeConfigs.data.talentNodeLevelDatas;
		_talentNodeLevelDic.Clear();
		foreach (KeyValuePair<int, TalentNodeLevelData> item in talentNodeLevelDatas)
		{
			if (_talentNodeLevelDic.TryGetValue(item.Value.talentNodeId, out var value))
			{
				value.Add(item.Value);
				continue;
			}
			List<TalentNodeLevelData> list = new List<TalentNodeLevelData>();
			list.Add(item.Value);
			_talentNodeLevelDic[item.Value.talentNodeId] = list;
		}
	}

	public RogueTalentTreeNode GetTalentNodeById(int id)
	{
		if (_info.TalentTree.Nodes.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public Dictionary<int, List<TalentNode>> GetTalentNodeDic()
	{
		return _talentDic;
	}

	public int GetTalentNodeCostByType(int type)
	{
		if (_info?.TalentTree?.Nodes == null)
		{
			return 0;
		}
		int num = 0;
		foreach (KeyValuePair<int, RogueTalentTreeNode> node in _info.TalentTree.Nodes)
		{
			if (CoreUtils.GetData(node.Value.NodeId, RuntimeConfigs.data.talentNodes).type != type)
			{
				continue;
			}
			int level = node.Value.Level;
			if (level <= 0)
			{
				continue;
			}
			foreach (KeyValuePair<int, TalentNodeLevelData> talentNodeLevelData in RuntimeConfigs.data.talentNodeLevelDatas)
			{
				if (talentNodeLevelData.Value.talentNodeId == node.Value.NodeId && talentNodeLevelData.Value.level <= level)
				{
					num += talentNodeLevelData.Value.upgradeCost[0].count;
				}
			}
		}
		return num;
	}

	public int GetAllTalentNodeCost()
	{
		return _info.TalentTree.UsedPoint;
	}

	public int GetTalentNodeLevel(int id)
	{
		int result = 0;
		if (_info?.TalentTree?.Nodes == null)
		{
			return result;
		}
		if (_info.TalentTree.Nodes.TryGetValue(id, out var value))
		{
			result = value.Level;
		}
		return result;
	}

	public List<TalentNodeLevelData> GetTalentNodeLevelDataList(int id)
	{
		if (_talentNodeLevelDic.TryGetValue(id, out var value))
		{
			return value;
		}
		return null;
	}

	public TalentNodeLevelData GetTalentNodeLevelDataByLevel(int id, int level)
	{
		if (_talentNodeLevelDic.TryGetValue(id, out var value))
		{
			for (int i = 0; i < value.Count; i++)
			{
				if (level == value[i].level)
				{
					return value[i];
				}
			}
		}
		return null;
	}

	public void SendUpgradeTalentNode(int NodeId, Action<RogueUpdateTalentTreeNodeAck> callback)
	{
		G.service.SendUpgradeTalentNode(NodeId, (RogueUpdateTalentTreeNodeAck ack) =>
		{
			callback(ack);
			Singleton<EventManager>.instance.EventDispatch(ClientEvent.RogueUpgradeTalentNode, null);
		});
	}

	public void TalentNodeUpgradeNtf(RogueTalentTreeNtf rogueTalentTreeNtf)
	{
		_info.TalentTree = rogueTalentTreeNtf.TalentTree;
	}

	public JumpResult CanJump(RuntimeJumpData jumpData)
	{
		ACT.Config.Mission data = CoreUtils.GetData(CoreUtils.GetData(CoreUtils.GetData(1047, RuntimeConfigs.data.systemOpens).missionId, RuntimeConfigs.data.missionGroups).missionId[0], RuntimeConfigs.data.missions);
		if (!Singleton<SystemUnlockManager>.instance.IsSystemUnlock(SystemType.Rogue))
		{
			return new JumpResult
			{
				ShowType = JumpResult.JumpShowType.Forbidden,
				Message = CustomTagParser.ReplacePreconditionText(data, data.number, data.param)
			};
		}
		return new JumpResult
		{
			ShowType = JumpResult.JumpShowType.CanJump
		};
	}

	public void Jump(RuntimeJumpData jumpData)
	{
		Singleton<NewUIManager>.instance.OpenUIAsync(UI_TYPE.UI_ROGUEENTRANCE).Forget();
	}
}
