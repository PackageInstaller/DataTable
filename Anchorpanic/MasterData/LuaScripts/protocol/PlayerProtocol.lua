-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    12     
-- @Name:  player   
-- @Desc:  角色协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *s2c* 返回角色数据结束 12000
SC_PLAYER_END_DATA =
{
    12000,
}
 
--- *s2c* 返回角色基础数据 12001
SC_PLAYER_BASE_DATA =
{
    12001, 
    {"player_id", "int64str", "玩家id"}, 
    {"level", "int32", "玩家等级"}, 
    {"player_name", "string", "玩家名字"}, 
    {"signature", "string", "玩家签名"}, 
    {"gm", "int8", "是否开启gm"}, 
    {"avatar_id", "int32", "头像"}, 
    {"avatar_frame", "int32", "头像框"}, 
    {"designation", "int32", "称号"}, 
    {"exp", "int64str", "当前经验"}, 
    {"max_exp", "int64str", "经验上限"}, 
    {"vip_lv", "int64str", "vip等级"}, 
    {"pay_titanium", "int64str", "充值钛金石"}, 
    {"titanium", "int64str", "钛金石"}, 
    {"gold_coin", "int64str", "金币"}, 
    {"arena_coin", "int64str", "竞技币"}, 
    {"decoreate_coin", "int64str", "装饰币"}, 
    {"hero_global_exp", "int64str", "战员全局经验"}, 
    {"inst_global_exp", "int64str", "研究所全局经验"}, 
    {"prestige_exp", "int64str", "当前声望经验"}, 
    {"prestige_stage", "int64str", "声望等阶"}, 
    {"exploit", "int64str", "战勋"}, 
    {"show_hero_list", pt_show_hero_info, "展示战员列表", "repeated"}, 
    {"show_id", "string", "玩家展示id"}, 
    {"hero_board_show_id", "int32", "看板娘展示的战员id"}, 
    {"infinite_coin", "int64str", "无限币"}, 
    {"prestige_coin", "int64str", "声望币"}, 
    {"roguelike_function_coin", "int64str", "肉鸽函数币"}, 
    {"roguelike_coin", "int64str", "肉鸽币"}, 
    {"apostles2_coin", "int64str", "使徒之证"}, 
    {"fashion_coin", "int64str", "时装币"}, 
    {"activity_coin", "int64str", "活动币"}, 
    {"competition_coin", "int64str", "综合对抗币"}, 
    {"guild_coin", "int64str", "公会币"}, 
    {"boundless_city_coin", "int64str", "无限城币"}, 
    {"dialog_box", "int32", "玩家聊天气泡"}, 
    {"farm_coin", "int64str", "农场币"}, 
    {"guild_war_coin", "int64str", "联盟团战币"},
}
 
--- *s2c* 更新玩家int32属性 12002
SC_PLAYER_UPDATE_ATTR_INT =
{
    12002, 
    {"attr_list", pt_attr_int, "属性列表", "repeated"},
}
 
--- *s2c* 更新玩家int64属性 12003
SC_PLAYER_UPDATE_ATTR_BIGINT =
{
    12003, 
    {"attr_list", pt_attr_bigint, "属性列表", "repeated"},
}
 
--- *s2c* 更新玩家string属性 12004
SC_PLAYER_UPDATE_ATTR_STRING =
{
    12004, 
    {"attr_list", pt_attr_string, "属性列表", "repeated"},
}
 
--- *c2s* 今日不再提示模块列表 12005
CS_TODAY_NOT_NOTICE =
{
    12005,
}
 
--- *s2c* 今日不再提示模块列表 12006
SC_TODAY_NOT_NOTICE =
{
    12006, 
    {"not_notice_list", "int32", "不再提示功能列表", "repeated"},
}
 
--- *c2s* 加入今日不再提示 12007
CS_ADD_TODAY_NOT_NOTICE =
{
    12007, 
    {"function_id", "int32", "模块id"},
}
 
--- *s2c* 加入今日不再提示 12008
SC_ADD_TODAY_NOT_NOTICE =
{
    12008, 
    {"function_id", "int32", "模块id"}, 
    {"result", "int32", "结果，1成功0失败"},
}
 
--- *s2c* 功能开启列表 12009
SC_FUNCTION_OPEN_LIST =
{
    12009, 
    {"function_open_list", "int32", "功能开启列表", "repeated"},
}
 
--- *s2c* 推送新功能开启 12010
SC_ADD_FUNCTION_OPEN =
{
    12010, 
    {"function_id", "int32", "推送新功能开启"},
}
 
--- *c2s* 玩家改名 12011
CS_RENAME =
{
    12011, 
    {"name", "string", "新的名字"},
}
 
--- *s2c* 玩家改名 12012
SC_RENAME =
{
    12012, 
    {"result", "int8", "结果,1成功0失败"},
}
 
--- *c2s* 玩家修改签名 12013
CS_SET_SIGNATURE =
{
    12013, 
    {"signature", "string", "新的签名"},
}
 
--- *s2c* 玩家修改签名 12014
SC_SET_SIGNATURE =
{
    12014, 
    {"signature", "string", "新的签名"}, 
    {"result", "int8", "结果,1成功0失败"},
}
 
--- *c2s* 设置展示战员 12015
CS_SET_SHOW_HERO =
{
    12015, 
    {"hero_list", pt_show_hero_info, "战员列表", "repeated"},
}
 
--- *s2c* 设置展示战员 12016
SC_SET_SHOW_HERO =
{
    12016, 
    {"result", "int8", "结果,1成功0失败"}, 
    {"hero_list", pt_show_hero_info, "战员列表", "repeated"},
}
 
--- *c2s* 获取头像列表 12017
CS_GET_AVATAR_LIST =
{
    12017,
}
 
--- *s2c* 获取头像列表 12018
SC_GET_AVATAR_LIST =
{
    12018, 
    {"avatar_list", pt_avatar_info, "头像列表", "repeated"},
}
 
--- *c2s* 获取头像框列表 12019
CS_GET_AVATAR_FRAME_LIST =
{
    12019,
}
 
--- *s2c* 获取头像框列表 12020
SC_GET_AVATAR_FRAME_LIST =
{
    12020, 
    {"avatar_frame_list", pt_avatar_frame_info, "头像框列表", "repeated"},
}
 
--- *c2s* 获取称号列表 12021
CS_GET_DESIGNATION_LIST =
{
    12021,
}
 
--- *s2c* 获取称号列表 12022
SC_GET_DESIGNATION_LIST =
{
    12022, 
    {"designation_list", pt_designation_info, "称号列表", "repeated"},
}
 
--- *c2s* 喜爱外观 12023
CS_LIKE_APPEARANCE =
{
    12023, 
    {"id", "int32", "外观ID"}, 
    {"type", "int8", "0-头像，1-头像框，2-称号"},
}
 
--- *s2c* 喜爱外观 12024
SC_LIKE_APPEARANCE =
{
    12024, 
    {"type", "int8", "0-头像，1-头像框，2-称号"}, 
    {"result", "int8", "结果,1成功0失败"},
}
 
--- *c2s* 取消喜爱外观 12025
CS_UNLIKE_APPEARANCE =
{
    12025, 
    {"id", "int32", "外观ID"}, 
    {"type", "int8", "0-头像，1-头像框，2-称号"},
}
 
--- *s2c* 取消喜爱外观 12026
SC_UNLIKE_APPEARANCE =
{
    12026, 
    {"type", "int8", "0-头像，1-头像框，2-称号"}, 
    {"result", "int8", "结果,1成功0失败"},
}
 
--- *c2s* 设置外观 12027
CS_SET_APPEARANCE =
{
    12027, 
    {"id", "int32", "外观ID"}, 
    {"type", "int8", "0-头像，1-头像框，2-称号, 3-背景，4-聊天气泡"},
}
 
--- *s2c* 设置外观 12028
SC_SET_APPEARANCE =
{
    12028, 
    {"type", "int8", "0-头像，1-头像框，2-称号, 3-背景，4-聊天气泡"}, 
    {"result", "int8", "结果,1成功0失败"},
}
 
--- *c2s* 获取表情列表 12029
CS_GET_EMOJI_LIST =
{
    12029,
}
 
--- *s2c* 获取表情列表 12030
SC_GET_EMOJI_LIST =
{
    12030, 
    {"emoji_list", pt_emoji_info, "表情列表", "repeated"},
}
 
--- *c2s* 其它玩家预览信息 12031
CS_OTHER_PLAYER_PRE_INFO =
{
    12031, 
    {"player_id", "int64str", "玩家id"},
}
 
--- *s2c* 其它玩家预览信息 12032
SC_OTHER_PLAYER_PRE_INFO =
{
    12032, 
    {"player_id", "int64str", "玩家id"}, 
    {"show_id", "string", "玩家展示id"}, 
    {"player_name", "string", "玩家名字"}, 
    {"player_signature", "string", "玩家签名"}, 
    {"level", "int16", "等级"}, 
    {"avatar", "int32", "头像"}, 
    {"avatar_frame", "int32", "头像框"}, 
    {"designation", "int32", "称号"}, 
    {"background", "int32", "背景图"}, 
    {"guild", "string", "军团"}, 
    {"power", "int64str", "战力"}, 
    {"hero_num", "int32", "战员数量"}, 
    {"main_stage", "int32", "主线进度"}, 
    {"tower_stage", "int32", "爬塔进度"}, 
    {"achievement_num", "int32", "成就进度"}, 
    {"hero_list", pt_other_hero_info, "展示战员列表", "repeated"}, 
    {"guild_info", pt_guild_simple_info, "公会信息"}, 
    {"city_id", "int16", "城区id"}, 
    {"friend_remarks", "string", "好友备注"}, 
    {"fashion_num", "int16", "时装数目"},
}
 
--- *c2s* 玩家的个人主页信息 12033
CS_PLAYER_HOMEPAGE_INFO =
{
    12033,
}
 
--- *s2c* 玩家的个人主页信息 12034
SC_PLAYER_HOMEPAGE_INFO =
{
    12034, 
    {"show_id", "string", "玩家展示id"}, 
    {"player_name", "string", "玩家名字"}, 
    {"player_signature", "string", "玩家签名"}, 
    {"level", "int16", "等级"}, 
    {"avatar", "int32", "头像"}, 
    {"avatar_frame", "int32", "头像框"}, 
    {"designation", "int32", "称号"}, 
    {"background", "int32", "背景图"}, 
    {"hero_num", "int32", "战员数量"}, 
    {"main_stage", "int32", "主线进度"}, 
    {"tower_stage", "int32", "爬塔进度"}, 
    {"achievement_num", "int32", "成就进度"}, 
    {"city_id", "int8", "成就进度"}, 
    {"show_hero_list", pt_show_hero_info, "展示战员列表", "repeated"}, 
    {"friend_remarks", "string", "好友备注"}, 
    {"fashion_num", "int16", "时装数目"},
}
 
--- *c2s* 获取聊天气泡列表 12035
CS_GET_DIALOG_BOX_LIST =
{
    12035,
}
 
--- *s2c* 获取聊天气泡列表 12036
SC_GET_DIALOG_BOX_LIST =
{
    12036, 
    {"dialog_box_list", pt_dialog_box_info, "头像框列表", "repeated"},
}
 
--- *s2c* 玩家体力信息 12051
SC_PLAYER_STAMINA_INFO =
{
    12051, 
    {"stamina", "int32", "体力值"}, 
    {"next_add_time", "int32", "下一次自然增加体力的时间戳0-不增加"}, 
    {"all_add_time", "int32", "恢复所有体力的时间戳 0-不增加"}, 
    {"buy_times", "int8", "已购买次数"}, 
    {"max_buy_times", "int8", "限购次数"},
}
 
--- *c2s* 购买体力 12052
CS_BUY_STAMINA =
{
    12052,
}
 
--- *s2c* 玩家剧情信息 12053
SC_PLAYER_STORY_INFO =
{
    12053, 
    {"story_list", pt_story_info, "已经播放过的剧情列表", "repeated"},
}
 
--- *c2s* 剧情首次播放完毕 12054
CS_STORY_OVER =
{
    12054, 
    {"story_id", "int32", "剧情ID"},
}
 
--- *s2c* 钛金石兑换金币信息 12055
SC_TITANIUM_EXCHANGE_GOLD_COIN_INFO =
{
    12055, 
    {"buy_times", "int8", "已购买次数"},
}
 
--- *c2s* 确定钛金石兑换金币 12056
CS_TITANIUM_EXCHANGE_GOLD_COIN_DO =
{
    12056, 
    {"buy_times", "int8", "购买次数"},
}
 
--- *c2s* 请求钛金石兑换金币信息 12057
CS_TITANIUM_EXCHANGE_GOLD_COIN_INFO =
{
    12057,
}
 
--- *s2c* 玩家引导信息 12058
SC_PLAYER_GUIDE_INFO =
{
    12058, 
    {"guide_list", pt_guide_info, "已经结束的引导列表", "repeated"},
}
 
--- *c2s* 结束引导 12059
CS_GUIDE_END =
{
    12059, 
    {"guide_id", "int16", "引导ID"},
}
 
--- *c2s* 领取引导奖励 12060
CS_GUIDE_AWARD =
{
    12060, 
    {"guide_id", "int16", "引导ID"},
}
 
--- *s2c* 领取引导奖励返回 12061
SC_GUIDE_AWARD =
{
    12061,
}
 
--- *s2c* 是否改名 12062
SC_IS_RENAME =
{
    12062, 
    {"is_rename", "int8", "1-是 0-否"},
}
 
--- *c2s* 货币兑换（货币A兑换成货币B） 12063
CS_COIN_EXCHANGE_COIN =
{
    12063, 
    {"coin_a_tid", "int32", "A货币tid"}, 
    {"coin_b_tid", "int32", "B货币tid"}, 
    {"exchange_num", "int32", "兑换数量"},
}
 
--- *s2c* 货币兑换 12064
SC_COIN_EXCHANGE_COIN =
{
    12064, 
    {"result", "int8", "结果0-失败，1-成功"},
}
 
--- *c2s* 引导打点记录 12065
CS_GUIDE_STEP_LOG =
{
    12065, 
    {"guide_id", "int16", "引导ID"}, 
    {"step_id", "int16", "引导步骤ID"},
}
 
--- *s2c* 外观过期 12066
SC_APPEARANCE_EXPIRE =
{
    12066, 
    {"id", "int32", "外观ID"}, 
    {"type", "int8", "0-头像，1-头像框，2-称号,4-聊天气泡"},
}
 
--- *s2c* 获取背景图列表 12067
SC_GET_BACKGROUND_LIST =
{
    12067, 
    {"background_list", "int32", "背景图id列表", "repeated"},
}
 
--- *c2s* 普通打点日志 12068
CS_NORMAL_LOG =
{
    12068, 
    {"key", "int16", "键 - 1: 画质选择..."}, 
    {"value", "string", "值"},
}
 
--- *s2c* 怪物图鉴 12100
SC_MONSTER_MANUAL =
{
    12100, 
    {"is_init", "int8", "是否初始化 0：否 1：是"}, 
    {"mon_list", "int16", "怪物图鉴id列表", "repeated"},
}
 
--- *s2c* 模组套装图鉴 12101
SC_EQUIP_SUIT_MANUAL =
{
    12101, 
    {"is_init", "int8", "是否初始化 0：否 1：是"}, 
    {"equip_suit_list", "int32", "模组套装id列表", "repeated"},
}
 
--- *s2c* 手环图鉴 12102
SC_BRACELET_MANUAL =
{
    12102, 
    {"is_init", "int8", "是否初始化 0：否 1：是"}, 
    {"bracelet_list", "int32", "手环tid列表", "repeated"},
}
 
--- *s2c* 音乐图鉴 12103
SC_MUSIC_MANUAL =
{
    12103, 
    {"is_init", "int8", "是否初始化 0：否 1：是"}, 
    {"music_list", "int32", "音乐id列表", "repeated"},
}
 
--- *s2c* 故事图鉴 12104
SC_STORY_MANUAL =
{
    12104, 
    {"is_init", "int8", "是否初始化 0：否 1：是"}, 
    {"story_list", "int32", "故事id列表", "repeated"},
}
 
--- *s2c* 世界观图鉴 12105
SC_WORLD_MANUAL =
{
    12105, 
    {"is_init", "int8", "是否初始化 0：否 1：是"}, 
    {"world_list", "int32", "世界观id列表", "repeated"},
}
 
--- *s2c* 战员蛋图鉴 12106
SC_HERO_EGG_MANUAL =
{
    12106, 
    {"is_init", "int8", "是否初始化 0：否 1：是"}, 
    {"hero_egg_list", "int32", "战员蛋id列表", "repeated"},
}
 
--- *s2c* 锚驴面板信息 12130
SC_PET_PANEL =
{
    12130, 
    {"pet_id_list", "int32", "已解锁的锚驴id列表", "repeated"},
}
 
--- *c2s* 解锁锚驴 12131
CS_PET_UNLOCK =
{
    12131, 
    {"pet_id", "int32", "需要解锁的锚驴id"},
}
 
--- *s2c* 返回解锁锚驴结果 12132
SC_PET_UNLOCK =
{
    12132, 
    {"result", "int8", "结果0-失败，1-成功"}, 
    {"pet_id", "int32", "新解锁的锚驴id"},
}
 
--- *s2c* 手环通讯面板信息 12160
SC_DIALOGUE_PANEL =
{
    12160, 
    {"target_list", pt_dialogue_target, "对话列表", "repeated"},
}
 
--- *c2s* 手环通讯对话 12161
CS_DIALOGUE_TALK =
{
    12161, 
    {"target_id", "int32", "目标id"},
}
 
--- *s2c* 返回手环通讯对话 12162
SC_DIALOGUE_TALK =
{
    12162, 
    {"result", "int8", "结果0-失败，1-成功"}, 
    {"target_id", "int32", "目标id"}, 
    {"part_id", "int32", "段落id"}, 
    {"next_talk_list", "int16", "下一个对话id（支持多个对话id）", "repeated"},
}
 
--- *c2s* 手环通讯玩家对话选择 12163
CS_DIALOGUE_TALK_SELECT =
{
    12163, 
    {"target_id", "int32", "目标id"}, 
    {"talk_id", "int16", "对话id"},
}
 
--- *s2c* 返回手环通讯玩家对话选择 12164
SC_DIALOGUE_TALK_SELECT =
{
    12164, 
    {"result", "int8", "结果0-失败，1-成功"}, 
    {"target_id", "int32", "目标id"}, 
    {"part_id", "int32", "段落id"}, 
    {"next_talk_list", "int16", "下一个对话id（支持多个对话id）", "repeated"},
}
 
--- *c2s* 获取模组方案信息 12190
CS_GET_ALL_CHIP_PLAN =
{
    12190,
}
 
--- *s2c* 获取模组方案信息 12191
SC_GET_ALL_CHIP_PLAN =
{
    12191, 
    {"chip_plan_list", pt_chip_plan, "模组方案", "repeated"},
}
 
--- *c2s* 保存模组方案 12192
CS_SAVE_CHIP_PLAN =
{
    12192, 
    {"chip_plan_info", pt_chip_plan, "模组方案信息"},
}
 
--- *s2c* 保存模组方案 12193
SC_SAVE_CHIP_PLAN =
{
    12193, 
    {"chip_plan_info", pt_chip_plan, "模组方案信息"}, 
    {"result", "int8", "结果0-失败，1-成功"},
}
 
--- *c2s* 更改模组方案名称 12194
CS_CHANGE_CHIP_PLAN_NAME =
{
    12194, 
    {"chip_plan_id", "int32", "模组方案id"}, 
    {"chip_plan_name", "string", "模组方案名称"},
}
 
--- *s2c* 更改模组方案名称 12195
SC_CHANGE_CHIP_PLAN_NAME =
{
    12195, 
    {"chip_plan_id", "int32", "模组方案id"}, 
    {"chip_plan_name", "string", "模组方案名称"}, 
    {"result", "int8", "结果0-失败，1-成功"},
}
 
--- *c2s* 删除模组方案 12196
CS_DELETE_CHIP_PLAN =
{
    12196, 
    {"chip_plan_id", "int32", "模组方案id"},
}
 
--- *s2c* 删除模组方案 12197
SC_DELETE_CHIP_PLAN =
{
    12197, 
    {"chip_plan_id", "int32", "模组方案id"}, 
    {"result", "int8", "结果0-失败，1-成功"},
}
 
--- *c2s* 装备模组方案 12198
CS_EQUIP_CHIP_PLAN =
{
    12198, 
    {"chip_plan_id", "int32", "模组方案id"}, 
    {"hero_id", "int32", "战员id"},
}
 
--- *s2c* 装备模组方案 12199
SC_EQUIP_CHIP_PLAN =
{
    12199, 
    {"chip_plan_id", "int32", "模组方案id"}, 
    {"hero_id", "int32", "战员id"}, 
    {"result", "int8", "结果0-失败，1-成功"},
}
