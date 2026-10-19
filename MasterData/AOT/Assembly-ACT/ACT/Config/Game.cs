using System;
using System.Collections.Generic;

namespace ACT.Config;

[Serializable]
public class Game
{
	public float chipTransPercent;

	public float weaponTransPercent;

	public List<ItemKv> initCharacter;

	public int[] xpBook;

	public int showAllItemLight;

	public int[] showPartItemLight;

	public int showRareItemLight;

	public int weaponEXPRequire;

	public int bagStackLimit;

	public int[] dropItemPerfabLight;

	public int dayRefreshHourOffset;

	public int stageRewardNeedMissonNum;

	public int weaponConsumeListNumber;

	public int bornMap;

	public float[] defBornPos;

	public int initMissionType;

	public int initDailyMissionNum;

	public float initBoundaryDistance;

	public float initFuzzyDistance;

	public int[] userDefinedIcons;

	public int mapCustomFlagMaxNum;

	public int[][] elementType;

	public int[][] characterType;

	public int characterInTeam;

	public int maxTeamNumber;

	public int[] weaponEnhancementMaterial;

	public int playerLevel;

	public float changeCharacterCoolDownTime;

	public int playerMaxLevelEachExpToGold;

	public int playerExpMaxOverflow;

	public int maxLevel;

	public int[] characterBraekLevels;

	public float expToCoinData;

	public int[] characterBreakStage;

	public int playerMaxLevel;

	public int[] playerLevelWorldLevel;

	public float offsiteChargeRate;

	public float[] anomalyChargeRate;

	public float nomalyChargeRate;

	public int bagWeaponLimit;

	public int bagChipLimit;

	public int[] OneCollectionEA;

	public string[] defaultTeamName;

	public string defaultAppendTeamName;

	public int worldLevelCD;

	public int worldLevelOnceRange;

	public int maxNumberOfOrdinaryMailboxes;

	public int maxNumberOfPreciousMailboxes;

	public List<ItemKv> raidLevel;

	public int weekTypeRewardTime;

	public float raidArchiveRevivalHp;

	public int powerLimit;

	public int secRecoverPower;

	public int[] chipEnhancementMaterial;

	public int initDailyMissionList;

	public int[][] monsterDeadUltraEnergyRecovery;

	public List<ItemKv> freeDiamondExchangePowerCost;

	public int freeDiamondExchangePowerObtain;

	public int freeDiamondExchangePowerNum;

	public int hpSync;

	public int characterSyncInterval;

	public int pingInterval;

	public int exchangePowerItemID;

	public float mainArchiveRevivalHp;

	public int defaultHeadAddress;

	public string defaultNickName;

	public string defaultIntroduction;

	public int customMenuLimit;

	public int cookFieldLimit;

	public int cookBuffTimeLimit;

	public List<ItemKv> cookBuffBaseWeight;

	public int cardpoolDrawMax;

	public List<Maybe> cardpoolDrawWeaponExtraReward;

	public List<Maybe> constellationExtraReward;

	public List<Maybe> constellationNotExtraReward;

	public string[] uiForceOpenList;

	public float decayAttackConst;

	public float characterLowHpPercent;

	public float waitServerPingTime;

	public int[] wifiPingConfig;

	public int[] dataPingConfig;

	public float newLocationTipCD;

	public int[] defaultSoundValue;

	public int disConnectSubworldTime;

	public int[] iPhoneSafeAreaOffset;

	public int[] androidSafeAreaOffset;

	public int[] windowsSafeAreaOffset;

	public float portalRecoverHPWaitTime;

	public float portalRecoverHPIntervalTime;

	public float portalRecoverHP;

	public float portalReviveBaseHP;

	public List<ItemKv> eachOnceCollectionMaxShowCount;

	public int hotUpdateNetworkWaitingTime;

	public int UiGuideLimit;

	public int MenuNameLimit;

	public int MistPointUnitDensity;

	public int MistPointUnitRatio;

	public List<ItemKv> activePointDailyRewardExchangeCost;

	public List<ItemKv> activePointExtraRewardExchangeCost;

	public List<ItemKv> activePointDailyRewardPreconditions;

	public List<ItemKv> activePointExtraRewardPreconditions;

	public int[] activePointDailyReward;

	public int[] activePointExtraReward;

	public float[] HitTypeParams;

	public List<ItemKv> CharacterMissionCostItem;

	public int[] MonsterHandListType;

	public ItemKv WeekBossDiscount;

	public List<ItemKv> MaterialTypeEnumeration;

	public int[] SmallItemShow;

	public int[] cookDoubleMaterialReject;

	public int[] ChipSlot;

	public float ChipDecompositionFacto;

	public int[] ChipSlotRelease;

	public int ChipEntryMaxSameNum;

	public int[] ChipSuitNum;

	public int ChipLevelUpItem;

	public int[] cookTypeList;

	public int[] UntraceableMonster;

	public int monsterWeeklyDropMaxExp;

	public int[] nickNameLengthLimit;

	public int rogueTeamLimit;

	public float rogueCaskActiveDefault;

	public int rogueCaskCoinDefault;

	public int[] rogueShopRareBasePrice;

	public float[][] roguePressureInterval;

	public float[] roguePriceInterval;

	public float roguePluralInterval;

	public int rogueOutCoinId;

	public int rogueTableStageCost;

	public int rogueDefaultCardChoose;

	public int[] rogueRedrawCoinCost;

	public int rogueRedrawLimit;

	public int[] GemstoneMeltingValue;

	public int raidNpcId;

	public int[] dayRaidType;

	public int dayRaidParkourDeadLimit;

	public int[] elite4StarToken;

	public int[] elite4StarTokenNum;

	public int[] elite4StarStageTokenNum;

	public int[] elite5StarToken;

	public int[] elite5StarTokenNum;

	public int[] elite5StarStageTokenNum;

	public int eliteStage1CharacterLevel;

	public int eliteStage1AttrNum;

	public int eliteStage1AttrLevel;

	public int eliteStage2PlayerLevel;

	public int eliteStage2EliteLevel;

	public int eliteStage2AttrNum;

	public int eliteStage2AttrLevel;

	public int eliteStage3PlayerLevel;

	public int eliteStage3EliteLevel;

	public int eliteStage3AttrNum;

	public int eliteStage3AttrLevel;

	public int eliteSkill1Num;

	public int eliteSkill2Num;

	public int eliteSkill3Num;

	public int potionCd;

	public int gachaDrawItemToken;

	public int gachaDrawItemNum;

	public int gachaDrawRoleToken;

	public int gachaDraw4StarNum;

	public int gachaDraw4StarDestinedNum;

	public int gachaDraw5StarNum;

	public int gachaDraw5StarDestinedNum;

	public int attrActivePoint;

	public int attrActiveExtraPoint;

	public int[] equipRareLevel;

	public int messageDynamicEffectBase;

	public int worldExpDropLimit;

	public int worldCoinDropLimit;

	public int equipRecycleLimit;

	public int gemRecycleLimit;

	public List<ItemKv> escOpen;

	public int activePointDailyLimit;

	public int bornChunk;

	public float[] presentFavorability;

	public int mapSpotLimit;

	public int presentDailyMax;

	public float loungePointWeightReduction;

	public int[] loungePoint;

	public int[] loungereFreshTime;

	public int loungereInviteNumberMax;

	public int loungereGreetFavorability;

	public int battlePassExp;

	public int battlePassExplimitation;

	public int battlePassExpBuy;

	public int textMail;

	public int BagRecycleLimit;

	public int battlePassShop;

	public int SubEnergyGuideTime;

	public int MaleDefaultAvatarId;

	public int FemaleDefaultAvatarId;

	public int nodeInterestCap;

	public int loungereGreetConditionNum;

	public int loungereGreetCommonNum;

	public int redemptionCode;

	public int genderChangeCooldown;

	public int topUpRebate;

	public int repeatPurchase;

	public int[] precondition76support;

	public int limitForCollectingItems;

	public int battlePassMail;

	public int surveyRewardMail;

	public int DailyRandomMessageNum;

	public int FemaleSkinId;

	public int MaleSkinId;

	public int BloodStainMinDistance;

	public int BloodStainMaxChunkNumber;

	public int[] BloodStainOffset;

	public int BloodStainGoldCollection;

	public int MessageLimit;

	public int MessageDuaLimit;

	public int NameDuLimit;

	public int BloodStainGeneratNumber;

	public float fogClearedRatio;

	public int maxAbyssPhaseRecord;

	public int expPerStamina;

	public ItemKv recoveryRule;

	public string rogueItemDropPath;

	public int firstFrame;

	public int beaconLifeCycle;

	public int beaconOvertime;

	public int beaconPlayerLimitNum;

	public int beaconChunkLimitNum;

	public int beaconChunkLoadNum;

	public int CommentMinDistance;

	public string databaseVersion;
}
