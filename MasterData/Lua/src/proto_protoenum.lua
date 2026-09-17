L_Const = L_Const or {}
L_Const.AbyssModeType = {
  ABYSS_MODE_NULL = 0,
  ABYSS_MODE_NEWER = 1,
  ABYSS_MODE_PERSISTANT = 2,
  ABYSS_MODE_ROTATION = 3
}
L_Const.ChallengeTaskStatus = {
  CHALLENGE_TASK_STATUS_NONE = 0,
  CHALLENGE_TASK_STATUS_IN_PROGRESS = 1,
  CHALLENGE_TASK_STATUS_COMPLETED = 2,
  CHALLENGE_TASK_STATUS_FAILED = 3
}
L_Const.ActivityType = {
  AT_SIGN = 1,
  AT_Main = 2,
  AT_DAILY_SIGN = 3,
  AT_Level = 7,
  AT_Kibo_Tour_Group = 8,
  AT_KIBO_DUEL = 20,
  AT_SUBMIT_ITEM_TASK = 30,
  AT_DOUBLE_DROP = 40,
  AT_PARTY = 50,
  AT_GROWUP = 60,
  AT_NDAY = 70,
  AT_JADEGAME_WEB = 80,
  AT_Companion = 90,
  AT_REPEAT_EVENT = 100,
  AT_TeachingUp = 110,
  AT_JOURNEY = 120,
  AT_KIBO_GRAB = 130,
  AT_SUNSET = 131,
  AT_APP_SHARE = 140,
  AT_Only_Show = 998,
  AT_DAILY_TASK = 999
}
L_Const.ActivityTimeType = {ATT_NORAML = 0, ATT_CYCLE = 1}
L_Const.ActivityTaskState = {
  KDT_NONE = 0,
  KDT_GUIDE = 1,
  KDT_END = 2
}
L_Const.ActivityRewardState = {
  ARS_NONE = 0,
  ARS_FINISH = 1,
  ARS_REWARDED = 2
}
L_Const.CommonState = {
  CS_NONE = 0,
  CS_ACCEPT = 1,
  CS_FINISH = 2
}
L_Const.GrowUpStage = {
  GUS_Primary = 1,
  GUS_Middle = 2,
  GUS_Advanced = 3,
  GUS_Endless = 4
}
L_Const.ActivityGrowUpTrainAttrType = {
  ATTR_STRENGTH = 101,
  ATTR_BODY = 102,
  ATTR_REALIZE = 103,
  ATTR_WAKAN = 104
}
L_Const.GROWUP_EVENT_TYPE = {
  GROWUP_NONE = 0,
  GROWUP_STAMINA_ADD = 1,
  GROWUP_STAMINA_REDUCE = 2,
  GROWUP_TRAINING_ADD = 3,
  GROWUP_TRAINING_REDUCE = 4,
  GROWUP_MOOD_LEVEL = 5,
  GROWUP_MOOD_DOWN = 6,
  GROWUP_GETONE_FEATURES = 7,
  GROWUP_RANDONE_FEATURES = 8,
  GROWUP_RANDOM_FEATURES = 9,
  GROWUP_GETONE_STATUS = 10,
  GROWUP_RANDONE_STATUS = 11,
  GROWUP_RANDOM_STATUS = 12,
  GROWUP_BONDS_ADD = 13,
  GROWUP_ACTIVATE_HERO = 14,
  GROWUP_TRAINING_ADD_PER = 15,
  GROWUP_TOUZI_ADD = 16,
  GROWUP_TOUZI_REDUCE = 17,
  GROWUP_BUILD_UP = 18,
  GROWUP_EVENT_ATTR_ADD = 19,
  GROWUP_EVENT_ATTR_REDUCE = 20,
  GROWUP_TRIAL_ATTR_ADD = 21,
  GROWUP_TRIAL_ATTR_REDUCE = 22,
  GROWUP_FAIL_RATE_REDUDE = 23,
  GROWUP_STAMINA_USE_REDUCE = 24,
  GROWUP_BOND_ENHANCE = 25,
  GROWUP_EVENT_ENHANCE = 26,
  GROWUP_STAMINA_RECOVER_INCREASE = 27,
  GROWUP_TRIAL_ENHANCE = 28,
  GROWUP_UNLOCK_EVENT = 29,
  GROWUP_MAX = 30
}
L_Const.GROWUP_ATTR_CHANGE_TYPE = {
  GROWUP_ATTR_CHANGE_NONE = 0,
  GROWUP_ATTR_CHANGE_TRAIN = 1,
  GROWUP_ATTR_CHANGE_EVENT = 2,
  GROWUP_ATTR_CHANGE_TRIAL = 3,
  GROWUP_ATTR_CHANGE_MAX = 4
}
L_Const.RANK_TYPE = {
  RT_INVALID = 0,
  RT_ACTIVITY_ENDLESS = 1,
  RT_ACTIVITY_REPET_EVENT = 2
}
L_Const.GrowUpEndStateType = {
  GROWUP_END_INVALID = 0,
  GROWUP_END_COMPLETE = 1,
  GROWUP_END_UNCOMPLETE = 2,
  GROWUP_END_UNLOCK = 3
}
L_Const.GrowUpAssistChangeType = {
  GROWUP_ASSIST_CHANGE_INVALID = 0,
  GROWUP_ASSIST_CHANGE_STARTING = 1,
  GROWUP_ASSIST_CHANGE_EVENT = 2,
  GROWUP_ASSIST_CHANGE_TRAIN = 3,
  GROWUP_ASSIST_CHANGE_REST = 4
}
L_Const.BattleType = {BT_SINGLE = 0, BT_TEAM = 1}
L_Const.BattleEntryType = {
  BET_COMPAIGN = 1,
  BET_ROUGUE = 2,
  BET_TOWER = 3,
  BET_INTERIMER = 4,
  BET_BATTLE_COMPAIGN = 5
}
L_Const.BattleEnemyLevelPolicyType = {
  BELPT_WORLD_DIFFICULT = 1,
  BELPT_FIX = 2,
  BELPT_DUNGEON = 3,
  BELPT_TASK = 4
}
L_Const.WorldMapActionType = {
  WMAT_JUMP = 1,
  WMAT_DASH = 2,
  WMAT_SKILL = 3
}
L_Const.FightObjType = {
  FO_None = 0,
  FO_Hero = 1,
  FO_Pet = 2,
  FO_Monster = 3,
  FO_Task_Monster = 4,
  FO_Trial_Hero = 5,
  FO_Puzzle_Obj = 6,
  FO_Puzzle_Monster = 7,
  FO_Tranform = 8,
  FO_Trial_Pet = 9,
  FO_Transform_Pet = 14,
  FO_KiboDuel_Trial_Pet = 15,
  FO_Bullet = 16,
  FO_Summoner = 17,
  FO_Rogue_Hero = 18,
  FO_Rogue_Pet = 19,
  FO_KiboDuel_Pet = 20,
  FO_KiboDuel_Tower = 21,
  FO_KiboDuel_ThisClam = 22,
  FO_Bot_Hero = 23,
  FO_Player = 24,
  FO_MobMonster = 25,
  FO_MapItem = 26,
  FO_Copy_Hero = 27,
  FO_Party_KiboCard = 28,
  FO_Dungeon_Item = 29,
  FO_Abyss_Hero = 30,
  FO_Abyss_Pet = 31
}
L_Const.FightObjSourceType = {FOST_WORLD = 0, FOST_TASK = 1}
L_Const.SkillResultType = {
  SRT_DAMAGE = 1,
  SRT_HEAL = 2,
  SRT_BUFF = 3
}
L_Const.FightObjState = {
  FOS_Normal = 1,
  FOS_Fight = 2,
  FOS_Reset = 3
}
L_Const.HeroAttrModuleType = {
  HAMT_HERO_BASIC = 0,
  HAMT_SOULESSENCE = 1,
  HAMT_ORNAMENT = 2,
  HAMT_WORLD_BUFF = 3,
  HAMT_PET_INHERENT = 4,
  HAMT_PET_GEN = 5,
  HAMT_PET_SPEED = 6,
  HAMT_ELEMENT = 7,
  HAMT_GLOBAL_BONUS = 8,
  HAMT_HERO_PLAYBALE = 9,
  HAMT_HERO_GRADE = 10
}
L_Const.ModuleGamingType = {MGT_WORLD_BATTLE = 0, MGT_KIBO_DUEL = 1}
L_Const.BuffOperator = {
  BuffOpe_Add = 1,
  BuffOpe_Del = 2,
  BuffOpe_Chg = 3,
  BuffOpe_RND = 4,
  BuffOpe_LOG = 5,
  BuffOpe_CleanData = 6,
  BuffOpe_Combine = 7,
  BuffOpe_DotDoExecute = 8,
  BuffOpe_DotDoEnd = 9,
  BuffOpe_RemoteAdd = 10
}
L_Const.SkillVerifyType = {
  SkillVerifyType_None = 0,
  SkillVerifyType_Skill = 1,
  SkillVerifyType_Elem = 2,
  SkillVerifyType_Bullet = 3,
  SkillVerifyType_Summon = 4,
  SkillVerifyType_Behavior = 5,
  SkillVerifyType_System = 6,
  SkillVerifyType_GM = 7,
  SkillVerifyType_HeroGrade = 8,
  SkillVerifyType_Equip = 9,
  SkillVerifyType_SMonster = 10,
  SkillVerifyType_MapItem = 11,
  SkillVerifyType_SAdd = 12
}
L_Const.FightFinishStatus = {
  FFS_Success = 0,
  FFS_Fail = 1,
  FFS_Escape = 2,
  FFS_Timeout = 3
}
L_Const.FightRewardReason = {FRR_Kill = 0, FRR_Catch = 1}
L_Const.HeroBattleInfoSyncReason = {
  HBISR_COMMON = 0,
  HBISR_TRANS_POINT = 1,
  HBISR_ACED = 2,
  HBISR_CHARGE = 3,
  HBISR_DUNGEON_ENTRUST = 4,
  HBISR_FSM_FIGHT_TO_NORMAL = 5
}
L_Const.GetCatchPetInfoReason = {GCPIR_SCAN = 1, GCPIR_CATCH = 2}
L_Const.BattleSkillOp = {
  RELEASE = 1,
  CHANGE_CD = 2,
  STOP = 3,
  INTERUPT = 4
}
L_Const.BattleEntityOp = {
  ADD = 1,
  DEAD = 2,
  DEL = 3
}
L_Const.DamageTagMask = {
  DamageTagMask_None = 0,
  DamageTagMask_Heal = 1,
  DamageTagMask_Critical = 2
}
L_Const.SummonType = {
  monster = 1,
  item = 2,
  independent = 3,
  kibo_pet = 4,
  kibo_monster = 5
}
L_Const.DungeonItemType = {DIT_INVALID = 0, DIT_PARTY_KIBO_CARD = 1}
L_Const.EEntityScene = {
  None = 0,
  Battle = 1,
  World = 2,
  BattlePerform = 3
}
L_Const.ElementSwapSource = {ESS_DEFAULT = 0, ESS_SERVER = 1}
L_Const.ElementSyncReason = {
  ESR_None = 0,
  ESR_HeroGrade = 1,
  ESR_EnterMap = 2,
  ESR_ChangeGroup = 3
}
L_Const.BlackboardValueType = {
  Int = 0,
  Float = 1,
  Bool = 2,
  Vector3 = 3,
  Entity = 4
}
L_Const.ElemSourceBehaviorType = {
  ElemSourceBehaviorType_None = 0,
  ElemSourceBehaviorType_SkillId = 1,
  ElemSourceBehaviorType_SkillIndex = 2,
  ElemSourceBehaviorType_ElemConfigId = 3,
  ElemSourceBehaviorType_BulletUid = 4
}
L_Const.Status = {
  INVALID = 0,
  START = 1,
  STOP = 2
}
L_Const.BattlePassTaskType = {
  BattlePassTaskType_DAY = 1,
  BattlePassTaskType_WEEK = 2,
  BattlePassTaskType_FOREVER = 3,
  BattlePassTaskType_INVALID = 4
}
L_Const.TaskState = {
  BEGIN = 0,
  FINISH = 1,
  REWARD = 2,
  EXPIRED = 3,
  INVALID = 4
}
L_Const.ActType = {
  EAT_NONE = 0,
  EAT_LOSE = 1,
  EAT_WIN = 2,
  EAT_QUIT = 3
}
L_Const.ItemActType = {
  IAT_ADD = 1,
  IAT_PUT = 2,
  IAT_PLANT = 3,
  IAT_AUTOWORKSTORE = 4
}
L_Const.HouseItemType = {HIT_BUILD = 1, HIT_SEED = 2}
L_Const.AnitCheatType = {
  BACT_None = 0,
  BACT_AttackDistance = 1,
  BACT_SkillCD = 2,
  BACT_PetDuelSummon = 3,
  BACT_MoveCheck = 4,
  BACT_InteractAttackCheck = 5,
  BACT_InteractDistance = 6,
  BACT_CatchPetCheck = 7,
  BACT_BattleCheck = 8,
  BACT_DamageCheck = 9,
  BACT_FightBreakTime = 10,
  BACT_BTTreeCheck = 11,
  BACT_Count = 12,
  BACT_DungeonPassError = 13
}
L_Const.BattleVerifyErrCode = {
  None = 0,
  CreateIndex = 1,
  SourceIndex = 2,
  SourceData = 3
}
L_Const.MutationType = {MT_cost_stamina = 1}
L_Const.PlatformType = {
  PFT_PC = 0,
  PFT_Andriod = 1,
  PFT_IOS = 2,
  PFT_PS5 = 3,
  PFT_HARMONY = 4,
  PFT_Web = 100
}
L_Const.EnterGameType = {
  EGT_Normal = 1,
  EGT_Reconnect = 2,
  EGT_Refresh = 3
}
L_Const.FriendChangeType = {
  FriendChangeTypeNone = 0,
  Add2FriendList = 1,
  Add2BlackList = 2,
  Add2ApplyList = 4,
  DelFromFriendList = 8,
  DelFromBlackList = 16,
  DelFromApplyList = 32,
  ClearApplyList = 64
}
L_Const.FriendOPType = {
  FOL_None = 0,
  FOL_Friend = 1,
  FOL_Apply = 2,
  FOL_Ban = 3
}
L_Const.FriendOPVal = {
  FOT_None = 0,
  FOT_Add = 1,
  FOT_Del = 2,
  FOT_AllAgree = 3,
  FOT_AllDel = 4
}
L_Const.ChatType = {
  CT_PersonType = 0,
  CT_GroupType = 1,
  CT_WorldType = 2,
  CT_MapType = 3
}
L_Const.CampaignStatusType = {
  CST_NONE = 0,
  CST_QUIT = 1,
  CST_START = 2,
  CST_WIN = 3,
  CST_LOSE = 4,
  CST_FINISH_QUIT = 5,
  CST_LOSE_QUIT = 6,
  CST_PAUSE_QUIT = 7
}
L_Const.CampaignSceneStatusType = {CSST_NORMAL = 0, CSST_FINISH = 1}
L_Const.CampaignType = {
  CT_SCENE = 1,
  CT_BATTLE = 2,
  CT_STORY_COMPAIGN = 3,
  CT_REPEAT_EVENT = 10,
  CT_TEACH = 100,
  CT_DUNGEON_MATERIAL = 101,
  CT_CULT_TRIAL = 102,
  CT_KIBODUEL_PVE = 200,
  CT_KIBODUEL_PVP = 201,
  CT_KIBODUEL_PVP_PVE = 202,
  CT_NEST_COOP = 300,
  CT_KIBODUEL_ARENA_PVE = 400,
  CT_KIBODUEL_ARENA_PVP = 401,
  CT_DUNGEON_WEEKLY = 500
}
L_Const.CampaignChooseType = {CCT_WORLD = 1, CCT_CHOOSE = 2}
L_Const.TeamApplySrc = {
  TAS_NONE = 0,
  TAS_Invite = 1,
  TAS_Chat = 2,
  TAS_Team_Platform = 3
}
L_Const.StaminaBoxSystemType = {
  SBST_CAMPAIGN = 1,
  SBST_BATTLE_CAMPAIGN = 2,
  SBST_WORLD_ENEMY = 3,
  SBST_MULTI_CAMPAIGN = 4
}
L_Const.StaminaBoxCountType = {
  SBCT_INFINITE = 1,
  SBCT_DAILY = 2,
  SBCT_WEEKLY = 3
}
L_Const.BaseMaterialDungeonGroupId = {
  HeroExpDungeon = 11,
  SoulEssenceExpDungeon = 12,
  PetExpDungeon = 13,
  GoldDungeon = 20
}
L_Const.EntrustType = {
  ET_NONE = 0,
  ET_Dungeon = 1,
  ET_TEACHING = 3,
  ET_Kibo = 5
}
L_Const.MultiCampaignStatus = {
  MCST_NONE = 0,
  MCST_QUIT = 1,
  MCST_READY = 2,
  MCST_START = 3,
  MCST_WIN = 4,
  MCST_LOSE = 5,
  MCST_FINISH_QUIT = 6
}
L_Const.MultiCampaignPlayerStatusType = {
  MCPS_INIT = 0,
  MCPS_READY = 1,
  MCPS_QUIT = 2,
  MCPS_MANUAL_QUIT = 3
}
L_Const.CampaignExpandType = {CET_ROGUE_BOX = 1}
L_Const.CMemOnlineStatus = {CMOS_ONLINE = 0, CMOS_OFFLINE = 1}
L_Const.MatchTeamOptionType = {
  CREATE_TEAM = 1,
  LEAVE_TEAM = 2,
  KICKOUT_TEAM = 3,
  INVITE_TEAM = 4,
  CANCEL_INVITE_TEAM = 5,
  ACCEPT_INVITE = 6,
  REJECT_INVITE = 7,
  START_MATCH = 8,
  STOP_MATCH = 9,
  READY_MATCH = 10,
  UNREADY_MATCH = 11,
  DESTROY_TEAM = 12,
  SYNC_DATA = 13,
  TRANS_PROTO = 14,
  CHANGE_CAPTAIN = 15
}
L_Const.MatchTeamDataSyncReason = {MTDSR_NONE = 0, MTDSR_LOGIN = 1}
L_Const.PlayerStoryStopOp = {END = 1, SKIP = 2}
L_Const.MatchStatusSyncReason = {MSSR_NONE = 0, MSSR_OVERTIME = 1}
L_Const.TeamDismissReason = {TDR_NONE = 0, TDR_OVERTIME = 1}
L_Const.RepeatEventTaskStatus = {
  RepeatEventTask_Running = 0,
  RepeatEventTask_Done = 1,
  RepeatEventTask_End = 2
}
L_Const.RepeatEventLevelMode = {Normal = 1, Hard = 2}
L_Const.IsolatedGamePlayDataType = {
  IsolatedGamePlayData_Common = 0,
  IsolatedGamePlayData_Rogue = 1,
  IsolatedGamePlayData_Nestcoop = 2,
  IsolatedGamePlayData_Abyss = 3,
  IsolatedGamePlayData_Campaign = 4,
  IsolatedGamePlayData_MultiCampaign = 5,
  IsolatedGamePlayData_KiboduelPVP = 6,
  IsolatedGamePlayData_PopperParty = 7,
  IsolatedGamePlayData_KiboduelArena = 8,
  IsolatedGamePlayData_CultTrial = 9,
  IsolatedGamePlayData_HomeStory = 10
}
L_Const.CommonOrganizedDataType = {CommonOrganizedData_Abyss = 0}
L_Const.PlayerBasicQueryType = {
  PBQT_ALL = 0,
  PBQT_NAME = 1,
  PBQT_OFFLINE_TIME = 2,
  PBQT_FACE_MINI = 3,
  PBQT_FACE_HALF = 4,
  PBQT_FACE_BATTLE = 5,
  PBQT_FACE_DIY = 6,
  PBQT_SIGN = 7,
  PBQT_PET = 8,
  PBQT_SIMPLE_SHOW = 9,
  PBQT_COMPLEX_SHOW = 10,
  PBQT_LEVEL = 11,
  PBQT_MONEY = 12,
  PBQT_TITLE = 13,
  PBQT_BIRTH = 14,
  PBQT_STAND_PLATES = 15,
  PBQT_APPAREL_INFO = 16
}
L_Const.PlayerLoginType = {
  PLT_LOGIN = 0,
  PLT_CREATE = 1,
  PLT_SHORT_RECONNECT = 2,
  PLT_LONG_RECONNECT = 3,
  PLT_SWITCH_SVR = 4
}
L_Const.PlayerNoviceTaskStatus = {
  PNTS_ACCEPTED = 0,
  PNTS_FINISHED = 1,
  PNTS_REWARD_SENT = 2
}
L_Const.SystemId = {
  SI_NONE = 0,
  SI_GACHA = 2,
  SI_HERO_GRADE = 23,
  SI_HERO_FAVOR = 50,
  SI_HERO_GIFT = 51,
  SI_NOVICE_TASK = 58,
  SI_PET_SPEICAL = 96,
  SI_ACHIEVEMENT = 12,
  SI_CHARGE = 16,
  SI_MONTHLY_CARD = 64,
  SI_BATTLE_PASS = 65,
  SI_RANDOM_TASK = 70,
  SI_CHANGE_WARDROBE = 73,
  SI_CHANGE_CLOTHES = 731,
  SI_NDAY_ACT = 75,
  SI_FIELD_UNPLANT = 156,
  SI_FIELD_CLOSE = 157,
  SI_PRODUCT = 164,
  SI_HOME_WORK_BIBO = 170,
  SI_HOME_RANCH_KIBO = 171,
  SI_DUNGEON_ENTRUST = 173,
  SI_PET_TALENT_FOOD = 507,
  SI_PET_MUTATION = 509,
  SI_NPC_SHOP = 653,
  SI_PET_BOX = 1102,
  SI_HOME_ORDER = 1301,
  SI_HERO_NEST_COOP = 2001,
  SI_ROGUE_LIKE_ENTRY = 1401,
  SI_ABYSS = 1700,
  SI_KIBO_ARENA_MATCH = 1014,
  SI_KIBODUEL_ARENA = 1010,
  SI_KIBODUEL_ARENA_PVP = 1018,
  SI_WEEKLY = 1735,
  SI_DUNGEON_MATERIAL = 1734,
  SI_CRISIS_CRUSADE = 1733,
  SI_START_JOURNEY = 57,
  SI_MallRechargeDiamondSystem = 4401,
  SI_MallRechargeDiamondExchange = 44011,
  SI_MallShopSwitch4402 = 4402,
  SI_MallShopSwitch4403 = 4403,
  SI_MallShopSwitch4404 = 4404,
  SI_MallShopSwitch4405 = 4405,
  SI_MallShopSwitch4406 = 4406,
  SI_MallShopSwitch4407 = 4407,
  SI_MallShopSwitch4408 = 4408,
  SI_MallShopSwitch4409 = 4409,
  SI_MallShopSwitch4410 = 4410,
  SI_MallShopSwitch4411 = 4411,
  SI_HERO_SKIN = 732,
  SI_PET_EAT_FOOD = 5003,
  SI_PET_SOUL_LINK = 5004,
  SI_WORLD_COLLECT = 92,
  SI_WORLD_COLLECT_TOOL = 1506,
  SI_Shortcut = 1019
}
L_Const.MoveStatus = {
  MS_TRANSFER = 1,
  MS_JUMP = 2,
  MS_DODGE = 3,
  MS_RUN = 4,
  MS_WALK = 5
}
L_Const.RHDGetType = {
  RHD_NONE = 0,
  RHD_PICK = 1,
  RHD_TALK = 2
}
L_Const.OrnamentEquipType = {
  OET_SUIT = 0,
  OET_WEAPON = 1,
  OET_CHEST = 2,
  OET_LEG = 3,
  OET_EARRINGS = 4,
  OET_RING = 5
}
L_Const.HeroType = {
  HT_NORMAL = 0,
  HT_MAIN = 1,
  HT_TRIAL = 2
}
L_Const.FurnitureType = {FT_TOBEGIVEN = 0, FT_ACCEPT = 1}
L_Const.PlayerSexType = {PST_MALE = 1, PST_FEMALE = 2}
L_Const.OnlineMode = {
  ONLINE_MODE_DEFAULT = 0,
  SINGLE_PLAYER = 1,
  MULTI_PLAYER_CITY = 2,
  MULTI_PLAYER_PVE = 3,
  MULTI_PLAYER_DUNGEON = 4,
  SINGLE_PLAYER_DUNGEON = 5,
  ONLINE_MODE_NEST_COOP = 6,
  ONLINE_MODE_NEST_COOP_PVE = 7,
  ONLINE_MODE_KIBO_DUEL_ARENA_PVP = 8,
  ONLINE_MODE_KIBO_DUEL_ARENA_PVE = 9,
  ONLINE_MODE_ABYSS = 10
}
L_Const.OrnamentAffixType = {OAT_NONE = 0, OAT_GOLDEN_SIDE = 1}
L_Const.MailType = {
  PLAYER = 0,
  SYSTEM = 1,
  REWARD = 2,
  GIFTCODE = 3,
  SHOPREWARD = 4
}
L_Const.BuffFromType = {
  SKILL = 1,
  SCENE = 2,
  BEHAVIOR_TREE = 3,
  FSM = 4
}
L_Const.GroupManagerType = {
  GMT_WORLD = 1,
  GMT_COMPAIGN = 2,
  GMT_ROGUE = 3,
  GMT_TOWER = 4,
  GMT_KIBODUEL_PVP = 5,
  GMT_KIBODUEL_ARENA = 6,
  GMT_ABYSS = 7,
  GMT_CULTTRIAL = 8
}
L_Const.AliveStateType = {
  AST_Alive = 0,
  AST_Dead = 1,
  AST_OverHurt = 2
}
L_Const.GroupManagerChangeSrc = {GMS_DEAULFT = 0, GMS_SWITCH = 1}
L_Const.ChatInfoType = {
  CHAT_NORMAL = 0,
  CHAT_COMMON = 1,
  CHAT_EMOJI = 2
}
L_Const.FishWeightStatusType = {
  FWST_NORMAL = 0,
  FWST_MAX = 1,
  FWST_MIN = 2,
  FWST_NEW = 3
}
L_Const.CookFinishStatusType = {
  CFST_NORMAL = 0,
  CFST_PERFECT = 1,
  CFST_FAIL = 2,
  CFST_COUNT = 3
}
L_Const.FoodType = {
  FT_HP = 1,
  FT_REVIVE = 2,
  FT_DEFEND = 3,
  FT_ATTACK = 4,
  FT_STAMINA = 5
}
L_Const.FoodBuffType = {
  FBT_NO_COST_SATIETY = 1,
  FBT_SATIETY_RECOVER = 2,
  FBT_COLLECT_EFFICIENCY = 3,
  FBT_CATCH_RATE = 4
}
L_Const.UseFoodTarget = {UFT_HERO = 0, UFT_PET = 1}
L_Const.HPRechargeType = {HPRT_VALUE = 1, HPRT_RATE = 2}
L_Const.GMPGameSystemEnum = {
  GachaSystem = 2,
  ChangeNameSystem = 3,
  GroupSystem = 4,
  ShopSystem = 6,
  ShopSpecial = 680,
  HomeSystem = 7,
  HomeTechSystem = 702,
  HomeBuildBag = 703,
  AchievementSystem = 12,
  MailSystem = 15,
  FriendSystem = 17,
  ChatSystem = 18,
  PersonalCardSystem = 19,
  ChangeName = 191,
  ChangePersonalSign = 192,
  PhotoSystem = 20,
  HeroCharDataSystem = 26,
  HeroCharDataStory = 261,
  HeroCharDataVoice = 262,
  HeroCharDataStoryline = 263,
  DungeonGate = 35,
  BaseMaterialDungeon = 36,
  HeroFavorSystem = 50,
  TaskRandomSystem = 70,
  ChangeWardrobe = 73,
  ChangeClothes = 731,
  NDayAct = 75,
  WorldTimeSyncSystem = 95,
  FlashPetSystem = 96,
  StaminaBuy = 99,
  PetColorFulSystem = 159,
  PetColorFulFlashSystem = 160,
  PetColorSystem = 161,
  PetFlashSystem = 162,
  PetColorFlashSystem = 163,
  KiboDuelSystem = 1009,
  KiboDuelTypeNpc = 1010,
  KiboDuelTypeLevels = 1011,
  ChangeHomeName = 1100,
  ChangePetName = 1101,
  ChangePetBagName = 1102,
  ChangeGroupName = 1103,
  ChangeFriendNickName = 1104,
  ChangeMapSignName = 1105,
  ChangePhotoTemplateName = 1106,
  WaterMarkSystem = 9901,
  CVShowSystem = 9902,
  TestWaterMarkSystem = 9903,
  OrderBuildSystem = 1301,
  StarSynthesisSystem = 10121,
  GodTowerSystem = 1501,
  PamiMailSystem = 60,
  MultiBattle = 1733,
  AssignTask = 173,
  RogueSystem = 1401,
  HomeDorm = 53,
  HomeRanch = 171,
  HomeCenter = 165,
  HomeBuildPack = 1502,
  CommunitySystem = 74,
  BeginTrain = 1731,
  KiboDuelTask = 1732,
  RechargeSystem = 601,
  AbyssSystem = 1700,
  MONTHLY_CARD_SWITCH = 64,
  BATTLE_PASS_SWITCH = 65,
  TodoNoSense2 = 66,
  MallControlSwitch = 44,
  MallRechargeDiamondSystem = 4401,
  RECHARGE_ANDROID = 44012,
  RECHARGE_IOS = 44013,
  RECHARGE_PC = 44014,
  RECHARGE_HARMONY = 44015,
  MallRechargeDiamondExchange = 44011,
  MallShopSwitch4402 = 4402,
  MallShopSwitch4403 = 4403,
  MallShopSwitch4404 = 4404,
  MallShopSwitch4405 = 4405,
  MallShopSwitch4406 = 4406,
  MallShopSwitch4407 = 4407,
  MallShopSwitch4408 = 4408,
  MallShopSwitch4409 = 4409,
  MallShopSwitch4410 = 4410,
  MallShopSwitch4411 = 4411,
  KiboSoulSys = 5004,
  KiboSkinSys = 505,
  KiboFree = 506,
  HeroGradeSys = 23,
  ESCBackground = 3006
}
L_Const.MedicineTargeType = {Single = 1, all = 2}
L_Const.MedicineType = {
  Damage = 1,
  Resistance = 2,
  Relive = 3
}
L_Const.ShortcutKeyType = {SKT_Item = 1}
L_Const.SkillTreeType = {STT_Rogue = 1}
L_Const.MatchRankMode = {KIBODUEL_ARENA = 1}
L_Const.EnumBanType = {CHAT = 1}
L_Const.TrialHeroType = {THT_MAIN = 1, THT_NORMAL = 2}
L_Const.TextGmType = {
  NICKNAME = 1,
  SIGNATURE = 2,
  HOME_NAME = 3,
  KIBO_NAME = 4,
  KIBO_BOX_NAME = 5,
  DORMITORY_NAME = 6,
  GROUP_NAME = 7,
  FREIND_REMARK = 8,
  MAP_MARK = 9,
  PHOTO_TEMPLATE = 10,
  SCENE_TEMPLATE = 11
}
L_Const.DungeonModeType = {
  DUNGEON_MODE_NORMAL = 1,
  DUNGEON_MODE_ROTATE = 2,
  DUNGEON_MODE_COUNT = 3
}
L_Const.DungeonStatus = {
  DUNGEON_STATUS_INIT = 0,
  DUNGEON_STATUS_GAME = 1,
  DUNGEON_STATUS_END = 2
}
L_Const.EscBgTabType = {
  EscBgTabType_Invalid = 0,
  EscBgTabType_Default = 1,
  EscBgTabType_Role = 2,
  EscBgTabType_Plot = 3,
  EscBgTabType_Max = 4
}
L_Const.EscBgPlayType = {
  EscBgPlayType_Invalid = 0,
  EscBgPlayType_Cycle = 1,
  EscBgPlayType_Random = 2,
  EscBgPlayType_Max = 3
}
L_Const.GMMaskType = {
  GMMaskType_NoCD = 0,
  GMMaskType_NoDmg = 1,
  GMMaskType_DebugInfo = 2,
  GMMaskType_Wudi = 3,
  GMMaskType_Dali = 4,
  GMMaskType_NoSPCost = 5
}
L_Const.GMPlatformRetEnum = {
  OK = 0,
  METHOD_ERROR = 1,
  SIGN_ERROR = 2,
  NOT_FOUND_API = 3,
  SERVER_BUSY = 4,
  PARAMS_ERROR = 5,
  SERVER_PROXY_NOT_FOUND_API = 6,
  PLAYER_OFFLINE = 7,
  SERVER_ERR = 8,
  PLAYER_NOT_EXIST = 9,
  SERVER_PROXY_DB = 16777214,
  SERVER_PROXY = 268435455
}
L_Const.GMPlatformJadeWebGameRetEnum = {
  JADE_WEB_GAME_OK = 0,
  JADE_WEB_GAME_PARAMS_ERROR = 1,
  JADE_WEB_GAME_SIGN_ERROR = 2,
  JADE_WEB_GAME_LOGIN_ERR = 401,
  JADE_WEB_GAME_SERVER_ERR = 999
}
L_Const.GMPRechargeDeductOpType = {
  eRECHARGE_DEDUCT_OP_TYPE_MONTH_CARD = 1,
  eRECHARGE_DEDUCT_OP_TYPE_CLOSE_PASS_AUTH = 2,
  eRECHARGE_DEDUCT_OP_TYPE_CLOSE_DAYSGIFT_AUTH = 3,
  eRECHARGE_DEDUCT_OP_TYPE_DEDUCT_ITEM_NUM = 4
}
L_Const.SurpriseType = {
  SURPRISE_TYPE_UNSPECIFIED = 0,
  BLUE_TO_GOLD = 1,
  PURPLE_TO_GOLD = 2
}
L_Const.WorldMapBuildStatusType = {
  WMBST_NORMAL = 1,
  WMBST_BUILDING = 2,
  WMBST_UPGRADING = 3,
  WMBST_PRODUCT = 4
}
L_Const.WorldMapBuildType = {
  WMBT_HOUSE = 1,
  WMBT_PRODUCT = 2,
  WMBT_DECORATE = 3,
  WMBT_CANTEEN = 4,
  WMBT_DORM = 5,
  WMBT_PET_CANTEEN = 6,
  WMBT_PRO_BUILD = 7,
  WMBT_PRO_ORNAMENT = 8,
  WMBT_PRO_COMMON = 9,
  WMBT_COOK = 10,
  WMBT_HATCH = 12,
  WMBT_MANAGE = 13,
  WMBT_STOREHOUSE = 14,
  WMBT_FIELD_NEW = 15,
  WMBT_FIELD_HOUSE = 16,
  WMBT_PARTICLE_STORE = 17,
  WMBT_HOME_ORDER = 18,
  WMBT_FIELD_NEW2 = 19,
  WMBT_WAR_GOD_TOWER = 23,
  WMBT_HOME_COLLECT = 24,
  WMBT_RANCH = 53,
  WMBT_FIELD = 54,
  WMBT_WILD_COLLECT = 55,
  WMBT_ACHIEVEMENT_SHOW = 61,
  WMBT_ACTIVITY_SHOW = 62,
  WMBT_WORLD_GAMEPLAY = 63,
  WMBT_BATCH_HATCH = 64
}
L_Const.ProductType = {
  PT_Unkown2 = 2,
  PT_Cook = 3,
  PT_Unkown6 = 6,
  PT_Unkown7 = 7
}
L_Const.FreeType = {
  FT_PASSIVE = 1,
  FT_ACTIVE = 2,
  FT_RECYCBUILD = 3
}
L_Const.WorldMapFieldStatusType = {
  WMFST_CLOSE = 1,
  WMFST_OPEN = 2,
  WMFST_CROP = 3
}
L_Const.WorldMapCropStatusType = {
  WMCST_SEED = 0,
  WMCST_GROW = 1,
  WMCST_PRE_HARVEST = 2,
  WMCST_HARVEST = 3
}
L_Const.HomeResidentSpecialWorkType = {HRSW_SCIENCE = 1, HRSW_MAX = 2}
L_Const.PetStationedWorkStatusType = {
  PSWST_NONE = 0,
  PSWST_HOME_REST = 1,
  PSWST_HOME_WORK = 2,
  PSWST_WILD_REST = 3,
  PSWST_WILD_WORK = 4,
  PSWST_FIELD_WORK = 5,
  PSWST_RANCH_WORK = 6,
  PSWST_CENTER = 7
}
L_Const.TechSyncType = {TST_EXP = 1}
L_Const.StationEventType = {
  SET_COLLECT = 1,
  SET_HOME_PRODUCT = 2,
  SET_HOME_FIELD = 3,
  SET_HOME_RANCH = 4
}
L_Const.HomeShortcutBarType = {HSBT_BUILD = 1, HSBT_CROP = 2}
L_Const.HomePetAutoWorkType = {
  HPAWT_WATER = 1,
  HPAWT_HARVEST = 2,
  HPAWT_PLANT = 3,
  HRANCH_WORK = 4,
  HRANCH_HARVEST = 5
}
L_Const.HomeOperateAutoWorkType = {HOAWT_ADD = 1, HOAWT_DEL = 2}
L_Const.HomeBuffValType = {
  HBVT_NUM = 1,
  HBVT_RATIO = 2,
  HBVT_TIME = 3,
  HBVT_CATCH_PET = 4,
  HBVT_BATTLE_ATTR = 5
}
L_Const.HomeBuffValCalcType = {
  HBVCT_Uncalc = 0,
  HBVCT_OUTVAL = 2,
  HBVCT_ADD = 3,
  HBVCT_MAX = 4,
  HBVCT_ADDMUL = 5,
  HBVCT_SUBMUL = 6,
  HBVCT_MIN = 7,
  HBVCT_UNION = 8,
  HBVCT_PRIORITY = 9
}
L_Const.HomeCropStateType = {
  HCST_NONE = 0,
  HCST_SEED = 1,
  HCST_GROW1 = 2,
  HCST_GROW2 = 3,
  HCST_HARVEST = 4
}
L_Const.HomeCropHarvestType = {
  HCHT_NONE = 0,
  HCHT_COMMON_PLANT = 1,
  HCHT_COMMON_FRUIT_TREE = 2,
  HCHT_DNA_FRUIT_TREE = 3
}
L_Const.HomeHubTabType = {
  HHTT_PRODUCT = 1,
  HHTT_AUTO_WORK = 2,
  HHTT_RANCH = 3,
  HHTT_COLLECT = 4
}
L_Const.HomeBuildingID = {FIELD_BUILDING = 20161, GOOD_FIELD_BULDING = 20331}
L_Const.PetEggHatchState = {
  PEHS_NORMAL = 0,
  PEHS_IN_HATCH_QUEUE = 1,
  PEHS_START_HATCH = 2,
  PEHS_FINISH_HATCH = 3
}
L_Const.BatchHatchSlotState = {
  BHSS_EMPTY = 0,
  BHSS_HATCHING = 1,
  BHSS_FINISH = 2
}
L_Const.EUpDown = {
  EUD_None = 0,
  EUD_Up = 1,
  EUD_Down = 2
}
L_Const.EOrderType = {
  EOT_None = 0,
  EOT_Plot = 1,
  EOT_Fixed = 2,
  EOT_Middle = 3,
  EOT_Hight = 4
}
L_Const.EOrderState = {
  EOS_None = 0,
  EOS_Accept = 1,
  EOS_Complete = 2
}
L_Const.ItemType = {
  kNone = 0,
  kHeroType = 1,
  kWeaponType = 2,
  kCommonItemType = 3,
  kPetType = 5,
  kSoulEssenceType = 9,
  kCurrencyType = 10,
  kMountType = 12,
  kBuildType = 13,
  kPetEggType = 14,
  kOrnamentType = 15,
  kPlayerTitleType = 17,
  kStarGiftType = 18,
  kTaskItemType = 20,
  kTeleport = 21,
  kChatEmoji = 22,
  kCollectTool = 24,
  kMountSaddlery = 25,
  kStandPlates = 26,
  kDrop = 27,
  kLibraryReading = 28,
  kReputation = 29,
  kPetCustomizedType = 30,
  kSocialEmoticons = 32,
  kOrnamentCustomizedType = 33,
  kHeroSkinType = 39
}
L_Const.CommonItemSubType = {
  kRandGiftPack = 5,
  kSelectGiftPack = 6,
  kCommonGiftPack = 7,
  kCrop = 9,
  kGiftPack = 11,
  kStaminaLiquid = 100,
  kHeroGift = 110,
  kHerofurniture = 111,
  kPetLens = 180,
  kExploreTool = 181,
  kHeroChips = 200,
  kElementCrystal = 304,
  kFishMeat = 308,
  kFish = 309,
  kSeed = 310,
  kPetTalentFeed = 320,
  kPetSoulFeed = 321,
  kPetFactorFeed = 322,
  kPetDndFruitGift = 330,
  kFood = 355,
  kSoulEssencePack = 356,
  kHeroExpBook = 400,
  kSoldierExpBook = 401,
  kPetExpBook = 402,
  kSoulEssenceExpBook = 403,
  kPetVitality = 404,
  kPetGeneRecombine = 405,
  kPetGeneUp = 406,
  kPetEggHatch = 407,
  kPetGeneTimes = 408,
  kCatchPet = 410,
  kRod = 420,
  kBait = 421,
  kInitialPet = 441,
  kRedemptionTicket = 502,
  kTechnologyPoint = 520,
  kMedicine = 701,
  kCook = 707,
  kSoulEssenceStarItem = 980,
  kMonthlyCard = 1201,
  kBattlePassNormal = 1202,
  kBattlePassPremium = 1203
}
L_Const.CurrencySubType = {
  kDiamond = 1,
  kCoin = 2,
  kStamina = 3,
  kHeroFavorExp = 4,
  kResonanceLevel = 10,
  kHeroExp = 11,
  kSoldierExp = 12,
  kSoulEssenceExp = 13,
  kPetExp = 14,
  kFreeHeroExp = 21,
  kLinkPoint = 22,
  kBattlePassExp = 50,
  kNaturePoint = 101,
  kPartyScore = 1001,
  kActivityPT = 1002,
  kElementEarthParticle = 700,
  kElementWaterParticle = 701,
  kElementFireParticle = 702,
  kElementWindParticle = 703,
  kElementIceParticle = 704,
  kElementThunderParticle = 705,
  kElementWoodParticle = 706,
  kElementLightParticle = 707,
  kElementDarkParticle = 708,
  kPurchaseDiamond = 901,
  kPurchaseBonusDiamond = 902,
  kAccumulativeRechargeScore = 910,
  kMythicalCatchCount = 2001,
  kPurchasePoint = 99001,
  kStaminaBuyTimeStamp = 200029,
  kStaminaRecoverTime = 200030,
  kStaminaBuyTimes = 200031,
  kGoldItemToStaminaTimes = 200032,
  kStaminaFullTime = 200033
}
L_Const.JourneyTaskType = {JTY_linearTask = 0, JTY_parallelism = 1}
L_Const.JourneyTrackingPoint = {
  JTP_targetFinish = 1,
  JTP_targetReward = 2,
  JTP_pointReward = 3,
  JTP_specialReward = 4,
  JTP_taskFinish = 5,
  JTP_taskReward = 6
}
L_Const.JourneyTypeInfo = {}
L_Const.JourneyRewardStatus = {}
L_Const.KiboDuelType = {KDuelTypeNpc = 1, KDuelTypeLevels = 2}
L_Const.KiboDuelStatus = {
  KDS_NORMAL = 0,
  KDS_QUIT = 1,
  KDS_START = 2,
  KDS_AGOING = 3,
  KDS_END = 4
}
L_Const.KiboDuelPVPStatus = {
  KIBO_DUEL_STATUS_NONE = 0,
  KIBO_DUEL_STATUS_QUIT = 1,
  KIBO_DUEL_STATUS_READY = 2,
  KIBO_DUEL_STATUS_PRE_START = 3,
  KIBO_DUEL_STATUS_REAL_START = 4,
  KIBO_DUEL_STATUS_FIN = 5,
  KIBO_DUEL_STATUS_OVERTIME = 8,
  KIBO_DUEL_STATUS_OVERTIME_EXPIRED = 9
}
L_Const.KiboDuelFinType = {
  KIBO_DUEL_FIN_INVALID = 0,
  KIBO_DUEL_FIN_CAMP1_WIN = 1,
  KIBO_DUEL_FIN_CAMP2_WIN = 2,
  KIBO_DUEL_FIN_DRAW = 3
}
L_Const.KiboDuelPVPFinReason = {
  KIBO_DUEL_FIN_REASON_INVALID = 0,
  KIBO_DUEL_FIN_REASON_DESTROY_CLAM = 1,
  KIBO_DUEL_FIN_REASON_TIMEOUT = 2,
  KIBO_DUEL_FIN_REASON_PLAYER_QUIT = 3
}
L_Const.MiniGameMode = {MINI_GAME_MODE_FAIR = 0, MINI_GAME_MODE_INIT = 1}
L_Const.MiniGameModeOp = {
  MINI_GAME_MODE_OP_ASK = 0,
  MINI_GAME_MODE_OP_FAIL = 1,
  MINI_GAME_MODE_OP_SUCC = 2
}
L_Const.KiboDuelArenaStatus = {
  KIBO_DUEL_ARENA_STATUS_NONE = 0,
  KIBO_DUEL_ARENA_STATUS_READY = 1,
  KIBO_DUEL_ARENA_STATUS_START = 2,
  KIBO_DUEL_ARENA_STATUS_FIRST = 3,
  KIBO_DUEL_ARENA_STATUS_REGULAR = 4,
  KIBO_DUEL_ARENA_STATUS_FINISH = 5,
  KIBO_DUEL_ARENA_STATUS_STINGER = 6,
  KIBO_DUEL_ARENA_STATUS_EXIT = 7
}
L_Const.KiboDuelArenaFinReason = {
  KIBO_DUEL_ARENA_FIN_REASON_INVALID = 0,
  KIBO_DUEL_ARENA_FIN_REASON_BATTLE = 1,
  KIBO_DUEL_ARENA_FIN_REASON_TIMEOUT = 2,
  KIBO_DUEL_ARENA_FIN_REASON_PLAYER_QUIT = 3
}
L_Const.KiboDuelArenaStingerStage = {
  KIBO_DUEL_ARENA_STINGER_STAGE_INVALID = 0,
  KIBO_DUEL_ARENA_STINGER_STAGE_START = 1,
  KIBO_DUEL_ARENA_STINGER_STAGE_FIRST = 2,
  KIBO_DUEL_ARENA_STINGER_STAGE_FINISH = 3
}
L_Const.KIBO_DUEL_ARENA_PVP_ENTER_TYPE = {
  NORMAL = 0,
  INVITE = 1,
  MATCH = 2,
  COMPETITION = 3
}
L_Const.ConfirmOp = {
  INVITE = 0,
  ACCEPT = 1,
  REJECT = 2
}
L_Const.ControlObjType = {
  ALL = 0,
  NPC = 1,
  KIBO = 2
}
L_Const.MallRefreshType = {
  MallRefreshType_None = 0,
  MallRefreshType_NoRefresh = 1,
  MallRefreshType_Minute = 2,
  MallRefreshType_Month = 3,
  MallRefreshType_Day = 4,
  MallRefreshType_Week = 5
}
L_Const.MallType = {
  MallType_General = 0,
  MallType_Gift = 1,
  MallType_SixYuanNewbie = 2,
  MallType_Furniture = 3
}
L_Const.NonMallType = {
  NonMallType_None = 0,
  NonMallType_RechargeDiamond = 1,
  NonMallType_MonthlyCard = 2,
  NonMallType_BattlePass = 3
}
L_Const.NovicePackStatus = {
  NPS_UNBOUGHT = 0,
  NPS_BOUGHT = 1,
  NPS_PAUSE = 2
}
L_Const.NestCoopSiteStatus = {
  NCSS_NONE = 0,
  NCSS_ACTIVE = 1,
  NCSS_FINISH = 2,
  NCSS_RUNNING = 3
}
L_Const.NestCoopLimitType = {
  NCLT_ALL = 0,
  NCLT_CURRENCY = 1,
  NCLT_CATCH = 2,
  NCLT_SPECIAL = 3
}
L_Const.NestCoopStatus = {
  NCCS_NONE = 0,
  NCCS_QUIT = 1,
  NCCS_READY1 = 2,
  NCCS_READY2 = 7,
  NCCS_QUIT_TIMEOUT = 8,
  NCCS_PRE_START = 9,
  NCCS_START = 3,
  NCCS_WIN = 4,
  NCCS_LOSE = 5
}
L_Const.NestCoopFinReason = {
  NCFR_INVALID = 0,
  NCFR_KILL_BOSS = 1,
  NCFR_TIMEOUT = 2,
  NCFR_KILL_CLAM = 3
}
L_Const.NestCoopSummonType = {
  NCST_NONE = 0,
  NCST_PLAYER = 1,
  NCST_NPC = 2,
  NCST_CLAM = 3,
  NCST_TOWER = 4
}
L_Const.NestCoopStarlinkStatus = {
  NCSLS_NONE = 0,
  NCSLS_SUCC = 1,
  NCSLS_FAIL = 2,
  NCSLS_ABORT = 3
}
L_Const.NestCoopPlayerState = {
  NCPS_NONE = 0,
  NCPS_LOAD = 1,
  NCPS_READY = 2,
  NCPS_QUIT = 3
}
L_Const.ResultType = {
  DRAW = 0,
  WIN = 1,
  LOSE = 2
}
L_Const.OperateSnackBagType = {
  OSBT_SUB = 0,
  OSBT_ADD = 1,
  OSBT_CHANGE_LOC = 2
}
L_Const.FavorSourceType = {
  FST_BATTLE = 1,
  FST_FOOD = 2,
  FST_FRUIT = 3,
  FST_CARESS = 4
}
L_Const.DnaPetType = {DPT_talent = 1, DPT_freedom = 2}
L_Const.PetType = {PT_NORMAL = 0, PT_TRIAL = 2}
L_Const.PetSpecialType = {
  PST_NORMAL = 0,
  PST_COLOR = 1,
  PST_FLASH = 2,
  PST_FLASH_COLOR = 3,
  PST_COLORFUL = 4,
  PST_FLASH_COLORFUL = 5,
  PST_NOT_DEFINE = 6
}
L_Const.PetState = {
  PET_NORMAL = 0,
  PET_HERO = 2,
  PET_ROULETTE = 3,
  PET_RIDE = 4,
  PET_WORKING = 5,
  PET_RESTING = 6,
  PET_PUZZLE_ROULETTE = 7,
  PET_HUB = 8
}
L_Const.PetFSMStateType = {
  PFST_NORMAL = 0,
  PFST_WORK = 1,
  PFST_EAT = 2,
  PFST_PAUSE = 3,
  PFST_HUB = 4
}
L_Const.PetHandElementType = {PHET_SINGLE = 5009, PHET_ALL = 5010}
L_Const.PetEggRatioType = {
  PERT_PROBABILITY_R1 = 1,
  PERT_PROBABILITY_R2 = 2,
  PERT_PROBABILITY_R3 = 3,
  PERT_PROBABILITY_R4 = 4,
  PERT_PROBABILITY_R5 = 5,
  PERT_PROBABILITY_SR = 11,
  PERT_PROBABILITY_SSR = 21
}
L_Const.PetEggHatchStrategy = {
  PEHS_GUARANTEE = 1,
  PEHS_UP = 2,
  PEHS_RANDOM = 3
}
L_Const.PopperPartyState = {
  PPCS_NONE = 0,
  PPCS_READY1 = 1,
  PPCS_READY2 = 2,
  PPCS_QUIT_TIMEOUT = 3,
  PPCS_PRE_START = 4,
  PPCS_START = 5,
  PPCS_END = 6
}
L_Const.PopperPartyPlayerState = {
  CCPS_NONE = 0,
  CCPS_LOAD = 1,
  CCPS_READY = 2,
  CCPS_QUIT = 3
}
L_Const.PopperPartyPlayerPlayState = {
  PPPPS_INVALID = 0,
  PPPPS_PLAY = 1,
  PPPPS_QUIT = 2,
  PPPPS_END = 3,
  PPPPS_WIN = 4
}
L_Const.RogueGraphNodeType = {
  RGNT_NORMAL = 0,
  RGNT_BEGIN = 1,
  RGNT_END = 2
}
L_Const.RogueNodeType = {
  RGT_SHOP = 0,
  RGT_BATTLE = 1,
  RGT_RELEX = 2,
  RGT_CONDITION = 3,
  RGT_RANDOM = 4,
  RGT_NODEGROUP = 5,
  RGT_COUNT = 6
}
L_Const.RogueDungeonState = {
  RDS_NONE = 0,
  RDS_BEFORE = 1,
  RDS_CHOSENB = 2,
  RDS_AFTER = 3,
  RDS_CHOSENA = 4
}
L_Const.RogueSelectionType = {
  RST_NORMAL = 0,
  RST_SHOP = 1,
  RST_CARP = 2
}
L_Const.RogueRewardType = {
  RogueReward_Dragon = 1,
  RogueReward_Gather = 2,
  RogueReward_Score_Normal = 3,
  RogueReward_MaxCount = 4
}
L_Const.ENUM_ROGUELIKE_EVENT_STATUS_TYPE = {
  eROGUELIKE_ES_TYPE_NONE = 0,
  eROGUELIKE_ES_TYPE_RUNNING = 1,
  eROGUELIKE_ES_TYPE_SUCCESS = 2
}
L_Const.ENUM_ROGUELIKE_EVENT_EFFECT_TYPE = {
  eROGLK_EFCT_NONE = 0,
  eROGLK_EFCT_ROUND_ITEM_NUM = 1,
  eROGLK_EFCT_ROUND_DRAGON_ACTIVE = 2,
  eROGLK_EFCT_SHOP_DISCOUNT = 3,
  eROGLK_EFCT_ADD_ENEMY_BUFF = 4,
  eROGLK_EFCT_ADD_MY_BUFF = 5,
  eROGLK_EFCT_BEGIN_NODE_CURRENCY_GIVE = 7,
  eROGLK_EFCT_SKILL_COIN_UP_PR = 8,
  eROGLK_EFCT_SHOP_EXTRA_COUNT = 14,
  eROGLK_EFCT_SHOP_DRAGON_UNLOCK = 15,
  eROGLK_EFCT_MAX = 20
}
L_Const.ENUM_ROGUELIKE_REWARD_SELECT_FLAG = {}
L_Const.ENUM_ROGUELIKE_EVENT_TYPE = {
  eROGLK_ET_NONE = 0,
  eROGLK_ET_ENTER_BATTLE = 1,
  eROGLK_ET_RAND_EVENT = 2,
  eROGLK_ET_RAND_WEIGHT_EVENT = 3,
  eROGLK_ET_ROUND_ITEM_NUM = 4,
  eROGLK_ET_ROUND_DRAGON_ACTIVE = 5,
  eROGLK_ET_HAVE_CARP_CURRENCY_NUM = 6,
  eROGLK_ET_RAND_UNACTIVE_DRAGON_GIVE_CARP = 7,
  eROGLK_ET_RAND_GIVE_DRAGON = 8,
  eROGLK_ET_RAND_GIVE_DRAGON_SELECT = 9,
  eROGLK_ET_RAND_LOSE_DARGON = 10,
  eROGLK_ET_RAND_LOSE_DARGON_SELECT = 11,
  eROGLK_ET_RAND_GIVE_QUALITY_CARP = 12,
  eROGLK_ET_RAND_GIVE_QUALITY_CARP_SELECT = 13,
  eROGLK_ET_RAND_LOSE_QUALITY_CARP = 14,
  eROGLK_ET_RAND_LOSE_QUALITY_CARP_SELECCT = 15,
  eROGLK_ET_UNACTIVE_DRAGON_RAND_GIVE_CARP = 16,
  eROGLK_ET_GIVE_CURRENCY = 17,
  eROGLK_ET_LOSE_CURRENCY = 18,
  eROGLK_ET_SHOP_DISCOUNT = 19,
  eROGLK_ET_ADD_BUFF_TOME = 20,
  eROGLK_ET_ADD_BUFF_TOENEMY = 21,
  eROGLK_ET_RAND_GIVE_TYPE_CARP = 22,
  eROGLK_ET_RAND_GIVE_TYPE_CARP_SELECT = 23,
  eROGLK_ET_RAND_LOSE_TYPE_CARP = 24,
  eROGLK_ET_RAND_LOSE_TYPE_CARP_SELECCT = 25,
  eROGLK_ET_RAND_GIVE_CARP_BY_QLT_WT = 26,
  eROGLK_ET_RAND_GIVE_CARP_BY_QLT_WT_SELECT = 27,
  eROGLK_ET_RAND_LOSE_CARP_BY_QLT_WT = 28,
  eROGLK_ET_RAND_LOSE_CARP_BY_QLT_WT_SELECT = 29,
  eROGLK_ET_MAX = 112
}
L_Const.TaskType = {
  TT_MAIN = 1,
  TT_BRANCH = 2,
  TT_GUIDE = 3,
  TT_ACTIVITY = 4,
  TT_DAILY_RANDOM = 7,
  TT_JOURNEY = 9,
  TT_DUNGEON = 11
}
L_Const.TaskNodeCollectType = {TNCT_ALL = 0, TNCT_SOME = 1}
L_Const.TaskNodeType = {
  TNT_START = 10,
  TNT_ACTION = 20,
  TNT_CONDITION = 30,
  TNT_START_CONDITION = 31,
  TNT_FAIL_CONDITION = 32,
  TNT_COLLECT = 33,
  TNT_BRANCH = 34,
  TNT_END = 50,
  TNT_JUMP = 60
}
L_Const.TaskNodeSubType = {
  TNST_TASK = 3010,
  TNST_LEVEL = 3020,
  TNST_HAS_ITEM = 2030
}
L_Const.TaskItemDefine = {TID_MAX_NUM = 99}
L_Const.TaskExternType = {TTT_ACTIVITY = 1, TTT_ABC = 2}
L_Const.TeamV2UpdateReason = {
  T2UR_NONE = 0,
  T2UR_CREATE = 1,
  T2UR_LOGIN = 2,
  T2UR_FSM_PREPARE = 3,
  T2UR_PREPARE = 4,
  T2UR_FSM_NORMAL = 5,
  T2UR_FSM_PRE_START = 6,
  T2UR_JOIN = 7,
  T2UR_FSM_PLAY = 8,
  T2UR_URGE = 9,
  T2UR_LIMIT = 10,
  T2UR_FSM_CHANGE = 11,
  T2UR_VOTE_CHANGE = 12,
  T2UR_FSM_CHANGE_SUCC = 13,
  T2UR_FSM_CHANGE_FAIL = 14,
  T2UR_FSM_CHANGE_CHECK_FAIL = 15,
  T2UR_FSM_CAMCEL_PREPARE = 16,
  T2UR_WORLD_INVITE = 17,
  T2UR_FSM_MATCH = 18,
  T2UR_FSM_MATCH_CANCEL = 19,
  T2UR_FSM_MATCH_SUCC = 20,
  T2UR_FSM_PLAY_FINISH = 21,
  T2UR_TEAM_INVITE = 22,
  T2UR_INIT = 23,
  T2UR_CANCEL_CHANGE_TARGET = 24,
  T2UR_FSM_MATCH_TIMEOUT = 25
}
L_Const.TeamV2LeaveReason = {
  T2LR_NONE = 0,
  T2LR_LEAVE = 1,
  T2LR_KICK = 2,
  T2LR_DISMISS = 3,
  T2LR_OFFLINE = 4,
  T2LR_SYNC = 5,
  T2LR_LOGIN = 6
}
L_Const.TeamV2MemberUpdateReason = {
  T2MUR_NONE = 0,
  T2MUR_LOGIN = 1,
  T2MUR_OFFLINE = 2,
  T2MUR_JOIN = 3,
  T2MUR_DATA_CHANGE = 4,
  T2MUR_PLAY = 5
}
L_Const.InviteSyncReason = {
  ISR_INVALID = 0,
  ISR_LOGIN = 1,
  ISR_INVITING = 2,
  ISR_INVITED = 3,
  ISR_INVITING_CANCEL = 4,
  ISR_INVITED_CANCEL = 5,
  ISR_INVITING_REJECT = 6,
  ISR_INVITED_REJECT = 7,
  ISR_INVITING_ACCEPT = 8,
  ISR_INVITED_ACCEPT = 9,
  ISR_INVITED_JOIN_TEAM = 10,
  ISR_INVITE_JOIN_TEAM_REJECT = 11
}
L_Const.TeamV2MatchUpdateReason = {
  T2MR_NONE = 0,
  T2MR_LOGIN = 1,
  T2MR_CANCEL = 2,
  T2MR_TIMEOUT = 3,
  T2MR_START = 4,
  T2MR_SUCCESS = 5
}
L_Const.TeamV2MatchState = {
  T2MS_NONE = 0,
  T2MS_MATCHING = 1,
  T2MS_SUCCESS = 2
}
L_Const.TeamV2State = {
  TS_INVALID = 0,
  TS_NORMAL = 1,
  TS_PREPARE = 2,
  TS_PRE_START = 3,
  TS_PLAY = 4
}
L_Const.WorldLastMapType = {
  WLT_Watching = 1,
  WLT_BigWorld = 2,
  WLT_HomeScene = 3
}
L_Const.WorldMapSceneType = {
  WMST_WORLD = 1,
  WMST_CAMPAIGN = 2,
  WMST_HOME = 3,
  WMST_PUBLIC_WORLD = 4,
  WMST_ROGUE = 5,
  WMST_PBULIC_DORM = 6,
  WMST_PRI_DORM = 7,
  WMST_OTAKU = 10,
  WMST_INTERIM = 11,
  WMST_MULTI_CAMPAIGN = 12,
  WMST_KIBODUEL = 13,
  WMST_PUBLIC_WORLD_SHADOW = 14,
  WMST_PHOTO_GRAPH = 20,
  WMST_HOME_DORM = 21,
  WMST_NEST_COOP = 22,
  WMST_KIBODUEL_PVP = 23,
  WMST_POPPER_PARTY = 24,
  WMST_KIBODUEL_ARENA = 25,
  WMST_ABYSS = 26,
  WMST_CULT_TRIAL = 27,
  WMST_HOME_STORY = 28,
  WMST_GROWUP_ACTIVITY = 29,
  WMST_WHITE_BOX = 100,
  WMST_INIT = 101
}
L_Const.WorldMapItemState = {
  WMIS_SHOW = 0,
  WMIS_HIDE = 1,
  WMIS_HOME_BUILD_LVUP = 110
}
L_Const.WorldMapDefine = {
  WM_UPDATE_INTERVAL = 1,
  WM_SAVE_INTERVAL = 5000,
  WM_PLAYER_EXPIRE_TIME = 300,
  WM_EXPIRE_TIME = 360000,
  WM_MAX_PLAYER_NUM = 4,
  WM_MAX_CMD_NUM = 256
}
L_Const.WorldMapInstanceStatusType = {
  WMIST_CREATE = 0,
  WMIST_LOADING = 1,
  WMIST_LOADED = 2
}
L_Const.WorldMapPlayerStatusType = {
  WMPST_NORMAL = 0,
  WMPST_MOUNT = 1,
  WMPST_FISH = 2,
  WMPST_ACTION = 3,
  WMPST_HOME = 4,
  WMPST_SIGHTSEE = 5,
  WMPST_COUNT = 6
}
L_Const.WorldMapPlayerMountStatusType = {
  WMPMST_DEFAULT = 0,
  WMPMST_GROUND = 1,
  WMPMST_FLY = 2,
  WMPMST_WATER_SURFACE = 3,
  WMPMST_WATER_UNDER = 4,
  WMPMST_GLIDE = 5,
  WMPMST_HOOKFLY = 6,
  WMPMST_COUNT = 7
}
L_Const.WorldMapTriggerType = {
  WMTT_NONE = 0,
  WMTT_BATTLE = 1,
  WMTT_QUEST_START = 2,
  WMTT_QUEST_FINISH = 3,
  WMTT_INTERACT = 4,
  WMTT_STEP = 5
}
L_Const.WorldMapCmdType = {
  WMCT_MOVE = 1,
  WMCT_INTERACT = 2,
  WMCT_BATTLE_START = 3,
  WMCT_BATTLE_FINISH = 4,
  WMCT_RESET = 5,
  WMCT_QUIT = 6,
  WMCT_BUILD_LOCATE = 7,
  WMCT_BUILD_UNLOCATE = 8,
  WMCT_BUILD_CREATE = 9,
  WMCT_BUILD_CREATE_FINISH = 10,
  WMCT_QUEST_START = 11,
  WMCT_QUEST_FINISH = 12,
  WMCT_UNLOCK_POINT = 13,
  WMCT_CROP_LOCATE = 14,
  WMCT_CROP_UNLOCATE = 15,
  WMCT_CROP_TAKE = 16,
  WMCT_MOUNT = 17,
  WMCT_GROUP = 18,
  WMCT_PLAYER = 19,
  WMCT_NAME = 20,
  WMCT_FACE = 21,
  WMCT_HOME_LEVEL = 22,
  WMCT_CHAT = 23,
  WMCT_KICK = 24,
  WMCT_PLAYER_STATUS = 25,
  WMCT_PRODUCT_START = 26,
  WMCT_PRODUCT_FINISH = 27,
  WMCT_PRODUCT_CANCEL = 28,
  WMCT_FIELD_OPEN = 29,
  WMCT_FIELD_CLOSE = 30,
  WMCT_FIELD_PLANT = 31,
  WMCT_FIELD_WATER = 32,
  WMCT_FIELD_HARVEST = 33,
  WMCT_FIELD_UNPLANT = 34,
  WMCT_FIELD_AUTO_WATER = 35,
  WMCT_HOUSE_REFRESH = 36,
  WMCT_RECORD = 37,
  WMCT_TIMER = 38,
  WMCT_PET_CANTEEN_REFRESH = 39,
  WMCT_HATCH_REFRESH = 40,
  WMCT_COLLECT_BUILD = 41,
  WMCT_SPECIAL = 42,
  WMCT_RETRACT = 43,
  WMCT_HOME_INIT = 44,
  WMCT_HOME_REFRESH = 45,
  WMCT_ACED = 46,
  WMCT_DYNAMIC_REFRESH = 47,
  WMCT_BLUE_PRINT = 48,
  WMCT_RELOAD_WORLD_FLOW = 49,
  WMCT_MONSTER_INFO_CHANGE = 50,
  WMCT_GM_RESET_ITEM = 255,
  WMCT_ENTER = 256
}
L_Const.WorldMapQuestStatusType = {
  WMQST_NONE = 0,
  WMQST_START = 1,
  WMQST_FINISH = 2
}
L_Const.WorldMapPlayerDirtyType = {
  WMPDT_MOVE = 0,
  WMPDT_STATUS = 1,
  WMPDT_PET = 2,
  WMPDT_MOUNT = 3,
  WMPDT_GROUP = 4,
  WMPDT_NAME = 5,
  WMPDT_FACE = 6
}
L_Const.WorldMapItemType = {WMIT_PRIVATE = 0, WMIT_PUBLIC = 1}
L_Const.CatchPetType = {CPT_SINGLE = 1, CPT_MUILT = 2}
L_Const.WorldMapChangeStatusReason = {WMCSR_NORMAL = 0, WMCSR_DIE = 1}
L_Const.WorldObjType = {
  WOT_NONE = 0,
  WOT_NPC = 1,
  WOT_ENEMY = 2,
  WOT_ITEM = 3,
  WOT_ENVIRONMENT = 4,
  WOT_DESTROY = 12,
  WOT_PUZZLE_ITEM = 13,
  WOT_PUZZLE_OBJECT = 18,
  WOT_TELEPORT_SMALL = 21,
  WOT_TELEPORT_BIG = 22,
  WOT_TELEPORT_EDGE = 23,
  WOT_TREASURE_CHEST = 30,
  WOT_PET_EGG = 31,
  WOT_MONSTER = 50,
  WOT_RANDOM_MONSTER = 51,
  WOT_CHEST_MONSTER = 52,
  WOT_AFFIX_BOSS = 53,
  WOT_INVISIBLE_WALL = 71,
  WOT_TRIGGER = 73,
  WOT_PUZZLE = 101,
  WOT_PUZZLE_PROPERTY = 161,
  WOT_PUZZLE_SKILL = 162,
  WOT_PUZZLE_WUMI = 163,
  WOT_HOME_ITEM = 201,
  WOT_BATTLE_CAMPAIGN = 301,
  WOT_WORLD_COLLET_BUILD = 302,
  WOT_DUNGEON_TELEPORT = 303,
  WOT_DUNGEON_REWARD = 304,
  WOT_DUNGEON_DROP_AREA = 305,
  WOT_DUNGEON_ACTIVE = 306,
  WOT_RANDOM_TASK_AREA = 307,
  WOT_WEEK_BOSS = 308,
  WOT_FISH = 309
}
L_Const.WorldObjRefreshType = {
  WORT_FINISH = 1,
  WORT_DAILY = 2,
  WORT_GROUP_DAILY = 4,
  WORT_WEEKLY = 5,
  WORT_FINISH_DAILY = 6
}
L_Const.WorldMonsterSettleType = {WMST_NORMAL = 0, WMST_ROUNDS = 1}
L_Const.WorldMonsterFillType = {WMFT_NORMAL = 0, WMFT_RANDOM = 1}
L_Const.WorldMapTransportType = {WMTT_MINIMAP = 0, WMTT_TRANSDOOR = 1}
L_Const.EnterWorldMapAction = {EWMA_INVALID = 0, EWMA_LEAVE_AREA_LINE = 1}
L_Const.WorldObjInteractType = {
  INTERACT_NORMAL = 0,
  INTERACT_COLLECT_TOOL = 1,
  INTERACT_ATTACKED = 2
}
L_Const.ExtContextType = {ECT_QIBO_PUZZLE = 1}
L_Const.PlayerActiveBehavior = {
  PAB_FALL = 1,
  PAB_REVIVE_LAST_POINT = 2,
  PAB_NEAR_TRANS_POINT = 3
}
L_Const.PlayableStatusType = {
  PST_NONE = 0,
  PST_START = 1,
  PST_COMPLETE = 2,
  PST_FINISH = 3
}
L_Const.WorldVotingType = {
  WorldVotingType_None = 0,
  WorldVotingType_TimeLine = 1,
  WorldVotingType_Transfer = 2
}
L_Const.WorldVotingVal = {
  WorldVotingVal_None = 0,
  WorldVotingVal_Waiver = 1,
  WorldVotingVal_No = 2,
  WorldVotingVal_Yes = 3
}
L_Const.WorldObjSearchType = {
  WOST_PET_EGG = 1,
  WOST_PET_SPECIAL = 2,
  WOST_PET_ALL = 3
}
L_Const.DBCheckReserveErrCode = {DBCheckReserveErrCodeOK = 0, DBCheckReserveErrCodeLimit = 1}
