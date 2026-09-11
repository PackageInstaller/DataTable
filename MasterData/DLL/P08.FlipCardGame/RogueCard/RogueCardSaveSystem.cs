using System;
using System.Collections.Generic;
using System.Security.Cryptography;
using System.Text;
using LitJson;
using UnityEngine;

namespace RogueCard;

public class RogueCardSaveSystem
{
	public const int SaveDataOtherDataForceSelectIndex = 0;

	public const int SaveDataOtherDataStageUseTimeIndex = 1;

	public const int SaveDataOtherDataChallengeStoryNormalImageIndex = 2;

	public const int SaveDataOtherDataDeckEffectStartIndex = 10;

	public const int SaveDataOtherDataDeckEffectEndIndex = 29;

	public const int SaveDataOtherDataPlayerEffectStartIndex = 30;

	public const int SaveDataOtherDataPlayerEffectEndIndex = 99;

	public const int PackageJokerVersionEncodeBase = 10000;

	private const int RuntimeEffectEntrySlotCount = 2;

	private const int RuntimeEffectCountBitShift = 16;

	public bool saveLock;

	public string rollBackData;

	private RogueCardSaveData current_data;

	private static List<int> trackingShopItem = new List<int>();

	private static List<int> trackingTypeItem = new List<int>();

	private static List<int> trackingCostItem = new List<int>();

	private static List<int> trackingVersionItem = new List<int>();

	private static List<int> trackingSelShopItem = new List<int>();

	private static List<int> trackingSelTypeItem = new List<int>();

	private static List<int> trackingSelCostItem = new List<int>();

	private static List<int> trackingSelVersionItem = new List<int>();

	public RogueCardSaveSystem()
	{
		rollBackData = "";
	}

	public static int EncodeShopItemID(int shopItemID, int versionID)
	{
		if (versionID > 0)
		{
			return 1000 * versionID + shopItemID;
		}
		return shopItemID;
	}

	public static int EncodeRecordItemID(int type, int id)
	{
		return 1000 * type + id;
	}

	public static (int, int) DecodeRecordItemID(int saveID)
	{
		int item = saveID / 1000;
		int item2 = saveID % 1000;
		return (item, item2);
	}

	public static (int, int) DecodeShopItemID(int saveID)
	{
		if (saveID > 1000)
		{
			int item = saveID / 1000;
			return (saveID % 1000, item);
		}
		return (saveID, 0);
	}

	public static int EncodePackageJokerID(int jokerID, int versionID)
	{
		if (versionID > 0)
		{
			return versionID * 10000 + jokerID;
		}
		return jokerID;
	}

	public static (int, int) DecodePackageJokerID(int saveID)
	{
		if (saveID >= 10000)
		{
			int item = saveID / 10000;
			return (saveID % 10000, item);
		}
		return (saveID, 0);
	}

	public void SaveGameData(bool isRollbackData = false)
	{
		if ((isRollbackData || !saveLock) && ReadGameContext())
		{
			string text = JsonMapper.ToJson(current_data);
			if (RogueCardGameMain.GameContext.stageType == LevelType.Challenge)
			{
				string text2 = CalculateChecksum(current_data);
				LuaHelper.CallFunction("RogueCardGameBridge.SaveStageData", RogueCardGameMain.GameContext.stageID, text, text2);
			}
			else
			{
				LuaHelper.CallFunction("RogueCardGameBridge.SaveStageData", RogueCardGameMain.GameContext.stageID, text);
			}
			if (isRollbackData)
			{
				SaveRollbackData(text);
				LuaHelper.CallFunction("RogueCardGameBridge.SaveRollbackData", RogueCardGameMain.GameContext.stageID, text);
			}
		}
	}

	private string CalculateChecksum(RogueCardSaveData data)
	{
		StringBuilder stringBuilder = new StringBuilder();
		if (data.global_attr_dic != null)
		{
			foreach (int item in data.global_attr_dic)
			{
				stringBuilder.Append(item);
			}
		}
		if (data.hand_type_level != null)
		{
			foreach (int item2 in data.hand_type_level)
			{
				stringBuilder.Append(item2);
			}
		}
		stringBuilder.Append(data.play_num);
		stringBuilder.Append(data.gold);
		stringBuilder.Append(data.discard_num);
		stringBuilder.Append(data.cur_round);
		stringBuilder.Append(data.target_score);
		stringBuilder.Append(data.boss_target_score);
		stringBuilder.Append(data.score);
		string s = stringBuilder.ToString();
		using MD5 mD = MD5.Create();
		byte[] bytes = Encoding.UTF8.GetBytes(s);
		byte[] array = mD.ComputeHash(bytes);
		StringBuilder stringBuilder2 = new StringBuilder();
		byte[] array2 = array;
		foreach (byte b in array2)
		{
			stringBuilder2.Append(b.ToString("x2"));
		}
		return stringBuilder2.ToString();
	}

	public RogueCardSaveData GetGameData()
	{
		try
		{
			ReadGameContext();
		}
		catch
		{
			Debug.LogError("RogueCard 处理埋点时报错");
		}
		return current_data;
	}

	public RogueCardSaveData GetCurrentData()
	{
		return current_data;
	}

	public RogueCardSaveData LoadGameData(string saveJson, string rollBackJson)
	{
		try
		{
			SaveRollbackData(rollBackJson);
			if (string.IsNullOrEmpty(saveJson))
			{
				InitializeDefaultData();
				return current_data;
			}
			current_data = JsonMapper.ToObject<RogueCardSaveData>(saveJson);
			EnsureSaveDataInitialized(current_data);
			return current_data;
		}
		catch (Exception ex)
		{
			Debug.LogError("加载存档失败: " + ex.Message);
			InitializeDefaultData();
			return current_data;
		}
	}

	public void SaveRollbackData(string rollBackSaveJson)
	{
		rollBackData = rollBackSaveJson;
	}

	private void InitializeDefaultData()
	{
		current_data = new RogueCardSaveData();
		EnsureSaveDataInitialized(current_data);
	}

	private void EnsureSaveDataInitialized(RogueCardSaveData saveData)
	{
		if (saveData == null)
		{
			current_data = new RogueCardSaveData();
			saveData = current_data;
		}
		if (saveData.record_items == null)
		{
			saveData.record_items = new List<int>();
		}
		if (saveData.global_attr_dic == null)
		{
			saveData.global_attr_dic = new List<int>();
		}
		if (saveData.hand_type_level == null)
		{
			saveData.hand_type_level = new List<int>();
		}
		if (saveData.deck_cards == null)
		{
			saveData.deck_cards = new List<RogueCardSaveCardData>();
		}
		if (saveData.pile_cards == null)
		{
			saveData.pile_cards = new List<RogueCardSaveCardData>();
		}
		if (saveData.hand_cards == null)
		{
			saveData.hand_cards = new List<RogueCardSaveCardData>();
		}
		if (saveData.jokers == null)
		{
			saveData.jokers = new List<RogueCardSaveJokerData>();
		}
		if (saveData.shop_item_data_list == null)
		{
			saveData.shop_item_data_list = new List<int>();
		}
		if (saveData.shop_package_data_list == null)
		{
			saveData.shop_package_data_list = new List<int>();
		}
		if (saveData.weal_list == null)
		{
			saveData.weal_list = new List<int>();
		}
		if (saveData.woe_list == null)
		{
			saveData.woe_list = new List<int>();
		}
		if (saveData.disable_type == null)
		{
			saveData.disable_type = new List<int>();
		}
		if (saveData.other_data == null)
		{
			saveData.other_data = new List<int>();
		}
		if (saveData.wu_chang_wait_cards == null)
		{
			saveData.wu_chang_wait_cards = new List<RogueCardSaveCardData>();
		}
		if (saveData.package_wuchang_id == null)
		{
			saveData.package_wuchang_id = new List<int>();
		}
		if (saveData.package_joker_id == null)
		{
			saveData.package_joker_id = new List<int>();
		}
		if (saveData.settle_data == null)
		{
			saveData.settle_data = new RogueCardSaveSettleData();
		}
		if (saveData.settle_data.hand_type_use_num == null)
		{
			saveData.settle_data.hand_type_use_num = new List<int>();
		}
		if (saveData.settle_data.hand_type_contain_num == null)
		{
			saveData.settle_data.hand_type_contain_num = new List<int>();
		}
		if (saveData.settle_data.use_item_id == null)
		{
			saveData.settle_data.use_item_id = new List<int>();
		}
		if (saveData.settle_data.enhance_id == null)
		{
			saveData.settle_data.enhance_id = new List<int>();
		}
		if (saveData.settle_data.weal_woe_id == null)
		{
			saveData.settle_data.weal_woe_id = new List<int>();
		}
		while (saveData.other_data.Count <= 99)
		{
			saveData.other_data.Add(-1);
		}
		EnsureCardListInitialized(saveData.deck_cards);
		EnsureCardListInitialized(saveData.pile_cards);
		EnsureCardListInitialized(saveData.hand_cards);
		EnsureCardListInitialized(saveData.wu_chang_wait_cards);
		EnsureJokerListInitialized(saveData.jokers);
	}

	private void EnsureCardListInitialized(List<RogueCardSaveCardData> cardList)
	{
		if (cardList == null)
		{
			return;
		}
		foreach (RogueCardSaveCardData card in cardList)
		{
			if (card != null && card.other_data == null)
			{
				card.other_data = new List<int>();
			}
		}
	}

	private void EnsureJokerListInitialized(List<RogueCardSaveJokerData> jokerList)
	{
		if (jokerList == null)
		{
			return;
		}
		foreach (RogueCardSaveJokerData joker in jokerList)
		{
			if (joker != null && joker.other_data == null)
			{
				joker.other_data = new List<int>();
			}
		}
	}

	private bool ReadGameContext()
	{
		if (current_data == null)
		{
			InitializeDefaultData();
		}
		RogueCardGameContext gameContext = RogueCardGameMain.GameContext;
		if (RogueCardGameMain.Instance.CurState is SelectStageState)
		{
			current_data.cur_state = 0;
		}
		else if (RogueCardGameMain.Instance.CurState is StageState)
		{
			current_data.cur_state = 1;
		}
		else if (RogueCardGameMain.Instance.CurState is ShopState)
		{
			current_data.cur_state = 2;
		}
		else if (RogueCardGameMain.Instance.CurState is PackageState)
		{
			current_data.cur_state = 3;
		}
		else if (RogueCardGameMain.Instance.CurState is WuChangState)
		{
			current_data.cur_state = 4;
		}
		else if (RogueCardGameMain.Instance.CurState is SettleState)
		{
			current_data.cur_state = 6;
		}
		else
		{
			if (!(RogueCardGameMain.Instance.CurState is TurnSettleState))
			{
				return false;
			}
			current_data.cur_state = 5;
		}
		current_data.record_items.Clear();
		foreach (int recordItem in gameContext.recordItems)
		{
			current_data.record_items.Add(EncodeRecordItemID(1, recordItem));
		}
		foreach (int item5 in gameContext.recordEnhance)
		{
			current_data.record_items.Add(EncodeRecordItemID(2, item5));
		}
		current_data.global_attr_dic = gameContext.globalAttrDic.dictValTolist();
		current_data.difficulty = gameContext.challengeDifficulty;
		current_data.stage_id = gameContext.stageID;
		current_data.cur_round = gameContext.curRound;
		current_data.cur_stage_state = (int)gameContext.curStageState;
		current_data.hand_type_level = gameContext.handTypeLevel.dictValTolist();
		current_data.gold = gameContext.gold;
		current_data.random_seed = gameContext.RandomSeed;
		current_data.deck_id = gameContext.rogueDeck.deckID;
		current_data.deck_cards.Clear();
		foreach (RogueCardData card in gameContext.rogueDeck.cards)
		{
			RogueCardSaveCardData rogueCardSaveCardData = new RogueCardSaveCardData
			{
				suit = (int)card.suit,
				rank = (int)card.rank,
				enhance_id = card.enhanceID,
				tag_id = card.tagID,
				effect_disable = card.effectDisable,
				other_data = new List<int>()
			};
			int num = 0;
			for (int i = 0; i < card.otherEffect.Count; i++)
			{
				rogueCardSaveCardData.other_data.Add(card.otherEffect[i].effectID);
				num++;
				rogueCardSaveCardData.other_data.Add(card.otherEffect[i].triggerCount);
				num++;
				rogueCardSaveCardData.other_data.Add(card.otherEffect[i].lifeCount);
				num++;
			}
			current_data.deck_cards.Add(rogueCardSaveCardData);
		}
		current_data.pile_cards.Clear();
		foreach (RogueCardData item6 in gameContext.rogueDeck.discardPile)
		{
			RogueCardSaveCardData rogueCardSaveCardData2 = new RogueCardSaveCardData
			{
				suit = (int)item6.suit,
				rank = (int)item6.rank,
				enhance_id = item6.enhanceID,
				tag_id = item6.tagID,
				effect_disable = item6.effectDisable,
				other_data = new List<int>()
			};
			int num2 = 0;
			for (int j = 0; j < item6.otherEffect.Count; j++)
			{
				rogueCardSaveCardData2.other_data.Add(item6.otherEffect[j].effectID);
				num2++;
				rogueCardSaveCardData2.other_data.Add(item6.otherEffect[j].triggerCount);
				num2++;
				rogueCardSaveCardData2.other_data.Add(item6.otherEffect[j].lifeCount);
				num2++;
			}
			current_data.pile_cards.Add(rogueCardSaveCardData2);
		}
		current_data.hand_cards.Clear();
		foreach (RogueCardData orderedHandDatum in gameContext.handData.GetOrderedHandData())
		{
			RogueCardSaveCardData rogueCardSaveCardData3 = new RogueCardSaveCardData
			{
				suit = (int)orderedHandDatum.suit,
				rank = (int)orderedHandDatum.rank,
				enhance_id = orderedHandDatum.enhanceID,
				tag_id = orderedHandDatum.tagID,
				effect_disable = orderedHandDatum.effectDisable,
				other_data = new List<int>()
			};
			int num3 = 0;
			for (int k = 0; k < orderedHandDatum.otherEffect.Count; k++)
			{
				rogueCardSaveCardData3.other_data.Add(orderedHandDatum.otherEffect[k].effectID);
				num3++;
				rogueCardSaveCardData3.other_data.Add(orderedHandDatum.otherEffect[k].triggerCount);
				num3++;
				rogueCardSaveCardData3.other_data.Add(orderedHandDatum.otherEffect[k].lifeCount);
				num3++;
			}
			current_data.hand_cards.Add(rogueCardSaveCardData3);
		}
		current_data.jokers.Clear();
		foreach (RogueCardJokerData orderedHandDatum2 in gameContext.jokerData.GetOrderedHandData())
		{
			RogueCardSaveJokerData rogueCardSaveJokerData = new RogueCardSaveJokerData
			{
				id = orderedHandDatum2.id,
				real_id = orderedHandDatum2.realID,
				version_id = orderedHandDatum2.versionID,
				add_point = orderedHandDatum2.addPoint,
				add_mutli = orderedHandDatum2.addMutli,
				mul_ratio = orderedHandDatum2.mulRatio,
				other_data = new List<int>()
			};
			int num4 = 0;
			for (int l = 0; l < orderedHandDatum2.effect.Count; l++)
			{
				rogueCardSaveJokerData.other_data.Add(orderedHandDatum2.effect[l].triggerCount);
				num4++;
				rogueCardSaveJokerData.other_data.Add(orderedHandDatum2.effect[l].lifeCount);
				num4++;
				int item = 0;
				if (orderedHandDatum2.effect[l].action is ChangeGlobalDataAction)
				{
					item = (orderedHandDatum2.effect[l].action as ChangeGlobalDataAction).changeNum;
				}
				rogueCardSaveJokerData.other_data.Add(item);
				num4++;
			}
			if (orderedHandDatum2.versionEffect != null)
			{
				rogueCardSaveJokerData.other_data.Add(orderedHandDatum2.versionEffect.triggerCount);
				rogueCardSaveJokerData.other_data.Add(orderedHandDatum2.versionEffect.lifeCount);
				int item2 = 0;
				if (orderedHandDatum2.versionEffect.action is ChangeGlobalDataAction)
				{
					item2 = (orderedHandDatum2.versionEffect.action as ChangeGlobalDataAction).changeNum;
				}
				rogueCardSaveJokerData.other_data.Add(item2);
			}
			if (orderedHandDatum2.copyEffect != null)
			{
				rogueCardSaveJokerData.other_data.Add(orderedHandDatum2.copyEffect.triggerCount);
				rogueCardSaveJokerData.other_data.Add(orderedHandDatum2.copyEffect.lifeCount);
				int item3 = 0;
				if (orderedHandDatum2.copyEffect.action is ChangeGlobalDataAction)
				{
					item3 = (orderedHandDatum2.copyEffect.action as ChangeGlobalDataAction).changeNum;
				}
				rogueCardSaveJokerData.other_data.Add(item3);
			}
			current_data.jokers.Add(rogueCardSaveJokerData);
		}
		current_data.play_num = gameContext.playNum;
		current_data.discard_num = gameContext.discardNum;
		current_data.score = gameContext.score;
		current_data.target_score = (int)((gameContext.targetScore >= int.MaxValue) ? int.MaxValue : gameContext.targetScore);
		current_data.boss_target_score = (int)((gameContext.bossTargetScore >= int.MaxValue) ? int.MaxValue : gameContext.bossTargetScore);
		current_data.round_play_num = gameContext.roundPlayNum;
		current_data.round_discard_num = gameContext.roundDiscardNum;
		current_data.shop_item_data_list.Clear();
		foreach (ShopItemData shopItemData in gameContext.shopData.shopItemDataList)
		{
			current_data.shop_item_data_list.Add(EncodeShopItemID(shopItemData.cfg.id, shopItemData.versionID));
		}
		current_data.shop_package_data_list.Clear();
		foreach (ShopPackageData shopPackageData in gameContext.shopData.shopPackageDataList)
		{
			current_data.shop_package_data_list.Add(shopPackageData.cfg.id);
		}
		current_data.cur_refresh_cost = gameContext.shopData.curRefreshCost;
		current_data.cur_package_id = gameContext.curPackageID;
		current_data.cur_package_wuchang = gameContext.curPackageWuChangID;
		current_data.last_package_num = gameContext.lastPackageNum;
		current_data.package_joker_id.Clear();
		for (int m = 0; m < gameContext.packageJoker.Count; m++)
		{
			int jokerID = gameContext.packageJoker[m];
			int versionID = ((m < gameContext.packageJokerVersion.Count) ? gameContext.packageJokerVersion[m] : 0);
			current_data.package_joker_id.Add(EncodePackageJokerID(jokerID, versionID));
		}
		current_data.package_wuchang_id.Clear();
		foreach (int item7 in gameContext.packageWuChang)
		{
			current_data.package_wuchang_id.Add(item7);
		}
		current_data.wu_chang_wait_cards.Clear();
		foreach (RogueCardData orderedHandDatum3 in gameContext.wuChangWaitCards.GetOrderedHandData())
		{
			RogueCardSaveCardData item4 = new RogueCardSaveCardData
			{
				suit = (int)orderedHandDatum3.suit,
				rank = (int)orderedHandDatum3.rank,
				enhance_id = orderedHandDatum3.enhanceID,
				tag_id = orderedHandDatum3.tagID,
				effect_disable = orderedHandDatum3.effectDisable,
				other_data = new List<int>()
			};
			current_data.wu_chang_wait_cards.Add(item4);
		}
		current_data.wu_chang_reset_num = gameContext.wuChangResetNum;
		current_data.white_wu_chang_id = gameContext.whiteWuChangID;
		current_data.black_wu_chang_id = gameContext.blackWuChangID;
		current_data.weal_woe_refresh_num = gameContext.wealWoeRefreshNum;
		current_data.weal_list.Clear();
		current_data.weal_list.AddRange(gameContext.wealList);
		current_data.woe_list.Clear();
		current_data.woe_list.AddRange(gameContext.woeList);
		current_data.cur_woe_id = gameContext.curWoeID;
		current_data.is_other_suit = gameContext.isOtherSuit;
		current_data.is_better_straight = gameContext.isBetterStraight;
		current_data.is_always_wu_chang = gameContext.isAlwaysWuChang;
		current_data.is_disable_type = gameContext.isDisableType;
		current_data.disable_type.Clear();
		foreach (HandType item8 in gameContext.disableType)
		{
			current_data.disable_type.Add((int)item8);
		}
		current_data.is_only_type = gameContext.isOnlyType;
		current_data.only_type = (int)((!gameContext.onlyType.HasValue) ? ((HandType)(-1)) : gameContext.onlyType.Value);
		current_data.hand_trigger = gameContext.handTrigger;
		current_data.ignore_woe = gameContext.ignoreWoe;
		current_data.ignore_spade = gameContext.ignoreSpade;
		current_data.is_odd_even = gameContext.isOddEven;
		current_data.odd_value = (int)gameContext.oddValue;
		current_data.even_value = (int)gameContext.evenValue;
		current_data.settle_data = new RogueCardSaveSettleData
		{
			most_hand_type = gameContext.settleContext.mostHandType,
			round = gameContext.settleContext.round,
			max_score = gameContext.settleContext.maxScore,
			use_card_num = gameContext.settleContext.useCardNum,
			discard_num = gameContext.settleContext.discardNum,
			black_wu_chang_num = gameContext.settleContext.blackWuChangNum,
			white_wu_chang_num = gameContext.settleContext.whiteWuChangNum,
			gain_gold_num = gameContext.settleContext.gainGoldNum,
			score = gameContext.settleContext.score,
			use_gold_num = gameContext.settleContext.useGoldNum,
			gain_joker_num = gameContext.settleContext.gainJokerNum,
			use_a_num = gameContext.settleContext.useANum,
			use_enhance_num = gameContext.settleContext.useEnhanceNum
		};
		current_data.settle_data.use_item_id = new List<int>();
		current_data.settle_data.use_item_id.AddRange(gameContext.settleContext.useItemID);
		current_data.settle_data.enhance_id = new List<int>();
		current_data.settle_data.enhance_id.AddRange(gameContext.settleContext.enhanceID);
		current_data.settle_data.weal_woe_id = new List<int>();
		current_data.settle_data.weal_woe_id.AddRange(gameContext.settleContext.wealWoeID);
		current_data.settle_data.hand_type_use_num = new List<int>();
		foreach (KeyValuePair<HandType, int> item9 in gameContext.settleContext.handTypeUseNum)
		{
			current_data.settle_data.hand_type_use_num.Add(item9.Value);
		}
		current_data.settle_data.hand_type_contain_num = new List<int>();
		foreach (int item10 in gameContext.settleContext.handTypeContainNum)
		{
			current_data.settle_data.hand_type_contain_num.Add(item10);
		}
		current_data.roll_back_num = gameContext.rollBackNum;
		if (current_data.other_data == null)
		{
			current_data.other_data = new List<int>();
		}
		while (current_data.other_data.Count <= 99)
		{
			current_data.other_data.Add(-1);
		}
		int value = -1;
		if (gameContext.handData != null && gameContext.handData.forceSelect != null)
		{
			List<RogueCardData> orderedHandData = gameContext.handData.GetOrderedHandData();
			for (int n = 0; n < orderedHandData.Count; n++)
			{
				if (orderedHandData[n] == gameContext.handData.forceSelect)
				{
					value = n;
					break;
				}
			}
		}
		current_data.other_data[0] = value;
		current_data.other_data[1] = ((RogueCardGameMain.Instance != null) ? RogueCardGameMain.Instance.GetStageUseTimeSeconds() : 0);
		current_data.other_data[2] = ((gameContext.stageType == LevelType.Challenge) ? gameContext.challengeStoryNormalImageIndex : (-1));
		WriteRuntimeEffectsToOtherData(current_data.other_data, 10, 29, RogueCardEffectManager.Instance.GetRegisteredEffects(EntityType.Deck));
		WriteRuntimeEffectsToOtherData(current_data.other_data, 30, 99, RogueCardEffectManager.Instance.GetRegisteredEffects(EntityType.Player));
		return true;
	}

	private void WriteRuntimeEffectsToOtherData(List<int> otherData, int startIndex, int endIndex, List<RogueCardGameEffect> effects)
	{
		for (int i = startIndex; i <= endIndex; i++)
		{
			otherData[i] = -1;
		}
		if (effects == null || effects.Count == 0)
		{
			return;
		}
		int num = (endIndex - startIndex + 1) / 2;
		int num2 = Math.Min(num, effects.Count);
		for (int j = 0; j < num2; j++)
		{
			int num3 = startIndex + j * 2;
			otherData[num3] = effects[j].effectID;
			int actionChangeNum = 0;
			if (effects[j].action is ChangeGlobalDataAction)
			{
				actionChangeNum = (effects[j].action as ChangeGlobalDataAction).changeNum;
			}
			otherData[num3 + 1] = EncodeRuntimeEffectCounts(effects[j].triggerCount, effects[j].lifeCount, actionChangeNum);
		}
		if (effects.Count > num)
		{
			Debug.LogWarning($"Runtime effect save slots not enough, truncated {effects.Count - num} effects. range={startIndex}-{endIndex}");
		}
	}

	public static int EncodeRuntimeEffectCounts(int triggerCount, int lifeCount, int actionChangeNum)
	{
		return (((actionChangeNum + 1024) & 0x7FF) << 20) | ((lifeCount & 0x3FF) << 10) | (triggerCount & 0x3FF);
	}

	public static (int, int, int) DecodeRuntimeEffectCounts(int packedValue)
	{
		int item = packedValue & 0x3FF;
		int item2 = (packedValue >> 10) & 0x3FF;
		int item3 = ((packedValue >> 20) & 0x7FF) - 1024;
		return (item, item2, item3);
	}

	public void Handle_PlayCard()
	{
		if (current_data == null)
		{
			InitializeDefaultData();
		}
	}

	public static void SendTrackingPoint1(RogueCardSaveData saveData, bool isFinish, int result, int nowScore, int targetScore)
	{
		int[] stageReward = RogueCardGameMain.GameContext.GetStageReward();
		int num = 0;
		if (stageReward.Length != 0)
		{
			num = stageReward[0];
		}
		LuaHelper.CallFunction("RogueCardGameBridge.SendSettleTrackingPoint", saveData, isFinish, result, nowScore, targetScore, num);
	}

	public static void SendTrackingPoint2(List<RogueCardData> cardList, RogueCardSaveData saveData, int nowScore, int targetScore, int opt, int getScore, int handType)
	{
		try
		{
			List<RogueCardSaveCardData> list = new List<RogueCardSaveCardData>();
			for (int i = 0; i < cardList.Count; i++)
			{
				RogueCardSaveCardData rogueCardSaveCardData = new RogueCardSaveCardData();
				rogueCardSaveCardData.rank = (int)cardList[i].rank;
				rogueCardSaveCardData.suit = (int)cardList[i].suit;
				rogueCardSaveCardData.enhance_id = cardList[i].enhanceID;
				rogueCardSaveCardData.tag_id = cardList[i].tagID;
				list.Add(rogueCardSaveCardData);
			}
			LuaHelper.CallFunction("RogueCardGameBridge.SendHandCardPlayPoint", list, saveData, nowScore, targetScore, opt, getScore, handType);
		}
		catch
		{
			Debug.LogError("RogueCard 处理打牌埋点时报错");
		}
	}

	public static void SendTrackingPoint3(RogueCardSaveData saveData, int vary, int opt, List<int> selectIndex, List<int> beforeList = null)
	{
		try
		{
			if (opt == 1 || opt == 2 || opt == 3)
			{
				trackingShopItem.Clear();
				trackingTypeItem.Clear();
				trackingCostItem.Clear();
				trackingVersionItem.Clear();
				trackingSelShopItem.Clear();
				trackingSelTypeItem.Clear();
				trackingSelCostItem.Clear();
				trackingSelVersionItem.Clear();
				RogueCardShopData shopData = RogueCardGameMain.GameContext.shopData;
				for (int i = 0; i < shopData.shopItemDataList.Count; i++)
				{
					trackingShopItem.Add(shopData.shopItemDataList[i].cfg.id);
					trackingTypeItem.Add(1);
					trackingCostItem.Add(shopData.shopItemDataList[i].cfg.price);
					trackingVersionItem.Add(shopData.shopItemDataList[i].versionID);
				}
				_ = trackingShopItem.Count;
				for (int j = 0; j < shopData.shopPackageDataList.Count; j++)
				{
					trackingShopItem.Add(shopData.shopPackageDataList[j].cfg.id);
					trackingTypeItem.Add(2);
					trackingCostItem.Add(shopData.shopPackageDataList[j].cfg.price);
					trackingVersionItem.Add(0);
				}
				switch (opt)
				{
				case 1:
				{
					ShopItemData shopItemData = shopData.shopItemDataList.Find((ShopItemData x) => x.index == selectIndex[0]);
					if (shopItemData != null)
					{
						trackingSelShopItem.Add(shopItemData.cfg.id);
						trackingSelTypeItem.Add(1);
						trackingSelCostItem.Add(shopItemData.cfg.price);
						trackingSelVersionItem.Add(shopItemData.versionID);
						break;
					}
					ShopPackageData shopPackageData = shopData.shopPackageDataList.Find((ShopPackageData x) => x.index == selectIndex[0]);
					trackingSelShopItem.Add(shopPackageData.cfg.id);
					trackingSelTypeItem.Add(2);
					trackingSelCostItem.Add(shopPackageData.cfg.price);
					trackingSelVersionItem.Add(0);
					break;
				}
				case 2:
				{
					RogueCardJokerData cardDataAtDisplayIndex = RogueCardGameMain.GameContext.jokerData.GetCardDataAtDisplayIndex(selectIndex[0]);
					trackingSelShopItem.Add(cardDataAtDisplayIndex.id);
					trackingSelTypeItem.Add(1);
					trackingSelCostItem.Add(cardDataAtDisplayIndex.GetPrice());
					trackingSelVersionItem.Add(cardDataAtDisplayIndex.versionID);
					break;
				}
				default:
				{
					for (int k = 3; k < beforeList.Count; k += 4)
					{
						trackingShopItem.Add(beforeList[k - 3]);
						trackingTypeItem.Add(beforeList[k - 2]);
						trackingCostItem.Add(beforeList[k - 1]);
						trackingVersionItem.Add(beforeList[k]);
					}
					for (int l = 3; l < selectIndex.Count; l += 4)
					{
						trackingSelShopItem.Add(selectIndex[l - 3]);
						trackingSelTypeItem.Add(selectIndex[l - 2]);
						trackingSelCostItem.Add(selectIndex[l - 1]);
						trackingSelVersionItem.Add(selectIndex[l]);
					}
					break;
				}
				}
			}
			else
			{
				trackingShopItem.Clear();
				trackingTypeItem.Clear();
				trackingCostItem.Clear();
				trackingVersionItem.Clear();
				trackingSelShopItem.Clear();
				trackingSelTypeItem.Clear();
				trackingSelCostItem.Clear();
				trackingSelVersionItem.Clear();
				for (int num = 0; num < RogueCardGameMain.GameContext.packageJoker.Count; num++)
				{
					trackingShopItem.Add(RogueCardGameMain.GameContext.packageJoker[num]);
					trackingTypeItem.Add(1);
					trackingCostItem.Add(0);
					trackingVersionItem.Add(RogueCardGameMain.GameContext.packageJokerVersion[num]);
				}
				int num2 = 0;
				if (selectIndex == null || selectIndex.Count == 0)
				{
					num2 = -1;
				}
				if (num2 != -1 && selectIndex[num2] != -1 && selectIndex[num2] < RogueCardGameMain.GameContext.packageJoker.Count)
				{
					trackingSelShopItem.Add(RogueCardGameMain.GameContext.packageJoker[selectIndex[num2]]);
					trackingSelTypeItem.Add(1);
					trackingSelCostItem.Add(0);
					trackingSelVersionItem.Add(RogueCardGameMain.GameContext.packageJoker[selectIndex[num2]]);
				}
			}
			LuaHelper.CallFunction("RogueCardGameBridge.SendShopTrackingPoint", saveData, opt, vary, trackingShopItem, trackingTypeItem, trackingCostItem, trackingVersionItem, trackingSelShopItem, trackingSelTypeItem, trackingSelCostItem, trackingSelVersionItem);
		}
		catch
		{
			Debug.LogError("RogueCard 处理商店埋点时报错");
		}
	}

	public static void SendTrackingPoint4(RogueCardSaveData saveData, int opt, List<RogueCardData> cardList, List<RogueCardData> selList, int wuchangID = 0, List<int> wuchangList = null)
	{
		try
		{
			List<RogueCardSaveCardData> list = new List<RogueCardSaveCardData>();
			for (int i = 0; i < cardList.Count; i++)
			{
				RogueCardSaveCardData rogueCardSaveCardData = new RogueCardSaveCardData();
				rogueCardSaveCardData.rank = (int)cardList[i].rank;
				rogueCardSaveCardData.suit = (int)cardList[i].suit;
				rogueCardSaveCardData.enhance_id = cardList[i].enhanceID;
				rogueCardSaveCardData.tag_id = cardList[i].tagID;
				list.Add(rogueCardSaveCardData);
			}
			List<RogueCardSaveCardData> list2 = new List<RogueCardSaveCardData>();
			for (int j = 0; j < selList.Count; j++)
			{
				RogueCardSaveCardData rogueCardSaveCardData2 = new RogueCardSaveCardData();
				rogueCardSaveCardData2.rank = (int)selList[j].rank;
				rogueCardSaveCardData2.suit = (int)selList[j].suit;
				rogueCardSaveCardData2.enhance_id = selList[j].enhanceID;
				rogueCardSaveCardData2.tag_id = selList[j].tagID;
				list2.Add(rogueCardSaveCardData2);
			}
			LuaHelper.CallFunction("RogueCardGameBridge.SendWuChangTrackingPoint", saveData, opt, list, list2, wuchangList, wuchangID);
		}
		catch
		{
			Debug.LogError("RogueCard 处理无常埋点时报错");
		}
	}
}
