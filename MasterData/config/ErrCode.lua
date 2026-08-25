local System = require("System.System")
local readonly = System.readonly
local ErrCode = readonly({
  SUCCESS = {
    Key = "SUCCESS",
    Data = 1,
    Desc = "ErrCode_SUCCESS_Desc|操作成功"
  },
  FAILED = {
    Key = "FAILED",
    Data = 2,
    Desc = "ErrCode_FAILED_Desc|失败"
  },
  CMD_UNDEFINED = {
    Key = "CMD_UNDEFINED",
    Data = 3,
    Desc = "ErrCode_CMD_UNDEFINED_Desc|命令不存在"
  },
  ERR_CONFIG = {
    Key = "ERR_CONFIG",
    Data = 10,
    Desc = "ErrCode_ERR_CONFIG_Desc|配置表错误"
  },
  ERR_CLIENT_DATA = {
    Key = "ERR_CLIENT_DATA",
    Data = 11,
    Desc = "ErrCode_ERR_CLIENT_DATA_Desc|客户端传入数据错误"
  },
  ERR_SERVER_NOT_START = {
    Key = "ERR_SERVER_NOT_START",
    Data = 12,
    Desc = "ErrCode_ERR_SERVER_NOT_START_Desc|服务未启动"
  },
  ERR_ROLE_DATA = {
    Key = "ERR_ROLE_DATA",
    Data = 13,
    Desc = "ErrCode_ERR_ROLE_DATA_Desc|角色数据错误"
  },
  ERR_NAME_ILLEGAL_CHARACTER = {
    Key = "ERR_NAME_ILLEGAL_CHARACTER",
    Data = 14,
    Desc = "ErrCode_ERR_NAME_ILLEGAL_CHARACTER_Desc|名字中包含非法字符，请重新输入"
  },
  ERR_PLAYERLEVEL_NOT_ENOUGH = {
    Key = "ERR_PLAYERLEVEL_NOT_ENOUGH",
    Data = 15,
    Desc = "ErrCode_ERR_PLAYERLEVEL_NOT_ENOUGH_Desc|玩家等级不足"
  },
  ERR_NAME_NOT_LENGTH = {
    Key = "ERR_NAME_NOT_LENGTH",
    Data = 16,
    Desc = "ErrCode_ERR_NAME_NOT_LENGTH_Desc|名字长度不合法，必须2-4字符"
  },
  ERR_NAME_CHANGE_COOLTIME = {
    Key = "ERR_NAME_CHANGE_COOLTIME",
    Data = 17,
    Desc = "ErrCode_ERR_NAME_CHANGE_COOLTIME_Desc|再次改名时间未到，请等待"
  },
  ERR_VERSION_TOO_OLD = {
    Key = "ERR_VERSION_TOO_OLD",
    Data = 18,
    Desc = "ErrCode_ERR_VERSION_TOO_OLD_Desc|版本号不符，请更新最新客户端；如已更新请静待校园维护完成"
  },
  ERR_NOT_OPEN = {
    Key = "ERR_NOT_OPEN",
    Data = 19,
    Desc = "ErrCode_ERR_NOT_OPEN_Desc|功能尚未开放"
  },
  ERR_LEVEL_MAX = {
    Key = "ERR_LEVEL_MAX",
    Data = 20,
    Desc = "ErrCode_ERR_LEVEL_MAX_Desc|已到达最大等级"
  },
  ERR_BANNED = {
    Key = "ERR_BANNED",
    Data = 21,
    Desc = "ErrCode_ERR_BANNED_Desc|你已被对方列入黑名单，无法操作"
  },
  ERR_ROLE_NOT_FIND = {
    Key = "ERR_ROLE_NOT_FIND",
    Data = 1000,
    Desc = "ErrCode_ERR_ROLE_NOT_FIND_Desc|没有找到唤醒体数据"
  },
  ERR_ROLE_MAX_LEVEL = {
    Key = "ERR_ROLE_MAX_LEVEL",
    Data = 1001,
    Desc = "ErrCode_ERR_ROLE_MAX_LEVEL_Desc|唤醒体已到达最高等级无法升级"
  },
  ERR_NOT_ENOUGH_INTEGRAL = {
    Key = "ERR_NOT_ENOUGH_INTEGRAL",
    Data = 1002,
    Desc = "ErrCode_ERR_NOT_ENOUGH_INTEGRAL_Desc|没有足够的积分"
  },
  ERR_ROLE_NOT_ARRIVED_MAXLEVEL = {
    Key = "ERR_ROLE_NOT_ARRIVED_MAXLEVEL",
    Data = 1003,
    Desc = "ErrCode_ERR_ROLE_NOT_ARRIVED_MAXLEVEL_Desc|没有到达最高等级，无法进阶"
  },
  ERR_ROLE_STAGE = {
    Key = "ERR_ROLE_STAGE",
    Data = 1004,
    Desc = "ErrCode_ERR_ROLE_STAGE_Desc|已进阶，不能再次进阶"
  },
  ERR_CREATE_ROLE = {
    Key = "ERR_CREATE_ROLE",
    Data = 10001,
    Desc = "ErrCode_ERR_CREATE_ROLE_Desc|没有角色，需要创建"
  },
  IS_CREATE_ROLE = {
    Key = "IS_CREATE_ROLE",
    Data = 10002,
    Desc = "ErrCode_IS_CREATE_ROLE_Desc|已有角色不需要再次创建"
  },
  ERR_CHREATE_ROLE = {
    Key = "ERR_CHREATE_ROLE",
    Data = 10003,
    Desc = "ErrCode_ERR_CHREATE_ROLE_Desc|角色名字重复"
  },
  ERR_CREATE_ROLE_CLOSE = {
    Key = "ERR_CREATE_ROLE_CLOSE",
    Data = 10004,
    Desc = "ErrCode_ERR_CREATE_ROLE_CLOSE_Desc|当前已暂停新守密人注册"
  },
  ERR_GAMECOPY_NOT = {
    Key = "ERR_GAMECOPY_NOT",
    Data = 10050,
    Desc = "ErrCode_ERR_GAMECOPY_NOT_Desc|副本错误"
  },
  ERR_GAMECOPY_NOT_FIND = {
    Key = "ERR_GAMECOPY_NOT_FIND",
    Data = 10051,
    Desc = "ErrCode_ERR_GAMECOPY_NOT_FIND_Desc|没有找到副本"
  },
  ERR_GAMECOPY_ENERGY_NOT_ENOUGH = {
    Key = "ERR_GAMECOPY_ENERGY_NOT_ENOUGH",
    Data = 10052,
    Desc = "ErrCode_ERR_GAMECOPY_ENERGY_NOT_ENOUGH_Desc|当前体力过低，你已经处于虚弱状态。"
  },
  ERR_GAMECOPY_MOPPING_LOCK = {
    Key = "ERR_GAMECOPY_MOPPING_LOCK",
    Data = 10053,
    Desc = "ErrCode_ERR_GAMECOPY_MOPPING_LOCK_Desc|副本探索等级达到2级解锁"
  },
  ERR_GAMECOPY_NOF_FINISH = {
    Key = "ERR_GAMECOPY_NOF_FINISH",
    Data = 10054,
    Desc = "ErrCode_ERR_GAMECOPY_NOF_FINISH_Desc|成功完成一次探索后可瞬时探索"
  },
  ERR_IN_COPIES = {
    Key = "ERR_IN_COPIES",
    Data = 10055,
    Desc = "ErrCode_ERR_IN_COPIES_Desc|副本状态错误，请重新登录"
  },
  ERR_CHALLENGE_NOT_IN_STAGEGROUP = {
    Key = "ERR_CHALLENGE_NOT_IN_STAGEGROUP",
    Data = 10056,
    Desc = "ErrCode_ERR_CHALLENGE_NOT_IN_STAGEGROUP_Desc|幻梦深潜关卡数据更新中，请稍后重试。"
  },
  ERR_EVENT_FINISH = {
    Key = "ERR_EVENT_FINISH",
    Data = 11001,
    Desc = "ErrCode_ERR_EVENT_FINISH_Desc|副本事件已完成"
  },
  ERR_EVENT_CONFIG_NOTYPE = {
    Key = "ERR_EVENT_CONFIG_NOTYPE",
    Data = 11002,
    Desc = "ErrCode_ERR_EVENT_CONFIG_NOTYPE_Desc|副本事件配置表中类型填写错误"
  },
  ERR_EVENT_NOT_FIND = {
    Key = "ERR_EVENT_NOT_FIND",
    Data = 11003,
    Desc = "ErrCode_ERR_EVENT_NOT_FIND_Desc|副本事件不存在"
  },
  ERR_EVENT_NOT_MONEY_ENOUGT = {
    Key = "ERR_EVENT_NOT_MONEY_ENOUGT",
    Data = 11004,
    Desc = "ErrCode_ERR_EVENT_NOT_MONEY_ENOUGT_Desc|密银不足无法购买"
  },
  ERR_CARD_NOT_UPDRADE = {
    Key = "ERR_CARD_NOT_UPDRADE",
    Data = 11005,
    Desc = "ErrCode_ERR_CARD_NOT_UPDRADE_Desc|此卡不能强化"
  },
  ERR_CARD_MAX_LEVEL = {
    Key = "ERR_CARD_MAX_LEVEL",
    Data = 11006,
    Desc = "ErrCode_ERR_CARD_MAX_LEVEL_Desc|此卡已达最大等级，不能强化"
  },
  ERR_SHOP_NOT_GOODS_SELL = {
    Key = "ERR_SHOP_NOT_GOODS_SELL",
    Data = 11007,
    Desc = "ErrCode_ERR_SHOP_NOT_GOODS_SELL_Desc|商店没此商品出售"
  },
  ERR_PRIZE_NOT_FIND = {
    Key = "ERR_PRIZE_NOT_FIND",
    Data = 11008,
    Desc = "ErrCode_ERR_PRIZE_NOT_FIND_Desc|没有此奖励"
  },
  ERR_PRIZE_GAIN = {
    Key = "ERR_PRIZE_GAIN",
    Data = 11009,
    Desc = "ErrCode_ERR_PRIZE_GAIN_Desc|奖励已领取"
  },
  ERR_EVENT_DATA = {
    Key = "ERR_EVENT_DATA",
    Data = 11010,
    Desc = "ErrCode_ERR_EVENT_DATA_Desc|事件数据错误"
  },
  ERR_SHOP_BUY = {
    Key = "ERR_SHOP_BUY",
    Data = 11011,
    Desc = "ErrCode_ERR_SHOP_BUY_Desc|商品已购买"
  },
  ERR_LEAVE_NOT_CONDITION = {
    Key = "ERR_LEAVE_NOT_CONDITION",
    Data = 11012,
    Desc = "ErrCode_ERR_LEAVE_NOT_CONDITION_Desc|当前收集的能量不足以启动传送门，启动传送门需要{s1}点能量。"
  },
  ERR_PLOTSAY_NOT_END = {
    Key = "ERR_PLOTSAY_NOT_END",
    Data = 11013,
    Desc = "ErrCode_ERR_PLOTSAY_NOT_END_Desc|没有找到剧情对话事件"
  },
  ERR_EVENT__CHOOSE_CARD_NUM = {
    Key = "ERR_EVENT__CHOOSE_CARD_NUM",
    Data = 11014,
    Desc = "ErrCode_ERR_EVENT__CHOOSE_CARD_NUM_Desc|事件选择卡牌数量不足"
  },
  ERR_EVENT_CHOOSE_CARD_NUM_MAX = {
    Key = "ERR_EVENT_CHOOSE_CARD_NUM_MAX",
    Data = 11015,
    Desc = "ErrCode_ERR_EVENT_CHOOSE_CARD_NUM_MAX_Desc|事件选择卡牌数量太多"
  },
  ERR_EVENT_CHOOSE_CARD_DATA = {
    Key = "ERR_EVENT_CHOOSE_CARD_DATA",
    Data = 11016,
    Desc = "ErrCode_ERR_EVENT_CHOOSE_CARD_DATA_Desc|事件选择卡牌不存在"
  },
  ERR_EVENT_RANDOM_POND = {
    Key = "ERR_EVENT_RANDOM_POND",
    Data = 11017,
    Desc = "ErrCode_ERR_EVENT_RANDOM_POND_Desc|事件随机池没有数据"
  },
  ERR_SHOP_NOT_SELL = {
    Key = "ERR_SHOP_NOT_SELL",
    Data = 11018,
    Desc = "ErrCode_ERR_SHOP_NOT_SELL_Desc|商店中没有此商品"
  },
  ERR_EVENT__CHOOSE_RELIC_NUM = {
    Key = "ERR_EVENT__CHOOSE_RELIC_NUM",
    Data = 11019,
    Desc = "ErrCode_ERR_EVENT__CHOOSE_RELIC_NUM_Desc|事件选择造物数量不足"
  },
  ERR_EVENT_CHOOSE_RELIC_NUM_MAX = {
    Key = "ERR_EVENT_CHOOSE_RELIC_NUM_MAX",
    Data = 11020,
    Desc = "ErrCode_ERR_EVENT_CHOOSE_RELIC_NUM_MAX_Desc|事件选择造物数量太多"
  },
  ERR_EVENT_CHOOSE_RELIC_DATA = {
    Key = "ERR_EVENT_CHOOSE_RELIC_DATA",
    Data = 11021,
    Desc = "ErrCode_ERR_EVENT_CHOOSE_RELIC_DATA_Desc|事件选择造物不存在"
  },
  ERR_EVENT_NOT_NODE = {
    Key = "ERR_EVENT_NOT_NODE",
    Data = 11022,
    Desc = "ErrCode_ERR_EVENT_NOT_NODE_Desc|事件没找到此节点"
  },
  ERR_EVENT_SHOP_NOT_REFRESH_NUM = {
    Key = "ERR_EVENT_SHOP_NOT_REFRESH_NUM",
    Data = 11023,
    Desc = "ErrCode_ERR_EVENT_SHOP_NOT_REFRESH_NUM_Desc|事件商店刷新没有次数"
  },
  ERR_EVENT_DROP_CARD_NO_REFRESH_NUM = {
    Key = "ERR_EVENT_DROP_CARD_NO_REFRESH_NUM",
    Data = 11024,
    Desc = "ErrCode_ERR_EVENT_DROP_CARD_NO_REFRESH_NUM_Desc|战斗掉落刷新卡牌没有次数"
  },
  ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM = {
    Key = "ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM",
    Data = 11025,
    Desc = "ErrCode_ERR_EVENT_DROP_RELIC_NO_REFRESH_NUM_Desc|战斗掉落刷新造物没有次数"
  },
  ERR_EVENT_REST_FUNCLOCK = {
    Key = "ERR_EVENT_REST_FUNCLOCK",
    Data = 11026,
    Desc = "ErrCode_ERR_EVENT_REST_FUNCLOCK_Desc|联络点功能被锁"
  },
  ERR_EVENT_AREA_NOT_MATCH = {
    Key = "ERR_EVENT_AREA_NOT_MATCH",
    Data = 11027,
    Desc = "ErrCode_ERR_EVENT_AREA_NOT_MATCH_Desc|事件区域错误"
  },
  ERR_EVENT_SHOP_NOT_REMOVECARD = {
    Key = "ERR_EVENT_SHOP_NOT_REMOVECARD",
    Data = 11028,
    Desc = "ErrCode_ERR_EVENT_SHOP_NOT_REMOVECARD_Desc|事件商店删除卡牌次数已用完"
  },
  ERR_EVENT_REST_FUNC_SELECT = {
    Key = "ERR_EVENT_REST_FUNC_SELECT",
    Data = 11029,
    Desc = "ErrCode_ERR_EVENT_REST_FUNC_SELECT_Desc|营地已选择了功能无法再次选择"
  },
  ERR_EVENT_REST_NOT_USENUM = {
    Key = "ERR_EVENT_REST_NOT_USENUM",
    Data = 11030,
    Desc = "ErrCode_ERR_EVENT_REST_NOT_USENUM_Desc|营地功能已没有使用次数"
  },
  ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH = {
    Key = "ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH",
    Data = 11031,
    Desc = "ErrCode_ERR_EXCLUSIVE_CARD_NOT_UPGRADE_SWITCH_Desc|专属卡没有升级无法切换"
  },
  ERR_EXCLUSIVE_CARD_NOT_CHANGE = {
    Key = "ERR_EXCLUSIVE_CARD_NOT_CHANGE",
    Data = 11032,
    Desc = "ErrCode_ERR_EXCLUSIVE_CARD_NOT_CHANGE_Desc|专属卡没有变化无法切换"
  },
  ERR_EXCLUSIVE_CARD_NOT_SWITCH = {
    Key = "ERR_EXCLUSIVE_CARD_NOT_SWITCH",
    Data = 11033,
    Desc = "ErrCode_ERR_EXCLUSIVE_CARD_NOT_SWITCH_Desc|专属卡切换失败"
  },
  ERR_LOGIN_SERVER = {
    Key = "ERR_LOGIN_SERVER",
    Data = 11034,
    Desc = "ErrCode_ERR_LOGIN_SERVER_Desc|登录服务器错误"
  },
  ERR_TOKEN = {
    Key = "ERR_TOKEN",
    Data = 11035,
    Desc = "ErrCode_ERR_TOKEN_Desc|登录Token错误"
  },
  ERR_SHOP_GOODS_EXPIRE = {
    Key = "ERR_SHOP_GOODS_EXPIRE",
    Data = 11036,
    Desc = "ErrCode_ERR_SHOP_GOODS_EXPIRE_Desc|商品已过期，不可兑换"
  },
  ERR_COURSE_NOT_FIND_UNIT = {
    Key = "ERR_COURSE_NOT_FIND_UNIT",
    Data = 11101,
    Desc = "ErrCode_ERR_COURSE_NOT_FIND_UNIT_Desc|没找到课题分单元数据"
  },
  ERR_COURSE_PRIZE = {
    Key = "ERR_COURSE_PRIZE",
    Data = 11102,
    Desc = "ErrCode_ERR_COURSE_PRIZE_Desc|单元已提交，无需再次提交"
  },
  ERR_COURSE_UNIT_NOT_FINISH = {
    Key = "ERR_COURSE_UNIT_NOT_FINISH",
    Data = 11103,
    Desc = "ErrCode_ERR_COURSE_UNIT_NOT_FINISH_Desc|单元下的任务尚未全部完成，无法提交"
  },
  ERR_COURSE_NOT_FIND_MODULE = {
    Key = "ERR_COURSE_NOT_FIND_MODULE",
    Data = 11104,
    Desc = "ErrCode_ERR_COURSE_NOT_FIND_MODULE_Desc|课题分没找到模块"
  },
  ERR_COURSE_NOT_BARRIES_DATA = {
    Key = "ERR_COURSE_NOT_BARRIES_DATA",
    Data = 11105,
    Desc = "ErrCode_ERR_COURSE_NOT_BARRIES_DATA_Desc|关卡没有课题分数据"
  },
  ERR_COURSE_NOT_FIND_COPIES = {
    Key = "ERR_COURSE_NOT_FIND_COPIES",
    Data = 11106,
    Desc = "ErrCode_ERR_COURSE_NOT_FIND_COPIES_Desc|没有此副本的课题分"
  },
  ERR_COURSE_CREDIT_NOT_ENOUGH = {
    Key = "ERR_COURSE_CREDIT_NOT_ENOUGH",
    Data = 11107,
    Desc = "ErrCode_ERR_COURSE_CREDIT_NOT_ENOUGH_Desc|无法领取奖励"
  },
  ERR_COURSE_MODULE_NOT_FINISH = {
    Key = "ERR_COURSE_MODULE_NOT_FINISH",
    Data = 11108,
    Desc = "ErrCode_ERR_COURSE_MODULE_NOT_FINISH_Desc|奖励尚未达到领取条件"
  },
  ERR_COURSE_NOT_FIND_TASK = {
    Key = "ERR_COURSE_NOT_FIND_TASK",
    Data = 11109,
    Desc = "ErrCode_ERR_COURSE_NOT_FIND_TASK_Desc|尚未找到任务"
  },
  ERR_COURSE_TASK_FINISH = {
    Key = "ERR_COURSE_TASK_FINISH",
    Data = 11110,
    Desc = "ErrCode_ERR_COURSE_TASK_FINISH_Desc|任务已完成"
  },
  ERR_COURSE_TASK_CONDITION_NOT_FINISH = {
    Key = "ERR_COURSE_TASK_CONDITION_NOT_FINISH",
    Data = 11111,
    Desc = "ErrCode_ERR_COURSE_TASK_CONDITION_NOT_FINISH_Desc|任务中的子任务未完成"
  },
  ERR_TASK_FINISH = {
    Key = "ERR_TASK_FINISH",
    Data = 11112,
    Desc = "ErrCode_ERR_TASK_FINISH_Desc|任务已完成"
  },
  ERR_TASK_NOT_GAINPRIZE = {
    Key = "ERR_TASK_NOT_GAINPRIZE",
    Data = 11113,
    Desc = "ErrCode_ERR_TASK_NOT_GAINPRIZE_Desc|任务尚未完成,无法领取奖励"
  },
  ERR_TASK_NOT_FIND = {
    Key = "ERR_TASK_NOT_FIND",
    Data = 11114,
    Desc = "ErrCode_ERR_TASK_NOT_FIND_Desc|未找到任务"
  },
  ERR_GAIN_BATTLE_PRIZE = {
    Key = "ERR_GAIN_BATTLE_PRIZE",
    Data = 11115,
    Desc = "ErrCode_ERR_GAIN_BATTLE_PRIZE_Desc|当前节点没有奖励可领取"
  },
  ERR_SHOP_REFRESH = {
    Key = "ERR_SHOP_REFRESH",
    Data = 11116,
    Desc = "ErrCode_ERR_SHOP_REFRESH_Desc|当前不是商店节点无法刷新"
  },
  ERR_SHOP_CUSTOM_CMD = {
    Key = "ERR_SHOP_CUSTOM_CMD",
    Data = 11117,
    Desc = "ErrCode_ERR_SHOP_CUSTOM_CMD_Desc|当前无法进行感应"
  },
  ERR_ENHANCE_RELIC = {
    Key = "ERR_ENHANCE_RELIC",
    Data = 11118,
    Desc = "ErrCode_ERR_ENHANCE_RELIC_Desc|当前无法进行祭祀"
  },
  ERR_LAST_GEAR_NOT_FIND = {
    Key = "ERR_LAST_GEAR_NOT_FIND",
    Data = 11119,
    Desc = "ErrCode_ERR_LAST_GEAR_NOT_FIND_Desc|上一触发节点未找到"
  },
  ERR_TRIGGER_NOT_FIND = {
    Key = "ERR_TRIGGER_NOT_FIND",
    Data = 11120,
    Desc = "ErrCode_ERR_TRIGGER_NOT_FIND_Desc|当前触发节点未找到"
  },
  ERR_CLOSE_GEAR_NOT_FIND = {
    Key = "ERR_CLOSE_GEAR_NOT_FIND",
    Data = 11121,
    Desc = "ErrCode_ERR_CLOSE_GEAR_NOT_FIND_Desc|关闭当前节点未找到"
  },
  ERR_CHOOSE_GEAR_NOT_FIND = {
    Key = "ERR_CHOOSE_GEAR_NOT_FIND",
    Data = 11122,
    Desc = "ErrCode_ERR_CHOOSE_GEAR_NOT_FIND_Desc|选择当前节点未找到"
  },
  ERR_NPC_FINISH = {
    Key = "ERR_NPC_FINISH",
    Data = 11201,
    Desc = "ErrCode_ERR_NPC_FINISH_Desc|Npc已触发过"
  },
  ERR_NPC_DATA = {
    Key = "ERR_NPC_DATA",
    Data = 11202,
    Desc = "ErrCode_ERR_NPC_DATA_Desc|NPC数据错误"
  },
  ERR_NPC_NOT_FIND = {
    Key = "ERR_NPC_NOT_FIND",
    Data = 11203,
    Desc = "ErrCode_ERR_NPC_NOT_FIND_Desc|NPC不存在"
  },
  ERR_TALENT_NOT_COPIES = {
    Key = "ERR_TALENT_NOT_COPIES",
    Data = 11300,
    Desc = "ErrCode_ERR_TALENT_NOT_COPIES_Desc|副本中未发现共鸣"
  },
  ERR_TALENT_NOT_FIND = {
    Key = "ERR_TALENT_NOT_FIND",
    Data = 11301,
    Desc = "ErrCode_ERR_TALENT_NOT_FIND_Desc|没有发现共鸣数据"
  },
  ERR_TALENT_MAX_LEVEL = {
    Key = "ERR_TALENT_MAX_LEVEL",
    Data = 11302,
    Desc = "ErrCode_ERR_TALENT_MAX_LEVEL_Desc|共鸣点已到达最大等级"
  },
  ERR_TALENT_NOT_FIND_LEVEL = {
    Key = "ERR_TALENT_NOT_FIND_LEVEL",
    Data = 11303,
    Desc = "ErrCode_ERR_TALENT_NOT_FIND_LEVEL_Desc|未发现共鸣点等级相关数据"
  },
  ERR_TALENT_NOT_RESET_NUM = {
    Key = "ERR_TALENT_NOT_RESET_NUM",
    Data = 11304,
    Desc = "ErrCode_ERR_TALENT_NOT_RESET_NUM_Desc|没有重置次数"
  },
  ERR_TALENT_ACTIVE_CONDITION = {
    Key = "ERR_TALENT_ACTIVE_CONDITION",
    Data = 11305,
    Desc = "ErrCode_ERR_TALENT_ACTIVE_CONDITION_Desc|激活条件不足"
  },
  ERR_TALENT_ITEM_NOT_ENOUGH = {
    Key = "ERR_TALENT_ITEM_NOT_ENOUGH",
    Data = 11306,
    Desc = "ErrCode_ERR_TALENT_ITEM_NOT_ENOUGH_Desc|共鸣材料不足。"
  },
  ERR_TALENT_ACTIVE = {
    Key = "ERR_TALENT_ACTIVE",
    Data = 11307,
    Desc = "ErrCode_ERR_TALENT_ACTIVE_Desc|共鸣已激活无需再次激活"
  },
  ERR_TALENT_INIT_STATE_NOT_RESET = {
    Key = "ERR_TALENT_INIT_STATE_NOT_RESET",
    Data = 11308,
    Desc = "ErrCode_ERR_TALENT_INIT_STATE_NOT_RESET_Desc|共鸣初始状态不能重置"
  },
  ERR_ROLE_NOT_ADVANCE = {
    Key = "ERR_ROLE_NOT_ADVANCE",
    Data = 11401,
    Desc = "ErrCode_ERR_ROLE_NOT_ADVANCE_Desc|唤醒体已升格到最高阶"
  },
  ERR_ROLE_ADVANCE_NOT_ITEM = {
    Key = "ERR_ROLE_ADVANCE_NOT_ITEM",
    Data = 11402,
    Desc = "ErrCode_ERR_ROLE_ADVANCE_NOT_ITEM_Desc|精英化所需材料数量不足"
  },
  ERR_ROLE_UPLEVEL_NOT_ITEM = {
    Key = "ERR_ROLE_UPLEVEL_NOT_ITEM",
    Data = 11403,
    Desc = "ErrCode_ERR_ROLE_UPLEVEL_NOT_ITEM_Desc|唤醒体升级消耗的道具不足"
  },
  ERR_ROLE_UPLEVEL_NOT_MONEY = {
    Key = "ERR_ROLE_UPLEVEL_NOT_MONEY",
    Data = 11404,
    Desc = "ErrCode_ERR_ROLE_UPLEVEL_NOT_MONEY_Desc|唤醒体升级消耗的货币不足"
  },
  ERR_ROLE_ADVANCE_NOT_MONEY = {
    Key = "ERR_ROLE_ADVANCE_NOT_MONEY",
    Data = 11405,
    Desc = "ErrCode_ERR_ROLE_ADVANCE_NOT_MONEY_Desc|唤醒体升级消耗的货币不足"
  },
  ERR_ROLE_NOT_SKILL = {
    Key = "ERR_ROLE_NOT_SKILL",
    Data = 11406,
    Desc = "ErrCode_ERR_ROLE_NOT_SKILL_Desc|唤醒体没有技能"
  },
  ERR_ROLE_SKILL_LOCKED = {
    Key = "ERR_ROLE_SKILL_LOCKED",
    Data = 11407,
    Desc = "ErrCode_ERR_ROLE_SKILL_LOCKED_Desc|唤醒体尚未解锁技能"
  },
  ERR_SENIORMONEY_NOT_ENOUGH = {
    Key = "ERR_SENIORMONEY_NOT_ENOUGH",
    Data = 11408,
    Desc = "ErrCode_ERR_SENIORMONEY_NOT_ENOUGH_Desc|银芯不足"
  },
  ERR_ITEM_NOT_ENOUGH = {
    Key = "ERR_ITEM_NOT_ENOUGH",
    Data = 11409,
    Desc = "ErrCode_ERR_ITEM_NOT_ENOUGH_Desc|物品不足"
  },
  ERR_ITEM_CHARGES_USEDUP = {
    Key = "ERR_ITEM_CHARGES_USEDUP",
    Data = 11410,
    Desc = "ErrCode_ERR_ITEM_CHARGES_USEDUP_Desc|今日购买次数已达上限"
  },
  ERR_ITEM_UNUSABLE = {
    Key = "ERR_ITEM_UNUSABLE",
    Data = 11411,
    Desc = "ErrCode_ERR_ITEM_UNUSABLE_Desc|物品不可使用"
  },
  ERR_ITEM_SUB_NUM_FAULT = {
    Key = "ERR_ITEM_SUB_NUM_FAULT",
    Data = 11412,
    Desc = "ErrCode_ERR_ITEM_SUB_NUM_FAULT_Desc|物品使用数量错误"
  },
  ERR_ROLE_SKILL_MAX = {
    Key = "ERR_ROLE_SKILL_MAX",
    Data = 11421,
    Desc = "ErrCode_ERR_ROLE_SKILL_MAX_Desc|技能已达到最大等级"
  },
  ERR_ROLE_SKILL_UPGRADE_NOT_ITEM = {
    Key = "ERR_ROLE_SKILL_UPGRADE_NOT_ITEM",
    Data = 11422,
    Desc = "ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_ITEM_Desc|技能升级道具不足"
  },
  ERR_ROLE_SKILL_UPGRADE_NOT_MONEY = {
    Key = "ERR_ROLE_SKILL_UPGRADE_NOT_MONEY",
    Data = 11423,
    Desc = "ErrCode_ERR_ROLE_SKILL_UPGRADE_NOT_MONEY_Desc|技能升级货币不足"
  },
  ERR_ROLE_POTENCY_MAX = {
    Key = "ERR_ROLE_POTENCY_MAX",
    Data = 11424,
    Desc = "ErrCode_ERR_ROLE_POTENCY_MAX_Desc|唤醒体潜力已到达最高等级"
  },
  ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM = {
    Key = "ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM",
    Data = 11425,
    Desc = "ErrCode_ERR_ROLE_POTENCY_UPGRADE_NOT_ITEM_Desc|唤醒体潜力升级道具不足"
  },
  ERR_ROLE_NOT_SLOTDATA = {
    Key = "ERR_ROLE_NOT_SLOTDATA",
    Data = 11426,
    Desc = "ErrCode_ERR_ROLE_NOT_SLOTDATA_Desc|没有槽位信息"
  },
  ERR_ROLE_MONEY_NOT_ENOUGH = {
    Key = "ERR_ROLE_MONEY_NOT_ENOUGH",
    Data = 11427,
    Desc = "ErrCode_ERR_ROLE_MONEY_NOT_ENOUGH_Desc|货币不足"
  },
  ERR_ROLE_SLOT_MAX_LEVEL = {
    Key = "ERR_ROLE_SLOT_MAX_LEVEL",
    Data = 11428,
    Desc = "ErrCode_ERR_ROLE_SLOT_MAX_LEVEL_Desc|已到达最大等级"
  },
  ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER = {
    Key = "ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER",
    Data = 11429,
    Desc = "ErrCode_ERR_ROLE_SLOT_UPGRADE_NOT_NUMBER_Desc|已没有手动升级槽位次数"
  },
  ERR_AWAKER_NOT_ARRIVED_LEVEL = {
    Key = "ERR_AWAKER_NOT_ARRIVED_LEVEL",
    Data = 11430,
    Desc = "ErrCode_ERR_AWAKER_NOT_ARRIVED_LEVEL_Desc|技能升级未到达设置的条件"
  },
  ERR_AWAKER_NOT_BREAKLEVEL = {
    Key = "ERR_AWAKER_NOT_BREAKLEVEL",
    Data = 11431,
    Desc = "ErrCode_ERR_AWAKER_NOT_BREAKLEVEL_Desc|唤醒体升格等级不足"
  },
  ERR_EXCLUSIVECARD_ROLE_NOT_FOUND = {
    Key = "ERR_EXCLUSIVECARD_ROLE_NOT_FOUND",
    Data = 11501,
    Desc = "ErrCode_ERR_EXCLUSIVECARD_ROLE_NOT_FOUND_Desc|升级路线没有配置角色id"
  },
  ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND = {
    Key = "ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND",
    Data = 11502,
    Desc = "ErrCode_ERR_EXCLUSIVECARD_CARD_CONFIG_NOT_FOUND_Desc|找不到指定专属卡信息"
  },
  ERR_EXCLUSIVE_CARD_INVALID = {
    Key = "ERR_EXCLUSIVE_CARD_INVALID",
    Data = 11503,
    Desc = "ErrCode_ERR_EXCLUSIVE_CARD_INVALID_Desc|指定专属卡未解锁"
  },
  ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND = {
    Key = "ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND",
    Data = 11504,
    Desc = "ErrCode_ERR_EXCLUSIVE_CARD_UUID_NOT_FOUND_Desc|找不到该专属卡uuid"
  },
  ERR_CARD_UPGRADE_NOT_NUMBER = {
    Key = "ERR_CARD_UPGRADE_NOT_NUMBER",
    Data = 11505,
    Desc = "ErrCode_ERR_CARD_UPGRADE_NOT_NUMBER_Desc|专属卡升级，没有次数"
  },
  ERR_CHAPTER_PRIZE_CONDITION = {
    Key = "ERR_CHAPTER_PRIZE_CONDITION",
    Data = 11601,
    Desc = "ErrCode_ERR_CHAPTER_PRIZE_CONDITION_Desc|章节奖励未达到积分"
  },
  ERR_CHAPTER_PRIZE_FINISH = {
    Key = "ERR_CHAPTER_PRIZE_FINISH",
    Data = 11602,
    Desc = "ErrCode_ERR_CHAPTER_PRIZE_FINISH_Desc|章节奖励已领取"
  },
  ERR_LOCK_SROTYLINE = {
    Key = "ERR_LOCK_SROTYLINE",
    Data = 11620,
    Desc = "ErrCode_ERR_LOCK_SROTYLINE_Desc|选择的剧情线尚未解锁"
  },
  ERR_LOCK_COPIES = {
    Key = "ERR_LOCK_COPIES",
    Data = 11621,
    Desc = "ErrCode_ERR_LOCK_COPIES_Desc|选择的副本尚未解锁"
  },
  ERR_LOCK_COPIESAREA = {
    Key = "ERR_LOCK_COPIESAREA",
    Data = 11622,
    Desc = "ErrCode_ERR_LOCK_COPIESAREA_Desc|副本区域尚未解锁"
  },
  ERR_LOCK_COPIESPLOTMOPPING = {
    Key = "ERR_LOCK_COPIESPLOTMOPPING",
    Data = 11623,
    Desc = "ErrCode_ERR_LOCK_COPIESPLOTMOPPING_Desc|剧情线扫荡尚未解锁"
  },
  ERR_BP_FAIL = {
    Key = "ERR_BP_FAIL",
    Data = 11700,
    Desc = "ErrCode_ERR_BP_FAIL_Desc|操作失败"
  },
  ERR_BP_REWARD_RECEIVED = {
    Key = "ERR_BP_REWARD_RECEIVED",
    Data = 11701,
    Desc = "ErrCode_ERR_BP_REWARD_RECEIVED_Desc|奖励已领取"
  },
  ERR_BP_REWARD_NOT_EXISTS = {
    Key = "ERR_BP_REWARD_NOT_EXISTS",
    Data = 11702,
    Desc = "ErrCode_ERR_BP_REWARD_NOT_EXISTS_Desc|奖励不存在"
  },
  ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH = {
    Key = "ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH",
    Data = 11703,
    Desc = "ErrCode_ERR_BP_PRIVILEGE_LEVEL_NOT_ENOUGH_Desc|特权等级不足，无法领取"
  },
  ERR_BP_BUYLEVEL_NOT_ENOUGH = {
    Key = "ERR_BP_BUYLEVEL_NOT_ENOUGH",
    Data = 11704,
    Desc = "ErrCode_ERR_BP_BUYLEVEL_NOT_ENOUGH_Desc|购买通行证等级需要的货币不足"
  },
  ERR_BP_NOT_CONFIG_PRIZE = {
    Key = "ERR_BP_NOT_CONFIG_PRIZE",
    Data = 11705,
    Desc = "ErrCode_ERR_BP_NOT_CONFIG_PRIZE_Desc|通行证未配置购买特权价格"
  },
  ERR_BP_PRIVILEGELEVEL_MAX = {
    Key = "ERR_BP_PRIVILEGELEVEL_MAX",
    Data = 11706,
    Desc = "ErrCode_ERR_BP_PRIVILEGELEVEL_MAX_Desc|通行证特权等级已满,无法再次购买"
  },
  ERR_CHALLENGE_NOT_FIND_PLOT = {
    Key = "ERR_CHALLENGE_NOT_FIND_PLOT",
    Data = 11801,
    Desc = "ErrCode_ERR_CHALLENGE_NOT_FIND_PLOT_Desc|未找到副本挑战的剧情线"
  },
  ERR_CHALLENGE_NOT_FIND_TASK = {
    Key = "ERR_CHALLENGE_NOT_FIND_TASK",
    Data = 11802,
    Desc = "ErrCode_ERR_CHALLENGE_NOT_FIND_TASK_Desc|未找到副本挑战的剧情线任务"
  },
  ERR_CHALLENGE_TASK_FINISH = {
    Key = "ERR_CHALLENGE_TASK_FINISH",
    Data = 11803,
    Desc = "ErrCode_ERR_CHALLENGE_TASK_FINISH_Desc|挑战任务已完成,无法再次领取奖励"
  },
  ERR_CHALLENGE_TASK_RUNING = {
    Key = "ERR_CHALLENGE_TASK_RUNING",
    Data = 11804,
    Desc = "ErrCode_ERR_CHALLENGE_TASK_RUNING_Desc|挑战任务尚未完成,无法领取奖励"
  },
  ERR_FACTORY_NOT_EXIST = {
    Key = "ERR_FACTORY_NOT_EXIST",
    Data = 11850,
    Desc = "ErrCode_ERR_FACTORY_NOT_EXIST_Desc|建筑不存在"
  },
  ERR_FACTORY_MAX_LEVEL = {
    Key = "ERR_FACTORY_MAX_LEVEL",
    Data = 11851,
    Desc = "ErrCode_ERR_FACTORY_MAX_LEVEL_Desc|建筑已到达最大等级"
  },
  ERR_FACTORY_UPGRADE_CONDITION = {
    Key = "ERR_FACTORY_UPGRADE_CONDITION",
    Data = 11852,
    Desc = "ErrCode_ERR_FACTORY_UPGRADE_CONDITION_Desc|升级/建设建筑条件不足"
  },
  ERR_FACTORY_EXIST = {
    Key = "ERR_FACTORY_EXIST",
    Data = 11853,
    Desc = "ErrCode_ERR_FACTORY_EXIST_Desc|建筑已存在不能再次建设"
  },
  ERR_FACTORY_UPGRADE_ITEMS = {
    Key = "ERR_FACTORY_UPGRADE_ITEMS",
    Data = 11854,
    Desc = "ErrCode_ERR_FACTORY_UPGRADE_ITEMS_Desc|升级/建设所需要的的道具不足"
  },
  ERR_FACTORY_HAVE_ACTOR = {
    Key = "ERR_FACTORY_HAVE_ACTOR",
    Data = 11855,
    Desc = "ErrCode_ERR_FACTORY_HAVE_ACTOR_Desc|位置已存在唤醒体,无法入驻"
  },
  ERR_FACTORY_COMPOSE_NOT_ITEMS = {
    Key = "ERR_FACTORY_COMPOSE_NOT_ITEMS",
    Data = 11856,
    Desc = "ErrCode_ERR_FACTORY_COMPOSE_NOT_ITEMS_Desc|合成道具所需的其他道具不足"
  },
  ERR_FACTORY_COMPOSE_NOT_CURRENCY = {
    Key = "ERR_FACTORY_COMPOSE_NOT_CURRENCY",
    Data = 11857,
    Desc = "ErrCode_ERR_FACTORY_COMPOSE_NOT_CURRENCY_Desc|合成道具需要的货币不足"
  },
  ERR_FACTORY_COMPOSE_ITEM_LOCK = {
    Key = "ERR_FACTORY_COMPOSE_ITEM_LOCK",
    Data = 11858,
    Desc = "ErrCode_ERR_FACTORY_COMPOSE_ITEM_LOCK_Desc|合成道具未解锁"
  },
  ERR_SERVER_CLOSED = {
    Key = "ERR_SERVER_CLOSED",
    Data = 11859,
    Desc = "ErrCode_ERR_SERVER_CLOSED_Desc|校园维护中，请静候修整完成"
  },
  ERR_NOT_HAVE_ITEM = {
    Key = "ERR_NOT_HAVE_ITEM",
    Data = 11860,
    Desc = "ErrCode_ERR_NOT_HAVE_ITEM_Desc|您没有此道具"
  },
  ERR_INVALID_INDEX = {
    Key = "ERR_INVALID_INDEX",
    Data = 11861,
    Desc = "ErrCode_ERR_INVALID_INDEX_Desc|错误的索引值"
  },
  ERR_LOCKED = {
    Key = "ERR_LOCKED",
    Data = 11862,
    Desc = "ErrCode_ERR_LOCKED_Desc|未解锁"
  },
  ERR_ROLE_ENERGY_FULL = {
    Key = "ERR_ROLE_ENERGY_FULL",
    Data = 11863,
    Desc = "ErrCode_ERR_ROLE_ENERGY_FULL_Desc|唤醒体降临度已满，无法继续提升"
  },
  ERR_TALENT_UNLOCK = {
    Key = "ERR_TALENT_UNLOCK",
    Data = 11864,
    Desc = "ErrCode_ERR_TALENT_UNLOCK_Desc|唤醒体生产效果已解锁,无需再次解锁"
  },
  ERR_MONEYCHALLENGE_NOT_CHALLENGE = {
    Key = "ERR_MONEYCHALLENGE_NOT_CHALLENGE",
    Data = 11900,
    Desc = "ErrCode_ERR_MONEYCHALLENGE_NOT_CHALLENGE_Desc|指定金币本无法挑战-"
  },
  ERR_MONEYCHALLENGE_NOT_CONDITION = {
    Key = "ERR_MONEYCHALLENGE_NOT_CONDITION",
    Data = 11901,
    Desc = "ErrCode_ERR_MONEYCHALLENGE_NOT_CONDITION_Desc|指定金币本未解锁-请完成指定的调查副本"
  },
  ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE = {
    Key = "ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE",
    Data = 11902,
    Desc = "ErrCode_ERR_MONEYCHALLENGE_NOT_CHOOSE_ROUSE_Desc|请选择上阵的唤醒体"
  },
  ERR_PVP_NOT_COUNT = {
    Key = "ERR_PVP_NOT_COUNT",
    Data = 11950,
    Desc = "ErrCode_ERR_PVP_NOT_COUNT_Desc|没有挑战次数"
  },
  ERR_PVP_NOT_COOLTIME = {
    Key = "ERR_PVP_NOT_COOLTIME",
    Data = 11951,
    Desc = "ErrCode_ERR_PVP_NOT_COOLTIME_Desc|挑战冷却中"
  },
  ERR_PVP_NOT_FIND_OTHER = {
    Key = "ERR_PVP_NOT_FIND_OTHER",
    Data = 11952,
    Desc = "ErrCode_ERR_PVP_NOT_FIND_OTHER_Desc|没有挑战对手"
  },
  ERR_PVP_NOT_FIND_ROUSE = {
    Key = "ERR_PVP_NOT_FIND_ROUSE",
    Data = 11953,
    Desc = "ErrCode_ERR_PVP_NOT_FIND_ROUSE_Desc|请选择上阵的唤醒体"
  },
  ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH = {
    Key = "ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH",
    Data = 11954,
    Desc = "ErrCode_ERR_GAMECOPY_CHALLENGETIMES_NOT_ENOUGH_Desc|没有挑战次数"
  },
  ERR_PLOT_BUY_TIMES_NOT_ENOUGH = {
    Key = "ERR_PLOT_BUY_TIMES_NOT_ENOUGH",
    Data = 11955,
    Desc = "ErrCode_ERR_PLOT_BUY_TIMES_NOT_ENOUGH_Desc|剧情线挑战购买次数不足"
  },
  ERR_PLOTMOP_STARLIMIT = {
    Key = "ERR_PLOTMOP_STARLIMIT",
    Data = 11956,
    Desc = "ErrCode_ERR_PLOTMOP_STARLIMIT_Desc|剧情线星级不足，无法扫荡"
  },
  ERR_TEAM_SCHOOLMIX = {
    Key = "ERR_TEAM_SCHOOLMIX",
    Data = 11957,
    Desc = "ErrCode_ERR_TEAM_SCHOOLMIX_Desc|队伍中唤醒体存在界域冲突，请进行调整"
  },
  ERR_BUY_TICKET_NO_MONEY = {
    Key = "ERR_BUY_TICKET_NO_MONEY",
    Data = 11958,
    Desc = "ErrCode_ERR_BUY_TICKET_NO_MONEY_Desc|银芯源液不足"
  },
  ERR_TICKET_NOT_ENOUGH = {
    Key = "ERR_TICKET_NOT_ENOUGH",
    Data = 11959,
    Desc = "ErrCode_ERR_TICKET_NOT_ENOUGH_Desc|凭证不足"
  },
  ERR_BUY_TICKET_NO_TIMES = {
    Key = "ERR_BUY_TICKET_NO_TIMES",
    Data = 11960,
    Desc = "ErrCode_ERR_BUY_TICKET_NO_TIMES_Desc|凭证购买次数不足"
  },
  ERR_PVP_QUIT = {
    Key = "ERR_PVP_QUIT",
    Data = 11961,
    Desc = "ErrCode_ERR_PVP_QUIT_Desc|对手已退出"
  },
  ERR_PVP_OverWinTime = {
    Key = "ERR_PVP_OverWinTime",
    Data = 11962,
    Desc = "ErrCode_ERR_PVP_OverWinTime_Desc|双方其中有一人已达两次胜场，无法再来一局"
  },
  ERR_PVP_ROOM_NOT_EXIST = {
    Key = "ERR_PVP_ROOM_NOT_EXIST",
    Data = 11963,
    Desc = "ErrCode_ERR_PVP_ROOM_NOT_EXIST_Desc|密码对战 不存在 或 已过时"
  },
  ERR_SHOP_NOT_GOODS = {
    Key = "ERR_SHOP_NOT_GOODS",
    Data = 12000,
    Desc = "ErrCode_ERR_SHOP_NOT_GOODS_Desc|没有此商品出售"
  },
  ERR_SHOP_NOT = {
    Key = "ERR_SHOP_NOT",
    Data = 12001,
    Desc = "ErrCode_ERR_SHOP_NOT_Desc|没有此类型商店"
  },
  ERR_SHOP_GOODS_NOT_ENGHOU = {
    Key = "ERR_SHOP_GOODS_NOT_ENGHOU",
    Data = 12002,
    Desc = "ErrCode_ERR_SHOP_GOODS_NOT_ENGHOU_Desc|出售的商品已没有库存"
  },
  ERR_SHOP_NOT_DATA = {
    Key = "ERR_SHOP_NOT_DATA",
    Data = 12003,
    Desc = "ErrCode_ERR_SHOP_NOT_DATA_Desc|没有商店数据"
  },
  ERR_SHOP_NOT_REFRESH_NUM = {
    Key = "ERR_SHOP_NOT_REFRESH_NUM",
    Data = 12004,
    Desc = "ErrCode_ERR_SHOP_NOT_REFRESH_NUM_Desc|没有刷新次数"
  },
  ERR_ENERGY_STORE_MAX = {
    Key = "ERR_ENERGY_STORE_MAX",
    Data = 13000,
    Desc = "ErrCode_ERR_ENERGY_STORE_MAX_Desc|灵啡肽已充足，无需补充"
  },
  ERR_RECHARGE_NOT_CONFIG = {
    Key = "ERR_RECHARGE_NOT_CONFIG",
    Data = 13050,
    Desc = "ErrCode_ERR_RECHARGE_NOT_CONFIG_Desc|充值配置表中没有此配置"
  },
  ERR_RECHARGE_NOT_FREE = {
    Key = "ERR_RECHARGE_NOT_FREE",
    Data = 13051,
    Desc = "ErrCode_ERR_RECHARGE_NOT_FREE_Desc|已免费充值过无法再次充值"
  },
  ERR_ITEM_HAS_LOCKED = {
    Key = "ERR_ITEM_HAS_LOCKED",
    Data = 13100,
    Desc = "ErrCode_ERR_ITEM_HAS_LOCKED_Desc|道具已锁定"
  },
  ERR_ITEM_NOT_FIND = {
    Key = "ERR_ITEM_NOT_FIND",
    Data = 13101,
    Desc = "ErrCode_ERR_ITEM_NOT_FIND_Desc|道具未找到"
  },
  ERR_ITEM_MAX_STAGE = {
    Key = "ERR_ITEM_MAX_STAGE",
    Data = 13102,
    Desc = "ErrCode_ERR_ITEM_MAX_STAGE_Desc|道具已达最大等阶"
  },
  ERR_ITEM_HAS_BEEN_EQUIP = {
    Key = "ERR_ITEM_HAS_BEEN_EQUIP",
    Data = 13103,
    Desc = "ErrCode_ERR_ITEM_HAS_BEEN_EQUIP_Desc|道具已被装备"
  },
  ERR_ITEM_NOT_MATCH = {
    Key = "ERR_ITEM_NOT_MATCH",
    Data = 13104,
    Desc = "ErrCode_ERR_ITEM_NOT_MATCH_Desc|道具不匹配"
  },
  ERR_ITEM_HAS_UNLOCKED = {
    Key = "ERR_ITEM_HAS_UNLOCKED",
    Data = 13105,
    Desc = "ErrCode_ERR_ITEM_HAS_UNLOCKED_Desc|道具未锁定"
  },
  ERR_ITEM_BAG_FULL = {
    Key = "ERR_ITEM_BAG_FULL",
    Data = 13106,
    Desc = "ErrCode_ERR_ITEM_BAG_FULL_Desc|背包已满"
  },
  ERR_ITEM_NOT_USE = {
    Key = "ERR_ITEM_NOT_USE",
    Data = 13107,
    Desc = "ErrCode_ERR_ITEM_NOT_USE_Desc|道具无法使用"
  },
  ERR_ITEM_REPEAT = {
    Key = "ERR_ITEM_REPEAT",
    Data = 13108,
    Desc = "ErrCode_ERR_ITEM_REPEAT_Desc|道具重复"
  },
  ERR_TRINKET_NOT_TRAINING = {
    Key = "ERR_TRINKET_NOT_TRAINING",
    Data = 13109,
    Desc = "ErrCode_ERR_TRINKET_NOT_TRAINING_Desc|饰品没转录,无法替换属性"
  },
  ERR_TEAM_NO_TEAM = {
    Key = "ERR_TEAM_NO_TEAM",
    Data = 13150,
    Desc = "ErrCode_ERR_TEAM_NO_TEAM_Desc|找不到队伍配置"
  },
  ERR_TEAM_NO_WEAPON_SLOT = {
    Key = "ERR_TEAM_NO_WEAPON_SLOT",
    Data = 13151,
    Desc = "ErrCode_ERR_TEAM_NO_WEAPON_SLOT_Desc|队伍唤醒体没有设置命轮"
  },
  ERR_TEAM_WEAPON_NOT_EXISTS = {
    Key = "ERR_TEAM_WEAPON_NOT_EXISTS",
    Data = 13152,
    Desc = "ErrCode_ERR_TEAM_WEAPON_NOT_EXISTS_Desc|命轮不存在"
  },
  ERR_TEAM_NAME_ILLEGLE = {
    Key = "ERR_TEAM_NAME_ILLEGLE",
    Data = 13200,
    Desc = "ErrCode_ERR_TEAM_NAME_ILLEGLE_Desc|队伍名中不可包含非中文或英文字符"
  },
  ERR_TEAM_NAME_TOO_LONG = {
    Key = "ERR_TEAM_NAME_TOO_LONG",
    Data = 13201,
    Desc = "ErrCode_ERR_TEAM_NAME_TOO_LONG_Desc|队伍名长度不可大于8个字符"
  },
  ERR_TEAM_NEED_4_AWAKER = {
    Key = "ERR_TEAM_NEED_4_AWAKER",
    Data = 13202,
    Desc = "ErrCode_ERR_TEAM_NEED_4_AWAKER_Desc|队伍中唤醒体数量需要满足四个才可进入关卡"
  },
  ERR_AWAKER_USED = {
    Key = "ERR_AWAKER_USED",
    Data = 13203,
    Desc = "ErrCode_ERR_AWAKER_USED_Desc|唤醒体已被使用过"
  },
  ERR_MAIL_ITEM_GAIN = {
    Key = "ERR_MAIL_ITEM_GAIN",
    Data = 13204,
    Desc = "ErrCode_ERR_MAIL_ITEM_GAIN_Desc|附件已领取"
  },
  ERR_MAIL_NOT_FIND = {
    Key = "ERR_MAIL_NOT_FIND",
    Data = 13205,
    Desc = "ErrCode_ERR_MAIL_NOT_FIND_Desc|邮件不存在"
  },
  ERR_TASKMODULE_PRIZE_NOT_GAIN = {
    Key = "ERR_TASKMODULE_PRIZE_NOT_GAIN",
    Data = 13206,
    Desc = "ErrCode_ERR_TASKMODULE_PRIZE_NOT_GAIN_Desc|奖励已领取"
  },
  ERR_TASK_DELEGATE_NOT_COND = {
    Key = "ERR_TASK_DELEGATE_NOT_COND",
    Data = 13207,
    Desc = "ErrCode_ERR_TASK_DELEGATE_NOT_COND_Desc|委派条件不足"
  },
  ERR_SUMMON_NOT_OPEN = {
    Key = "ERR_SUMMON_NOT_OPEN",
    Data = 13208,
    Desc = "ErrCode_ERR_SUMMON_NOT_OPEN_Desc|唤醒功能未开启"
  },
  ERR_EQUIP_NOT_FIND = {
    Key = "ERR_EQUIP_NOT_FIND",
    Data = 13209,
    Desc = "ErrCode_ERR_EQUIP_NOT_FIND_Desc|饰品不存在"
  },
  ERR_HOME_PLAYERLEVEL_LOCK = {
    Key = "ERR_HOME_PLAYERLEVEL_LOCK",
    Data = 13211,
    Desc = "ErrCode_ERR_HOME_PLAYERLEVEL_LOCK_Desc|玩家等级不足"
  },
  ERR_ROLE_LEVEl_NOENOUGH = {
    Key = "ERR_ROLE_LEVEl_NOENOUGH",
    Data = 13212,
    Desc = "ErrCode_ERR_ROLE_LEVEl_NOENOUGH_Desc|唤醒体等级不足"
  },
  ERR_PUTENCHANT_FAIL = {
    Key = "ERR_PUTENCHANT_FAIL",
    Data = 13213,
    Desc = "ErrCode_ERR_PUTENCHANT_FAIL_Desc|镶嵌符文失败"
  },
  ERR_NOT_MOVE = {
    Key = "ERR_NOT_MOVE",
    Data = 13214,
    Desc = "ErrCode_ERR_NOT_MOVE_Desc|不可移动"
  },
  ERR_GEAR_NOT_FINISH = {
    Key = "ERR_GEAR_NOT_FINISH",
    Data = 13215,
    Desc = "ErrCode_ERR_GEAR_NOT_FINISH_Desc|节点未完成"
  },
  ERR_GEAR_FINISH = {
    Key = "ERR_GEAR_FINISH",
    Data = 13216,
    Desc = "ErrCode_ERR_GEAR_FINISH_Desc|节点已完成"
  },
  ERR_RELIC_FULL = {
    Key = "ERR_RELIC_FULL",
    Data = 13217,
    Desc = "ErrCode_ERR_RELIC_FULL_Desc|遗物已满"
  },
  ERR_GEAR_SHOP_NOT_NUM = {
    Key = "ERR_GEAR_SHOP_NOT_NUM",
    Data = 13218,
    Desc = "ErrCode_ERR_GEAR_SHOP_NOT_NUM_Desc|商店刷新次数不足"
  },
  ERR_GEAR_BLOCK = {
    Key = "ERR_GEAR_BLOCK",
    Data = 13219,
    Desc = "ErrCode_ERR_GEAR_BLOCK_Desc|节点未解锁"
  },
  ERR_TASK_APPOINT_TASK_FINISH = {
    Key = "ERR_TASK_APPOINT_TASK_FINISH",
    Data = 13300,
    Desc = "ErrCode_ERR_TASK_APPOINT_TASK_FINISH_Desc|委派任务已完成,不可召回"
  },
  ERR_ACTIVITY_TRIAL_NOT_STAGE = {
    Key = "ERR_ACTIVITY_TRIAL_NOT_STAGE",
    Data = 13400,
    Desc = "ErrCode_ERR_ACTIVITY_TRIAL_NOT_STAGE_Desc|试玩活动中,未找到此关卡"
  },
  ERR_ACTIVITY_TRIALSTAGE_FAIL = {
    Key = "ERR_ACTIVITY_TRIALSTAGE_FAIL",
    Data = 13401,
    Desc = "ErrCode_ERR_ACTIVITY_TRIALSTAGE_FAIL_Desc|试玩活动,未完成关卡不能领取奖励"
  },
  ERR_ACTIVITY_NOT_CONDITION = {
    Key = "ERR_ACTIVITY_NOT_CONDITION",
    Data = 13402,
    Desc = "ErrCode_ERR_ACTIVITY_NOT_CONDITION_Desc|参加活动,条件不满足"
  },
  ERR_ACTIVITY_LOGINDAILY = {
    Key = "ERR_ACTIVITY_LOGINDAILY",
    Data = 13403,
    Desc = "ErrCode_ERR_ACTIVITY_LOGINDAILY_Desc|登入天数不足,不能领取奖励"
  },
  ERR_ACTIVITY_TASK_NOT_FINISH = {
    Key = "ERR_ACTIVITY_TASK_NOT_FINISH",
    Data = 13404,
    Desc = "ErrCode_ERR_ACTIVITY_TASK_NOT_FINISH_Desc|活动任务未完成"
  },
  ERR_ACTIVITY_NOT_FIND = {
    Key = "ERR_ACTIVITY_NOT_FIND",
    Data = 13405,
    Desc = "ErrCode_ERR_ACTIVITY_NOT_FIND_Desc|不存在此活动"
  },
  ERR_ACTIVITY_FINISH = {
    Key = "ERR_ACTIVITY_FINISH",
    Data = 13406,
    Desc = "ErrCode_ERR_ACTIVITY_FINISH_Desc|活动已结束"
  },
  ERR_ACTIVITY_NOT_OPEN = {
    Key = "ERR_ACTIVITY_NOT_OPEN",
    Data = 13407,
    Desc = "ErrCode_ERR_ACTIVITY_NOT_OPEN_Desc|活动尚未开启"
  },
  ERR_ACTIVITY_NOT_HANDLE_CLASS = {
    Key = "ERR_ACTIVITY_NOT_HANDLE_CLASS",
    Data = 13408,
    Desc = "ErrCode_ERR_ACTIVITY_NOT_HANDLE_CLASS_Desc|活动未开发"
  },
  ERR_UNLOCK_SUB_PLOT_AVAILABLE = {
    Key = "ERR_UNLOCK_SUB_PLOT_AVAILABLE",
    Data = 13501,
    Desc = "ErrCode_ERR_UNLOCK_SUB_PLOT_AVAILABLE_Desc|解锁支线失败：支线可用"
  },
  ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM = {
    Key = "ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM",
    Data = 13502,
    Desc = "ErrCode_ERR_UNLOCK_SUB_PLOT_NO_UNLOCKITEM_Desc|解锁支线失败：无需解锁物品"
  },
  ERR_UNLOCK_SUB_PLOT_UNLOCKED = {
    Key = "ERR_UNLOCK_SUB_PLOT_UNLOCKED",
    Data = 13503,
    Desc = "ErrCode_ERR_UNLOCK_SUB_PLOT_UNLOCKED_Desc|解锁支线失败：支线已解锁"
  },
  ERR_UNLOCK_SUB_PLOT_NOT_OPEN = {
    Key = "ERR_UNLOCK_SUB_PLOT_NOT_OPEN",
    Data = 13504,
    Desc = "ErrCode_ERR_UNLOCK_SUB_PLOT_NOT_OPEN_Desc|解锁支线失败：支线未开启"
  },
  ERR_SCHOOL_TOWN_BATCH_MATCH = {
    Key = "ERR_SCHOOL_TOWN_BATCH_MATCH",
    Data = 13550,
    Desc = "ErrCode_ERR_SCHOOL_TOWN_BATCH_MATCH_Desc|进入的关卡不在当前开启的关卡中"
  },
  ERR_SCHOOL_TOWN_SAME_AWAKER = {
    Key = "ERR_SCHOOL_TOWN_SAME_AWAKER",
    Data = 13551,
    Desc = "ErrCode_ERR_SCHOOL_TOWN_SAME_AWAKER_Desc|界域塔不可携带相同的唤醒体出战"
  },
  ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT = {
    Key = "ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT",
    Data = 13552,
    Desc = "ErrCode_ERR_SCHOOL_TOWN_AWAKER_REQUIREMENT_Desc|界域塔出战的唤醒体不满足界域要求"
  },
  ERR_NOT_PRIZE_CONDITION = {
    Key = "ERR_NOT_PRIZE_CONDITION",
    Data = 13553,
    Desc = "ErrCode_ERR_NOT_PRIZE_CONDITION_Desc|奖励未满足条件,无法领取"
  },
  ERR_PVPTEAM_NEED_WEAPON = {
    Key = "ERR_PVPTEAM_NEED_WEAPON",
    Data = 13580,
    Desc = "ErrCode_ERR_PVPTEAM_NEED_WEAPON_Desc|相位对弈队伍上阵命轮不足"
  },
  ERR_PVPTEAM_NEED_KEEPERSKILL = {
    Key = "ERR_PVPTEAM_NEED_KEEPERSKILL",
    Data = 13581,
    Desc = "ErrCode_ERR_PVPTEAM_NEED_KEEPERSKILL_Desc|相位对弈队伍上阵钥令不足"
  },
  ERR_PVPCOLLECT_NOT_FIND = {
    Key = "ERR_PVPCOLLECT_NOT_FIND",
    Data = 13582,
    Desc = "ErrCode_ERR_PVPCOLLECT_NOT_FIND_Desc|未获得PVP收藏"
  },
  ERR_MATCH_FAIL = {
    Key = "ERR_MATCH_FAIL",
    Data = 13583,
    Desc = "ErrCode_ERR_MATCH_FAIL_Desc|匹配失败"
  },
  ERR_SUMMON_CLICKTOOFAST = {
    Key = "ERR_SUMMON_CLICKTOOFAST",
    Data = 13584,
    Desc = "ErrCode_ERR_SUMMON_CLICKTOOFAST_Desc|点击过于频繁，请稍候尝试"
  },
  ERR_SOCIAL_NO_ROLE = {
    Key = "ERR_SOCIAL_NO_ROLE",
    Data = 13600,
    Desc = "ErrCode_ERR_SOCIAL_NO_ROLE_Desc|该玩家不存在"
  },
  ERR_REQUEST_CD = {
    Key = "ERR_REQUEST_CD",
    Data = 13601,
    Desc = "ErrCode_ERR_REQUEST_CD_Desc|请求过于频繁，请稍候尝试"
  },
  ERR_NOTE_LENGTH_LIMIT = {
    Key = "ERR_NOTE_LENGTH_LIMIT",
    Data = 13602,
    Desc = "ErrCode_ERR_NOTE_LENGTH_LIMIT_Desc|输入字符过长"
  },
  ERR_ILLEGAL_CHARACTER = {
    Key = "ERR_ILLEGAL_CHARACTER",
    Data = 13603,
    Desc = "ErrCode_ERR_ILLEGAL_CHARACTER_Desc|简介包含非法字符,请重新输入"
  },
  ERR_NO_AWAKER_DETAIL = {
    Key = "ERR_NO_AWAKER_DETAIL",
    Data = 13604,
    Desc = "ErrCode_ERR_NO_AWAKER_DETAIL_Desc|个人资料更新中，请稍后再查看。"
  },
  ERR_NO_TRINKET = {
    Key = "ERR_NO_TRINKET",
    Data = 13605,
    Desc = "ErrCode_ERR_NO_TRINKET_Desc|当前没有闲置密契"
  },
  ERR_OFFLINE = {
    Key = "ERR_OFFLINE",
    Data = 13606,
    Desc = "ErrCode_ERR_OFFLINE_Desc|对方当前不在线"
  },
  ERR_RELATION = {
    Key = "ERR_RELATION",
    Data = 13607,
    Desc = "ErrCode_ERR_RELATION_Desc|与对方不是互相关注状态"
  },
  ERR_NO_FRIEND_GAME = {
    Key = "ERR_NO_FRIEND_GAME",
    Data = 13608,
    Desc = "ErrCode_ERR_NO_FRIEND_GAME_Desc|当前没有进行中的友谊赛"
  },
  ERR_INOTHERBATTLE = {
    Key = "ERR_INOTHERBATTLE",
    Data = 13609,
    Desc = "ErrCode_ERR_INOTHERBATTLE_Desc|对方正在调查或其他玩法中"
  },
  ERR_AlREADY_BAN = {
    Key = "ERR_AlREADY_BAN",
    Data = 13610,
    Desc = "ErrCode_ERR_AlREADY_BAN_Desc|不可重复拉黑"
  },
  ERR_UNATTEN_FIRST = {
    Key = "ERR_UNATTEN_FIRST",
    Data = 13611,
    Desc = "ErrCode_ERR_UNATTEN_FIRST_Desc|先取消关注对方才可拉黑"
  },
  ERR_BAN_NUM_LIMIT = {
    Key = "ERR_BAN_NUM_LIMIT",
    Data = 13612,
    Desc = "ErrCode_ERR_BAN_NUM_LIMIT_Desc|拉黑人数达到上限"
  },
  ERR_BANNED_FOLLOW_LIKE = {
    Key = "ERR_BANNED_FOLLOW_LIKE",
    Data = 13613,
    Desc = "ErrCode_ERR_BANNED_FOLLOW_LIKE_Desc|你已被对方列入黑名单，无法关注和点赞"
  },
  ERR_BAN_FOLLOW_LIKE = {
    Key = "ERR_BAN_FOLLOW_LIKE",
    Data = 13614,
    Desc = "ErrCode_ERR_BAN_FOLLOW_LIKE_Desc|你已将对方列入黑名单，无法点赞和关注"
  },
  ERR_STAGE_GROUP_BAN_BY_TASK = {
    Key = "ERR_STAGE_GROUP_BAN_BY_TASK",
    Data = 13615,
    Desc = "ErrCode_ERR_STAGE_GROUP_BAN_BY_TASK_Desc|该原初之视的所有分身均已被击杀"
  },
  ERR_ASSISTED_ONCE = {
    Key = "ERR_ASSISTED_ONCE",
    Data = 13616,
    Desc = "ErrCode_ERR_ASSISTED_ONCE_Desc|本活动该守密人已为你提供过一次助战"
  },
  ERR_ASSIST_NEED_FOLLOW_EACHOTHER = {
    Key = "ERR_ASSIST_NEED_FOLLOW_EACHOTHER",
    Data = 13617,
    Desc = "ErrCode_ERR_ASSIST_NEED_FOLLOW_EACHOTHER_Desc|本活动需要互相关注的守密人才能提供助战"
  },
  ERR_SCHOOL_NOT_MATCH = {
    Key = "ERR_SCHOOL_NOT_MATCH",
    Data = 13618,
    Desc = "ErrCode_ERR_SCHOOL_NOT_MATCH_Desc|界域不满足条件"
  },
  ERR_GEAR_NOT_NEIGHBORING = {
    Key = "ERR_GEAR_NOT_NEIGHBORING",
    Data = 13619,
    Desc = "ErrCode_ERR_GEAR_NOT_NEIGHBORING_Desc|节点不相邻"
  },
  ERR_AWAKER_START_DROP_DATE = {
    Key = "ERR_AWAKER_START_DROP_DATE",
    Data = 13620,
    Desc = "ErrCode_ERR_AWAKER_START_DROP_DATE_Desc|唤醒体还未到开放时间"
  },
  ERR_ITEM_START_DROP_DATE = {
    Key = "ERR_ITEM_START_DROP_DATE",
    Data = 13621,
    Desc = "ErrCode_ERR_ITEM_START_DROP_DATE_Desc|命轮或钥令还未到开放时间"
  },
  ERR_ENCHANCE_RELIC_EXIST = {
    Key = "ERR_ENCHANCE_RELIC_EXIST",
    Data = 13622,
    Desc = "ErrCode_ERR_ENCHANCE_RELIC_EXIST_Desc|造物已强化"
  },
  ERR_CANT_ENCHANCE_RELIC = {
    Key = "ERR_CANT_ENCHANCE_RELIC",
    Data = 13623,
    Desc = "ErrCode_ERR_CANT_ENCHANCE_RELIC_Desc|造物不支持强化"
  },
  ERR_UNIT_USED_ONCE = {
    Key = "ERR_UNIT_USED_ONCE",
    Data = 13624,
    Desc = "ErrCode_ERR_UNIT_USED_ONCE_Desc|唤醒体、命轮或钥令今日在本玩法中已使用过"
  },
  ERR_CUSTOM_CMD_USE_LIMIT = {
    Key = "ERR_CUSTOM_CMD_USE_LIMIT",
    Data = 13625,
    Desc = "ErrCode_ERR_CUSTOM_CMD_USE_LIMIT_Desc|自定义指令使用次数达到上限"
  },
  ERR_REFRESH_NUM_LIMIT = {
    Key = "ERR_REFRESH_NUM_LIMIT",
    Data = 13626,
    Desc = "ErrCode_ERR_REFRESH_NUM_LIMIT_Desc|商品刷新次数达到上限"
  },
  ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT = {
    Key = "ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT",
    Data = 13627,
    Desc = "ErrCode_ERR_STAGE_GROUP_TYPE_BAN_BY_DAILY_WIN_COUNT_Desc|关卡类型每日挑战次数达到上限"
  },
  ERR_MAXSUMMONLIMIT = {
    Key = "ERR_MAXSUMMONLIMIT",
    Data = 13628,
    Desc = "ErrCode_ERR_MAXSUMMONLIMIT_Desc|已达最大可唤醒次数！"
  },
  ERR_EXPIRED_SUPPORTLIST = {
    Key = "ERR_EXPIRED_SUPPORTLIST",
    Data = 13629,
    Desc = "ErrCode_ERR_EXPIRED_SUPPORTLIST_Desc|助战唤醒体已失效，请刷新助战列表重新选择助战唤醒体。"
  },
  ERR_INVITE_EACH = {
    Key = "ERR_INVITE_EACH",
    Data = 13700,
    Desc = "ErrCode_ERR_INVITE_EACH_Desc|您已是对方的邀请人"
  },
  ERR_INVITE_REPEAT = {
    Key = "ERR_INVITE_REPEAT",
    Data = 13701,
    Desc = "ErrCode_ERR_INVITE_REPEAT_Desc|已有邀请人"
  },
  ERR_PVP_DRAFT_LOCK = {
    Key = "ERR_PVP_DRAFT_LOCK",
    Data = 13702,
    Desc = "ErrCode_ERR_PVP_DRAFT_LOCK_Desc|未达到轮选模式开启条件"
  },
  ERR_ASSIST_STAR_LIMIT = {
    Key = "ERR_ASSIST_STAR_LIMIT",
    Data = 13703,
    Desc = "ErrCode_ERR_ASSIST_STAR_LIMIT_Desc|常用助战守密人已达上限，请调整常用助战列表"
  },
  ERR_CARD_REVIEW_LENGTH_EXCEEDED = {
    Key = "ERR_CARD_REVIEW_LENGTH_EXCEEDED",
    Data = 13704,
    Desc = "ErrCode_ERR_CARD_REVIEW_LENGTH_EXCEEDED_Desc|长度超过限制"
  },
  ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD = {
    Key = "ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD",
    Data = 13705,
    Desc = "ErrCode_ERR_CARD_REVIEW_CONTAINS_BLOCKED_WORD_Desc|包含屏蔽字"
  },
  ERR_CARD_REVIEW_DUPLICATE_COMMENT = {
    Key = "ERR_CARD_REVIEW_DUPLICATE_COMMENT",
    Data = 13706,
    Desc = "ErrCode_ERR_CARD_REVIEW_DUPLICATE_COMMENT_Desc|重复发表评论"
  },
  ERR_CARD_REVIEW_TIMEOUT = {
    Key = "ERR_CARD_REVIEW_TIMEOUT",
    Data = 13707,
    Desc = "ErrCode_ERR_CARD_REVIEW_TIMEOUT_Desc|评论超时"
  },
  ERR_CARD_REVIEW_DUPLICATE_LIKE = {
    Key = "ERR_CARD_REVIEW_DUPLICATE_LIKE",
    Data = 13708,
    Desc = "ErrCode_ERR_CARD_REVIEW_DUPLICATE_LIKE_Desc|重复点赞"
  },
  ERR_CARD_REVIEW_DUPLICATE_DELETE = {
    Key = "ERR_CARD_REVIEW_DUPLICATE_DELETE",
    Data = 13709,
    Desc = "ErrCode_ERR_CARD_REVIEW_DUPLICATE_DELETE_Desc|重复删除"
  },
  ERR_CARD_REVIEW_DUPLICATE_UNLIKE = {
    Key = "ERR_CARD_REVIEW_DUPLICATE_UNLIKE",
    Data = 13710,
    Desc = "ErrCode_ERR_CARD_REVIEW_DUPLICATE_UNLIKE_Desc|重复取消点赞"
  },
  ERR_CARD_REVIEW_LIKE_ALREADY_DELETED = {
    Key = "ERR_CARD_REVIEW_LIKE_ALREADY_DELETED",
    Data = 13711,
    Desc = "ErrCode_ERR_CARD_REVIEW_LIKE_ALREADY_DELETED_Desc|点赞评论已删除"
  },
  ERR_RANK_OUT_OF_RANGE = {
    Key = "ERR_RANK_OUT_OF_RANGE",
    Data = 13712,
    Desc = "ErrCode_ERR_RANK_OUT_OF_RANGE_Desc|暂不支持查看 2000 名以外的排行信息。"
  },
  ERR_BATTLE_CREATE_FAILED = {
    Key = "ERR_BATTLE_CREATE_FAILED",
    Data = 13713,
    Desc = "ErrCode_ERR_BATTLE_CREATE_FAILED_Desc|战斗创建失败"
  },
  ERR_NOTE_LENGTH_SHORT = {
    Key = "ERR_NOTE_LENGTH_SHORT",
    Data = 13714,
    Desc = "ErrCode_ERR_NOTE_LENGTH_SHORT_Desc|输入字符过短"
  }
})
return ErrCode
