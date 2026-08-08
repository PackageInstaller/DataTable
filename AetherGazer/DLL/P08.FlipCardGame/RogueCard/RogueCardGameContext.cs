using System;
using System.Collections.Generic;
using UnityEngine;

namespace RogueCard;

public class RogueCardGameContext
{
	public HashSet<RogueCardData> destroyedCardsCache = new HashSet<RogueCardData>();

	private readonly List<RogueCardData> _allCardsCache = new List<RogueCardData>();

	private readonly List<RogueCardData> _wuChangSelectCache = new List<RogueCardData>();

	private readonly List<RogueCardData> _wuChangUnSelectCache = new List<RogueCardData>();

	private readonly List<RogueCardData> _wuChangUnSelectAllCache = new List<RogueCardData>();

	private readonly List<RogueCardData> _selectDataCache = new List<RogueCardData>();

	private readonly List<RogueCardData> _unselectDataCache = new List<RogueCardData>();

	public List<int> _scoreList = new List<int>();

	public bool isRestoringSave;

	public bool isChallengeContinue;

	public bool restoreChallengeNormalStoryImage;

	private bool isInit;

	public int challengeDifficulty;

	public bool result = true;

	public bool resultContinue;

	public HashSet<int> recordItems;

	public HashSet<int> recordEnhance;

	public Dictionary<AttributeType, int> globalAttrDic;

	public int stageID;

	public LevelType stageType;

	public int allRoundNum;

	public int curRound;

	public StageType curStageState;

	public int challengeStoryNormalImageIndex = -1;

	public Dictionary<HandType, int> handTypeLevel;

	public int gold;

	public int stageUseTime;

	private int randomSeed;

	public RogueDeck rogueDeck;

	public HandData<RogueCardData> handData;

	public HandData<RogueCardJokerData> jokerData;

	private int _playNum;

	private int _discardNum;

	public int score;

	public long targetScore;

	public long bossTargetScore;

	public int roundPlayNum;

	public int roundDiscardNum;

	public bool pendingRestoreActionCounts;

	public int pendingRestorePlayNum;

	public int pendingRestoreDiscardNum;

	public int restoreForceSelectIndex = -1;

	public ScoreResult scoreResult;

	public RogueCardShopData shopData;

	public int curPackageID;

	public int curPackageWuChangID;

	public int lastPackageNum;

	public int selectJokerIndex = -1;

	public int packageJokerIndex = -1;

	public List<int> packageJoker = new List<int>();

	public List<int> packageJokerVersion = new List<int>();

	public HandData<RogueCardData> wuChangWaitCards;

	public int wuChangResetNum;

	public int whiteWuChangID = -1;

	public int blackWuChangID = -1;

	public int selectWuChangIndex = -1;

	public int wuChangSelectCardNum = 3;

	public List<int> packageWuChang = new List<int>();

	public int wealWoeRefreshNum;

	public List<int> wealList;

	public List<int> woeList;

	public int curWoeID;

	public RogueCardResultContext settleContext;

	public bool isOtherSuit;

	public bool isBetterStraight;

	public bool isAlwaysWuChang;

	public bool isDisableType;

	public HashSet<HandType> disableType = new HashSet<HandType>();

	public bool isOnlyType;

	public HandType? onlyType;

	public bool handTrigger;

	public bool ignoreWoe;

	public bool ignoreWoeStageLocked;

	public bool ignoreSpade;

	public bool isOddEven;

	public Rank oddValue;

	public Rank evenValue;

	public Rank randomRank;

	public Dictionary<int, int> jokerGold;

	public RogueCardData curEffectData;

	public List<RogueCardData> drawCardPool;

	public bool isTargetDraw;

	public int sortState = 1;

	public int rollBackNum = 2;

	public int RandomSeed => randomSeed;

	public int playNum
	{
		get
		{
			return _playNum;
		}
		set
		{
			if (_playNum != value)
			{
				RogueCardGameMain.Instance.lastPlayFlyText.text = (value - _playNum).ToString("+0;-0;0");
				RogueCardGameMain.Instance.lastPlayFlyText2.text = (value - _playNum).ToString("+0;-0;0");
				RogueCardGameMain.Instance.lastPlayAni.Play("UI_text", 0, 0f);
				RogueCardGameMain.Instance.playNumFly.SetActive(value: false);
				RogueCardGameMain.Instance.playNumFly.SetActive(value: true);
				_playNum = value;
				RogueCardGameMain.Instance.lastPlayNum.text = _playNum.ToString();
			}
		}
	}

	public int discardNum
	{
		get
		{
			return _discardNum;
		}
		set
		{
			if (_discardNum != value)
			{
				RogueCardGameMain.Instance.lastDiscardFlyText.text = (value - _discardNum).ToString("+0;-0;0");
				RogueCardGameMain.Instance.lastDiscardFlyText2.text = (value - _discardNum).ToString("+0;-0;0");
				RogueCardGameMain.Instance.lastDiscardAni.Play("UI_text", 0, 0f);
				RogueCardGameMain.Instance.discardNumFly.SetActive(value: false);
				RogueCardGameMain.Instance.discardNumFly.SetActive(value: true);
				_discardNum = value;
				RogueCardGameMain.Instance.lastDiscardNum.text = _discardNum.ToString();
			}
		}
	}

	public long GetTargetScore
	{
		get
		{
			if (curStageState == StageType.Boss)
			{
				return bossTargetScore;
			}
			return targetScore;
		}
	}

	public List<RogueCardData> GetAllCards
	{
		get
		{
			_allCardsCache.Clear();
			if (rogueDeck?.cards != null)
			{
				_allCardsCache.AddRange(rogueDeck.cards);
			}
			if (rogueDeck?.discardPile != null)
			{
				_allCardsCache.AddRange(rogueDeck.discardPile);
			}
			if (handData?.handCards != null)
			{
				_allCardsCache.AddRange(handData.handCards);
			}
			if (wuChangWaitCards?.handCards != null)
			{
				_allCardsCache.AddRange(wuChangWaitCards.handCards);
			}
			List<RogueCardData> list = new List<RogueCardData>();
			list.AddRange(_allCardsCache);
			return list;
		}
	}

	public List<RogueCardData> GetWuChangSelect
	{
		get
		{
			_wuChangSelectCache.Clear();
			int[] selectIndexList = wuChangWaitCards.GetSelectIndexList();
			for (int i = 0; i < selectIndexList.Length; i++)
			{
				_wuChangSelectCache.Add(wuChangWaitCards.GetCardDataAtDisplayIndex(selectIndexList[i]));
			}
			List<RogueCardData> list = new List<RogueCardData>();
			list.AddRange(_wuChangSelectCache);
			return list;
		}
	}

	public List<RogueCardData> GetWuChangUnSelect
	{
		get
		{
			_wuChangUnSelectCache.Clear();
			if (wuChangWaitCards?.handCards != null)
			{
				_wuChangUnSelectCache.AddRange(wuChangWaitCards.handCards);
			}
			int[] selectIndexList = wuChangWaitCards.GetSelectIndexList();
			for (int i = 0; i < selectIndexList.Length; i++)
			{
				_wuChangUnSelectCache.Remove(wuChangWaitCards.GetCardDataAtDisplayIndex(selectIndexList[i]));
			}
			List<RogueCardData> list = new List<RogueCardData>();
			list.AddRange(_wuChangUnSelectCache);
			return list;
		}
	}

	public List<RogueCardData> GetWuChangUnSelectAll
	{
		get
		{
			_wuChangUnSelectAllCache.Clear();
			if (rogueDeck?.cards != null)
			{
				_wuChangUnSelectAllCache.AddRange(rogueDeck.cards);
			}
			int[] selectIndexList = wuChangWaitCards.GetSelectIndexList();
			for (int i = 0; i < selectIndexList.Length; i++)
			{
				_wuChangUnSelectAllCache.Remove(wuChangWaitCards.GetCardDataAtDisplayIndex(selectIndexList[i]));
			}
			List<RogueCardData> list = new List<RogueCardData>();
			list.AddRange(_wuChangUnSelectAllCache);
			return list;
		}
	}

	public int GetCurWealWoeNum
	{
		get
		{
			int num = 0;
			if (curStageState == StageType.Boss)
			{
				IState curState = RogueCardGameMain.Instance.CurState;
				if (curState != null && curState.GetIndex() > 7)
				{
					num = curRound;
					goto IL_0038;
				}
			}
			num = curRound - 1;
			goto IL_0038;
			IL_0038:
			int num2 = num;
			for (int i = 0; i < num2; i++)
			{
				if (wealList[i] == 199)
				{
					num--;
				}
			}
			return Math.Max(0, num);
		}
	}

	public int GetShowWealWoeNum
	{
		get
		{
			int num = 0;
			if (curStageState == StageType.Boss)
			{
				IState curState = RogueCardGameMain.Instance.CurState;
				if (curState != null && curState.GetIndex() >= 3)
				{
					num = curRound;
					goto IL_003b;
				}
			}
			num = curRound - 1;
			goto IL_003b;
			IL_003b:
			for (int i = 0; i < num; i++)
			{
				if (wealList[i] == 199)
				{
					num--;
				}
			}
			return num;
		}
	}

	public int GetSettleRound()
	{
		int num = (RogueCardGameMain.Instance?.CurState?.GetIndex()).GetValueOrDefault();
		if (num == 11)
		{
			num = RogueCardGameMain.Instance?.LastState?.GetIndex() ?? num;
		}
		bool flag = num >= 7 && result;
		if (stageType == LevelType.Boss)
		{
			int num2 = curRound;
			if (!flag)
			{
				num2--;
			}
			return num2;
		}
		int num3 = curRound * 2;
		if (curStageState == StageType.Normal)
		{
			num3 = (flag ? (num3 - 1) : (num3 - 2));
		}
		else if (curStageState == StageType.Boss && !flag)
		{
			num3--;
		}
		if (num3 == 11 && RogueCardGameMain.Instance?.CurState?.GetIndex() == 11 && result)
		{
			num3 = 12;
		}
		return num3;
	}

	public void SetPlayNum(int value)
	{
		_playNum = value;
		RogueCardGameMain.Instance.lastPlayNum.text = _playNum.ToString();
	}

	public void SetDiscardNum(int value)
	{
		_discardNum = value;
		RogueCardGameMain.Instance.lastDiscardNum.text = _discardNum.ToString();
	}

	public RogueCardGameContext(int randomSeed)
	{
		this.randomSeed = randomSeed;
		settleContext = new RogueCardResultContext();
		sortState = 1;
	}

	public RogueCardGameContext(RogueCardSaveData saveData)
	{
		randomSeed = saveData.random_seed;
		settleContext = new RogueCardResultContext();
		sortState = 1;
	}

	public void OnDispose()
	{
	}

	public void InitStage(int stageID, RogueCardSaveData saveData, bool isRollback = false)
	{
		result = true;
		recordItems = new HashSet<int>();
		recordEnhance = new HashSet<int>();
		foreach (int record_item in saveData.record_items)
		{
			(int, int) tuple = RogueCardSaveSystem.DecodeRecordItemID(record_item);
			if (tuple.Item1 == 1)
			{
				recordItems.Add(tuple.Item2);
			}
			else
			{
				recordEnhance.Add(tuple.Item2);
			}
		}
		if (saveData.settle_data != null)
		{
			settleContext.mostHandType = saveData.settle_data.most_hand_type;
			settleContext.round = saveData.settle_data.round;
			settleContext.maxScore = saveData.settle_data.max_score;
			settleContext.useCardNum = saveData.settle_data.use_card_num;
			settleContext.discardNum = saveData.settle_data.discard_num;
			settleContext.blackWuChangNum = saveData.settle_data.black_wu_chang_num;
			settleContext.whiteWuChangNum = saveData.settle_data.white_wu_chang_num;
			settleContext.gainGoldNum = saveData.settle_data.gain_gold_num;
			settleContext.score = saveData.settle_data.score;
			settleContext.useGoldNum = saveData.settle_data.use_gold_num;
			settleContext.gainJokerNum = saveData.settle_data.gain_joker_num;
			settleContext.useANum = saveData.settle_data.use_a_num;
			settleContext.useEnhanceNum = saveData.settle_data.use_enhance_num;
			settleContext.useItemID.AddRange(saveData.settle_data.use_item_id);
			settleContext.enhanceID.AddRange(saveData.settle_data.enhance_id);
			settleContext.wealWoeID.AddRange(saveData.settle_data.weal_woe_id);
			settleContext.handTypeContainNum.Clear();
			settleContext.handTypeContainNum.AddRange(saveData.settle_data.hand_type_contain_num);
			int num = 0;
			foreach (HandType item5 in new List<HandType>(settleContext.handTypeUseNum.Keys))
			{
				if (num < saveData.settle_data.hand_type_use_num.Count)
				{
					settleContext.handTypeUseNum[item5] = saveData.settle_data.hand_type_use_num[num];
				}
				num++;
			}
		}
		globalAttrDic = new Dictionary<AttributeType, int>();
		for (int i = 0; i < saveData.global_attr_dic.Count; i++)
		{
			globalAttrDic.Add((AttributeType)(i + 1), saveData.global_attr_dic[i]);
		}
		jokerGold = new Dictionary<int, int>();
		this.stageID = saveData.stage_id;
		challengeDifficulty = saveData.difficulty;
		RogueCardStageCfg rogueCardStageCfg = RogueCardDataManager.stageDatabase[this.stageID];
		stageType = rogueCardStageCfg.type;
		curRound = saveData.cur_round;
		curStageState = (StageType)saveData.cur_stage_state;
		restoreChallengeNormalStoryImage = stageType == LevelType.Challenge && saveData.cur_state == 5 && curStageState == StageType.Boss;
		handTypeLevel = new Dictionary<HandType, int>();
		for (int j = 0; j < saveData.hand_type_level.Count; j++)
		{
			handTypeLevel.Add((HandType)(j + 1), saveData.hand_type_level[j]);
		}
		gold = saveData.gold;
		stageUseTime = 0;
		wuChangWaitCards = new HandData<RogueCardData>();
		SetPlayNum(saveData.play_num);
		SetDiscardNum(saveData.discard_num);
		score = saveData.score;
		targetScore = saveData.target_score;
		bossTargetScore = saveData.boss_target_score;
		roundPlayNum = saveData.round_play_num;
		roundDiscardNum = saveData.round_discard_num;
		rollBackNum = saveData.roll_back_num;
		wuChangResetNum = saveData.wu_chang_reset_num;
		whiteWuChangID = saveData.white_wu_chang_id;
		blackWuChangID = saveData.black_wu_chang_id;
		wealWoeRefreshNum = saveData.weal_woe_refresh_num;
		wealList = new List<int>();
		woeList = new List<int>();
		for (int k = 0; k < saveData.weal_list.Count; k++)
		{
			wealList.Add(saveData.weal_list[k]);
		}
		for (int l = 0; l < saveData.woe_list.Count; l++)
		{
			woeList.Add(saveData.woe_list[l]);
		}
		curWoeID = saveData.cur_woe_id;
		isOtherSuit = saveData.is_other_suit;
		isBetterStraight = saveData.is_better_straight;
		isAlwaysWuChang = saveData.is_always_wu_chang;
		isDisableType = saveData.is_disable_type;
		disableType = new HashSet<HandType>();
		for (int m = 0; m < saveData.disable_type.Count; m++)
		{
			disableType.Add((HandType)saveData.disable_type[m]);
		}
		isOnlyType = saveData.is_only_type;
		onlyType = ((saveData.only_type == -1) ? ((HandType?)null) : new HandType?((HandType)saveData.only_type));
		handTrigger = saveData.hand_trigger;
		ignoreWoe = saveData.ignore_woe;
		ignoreSpade = saveData.ignore_spade;
		isOddEven = saveData.is_odd_even;
		oddValue = (Rank)saveData.odd_value;
		evenValue = (Rank)saveData.even_value;
		scoreResult = new ScoreResult();
		drawCardPool = new List<RogueCardData>();
		isInit = true;
		allRoundNum = rogueCardStageCfg.round;
		rogueDeck = new RogueDeck(saveData.deck_id);
		rogueDeck.discardPile = new List<RogueCardData>();
		for (int n = 0; n < saveData.deck_cards.Count; n++)
		{
			RogueCardData item = new RogueCardData(saveData.deck_cards[n]);
			rogueDeck.cards.Add(item);
		}
		for (int num2 = 0; num2 < saveData.pile_cards.Count; num2++)
		{
			RogueCardData item2 = new RogueCardData(saveData.pile_cards[num2]);
			rogueDeck.discardPile.Add(item2);
		}
		handData = new HandData<RogueCardData>();
		for (int num3 = 0; num3 < saveData.hand_cards.Count; num3++)
		{
			RogueCardData cardData = new RogueCardData(saveData.hand_cards[num3]);
			handData.AddCardToHand(cardData);
		}
		if (saveData.other_data != null && saveData.other_data.Count > 0)
		{
			restoreForceSelectIndex = saveData.other_data[0];
		}
		else
		{
			restoreForceSelectIndex = -1;
		}
		if (saveData.other_data != null && saveData.other_data.Count > 1)
		{
			stageUseTime = Mathf.Max(0, saveData.other_data[1]);
		}
		else
		{
			stageUseTime = 0;
		}
		if (saveData.other_data != null && saveData.other_data.Count > 2)
		{
			challengeStoryNormalImageIndex = saveData.other_data[2];
		}
		else
		{
			challengeStoryNormalImageIndex = -1;
		}
		_scoreList.Clear();
		_scoreList.AddRange(rogueCardStageCfg.score_list);
		jokerData = new HandData<RogueCardJokerData>();
		for (int num4 = 0; num4 < saveData.jokers.Count; num4++)
		{
			RogueCardJokerData cardData2 = RogueCardJokerData.CreateJokerCard(saveData.jokers[num4]);
			jokerData.AddCardToHand(cardData2);
		}
		RestoreRuntimeEffects(saveData, isRollback);
		if (saveData.cur_state == 4)
		{
			RefreshWuChangData();
			for (int num5 = 0; num5 < saveData.wu_chang_wait_cards.Count; num5++)
			{
				RogueCardData cardData3 = new RogueCardData(saveData.wu_chang_wait_cards[num5]);
				wuChangWaitCards.AddCardToHand(cardData3);
				SortCard(wuChangWaitCards, sortState);
			}
			wuChangResetNum = saveData.wu_chang_reset_num;
			whiteWuChangID = saveData.white_wu_chang_id;
			blackWuChangID = saveData.black_wu_chang_id;
		}
		if (saveData.cur_state == 3)
		{
			curPackageID = saveData.cur_package_id;
			curPackageWuChangID = saveData.cur_package_wuchang;
			lastPackageNum = saveData.last_package_num;
			packageJoker = new List<int>();
			packageJokerVersion = new List<int>();
			for (int num6 = 0; num6 < saveData.package_joker_id.Count; num6++)
			{
				(int, int) tuple2 = RogueCardSaveSystem.DecodePackageJokerID(saveData.package_joker_id[num6]);
				packageJoker.Add(tuple2.Item1);
				packageJokerVersion.Add(tuple2.Item2);
			}
			packageWuChang = new List<int>();
			packageWuChang.AddRange(saveData.package_wuchang_id);
			wuChangWaitCards = new HandData<RogueCardData>();
			for (int num7 = 0; num7 < saveData.wu_chang_wait_cards.Count; num7++)
			{
				RogueCardData cardData4 = new RogueCardData(saveData.wu_chang_wait_cards[num7]);
				wuChangWaitCards.AddCardToHand(cardData4);
				SortCard(wuChangWaitCards, sortState);
			}
		}
		int num8 = 0;
		shopData = new RogueCardShopData();
		for (int num9 = 0; num9 < saveData.shop_item_data_list.Count; num9++)
		{
			(int, int) itemData = RogueCardSaveSystem.DecodeShopItemID(saveData.shop_item_data_list[num9]);
			RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg rogueCardItemCfg2) => rogueCardItemCfg2.id == itemData.Item1);
			ShopItemData item3 = new ShopItemData
			{
				cfg = rogueCardItemCfg,
				type = rogueCardItemCfg.type,
				isSaled = false,
				index = num8,
				versionID = itemData.Item2
			};
			num8++;
			shopData.shopItemDataList.Add(item3);
		}
		num8 = 100;
		for (int num10 = 0; num10 < saveData.shop_package_data_list.Count; num10++)
		{
			RogueCardPackageCfg cfg = RogueCardDataManager.packageDatabase[saveData.shop_package_data_list[num10]];
			ShopPackageData item4 = new ShopPackageData
			{
				cfg = cfg,
				isSaled = false,
				index = num8
			};
			num8++;
			shopData.shopPackageDataList.Add(item4);
		}
		shopData.curRefreshCost = saveData.cur_refresh_cost;
		randomRank = (Rank)RogueCardGameMain.Random.Range(2, 12);
	}

	public void InitStage(int stageID, int deckID, int difficulty)
	{
		result = true;
		recordItems = new HashSet<int>();
		recordEnhance = new HashSet<int>();
		for (int i = 0; i < RogueCardDataManager.recordItemData.Count; i++)
		{
			recordItems.Add(RogueCardDataManager.recordItemData[i]);
		}
		for (int j = 0; j < RogueCardDataManager.recordEnhanceData.Count; j++)
		{
			recordEnhance.Add(RogueCardDataManager.recordEnhanceData[j]);
		}
		globalAttrDic = new Dictionary<AttributeType, int>();
		jokerGold = new Dictionary<int, int>();
		foreach (KeyValuePair<AttributeType, RogueAttributeCfg> item in RogueCardDataManager.attributeDatabase)
		{
			globalAttrDic.Add(item.Key, item.Value.defaultValue);
		}
		isOtherSuit = false;
		isBetterStraight = false;
		isAlwaysWuChang = false;
		this.stageID = stageID;
		RogueCardStageCfg rogueCardStageCfg = RogueCardDataManager.stageDatabase[stageID];
		stageType = rogueCardStageCfg.type;
		gold = globalAttrDic[AttributeType.InitGold];
		stageUseTime = 0;
		scoreResult = new ScoreResult();
		shopData = new RogueCardShopData();
		rogueDeck = RogueDeck.CreateDefaultDeck(deckID);
		rogueDeck.ShuffleCard(RogueCardGameMain.Instance.randomSystem);
		handData = new HandData<RogueCardData>();
		jokerData = new HandData<RogueCardJokerData>();
		wuChangWaitCards = new HandData<RogueCardData>();
		drawCardPool = new List<RogueCardData>();
		wealList = new List<int>();
		woeList = new List<int>();
		score = 0;
		SetPlayNum(globalAttrDic[AttributeType.PlayCardNum]);
		SetDiscardNum(globalAttrDic[AttributeType.DiscardNum]);
		isInit = false;
		if (stageType == LevelType.Boss)
		{
			curStageState = StageType.Boss;
		}
		else
		{
			curStageState = StageType.Normal;
		}
		curRound = 1;
		restoreChallengeNormalStoryImage = false;
		challengeStoryNormalImageIndex = -1;
		_scoreList.Clear();
		_scoreList.AddRange(rogueCardStageCfg.score_list);
		SetTargetScore();
		allRoundNum = rogueCardStageCfg.round;
		handTypeLevel = new Dictionary<HandType, int>
		{
			[HandType.StraightFlush] = 1,
			[HandType.Bomb] = 1,
			[HandType.Flush] = 1,
			[HandType.Straight] = 1,
			[HandType.Pair] = 1,
			[HandType.HighCard] = 1
		};
		disableType = new HashSet<HandType>();
		onlyType = null;
		if (stageType == LevelType.Challenge)
		{
			for (int k = 1; k <= difficulty; k++)
			{
				int[] effect_list = RogueCardDataManager.difficultyDatabase[k].effect_list;
				foreach (int effectID in effect_list)
				{
					RogueCardEffectManager.Instance.RegistEffect(effectID, EntityType.Deck);
				}
			}
			challengeDifficulty = difficulty;
		}
		if (RogueCardGameMain.Instance.guideSystem.CheckGuide(RogueCardGuideMoment.beginning))
		{
			foreach (RogueCardGuideItem guideItem in RogueCardGameMain.Instance.guideSystem.GetGuideItems(RogueCardGuideMoment.beginning))
			{
				RogueCardJokerData rogueCardJokerData = RogueCardJokerData.CreateJokerCard(guideItem.id, guideItem.versionID);
				RogueCardGameMain.Instance.RecordItem(1, rogueCardJokerData.id);
				jokerData.AddCardToHand(rogueCardJokerData);
			}
		}
		rollBackNum = RogueCardGameMain.Instance.rollBackMaxNum;
		randomRank = (Rank)RogueCardGameMain.Random.Range(2, 12);
	}

	public void SetTargetScore()
	{
		_ = RogueCardDataManager.stageDatabase[stageID];
		RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = null;
		int count = _scoreList.Count;
		if (curRound - 1 < count)
		{
			targetScore = _scoreList[curRound - 1];
		}
		else
		{
			int num = curRound - count + 1;
			int num2 = num * (num - 1) / 2;
			long num3 = _scoreList[count - 1];
			for (int i = 0; i < num2; i++)
			{
				num3 = (long)((double)num3 * (double)RogueCardGameMain.Instance.challenge_target_score_ratio);
				if (num3 >= int.MaxValue)
				{
					num3 = 2147483647L;
					break;
				}
			}
			targetScore = (int)num3;
		}
		bossTargetScore = targetScore;
		if (woeList == null || woeList.Count <= 0)
		{
			return;
		}
		Dictionary<int, RogueCardWealAndWoeCfg> wealAndWoeDatabase = RogueCardDataManager.wealAndWoeDatabase;
		List<int> list = woeList;
		rogueCardWealAndWoeCfg = wealAndWoeDatabase[list[list.Count - 1]];
		double num4 = rogueCardWealAndWoeCfg.coefficient;
		if (!ignoreWoe && rogueCardWealAndWoeCfg.effect_list != null && rogueCardWealAndWoeCfg.effect_list.Length != 0)
		{
			int num5 = rogueCardWealAndWoeCfg.effect_list[0];
			if (num5 == 702)
			{
				RogueCardEffectCfg rogueCardEffectCfg = RogueCardDataManager.effectDatabase[num5];
				if (rogueCardEffectCfg == null)
				{
					return;
				}
				num4 += (double)rogueCardEffectCfg.param2[0];
			}
		}
		double num6 = (double)targetScore * (num4 / 100.0);
		if (num6 >= 2147483647.0)
		{
			bossTargetScore = 2147483647L;
		}
		else
		{
			bossTargetScore = (long)Math.Round(num6);
		}
	}

	public void FinishStage()
	{
		int[] stageReward = GetStageReward();
		gold += stageReward[0];
		settleContext.gainGoldNum += stageReward[0];
	}

	public void GetJokerGold(int effectID, int goldNum)
	{
		if (jokerGold == null)
		{
			jokerGold = new Dictionary<int, int>();
		}
		if (jokerGold.ContainsKey(effectID))
		{
			jokerGold[effectID] += goldNum;
		}
		else
		{
			jokerGold.Add(effectID, goldNum);
		}
	}

	public int[] GetStageReward()
	{
		int[] array = new int[4];
		array[1] = ((curStageState == StageType.Normal) ? RogueCardGameMain.GameContext.globalAttrDic[AttributeType.NormalStageReward] : RogueCardGameMain.GameContext.globalAttrDic[AttributeType.BossStageReward]);
		array[2] = playNum;
		array[0] = array[1] + array[2];
		foreach (KeyValuePair<int, int> item in jokerGold)
		{
			array[0] += item.Value;
		}
		return array;
	}

	public void ClearStageData()
	{
		if (curStageState == StageType.Boss)
		{
			Dictionary<int, RogueCardWealAndWoeCfg> wealAndWoeDatabase = RogueCardDataManager.wealAndWoeDatabase;
			List<int> list = woeList;
			if (wealAndWoeDatabase[list[list.Count - 1]].effect_list.Length != 0)
			{
				RogueCardEffectManager.Instance.UnRegistEffect(curWoeID, EntityType.Player);
			}
			curWoeID = 0;
			Dictionary<int, RogueCardWealAndWoeCfg> wealAndWoeDatabase2 = RogueCardDataManager.wealAndWoeDatabase;
			List<int> list2 = wealList;
			RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = wealAndWoeDatabase2[list2[list2.Count - 1]];
			if (rogueCardWealAndWoeCfg.effect_list.Length != 0)
			{
				int effectID = rogueCardWealAndWoeCfg.effect_list[0];
				RogueCardEffectManager.Instance.RegistEffect(effectID, EntityType.Player);
			}
		}
		roundPlayNum = 0;
		roundDiscardNum = 0;
		jokerGold.Clear();
		pendingRestoreActionCounts = true;
		pendingRestorePlayNum = globalAttrDic[AttributeType.PlayCardNum];
		pendingRestoreDiscardNum = globalAttrDic[AttributeType.DiscardNum];
		handData.DeSelect();
		disableType.Clear();
		List<RogueCardData> getAllCards = GetAllCards;
		for (int i = 0; i < getAllCards.Count; i++)
		{
			getAllCards[i].effectDisable = false;
		}
		onlyType = null;
	}

	public void ApplyPendingActionCountsIfNeeded()
	{
		if (pendingRestoreActionCounts)
		{
			SetPlayNum(pendingRestorePlayNum);
			SetDiscardNum(pendingRestoreDiscardNum);
			pendingRestoreActionCounts = false;
		}
	}

	public void ResetDeck()
	{
		DisCardAll();
		rogueDeck.MakeDeck();
	}

	public void NewStageData()
	{
		if (isInit)
		{
			if (stageType == LevelType.Boss)
			{
				curStageState = StageType.Boss;
				curRound++;
			}
			else if (curStageState == StageType.Normal)
			{
				curStageState = StageType.Boss;
			}
			else
			{
				curStageState = StageType.Normal;
				curRound++;
			}
		}
	}

	public void RefreshStageData()
	{
		score = 0;
		_ = RogueCardDataManager.stageDatabase[stageID];
		Dictionary<int, RogueCardWealAndWoeCfg> wealAndWoeDatabase = RogueCardDataManager.wealAndWoeDatabase;
		List<int> list = woeList;
		_ = wealAndWoeDatabase[list[list.Count - 1]];
		SetTargetScore();
		scoreResult = new ScoreResult();
		isInit = true;
		rogueDeck.ShuffleCard(RogueCardGameMain.Instance.randomSystem);
	}

	public void RefreshWoeEffect()
	{
		if (RogueCardGameMain.Instance.CurState is StageState && RogueCardGameMain.Instance.CurState.GetIndex() != 3)
		{
			return;
		}
		Dictionary<int, RogueCardWealAndWoeCfg> wealAndWoeDatabase = RogueCardDataManager.wealAndWoeDatabase;
		List<int> list = woeList;
		RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = wealAndWoeDatabase[list[list.Count - 1]];
		if (rogueCardWealAndWoeCfg.effect_list.Length == 0)
		{
			return;
		}
		int num = rogueCardWealAndWoeCfg.effect_list[0];
		if (ignoreWoe || curStageState != StageType.Boss)
		{
			if (num != 0)
			{
				RogueCardEffectManager.Instance.UnRegistEffect(num, EntityType.Player);
				num = 0;
			}
			SetTargetScore();
		}
		else if (curStageState == StageType.Boss)
		{
			curWoeID = num;
			_ = RogueCardDataManager.effectDatabase[num];
			RogueCardEffectManager.Instance.RegistEffect(num, EntityType.Player);
			SetTargetScore();
		}
	}

	public void EnterStage()
	{
		if (!isRestoringSave)
		{
			RefreshWoeEffect();
			SetPlayNum(globalAttrDic[AttributeType.PlayCardNum]);
			SetDiscardNum(globalAttrDic[AttributeType.DiscardNum]);
			wealWoeRefreshNum = globalAttrDic[AttributeType.WealWoeResetNum];
		}
		SetTargetScore();
	}

	private void RestoreRuntimeEffects(RogueCardSaveData saveData, bool isRollback)
	{
		if (!RestoreRuntimeEffectList(saveData.other_data, 10, 29, EntityType.Deck, !isRollback))
		{
			RestoreLegacyDeckEffects(isRollback);
		}
		if (!RestoreRuntimeEffectList(saveData.other_data, 30, 99, EntityType.Player, !isRollback))
		{
			RestoreLegacyPlayerEffects(isRollback);
		}
	}

	private bool RestoreRuntimeEffectList(List<int> otherData, int startIndex, int endIndex, EntityType entityType, bool executeOnAcquire = true)
	{
		if (otherData == null || otherData.Count <= startIndex)
		{
			return false;
		}
		bool flag = false;
		for (int i = startIndex; i + 1 <= endIndex && i + 1 < otherData.Count; i += 2)
		{
			int num = otherData[i];
			int num2 = otherData[i + 1];
			if (num < 0 || num2 < 0)
			{
				continue;
			}
			RogueCardGameEffect rogueCardGameEffect = RogueCardEffectManager.Instance.RegistEffect(num, entityType, executeOnAcquire);
			if (rogueCardGameEffect != null)
			{
				(int, int, int) tuple = RogueCardSaveSystem.DecodeRuntimeEffectCounts(num2);
				(rogueCardGameEffect.triggerCount, rogueCardGameEffect.lifeCount, _) = tuple;
				if (rogueCardGameEffect.action is ChangeGlobalDataAction)
				{
					(rogueCardGameEffect.action as ChangeGlobalDataAction).changeNum = tuple.Item3;
				}
				flag = true;
			}
		}
		return flag;
	}

	private void RestoreLegacyDeckEffects(bool executeOnAcquire = true)
	{
		if (RogueCardDataManager.deckDatabase.TryGetValue(rogueDeck.deckID, out var value) && value.effect_list != null)
		{
			int[] effect_list = value.effect_list;
			foreach (int effectID in effect_list)
			{
				RogueCardEffectManager.Instance.RegistEffect(effectID, EntityType.Deck, executeOnAcquire);
			}
		}
		if (stageType != LevelType.Challenge)
		{
			return;
		}
		for (int j = 1; j <= challengeDifficulty; j++)
		{
			int[] effect_list = RogueCardDataManager.difficultyDatabase[j].effect_list;
			foreach (int effectID2 in effect_list)
			{
				RogueCardEffectManager.Instance.RegistEffect(effectID2, EntityType.Deck);
			}
		}
	}

	private void RestoreLegacyPlayerEffects(bool executeOnAcquire = true)
	{
		if (wealList != null)
		{
			for (int i = 0; i < wealList.Count; i++)
			{
				RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = RogueCardDataManager.wealAndWoeDatabase[wealList[i]];
				if (rogueCardWealAndWoeCfg.effect_list != null && rogueCardWealAndWoeCfg.effect_list.Length != 0)
				{
					RogueCardEffectManager.Instance.RegistEffect(rogueCardWealAndWoeCfg.effect_list[0], EntityType.Player, executeOnAcquire);
				}
			}
		}
		if (curStageState == StageType.Boss)
		{
			RefreshWoeEffect();
		}
	}

	public void SelectWuChangCard(int num)
	{
		if (isRestoringSave)
		{
			return;
		}
		foreach (RogueCardData orderedHandDatum in wuChangWaitCards.GetOrderedHandData())
		{
			rogueDeck.AddCard(orderedHandDatum);
		}
		wuChangWaitCards.ClearCard();
		foreach (RogueCardData item in rogueDeck.GetCard(num))
		{
			wuChangWaitCards.AddCardToHand(item);
		}
		SortCard(wuChangWaitCards, sortState);
	}

	public void DrawCard()
	{
		if (roundPlayNum == 0 && roundDiscardNum == 0 && RogueCardGameMain.Instance.guideSystem.CheckGuide(RogueCardGuideMoment.battle, ignoreGuideState: true))
		{
			List<RogueCardGuideCard> guideRogueCards = RogueCardGameMain.Instance.guideSystem.GetGuideRogueCards(RogueCardGuideMoment.battle);
			drawCardPool.Clear();
			{
				foreach (RogueCardGuideCard item in guideRogueCards)
				{
					if (handData.HandCount >= globalAttrDic[AttributeType.HandMaxNum])
					{
						break;
					}
					RogueCardData rogueCardData = rogueDeck.DrawCard((Rank)item.rank, (Suit)item.suit);
					if (rogueCardData == null)
					{
						break;
					}
					handData.AddCardToHand(rogueCardData);
					drawCardPool.Add(rogueCardData);
					RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnDrawInBattle);
					RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnAfterDraw);
				}
				return;
			}
		}
		if (roundDiscardNum == 1 && RogueCardGameMain.Instance.guideSystem.CheckGuide(RogueCardGuideMoment.discarded, ignoreGuideState: true))
		{
			List<RogueCardGuideCard> guideRogueCards2 = RogueCardGameMain.Instance.guideSystem.GetGuideRogueCards(RogueCardGuideMoment.discarded);
			drawCardPool.Clear();
			{
				foreach (RogueCardGuideCard item2 in guideRogueCards2)
				{
					if (handData.HandCount >= globalAttrDic[AttributeType.HandMaxNum])
					{
						break;
					}
					RogueCardData rogueCardData2 = rogueDeck.DrawCard((Rank)item2.rank, (Suit)item2.suit);
					if (rogueCardData2 == null)
					{
						break;
					}
					handData.AddCardToHand(rogueCardData2);
					drawCardPool.Add(rogueCardData2);
					RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnDrawInBattle);
					RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnAfterDraw);
				}
				return;
			}
		}
		if (roundPlayNum == 1 && RogueCardGameMain.Instance.guideSystem.CheckGuide(RogueCardGuideMoment.play, ignoreGuideState: true))
		{
			List<RogueCardGuideCard> guideRogueCards3 = RogueCardGameMain.Instance.guideSystem.GetGuideRogueCards(RogueCardGuideMoment.play);
			drawCardPool.Clear();
			{
				foreach (RogueCardGuideCard item3 in guideRogueCards3)
				{
					if (handData.HandCount >= globalAttrDic[AttributeType.HandMaxNum])
					{
						break;
					}
					RogueCardData rogueCardData3 = rogueDeck.DrawCard((Rank)item3.rank, (Suit)item3.suit);
					if (rogueCardData3 == null)
					{
						break;
					}
					handData.AddCardToHand(rogueCardData3);
					drawCardPool.Add(rogueCardData3);
					RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnDrawInBattle);
					RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnAfterDraw);
				}
				return;
			}
		}
		drawCardPool.Clear();
		while (handData.HandCount < globalAttrDic[AttributeType.HandMaxNum])
		{
			RogueCardData rogueCardData4 = rogueDeck.DrawCard();
			if (rogueCardData4 == null)
			{
				return;
			}
			handData.AddCardToHand(rogueCardData4);
			drawCardPool.Add(rogueCardData4);
			RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnDrawInBattle);
		}
		RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnAfterDraw);
		SortCard(handData, sortState);
	}

	public void DrawCard(int num, Rank rank)
	{
		drawCardPool.Clear();
		isTargetDraw = true;
		while (num > 0)
		{
			RogueCardData rogueCardData = rogueDeck.DrawCard(rank);
			if (rogueCardData == null)
			{
				return;
			}
			handData.AddCardToHand(rogueCardData);
			drawCardPool.Add(rogueCardData);
			RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnDrawInBattle);
			num--;
		}
		RogueCardEffectManager.Instance.TriggerEffects(TriggerMoment.OnAfterDraw);
		isTargetDraw = false;
		SortCard(handData, sortState);
	}

	public void RemoveCard(RogueCardData data)
	{
		destroyedCardsCache.Add(data);
		if (handData.RemoveCard(data) == null)
		{
			rogueDeck.RemoveCard(data);
		}
	}

	public void InsertAndSortHand(HandData<RogueCardData> targetHand, List<RogueCardData> newCards)
	{
		foreach (RogueCardData newCard in newCards)
		{
			targetHand.AddCardToHand(newCard);
		}
		bool flag = false;
		for (int i = 0; i < targetHand.cardOrder.Count; i++)
		{
			for (int j = 0; j < targetHand.cardOrder.Count - i - 1; j++)
			{
				RogueCardData rogueCardData = targetHand.handCards[targetHand.cardOrder[j]];
				RogueCardData rogueCardData2 = targetHand.handCards[targetHand.cardOrder[j + 1]];
				bool flag2 = false;
				if (sortState == 1 || sortState == 0)
				{
					flag2 = rogueCardData.rank < rogueCardData2.rank;
				}
				else if (sortState == 2)
				{
					flag2 = rogueCardData.suit > rogueCardData2.suit;
				}
				if (flag2)
				{
					targetHand.SwapCardPositions(j, j + 1);
					flag = true;
				}
			}
			if (!flag)
			{
				break;
			}
		}
	}

	public void PlaySelectedCard(List<RogueCardData> cardList, ScoreResult scoreResult)
	{
		foreach (RogueCardData item in handData.PlaySelectedCard(cardList))
		{
			if (item != null)
			{
				rogueDeck.DiscardCard(item);
			}
		}
	}

	public void DisCardAll()
	{
		List<RogueCardData> handCards = handData.handCards;
		foreach (RogueCardData item in handCards)
		{
			rogueDeck.DiscardCard(item);
		}
		for (int num = handCards.Count - 1; num >= 0; num--)
		{
			RemoveCard(handCards[num]);
		}
	}

	public void RefreshWuChangWhiteData()
	{
		List<RogueCardItemCfg> list = RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg itemCfg) => itemCfg.type == ItemType.WhiteWuChang);
		if (list.Count > 1)
		{
			list.RemoveAll((RogueCardItemCfg itemCfg) => itemCfg.id == whiteWuChangID);
		}
		RogueCardItemCfg rogueCardItemCfg = list[RogueCardGameMain.Random.Range(0, list.Count)];
		whiteWuChangID = rogueCardItemCfg.id;
	}

	public void RefreshWuChangBlackData()
	{
		List<RogueCardItemCfg> list = RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg itemCfg) => itemCfg.type == ItemType.BlackWuChang);
		if (list.Count > 1)
		{
			list.RemoveAll((RogueCardItemCfg itemCfg) => itemCfg.id == blackWuChangID);
		}
		RogueCardItemCfg rogueCardItemCfg = list[RogueCardGameMain.Random.Range(0, list.Count)];
		blackWuChangID = rogueCardItemCfg.id;
	}

	public void RefreshWoeWealList(bool isChange)
	{
		int count = wealList.Count;
		bool flag = false;
		int removedWealID = 199;
		int removedWoeID = 299;
		if (stageType == LevelType.Challenge)
		{
			if (count >= RogueCardGameMain.GameContext.curRound)
			{
				if (wealWoeRefreshNum <= 0 || !isChange)
				{
					return;
				}
				wealWoeRefreshNum--;
				flag = true;
				removedWealID = wealList[count - 1];
				removedWoeID = woeList[count - 1];
				wealList.RemoveAt(count - 1);
				woeList.RemoveAt(count - 1);
			}
			List<int> wealWoeIDList = RogueCardDataManager.GetWealWoeIDList(WealOrWoeType.Weal, new int[0]);
			for (int num = wealWoeIDList.Count - 1; num >= 0; num--)
			{
				int num2 = RogueCardDataManager.wealAndWoeDatabase[wealWoeIDList[num]].max_num;
				if (num2 == 0)
				{
					num2 = -1;
				}
				for (int i = 0; i < wealList.Count; i++)
				{
					if (wealList[i] == wealWoeIDList[num])
					{
						num2--;
					}
					if (num2 == 0)
					{
						wealWoeIDList.RemoveAt(num);
						break;
					}
				}
			}
			if (removedWealID != 199 && wealWoeIDList.Count > 1)
			{
				wealWoeIDList.RemoveAll((int id) => id == removedWealID);
			}
			Dictionary<int, float> dictionary = new Dictionary<int, float>();
			for (int num3 = 0; num3 < wealWoeIDList.Count; num3++)
			{
				RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg = RogueCardDataManager.wealAndWoeDatabase[wealWoeIDList[num3]];
				dictionary.Add(wealWoeIDList[num3], rogueCardWealAndWoeCfg.weight);
			}
			int item = RogueCardGameMain.Instance.randomSystem.WeightedRandom(dictionary);
			Dictionary<int, float> dictionary2 = new Dictionary<int, float>();
			List<int> wealWoeIDList2 = RogueCardDataManager.GetWealWoeIDList(WealOrWoeType.Woe, new int[0]);
			if (removedWoeID != 299 && wealWoeIDList2.Count > 1)
			{
				wealWoeIDList2.RemoveAll((int id) => id == removedWoeID);
			}
			for (int num4 = 0; num4 < wealWoeIDList2.Count; num4++)
			{
				RogueCardWealAndWoeCfg rogueCardWealAndWoeCfg2 = RogueCardDataManager.wealAndWoeDatabase[wealWoeIDList2[num4]];
				dictionary2.Add(wealWoeIDList2[num4], rogueCardWealAndWoeCfg2.weight);
			}
			int item2 = RogueCardGameMain.Instance.randomSystem.WeightedRandom(dictionary2);
			wealList.Add(item);
			woeList.Add(item2);
			if (flag)
			{
				RogueCardGameMain.Instance.saveSystem.SaveGameData();
			}
		}
		else
		{
			if (count >= RogueCardGameMain.GameContext.curRound)
			{
				return;
			}
			RogueCardStageCfg rogueCardStageCfg = RogueCardDataManager.stageDatabase[stageID];
			int item3 = rogueCardStageCfg.boss_weal[RogueCardGameMain.GameContext.curRound - 1];
			int item4 = rogueCardStageCfg.boss_woe[RogueCardGameMain.GameContext.curRound - 1];
			wealList.Add(item3);
			woeList.Add(item4);
		}
		SetTargetScore();
	}

	public void InitShopData()
	{
		if (!isRestoringSave)
		{
			shopData.InitShopData();
		}
	}

	public bool RefreshByCost()
	{
		if (gold >= shopData.curRefreshCost)
		{
			gold -= shopData.curRefreshCost;
			settleContext.useGoldNum += shopData.curRefreshCost;
			shopData.curRefreshCost++;
			shopData.RefreshShopData();
			return true;
		}
		LuaHelper.CallFunction("ShowTips", "ROGUE_CARD_NO_MONEY");
		return false;
	}

	public void DeSelect()
	{
		handData.DeSelect();
	}

	public void SelectCard(int index)
	{
		handData.SelectCard(index);
	}

	public int[] GetSelectIndexList()
	{
		return handData.GetSelectIndexList();
	}

	public int[] GetUnSelectIndexList()
	{
		return handData.GetUnselectIndexList();
	}

	public List<RogueCardData> GetSelectDataList()
	{
		_selectDataCache.Clear();
		int[] selectIndexList = GetSelectIndexList();
		Array.Sort(selectIndexList);
		for (int i = 0; i < selectIndexList.Length; i++)
		{
			_selectDataCache.Add(GetHandCard(selectIndexList[i]));
		}
		List<RogueCardData> list = new List<RogueCardData>();
		list.AddRange(_selectDataCache);
		return list;
	}

	public List<RogueCardData> GetUnSelectDataList()
	{
		_unselectDataCache.Clear();
		int[] unSelectIndexList = GetUnSelectIndexList();
		Array.Sort(unSelectIndexList);
		for (int i = 0; i < unSelectIndexList.Length; i++)
		{
			_unselectDataCache.Add(GetHandCard(unSelectIndexList[i]));
		}
		List<RogueCardData> list = new List<RogueCardData>();
		list.AddRange(_unselectDataCache);
		return list;
	}

	public RogueCardData GetHandCard(int index)
	{
		return handData.GetCardDataAtDisplayIndex(index);
	}

	public void RefreshWuChangData()
	{
		wuChangWaitCards.DeSelect();
		selectWuChangIndex = -1;
	}

	public void WuChangSelectCard(int index)
	{
	}

	public void WuChangSelectWuChang(int index)
	{
		if (selectWuChangIndex == index)
		{
			selectWuChangIndex = -1;
		}
		else
		{
			selectWuChangIndex = index;
		}
	}

	public void SortCard(HandData<RogueCardData> handData, int sortType = -1)
	{
		int num = sortType;
		if (num == -1)
		{
			if (sortState == 0 || sortState == 2)
			{
				num = 1;
			}
			else if (sortState == 1)
			{
				num = 2;
			}
		}
		sortState = num;
		bool flag = false;
		for (int i = 0; i < handData.cardOrder.Count; i++)
		{
			for (int j = 0; j < handData.cardOrder.Count - i - 1; j++)
			{
				RogueCardData rogueCardData = handData.handCards[handData.cardOrder[j]];
				RogueCardData rogueCardData2 = handData.handCards[handData.cardOrder[j + 1]];
				bool flag2 = false;
				switch (num)
				{
				case 1:
					if (rogueCardData.rank < rogueCardData2.rank)
					{
						flag2 = true;
					}
					else if (rogueCardData.rank == rogueCardData2.rank && rogueCardData.suit > rogueCardData2.suit)
					{
						flag2 = true;
					}
					break;
				case 2:
					if (rogueCardData.suit > rogueCardData2.suit)
					{
						flag2 = true;
					}
					else if (rogueCardData.suit == rogueCardData2.suit && rogueCardData.rank < rogueCardData2.rank)
					{
						flag2 = true;
					}
					break;
				}
				if (flag2)
				{
					handData.SwapCardPositions(j, j + 1);
					flag = true;
				}
			}
			if (!flag)
			{
				break;
			}
		}
	}

	public void SortJokerCard()
	{
		bool flag = false;
		for (int i = 0; i < jokerData.cardOrder.Count; i++)
		{
			flag = false;
			for (int j = 0; j < jokerData.cardOrder.Count - i - 1; j++)
			{
				RogueCardJokerData jokerA = jokerData.handCards[jokerData.cardOrder[j]];
				RogueCardJokerData jokerB = jokerData.handCards[jokerData.cardOrder[j + 1]];
				if (CompareJokerForSort(jokerA, jokerB) > 0)
				{
					jokerData.SwapCardPositions(j, j + 1);
					flag = true;
				}
			}
			if (!flag)
			{
				break;
			}
		}
	}

	private int CompareJokerForSort(RogueCardJokerData jokerA, RogueCardJokerData jokerB)
	{
		if (jokerA == jokerB)
		{
			return 0;
		}
		if (jokerA == null)
		{
			return 1;
		}
		if (jokerB == null)
		{
			return -1;
		}
		int num = GetJokerSortPriority(jokerB) - GetJokerSortPriority(jokerA);
		if (num != 0)
		{
			return num;
		}
		bool flag = jokerA.versionID != 0;
		bool flag2 = jokerB.versionID != 0;
		if (flag != flag2)
		{
			if (!flag)
			{
				return 1;
			}
			return -1;
		}
		if (!flag)
		{
			return jokerA.id - jokerB.id;
		}
		int num2 = GetJokerVersionSortPriority(jokerA.versionID) - GetJokerVersionSortPriority(jokerB.versionID);
		if (num2 != 0)
		{
			return num2;
		}
		if (jokerA.versionID != jokerB.versionID)
		{
			return jokerA.versionID - jokerB.versionID;
		}
		return jokerA.id - jokerB.id;
	}

	private int GetJokerSortPriority(RogueCardJokerData jokerData)
	{
		if (jokerData == null)
		{
			return int.MinValue;
		}
		return RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.id == jokerData.id)?.sort_priority ?? int.MinValue;
	}

	private int GetJokerVersionSortPriority(int versionID)
	{
		if (versionID == 0)
		{
			return int.MaxValue;
		}
		if (RogueCardDataManager.enhanceDatabase.TryGetValue(versionID, out var value))
		{
			return value.sort_priority;
		}
		return int.MaxValue;
	}

	public void RefreshWuChangPackage()
	{
		if ((packageWuChang != null && packageWuChang.Count > 0) || isRestoringSave)
		{
			return;
		}
		RogueCardPackageCfg cfg = RogueCardDataManager.packageDatabase[RogueCardGameMain.Instance.gameContext.curPackageID];
		RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg itemCfg) => itemCfg.type == cfg.type);
		new RogueCardItemCfg();
		int num = cfg.content[0];
		Dictionary<RogueCardItemCfg, float> dictionary = new Dictionary<RogueCardItemCfg, float>();
		foreach (RogueCardItemCfg goods in RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg item) => item.type == cfg.type))
		{
			float value = 0f;
			if (cfg.type == ItemType.WhiteWuChang)
			{
				if (goods.rare == 1)
				{
					value = RogueCardGameMain.GameContext.globalAttrDic[AttributeType.WhiteWuChangLowRatio];
				}
				else if (goods.rare == 2)
				{
					value = RogueCardGameMain.GameContext.globalAttrDic[AttributeType.WhiteWuChangHighRatio];
				}
			}
			else if (goods.rare == 1)
			{
				value = RogueCardGameMain.GameContext.globalAttrDic[AttributeType.BlackWuChangLowRatio];
			}
			else if (goods.rare == 2)
			{
				value = RogueCardGameMain.GameContext.globalAttrDic[AttributeType.BlackWuChangHighRatio];
			}
			if (RogueCardGameMain.GameContext.jokerData.handCards.Find((RogueCardJokerData joker) => joker.id == goods.id) == null && RogueCardGameMain.GameContext.shopData.shopItemDataList.Find((ShopItemData item) => item.cfg.id == goods.id) == null)
			{
				dictionary.Add(goods, value);
			}
		}
		packageWuChang.Clear();
		while (num > 0)
		{
			RogueCardItemCfg rogueCardItemCfg = RogueCardGameMain.Instance.randomSystem.WeightedRandom(dictionary);
			dictionary.Remove(rogueCardItemCfg);
			packageWuChang.Add(rogueCardItemCfg.id);
			num--;
		}
		lastPackageNum = cfg.content[1];
	}

	public void ClearPackageJokerData()
	{
		packageJoker.Clear();
		packageJokerVersion.Clear();
	}

	public void AddPackageJokerData(int jokerID, int versionID = 0)
	{
		packageJoker.Add(jokerID);
		packageJokerVersion.Add(versionID);
	}

	public int GetPackageJokerVersion(int index)
	{
		if (index < 0 || index >= packageJokerVersion.Count)
		{
			return 0;
		}
		return packageJokerVersion[index];
	}

	public void RemovePackageJokerAt(int index)
	{
		if (index >= 0 && index < packageJoker.Count)
		{
			packageJoker.RemoveAt(index);
			if (index >= 0 && index < packageJokerVersion.Count)
			{
				packageJokerVersion.RemoveAt(index);
			}
		}
	}

	public void RefreshJokerPackage()
	{
		if ((packageJoker != null && packageJoker.Count > 0) || isRestoringSave)
		{
			return;
		}
		packageJoker.Clear();
		packageJokerVersion.Clear();
		int key = RogueCardGameMain.Instance.gameContext.curPackageID;
		RogueCardPackageCfg cfg = RogueCardDataManager.packageDatabase[key];
		lastPackageNum = cfg.content[1];
		if (RogueCardGameMain.Instance.guideSystem.CheckGuide(RogueCardGuideMoment.package_card, ignoreGuideState: true))
		{
			foreach (RogueCardGuideItem guide in RogueCardGameMain.Instance.guideSystem.GetGuideItems(RogueCardGuideMoment.package_card))
			{
				RogueCardItemCfg rogueCardItemCfg = RogueCardDataManager.itemDatabase.Find((RogueCardItemCfg item) => item.type == ItemType.Joker && item.id == guide.id);
				if (rogueCardItemCfg != null)
				{
					AddPackageJokerData(rogueCardItemCfg.id, guide.versionID);
				}
			}
			return;
		}
		RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg itemCfg) => itemCfg.type == cfg.type);
		new RogueCardItemCfg();
		int num = cfg.content[0];
		Dictionary<RogueCardItemCfg, float> dictionary = new Dictionary<RogueCardItemCfg, float>();
		foreach (RogueCardItemCfg goods in RogueCardDataManager.itemDatabase.FindAll((RogueCardItemCfg item) => item.type == ItemType.Joker))
		{
			float num2 = 0f;
			num2 = ((goods.rare == 1) ? ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare1Weight]) : ((goods.rare != 2) ? ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare3Weight]) : ((float)RogueCardGameMain.GameContext.globalAttrDic[AttributeType.Rare2Weight])));
			if (RogueCardGameMain.GameContext.jokerData.handCards.Find((RogueCardJokerData joker) => joker.id == goods.id) == null && RogueCardGameMain.GameContext.shopData.shopItemDataList.Find((ShopItemData item) => item.cfg.id == goods.id) == null)
			{
				dictionary.Add(goods, num2);
			}
		}
		while (num > 0)
		{
			RogueCardItemCfg rogueCardItemCfg2 = RogueCardGameMain.Instance.randomSystem.WeightedRandom(dictionary);
			if (rogueCardItemCfg2 == null)
			{
				break;
			}
			List<RogueCardEnhanceCfg> list = new List<RogueCardEnhanceCfg>();
			foreach (KeyValuePair<int, RogueCardEnhanceCfg> item in RogueCardDataManager.enhanceDatabase)
			{
				if (item.Value.type == EnhanceType.Version)
				{
					list.Add(item.Value);
				}
			}
			int num3 = RogueCardGameMain.Instance.randomSystem.Range(1, 1001);
			int num4 = 0;
			int versionID = 0;
			for (int num5 = 0; num5 < list.Count; num5++)
			{
				num4 += list[num5].rare;
				if (num3 <= num4)
				{
					versionID = list[num5].id;
					break;
				}
			}
			dictionary.Remove(rogueCardItemCfg2);
			AddPackageJokerData(rogueCardItemCfg2.id, versionID);
			num--;
		}
	}
}
