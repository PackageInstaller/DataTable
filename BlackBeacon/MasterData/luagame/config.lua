local ShareRes = require("utils.share_res")
local config = {}
local Logger = require("utils.logger")
local FightDefine = require("cs_share.fight_define")
FightDefine.CLIENT_ENV = true
local CommonDef = require("cs_share.common_define")
local MagicDefine = require("cs_share.magic_def")
local lua_behavior_define = require("common.lua_behavior_define")
config.SCENE_FINAL_SUFFIX = "_final"
config.UI_GROUPS = {
  GROUP_NORMAL = "GroupNormal",
  GROUP_SPECIAL = "GroupSpecial",
  GROUP_CINEMA = "GroupCinema",
  GROUP_WORLD = "GroupWorld"
}
config.TIME_UNIT = {
  DAY = 1,
  HOUR = 2,
  MINUTE = 3
}
config.A_LARGE_NUM = 1.0E9
config.METER_PER_CELL = 0.5
config.CAMPS = {FRIEND = 1, ENEMY = 2}

function config.get_camp(self_camp, relationship)
  local npc_camp
  if self_camp == CAMPS.FRIEND and relationship == RELATIONSHIP.SIMILAR or self_camp == CAMPS.ENEMY and relationship == RELATIONSHIP.OPPOSED then
    npc_camp = CAMPS.FRIEND
  elseif self_camp == CAMPS.FRIEND and relationship == RELATIONSHIP.OPPOSED or self_camp == CAMPS.ENEMY and relationship == RELATIONSHIP.SIMILAR then
    npc_camp = CAMPS.ENEMY
  end
  return npc_camp
end

config.RELATIONSHIP = {
  MYSELF = 1,
  SIMILAR = 2,
  EXCEPT_OPPOSED = 3,
  OPPOSED = 4,
  EXCEPT_SELF = 6
}
config.BIND_TYPE = {
  OBJECT = 1,
  TRANSFORM = 2,
  IMAGE = 3,
  RAW_IMAGE = 4,
  TEXT = 5,
  BUTTON = 6,
  TOGGLE = 7,
  INPUT = 8,
  SCROLL = 9,
  DROPDOWN = 10,
  SLIDER = 11,
  BUTTON_EX = 12,
  SCROLL_EX = 13,
  UIPARTICLE = 14,
  PLAYABLEDIRECTOR = 15,
  CANVAS_GROUP = 16
}
config.TERRAIN_TAG = {WATER = "Water"}
config.SPECIAL_TERRAIN = {
  [config.TERRAIN_TAG.WATER] = {
    effect = "Fx_Common_step_water",
    sound = "",
    tag = config.TERRAIN_TAG.WATER,
    container_objs_name = "WaterObjs"
  }
}
config.SCENE_HEIGHT_OFFSET = {Scene005_01 = 0.55}
config.UI_VIEW_LEVEL = {MAIN_VIEW = 1}
config.UI_SORT_ORDER = {
  MainView = 0,
  System = 10,
  PopUpWindow = 20,
  LowTip = 45,
  Tip = 50,
  SeniorTip = 70,
  Dialog = 90,
  Tutorial = 130,
  Special = 170,
  Alert = 200,
  Click = 300
}
config.UI_TYPE = {
  PAGE_ATTR = 1,
  PAGE_BAG = 2,
  PAGE_INFO = 3,
  PAGE_DETAIL = 4,
  PAGE_DEV = 5
}
config.WEAK_METATABLE = {__mode = "kv"}
config.KEY_WEAK_METATABLE = {__mode = "k"}
config.VALUE_WEAK_METATABLE = {__mode = "v"}
Global.i18n = ShareRes.create("langs.langs")
config.HPBAR_TYPE = {COMMON = 0, BOSS = 1}
config.MISSILE_TYPE = {
  COMMON = 1,
  JUDG = 2,
  Dodge = 3,
  SnapShoot = 4
}
config.MISSILE_SHAPE = {
  RECT = 1,
  CIRCLE = 2,
  SECTOR = 3,
  ANNULAR = 4,
  CIRCLE_X = 5,
  SPHERE = 6
}
config.MISSILE_BORN_POS_TYPE = {
  LAUNCHER = 0,
  TARGET = 1,
  PARENT = 2,
  BYPARAM = 3,
  BYBRONPOS = 4
}
config.MISSILE_TYPE_TAG = {
  MELEE = 1,
  RANGE = 2,
  OBSTACLE = 6,
  BOUND = 7
}
config.NUM_TO_RATIO = 1.0E-4
config.RATIO_TO_NUM = 10000
config.QTE_BASE_CD = 100
config.MODEL_VIEW = "ui/common/systemmodelview.prefab"
config.GAME_CAMER_PREFAB = "GameCamera"
config.LOW_UPDATE_INTERVAL = 0.03333333333333333
config.VERY_LOW_UPDATE_INTERVAL = 0.1
config.CAMERA_DEFAULT_OFFSET = 0.5
config.ROLE_MOVE_TYPE = {
  run = 0,
  forward = 1,
  back = 2,
  left = 3,
  right = 4
}
config.TEST_SCENE_CFG = {MapName = "Scene07005", is_old = true}
config.EMPTY_SCENE_CFG = {MapName = "Main", is_old = false}
config.STATE_RELATION = {
  can_transit = 0,
  can_not_transit = 1,
  can_coexist = 2,
  can_not_coexist = 3,
  can_not_transit_or_coexist = 4,
  can_reenter = 5,
  can_not_reenter = 6
}
config.BEHAVIOR_TRIGGER_TYPE = {
  ON_FRAME = 1,
  ON_SWITCHNPC = 2,
  ON_BEFORECURE = 3,
  ON_AFTERCURE = 4,
  ON_BEFOREDAMAGE = 5,
  ON_AFTERDAMAGE = 6,
  ON_NPCWILLDIE = 7,
  ON_NPCDIE = 8,
  ON_SKILL = 9,
  ON_BEHIT = 10,
  ON_BALL = 11,
  ON_EVENT = 12,
  ON_PREADDBALL = 13,
  ON_AFTERFRAME = 14,
  ON_DODGE = 15,
  ON_BEDODGE = 16,
  ON_SKILLFINISH = 17,
  ON_SKILLABORT = 18
}
config.BEHAVIOR_NODE_TYPE = {
  ACTION_NODE = 0,
  SELECTOR_NODE = 1,
  SEQUENCE_NODE = 2,
  PARALLEL_NODE = 3,
  RANDOM_NODE = 4
}
config.ACT_DEFINE = {
  Idle = "arder_idle",
  Idle2 = "idle",
  StandChange = "arder_switch",
  RunStart = "runstart",
  Run = "run",
  Idle3 = "idle3",
  Walk = "walk",
  Walkb = "walk_b",
  Walkl = "walk_l",
  Walkr = "walk_r",
  RunStartEnd1 = "runstart_stop_L",
  RunEnd1 = "run_stop_L",
  Hit = "hit",
  Die = "die",
  Die1 = "die1",
  BeHitFly = "hurt_fly",
  Falldown = "fall_ground",
  Lieonfloor = "lie",
  Standup = "lie_to_stand",
  Hoverhit = "hurt_fly_hit",
  HoverHitRoll = "hurt_fly_hit1",
  BeHitRollFly = "hurt_fly1",
  LieHit = "lie_hit",
  TurnOver = "turn_over",
  StunStart = "stun1_1",
  Stun = "stun1_2",
  StunEnd = "stun1_3",
  StunStart2 = "stun2_1",
  Stun2 = "stun2_2",
  StunEnd2 = "stun2_3",
  StunStart3 = "stun3_1",
  Stun3 = "stun3_2",
  StunEnd3 = "stun3_3",
  StunHitL = "stun_hit_L",
  StunHitR = "stun_hit_R",
  FinishLoop = "finish_loop",
  Interact = "interact",
  UIMainIdle = "uimain_idle",
  WeaponIdle = "weapon_idle"
}
config.CHARACTER_STATE_TYPE = {
  IDLE = 0,
  ATTACK = 1,
  BEATTACK = 2,
  DYING = 3,
  CREATING = 4,
  DIE = 5,
  BEGRAB = 6,
  TIMELINE = 7,
  ENTERING = 8,
  MOVE = 9,
  FLY = 10,
  FALL = 11,
  TURN_OVER_FORBIT = 12,
  TURN_OVER = 13,
  STUN = 14,
  PERCENT_DAMAGE_ON_SEC = 15
}
config.STATE_NAME = {
  move = "移动",
  auto_forward_move = "自动向前移动",
  idle = "休闲",
  beattack = "受击",
  attack = "攻击",
  run = "移动",
  die = "死亡",
  anim = "播放动画",
  behitfly = "击飞",
  born = "出生",
  relive = "复活",
  jump = "跳跃",
  stun = "定身",
  fall = "倒地",
  turnover = "倒地受身",
  percentdamage = "X秒内受伤XX%"
}
local ACTS = config.ACT_DEFINE
config.NEED_SPEED_ACTS = {
  [ACTS.RunStart] = true,
  [ACTS.RunStartEnd1] = true
}
local STATE_NAME = config.STATE_NAME
local STATE = config.CHARACTER_STATE_TYPE
config.STATE_NAME_TO_ID = {
  [STATE_NAME.die] = {
    id = STATE.DIE,
    sort_val = 1
  },
  [STATE_NAME.attack] = {
    id = STATE.ATTACK,
    sort_val = 2
  },
  [STATE_NAME.beattack] = {
    id = STATE.BEATTACK,
    sort_val = 3
  },
  [STATE_NAME.idle] = {
    id = STATE.IDLE,
    sort_val = 4
  },
  [STATE_NAME.move] = {
    id = STATE.MOVE,
    sort_val = 5
  },
  [STATE_NAME.fall] = {
    id = STATE.FALL,
    sort_val = 6
  },
  [STATE_NAME.behitfly] = {
    id = STATE.FLY,
    sort_val = 7
  },
  [STATE_NAME.turnover] = {
    id = STATE.TURN_OVER,
    sort_val = 8
  }
}
config.STATE_ID_TO_NAME = {
  [STATE.MOVE] = {
    STATE_NAME.move,
    STATE_NAME.run
  },
  [STATE.IDLE] = {
    STATE_NAME.idle
  },
  [STATE.BEATTACK] = {
    STATE_NAME.beattack,
    STATE_NAME.behitfly
  },
  [STATE.ATTACK] = {
    STATE_NAME.attack
  },
  [STATE.DIE] = {
    STATE_NAME.die
  },
  [STATE.FLY] = {
    STATE_NAME.behitfly
  },
  [STATE.FALL] = {
    STATE_NAME.fall
  },
  [STATE.STUN] = {
    STATE_NAME.stun
  }
}
config.MOVE_INERTIAL_STATE = {SLOW_DOWN = 1, SPEED_UP = 2}
config.AWARD_TYPE = {
  RES = 1,
  ITEM = 2,
  FRAGMENT = 3,
  GAME_COIN = 4,
  CHARA = 5,
  EQUIP = 6,
  BATTLE_RES = 7,
  BATTLE_ITEM = 8,
  BATTLE_COLLECTION = 9,
  MOON = 10,
  AVATAR = 11,
  STOCK_ITEM = 12,
  FASHION = 13,
  MAIN_COLLECTION = 18,
  TITTLE = 19,
  TITTLE_CARD = 22,
  RELIC = 23,
  SOURCE = 25,
  PUZZLE = 26,
  EQUIP_FASHION = 29
}
config.INPUT_CODE = {
  FORWARD = 1,
  BACKWARD = 2,
  LEFT = 3,
  RIGHT = 4,
  INPUT_COMMON = 15,
  INPUT_DODGE = 16,
  INPUT_SPECAIL_SKILL = 17,
  INPUT_SKILL1 = 18,
  INPUT_SKILL2 = 19,
  INPUT_SKILL3 = 20,
  QTE1 = 21,
  QTE2 = 22,
  INPUT_SKILL4 = 23,
  OPERATE_CHAR1 = 24,
  INPUT_LOCK_TAR = 48,
  AIM_JOYSTICK = 49,
  TOWER_SKILL = 60,
  TPS_SKILL = 61,
  TPS_ATK_SKILL = 62,
  INPUT_INTERACT = 63,
  QTE_UltSkill_1 = 64,
  QTE_UltSkill_2 = 65,
  INPUT_NAVIGATION = 66
}
config.BIND_LAUNCHER = {
  NONE = 0,
  ONLY_POS = 1,
  ONLY_ROTATION = 2,
  ALL = 3
}
config.BEHIT_TYEP = {
  NONE = 0,
  LEFT_SMALL = 1,
  RIGHT_SMALL = 2,
  LEFT_LARGE = 3,
  RIGHT_LARGE = 4,
  HIT_FLY = 5,
  HIT_DOWN = 6,
  COMBO_HIT_LEFT_START = 7,
  COMBO_HIT_RIGHT_START = 8,
  ROLL_HIT_FLY = 9
}
config.BEHIT_ACTION = {
  [config.BEHIT_TYEP.LEFT_SMALL] = "hurt_l_1",
  [config.BEHIT_TYEP.RIGHT_SMALL] = "hurt_r_1",
  [config.BEHIT_TYEP.LEFT_LARGE] = "hurt_l_2",
  [config.BEHIT_TYEP.RIGHT_LARGE] = "hurt_r_2"
}
config.DAMAGE_TYPE = {SHARP = 1, BLUNT = 2}
config.BEHIT_BONE_SHAKE = {
  [config.BEHIT_TYEP.LEFT_SMALL] = 1,
  [config.BEHIT_TYEP.RIGHT_SMALL] = 2,
  [config.BEHIT_TYEP.LEFT_LARGE] = 1,
  [config.BEHIT_TYEP.RIGHT_LARGE] = 2,
  [config.BEHIT_TYEP.HIT_FLY] = 3,
  [config.BEHIT_TYEP.HIT_DOWN] = 4
}
config.ROOT_BONE_SHAKE_NAME = "Bip001"
config.ATTACK_QUIT_TYPE = {END_BY_ANIMATION = 0, END_BY_SKILL_TIME = 1}
config.IMMUNIT_TYPE = {
  IMMUNIT_ALL = 1,
  EXCEPT_HAD = 2,
  EXCEPT_ADD = 3
}
config.ATTR_MAX_TAG = 1
config.CHAR_ATTR_TYPE = {
  CHAR_HP = 1,
  CHAR_SP = 2,
  CHAR_HP_MAX = 4,
  CHAR_SP_MAX = 5,
  RECOVER_ENERGY_ADDITIVE = FightDefine.ATTR_TYPE.RECOVER_ENERGY_ADDITIVE
}
config.HP_ATTR_TYPE = {
  [FightDefine.ATTR_TYPE.CHAR_HP] = FightDefine.ATTR_TYPE.CHAR_HP,
  [FightDefine.ATTR_TYPE.CHAR_HP_MAX] = FightDefine.ATTR_TYPE.CHAR_HP_MAX
}
config.ATTR_GROUP_TYPE = {
  BASE = 1,
  ADDITIVE = 2,
  MODULE_ATTR = 3,
  EQUIP_ATTR = 4,
  NO_FIGHT_ATTR = 5
}
config.ATTR_SET_TYPE = {CHANGE_BY_DELTA = 1, REPLACE = 2}
config.ENERGY_ATTR_SET_TYPE = {REDUCE = 1, ADD = 2}
config.ENERGY_TYPE = {CUR_ENERGY = 0, MAX_ENERGY = 1}
config.RATIO_TYPE = {CUR = 1, MAX = 2}
config.ANIMATOR_DEFAULT_LAYER = 0
config.ANIMATOR_ATTACK_LAYER = 1
config.LOGIC_FRAME = 0.05
config.ANIMATOR_RUNSPEED = 5
config.DEFAULT_HIT_POINT = "HitCase"
config.UI_POINT_NAME = "attachpoint"
config.PRELOAD_MATS = {
  "ShadowCaster"
}
config.TAG = {Plat = "Plat"}
config.MAGIC_FUNC_MAP = {
  [1] = "ChangeTimeScale",
  [2] = "ChangeAttribAdditive",
  [3] = "AddBehavior",
  [4] = "ShakeCamera",
  [5] = "PlayCameraTrack",
  [6] = "SetNpcStatus",
  [7] = "HideJoint",
  [8] = "PlayEffect",
  [9] = nil,
  [10] = "ForceShift",
  [11] = "CamPosition",
  [12] = "CamPositionRotation",
  [13] = "CamFOV",
  [14] = "ChangeAttr",
  [15] = "SkillEnergy",
  [16] = "FightBtnEffect",
  [17] = "HurtDamage",
  [18] = "AbnorDamage",
  [19] = "UIObjectVisble"
}
config.SHADOWCASTER_MAT = "ShadowCaster"
config.system_modules = {
  {
    global_name = "SysOpenMgr",
    class = "sys_open.sys_mgr",
    is_init_client_only = false
  },
  {
    global_name = "CharacterMgr",
    class = "character.character_mgr",
    is_init_client_only = false
  },
  {
    global_name = "TowerMgr",
    class = "tower_mgr.tower_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BagMgr",
    class = "character.bag_mgr",
    is_init_client_only = false
  },
  {
    global_name = "StoryMgr",
    class = "story_mgr.story_mgr",
    is_init_client_only = true
  },
  {
    global_name = "ChapterMgr",
    class = "chapter.chapter_mgr",
    is_init_client_only = false
  },
  {
    global_name = "ChapterMaterialMgr",
    class = "chapter.chapter_material_mgr",
    is_init_client_only = false
  },
  {
    global_name = "ChapterEndlessMgr",
    class = "chapter.chapter_endless_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BossChallengeMgr",
    class = "boss_challenge.boss_challenge_mgr",
    is_init_client_only = true
  },
  {
    global_name = "SceneEventMgr",
    class = "scene_event.scene_event_mgr",
    is_init_client_only = false
  },
  {
    global_name = "TaskMgr",
    class = "task.task_mgr",
    is_init_client_only = false
  },
  {
    global_name = "FormationMgr",
    class = "formation.formation_mgr",
    is_init_client_only = false
  },
  {
    global_name = "JournalMgr",
    class = "debug.journal_mgr",
    is_init_client_only = true
  },
  {
    global_name = "MailMgr",
    class = "mail.mail_mgr",
    is_init_client_only = false
  },
  {
    global_name = "FightBagMgr",
    class = "character.fight_bag_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BattleShopMgr",
    class = "battleshop.battle_shop_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BattleTalentMgr",
    class = "battle_talent.battle_talent_mgr",
    is_init_client_only = false
  },
  {
    global_name = "SignInMgr",
    class = "sign_in.sign_in_mgr",
    is_init_client_only = false
  },
  {
    global_name = "NoticeMgr",
    class = "notice.notice_mgr",
    is_init_client_only = false
  },
  {
    global_name = "PlayerMgr",
    class = "player.player_mgr",
    is_init_clint_only = false
  },
  {
    global_name = "ShopMgr",
    class = "shop.shop_mgr",
    is_init_client_only = false
  },
  {
    global_name = "FriendMgr",
    class = "friend.friend_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BattleTreasureMgr",
    class = "battle_treasure.battle_treasure_mgr",
    is_init_client_only = false
  },
  {
    global_name = "FunctionalNpcMgr",
    class = "functional_npc.functional_npc_mgr",
    is_init_client_only = false
  },
  {
    global_name = "FashionMgr",
    class = "fashion_mgr.fashion_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BattleSkillBookMgr",
    class = "battle_skill.battle_skill_mgr",
    is_init_client_only = true
  },
  {
    global_name = "ChatMgr",
    class = "chat.chat_mgr",
    is_init_client_only = false
  },
  {
    global_name = "NewbieTowerMgr",
    class = "newbie_tower.newbie_tower_mgr",
    is_init_client_only = false
  },
  {
    global_name = "NoviceMgr",
    class = "novice.novice_mgr",
    is_init_client_only = false
  },
  {
    global_name = "DrawCardMgr",
    class = "drawcard.drawcard_mgr",
    is_init_client_only = false
  },
  {
    global_name = "MarqueeMgr",
    class = "marquee.marquee_mgr",
    is_init_client_only = false
  },
  {
    global_name = "GuideMgr",
    class = "guide.guide_mgr",
    is_init_client_only = false,
    can_update = true
  },
  {
    global_name = "BattleSettingMgr",
    class = "battle_setting.battle_setting_mgr",
    is_init_client_only = true
  },
  {
    global_name = "FixedBuddyMgr",
    class = "character.fixed_buddy_mgr",
    is_init_client_only = true
  },
  {
    global_name = "FixedBuddyPoolMgr",
    class = "character.fixed_buddy_pool_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BattleTaskMgr",
    class = "battle_task.battle_task_mgr",
    is_init_client_only = false,
    can_update = true
  },
  {
    global_name = "SignBoardGirlMgr",
    class = "signboard_girl.signboard_girl_mgr",
    is_init_client_only = false
  },
  {
    global_name = "NoFightGameMgr",
    class = "no_fight_game.no_fight_game_mgr",
    is_init_client_only = false
  },
  {
    global_name = "DropShowMgr",
    class = "drop_show.drop_show_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BattleTreasureBoxMgr",
    class = "battle_treasure.battle_treasure_box_mgr",
    is_init_client_only = false
  },
  {
    global_name = "ActivityMgr",
    class = "activity.activity_mgr",
    is_init_client_only = false,
    can_update = true
  },
  {
    global_name = "ChallengeRingMgr",
    class = "challenge_ring.challenge_ring_mgr",
    is_init_client_only = false
  },
  {
    global_name = "RuneMgr",
    class = "activity.rune_mgr",
    is_init_client_only = false
  },
  {
    global_name = "InitBoxMgr",
    class = "init_box.init_box_mgr",
    is_init_client_only = false
  },
  {
    global_name = "GraphicGuideMgr",
    class = "graphic_guide.graphic_guide_mgr",
    is_init_client_only = false
  },
  {
    global_name = "ArchiveMgr",
    class = "archive.archive_mgr",
    is_init_client_only = false
  },
  {
    global_name = "Rune2Mgr",
    class = "activity.rune2_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BattleOrnamentMgr",
    class = "battle_ornament.battle_ornament_mgr",
    is_init_client_only = false
  },
  {
    global_name = "RechargeMgr",
    class = "shop.recharge_mgr",
    is_init_client_only = false
  },
  {
    global_name = "TreasureChestMgr",
    class = "treasure_chest.treasure_chest_mgr",
    is_init_client_only = false
  },
  {
    global_name = "UnionMgr",
    class = "union.union_mgr",
    is_init_client_only = false
  },
  {
    global_name = "ChallengeRingPlusMgr",
    class = "challenge_ring.challenge_ring_plus_mgr",
    is_init_client_only = false
  },
  {
    global_name = "BuffMgr",
    class = "character.buff_mgr",
    is_init_client_only = false
  },
  {
    global_name = "PlayerSundryMgr",
    class = "player.player_sundry_mgr",
    is_init_client_only = false
  },
  {
    global_name = "WeeklyMgr",
    class = "weekly.weekly_mgr",
    is_init_client_only = false
  },
  {
    global_name = "GeCaoBattleMgr",
    class = "gecao_battle_mgr.gecao_battle_mgr",
    is_init_client_only = true
  },
  {
    global_name = "AssistMgr",
    class = "assist.assist_mgr",
    is_init_client_only = false
  },
  {
    global_name = "TimeLineMgr",
    class = "timeline_mgr.timeline_mgr",
    is_init_client_only = true
  },
  {
    global_name = "PlayerJourneyMgr",
    class = "player.player_journey_mgr",
    is_init_client_only = false
  },
  {
    global_name = "GenresMgr",
    class = "genres.genres_mgr",
    is_init_client_only = false
  },
  {
    global_name = "RelicMgr",
    class = "character.relic_mgr",
    is_init_client_only = false
  },
  {
    global_name = "UIMainBubbleMgr",
    class = "uimain.uimain_bubble_mgr",
    is_init_client_only = true
  },
  {
    global_name = "JumpTeamMgr",
    class = "jump_team.jump_team_mgr",
    is_init_client_only = false
  },
  {
    global_name = "PlayerPrefsMgr",
    class = "playerprefs.playerprefs_mgr",
    is_init_client_only = false
  },
  {
    global_name = "LinearMgr",
    class = "linear.linear_mgr",
    is_init_client_only = false
  },
  {
    global_name = "ClimbingTowerMgr",
    class = "climbing_tower.climbing_tower_mgr",
    is_init_client_only = false
  },
  {
    global_name = "FateBookMgr",
    class = "fate_book.fate_book_mgr",
    is_init_client_only = false
  },
  {
    global_name = "PassPortMgr",
    class = "passport_mgr.passport_mgr",
    is_init_client_only = false
  },
  {
    global_name = "PopUpWindowMgr",
    class = "pop_up_window.popupwindow_mgr",
    is_init_client_only = true
  },
  {
    global_name = "GemStoneMgr",
    class = "character.gem_stone_mgr",
    is_init_client_only = false
  },
  {
    global_name = "FightDataMgr",
    class = "fight.fight_data_mgr",
    is_init_client_only = true
  },
  {
    global_name = "PuzzleMgr",
    class = "character.puzzle_mgr",
    is_init_client_only = true
  },
  {
    global_name = "JourneyEventMgr",
    class = "journey_event.journey_event_mgr",
    is_init_client_only = true
  },
  {
    global_name = "BuildingMgr",
    class = "building.building_mgr"
  },
  {
    global_name = "PhotoMgr",
    class = "uimain.uimain_photo_mgr"
  },
  {
    global_name = "BuddyTryoutMgr",
    class = "novice.buddy_tryout_mgr"
  },
  {
    global_name = "CatchCatMgr",
    class = "novice.catch_cat_mgr"
  },
  {
    global_name = "MonkeyTyperMgr",
    class = "novice.monkey_typer_mgr"
  },
  {
    global_name = "PuzzleGameMgr",
    class = "novice.puzzle_game_mgr"
  },
  {
    global_name = "MusicGameMgr",
    class = "novice.music_game_mgr"
  },
  {
    global_name = "BarbecueGameMgr",
    class = "novice.barbecue_game_mgr"
  },
  {
    global_name = "SimpleTagMgr",
    class = "fight.simple_tag_mgr",
    is_init_client_only = true
  },
  {
    global_name = "UIEffectMgr",
    class = "ui.ui_effect_manager",
    is_init_client_only = true
  },
  {
    global_name = "RankMgr",
    class = "rank.rank_mgr",
    is_init_client_only = true
  },
  {
    global_name = "VisualGameManager",
    class = "visual_gameplay.visualgame_manager",
    is_init_client_only = true
  },
  {
    global_name = "CaptureMgr",
    class = "capture.capture_mgr",
    is_init_client_only = true
  },
  {
    global_name = "CompensateMgr",
    class = "compensate.compensate_mgr",
    is_init_client_only = false
  },
  {
    global_name = "TimeLimitedActMgr",
    class = "activity.time_limited_activity_mgr",
    is_init_client_only = true
  },
  {
    global_name = "MineSweeperMgr",
    class = "minesweeper.minesweeper_mgr",
    is_init_client_only = true
  },
  {
    global_name = "MineSweeperBattleMgr",
    class = "minesweeper.minesweeper_battle_mgr",
    is_init_client_only = true
  },
  {
    global_name = "DailyActMgr",
    class = "activity.daily_act_mgr",
    is_init_client_only = true
  },
  {
    global_name = "LivenessGiftMgr",
    class = "shop.liveness_gift_mgr",
    is_init_client_only = true
  }
}
config.SELECTED_SERVER_KEY = "selected_server_key"
config.MAX_BREAK_LV = 3
config.EXP_ITEMID = 1
config.COIN_ITEMID = 2
config.DIAMOND_ITEMID = 3
config.PLAYER_SP_ITEMID = 4
config.GILTGOLD_ITEMID = 5
config.DP_ITEMID = 7
config.FATE_TICKET_ITEMID = 11
config.DAILY_TASK_POINT = 8
config.WEEKLY_TASK_POINT = 9
config.CURSE_COST_ID = 11
config.NORMAL_ROLL_ITEMID = 21
config.SPECIAL_ROLL_ITEMID = 22
config.WEAPON_TONGTIAO_ITEMID = 33
config.PUZZLE_REFINE_COIN = 37
config.CURSE_GOLD = 500001
config.RES_DIVISION_VAL = 999
config.BACKGROUND_HERO_POS = 3000
config.MISSILE_PART_DEG = 180
config.WRITER_LOG_KEY = "writer_log_key"
config.WRITE_RPC_LOG_KEY = "write_rpc_log_key"
config.UPLOAD_ERROR_KEY = "upload_error_key"
config.SKILL_ATTACK_TYPE = {
  NORMAL = 1,
  COUNTER = 2,
  SMALL_SKILL = 3,
  BIG_SKILL = 4,
  APPEAR = 5,
  LEVEL = 6
}
config.MAGIC_SRC = {
  MISSILE = 1,
  SKILL = 2,
  BEHAVIOR = 3
}
config.CHAR_EFFECT = {
  SHADOW = "shadow",
  RIM = "rim",
  PLANE_SHADOW = "plane_shadow"
}
config.EXCHANGE_TYPE = {DEFAULT = 1, ZHONGQIU_ACTIVITY = 2}
config.NAME_TO_ID_ITEM_TYPE = {
  BATTLE_ITEM = "battle_item",
  ITEM = "item"
}
config.ITEM_TIPS_TYPE = {
  COMMON = 1,
  SHOP = 2,
  BAG = 3
}
config.ITEM_SHOW_TYPE = {DETAIL = 1, SOURCE = 2}
config.BAG_TYPE = {
  RESOURCE = 1,
  ITEM = 2,
  FRAGMENT = 3,
  CURRENTY = 4,
  HERO = 5,
  WEAPON = 6,
  FIGHT_CURRENCY = 7,
  FIGHT_ITEM = 8,
  FIGHT_WEAPON = 9,
  MONTH_CARD = 10,
  HERP_ICON = 11,
  INVENTORY = 12,
  GEMSTONE = 25
}
config.CHAPTER_OPEN_KEY = "chapter_open_key"
config.NEW_CHAPTER_OPEN_KEY = "new_chapter_open_key"
config.RESET_DATA_HOUR = 5
config.SECTOR_COLLIDER_DEGREE = {
  30,
  45,
  60,
  90,
  120,
  135,
  150,
  180,
  225,
  270,
  315,
  360
}
config.CONNECT = {LOBBY = 1, FIGHT = 2}
config.ROOM_TYPE = {
  LITTLE_MOB1 = 1,
  LITTLE_MOB2 = 2,
  LITTLE_MOB3 = 3,
  LITTLE_MOB4 = 4,
  LITTLE_MOB5 = 5,
  LITTLE_MOB6 = 6,
  LITTLE_MOB7 = 7,
  LITTLE_MOB8 = 8,
  LITTLE_MOB9 = 9,
  LITTLE_MOB10 = 10,
  SPECIAL_MOB = 11,
  BOSS = 12,
  TREASURE = 13,
  START = 14,
  REST = 15,
  SHOP = 16,
  CAST = 17,
  NO_FIGHT_GAME = 21,
  CHALLENGE = 22,
  PUZZLE = 23,
  MAZE = 28
}
config.EVENT_TRIGGER_TYPE = {
  PointerEnter = 0,
  PointerExit = 1,
  PointerDown = 2,
  PointerUp = 3,
  PointerClick = 4,
  Drag = 5,
  Drop = 6,
  Scroll = 7,
  UpdateSelected = 8,
  Select = 9,
  Deselect = 10,
  Move = 11,
  InitializePotentialDrag = 12,
  BeginDrag = 13,
  EndDrag = 14,
  Submit = 15,
  Cancel = 16
}
config.RECT_TRANSFORM_EDGE = {
  Left = 0,
  Right = 1,
  Top = 2,
  Bottom = 3
}
config.FUNCTIONAL_NPC_SHOW_TYPE = {
  Dialog = 1,
  Treasure = 2,
  TASK = 3,
  Challenge = 4,
  NoFightGame = 5,
  ChallengeRing = 6,
  Door = 7,
  InitBox = 8,
  NormalDrop = 9,
  Casting = 10,
  CurseRing = 11
}
config.MAIN_SCENE_ID = 100
config.iOSDeviceGeneration = {
  iPhoneXR = 42,
  iPhone11 = 48,
  iPhone12 = 57,
  iPhone13 = 64,
  iPhone14Pro = 74
}
config.iOSLowMemoryDeviceGeneration = {
  iPadPro11Inch = 43,
  iPadPro3Gen = 44,
  iPadAir3Gen = 46,
  iPadMini5Gen = 47,
  iPhone11 = 48,
  iPhone11Pro = 49,
  iPhone11ProMax = 50,
  iPad7Gen = 52,
  iPhoneSE2Gen = 53,
  iPadPro11Inch2Gen = 54,
  iPhone12Mini = 56,
  iPhone12 = 57,
  iPad8Gen = 60,
  iPadAir4Gen = 61,
  iPad9Gen = 62,
  iPadMini6Gen = 63,
  iPhone13 = 64,
  iPhone13Mini = 65,
  iPhoneSE3Gen = 70,
  iPhone14 = 72
}
config.SOUND_SOURCE_TYPE = {BGM = 1, EFFECT = 2}
config.REBORN_TYPE = {NORMAL = 1, INFINITE_FREE = 2}
config.CAMERA_VIEW_TYPE_ID = {
  SHOULDER_ANGLE = ShareRes.get_comm_value("DefaultShoulderCameraId"),
  DEPRESSION_ANGLE = ShareRes.get_comm_value("DefaultDepressionCameraId")
}
config.CAMERA_VIEW_TYPE = {
  DEPRESSION = 1,
  SHOULDER = 2,
  AUTO_ANGLE = 3
}
config.CAMERA_SHAKE_TYPE = {
  DEFAULT = 1,
  DEPRESSION = 2,
  OTS = 3
}
config.CAMERA_PINCH_TYPE = {
  CLOSE = 0,
  FREE = 1,
  GEAR = 2
}
config.SETTING = {
  SEARCH_TARGET_TYPE = {HP_PERCENT = 1, DISTANCE = 2},
  LOCK_ENEMY_BTN_VISIBLE = {CLOSE = 0, OPEN = 1},
  JOYSTICK_MOVE_TYPE = {DYNAMIC = 0, STATIC = 1},
  CANCEL_SKILL_TYPE = {BUTTON = 0, DISTANCE = 1},
  SKILL_ACTIVE_LOCATION = {FIXED = 1, HANDLE = 2},
  SKILL_SENSITIVITY = {MIN_NUM = 0.3, MAX_NUM = 1.7},
  CAMERA_SENSITIVITY = {MIN_NUM = 0.5, MAX_NUM = 1.5},
  CAMERA_VIEW_TYPE = {DEPRESSION = 1, SHOULDER = 2},
  CUSTOM_CAMERA_VIEW = {
    DEPRESSION_ANGLE = 1,
    SHOULDER_ANGLE = 2,
    AUTO_ANGLE = 3
  },
  CAMERA_DEPRESSION_MODE_ROTATE = {ON = 1, OFF = 0},
  LOGIN_CAMERA_MOVEMENT_SETTING = {
    OFF = 0,
    EVERYLOGIN = 1,
    DAILYLOGIN = 2
  },
  INDICATOR_ATTACH_TARGET = {ON = 1, OFF = 0},
  AUTO_TRIGGER_QTE_ON_ROLE_OUT = {
    ON = 2,
    ONLY_LINK = 1,
    OFF = 0
  },
  CAMERA_PINCH_TYPE = {OPEN = 1, CLOSE = 2},
  DAMAGE_FONT_SIZE = {MIN_NUM = 0.4, MAX_NUM = 0.7},
  AUTO_LOCK_TYPE = {CLOSE = 0, OPEN = 1},
  RENDER_FRAME_TYPE = {LOW = 1, NORMAL = 2},
  EFFECT_QUALITY_TYPE = {
    LOW = 1,
    MIDDLE = 2,
    HIGH = 3,
    VERY_HIGH = 4
  },
  MAX_RESOLUTION_HEIGHT = 1080,
  MAX_MOBILE_RESOLUTION_HEIGHT = 900,
  MAX_LOW_MEMORY_DEVICE_RESOLUTION_HEIGHT = 720,
  RESOLUTION = {
    LOW = 1,
    MIDDLE = 2,
    HIGH = 3,
    VERY_HIGH = 4
  },
  UNITY_QUALITY_SETTING_TYPE = {
    LOW = 1,
    MIDDLE = 2,
    HIGH = 3,
    VERY_HIGH = 4
  },
  DAMAGE_FONT_SIZE_TYPE = {
    HIDE = 0,
    LOW = 1,
    MIDDLE = 2,
    HIGH = 3
  },
  SHADOW_TYPE = {
    CLOSE = 1,
    LOW = 2,
    MIDDLE = 3,
    HIGH = 4
  },
  ANTI_ALIASING_TYPE = {CLOSE = 0, OPEN = 1},
  HDR_TYPE = {CLOSE = 0, OPEN = 1}
}
config.LOCAL_NOTICE_READ_KEY = "LOCAL_NOTICE_READ_KEY"
config.LOCAL_NOTICE_CFG_KEY = "LOCAL_NOTICE_CFG_KEY"
config.SETTING_INFO_KEY = "SETTING_INFO_KEY"
config.SETTING_BTN_LAYOUT_KEY = "SETTING_BTN_LAYOUT_KEY"
config.BUDDY_VOICE_LANGUAGE_KEY = "BUDDY_VOICE_LANGUAGE_KEY"
config.LOCAL_DAILY_LOGIN_TIMESTEP_KEY = "LOCAL_DAILY_LOGIN_TIMESTEP_KEY"
config.ILLUSTRATED_REDPOINT_KEY = "ILLUSTRATED_REDPOINT_KEY"
config.PREHEAT_RECORD_KEY = "PREHEAT_RECORD_KEY"
config.ENDLESS_ENTRY_SELECT_KEY = "ENDLESS_ENTRY_SELECT_KEY"
config.LOCAL_STORE_DRAW_KEY = "LOCAL_STORE_DRAW_KEY"
config.LAST_LOGIN_UUID_KEY = "LAST_LOGIN_UUID_KEY"
config.TREASURE_CHEST_GUIDE_STATE = "TREASURE_CHEST_GUIDE_STATE"
config.WEEKLY_IS_OPENED_PVP_STATE = "WEEKLY_IS_OPENED_PVP_STATE"
config.PLAYER_ROLE = {PLAYER = 1, GM = 2}
config.IGNORE_ARMOR = {NONE = 0, IGNORE = 1}
config.MISSILE_BROARDCAST_TYPE = {NONE = 0, POS = 1}
config.CONDITION_ACTION = {
  CHANGE_GIRL = 1,
  LOGIN_WEILCOME = 2,
  PLAY_LONG_TIEM = 3,
  HAVE_NEW_JOURNEY = 4,
  BUDDY_EVENT = 5,
  FAVOR_EXP_UP = 10,
  FAVOR_LV_UP = 11
}
config.SIGNBOARD_PARAM = {
  NORMAL = 1,
  CHANGE_ROLE = 2,
  LOGIN = 3,
  LONG_STANDBY = 4,
  CHAR_ARCHIVE = 5,
  CHOOSE_ROLE = 7,
  CHOOSE_GIFT = 8,
  ARCHIVE = 9,
  VOICE = 10
}
config.DO_STAND_BY_SIGNBOARD_PARAM = {
  [config.SIGNBOARD_PARAM.NORMAL] = true,
  [config.SIGNBOARD_PARAM.LOGIN] = true,
  [config.SIGNBOARD_PARAM.LONG_STANDBY] = true,
  [config.SIGNBOARD_PARAM.CHANGE_ROLE] = true
}
config.KEEP_ACT_SIGNBOARD_PARAM = {
  [config.SIGNBOARD_PARAM.CHOOSE_GIFT] = true,
  [config.SIGNBOARD_PARAM.CHOOSE_ROLE] = true
}
config.SIGNBOARD_PARAM_USE_GYRO = {
  [config.SIGNBOARD_PARAM.NORMAL] = 1
}
config.HERO_BEHAVIOR_VALUE = {LOCK_AND_TURN_SETTING = 1}
config.START_SETTING_KEY = "START_SETTING_KEY"
config.FIGHT_OBJ_VISIBLE_TYPE = {
  BUDDY = 1,
  TALENT = 2,
  SETTING = 3,
  INTERACT = 4,
  GAME_PLAY = 5,
  STORY = 6
}
config.OBJ_VISIBLE_STATE = {SHOW = 1, HIDE = 2}
config.OPEN_OR_CLOSE_STATE = {OPEN = 1, CLOSE = 2}
config.UI_STACK_TYPE = {MAIN_SCENE = 1, FIGHT_SCENE = 2}
config.TOWER_TYPE = {
  DEFAULT = 1,
  CHALLENGE_RING = 2,
  CURSE_RING = 3,
  CUT_GRASS = 4,
  WEEKLY_ACT = 5
}
config.FIGHT_STATE = {
  TOWER_WIN = 101,
  TOWER_FAIL = 102,
  FIGHT_SWITCH_CHAR = 103,
  LEISURE_SWITCH_CHAR = 104,
  FIGHT_START_BORN = 105,
  FIGHT_END_PLAY_ANIM = 106,
  CHAR_REDUCE_HP = 107
}
config.DROP_TYPE = {
  CONTINUE = 1,
  BAG_INIT = 2,
  FIGHT_END = 3,
  GM = 4,
  HERO_BORN = 5,
  BAG_UPDATE = 6
}
config.SCENE_ITEM_DROP_TYPE = {
  BATTLE = 1,
  NPC = 2,
  BREAKABLE = 3
}
config.NUM_2_TRAD_CHINESE = {
  [1] = "壹",
  [2] = "貳",
  [3] = "叁",
  [4] = "肆",
  [5] = "伍",
  [6] = "陆",
  [7] = "柒",
  [8] = "捌",
  [9] = "玖",
  [10] = "拾"
}
config.NUM_2_ROMAN = CommonDef.ROME_NUM
config.ITEM_OBJ_TYPE = {
  INIT_BOX = 1,
  INIT_BOX_HERO_ITEM = 2,
  CR_SHOP = 3
}
config.ANCHOR_LAYOUT_NAME = {MIDDLE = "MIDDLE", LEFT = "LEFT"}
config.TXT_CCOLOR = {
  BLACK = "<color=#000000>",
  WHITE = "<color=#ffffff>",
  GREY = "<color=#292929>",
  LIGHT = "<color=#FFF0D5>",
  DARK = "<color=#C9C5BC>"
}
config.TITLE_COLOR = {
  LIGHT_1 = "<color=#D3C99D>",
  LIGHT_2 = "<color=#6B543B>",
  DARK = "<color=#bcb4a5>"
}
config.QUALITY_COLOR = {
  BLUE = "<color=#789EEC>",
  PURPLE = "<color=#9968E5>",
  ORANGE = "<color=#E5B564>"
}
config.HLIGHT_COLOR = {
  ORANGE = "<color=#DD7A39>",
  RED = "<color=#E0212C>",
  GREEN = "<color=#39dd86>"
}
config.BTN_COLOR = {
  LIGHT_ORANGE = "<color=#c15e38>",
  LIGHT_GREY = "<color=#292929>",
  LIGHT_WHITE = "<color=#FFF0D5>",
  DARK_RED = "<color=#721f1f1>",
  DARK_GREEN = "<color=#1f725c>",
  DARK_ORANGE = "<color=#8C8473>"
}
config.SAVE_TYPE = {
  BATTLE_SETTING = 1,
  FIRST_RECHARGE_POPUP = 2,
  GUIDE_RECOVER = 3
}
config.HERO_ICON_LV = {
  THUMBNAIL = 1,
  SHOW_IMG = 2,
  HALF_IMG = 3,
  FULL_IMG = 4,
  HD_FULL_IMG = 5,
  DRAW_CARD_IMG = 6
}
config.SOURCE_TYPE = {
  BGM = 1,
  EFFECT = 2,
  SPECIAL = 3,
  EFFECT_LOOP = 4,
  VOICE = 5,
  BGM2 = 6,
  CLICK = 7,
  VOICE2 = 8,
  UI_SOUND = 9
}
config.UI_SOUND_CFG = {
  uimain_setting_UI_SOUND = "uimain_setting_UI_SOUND",
  gift_UI_SOUND = "gift_UI_SOUND",
  switch_achievement_UI_SOUND = "switch_achievement_UI_SOUND",
  synthesis_UI_SOUND = "synthesis_UI_SOUND",
  bag_item_refresh_UI_SOUND = "bag_item_refresh_UI_SOUND",
  recommond_shop_tog2_UI_SOUND = "recommond_shop_tog2_UI_SOUND",
  recommond_shop_tog3_UI_SOUND = "recommond_shop_tog3_UI_SOUND",
  monthly_pass_UI_SOUND = "monthly_pass_UI_SOUND",
  shop_item_refresh_UI_SOUND = "shop_item_refresh_UI_SOUND",
  chapter_refresh_UI_SOUND = "chapter_refresh_UI_SOUND",
  ui_monthtask_tog_UI_SOUND = "ui_monthtask_tog_UI_SOUND",
  ui_monthtask_switch_UI_SOUND = "ui_monthtask_switch_UI_SOUND",
  uidrawcard_switch_UI_SOUND = "uidrawcard_switch_UI_SOUND",
  building_tower_update_UI_SOUND = "building_tower_update_UI_SOUND",
  puzzle_set_UI_SOUND = "puzzle_set_UI_SOUND",
  puzzle_synthesis_UI_SOUND = "puzzle_synthesis_UI_SOUND",
  fate_book_tog_UI_SOUND = "fate_book_tog_UI_SOUND",
  fate_book_point_detail_tog_UI_SOUND = "fate_book_point_detail_tog_UI_SOUND",
  challenge_select_tog_UI_SOUND = "challenge_select_tog_UI_SOUND",
  weekly_pvp_stage_info_UI_SOUND = "weekly_pvp_stage_info_UI_SOUND",
  catch_cat_click_road_UI_SOUND = "catch_cat_click_road_UI_SOUND",
  catch_cat_move_UI_SOUND = "catch_cat_move_UI_SOUND",
  catch_cat_success_UI_SOUND = "catch_cat_success_UI_SOUND",
  catch_cat_fail_UI_SOUND = "catch_cat_fail_UI_SOUND",
  chapter_story_preheat_unlock_UI_SOUND = "chapter_story_preheat_unlock_UI_SOUND",
  monkey_typer_click_machine_UI_SOUND = "monkey_typer_click_machine_UI_SOUND",
  monkey_typer_monkey_up_UI_SOUND = "monkey_typer_monkey_up_UI_SOUND",
  monkey_typer_machine_up_UI_SOUND = "monkey_typer_machine_up_UI_SOUND",
  monkey_typer_up_cpl_UI_SOUND = "monkey_typer_up_cpl_UI_SOUND",
  barbecue_game_main_panel_UI_SOUND = "barbecue_game_main_panel_UI_SOUND",
  barbeque_game_put_plate_UI_SOUND = "barbeque_game_put_plate_UI_SOUND",
  barbeque_game_put_cup_UI_SOUND = "barbeque_game_put_cup_UI_SOUND",
  barbeque_game_get_score_UI_SOUND = "barbeque_game_get_score_UI_SOUND",
  barbecue_game_start_tips_UI_SOUND = "barbecue_game_start_tips_UI_SOUND",
  barbecue_game_result_tips_UI_SOUND = "barbecue_game_result_tips_UI_SOUND",
  quality_setting_tog_UI_SOUND = "quality_setting_tog_UI_SOUND",
  camera_setting_tog_UI_SOUND = "camera_setting_tog_UI_SOUND",
  click_npc_bird_UI_SOUND = "click_npc_bird_UI_SOUND",
  recommond_shop_tog1_UI_SOUND = "recommond_shop_tog1_UI_SOUND",
  monthly_pass_award_UI_SOUND = "monthly_pass_award_UI_SOUND",
  left_right_common_UI_SOUND = "left_right_common_UI_SOUND",
  player_setting_env_bgm_UI_SOUND = "player_setting_env_bgm_UI_SOUND",
  player_setting_quality_confirm_UI_SOUND = "player_setting_quality_confirm_UI_SOUND",
  player_setting_quality_nameconfirm_UI_SOUND = "player_setting_quality_nameconfirm_UI_SOUND",
  ui_main_entry_panel_unlock_UI_SOUND = "ui_main_entry_panel_unlock_UI_SOUND",
  common_tips_complete_UI_SOUND = "common_tips_complete_UI_SOUND",
  ui_chapter_easy_switch_UI_SOUND = "ui_chapter_easy_switch_UI_SOUND",
  common_pickup_tips_UI_SOUND = "common_pickup_tips_UI_SOUND",
  story_branch_click_UI_SOUND = "story_branch_click_UI_SOUND",
  card_select_UI_SOUND = "card_select_UI_SOUND",
  event_select_UI_SOUND = "event_select_UI_SOUND",
  curse_obj_val_add_UI_SOUND = "curse_obj_val_add_UI_SOUND",
  card_boss_UI_SOUND = "card_boss_UI_SOUND",
  puzzle_set_cube_suc_UI_SOUND = "puzzle_set_cube_suc_UI_SOUND",
  puzzle_set_cube_fal_UI_SOUND = "puzzle_set_cube_fal_UI_SOUND",
  puzzle_set_cube_ret_UI_SOUND = "puzzle_set_cube_ret_UI_SOUND",
  puzzle_set_cube_rot_UI_SOUND = "puzzle_set_cube_rot_UI_SOUND",
  puzzle_game_suc_SOUND = "puzzle_game_suc_SOUND",
  puzzle_game_fal_SOUND = "puzzle_game_fal_SOUND",
  fate_book_talent_unlock_UI_SOUND = "fate_book_talent_unlock_UI_SOUND",
  return_act_sign_click_UI_SOUND = "return_act_sign_click_UI_SOUND",
  puzzle_game_battle_panel_UI_SOUND = "puzzle_game_battle_panel_UI_SOUND",
  music_game_chapter_in_UI_SOUND = "music_game_chapter_in_UI_SOUND",
  music_game_stage_in_UI_SOUND = "music_game_stage_in_UI_SOUND",
  music_game_count_down_UI_SOUND = "music_game_count_down_UI_SOUND",
  music_game_node_suc_UI_SOUND = "music_game_node_suc_UI_SOUND",
  music_game_node_fail_UI_SOUND = "music_game_node_fail_UI_SOUND",
  music_game_node_end_UI_SOUND = "music_game_node_end_UI_SOUND",
  music_game_suc_UI_SOUND = "music_game_suc_UI_SOUND",
  music_game_fail_UI_SOUND = "music_game_fail_UI_SOUND",
  ui_return_activity_main_in_UI_SOUND = "ui_return_activity_main_in_UI_SOUND",
  ui_activity_main_btn_UI_SOUND = "ui_activity_main_btn_UI_SOUND",
  ui_puzzle_refine_btn_UI_SOUND = "ui_puzzle_refine_btn_UI_SOUND",
  ui_build_btnharvest_UI_SOUND = "ui_build_btnharvest_UI_SOUND",
  ui_act_bird_shoot_UI_SOUND = "ui_act_bird_shoot_UI_SOUND",
  ui_fish_game_stage_item_UI_SOUND = "ui_fish_game_stage_item_UI_SOUND",
  ui_fish_game_down_UI_SOUND = "ui_fish_game_down_UI_SOUND",
  ui_fish_game_get_UI_SOUND = "ui_fish_game_get_UI_SOUND",
  ui_fish_game_get_sorce_UI_SOUND = "ui_fish_game_get_sorce_UI_SOUND",
  ui_fish_game_explode_UI_SOUND = "ui_fish_game_explode_UI_SOUND",
  fish_game_battle_settle_suc_UI_SOUND = "fish_game_battle_settle_suc_UI_SOUND",
  fish_game_battle_settle_fail_UI_SOUND = "fish_game_battle_settle_fail_UI_SOUND",
  ui_summer_act_icon_UI_SOUND = "ui_summer_act_icon_UI_SOUND",
  ui_maze_game_main_UI_SOUND = "ui_maze_game_main_UI_SOUND",
  ui_maze_game_start_UI_SOUND = "ui_maze_game_start_UI_SOUND",
  ui_maze_game_start_click_UI_SOUND = "ui_maze_game_start_click_UI_SOUND",
  ui_maze_game_view_click_UI_SOUND = "ui_maze_game_view_click_UI_SOUND",
  ui_maze_game_illustrated_UI_SOUND = "ui_maze_game_illustrated_UI_SOUND",
  ui_minesweeper_settle_suc_UI_SOUND = "ui_minesweeper_settle_suc_UI_SOUND",
  ui_minesweeper_settle_fail_UI_SOUND = "ui_minesweeper_settle_fail_UI_SOUND",
  minesweeper_grid_flip_SOUND = "minesweeper_grid_flip_SOUND",
  minesweeper_grid_in_SOUND = "minesweeper_grid_in_SOUND",
  minesweeper_grid_out_SOUND = "minesweeper_grid_out_SOUND",
  minesweeper_grid_refresh_SOUND = "minesweeper_grid_refresh_SOUND",
  minesweeper_allbeat_SOUND = "minesweeper_allbeat_SOUND"
}
config.SOUND_STATUS = {
  STOP = 0,
  PREP = 1,
  PLAYING = 2,
  PLAYEND = 3,
  ERROR = 4
}
config.BEHIT_INTERRUPT_TYPE = {
  MOVE = 1,
  COUNTER = 2,
  SKILL = 3
}
config.CHAR_QUALITY_TYPE = {
  SMALL = 1,
  BIG = 2,
  NAME = 3,
  LONG = 4,
  SHORT = 5
}
config.SCENE_BLUR_TYPE = {UI = 1, SCENE = 2}
config.TEAM_TYPE = {CHAPTER = 1, ONLINE_BATTLE = 2}
config.ROOM_LOCK_STATE = {
  NONE = 1,
  LOCK = 2,
  UNLOCK = 3
}
config.BUDDY_TYPE = {DEFAULT = 0, ROBOT = 1}
config.CAMERA_NAME = "GameCamera"
config.UI_QUEUE_GROUP = {
  Recharge_Reward = 1,
  Upgrade_Notice = 2,
  Common_Reward = 3,
  Lv_Up_Reward = 4,
  Sys_Open_Notice = 5,
  Task_Notice = 6,
  Fight_Tips = 7
}
config.ENTER_ROOM_IS_HAVE_ANIMATIOIN = {NO = 0, YES = 1}
config.TP_POS_RULE = {CENTER = 0, Y_ANGLE = 1}
config.CARD_IMG_NAME = {
  [701000] = "Event_bg_kp05",
  [701001] = "Event_bg_kp04",
  [701002] = "Event_bg_kp03",
  [701003] = "Event_bg_kp02",
  [701004] = "Event_bg_kp01",
  [701010] = "Event_bg_kp05",
  [701011] = "Event_bg_kp04",
  [701012] = "Event_bg_kp03",
  [701013] = "Event_bg_kp02",
  [701014] = "Event_bg_kp01",
  [701020] = "Event_bg_kp05",
  [701021] = "Event_bg_kp04",
  [701022] = "Event_bg_kp03",
  [701023] = "Event_bg_kp02",
  [701024] = "Event_bg_kp01",
  [701100] = "Event_bg_yskp01",
  [701101] = "Event_bg_yskp02",
  [701102] = "Event_bg_yskp03",
  [701103] = "Event_bg_yskp04",
  [701104] = "Event_bg_yskp05",
  [701105] = "Event_bg_yskp06"
}
config.NOT_PROGRESS_BATTLE_TYPE = {
  [CommonDef.CHALLENGE_TYPE.CHAPTER] = CommonDef.CHALLENGE_TYPE.CHAPTER,
  [CommonDef.CHALLENGE_TYPE.BUDDY_TEACH] = CommonDef.CHALLENGE_TYPE.BUDDY_TEACH,
  [CommonDef.CHALLENGE_TYPE.PROBATION_BUDDY] = CommonDef.CHALLENGE_TYPE.PROBATION_BUDDY,
  [CommonDef.CHALLENGE_TYPE.NEW_MATERIAL] = CommonDef.CHALLENGE_TYPE.NEW_MATERIAL,
  [CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI] = CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI,
  [CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI] = CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI
}
config.MISSILE_HIT_STOP_ID = 2333333333
config.FORMAL_SERVER_TAG = {TAP_TAP = 1, TOU_TIAO = 2}
config.CHANNEL_MAP = {
  ["funplus-iap-cn.taptap"] = config.FORMAL_SERVER_TAG.TAP_TAP,
  ["funplus-iap-cn.toutiao"] = config.FORMAL_SERVER_TAG.TOU_TIAO
}
config.ENTER_NODE_TYPE = {
  FIGHT_NODE = CommonDef.CHAPTER_NODE_TYPE.MAIN_LINE,
  STORY_NODE = CommonDef.CHAPTER_NODE_TYPE.STORY_LINE,
  BRANCH_TASK_NODE = CommonDef.CHAPTER_NODE_TYPE.BRANCH_LINE,
  HARD_MODE_NODE = 4
}
config.HARD_NODE_POS = {
  [1] = "h,1,3",
  [2] = "h,2,4",
  [3] = "h,3,3",
  [4] = "h,4,4",
  [5] = "h,5,3"
}
config.MAZE_DATA_STATE = {
  EVACUATE_CNT_CHANGE = 1,
  EXPLORE_CNT_CHANGE = 2,
  ALL_CNT_CHANGE = 3,
  NO_CHANGE = 4
}
config.SKIP_SHOW_ATTR_ID = {
  [FightDefine.ATTR_TYPE.CHAR_SP_MAX] = true,
  [FightDefine.ATTR_TYPE.CHAR_PENETRATE] = true,
  [FightDefine.ATTR_TYPE.CHAR_CRIT_DAMAGE_ATK_PER] = true,
  [FightDefine.ATTR_TYPE.CHAR_CRIT_ATK_PER] = true,
  [FightDefine.ATTR_TYPE.ABNORMAL_PURE_ESSENCE] = true
}
config.TOUGH_CONFIG_INDEX = {
  MAX_VALUE = 1,
  CAN_STUN = 2,
  FLYER_COUNT1 = 3,
  FLYER_COUNT2 = 4
}
config.BLOOD_ATTACH = "Bip001 Chest"
config.SNAP_SHOOT_MISSILE_RECORD_ATTR_ID = {}
config.Condition_Type = {
  MinFloor = 1,
  MinBeHit = 2,
  HealthMoreThan = 3,
  MinPassTime = 4,
  ApiAddProgress = 5,
  TeamRoleCount = 6,
  UnusedSkillPassTower = 7,
  ApiReduProgress = 55,
  EnoughPlayLv = 1008
}
config.Chapter_Mode = {
  NORMAL = 1,
  DIFFICULTY = 2,
  HARD = 3
}
config.Chapter_Page = {
  MAINLINE = 1,
  ROLE = 2,
  OTHER = 3,
  OUTER = 4
}
config.HERO_OPERATE_TYPE = {REMOVE = 1, RESET = 2}
config.CD_MASK_TYPE = {ATTR = 1, TIME = 2}
config.CommonDefine = CommonDef
config.FightDefine = FightDefine
config.MagicDefine = MagicDefine
config.RECOVER_SP_MAGIC = 1999167
config.NPC_ON_STUN_MAGIC = 100187
config.PRIVILEGE_BUTTON_TYPE = {
  NOT_ACTIVE = 0,
  JUMP = 1,
  SHOW_TIPS = 2
}
config.PRIVILEGE_TYPE = {
  GIVE_ENERGY_VALUE = 1001,
  WEAPON_REMODEL = 1002,
  WEAPON_RESOLVE = 1003,
  MALL_GIFT_PAGING = 1004,
  MALL_GIFT_GIFT = 1005
}
config.NOVICE_PRIVILEGE_PAGE = 4
config.TASK_STATE = {
  NOT_RECEIVE = 0,
  CAN_RECEIVE = 1,
  RECEIVE = 2,
  COMPLETE = 3,
  GET_REWARD = 4
}
config.ACTIVITY_TYPE = {
  TASK = 1,
  SIGN_IN = 2,
  PRIVILEGE = 3,
  COURSE_AWARD = 4
}
config.TOUGH_CHANGE_TYPE = {
  RESET_TOUGH_PARAM = 1,
  TOUGH_LV_DOWN = 2,
  TOUGH_LV_UP = 3,
  TOUGH_CLEAR = 4,
  TOUGH_RECOVER_DONE = 5,
  TOUGH_VALUE_CHANGE = 6,
  TOUGH_RECOVER_START = 7
}
config.ROOM_STATE_PASS = 1
config.SQUEEZE_OUT_SPEED = ShareRes.get_comm_value("ColliderSqueezeOutSpeed") or 3.5
config.BUTTON_INPUT_STATE_NAME = {
  NO_INPUT = "no_input",
  ON_INPUT = "on_input",
  ON_TOUCH_UP = "on_touch_up",
  CANCLE = "cancle"
}
config.ABANDON_BTN_IDX = {
  [6] = true
}
config.PICK_ENERGY_BALL_EFFECT = "Fx_Common_ultimateflash"
config.AUTO_TP_NEXT_FLOOR_TIME = 2
config.SceneRootName = "Root"
config.SceneGroupCtrlObjName = "GroupCtrlObj"
config.CUSTOM_MAGIC = 19999999
config.ARROWS_EFFECT_NAME = "Fx_indicate_1"
config.NEW_ARROWS_EFFECT_NAME = "Fx_indicate_3"
config.ARROWS_EFFECT_COLOR = {
  YELLOW = "jiantou_huang",
  WHITE = "jiantou_bai",
  RED = "jiantou_hong",
  ORANGE = "jiantou_cheng",
  WARING = "jiantou_warn"
}
config.HERO_CIRCEL_EFFECT_NAME = "Fx_indicate"
config.HERO_HEAL_EFFECT_NAME = "Fx_cure_1"
config.ASSET_BAR_STATE = {
  ON_CREATE = 1,
  ON_HIDE = 2,
  ON_DESTROY = 3,
  ON_CLREA = 4
}
config.ASSET_BAR_STATE = {
  ON_CREATE = 1,
  ON_HIDE = 2,
  ON_DESTROY = 3,
  ON_CLREA = 4
}
config.PAUSE_FUN_TOG_SHOW_LIST = {
  [CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PERPARE_EPI] = {
    7,
    3,
    10
  },
  [CommonDef.CHALLENGE_TYPE.WEEK_ACTY_PVP_EPI] = {
    7,
    3,
    10
  },
  [CommonDef.CHALLENGE_TYPE.BUDDY_TEACH] = {
    7,
    3,
    10
  },
  [CommonDef.CHALLENGE_TYPE.NEW_MATERIAL] = {
    7,
    3,
    10
  },
  [CommonDef.CHALLENGE_TYPE.LONG_CHAPTER] = {
    7,
    3,
    8,
    10
  },
  [CommonDef.CHALLENGE_TYPE.CHAPTER] = {
    7,
    3,
    10
  },
  [CommonDef.CHALLENGE_TYPE.INFINITE] = {
    7,
    3,
    10
  },
  [CommonDef.CHALLENGE_TYPE.NEWBIE_TOWER] = {
    7,
    3,
    10
  },
  [CommonDef.CHALLENGE_TYPE.CURSE_CIRCLE] = {
    3,
    5,
    6,
    9,
    10
  },
  [CommonDef.CHALLENGE_TYPE.ACTIVITY_MINESWEEPER] = {3, 10}
}
config.NUMBER_TO_CHINESE = {
  [1] = "一",
  [2] = "二",
  [3] = "三",
  [4] = "四",
  [5] = "五",
  [6] = "六",
  [7] = "七",
  [8] = "八",
  [9] = "九",
  [10] = "十"
}
config.SYNTHESIS_CLASSIFY = {
  ALL = 0,
  TUPO_ITEM = 1,
  ENGRAVE = 2,
  ENGRAVE_ITEM = 3
}
config.SYNTHESIS_CLASSIFY_TO_TOG = {
  [config.SYNTHESIS_CLASSIFY.ALL] = "All",
  [config.SYNTHESIS_CLASSIFY.TUPO_ITEM] = "Page1",
  [config.SYNTHESIS_CLASSIFY.ENGRAVE] = "Page2",
  [config.SYNTHESIS_CLASSIFY.ENGRAVE_ITEM] = "Page3"
}
config.SKILL_CONSUME_MAGIC = {
  BATTLE_RES_COST = ShareRes.get_comm_value("BattleResCostMagicId"),
  SKILL_RES_COST = ShareRes.get_comm_value("SkillResCostMagicId"),
  ULT_RES_COST = ShareRes.get_comm_value("UltResCostMagicId")
}
config.ABNORMAL_DAMAGE_DEDUCT_TOUGH = ShareRes.get_comm_string_value("AbnormalDamageDeductTough")
config.AREA_POINT_MODULE_TYPE = {CHAPTER_NODE = 1, CHAPTER_POINT = 2}
config.AREA_POINT_TYPE = {
  NORMAL = 1,
  STORY = 2,
  CHALLENGE = 3
}
config.DAMAGE_EFFECT_TYPE = {
  NORMAL = 1,
  SPECIAL = 2,
  ABNORMAL = 3
}
config.SELECT_ITEM_TYPE = {STORY_SNIPPET = 1, CURSE_SELECT_POINT = 2}
config.BUFF_SOURCE_TYPE = {ornaments = "ornaments"}
config.PAY_COSE_TYPE = {
  USE_ITEM = 1,
  USE_CUESE = 2,
  FREE = 3
}
config.MINI_GAME_TYPE = {WATER_PIPE = 1, INSERT_NEEDLE = 2}
config.DRAW_RESULT_EFFECT_QUALITY2_PATH = {
  [1] = "Camera/Cinemachine/Main_chouka_1/Fx_Chouka_jieguo_4.prefab",
  [2] = "Camera/Cinemachine/Main_chouka_1/Fx_Chouka_jieguo_4.prefab",
  [3] = "Camera/Cinemachine/Main_chouka_1/Fx_Chouka_jieguo_3.prefab",
  [4] = "Camera/Cinemachine/Main_chouka_1/Fx_Chouka_jieguo_2.prefab",
  [5] = "Camera/Cinemachine/Main_chouka_1/Fx_Chouka_jieguo_1.prefab"
}
config.DRAW_RESULT_QUALITY2_EFFECT_NAME = {
  [1] = "Fx_Chouka_chongdong_3",
  [2] = "Fx_Chouka_chongdong_3",
  [3] = "Fx_Chouka_chongdong_3",
  [4] = "Fx_Chouka_chongdong_2",
  [5] = "Fx_Chouka_chongdong_1"
}
config.CHAR_TIP_PAGE_TYPE = {ELEMENT = 1, JOB = 2}
config.FIGHT_TYPE_TO_MODULE_TYPE = {
  [CommonDef.CHALLENGE_TYPE.LONG_CHAPTER] = config.AREA_POINT_MODULE_TYPE.CHAPTER_NODE,
  [CommonDef.CHALLENGE_TYPE.CHAPTER] = config.AREA_POINT_MODULE_TYPE.CHAPTER_POINT
}
config.DEFAULT_CAMERA_TEXTURE = "UIloginBg3"
config.MINIMUM_REBOUND_HEIGHT = ShareRes.get_comm_value("MinimumReboundHeight")
config.ENTRY_QUALITY_PATH = {
  [1] = "Skill/EndLessBuff/Endless_bg_bz_gery",
  [2] = "Skill/EndLessBuff/Endless_bg_bz_green",
  [3] = "Skill/EndLessBuff/Endless_bg_bz_yellow",
  [4] = "Skill/EndLessBuff/Endless_bg_bz_red",
  [5] = "Skill/EndLessBuff/Endless_bg_bz_orange"
}
config.FATE_POINT_TYPE = {
  POINT = 1,
  STORY = 2,
  HARD = 3
}
config.ENTER_DRAWCARD_AUDIO_ID1 = "Sound_chouka_01"
config.ENTER_DRAWCARD_AUDIO_ID2 = "Sound_chouka_01_loop"
config.NORMAL_QUALITY_AUDIO_ID = "Sound_chouka_07"
config.HIGH_QUALITY_AUDIO_ID = "Sound_chouka_06"
config.EFF_AUDIO_ID_LIST = {
  [1] = {
    "Sound_chouka_02",
    "Sound_chouka_02_loop"
  },
  [2] = {
    "Sound_chouka_03",
    "Sound_chouka_03_loop"
  },
  [3] = {
    "Sound_chouka_04",
    "Sound_chouka_04_loop"
  },
  [4] = {
    "Sound_chouka_05",
    "Sound_chouka_05_loop"
  }
}
config.TOUCH_UP_TYPE = {
  CHANGE_BUTTON = 1,
  ON_UP_ALL_CODE = 2,
  BUTTON_LISTENER = 3,
  ON_DOWN_SKILL_FORCE_UP = 4,
  UIOBJECT_INVISIBLE = 5,
  ON_CLEAR_KEY = 6,
  ON_SKILL_UP = 7,
  SHOW_INTERACT = 8
}
config.MAX_CHAR_ITEM_COUNT = 3
config.HIT_FLY_UP_STATE = {
  [config.ACT_DEFINE.BeHitFly] = true,
  [config.ACT_DEFINE.Hoverhit] = true,
  [config.ACT_DEFINE.BeHitRollFly] = true,
  [config.ACT_DEFINE.HoverHitRoll] = true,
  [config.ACT_DEFINE.LieHit] = true
}
config.FLASH_TO_POS_Y_OFFSET = ShareRes.get_comm_value("FlashToPosYOffset")
config.EFFECT_SOURCE = {
  NORMAL_PLAY = 1,
  MAGIC_PLAY = 2,
  MISSILE_PLAY = 3,
  SKILL_PLAY = 4
}
config.SKILL_TURN_DIR_STOP_TYPE = {NORMAL_OUT = 10, TIME_OUT = 1}
config.NEED_QUIT_TIME_SCALE_STATE = {
  [STATE_NAME.beattack] = true,
  [STATE_NAME.behitfly] = true
}
config.ENEMY_BAR_TYPE = {
  MAIN_TARGET = 1,
  MULTI_TARGET = 2,
  ELITE_TARGET = 3
}
config.PICK_ENERGY_BALL_MAGIC = ShareRes.get_comm_value("PickEnergyBallMagic")
config.BIG_ENERGY_BALL_MAGIC_LEVEL = ShareRes.get_comm_value("BigEnergyBallMagicLevel")
config.SAMLL_ENERGY_BALL_MAGIC_LEVEL = ShareRes.get_comm_value("SmallEnergyBallMagicLevel")
config.ENERGY_BALL_SIZE_RANGE = ShareRes.get_comm_value("EnergyBallSizeRange")
config.HERO_STATE = {
  IN_CONTROL = 1,
  IN_GROUND = 2,
  IN_BACKGROUND = 3
}
config.HERO_POS_CHANGE_TYPE = {
  GLOBAL_POS = 1,
  TRANSFER_POS = 2,
  ORIGIN = 3
}
config.PUZZLE_TIPS_OFFSET = {
  MIDDLE = {0, 265},
  LIST_ITEM = {80, 265},
  MAP_ITEM = {-285, 265},
  RIGHT = {612, 265}
}
config.PUZZLE_OPERATE_PANEL_VIEW_TYPE = {
  OPERATE = 1,
  UP_LV = 2,
  DECOMPOSE = 3,
  REFINE = 4
}
config.PUZZLE_MIN_QUALITY = 3
config.PUZZLE_MAX_QUALITY = 5
config.NPC_STATUS_KIND = {
  IS_GHOST = 1,
  IS_AIR = 2,
  GODMODE = 3,
  IS_SUPER_GHOST = 4,
  IS_FRIENDLY_GHOST = 5,
  IS_FRIENDLY_AIR = 6
}
config.NEED_SHOW_DROP_TIPS_ITEM = {
  [config.CURSE_GOLD] = true
}
config.BTN_NAME_2_SKILL_INDEX = {
  Btn_skill1 = 1,
  Btn_skill2 = 2,
  Btn_skill3 = 3,
  Btn_skill4 = 4,
  Btn_skill5 = 5,
  Btn_skill6 = 6,
  Btn_skill7 = 7,
  Btn_skill8 = 8
}
config.TOUGH_BAR_PROTECT_STATE = {
  CREATE_PROTECT = 1,
  PLAY_BREAK_EFFECT = 2,
  EXIT_PROTECT = 3
}
config.SDK_TYPE = {
  TSI_SDK = 0,
  UG_SDK = 1,
  HIVE_SDK = 2
}
config.PLATFORM = {
  TOURIST = "fx_tourist",
  UGSDK = "ugsdk",
  TSISDK = "tsisdk",
  HIVESDK = "hivesdk"
}
config.EACH_POINT_EXPEND_VALUE = ShareRes.get_comm_value("EachPointExpendValue")
config.IgnoreAllRootMotionMap = {M201054 = true}
config.ACTIVATE_PHYSICS_COUNT = 2
config.CATCH_CAT_GRID_TYPE = {
  DEFAULT = 0,
  BLOCK = 1,
  EXIT = 2
}
config.CATCH_CAT_GRID_WALKABLE = {
  [config.CATCH_CAT_GRID_TYPE.DEFAULT] = true,
  [config.CATCH_CAT_GRID_TYPE.BLOCK] = false,
  [config.CATCH_CAT_GRID_TYPE.EXIT] = true
}
config.TIME_SCALE_EFFECT_TYPE = {NORMAL = 1, FREEZE = 2}
config.SHOW_SKILL_AREA_TYPE = {
  NONE = 0,
  MESH = 1,
  SHAPE = 2
}
config.BEHIT_STATE_TYPE = {
  ENTER_BEHIT = 1,
  BEHIT_CAN_COUNTER = 2,
  BEHIT_CAN_CAST = 3,
  ENTER_BEHITFLY = 4,
  ENTER_BEHITDOWN = 5,
  ENTER_LIE = 6,
  LIE_CAN_TURN_OVER = 7,
  LIE_CAN_CAST = 8,
  TURN_OVER_CAN_CAST = 9,
  ENTER_MOVE = 10,
  ENTER_IDLE = 11
}
config.COLLIDER_BLOCKED_TYPE = {
  NONE = 0,
  STOP = 1,
  CHANGE_SPEED = 2
}
config.SIMPLE_TAG_TYPE = {NORMAL = 0, GLOBAL_TIME_SCALE = 1}
config.SIMPLE_TAG_TIMER_TYPE = {
  NONE = 0,
  ROLE_TIME_SCALE = 1,
  GLOBAL_TIME_SCALE = 2,
  UNSCALE = 4
}
config.SKILL_ABORT_TYPE = {
  FOECE = 2,
  BEHIT_ABORT = 4,
  BREAK_ABORT = 8,
  BEHAVIOR_ABORT = 16,
  MOVE_ABORT = 32
}
config.CHANGE_HERO_ANIM_TYPE = lua_behavior_define.CHANGE_HERO_ANIM_TYPE
config.MISSILE_ONCE_ATKCD = -999999
config.PART_MAGIC_EFFECT_TYPE = {ADD_TO_MAIN = 1}
config.PART_NPC_TYPE = {INDEPENDENT = 1, AFFILIATE = 2}
config.BACK_TYPE = {
  NONE = 0,
  GO_TO_MAIN = 1,
  GO_TO_BACK = 2
}
return config
