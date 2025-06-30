-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    13     
-- @Name:  hero   
-- @Desc:  战员协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *s2c* 战员数据 13000
SC_HERO_DATA =
{
    13000, 
    {"hero_info", pt_hero_info, "战员数据", "repeated"},
}
 
--- *s2c* 更新战员列表数据 13001
SC_UPDATE_HERO_LIST =
{
    13001, 
    {"add_hero_list", pt_hero_info, "新增战员列表数据", "repeated"}, 
    {"del_hero_list", "int32", "删除战员列表数据", "repeated"},
}
 
--- *s2c* 更新战员属性 13003
SC_HERO_UPDATE_ATTR =
{
    13003, 
    {"id", "int32", "战员唯一id"}, 
    {"attr_list", pt_attr, "属性列表", "repeated"},
}
 
--- *c2s* 战员进化 13004
CS_HERO_EVOLUTION =
{
    13004, 
    {"id", "int32", "战员唯一id"},
}
 
--- *s2c* 战员进化 13005
SC_HERO_EVOLUTION =
{
    13005, 
    {"result", "int8", "进化结果:0-失败，1-成功"}, 
    {"id", "int32", "战员唯一id"}, 
    {"evolution", "int16", "进化等级"},
}
 
--- *c2s* 战员升级 13006
CS_HERO_LEVELUP =
{
    13006, 
    {"id", "int32", "战员唯一id"}, 
    {"level", "int16", "目标等级"},
}
 
--- *s2c* 战员升级 13007
SC_HERO_LEVELUP =
{
    13007, 
    {"result", "int8", "升级结果:0-失败，1-成功"}, 
    {"id", "int32", "战员唯一id"}, 
    {"level", "int16", "等级"},
}
 
--- *c2s* 战员图鉴 13008
CS_HERO_MANUAL =
{
    13008,
}
 
--- *s2c* 战员图鉴 13009
SC_HERO_MANUAL =
{
    13009, 
    {"hero_list", pt_recruit_once, "战员列表", "repeated"},
}
 
--- *c2s* 请求战员详细数据 13010
CS_HERO_DETAIL =
{
    13010, 
    {"id", "int32", "战员唯一id"},
}
 
--- *s2c* 返回战员详细数据 13011
SC_HERO_DETAIL =
{
    13011, 
    {"id", "int32", "战员唯一id"}, 
    {"hero_info", pt_hero_info, "战员数据"},
}
 
--- *c2s* 战员提升军阶 13013
CS_HERO_MILITARY_RANK_UP =
{
    13013, 
    {"id", "int32", "战员唯一id"}, 
    {"cost_id", "int32", "消耗战员id列表", "repeated"},
}
 
--- *s2c* 战员提升军阶 13014
SC_HERO_MILITARY_RANK_UP =
{
    13014, 
    {"result", "int8", "进化结果:0-失败，1-成功"}, 
    {"id", "int32", "战员唯一id"}, 
    {"military_rank", "int16", "军阶等级"},
}
 
--- *c2s* 装备战员装备 13015
CS_LOAD_EQUIP =
{
    13015, 
    {"hero_id", "int32", "战员id"}, 
    {"equip_id", "int32", "装备唯一id", "repeated"},
}
 
--- *s2c* 装备战员装备 13016
SC_LOAD_EQUIP =
{
    13016, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 卸下战员装备 13017
CS_UNLOAD_EQUIP =
{
    13017, 
    {"hero_id", "int32", "战员id"}, 
    {"pos", "int32", "装备部位", "repeated"},
}
 
--- *s2c* 卸下战员装备 13018
SC_UNLOAD_EQUIP =
{
    13018, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *s2c* 战员装备更新 13019
SC_UPDATE_EQUIP =
{
    13019, 
    {"hero_id", "int32", "战员ID"}, 
    {"update_list", pt_equip_pos, "更新,添加列表", "repeated"}, 
    {"del_list", "int32", "删除装备索引位置列表", "repeated"},
}
 
--- *c2s* 战员装备强化 13020
CS_EQUIP_STRENGTH =
{
    13020, 
    {"hero_id", "int32", "战员id"}, 
    {"equip_id", "int32", "装备id"}, 
    {"cost_list", pt_item_num, "消耗装备道具列表", "repeated"},
}
 
--- *s2c* 战员装备强化 13021
SC_EQUIP_STRENGTH =
{
    13021, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"hero_id", "int32", "战员id"}, 
    {"equip_id", "int32", "装备id"}, 
    {"strength_lv", "int32", "强化等级"}, 
    {"strength_exp", "int32", "强化经验"}, 
    {"equip_pos", "int32", "装备部位"},
}
 
--- *c2s* 战员装备突破 13022
CS_EQUIP_BREAKUP =
{
    13022, 
    {"hero_id", "int32", "战员id"}, 
    {"equip_id", "int32", "装备id"},
}
 
--- *s2c* 战员装备突破 13023
SC_EQUIP_BREAKUP =
{
    13023, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"hero_id", "int32", "战员id"}, 
    {"equip_id", "int32", "装备id"}, 
    {"breakup_rank", "int32", "突破阶段"}, 
    {"equip_pos", "int32", "装备部位"},
}
 
--- *c2s* 预览属性 13024
CS_ATTR_PREVIEW =
{
    13024, 
    {"hero_id", "int32", "战员id"}, 
    {"module_id", "int32", "模块类型，1：战员军阶"},
}
 
--- *s2c* 预览属性 13025
SC_ATTR_PREVIEW =
{
    13025, 
    {"hero_id", "int32", "战员id"}, 
    {"module_id", "int32", "模块类型"}, 
    {"attr_preview", pt_attr, "预览属性列表", "repeated"}, 
    {"param_int", "int32", "额外参数（int类型） 进化：下一星增加的品质系数差值"},
}
 
--- *c2s* 战员装备改造 13026
CS_EQUIP_REMAKE =
{
    13026, 
    {"hero_id", "int32", "战员id"}, 
    {"equip_id", "int32", "装备id"}, 
    {"pos", "int32", "属性位置"}, 
    {"cost_id", "int32", "消耗装备id"},
}
 
--- *s2c* 战员装备改造 13027
SC_EQUIP_REMAKE =
{
    13027, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"hero_id", "int32", "战员id"}, 
    {"equip_id", "int32", "装备id"}, 
    {"pos", "int32", "属性位置"}, 
    {"new_attr", pt_remake_attr, "新的改造属性", "repeated"},
}
 
--- *c2s* 确认改造结果 13028
CS_EQUIP_REMAKE_CONFIRM =
{
    13028,
}
 
--- *s2c* 确认改造结果 13029
SC_EQUIP_REMAKE_CONFIRM =
{
    13029, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 战员装备重构 13030
CS_EQUIP_RECONSTRUCT =
{
    13030, 
    {"hero_id", "int32", "战员id"}, 
    {"equip_id", "int32", "装备id"}, 
    {"cost_id", "int32", "消耗装备id"},
}
 
--- *s2c* 战员装备重构 13031
SC_EQUIP_RECONSTRUCT =
{
    13031, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"hero_id", "int32", "战员id"}, 
    {"equip_id", "int32", "装备id"}, 
    {"nuclear_attr", pt_attr, "核能技能属性", "repeated"}, 
    {"skill_effect", pt_skill_effect_value, "技能效果", "repeated"},
}
 
--- *c2s* 战员装备重构确认 13032
CS_EQUIP_RECONSTRUCT_CONFIRM =
{
    13032,
}
 
--- *s2c* 战员装备重构确认 13033
SC_EQUIP_RECONSTRUCT_CONFIRM =
{
    13033, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 战员抢夺装备 13034
CS_ROB_EQUIP =
{
    13034, 
    {"rob_pos_id", "int32", "被抢夺装备唯一id"}, 
    {"hero_id", "int32", "抢夺战员id"},
}
 
--- *s2c* 装备战员装备 13035
SC_ROB_EQUIP =
{
    13035, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 战员阵型列表 13040
CS_HERO_FORMATION =
{
    13040, 
    {"type", "int8", "类型返回(前端使用)"},
}
 
--- *s2c* 战员阵型列表 13041
SC_HERO_FORMATION =
{
    13041, 
    {"type", "int8", "类型返回(前端使用)"}, 
    {"formation_list", pt_hero_formation, "战员阵型列表", "repeated"},
}
 
--- *c2s* 改变阵型 13042
CS_CHANGE_FORMATION =
{
    13042, 
    {"type", "int8", "类型返回(前端使用)"}, 
    {"team_id", "int16", "队列id"}, 
    {"formation_id", "int16", "阵型id"}, 
    {"is_lock", "int8", "是否关卡锁阵型 1-是 0-否"},
}
 
--- *s2c* 改变阵型 13043
SC_CHANGE_FORMATION =
{
    13043, 
    {"type", "int8", "类型返回(前端使用)"}, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"team_id", "int16", "队列id"}, 
    {"formation_id", "int16", "阵型id"},
}
 
--- *c2s* 设置出战 13044
CS_SET_READY =
{
    13044, 
    {"type", "int8", "类型返回(前端使用)"}, 
    {"team_id", "int16", "队列id"},
}
 
--- *s2c* 设置出战 13045
SC_SET_READY =
{
    13045, 
    {"type", "int8", "类型返回(前端使用)"}, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"team_id", "int16", "队列id"},
}
 
--- *c2s* 请求更新阵型英雄列表 13046
CS_CHANGE_HERO =
{
    13046, 
    {"type", "int8", "类型返回(前端使用)"}, 
    {"is_lock", "int8", "是否关卡锁阵型 1-是 0-否"}, 
    {"formation_list", pt_hero_formation, "战员阵型列表", "repeated"},
}
 
--- *s2c* 返回更新阵型英雄列表 13047
SC_CHANGE_HERO =
{
    13047, 
    {"type", "int8", "类型返回(前端使用)"}, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"formation_list", pt_hero_formation, "战员阵型列表", "repeated"},
}
 
--- *c2s* 编队改名 13048
CS_RENAME_FORMATION =
{
    13048, 
    {"type", "int8", "类型返回(前端使用)"}, 
    {"team_id", "int16", "队列id"}, 
    {"name", "string", "新的名字"},
}
 
--- *s2c* 编队改名 13049
SC_RENAME_FORMATION =
{
    13049, 
    {"type", "int8", "类型返回(前端使用)"}, 
    {"team_id", "int16", "队列id"}, 
    {"name", "string", "新的名字"}, 
    {"result", "int8", "结果,1成功0失败,(2-长度限制,3-敏感词汇,4-特殊词汇,5-改名cd"},
}
 
--- *s2c* 招募信息 13050
SC_RECRUIT_INFO =
{
    13050, 
    {"recruit_list", pt_recruit_info, "招募数据", "repeated"},
}
 
--- *c2s* 招募道具 13051
CS_RECRUIT_ITEM =
{
    13051, 
    {"recruit_id", "int32", "招募id"}, 
    {"times", "int8", "1单抽，10十连抽"},
}
 
--- *s2c* 招募道具 13052
SC_RECRUIT_ITEM =
{
    13052, 
    {"recruit_id", "int32", "招募id"}, 
    {"times", "int8", "1单抽，10十连抽"}, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"item_list", pt_recruit_once, "获得的道具列表(战员用)", "repeated"}, 
    {"detail_item_list", pt_prop_award, "获得道具详细信息列表(手环用)", "repeated"},
}
 
--- *c2s* 查看招募日志 13053
CS_GET_RECRUIT_LOG =
{
    13053, 
    {"recruit_id", "int32", "招募id"},
}
 
--- *s2c* 查看招募日志 13054
SC_GET_RECRUIT_LOG =
{
    13054, 
    {"recruit_id", "int32", "招募id"}, 
    {"log_list", pt_recruit_log, "招募日志", "repeated"},
}
 
--- *c2s* 领取保底奖励 13055
CS_RECRUIT_GUARANTEED_AWARD =
{
    13055, 
    {"type", "int8", "招募类型"},
}
 
--- *s2c* 领取保底奖励 13056
SC_RECRUIT_GUARANTEED_AWARD =
{
    13056, 
    {"type", "int8", "招募类型"}, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *s2c* 限定up池招募大保底信息 13057
SC_RECRUIT_DEBUG_UP_INFO =
{
    13057, 
    {"info_list", pt_recruit_debug_up_detail, "其他SSR权重", "repeated"},
}
 
--- *c2s* 自选up选择 13058
CS_SELECT_RECRUIT =
{
    13058, 
    {"recruit_id", "int32", "招募id"}, 
    {"select_tid", "int16", "自选tid"},
}
 
--- *s2c* 自选up选择 13059
SC_SELECT_RECRUIT =
{
    13059, 
    {"recruit_id", "int32", "招募id"}, 
    {"select_tid", "int16", "自选tid"}, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *s2c* 战员预览数据 13060
SC_HERO_PRE_LIST =
{
    13060, 
    {"hero_pre_list", pt_hero_pre_info, "战员预览数据", "repeated"},
}
 
--- *c2s* 请求不能删除的战员列表 13061
CS_CANNOT_DEL_HERO_LIST =
{
    13061,
}
 
--- *s2c* 不能删除的战员列表 13062
SC_CANNOT_DEL_HERO_LIST =
{
    13062, 
    {"cannot_del_hero_list", pt_cannot_del_hero, "不能删除的战员列表", "repeated"},
}
 
--- *c2s* 增加出战技能 13070
CS_ADD_FIGHT_SKILL =
{
    13070, 
    {"hero_id", "int32", "战员id"}, 
    {"skill_id", "int32", "技能id"}, 
    {"pos", "int8", "位置"},
}
 
--- *s2c* 增加出战技能 13071
SC_ADD_FIGHT_SKILL =
{
    13071, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"hero_id", "int32", "战员id"}, 
    {"skill_id", "int32", "增加技能id"}, 
    {"fight_skill_list", pt_fight_skill_info, "最新的出战技能列表", "repeated"},
}
 
--- *c2s* 删除出战技能 13072
CS_DEL_FIGHT_SKILL =
{
    13072, 
    {"hero_id", "int32", "战员id"}, 
    {"skill_id", "int32", "技能id"},
}
 
--- *s2c* 删除出战技能 13073
SC_DEL_FIGHT_SKILL =
{
    13073, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"hero_id", "int32", "战员id"}, 
    {"skill_id", "int32", "删除技能id"}, 
    {"fight_skill_list", pt_fight_skill_info, "最新的出战技能列表", "repeated"},
}
 
--- *s2c* 更新战员属性 13080
SC_HERO_UPDATE_EQUIP_ATTR =
{
    13080, 
    {"id", "int32", "战员唯一id"}, 
    {"equip_attr_list", pt_attr, "属性列表", "repeated"},
}
 
--- *c2s* 装备四维属性 13081
CS_HERO_UPDATE_EQUIP_ATTR1 =
{
    13081, 
    {"id", "int32", "战员唯一id"},
}
 
--- *s2c* 装备四维属性 13082
SC_HERO_UPDATE_EQUIP_ATTR1 =
{
    13082, 
    {"id", "int32", "战员唯一id"}, 
    {"equip_type", "int8", "装备类型 1：芯片 2：手环"}, 
    {"equip_attr_list", pt_attr, "属性列表", "repeated"},
}
 
--- *c2s* 战员加锁 13083
CS_LOCK_HERO =
{
    13083, 
    {"id", "int32", "战员唯一id"},
}
 
--- *c2s* 战员解锁 13084
CS_UNLOCK_HERO =
{
    13084, 
    {"id", "int32", "战员唯一id"},
}
 
--- *c2s* 选择战员看板娘 13085
CS_SELECT_HERO_BOARD_SHOW =
{
    13085, 
    {"id", "int32", "战员id"},
}
 
--- *s2c* 选择战员看板娘返回 13086
SC_SELECT_HERO_BOARD_SHOW =
{
    13086, 
    {"id", "int32", "战员id"}, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 战员喜欢 13087
CS_LIKE_HERO =
{
    13087, 
    {"id", "int32", "战员唯一id"},
}
 
--- *c2s* 战员取消喜欢 13088
CS_UNLIKE_HERO =
{
    13088, 
    {"id", "int32", "战员唯一id"},
}
 
--- *s2c* 更新战员int32属性 13089
SC_HERO_UPDATE_ATTR_INT =
{
    13089, 
    {"id", "int32", "战员唯一id"}, 
    {"attr_list", pt_attr_int, "属性列表", "repeated"},
}
 
--- *s2c* 更新战员int64属性 13090
SC_HERO_UPDATE_ATTR_BIGINT =
{
    13090, 
    {"id", "int32", "战员唯一id"}, 
    {"attr_list", pt_attr_bigint, "属性列表", "repeated"},
}
 
--- *s2c* 更新战员string属性 13091
SC_HERO_UPDATE_ATTR_STRING =
{
    13091, 
    {"id", "int32", "战员唯一id"}, 
    {"attr_list", pt_attr_string, "属性列表", "repeated"},
}
 
--- *c2s* 剧情战斗自选支援战员列表 13092
CS_SET_STORY_BATTLE_SUPPORT_HERO_LIST =
{
    13092, 
    {"dup_type", "int32", "副本类型"}, 
    {"dup_id", "int32", "副本id"}, 
    {"support_list", pt_battle_support_hero_list, "怪物id列表", "repeated"},
}
 
--- *s2c* 选择支援战员列表返回 13093
SC_SET_STORY_BATTLE_SUPPORT_HERO_LIST =
{
    13093, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 剧情战斗自选支援战员列表 13094
CS_GET_STORY_BATTLE_SUPPORT_HERO_LIST =
{
    13094, 
    {"dup_type", "int32", "副本类型"}, 
    {"dup_id", "int32", "副本id"},
}
 
--- *s2c* 选择支援战员列表返回 13095
SC_GET_STORY_BATTLE_SUPPORT_HERO_LIST =
{
    13095, 
    {"dup_type", "int32", "副本类型"}, 
    {"dup_id", "int32", "副本id"}, 
    {"support_list", pt_battle_support_hero_list, "怪物id列表", "repeated"},
}
 
--- *c2s* 请求可以更换的看板娘列表 13096
CS_HERO_BOARD_CAN_SHOW =
{
    13096,
}
 
--- *s2c* 选择战员看板娘返回 13097
SC_HERO_BOARD_CAN_SHOW =
{
    13097, 
    {"id_list", "int32", "战员id列表", "repeated"},
}
 
--- *c2s* 战员提升品质 13098
CS_HERO_COLOR_UPGRADE =
{
    13098, 
    {"id", "int32", "战员唯一id"}, 
    {"cost_id", "int32", "消耗战员id列表", "repeated"},
}
 
--- *s2c* 战员提升品质 13099
SC_HERO_COLOR_UPGRADE =
{
    13099, 
    {"result", "int8", "升品结果:0-失败，1-成功"}, 
    {"id", "int32", "战员唯一id"}, 
    {"color", "int16", "战员品质等级"},
}
 
--- *c2s* 装备手环精炼 13100
CS_EQUIP_BRACELET_REFINE =
{
    13100, 
    {"id", "int32", "战员唯一id"}, 
    {"equip_id", "int32", "装备唯一id"}, 
    {"cost_list", pt_item_num, "消耗装备道具列表", "repeated"},
}
 
--- *s2c* 装备手环精炼 13101
SC_EQUIP_BRACELET_REFINE =
{
    13101, 
    {"result", "int8", "升品结果:0-失败，1-成功"}, 
    {"hero_id", "int32", "战员唯一id"}, 
    {"equip_id", "int32", "装备唯一id"}, 
    {"refine_lv", "int16", "精炼等级"},
}
 
--- *c2s* 全部战员简易信息 13102
CS_ALL_HERO_EQUIP_INFO =
{
    13102,
}
 
--- *s2c* 全部战员简易信息 13103
SC_ALL_HERO_EQUIP_INFO =
{
    13103, 
    {"all_hero_equip_info", pt_hero_equip, "战员已装备的id列表", "repeated"},
}
 
--- *c2s* 战员穿戴时装 13104
CS_WEAR_FASHION =
{
    13104, 
    {"hero_id", "int32", "战员唯一id"}, 
    {"fashion_id", "int32", "时装id"}, 
    {"fashion_type", "int8", "1-衣服时装 | 2-武器时装"},
}
 
--- *s2c* 战员穿戴时装 13105
SC_WEAR_FASHION =
{
    13105, 
    {"result", "int8", "穿戴时装结果:0-失败，1-成功"}, 
    {"hero_id", "int32", "战员唯一id"}, 
    {"fashion_id", "int32", "时装id"}, 
    {"fashion_type", "int8", "1-衣服时装 | 2-武器时装"},
}
 
--- *c2s* 战员时装信息 13106
CS_FASHION_INFO =
{
    13106, 
    {"hero_id", "int32", "战员唯一id"},
}
 
--- *s2c* 战员穿戴时装 13107
SC_FASHION_INFO =
{
    13107, 
    {"hero_fashion_info", pt_hero_fashion_info, "战员时装列表", "repeated"},
}
 
--- *s2c* 所有战员穿戴时装 13108
SC_ALL_FASHION_INFO =
{
    13108, 
    {"all_hero_fashion_info", pt_hero_fashion_info, "战员时装列表", "repeated"},
}
 
--- *c2s* 解锁时装 13109
CS_UNLOCK_FASHION =
{
    13109, 
    {"hero_tid", "int32", "战员tid"}, 
    {"fashion_id", "int32", "时装id"}, 
    {"fashion_type", "int8", "1-衣服时装 | 2-武器时装"},
}
 
--- *s2c* 解锁时装 13110
SC_UNLOCK_FASHION =
{
    13110, 
    {"result", "int8", "解锁时装结果:0-失败，1-成功"}, 
    {"hero_tid", "int32", "战员tid"}, 
    {"fashion_id", "int32", "时装id"}, 
    {"fashion_type", "int8", "1-衣服时装 | 2-武器时装"}, 
    {"fashion_coin_num", "int16", "获得时装币的数量"},
}
 
--- *s2c* 战员亲密度提升等级 13111
SC_HERO_RELATION_LEVELUP =
{
    13111, 
    {"result", "int8", "升级结果:0-失败，1-成功"},
}
 
--- *c2s* 战员增幅 13114
CS_HERO_INCREASE =
{
    13114, 
    {"hero_id", "int32", "战员id"},
}
 
--- *s2c* 战员增幅 13115
SC_HERO_INCREASE =
{
    13115, 
    {"result", "int8", "升级结果:0-失败，1-成功"},
}
 
--- *c2s* 战员普通攻击技能升级信息 13116
CS_NORMAL_SKILL_LV_UP =
{
    13116, 
    {"hero_id", "int32", "战员id"}, 
    {"skill_id", "int32", "技能id"},
}
 
--- *s2c* 战员普攻技能升级信息 13117
SC_NORMAL_SKILL_LV_UP =
{
    13117, 
    {"type", "int8", "信息类型:0-查看技能，1-升级推送"}, 
    {"hero_id", "int32", "战员id"}, 
    {"present_skill_effect", pt_skill_effect_value, "当前技能效果", "repeated"}, 
    {"next_skill_effect", pt_skill_effect_value, "下一技能效果", "repeated"},
}
 
--- *c2s* 战员增幅属性 13118
CS_HERO_INCREASE_ATTR =
{
    13118, 
    {"hero_id", "int32", "战员id"},
}
 
--- *s2c* 战员增幅属性 13119
SC_HERO_INCREASE_ATTR =
{
    13119, 
    {"increases_lv", "int16", "战员增幅等级"}, 
    {"skill_lv", "int16", "普攻等级"}, 
    {"pre_attr_list", pt_attr, "当前属性列表", "repeated"}, 
    {"next_attr_list", pt_attr, "下一属性列表", "repeated"},
}
 
--- *c2s* 战员技能升级 13120
CS_SKILL_LV_UP =
{
    13120, 
    {"hero_id", "int32", "战员id"}, 
    {"skill_id", "int32", "技能id"},
}
 
--- *s2c* 战员技能升级信息 13121
SC_SKILL_LV_UP =
{
    13121, 
    {"result", "int8", "升级结果:0-失败，1-成功"}, 
    {"hero_id", "int32", "战员id"}, 
    {"skill_id", "int32", "技能id"}, 
    {"skill_lv", "int16", "技能等级"},
}
 
--- *c2s* 战员退役 13130
CS_HERO_RETIRE =
{
    13130, 
    {"cost_hero_list", "int32", "消耗战员id列表", "repeated"},
}
 
--- *s2c* 战员退役 13131
SC_HERO_RETIRE =
{
    13131, 
    {"result", "int8", "退休结果:0-失败，1-成功"},
}
 
--- *c2s* 战员使用亲密度道具升级 13140
CS_ITEM_ADD_RELATION_EXP =
{
    13140, 
    {"item_list", pt_item_num, "消耗道具", "repeated"}, 
    {"hero_id", "int32", "战员id"},
}
 
--- *s2c* 战员使用亲密度道具结果 13141
SC_ITEM_ADD_RELATION_EXP =
{
    13141, 
    {"result", "int8", "使用结果0-失败1-成功"},
}
 
--- *s2c* 已领取的亲密度奖励id列表 13142
SC_RELATION_REWARD =
{
    13142, 
    {"relation_reward_list", pt_relation_reward, "已领取的亲密度奖励id列表", "repeated"},
}
 
--- *c2s* 领取亲密度奖励 13143
CS_RECEIVE_RELATION_REWARD =
{
    13143, 
    {"hero_tid", "int32", "战员tid"}, 
    {"id", "int16", "领取的奖励id"},
}
 
--- *s2c* 领取亲密度奖励结果 13144
SC_RECEIVE_RELATION_REWARD =
{
    13144, 
    {"result", "int8", "领取结果 0：失败 1：成功"}, 
    {"hero_tid", "int32", "战员tid"}, 
    {"id", "int16", "领取的奖励id"},
}
 
--- *c2s* 领取心语集奖励 13145
CS_RECEIVE_STORY_REWARD =
{
    13145, 
    {"hero_tid", "int32", "战员tid"}, 
    {"relation_lv", "int16", "对应的好感度等级"},
}
 
--- *s2c* 领取心语集奖励 13146
SC_RECEIVE_STORY_REWARD =
{
    13146, 
    {"result", "int8", "领取结果 0：失败 1：成功"}, 
    {"hero_tid", "int32", "战员tid"}, 
    {"relation_lv", "int16", "对应的好感度等级"},
}
 
--- *c2s* 所有属性预览 13150
CS_ATTR_PREVIEW_ALL =
{
    13150, 
    {"hero_id", "int32", "战员id"}, 
    {"module_id", "int32", "模块类型，1：装备强化 3：亲密度"}, 
    {"param_int", "int32", "额外参数（int类型）"},
}
 
--- *s2c* 所有属性预览 13151
SC_ATTR_PREVIEW_ALL =
{
    13151, 
    {"hero_id", "int32", "战员id"}, 
    {"module_id", "int32", "模块类型，1：装备强化 3：亲密度"}, 
    {"param_int", "int32", "额外参数（int类型）"}, 
    {"attr_preview", pt_attr_preview_all, "属性显示", "repeated"},
}
 
--- *c2s* 战员碎片合成战员 13160
CS_FRAGMENT_COMPOSE =
{
    13160, 
    {"hero_tid", "int32", "战员tid"},
}
 
--- *s2c* 战员碎片合成战员结果 13161
SC_FRAGMENT_COMPOSE =
{
    13161, 
    {"result", "int8", "合成结果 0：失败 1：成功"}, 
    {"hero_tid", "int32", "战员tid"},
}
 
--- *c2s* 战员初始战力 13162
CS_HERO_INIT_POWER =
{
    13162, 
    {"hero_tid", "int32", "战员tid"},
}
 
--- *s2c* 战员初始战力 13163
SC_HERO_INIT_POWER =
{
    13163, 
    {"hero_tid", "int32", "战员tid"}, 
    {"power", "int32", "战力"},
}
 
--- *s2c* 已领取的等级奖励id列表 13200
SC_HERO_LV_REWARD =
{
    13200, 
    {"lv_reward_list", pt_lv_reward, "已领取的等级奖励id列表", "repeated"},
}
 
--- *c2s* 领取战员等级奖励 13201
CS_RECEIVE_HERO_LV_REWARD =
{
    13201, 
    {"hero_tid", "int32", "战员tid"}, 
    {"id", "int16", "领取的等级奖励id"},
}
 
--- *s2c* 领取战员等级奖励结果 13202
SC_RECEIVE_HERO_LV_REWARD =
{
    13202, 
    {"result", "int8", "领取结果 0：失败 1：成功"}, 
    {"hero_tid", "int32", "战员tid"}, 
    {"id", "int16", "领取的等级奖励id"},
}
 
--- *s2c* 推送战员的助战技能 13220
SC_HERO_ASSIST_FIGHT_SKILL =
{
    13220, 
    {"is_init", "int8", "是否是初始数据 0：否 1：是"}, 
    {"hero_af_list", pt_hero_assist_fight, "战员助战列表", "repeated"},
}
 
--- *c2s* 战员进化属性 13250
CS_HERO_EVOLUTION_ATTR =
{
    13250, 
    {"hero_id", "int32", "战员id"},
}
 
--- *s2c* 战员进化属性 13251
SC_HERO_EVOLUTION_ATTR =
{
    13251, 
    {"now_attr_list", pt_attr, "当前属性列表", "repeated"}, 
    {"next_attr_list", pt_attr, "下一星级的属性列表", "repeated"}, 
    {"next_color_ratio", "int16", "下一星级的品质系数（万分比值）"},
}
 
--- *s2c* 所有的战员动作 13280
SC_HERO_ACTION_LIST =
{
    13280, 
    {"action_list", pt_hero_action, "战员动作列表", "repeated"},
}
 
--- *s2c* 新增战员动作 13281
SC_ADD_HERO_NEW_ACTION =
{
    13281, 
    {"model_id", "int32", "模型id"}, 
    {"action_id", "int16", "动作id"},
}
 
--- *c2s* 新手招募保存的招募列表 13290
CS_RECRUIT_HERO_NEW_SAVE_LIST =
{
    13290,
}
 
--- *s2c* 新手招募保存的招募列表 13291
SC_RECRUIT_HERO_NEW_SAVE_LIST =
{
    13291, 
    {"item_list", pt_recruit_once, "获得的战员列表", "repeated"},
}
 
--- *c2s* 新手招募 13292
CS_RECRUIT_HERO_NEW_PREPARE =
{
    13292,
}
 
--- *s2c* 新手招募 13293
SC_RECRUIT_HERO_NEW_PREPARE =
{
    13293, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"item_list", pt_recruit_once, "获得的战员列表", "repeated"},
}
 
--- *c2s* 新手招募确认 13294
CS_RECRUIT_HERO_NEW_CONFIRM =
{
    13294,
}
 
--- *s2c* 新手招募确认 13295
SC_RECRUIT_HERO_NEW_CONFIRM =
{
    13295, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 装备手环 13320
CS_LOAD_BRACELET =
{
    13320, 
    {"hero_id", "int32", "战员id"}, 
    {"bracelet_id", "int32", "手环id"},
}
 
--- *s2c* 装备手环 13321
SC_LOAD_BRACELET =
{
    13321, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 卸下手环 13322
CS_UNLOAD_BRACELET =
{
    13322, 
    {"hero_id", "int32", "战员id"},
}
 
--- *s2c* 卸下手环 13323
SC_UNLOAD_BRACELET =
{
    13323, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 抢夺手环 13324
CS_ROB_BRACELET =
{
    13324, 
    {"rob_bracelet_id", "int32", "被抢夺的手环id"}, 
    {"hero_id", "int32", "抢夺战员id"},
}
 
--- *s2c* 抢夺手环 13325
SC_ROB_BRACELET =
{
    13325, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 战员烙痕赋能 13331
CS_BRACELET_EQUIP_REMAKE =
{
    13331, 
    {"equip_id", "int32", "装备id"}, 
    {"remake_type", "int8", "赋能类型：1-属性洗练，2-数值洗练"},
}
 
--- *s2c* 战员烙痕赋能 13332
SC_BRACELET_EQUIP_REMAKE =
{
    13332, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"equip_id", "int32", "装备id"}, 
    {"remake_type", "int8", "赋能类型：1-属性洗练，2-数值洗练"}, 
    {"new_attr", pt_bracelet_remake_attr, "新的改造属性", "repeated"},
}
 
--- *c2s* 确认赋能结果 13333
CS_BRACELET_EQUIP_REMAKE_CONFIRM =
{
    13333, 
    {"equip_id", "int32", "装备id"}, 
    {"is_save", "int8", "是否保存，1保存 0不保存"},
}
 
--- *s2c* 确认赋能结果 13334
SC_BRACELET_EQUIP_REMAKE_CONFIRM =
{
    13334, 
    {"equip_id", "int32", "装备id"}, 
    {"is_save", "int8", "是否保存，1保存 0不保存"}, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 烙痕锁定 13335
CS_BRACELET_EQUIP_REMAKE_LOCK =
{
    13335, 
    {"equip_id", "int32", "装备id"}, 
    {"pos", "int32", "位置"}, 
    {"is_lock", "int8", "1锁定0解锁"},
}
 
--- *s2c* 烙痕锁定 13336
SC_BRACELET_EQUIP_REMAKE_LOCK =
{
    13336, 
    {"equip_id", "int32", "装备id"}, 
    {"pos", "int32", "位置"}, 
    {"is_lock", "int8", "1锁定0解锁"}, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 烙痕是否有未确认的信息 13337
CS_BRACELET_EQUIP_REMAKE_UNCONFIRM =
{
    13337, 
    {"equip_id", "int32", "装备id"},
}
 
--- *s2c* 烙痕未确认的信息返回 13338
SC_BRACELET_EQUIP_REMAKE_UNCONFIRM =
{
    13338, 
    {"equip_id", "int32", "装备id"}, 
    {"new_attr", pt_bracelet_remake_attr, "赋能属性：如果为空则说明没有未确认信息", "repeated"}, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *c2s* 战员共鸣 13339
CS_RESONANCE =
{
    13339, 
    {"hero_id", "int32", "战员唯一id"}, 
    {"pos", "int32", "激活位置"},
}
 
--- *s2c* 战员共鸣 13340
SC_RESONANCE =
{
    13340, 
    {"hero_id", "int32", "战员唯一id"}, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"pos_list", "int16", "位置列表", "repeated"},
}
 
--- *s2c* 所有战员穿戴的炫彩时装 13341
SC_FASHION_COLOR_INFO =
{
    13341, 
    {"hero_fashion_color_info", pt_hero_fashion_color_info, "战员穿戴的炫彩时装", "repeated"},
}
 
--- *c2s* 战员穿戴炫彩 13342
CS_WEAR_FASHION_COLOR =
{
    13342, 
    {"hero_id", "int32", "战员唯一id"}, 
    {"fashion_id", "int32", "时装id"}, 
    {"color_id", "int32", "炫彩id"},
}
 
--- *s2c* 战员穿戴炫彩 13343
SC_WEAR_FASHION_COLOR =
{
    13343, 
    {"hero_id", "int32", "战员唯一id"}, 
    {"fashion_id", "int32", "时装id"}, 
    {"color_id", "int32", "炫彩id"}, 
    {"result", "int8", "操作结果 0-失败 1-成功"},
}
 
--- *c2s* 查看战员时装的炫彩 13344
CS_LOOK_FASHION_COLOR =
{
    13344, 
    {"hero_tid", "int32", "战员模板id"}, 
    {"fashion_id", "int32", "时装id"},
}
 
--- *s2c* 查看战员时装的炫彩 13345
SC_LOOK_FASHION_COLOR =
{
    13345, 
    {"hero_tid", "int32", "战员模板id"}, 
    {"fashion_id", "int32", "时装id"}, 
    {"color_id", "int32", "炫彩使用id"}, 
    {"color_list", "int32", "炫彩解锁列表 炫彩原皮0不在列表内", "repeated"}, 
    {"result", "int8", "操作结果 0-失败 1-成功"},
}
 
--- *s2c* 解锁时装炫彩 13346
SC_UNLOCK_FASHION_COLOR =
{
    13346, 
    {"result", "int8", "解锁时装结果:0-失败，1-成功"}, 
    {"hero_tid", "int32", "战员tid"}, 
    {"fashion_id", "int32", "时装id"}, 
    {"color_id", "int8", "炫彩id"}, 
    {"fashion_coin_num", "int16", "获得时装币的数量"},
}
 
--- *s2c* 时装拥有信息 13350
SC_HERO_FASHION_HAVE_INFO =
{
    13350, 
    {"hero_have_body_fashion", pt_hero_have_fashion_info, "战员时装衣服拥有列表", "repeated"}, 
    {"hero_have_weapons_fashion", pt_hero_have_fashion_info, "战员时装武器拥有列表", "repeated"},
}
 
--- *c2s* 战员蛋装备 13351
CS_HERO_EGG_EQUIP =
{
    13351, 
    {"hero_id", "int32", "战员id"}, 
    {"egg_id", "int16", "战员蛋品质id"},
}
 
--- *c2s* 战员蛋升级 13352
CS_HERO_EGG_UPGRADE =
{
    13352, 
    {"hero_id", "int32", "战员id"},
}
 
--- *c2s* 战员孵化 13353
CS_HERO_EGG_HATCH =
{
    13353, 
    {"hero_id", "int32", "战员id"},
}
 
--- *s2c* 战员孵化 13354
SC_HERO_EGG_HATCH =
{
    13354, 
    {"hero_id", "int32", "战员id"}, 
    {"result", "int8", "操作结果 0-失败 1-成功"},
}
 
--- *c2s* 战员蛋属性开关 13355
CS_HERO_EGG_CAL_SWITCH =
{
    13355, 
    {"hero_id", "int32", "战员id"}, 
    {"close_attr_list", "int16", "关闭的属性列表", "repeated"},
}
 
--- *c2s* 重置战员等级 13363
CS_RESET_HERO_LV =
{
    13363, 
    {"hero_id", "int32", "战员id"},
}
 
--- *c2s* 重置战员等级-前瞻 13364
CS_RESET_HERO_LV_PRE_VIEW =
{
    13364, 
    {"hero_id", "int32", "战员id"},
}
 
--- *s2c* 重置战员等级-前瞻 13365
SC_RESET_HERO_LV_PRE_VIEW =
{
    13365, 
    {"hero_id", "int32", "战员id"}, 
    {"award_list", pt_prop_award, "返还道具列表", "repeated"}, 
    {"result", "int8", "操作结果 0-失败 1-成功"},
}
 
--- *s2c* 时装场景全部解锁信息 13370
SC_FASHION_SCENE_PANEL =
{
    13370, 
    {"fashion_scene_list", pt_fashion_scene_info, "战员的场景解锁", "repeated"},
}
 
--- *s2c* 解锁时装场景 13371
SC_UNLOCK_FASHION_SCENE =
{
    13371, 
    {"result", "int8", "解锁时装结果:0-失败，1-成功"}, 
    {"hero_tid", "int32", "战员tid"}, 
    {"fashion_id", "int32", "时装id"}, 
    {"fashion_coin_num", "int16", "获得时装币的数量"},
}
