local CampaignIDErrorType = {CAMPAIGN_ID_INVALID = 0}
_enum("CampaignIDErrorType", CampaignIDErrorType)
local CampaignDefaultNotify = {CAMPAIGN_NOTIFY_DEFAULT = -1}
_enum("CampaignDefaultNotify", CampaignDefaultNotify)
local CampaignConfigDefine = {CONFIG_CAMPAIGN_ID_MOD = 100000, CONFIG_COMPONENT_TYPE_MOD = 100}
_enum("CampaignConfigDefine", CampaignConfigDefine)
local CampaignCompentState = {
  CCS_Invalid = 0,
  CCS_Doing = 1,
  CCS_Over = 2
}
_enum("CampaignCompentState", CampaignCompentState)
local CampaignSpecialType = {
  CST_Common = 0,
  CST_Review = 1,
  CST_Season = 2,
  CST_Rank = 3,
  CST_Maze = 4
}
_enum("CampaignSpecialType", CampaignSpecialType)
local SeasonEventPointProgress = {SEPP_Begin = 0, SEPP_End = 5}
_enum("SeasonEventPointProgress", SeasonEventPointProgress)
local SeasonEventPointType = {
  MainLevel = 1,
  SubLevel = 2,
  MainStory = 3,
  SubStory = 4,
  Box = 5,
  SubBox = 6,
  Mechanism = 7,
  SubMechanism = 8,
  DailyLevel = 9,
  Task = 10,
  NavPoint = 11
}
_enum("SeasonEventPointType", SeasonEventPointType)
local ECampaignType = {
  CAMPAIGN_TYPE_INVALID = 0,
  CAMPAIGN_TYPE_COMPONENT = 10000,
  CAMPAIGN_TYPE_DEMO1 = 10001,
  CAMPAIGN_TYPE_DEMO2 = 10002,
  CAMPAIGN_TYPE_EVERESCUEPLAN = 10003,
  CAMPAIGN_TYPE_HIIRO = 10004,
  CAMPAIGN_TYPE_SUMMER_I = 10005,
  CAMPAIGN_TYPE_SUMMER_II = 10006,
  CAMPAIGN_TYPE_BATTLEPASS = 10007,
  CAMPAIGN_TYPE_N5 = 10008,
  CAMPAIGN_TYPE_HALLOWEEN = 10009,
  CAMPAIGN_TYPE_GRASS = 10010,
  CAMPAIGN_TYPE_WEEK_TOWER = 10012,
  CAMPAIGN_TYPE_N7 = 10013,
  CAMPAIGN_TYPE_N8 = 10014,
  CAMPAIGN_TYPE_N9 = 10015,
  CAMPAIGN_TYPE_N10 = 10016,
  CAMPAIGN_TYPE_N11 = 10017,
  CAMPAIGN_TYPE_N12 = 10018,
  CAMPAIGN_TYPE_N13 = 10019,
  CAMPAIGN_TYPE_N14 = 10020,
  CAMPAIGN_TYPE_N15 = 10021,
  CAMPAIGN_TYPE_N16 = 10022,
  CAMPAIGN_TYPE_N17 = 10023,
  CAMPAIGN_TYPE_N18 = 10024,
  CAMPAIGN_TYPE_N19_COMMON = 10025,
  CAMPAIGN_TYPE_N19_P5 = 10026,
  CAMPAIGN_TYPE_N20 = 10027,
  CAMPAIGN_TYPE_N21_CHALLENGE = 10028,
  CAMPAIGN_TYPE_N21 = 10029,
  CAMPAIGN_TYPE_N22 = 10030,
  CAMPAIGN_TYPE_N23 = 10031,
  CAMPAIGN_TYPE_N24 = 10032,
  CAMPAIGN_TYPE_N25 = 10033,
  CAMPAIGN_TYPE_N25_NEW_YEAR = 10034,
  CAMPAIGN_TYPE_N26 = 10036,
  CAMPAIGN_TYPE_N27 = 10037,
  CAMPAIGN_TYPE_N27_MINI_GAME = 10038,
  CAMPAIGN_TYPE_N28 = 10039,
  CAMPAIGN_TYPE_N28_MINI_GAME = 10040,
  CAMPAIGN_TYPE_N29 = 10041,
  CAMPAIGN_TYPE_N30 = 10042,
  CAMPAIGN_TYPE_N31 = 10043,
  CAMPAIGN_TYPE_DIFFICULTY_WEEK_TOWER = 10044,
  CAMPAIGN_TYPE_N31_ANNIVERSARY = 10045,
  CAMPAIGN_TYPE_N31_CENTER = 10046,
  CAMPAIGN_TYPE_GLOBALBOSS = 10047,
  CAMPAIGN_TYPE_N32 = 10048,
  CAMPAIGN_TYPE_N32_VIG_QUEST = 10049,
  CAMPAIGN_TYPE_N33 = 10101,
  CAMPAIGN_TYPE_N33_EIGHT_PETS = 10102,
  CAMPAIGN_TYPE_N34 = 10103,
  CAMPAIGN_TYPE_N37 = 10104,
  CAMPAIGN_TYPE_N39 = 10105,
  CAMPAIGN_TYPE_N42 = 10106,
  CAMPAIGN_TYPE_N43 = 10107,
  CAMPAIGN_TYPE_N45 = 10108,
  CAMPAIGN_TYPE_N48 = 10109,
  CAMPAIGN_TYPE_BACK = 10050,
  CAMPAIGN_TYPE_HAVESTTIME = 10051,
  CAMPAIGN_TYPE_SENIOR_SKIN = 10052,
  CAMPAIGN_TYPE_POWERCOST = 10053,
  CAMPAIGN_TYPE_CHESS = 10054,
  CAMPAIGN_TYPE_SIGN_IN = 10055,
  CAMPAIGN_TYPE_CELEBRATION = 10056,
  CAMPAIGN_TYPE_ANNIVERSARY = 10057,
  CAMPAIGN_TYPE_SENIOR_SKIN_COPY = 10058,
  CAMPAIGN_TYPE_SPECIAL = 10059,
  CAMPAIGN_TYPE_BACK_PHASE_II = 10060,
  CAMPAIGN_TYPE_LINE_MISSION = 10061,
  CAMPAIGN_TYPE_SIGN_IN_TWO = 10063,
  CAMPAIGN_TYPE_MAIN_MISSION = 10064,
  CAMPAIGN_TYPE_COLLECT_CARD = 10065,
  CAMPAIGN_TYPE_COLLECT_FROG = 10066,
  CAMPAIGN_TYPE_STORY_ACTIVITY = 10067,
  CAMPAIGN_TYPE_OPTION_PET = 10068,
  CAMPAIGN_TYPE_FISH_GAME = 10069,
  CAMPAIGN_TYPE_REVIEW_N1 = 20001,
  CAMPAIGN_TYPE_REVIEW_N2 = 20002,
  CAMPAIGN_TYPE_REVIEW_N3 = 20003,
  CAMPAIGN_TYPE_REVIEW_N4 = 20004,
  CAMPAIGN_TYPE_REVIEW_N5 = 20005,
  CAMPAIGN_TYPE_REVIEW_N6 = 20006,
  CAMPAIGN_TYPE_REVIEW_N7 = 20007,
  CAMPAIGN_TYPE_REVIEW_N8 = 20008,
  CAMPAIGN_TYPE_REVIEW_N9 = 20009,
  CAMPAIGN_TYPE_REVIEW_N11 = 20011,
  CAMPAIGN_TYPE_REVIEW_N12 = 20012,
  CAMPAIGN_TYPE_REVIEW_N13 = 20013,
  CAMPAIGN_TYPE_REVIEW_N14 = 20014,
  CAMPAIGN_TYPE_REVIEW_N15 = 20015,
  CAMPAIGN_TYPE_REVIEW_N16 = 20016,
  CAMPAIGN_TYPE_REVIEW_N18 = 20017,
  CAMPAIGN_TYPE_INLAND_S1 = 50003,
  CAMPAIGN_TYPE_INLAND_S2 = 50004,
  CAMPAIGN_TYPE_INLAND_S0 = 50006,
  CAMPAIGN_TYPE_INLAND_FIRSTPET = 50005,
  CAMPAIGN_TYPE_INLAND_TIMELOGIN = 50007,
  CAMPAIGN_TYPE_INLAND_SAILING = 50008,
  CAMPAIGN_TYPE_INLAND_PET_WS = 50009,
  CAMPAIGN_TYPE_INLAND_DINNER = 50011,
  CAMPAIGN_TYPE_INLAND_N6 = 50013,
  CAMPAIGN_TYPE_INLAND_N7 = 50014,
  CAMPAIGN_TYPE_INLAND_N9 = 50016,
  CAMPAIGN_TYPE_INLAND_N4_CHALLENGE = 50020,
  CAMPAIGN_TYPE_INLAND_VOTE = 50021,
  CAMPAIGN_TYPE_INLAND_N9_ASHEEP = 50023,
  CAMPAIGN_TYPE_LUCKLAND = 50025,
  CAMPAIGN_TYPE_INLAND_N12 = 50026,
  CAMPAIGN_TYPE_INLAND_PERFECT_PUZZLE = 50028,
  CAMPAIGN_TYPE_INLAND_GAMBLE = 50029,
  CAMPAIGN_TYPE_INLAND_N16 = 50033,
  CAMPAIGN_TYPE_INLAND_N17 = 50034,
  CAMPAIGN_TYPE_INLAND_N18 = 50035,
  CAMPAIGN_TYPE_INLAND_N20 = 50037,
  CAMPAIGN_TYPE_INLAND_N21 = 50038,
  CAMPAIGN_TYPE_INLAND_N22 = 50039,
  CAMPAIGN_TYPE_FLTT = 50040,
  CAMPAIGN_TYPE_INLAND_STORY = 50202,
  CAMPAIGN_TYPE_INLAND_PET_SKIN = 52000,
  CAMPAIGN_TYPE_INLAND_BUSINESS = 53000,
  CAMPAIGN_TYPE_INLAND_RANDOM_DRAW = 54000,
  CAMPAIGN_TYPE_INLAND_SEASON_BEGIN = 80000,
  CAMPAIGN_TYPE_INLAND_SEASON = 80001,
  CAMPAIGN_TYPE_SEASON_TASK_MISSION = 80002,
  CAMPAIGN_TYPE_SEASON_MAZE = 80003,
  CAMPAIGN_TYPE_INLAND_SEASON_END = 89999
}
_enum("ECampaignType", ECampaignType)
local ECampaignAcceptType = {
  ECAT_All = 0,
  ECAT_NewPlayerOnly = 1,
  ECAT_OldPlayerOnly = 2
}
_enum("ECampaignAcceptType", ECampaignAcceptType)
local CampaignComponentUnlockCondT = {CAMPAIGN_COMPONENT_UNLOCK_AND = 0, CAMPAIGN_COMPONENT_UNLOCK_OR = 1}
_enum("CampaignComponentUnlockCondT", CampaignComponentUnlockCondT)
local ECampaignStep = {
  CAMPAIGN_STEP_INVALID = 0,
  CAMPAIGN_STEP_NEW = 1,
  CAMPAIGN_STEP_REWARD = 2,
  CAMPAIGN_STEP_CLOSE_TLOG = 4,
  CAMPAIGN_STEP_HIDE = 8,
  CAMPAIGN_STEP_RED = 16,
  CAMPAIGN_STEP_DAILY_NEW = 32,
  CAMPAIGN_STEP_RAFFLE = 64,
  CAMPAIGN_STEP_FORCE_POP = 128,
  CAMPAIGN_STEP_EVERY_LOGIN = 256,
  CAMPAIGN_STEP_CAN_CHALLENGE = 512,
  CAMPAIGN_STEP_CLOSE_REMIND = 1024,
  CAMPAIGN_STEP_SEASONQUEST_REWARD = 2048,
  CAMPAIGN_STEP_CLEARING = 4096,
  CAMPAIGN_STEP_FINISHED = 536870912,
  CAMPAIGN_STEP_FINISH = 1073741824
}
_enum("ECampaignStep", ECampaignStep)
local CampaignComType = {
  E_CAMPAIGN_COM_TYPE_BEGIN = 0,
  E_CAMPAIGN_COM_DEMO = 1,
  E_CAMPAIGN_COM_EXCHANGE_ITEM = 2,
  E_CAMPAIGN_COM_CUMULATIVE_LOGIN = 3,
  E_CAMPAIGN_COM_PERSON_PROGESS = 4,
  E_CAMPAIGN_COM_LINE_MISSION = 5,
  E_CAMPAIGN_COM_TREE_MISSION = 6,
  E_CAMPAIGN_COM_QUEST = 7,
  E_CAMPAIGN_COM_STORY = 8,
  E_CAMPAIGN_COM_LOTTERY = 9,
  E_CAMPAIGN_COM_COMMON_BASE = 10,
  E_CAMPAIGN_COM_SUM_II_MISSION = 11,
  E_CAMPAIGN_COM_LV_REWARD = 12,
  E_CAMPAIGN_COM_BUY_GIFT = 13,
  E_CAMPAIGN_COM_ACTION_POINT = 14,
  E_CAMPAIGN_COM_BATTLEFIELD = 15,
  E_CAMPAIGN_COM_REBUILD = 16,
  E_CAMPAIGN_COM_BLACKFIST = 17,
  E_CAMPAIGN_COM_ENTRUST = 18,
  E_CAMPAIGN_COM_CHALL_MISSION = 19,
  E_CAMPAIGN_COM_DAILY_MISSION = 20,
  E_CAMPAIGN_COM_POWER2ITEM = 21,
  E_CAMPAIGN_COM_CHESS = 22,
  E_CAMPAIGN_COM_TIME_REWARD = 23,
  E_CAMPAIGN_COM_HOMELAND_GROUP_TASK = 24,
  E_CAMPAIGN_COM_HOMELAND_TASK = 25,
  E_CAMPAIGN_COM_BLOODSUCKER = 26,
  E_CAMPAIGN_COM_MINI_MAIL = 27,
  E_CAMPAIGN_COM_DIFFICULTY_MISSION = 28,
  E_CAMPAIGN_COM_POPSTAR_MISSION = 29,
  E_CAMPAIGN_COM_GLOBALBOSS = 30,
  E_CAMPAIGN_COM_TURNCARD = 31,
  E_CAMPAIGN_COM_MULTILINE_MISSION = 32,
  E_CAMPAIGN_COM_EIGHT_PETS_MISSION = 33,
  E_CAMPAIGN_COM_BACK = 50,
  E_CAMPAIGN_COM_RES_HELP = 51,
  E_CAMPAIGN_COM_REWARD_DOUBLE = 52,
  E_CAMPAIGN_COM_MISSION_DROP = 53,
  E_CAMPAIGN_COM_VOTE = 54,
  E_CAMPAIGN_TIME_LOGIN = 70,
  E_CAMPAIGN_SMELT_ITEM = 71,
  E_CAMPAIGN_COM_SEASON = 72,
  E_CAMPAIGN_COM_WEEKLY_MISSION = 73,
  E_CAMPAIGN_RECALL = 74,
  E_CAMPAIGN_RANDOM_LOTTERY = 76,
  E_CAMPAIGN_BUSINESS = 77,
  E_CAMPAIGN_TALENT_TREE = 78,
  E_CAMPAIGN_COLLECT_CARD = 79,
  E_CAMPAIGN_SEASON_MAZE = 80,
  E_CAMPAIGN_ALCHEMY = 81,
  E_CAMPAIGN_COM_MINI_GAME = 100,
  E_CAMPAIGN_COM_CombatSimulator = 101,
  E_CAMPAIGN_COM_SUBJECT = 102,
  E_CAMPAIGN_COM_SENIOR_SKIN = 103,
  E_CAMPAIGN_COM_CYCLE_QUEST = 104,
  E_CAMPAIGN_COM_MINI_GAME_EXPLORE = 105,
  E_CAMPAIGN_COM_POINT_PROGRESS = 106,
  E_CAMPAIGN_COM_AVG_STORY = 107,
  E_CAMPAIGN_COM_IDOL_GAME = 108,
  E_CAMPAIGN_COM_NEWYEAR_DINNER = 109,
  E_CAMPAIGN_COM_POST_STATION_GAME = 110,
  E_CAMPAIGN_COM_BOUNCE_MISSION = 111,
  E_CAMPAIGN_COM_DETECTIVE = 112,
  E_CAMPAIGN_COM_SIMULATION_OPERATION = 113,
  E_CAMPAIGN_COM_DISPATCH = 114,
  E_CAMPAIGN_COM_SURVEY = 115,
  E_CAMPAIGN_COM_TACIT_TEST = 117,
  E_CAMPAIGN_COM_LINE_POPSTAR_MISSION = 118,
  E_CAMPAIGN_COM_A_SHEEP = 119,
  E_CAMPAIGN_COM_LUCK_LAND = 120,
  E_CAMPAIGN_COM_PERFECT_PUZZLE = 121
}
_enum("CampaignComType", CampaignComType)
local ECampaignComHandle = {
  ECCH_INVALID = 0,
  ECCH_HandleDemoMsg = 1001,
  ECCH_HandleExchangeItemComponentExchange = 2001,
  ECCH_HandleReceiveCumulativeLoginReward = 3001,
  ECCH_HandleReceiveReward = 4001,
  ECCH_HandlePersonProgressOneKeyRecvRewards = 4002,
  ECCH_HandlePersonProgressProgressReq = 4003,
  ECCH_HandleLineMissionMsg = 5001,
  ECCH_HandleLineMissionTeamRecord = 5002,
  ECCH_HandleLineChangeFormationReq = 5003,
  ECCH_HandleCompleteStoryTreeMission = 6001,
  ECCH_HandleTreeMissionTeamRecord = 6002,
  ECCH_HandleQuestTake = 7001,
  ECCH_HandleQuestDailyReset = 7002,
  ECCH_HandleOneKeyTakeAll = 7003,
  ECCH_HandleRecvStoryReward = 8001,
  ECCH_HandleLottery = 9001,
  ECCH_HandleActionPointData = 10001,
  ECCH_HandleCompleteStorySummerIIMission = 11001,
  ECCH_HandleSelectAffix = 11002,
  ECCH_HandleSummerIIChangeFormationReq = 11003,
  ECCH_HandleReceiveLVReward = 12001,
  ECCH_HandleOneKeyReceiveReward = 12002,
  ECCH_HandleApplyBuyGift = 13001,
  ECCH_HandleBattlefieldDailyReset = 15001,
  ECCH_HandleBuild = 16001,
  ECCH_HandleStory = 16002,
  ECCH_HandleCompleteEvent = 16003,
  ECCH_HandlePicnicPutFood = 16004,
  ECCH_HandlePicnicStory = 16005,
  ECCH_HandleEntrustCompleteEvent = 18001,
  ECCH_HandleMoveCompleteEvent = 18002,
  ECCH_HandleClearAffix = 19001,
  ECCH_HandleChallengeSelectAffix = 19002,
  ECCH_HandleChallengeChangeFormationReq = 19003,
  ECCH_HandleChallengeClearNewReq = 19004,
  ECCH_HandleRequestDailyInfo = 20001,
  ECCH_HandleTakeTimeRewardReward = 23001,
  ECCH_HandleCMPHomelandTaskGet = 24001,
  ECCH_HandleReadMiniMail = 25001,
  ECCH_HandleRecvBackReward = 50001,
  ECCH_HandleStoryMsg = 100001,
  ECCH_HandleScoreMsg = 100002,
  ECCH_HandleRecvRewardMsg = 100003,
  ECCH_HandleCombatSimulatorComponentRefresh = 101001,
  ECCH_HandleCombatSimulatorComponentOpenGift = 101002,
  ECCH_HandleCombatSimulatorComponentDelCartridge = 101003,
  ECCH_HandleRewardSubject = 102001,
  ECCH_HandleTestScoreSubject = 102002,
  ECCH_HandleApplySeniorSkinShake = 103001,
  ECCH_HandleRandomRewardPostion = 105001,
  ECCH_HandleExploredReceiveReward = 105002,
  ECCH_HandleEnterExplored = 105003,
  ECCH_HandlePointReceiveReward = 106001,
  ECCH_HandlePointProgressOneKeyRecvRewards = 106002,
  ECCH_HandleSetCurrentLocation = 107001,
  ECCH_HandleUpdateNodeData = 107002,
  ECCH_HandleManualChoose = 107003,
  ECCH_HandleGetBadgeReward = 107004,
  ECCH_HandleComplateEnding = 107005,
  ECCH_HandleShowEvidence = 107006,
  ECCH_HandleGainEvidence = 107007,
  ECCH_HandleUpgradeTalentPoint = 108001,
  ECCH_HandleSelectSkill = 108002,
  ECCH_HandleResetTalentTree = 108003,
  ECCH_HandleCompChangeFormation = 108004,
  ECCH_HandleGetCollectInfo = 109001,
  ECCH_HandleIdolStartPlay = 109002,
  ECCH_HandleIdolTrain = 109003,
  ECCH_HandleIdolCompleteEvent = 109004,
  ECCH_HandleIdolCompleteActivity = 109005,
  ECCH_HandleIdolGetAchieveReward = 109006,
  ECCH_HandleIdolComplateEnding = 109007,
  ECCH_HandleIdolConcertFail = 109008,
  ECCH_HandleNewYearDinnerMakeFood = 109501,
  ECCH_HandleNewYearDinnerReward = 109502,
  ECCH_HandleSubmitMission = 110001,
  ECCH_HandleGetTargetReward = 110002,
  ECCH_HandleSubmitStory = 110003,
  ECCH_HandleDifficultyChangeFormation = 111000,
  ECCH_HandleDifficultyResetSubMissionRecord = 111001,
  ECCH_HandleBounceMissionSettle = 112000,
  ECCH_HandleBounceMissionGetReward = 112001,
  ECCH_HandleDetectiveSubmitItem = 113000,
  ECCH_HandleDetectiveSubmitEnding = 113001,
  ECCH_HandleDetectiveAutoSave = 113002,
  ECCH_HandleDetectiveReadRecordPlay = 113003,
  ECCH_HandlePopStarChangeFormation = 113100,
  ECCH_HandleChangeFormation = 113200,
  ECCH_HandleResetRecord = 113201,
  ECCH_HandleChoseRecord = 113202,
  ECCH_HandleGetRankList = 113203,
  ECCH_HandleRankDetail = 113204,
  ECCH_HandleTurnCardOperate = 113300,
  ECCH_HandleMultiLineMissionSettle = 113400,
  ECCH_HandleMultiLineMissionGetReward = 113401,
  ECCH_HandleMultiLineSetMark = 113402,
  ECCH_HandlePickUpCoin = 113500,
  ECCH_HandleSubmitSimulationOperationStory = 113501,
  ECCH_HandleUpgradeArch = 113502,
  ECCH_HandleGetArchInfos = 113503,
  ECCH_HandleEightPetsChangeFormation = 113600,
  ECCH_HandleGetDispatchRewards = 113700,
  ECCH_HandleDispatch = 113701,
  ECCH_HandleSurveyClientDataReq = 113750,
  ECCH_HandlePersonProgressCollect = 113760,
  ECCH_HandleReceiveTimeLoginReward = 5000001,
  ECCH_HandleReceiveSmeltItemReward = 5000002,
  ECCH_HandleSeasonChangeFormation = 5000010,
  ECCH_HandleSeasonMissionMsg = 5000011,
  ECCH_HandleSeasonClientDataPoint = 5000012,
  ECCH_HandleSeasonClientStageData = 5000013,
  ECCH_HandleSeasonPointClientData = 5000014,
  ECCH_HandleSeasonMissionTeamRecord = 5000015,
  ECCH_HandleSeasonClientDataExt = 5000016,
  ECCH_HandleWeeklyChangeFormationReq = 5000020,
  ECCH_HandleCompleteTacitTestMission = 5000030,
  ECCH_HandleUpdateTacitTestAnswer = 5000031,
  ECCH_HandleDoVote = 5000041,
  ECCH_HandleGetZoneInfo = 5000042,
  ECCH_HandleRecallRefresh = 5000050,
  ECCH_HandleRecallFriend = 5000051,
  ECCH_HandleLinePopStarChangeFormation = 5000052,
  ECCH_HandleCompleteASheepMission = 5000060,
  ECCH_HandleCompleteLuckLandMission = 5000065,
  ECCH_HandleBalanceLuckLandMoney = 5000066,
  ECCH_HandleLuckLandGetRankList = 5000067,
  ECCH_HandleReceiveRandomLotteryCost = 5000100,
  ECCH_HandleRandomLotteryComponentDraw = 5000101,
  ECCH_HandleRandomLotteryComponentDrawReward = 5000103,
  ECCH_HandleBusinessSelectReq = 5000200,
  ECCH_HandleBusinessHarborReq = 5000201,
  ECCH_HandleBusinessShipReq = 5000202,
  ECCH_HandleBusinessHireSeamanReq = 5000203,
  ECCH_HandleBusinessWorkSeamanReq = 5000204,
  ECCH_HandleBusinessSailingReq = 5000205,
  ECCH_HandleOperateTalentTreeSkill = 5000300,
  ECCH_HandleTakeRewards = 5000400,
  ECCH_HandleDropCards = 5000401,
  ECCH_HandleSendCard = 5000402,
  ECCH_HandleClearSendCardInfo = 5000403,
  ECCH_HandleCompletePerfectPuzzle = 5000450,
  ECCH_HandleUnlockPerfectPuzzle = 5000451,
  ECCH_HandleSeasonMazeSelectHard = 5000500,
  ECCH_HandleSeasonMazeRandomHand = 5000501,
  ECCH_HandleSeasonMazeChooseHand = 5000502,
  ECCH_HandleSeasonMazeClearing = 5000503,
  ECCH_HandleSeasonMazeGoPoint = 5000504,
  ECCH_HandleSeasonMazeRoomEnd = 5000505,
  ECCH_HandleSeasonMazeChooseRelic = 5000506,
  ECCH_HandleSeasonMazeBattle = 5000507,
  ECCH_HandleSeasonMazeEvent = 5000508,
  ECCH_HandleSeasonMazeResource = 5000509,
  ECCH_HandleSeasonMazeOre = 5000510,
  ECCH_HandleSeasonMazeBox = 5000511,
  ECCH_HandleSeasonMazeRound = 5000512,
  ECCH_HandleSeasonMazeAltar = 5000513,
  ECCH_HandleSeasonMazeUseOnce = 5000514,
  ECCH_HandleSeasonMazeSaveLv = 5000515,
  ECCH_HandleSeasonMazeGetSlot = 5000516,
  ECCH_HandleSeasonMazeOperaSlot = 5000517,
  ECCH_HandleSeasonMazeNewHand = 5000518,
  ECCH_HandleSeasonMazeGetMarket = 5000519,
  ECCH_HandleSeasonMazeOperaMarket = 5000520,
  ECCH_HandleSeasonMazeRoundEnd = 5000521,
  ECCH_HandleSeasonMazeRecruitRoomSelectProp = 5000522,
  ECCH_HandleSeasonMazeRecruitRoomReflush = 5000523,
  ECCH_HandleSeasonMazeRecruitRoomSelect = 5000524,
  ECCH_HandleSeasonMazeRoomTransfer = 5000525,
  ECCH_HandleSeasonMazeBanPet = 5000526,
  ECCH_HandleSeasonMazeBanPetNoOpen = 5000527,
  ECCH_HandleSeasonMazeWhiteTest = 5000540,
  ECCH_HandleSeasonMazeChangeFormation = 5000550,
  ECCH_HandleSeasonMazeInitPetSelect = 5000551,
  ECCH_HandleSeasonMazeFitAutoBead = 5000553,
  ECCH_HandleSeasonMazeComposeAutoBead = 5000554,
  ECCH_HandleSeasonMazeHealthy = 5000555,
  ECCH_HandleSeasonMazeResurrectPet = 5000556,
  ECCH_HandleSeasonMazePetRecruitList = 5000557,
  ECCH_HandleSeasonMazePetRecruitSelect = 5000558,
  ECCH_HandleSeasonMazePetRecruitReset = 5000559,
  ECCH_HandleSeasonMazeSelectFullBreakPet = 5000560,
  ECCH_HandleSeasonMazeClearAllBeadNew = 5000561,
  ECCH_HandleAlchemyMakeup = 5000601,
  ECCH_HandleAlchemyShopSell = 5000602,
  ECCH_HandleAlchemyShopBuy = 5000603
}
_enum("ECampaignComHandle", ECampaignComHandle)
local CampaignErrorType = {
  E_CAMPAIGN_ERROR_TYPE_SUCCESS = 0,
  E_CAMPAIGN_ERROR_TYPE_FAILURE = 1,
  E_CAMPAIGN_ERROR_TYPE_DB_ERR = 2,
  E_CAMPAIGN_ERROR_TYPE_RMI = 100,
  E_CAMPAIGN_ERROR_TYPE_NET_ERROR = 101,
  E_CAMPAIGN_ERROR_TYPE_CONFIG_CHANGE = 102,
  E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_ID_ERROR = 104,
  E_CAMPAIGN_ERROR_TYPE_COMPONENT_ID_ERROR = 105,
  E_CAMPAIGN_ERROR_TYPE_COMPONENT_CONFIG_ERROR = 106,
  E_CAMPAIGN_ERROR_TYPE_COMPONENT_UNLOCK = 107,
  E_CAMPAIGN_ERROR_TYPE_Cross_Day = 108,
  E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_FINISHED = 109,
  E_CAMPAIGN_ERROR_TYPE_CAMPAIGN_NO_OPEN = 110,
  E_CAMPAIGN_ERROR_TYPE_OFFLINE_CONVERT_FAILED = 111,
  E_CAMPAIGN_ERROR_TYPE__NOT_SUPPORT_SET_REMIND = 120,
  E_CAMPAIGN_ERROR_TYPE_FIRE_EVENT_PARAM_ERROR = 121,
  E_CAMPAIGN_ERROR_TYPE_RMT_PLAYER_NOT_FOUND = 122,
  E_CAMPAIGN_ERROR_TYPE_RMI_ERROR = 123,
  E_CAMPAIGN_ERROR_TYPE_NOT_COMPLETE = 124,
  E_CAMPAIGN_ERROR_TYPE_COMPONENT_CLOSE = 125,
  E_CAMPAIGN_ERROR_TYPE_EXPEND_ITEM__FAILED = 126,
  E_CAMPAIGN_ERROR_TYPE_ADD_REWARD_FAILED = 127,
  E_CAMPAIGN_ERROR_TYPE_ALREADY_UNLOCK = 128,
  E_EXCHANGEITEM_COMPONENT_NOT_FOUND_ITEM = 2001,
  E_EXCHANGEITEM_COMPONENT_ITEM_LOCK = 2002,
  E_EXCHANGEITEM_COMPONENT_EXCHANGE_LIMIT = 2003,
  E_EXCHANGEITEM_COMPONENT_COST_ITEM_NOT_ENOUGH = 2004,
  E_EXCHANGEITEM_COMPONENT_EXPENDITEM_ERROR = 2005,
  E_EXCHANGEITEM_COMPONENT_ADDREWARD_ERROR = 2006,
  E_COMPONENT_CUMULATIVE_LOGIN_ERROR_DAY = 3001,
  E_COMPONENT_CUMULATIVE_LOGIN_DAY_NO_OPEN = 3002,
  E_COMPONENT_CUMULATIVE_LOGIN_RECEIVED = 3003,
  E_COMPONENT_CUMULATIVE_LOGIN_EXPIRED = 3004,
  E_COMPONENT_CUMULATIVE_LOGIN_LIMIT = 3005,
  E_COMPONENT_PersonProgress_Not_Exist_Progress = 4001,
  E_COMPONENT_PersonProgress_Reward_Received = 4002,
  E_COMPONENT_PersonProgress_Not_Reach_Progress = 4003,
  E_COMPONENT_PERSONPROGRESS_REQ_VALUE_ERROR = 4004,
  E_COMPONENT_PERSONPROGRESS_LV_ERROR = 4005,
  E_COMPONENT_MISSIONTEAMRECORD_REQNUM = 5001,
  E_COMPONENT_MISSIONTEAMRECORD_NODATA = 5002,
  E_COMPONENT_MISSIONTEAMRECORD_MAXNUM = 5003,
  E_COMPONENT_LINE_MISSIONTEAM_ERROR = 5501,
  E_COMPONENT_MINI_MAIL_REQ_ID_ERROR = 6001,
  E_COMPONENT_MINI_MAIL_READ_ERROR = 6002,
  E_COMPONENT_MINI_MAIL_LOCK_ERROR = 6003,
  E_COMPONENT_QUEST_NOT_REACH_RESET_TIME = 7001,
  E_COMPONENT_QUEST_NO_DAILY_TYPE = 7002,
  E_COMPONENT_QUEST_TAKE_ERROR = 7003,
  E_COMPONENT_STORY_IS_RECVED = 8001,
  E_COMPONENT_STORY_CAM_POINT_NOT_ENOUGH = 8002,
  E_COMPONENT_LOTTERY_COST_ITEM_NOT_ENOUGH = 9001,
  E_COMPONENT_LOTTERY_JACKPOT_LOTTERY_COUNT_NOT_ENOUGH = 9002,
  E_COMPONENT_LOTTERY_JACKPOT_LOCK = 9003,
  E_COMPONENT_LOTTERY_EXPEND_ITEM_ERROR = 9004,
  E_COMPONENT_LOTTERY_ADD_REWARD_ERROR = 9005,
  E_COMPONENT_CHALLENGE_REQ_CONFIG = 10001,
  E_COMPONENT_CHALLENGE_HAVE_DB = 10002,
  E_COMPONENT_PLAYERBACK_WAS_RECV_REWARD = 50001,
  E_COMPONENT_MINI_GAME_STORY_ALREADY_READ = 100001,
  E_COMPONENT_MINI_GAME_GRADE_ERROR = 100002,
  E_COMPONENT_MINI_GAME_REWARD_RECVE = 100003,
  E_COMPONENT_COMBAT_SIMULATOR_GIFT_ITEM_NOT_ENOUGH = 101001,
  E_COMPONENT_SUM_II_MISSION_MISSIONID_INVALID = 11001,
  E_COMPONENT_SUM_II_AFFIX_ID_INVALID = 11002,
  E_COMPONENT_SUM_II_AFFIX_TYPE_REPEAT = 11003,
  E_COMPONENT_SUM_II_MISSION_AFFIX_INVALID = 11004,
  E_COMPONENT_SUM_II_FORMATION_TYPE_INVALID = 11005,
  E_COMPONENT_SUM_II_FORMATION_INVALID = 11006,
  E_COMPONENT_SUM_II_MISSION_HARDID_INVALID = 11007,
  E_COMPONENT_LVREWARD_LEVEL_ERROR = 12001,
  E_COMPONENT_LVREWARD_REWARD_RECEIVED = 12002,
  E_COMPONENT_LVREWARD_LEVEL_NOT_REACHED = 12003,
  E_COMPONENT_LVREWARD_ADVANCED_LOCK = 12004,
  E_COMPONENT_LVREWARD_NO_REWARD_CAN_REVEIVE = 12005,
  E_COMPONENT_BUYGIFT_ID_ERROR = 13001,
  E_COMPONENT_BUYGIFT_NO_SALE_TIME = 13002,
  E_COMPONENT_BUYGIFT_BUY_COUNT_LIMIT = 13003,
  E_COMPONENT_BUYGIFT_BUY_COUNT_INVILID = 13004,
  E_COMPONENT_BUYGIFT_CURRENCY_NOT_ENOUGH = 13005,
  E_COMPONENT_ENTRUST_LEVEL_NOT_OPEN = 18001,
  E_COMPONENT_ENTRUST_ENTRUSTID_INVALID = 18002,
  E_COMPONENT_ENTRUST_EVENTID_INVALID = 18003,
  E_COMPONENT_ENTRUST_EVENT_COMPLETED = 18004,
  E_COMPONENT_ENTRUST_EVENT_NOT_OPEN = 18005,
  E_COMPONENT_ENTRUST_EVENT_LACKITEM = 18006,
  E_COMPONENT_ENTRUST_EVENT_MISSION_NOTSUCC = 18007,
  E_COMPONENT_ENTRUST_TEAM_INVALID = 18008,
  E_COMPONENT_ENTRUST_INTERACT_ERROR = 18009,
  E_COMPONENT_SUBJECT_LEVEL_UNREACH_OPENTIME = 102001,
  E_COMPONENT_SUBJECT_ILLEGAL_CONFIG = 102002,
  E_COMPONENT_SUBJECT_LEVEL_NOTFOUND = 102003,
  E_COMPONENT_SUBJECT_LEVEL_REWARDED = 102004,
  E_COMPONENT_SUBJECT_TEST_SCORE_LITTLE = 102005,
  E_COMPONENT_PUZZLE_MISSION_MISSIONID_INVALID = 19001,
  E_COMPONENT_PUZZLE_AFFIX_ID_INVALID = 19002,
  E_COMPONENT_PUZZLE_AFFIX_TYPE_REPEAT = 19003,
  E_COMPONENT_PUZZLE_MISSION_AFFIX_INVALID = 19004,
  E_COMPONENT_PUZZLE_UNREACH_UNLOCK_SCORE = 19005,
  E_COMPONENT_PUZZLE_FORMATION_ID = 19006,
  E_COMPONENT_PUZZLE_FORMATION_INFO = 19007,
  E_COMPONENT_PUZZLE_AFFIX_LOCK = 19008,
  E_COMPONENT_PUZZLE_AFFIX_NUM = 19009,
  E_COMPONENT_HOMELANDTASK_REQ_ID_ERROR = 20001,
  E_COMPONENT_HOMELANDTASK_UNLOCK = 20002,
  E_COMPONENT_HOMELANDTASK_UNCOMPLETE = 20003,
  E_COMPONENT_HOMELANDTASK_HAVEBEEN = 20004,
  E_COMPONENT_TIME_REWARD_ERROR_NOT_OPEN = 23001,
  E_COMPONENT_TIME_REWARD_RECEIVED = 23002,
  E_COMPONENT_EXCEEDED_MAX_TIMES = 103001,
  E_COMPONENT_SHAKE_TIMES_UNNORMAL = 103002,
  E_COMPONENT_SENIOR_SKIN_RESOURCE_NOT_ENOUGH = 103003,
  E_COMPONENT_SENIOR_SKIN_DELASSET_FALSE = 103004,
  E_COMPONENT_PointProgress_Not_Exist_Progress = 106001,
  E_COMPONENT_PointProgress_Reward_Received = 106002,
  E_COMPONENT_PointProgress_Not_Reach_Progress = 106003,
  E_COMPONENT_Bloodsucker_Talent_Point_Not_Enough = 107001,
  E_COMPONENT_Bloodsucker_Config_Error = 107002,
  E_COMPONENT_Bloodsucker_Codition_Not_Enough = 107003,
  E_COMPONENT_Bloodsucker_Select_Error = 107004,
  E_COMPONENT_Bloodsucker_skill_max_level = 107005,
  E_COMPONENT_IDOL_MAX_ROUND = 107050,
  E_COMPONENT_IDOL_TRAIN_ERROR = 107051,
  E_COMPONENT_IDOL_EVENT_ERROR = 107052,
  E_COMPONENT_IDOL_EVENT_EXIST = 107053,
  E_COMPONENT_IDOL_EVENT_MAX = 107054,
  E_COMPONENT_IDOL_EVENT_PRE_ERROR = 107055,
  E_COMPONENT_IDOL_EVENT_OPTION = 107056,
  E_COMPONENT_IDOL_ACTIVITY_ERROR = 107057,
  E_COMPONENT_IDOL_ACTIVITY_TIME_ERROR = 107058,
  E_COMPONENT_IDOL_ACTIVITY_LIMIT = 107059,
  E_COMPONENT_IDOL_ACHIEVE_ERROR = 107060,
  E_COMPONENT_IDOL_ACHIEVE_REWARDED = 107061,
  E_COMPONENT_IDOL_ENDING_ERROR = 107062,
  E_COMPONENT_IDOL_ENDING_LIMIT = 107063,
  E_COMPONENT_IDOL_ROUND_NO_OPEN = 107064,
  E_COMPONENT_IDOL_TRAIN_FUNS_ENOUGH = 107065,
  E_COMPONENT_IDOL_TRAIN_STATE_REPEAT = 107066,
  E_COMPONENT_IDOL_ROUND_ERROR = 107067,
  E_COMPONENT_IDOL_ACTIVITY_UNFINISH = 107068,
  E_COMPONENT_IDOL_TRAINTYPE_ERROR = 107069,
  E_COMPONENT_IDOL_EVENT_ID_ERROR = 107070,
  E_COMPONENT_IDOL_TRAIN_STATE_ERROR = 107071,
  E_COMPONENT_NEWYEAR_DINNER_FOOD_ERROR = 107100,
  E_COMPONENT_NEWYEAR_DINNER_FOOD_ACTIVED = 107101,
  E_COMPONENT_NEWYEAR_DINNER_ID_ERROR = 107102,
  E_COMPONENT_NEWYEAR_DINNER_UNFINISH = 107103,
  E_COMPONENT_NEWYEAR_DINNER_REWARDED = 107104,
  E_COMPONENT_NEWYEAR_DINNER_UNLOCK = 107105,
  E_COMPONENT_NEWYEAR_DINNER_ITEM_LECK = 107106,
  E_COMPONENT_MATCH_DIFFICULTY_CONFIG_ERROR = 107200,
  E_COMPONENT_BOUNCE_MISSION_ID_ERROR = 107300,
  E_COMPONENT_BOUNCE_MISSION_DATA_ERROR = 107301,
  E_COMPONENT_BOUNCE_MISSION_REWARD_ERROR = 107302,
  E_COMPONENT_BOUNCE_MISSION_REWARD_RECVED = 107303,
  E_COMPONENT_BOUNCE_MISSION_UNLOCK = 107304,
  E_COMPONENT_BOUNCE_MISSION_PRE_UNLOCK = 107305,
  E_COMPONENT_TURNCARD_INVALID_ITEM_ID = 107400,
  E_COMPONENT_TURNCARD_INVALID_TRUNCARD_ID = 107401,
  E_COMPONENT_TURNCARD_LACK_ITEM = 107402,
  E_COMPONENT_TURNCARD_INVALID_ITEM_INDEX = 107403,
  E_COMPONENT_TURNCARD_CELL_TURNED = 107404,
  E_COMPONENT_MULTILINE_MISSION_REWARDED = 107500,
  E_COMPONENT_MULTILINE_MISSION_FILESLECK = 107501,
  E_COMPONENT_MULTILINE_MISSION_FILES_ERROR = 107502,
  E_COMPONENT_EIGHT_PETS_MISSION_FORMATION_INVALID = 107600,
  E_COMPONENT_SURVEY_TOKENS_MAX_NUM = 107700,
  E_COMPONENT_SURVEY_TOKENS_CD_ERROR = 107701,
  E_COMPONENT_SURVEY_TRUST_ERROR = 107702,
  E_COMPONENT_TIMELOGIN_CFGID_ERROR = 5000001,
  E_COMPONENT_TIMELOGIN_STATE_ERROR = 5000002,
  E_COMPONENT_SMELTITEM_CFGID_ERROR = 5001001,
  E_COMPONENT_SMELTITEM_STATE_ERROR = 5001002,
  E_COMPONENT_SMELTITEM_FEWITEM_ERROR = 5001003,
  E_COMPONENT_RANDOMLOTTERY_CFGID_ERROR = 5001101,
  E_COMPONENT_RANDOMLOTTERY_FEWITEM_ERROR = 5001102,
  E_COMPONENT_RANDOMLOTTERY_DIAMOND_ERROR = 5001103,
  E_COMPONENT_RANDOMLOTTERY_RANDOMTYPE_ERROR = 5001104,
  E_COMPONENT_RANDOMLOTTERY_RANDOMID_ERROR = 5001105,
  E_COMPONENT_RANDOMLOTTERY_GET_REWARD_ERROR = 5001106,
  E_COMPONENT_SEASON_MISSIONID_INVALID = 5002001,
  E_COMPONENT_SEASON_FORMATION_INVALID = 5002002,
  E_COMPONENT_SEASON_PREMISSIONNOTPASS = 5002003,
  E_COMPONENT_SEASON_CANNOTREPEATEFIGHT = 5002004,
  E_COMPONENT_SEASON_OTHERCFG_INVALID = 5002005,
  E_COMPONENT_SEASON_ITEM_FEW = 5002006,
  E_COMPONENT_SEASON_REQDATA_ERROR = 5002007,
  E_COMPONENT_LUCKLAND_DATA_ERROR = 5004501,
  E_COMPONENT_LUCKLAND_BUILD_ERROR = 5004502,
  E_COMPONENT_BUSINESS_CFG_ERROR = 5005001,
  E_COMPONENT_BUSINESS_LOCK_ERROR = 5005002,
  E_COMPONENT_BUSINESS_REQ_ERROR = 5005003,
  E_COMPONENT_BUSINESS_ITEM_FEW_ERROR = 5005004,
  E_COMPONENT_BUSINESS_SEAMAN_HAVE_ERROR = 5005005,
  E_COMPONENT_BUSINESS_SEAMAN_NO_ERROR = 5005006,
  E_COMPONENT_BUSINESS_SEAMAN_NOCHANGE_ERROR = 5005007,
  E_COMPONENT_BUSINESS_EVENT_ERROR = 5005008,
  E_COMPONENT_BUSINESS_EVENTCFG_ERROR = 5005009,
  E_COMPONENT_BUSINESS_OPCFG_ERROR = 5005010,
  E_COMPONENT_BUSINESS_INCOME_ERROR = 5005011,
  E_COMPONENT_BUSINESS_CDCALC_ERROR = 5005012,
  E_COMPONENT_BUSINESS_CDEND_ERROR = 5005013,
  E_COMPONENT_TALENT_TREE_NEEDCOST_ERROR = 5005501,
  E_COMPONENT_TALENT_TREE_BUY_ITEM_ERROR = 5005502,
  E_COMPONENT_TALENT_TREE_BUY_MAIN_ERROR = 5005503,
  E_COMPONENT_TALENT_TREE_UPGRADE_FULL = 5005504,
  E_COMPONENT_TALENT_TREE_UPGRADE_ERROR = 5005505,
  E_COMPONENT_TALENT_TREE_SOLT_ERROR = 5005506,
  E_COMPONENT_PERFECT_PUZZLE_ITEM_NOT_ENOUGH = 5005601,
  E_COMPONENT_PERFECT_PUZZLE_SCORE_ERROR = 5005602,
  E_COMPONENT_SEASON_MAZE_HAVE_HARD = 5006101,
  E_COMPONENT_SEASON_MAZE_NOFIND_HARD = 5006102,
  E_COMPONENT_SEASON_MAZE_NOLOCK_HARD = 5006103,
  E_COMPONENT_SEASON_MAZE_REQ_POINT_SURPLUS = 5006104,
  E_COMPONENT_SEASON_MAZE_REQ_CFG_POINT = 5006105,
  E_COMPONENT_SEASON_MAZE_ERROR_POINT = 5006106,
  E_COMPONENT_SEASON_MAZE_CHOOSE_RELIC = 5006107,
  E_COMPONENT_SEASON_MAZE_RAND_HAND = 5006108,
  E_COMPONENT_SEASON_MAZE_UP_ERROR = 5006109,
  E_COMPONENT_SEASON_MAZE_NO_CFG = 5006110,
  E_COMPONENT_SEASON_MAZE_DO_BOSS = 5006111,
  E_COMPONENT_SEASON_MAZE_ROOM_STATE = 5006112,
  E_COMPONENT_SEASON_MAZE_CLEARING = 5006113,
  E_COMPONENT_SEASON_MAZE_ROOM_TYPE = 5006114,
  E_COMPONENT_SEASON_MAZE_NO_RELIC_E = 5006115,
  E_COMPONENT_SEASON_MAZE_NO_MS = 5006116,
  E_COMPONENT_SEASON_MAZE_ROOM_DATA = 5006117,
  E_COMPONENT_SEASON_MAZE_PET_DATA = 5006118,
  E_COMPONENT_SEASON_MAZE_DOT_RELIC = 5006119,
  E_COMPONENT_SEASON_MAZE_NO_ITEM = 5006120,
  E_COMPONENT_SEASON_MAZE_BOMB = 5006121,
  E_COMPONENT_SEASON_MAZE_NO_GOLD = 5006122,
  E_COMPONENT_SEASON_MAZE_ALL_HAND = 5006123,
  E_COMPONENT_SEASON_MAZE_FEW_PRO = 5006124,
  E_COMPONENT_SEASON_MAZE_MAXLV = 5006125,
  E_COMPONENT_SEASON_MAZE_BUY = 5006126,
  E_COMPONENT_SEASON_NORELIC_GROUP = 5006127,
  E_COMPONENT_SEASON_ERROR_STATE = 5006128,
  E_COMPONENT_SEASON_ERROR_OVER = 5006129,
  E_COMPONENT_SEASON_NO_HARD = 5006130,
  E_COMPONENT_SEASON_RECRUIT_ROOM_PROP_SELECTED = 5006131,
  E_COMPONENT_SEASON_MAZE_BanPet_Max = 5006132,
  E_COMPONENT_SEASON_MAZE_PetBan = 5006133,
  E_COMPONENT_SEASON_MAZE_INITSELECT_PET_INVILD = 5006501,
  E_COMPONENT_SEASON_MAZE_INITSELECT_PET_REPEAT = 5006502,
  E_COMPONENT_SEASON_MAZE_INITSELECT_FINISH = 5006503,
  E_COMPONENT_SEASON_MAZE_FORMATION_INVALID = 5006504,
  E_COMPONENT_SEASON_MAZE_BEAD_ID_ERR = 5006505,
  E_COMPONENT_SEASON_MAZE_BEAD_SLOT_POS_UNLOCK = 5006506,
  E_COMPONENT_SEASON_MAZE_BEAD_COMPOSE_MAX_LEVEL = 5006507,
  E_COMPONENT_SEASON_MAZE_BEAD_SLOT_MAX = 5006508,
  E_COMPONENT_SEASON_MAZE_MoneyDeficit = 5006509,
  E_COMPONENT_SEASON_MAZE_AllPetFullBlood = 5006510,
  E_COMPONENT_SEASON_MAZE_PetAlive = 5006511,
  E_COMPONENT_SEASON_MAZE_Pet_INVALID = 5006512,
  E_COMPONENT_SEASON_MAZE_Recruit_PetNotInList = 5006513,
  E_COMPONENT_SEASON_MAZE_Recruit_Err = 5006514,
  E_COMPONENT_SEASON_MAZE_BEAD_Pos_ERR = 5006515,
  E_COMPONENT_SEASON_MAZE_Recruit_Repeat = 5006516,
  E_COMPONENT_SEASON_MAZE_BEAD_Repeat = 5006517,
  E_COMPONENT_SEASON_MAZE_INITSELECT_PET_CNT_ERR = 5006518,
  E_COMPONENT_SEASON_MAZE_Pet_Status_Err = 5006519,
  E_COMPONENT_SEASON_MAZE_BeadNotOpen = 5006520,
  E_COMPONENT_SEASON_MAZE_BeadUnLock = 5006521,
  E_COMPONENT_ALCHEMY_ERR = 5007000,
  E_COMPONENT_ALCHEMY_ITEM_ERR = 5007001,
  E_COMPONENT_ALCHEMY_FORMULA_CFGERR = 5007002,
  E_COMPONENT_ALCHEMY_FORMULA_UNLOCK = 5007003,
  E_COMPONENT_ALCHEMY_FORMULA_ITEM_NOTENOUGH = 5007004,
  E_COMPONENT_ALCHEMY_ITEM_NOTENOUGH = 5007005,
  E_COMPONENT_ALCHEMY_BUY_ID_ERR = 5007006,
  E_COMPONENT_ALCHEMY_FORMULA_HAVE = 5007007,
  E_COMPONENT_ALCHEMY_MONEY_NOTENOUGH = 5007008,
  E_COMPONENT_ALCHEMY_SHOP_LEVEL_LOW = 5007009
}
_enum("CampaignErrorType", CampaignErrorType)
local CampaignOfflineDataType = {CAMPAIGN_OMT_INVALID = 0}
_enum("CampaignOfflineDataType", CampaignOfflineDataType)
local CampainExtendKey = {
  E_CAMPAIGN_EXTEND_KEY_INT_BEGIN = 0,
  E_CAMPAIGN_EXTEND_KEY_FIRST_ENTER_STROY = 1,
  E_CAMPAIGN_EXTEND_KEY_NEED_MISSION_ID = 2,
  E_CAMPAIGN_EXTEND_KEY_CUMULATIVE_LOGIN_COMPLATE = 3,
  E_CAMPAIGN_EXTEND_KEY_POINT_PROGRESS = 4,
  E_CAMPAIGN_EXTEND_KEY_COMPLETE_COND = 5,
  E_CAMPAIGN_EXTEND_KEY_TIME_BEGIN = 1000000,
  E_CAMPAIGN_EXTEND_KEY_NEXT_REFRESH_TIME = 1000001
}
_enum("CampainExtendKey", CampainExtendKey)
local CampainMissionCanSerialAutoFightType = {
  E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_DISABLE = 0,
  E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_ENABLE = 1,
  E_CAMPAIGN_MISSION_CAN_SERIAL_AUTO_FIGHT_NEED_UNLOCK = 2
}
_enum("CampainMissionCanSerialAutoFightType", CampainMissionCanSerialAutoFightType)
local CampainMissionCanAutoFightType = {
  E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_DISABLE = 0,
  E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_ENABLE = 1,
  E_CAMPAIGN_MISSION_CAN_AUTO_FIGHT_NEED_UNLOCK = 2
}
_enum("CampainMissionCanAutoFightType", CampainMissionCanAutoFightType)
_class("ICampaignComponentDataInfo", Object)
ICampaignComponentDataInfo = ICampaignComponentDataInfo

function ICampaignComponentDataInfo:Constructor()
  self.m_component_type = 0
  self.m_component_id = 0
  self.m_component_step = 0
end

ICampaignComponentDataInfo._proto = {
  [1] = {
    "m_component_type",
    "int"
  },
  [2] = {
    "m_component_id",
    "int"
  },
  [3] = {
    "m_component_step",
    "int"
  }
}
_class("ICampaignDataInfoImpl", ICampaignComponentDataInfo)
ICampaignDataInfoImpl = ICampaignDataInfoImpl

function ICampaignDataInfoImpl:Constructor()
end

ICampaignDataInfoImpl._proto = {}
_class("campaign_data_extend_info", Object)
campaign_data_extend_info = campaign_data_extend_info

function campaign_data_extend_info:Constructor()
  self.m_db_data_map = {}
  self.is_review_unlock = false
  self.m_unserialize_flag = false
  self.m_dirty_set = {}
end

campaign_data_extend_info._proto = {
  [1] = {
    "m_db_data_map",
    "map<int,buffer>"
  },
  [2] = {
    "is_review_unlock",
    "bool"
  }
}
_class("campaign_data_info", Object)
campaign_data_info = campaign_data_info

function campaign_data_info:Constructor()
  self.pstid = 0
  self.id = 0
  self.step = 0
  self.accept_time = 0
  self.last_load_time = 0
  self.extends = ""
  self.extend_info = campaign_data_extend_info:New()
end

campaign_data_info._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"id", "int"},
  [3] = {"step", "int"},
  [4] = {
    "accept_time",
    "time"
  },
  [5] = {
    "last_load_time",
    "time"
  },
  [6] = {"extends", "buffer"}
}
_class("campaign_sample", Object)
campaign_sample = campaign_sample

function campaign_sample:Constructor()
  self.id = 0
  self.name = ""
  self.begin_time = 0
  self.end_time = 0
  self.camp_type = 0
  self.config_version = 0
  self.is_open = false
  self.index = 0
  self.status_prompt = false
  self.step = 0
  self.extend_data = ""
  self.accept_tag = 0
  self.constant_after_accept_sec = 0
  self.m_extend_info = {}
  self.m_extend_info_time = {}
  self.is_unlock = false
  self.m_join_old = false
  self.m_join_end = false
  self.m_is_component_open = 0
  self.m_components_step = 0
end

function campaign_sample:FromProcess(cp)
  self.id = cp.id
  self.camp_type = cp.type
  self.step = cp.step
end

function campaign_sample:GetStepStatus(step)
  return self.step & step > 0 and self.is_open
end

function campaign_sample:IsCompOpen(compID)
  return self.m_is_component_open & 1 << compID > 0
end

function campaign_sample:IsCompRed(compID)
  return self.m_components_step & 1 << compID > 0
end

function campaign_sample:to_string()
  return "CampaignSample id" .. self.id .. ", type" .. self.camp_type
end

function campaign_sample:IsShow(spe_time)
  if self.end_time ~= 0 and spe_time >= self.end_time then
    return false
  end
  if spe_time < self.begin_time then
    return false
  end
  return true
end

campaign_sample._proto = {
  [1] = {"id", "int"},
  [2] = {"name", "string"},
  [3] = {"begin_time", "time"},
  [4] = {"end_time", "time"},
  [5] = {"camp_type", "int"},
  [6] = {
    "config_version",
    "int"
  },
  [7] = {"is_open", "bool"},
  [8] = {"index", "int"},
  [9] = {
    "status_prompt",
    "bool"
  },
  [10] = {"step", "int"},
  [11] = {
    "extend_data",
    "string"
  },
  [12] = {"accept_tag", "int"},
  [13] = {
    "constant_after_accept_sec",
    "int"
  },
  [14] = {
    "m_extend_info",
    "map<int,int>"
  },
  [15] = {
    "m_extend_info_time",
    "map<int,time>"
  },
  [16] = {"is_unlock", "bool"},
  [17] = {"m_join_old", "bool"},
  [18] = {"m_join_end", "bool"},
  [19] = {
    "m_is_component_open",
    "int"
  },
  [20] = {
    "m_components_step",
    "int"
  }
}
_class("CampaignComponentLoadInfo", Object)
CampaignComponentLoadInfo = CampaignComponentLoadInfo

function CampaignComponentLoadInfo:Constructor()
  self.m_campaign_id = 0
  self.m_com_id = 0
  self.m_com_type = 0
  self.m_component_step = 0
  self.m_b_unlock = false
  self.m_unlock_time = 0
  self.m_data = ""
  self.m_unlock_items = {}
  self.m_open_time = 0
  self.m_close_time = 0
  self.m_need_mission_type = 0
  self.m_need_mission_id = 0
  self.m_first_story_id = 0
end

CampaignComponentLoadInfo._proto = {
  [1] = {
    "m_campaign_id",
    "int"
  },
  [2] = {"m_com_id", "int"},
  [3] = {"m_com_type", "int"},
  [4] = {
    "m_component_step",
    "int"
  },
  [5] = {"m_b_unlock", "bool"},
  [6] = {
    "m_unlock_time",
    "time"
  },
  [7] = {"m_data", "buffer"},
  [8] = {
    "m_unlock_items",
    "list<RoleAsset>"
  },
  [9] = {
    "m_open_time",
    "time"
  },
  [10] = {
    "m_close_time",
    "time"
  },
  [11] = {
    "m_need_mission_type",
    "int"
  },
  [12] = {
    "m_need_mission_id",
    "int"
  },
  [13] = {
    "m_first_story_id",
    "int"
  }
}
_class("CampaignLoadInfo", Object)
CampaignLoadInfo = CampaignLoadInfo

function CampaignLoadInfo:Constructor()
  self.m_server_time = 0
  self.m_sample_info = campaign_sample:New()
  self.m_data_dict = {}
  self.m_campaign_common_config = {}
end

CampaignLoadInfo._proto = {
  [1] = {
    "m_server_time",
    "time"
  },
  [2] = {
    "m_sample_info",
    "campaign_sample"
  },
  [3] = {
    "m_data_dict",
    "map<int,CampaignComponentLoadInfo>"
  },
  [4] = {
    "m_campaign_common_config",
    "map<string,string>"
  }
}
_class("CCampaignOnEventFireReturn", Object)
CCampaignOnEventFireReturn = CCampaignOnEventFireReturn

function CCampaignOnEventFireReturn:Constructor()
  self.m_campaign_id = 0
  self.m_campaign_type = 0
  self.m_component_id = 0
  self.m_component_type = 0
  self.ret = 0
end

CCampaignOnEventFireReturn._proto = {
  [1] = {
    "m_campaign_id",
    "int"
  },
  [2] = {
    "m_campaign_type",
    "int"
  },
  [3] = {
    "m_component_id",
    "int"
  },
  [4] = {
    "m_component_type",
    "int"
  },
  [5] = {"ret", "int"}
}
_class("campaign_process", Object)
campaign_process = campaign_process

function campaign_process:Constructor()
  self.id = 0
  self.step = 0
  self.type = 0
end

function campaign_process:to_string()
  return "campaign_process[id:" .. self.id .. ", step:" .. self.step .. ", type:" .. self.type .. "]"
end

campaign_process._proto = {
  [1] = {"id", "int"},
  [2] = {"step", "int"},
  [3] = {"type", "int"}
}
_class("ICampaignNotifyDataInfo", Object)
ICampaignNotifyDataInfo = ICampaignNotifyDataInfo

function ICampaignNotifyDataInfo:Constructor()
  self.m_notify_type = 0
  self.m_data = ""
end

ICampaignNotifyDataInfo._proto = {
  [1] = {
    "m_notify_type",
    "int"
  },
  [2] = {"m_data", "buffer"}
}
_class("ICampaignOfflineDataInfo", Object)
ICampaignOfflineDataInfo = ICampaignOfflineDataInfo

function ICampaignOfflineDataInfo:Constructor()
  self.campaign_id = 0
  self.component_id = 0
  self.component_type = 0
  self.offline_type = 0
  self.m_data = ""
end

ICampaignOfflineDataInfo._proto = {
  [1] = {
    "campaign_id",
    "int"
  },
  [2] = {
    "component_id",
    "int"
  },
  [3] = {
    "component_type",
    "int"
  },
  [4] = {
    "offline_type",
    "int"
  },
  [5] = {"m_data", "buffer"}
}
_class("campaign_mtr_role", Object)
campaign_mtr_role = campaign_mtr_role

function campaign_mtr_role:Constructor()
  self.pstid = 0
  self.nick = ""
  self.head_image_id = 0
  self.head_head_color = 0
  self.head_frame_id = 0
  self.team = {}
end

campaign_mtr_role._proto = {
  [1] = {"pstid", "int64"},
  [2] = {"nick", "string"},
  [3] = {
    "head_image_id",
    "int"
  },
  [4] = {
    "head_head_color",
    "int"
  },
  [5] = {
    "head_frame_id",
    "int"
  },
  [6] = {
    "team",
    "list<tower_pass_pet_info>"
  }
}
