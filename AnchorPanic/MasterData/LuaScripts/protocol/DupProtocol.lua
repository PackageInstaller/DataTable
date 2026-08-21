-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    18     
-- @Name:  dup   
-- @Desc:  副本协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *s2c* 主线关卡 18000
SC_MAIN_STORY_INFO =
{
    18000, 
    {"now_stage_list", "int32", "当前开启的关卡id", "repeated"}, 
    {"pass_stage_list", "int32", "已通关关卡id", "repeated"}, 
    {"ongoing_stage_id", "int32", "进行中的关卡id（未通关的锚点空间）"}, 
    {"play_chapter_pic_list", "int16", "已播放插画的章节id", "repeated"},
}
 
--- *s2c* 副本列表信息 18001
SC_DUP_DATA =
{
    18001, 
    {"dup_info", pt_dup_info, "副本列表信息", "repeated"},
}
 
--- *s2c* 副本信息更新 18002
SC_DUP_UPDATE =
{
    18002, 
    {"dup_info", pt_dup_info, "副本信息"},
}
 
--- *s2c* 装备副本额外奖励信息更新 18003
SC_EQUIP_DUP_EX_AWARD =
{
    18003, 
    {"gain_list", "int16", "已领取章节ID", "repeated"},
}
 
--- *c2s* 领取装备副本额外奖励 18004
CS_GAIN_EQUIP_DUP_EX_AWARD =
{
    18004, 
    {"gain_id", "int16", "领取章节ID"},
}
 
--- *s2c* 领取装备副本额外奖励返回 18005
SC_GAIN_EQUIP_DUP_EX_AWARD =
{
    18005, 
    {"result", "int8", "结果0-失败1-成功"}, 
    {"award_list", pt_prop_award, "奖励列表", "repeated"},
}
 
--- *c2s* 战员回忆录 18006
CS_HERO_BIOGRAPHY_INFO =
{
    18006,
}
 
--- *s2c* 战员回忆录 18007
SC_HERO_BIOGRAPHY_INFO =
{
    18007, 
    {"hero_biography_list", pt_hero_biography, "战员回忆录列表", "repeated"}, 
    {"challenge_times", "int16", "剩余挑战次数"},
}
 
--- *s2c* 爬塔轮次结束 18008
SC_CLIMB_TOWER_ROUND_END =
{
    18008, 
    {"is_all_pass", "int8", "是否全部通关0-否1-是"},
}
 
--- *c2s* 领取爬塔奖励 18009
CS_CLIMB_TOWER_AWARD =
{
    18009, 
    {"map_id", "int32", "区域id"},
}
 
--- *s2c* 已领取爬塔奖励列表 18010
SC_CLIMB_TOWER_GAIN_LIST =
{
    18010, 
    {"map_list", "int32", "奖励区域id列表", "repeated"},
}
 
--- *c2s* 纯剧情副本 18012
CS_DUP_ONLY_STORY_PASS =
{
    18012, 
    {"battle_type", "int32", "战斗类型"}, 
    {"field_id", "int32", "副本id"},
}
 
--- *s2c* 纯剧情副本 返回 18013
SC_DUP_ONLY_STORY_PASS =
{
    18013, 
    {"battle_type", "int32", "战斗类型"}, 
    {"field_id", "int32", "副本id"}, 
    {"result", "int16", "1成功0失败"}, 
    {"award", pt_prop_award, "奖励", "repeated"},
}
 
--- *c2s* 战员回忆录关注战员 18014
CS_HERO_BIOGRAPHY_FOLLOW =
{
    18014, 
    {"hero_tid", "int32", "战员关注"}, 
    {"is_follow", "int8", "0-取消关注，1-关注"},
}
 
--- *c2s* 芯片支线副本面板请求 18020
CS_CHIP_BRANCH_DUP_INFO =
{
    18020,
}
 
--- *s2c* 芯片支线副本面板返回 18021
SC_CHIP_BRANCH_DUP_INFO =
{
    18021, 
    {"gain_chapter_list", "int16", "已领取的章节奖励id", "repeated"}, 
    {"pass_list", "int32", "已经通过的关卡id", "repeated"},
}
 
--- *c2s* 芯片支线副本领取章节奖励 18022
CS_CHIP_BRANCH_GAIN_CHAPTER =
{
    18022, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *s2c* 芯片支线副本章节奖励返回 18023
SC_CHIP_BRANCH_GAIN_CHAPTER =
{
    18023, 
    {"chapter_id", "int16", "章节id"}, 
    {"result", "int8", "结果0-失败1-成功"},
}
 
--- *s2c* 战术训练信息 18030
SC_TACTICS_TRAINING_INFO =
{
    18030, 
    {"info_list", pt_tactics_training_info, "类型信息列表", "repeated"},
}
 
--- *s2c* 战场异闻信息 18031
SC_BRANCH_STORY_INFO =
{
    18031, 
    {"info_list", pt_branch_story_info, "类型信息列表", "repeated"},
}
 
--- *s2c* 战员能源训练副本面板返回 18041
SC_POWER_TRAIN_INFO =
{
    18041, 
    {"pass_list", "int32", "已经通过的副本id", "repeated"},
}
 
--- *c2s* 主线播放章节插图 18051
CS_MAIN_STORY_PLAY_CHAPTER_PIC =
{
    18051, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *s2c* 主线播放章节插图 18052
SC_MAIN_STORY_PLAY_CHAPTER_PIC =
{
    18052, 
    {"result", "int8", "结果0-失败1-成功"}, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *c2s* 主线关卡奖励 18053
CS_MAIN_STORY_STAGE_AWARD =
{
    18053, 
    {"stage_id", "int32", "关卡id"},
}
 
--- *s2c* 已领取主线关卡奖励 18054
SC_MAIN_STORY_STAGE_AWARD_LIST =
{
    18054, 
    {"stage_list", "int32", "已领取关卡id", "repeated"},
}
 
--- *c2s* 芯片副本选择套装掉落 18061
CS_CHIP_DUP_PICK_SUIT =
{
    18061, 
    {"suit_id", "int8", "套装id"},
}
 
--- *s2c* 芯片副本选择套装掉落 18062
SC_CHIP_DUP_PICK_SUIT =
{
    18062, 
    {"suit_id", "int8", "套装id"},
}
 
--- *s2c* 活动期间副本双倍掉落次数 18063
SC_DUP_DOUBLE_TIMES =
{
    18063, 
    {"remain_times", "int16", "剩余次数"}, 
    {"max_times", "int16", "最大次数"},
}
 
--- *s2c* 支线副本面板信息 18100
SC_BRANCH_PLOT_PANEL =
{
    18100, 
    {"unlock_times", "int16", "已消耗的解锁章节次数"}, 
    {"chapter_list", pt_branch_plot_chapter, "已解锁的章节列表", "repeated"},
}
 
--- *c2s* 支线副本解锁新的章节 18101
CS_BRANCH_PLOT_UNLOCK_CHAPTER =
{
    18101, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *s2c* 支线副本解锁新的章节 18102
SC_BRANCH_PLOT_UNLOCK_CHAPTER =
{
    18102, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *s2c* 支线副本更新章节信息 18103
SC_BRANCH_PLOT_UPDATE_CHAPTER =
{
    18103, 
    {"chapter_info", pt_branch_plot_chapter, "章节信息"},
}
 
--- *s2c* 跑酷副本面板信息 18120
SC_PARKOUR_PANEL =
{
    18120, 
    {"parkour_list", pt_parkour_info, "跑酷信息", "repeated"}, 
    {"gained_list", "int16", "已领取奖励列表", "repeated"},
}
 
--- *c2s* 通关跑酷玩法 18121
CS_PASS_PARKOUR =
{
    18121, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新跑酷信息 18122
SC_UPDATE_PARKOUR_INFO =
{
    18122, 
    {"parkour_info", pt_parkour_info, "跑酷信息"},
}
 
--- *c2s* 获取奖励 18123
CS_GAIN_PARKOUR_REWARD =
{
    18123, 
    {"id_list", "int16", "奖励id列表", "repeated"},
}
 
--- *s2c* 更新跑酷信息 18124
SC_GAIN_PARKOUR_REWARD =
{
    18124, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"id_list", "int16", "成功领取的奖励id列表", "repeated"},
}
 
--- *s2c* 挖矿信息 18130
SC_MINER_PANEL =
{
    18130, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"gained_list", "int16", "已领取奖励列表", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *c2s* 挖矿事件触发通知 18131
CS_MINER_EVENT =
{
    18131, 
    {"id", "int16", "事件id"},
}
 
--- *s2c* 挖矿任务进度更新 18132
SC_MINER_TASK_UPDATE =
{
    18132, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 挖矿任务领取 18133
CS_MINER_TASK_GAIN =
{
    18133, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 挖矿任务领取 返回 18134
SC_MINER_TASK_GAIN_RETURN =
{
    18134, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关挖矿玩法 18135
CS_PASS_MINER =
{
    18135, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新挖矿信息 18136
SC_UPDATE_MINER_INFO =
{
    18136, 
    {"dup_info", pt_mini_game_dup_base, "挖矿信息"},
}
 
--- *c2s* 挖矿获取阶段奖励 18137
CS_GAIN_MINER_REWARD =
{
    18137, 
    {"id_list", "int16", "奖励id列表", "repeated"},
}
 
--- *s2c* 挖矿获取阶段奖励返回 18138
SC_GAIN_MINER_REWARD =
{
    18138, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"id_list", "int16", "成功领取的奖励id列表", "repeated"},
}
 
--- *s2c* 钓鱼信息 18140
SC_FISHING_PANEL =
{
    18140, 
    {"unlock_list", pt_fish_info, "钓过的鱼信息列表", "repeated"}, 
    {"collect_list", "int16", "已领取收集id", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *c2s* 钓鱼 18141
CS_FISHING =
{
    18141, 
    {"fish_id", "int16", "鱼id"}, 
    {"bait", "int32", "鱼饵道具tid"}, 
    {"size", "int16", "鱼的长度"},
}
 
--- *s2c* 钓鱼任务进度更新 18142
SC_FISHING_TASK_UPDATE =
{
    18142, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 钓鱼任务领取 18143
CS_FISHING_TASK_GAIN =
{
    18143, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 钓鱼任务领取 返回 18144
SC_FISHING_TASK_GAIN_RETURN =
{
    18144, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 钓鱼收集领取 18145
CS_FISHING_COLLECT_GAIN =
{
    18145, 
    {"collect_id", "int16", "收集id"},
}
 
--- *s2c* 钓鱼返回 18146
SC_FISHING =
{
    18146, 
    {"fish_info", pt_fish_info, "鱼信息"}, 
    {"award_list", pt_prop_award, "奖励", "repeated"},
}
 
--- *s2c* 沙盒地图信息 18150
SC_SANDPLAY_PANEL =
{
    18150, 
    {"map_list", pt_sandplay_map_info, "地图信息", "repeated"},
}
 
--- *c2s* 沙盒地图事件触发 18151
CS_SANDPLAY_TRIGGER_EVENT =
{
    18151, 
    {"map_id", "int16", "地图id"}, 
    {"npc_id", "int32", "npc_id"}, 
    {"event_id", "int32", "事件id"},
}
 
--- *s2c* 沙盒地图信息更新 18152
SC_SANDPLAY_MAP_UPDATE =
{
    18152, 
    {"map_id", "int16", "地图id"}, 
    {"npc_id", "int32", "npc_id"}, 
    {"event_id", "int32", "事件id"},
}
 
--- *s2c* 消消乐面板 18160
SC_XIAOXIAOLE_PANEL =
{
    18160, 
    {"dup_list", "int16", "已通关关卡id", "repeated"}, 
    {"task_info", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *c2s* 事件通知-消除数量统计 18161
CS_XIAOXIAOLE_EVENT =
{
    18161, 
    {"event_list", pt_int_int, "事件key-val列表", "repeated"},
}
 
--- *s2c* 任务进度更新 18162
SC_XIAOXIAOLE_TASK_UPDATE =
{
    18162, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 任务领取 18163
CS_XIAOXIAOLE_TASK_GAIN =
{
    18163, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 任务领取 返回 18164
SC_XIAOXIAOLE_TASK_GAIN_RETURN =
{
    18164, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 消消乐关卡更新 18165
SC_UPDATE_XIAOXIAOLE_INFO =
{
    18165, 
    {"dup_list", "int16", "已通关关卡id", "repeated"},
}
 
--- *c2s* 通关玩法 18166
CS_PASS_XIAOXIAOLE =
{
    18166, 
    {"dup_id", "int32", "副本id"},
}
 
--- *s2c* 蛋壳面板 18170
SC_DANKE_PANEL =
{
    18170, 
    {"dup_list", pt_danke_dup_info, "已通关关卡信息", "repeated"}, 
    {"task_info", pt_task_info_base, "任务信息", "repeated"}, 
    {"gain_star_award_list", "int16", "已领取星数奖励信息", "repeated"},
}
 
--- *c2s* 事件通知-数量统计 18171
CS_DANKE_EVENT =
{
    18171, 
    {"event_list", pt_int_int, "事件key-val列表", "repeated"},
}
 
--- *s2c* 任务进度更新 18172
SC_DANKE_TASK_UPDATE =
{
    18172, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 任务领取 18173
CS_DANKE_TASK_GAIN =
{
    18173, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 任务领取 返回 18174
SC_DANKE_TASK_GAIN_RETURN =
{
    18174, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 关卡更新 18175
SC_UPDATE_DANKE_INFO =
{
    18175, 
    {"dup_info", pt_danke_dup_info, "更新关卡信息"},
}
 
--- *c2s* 通关玩法 18176
CS_PASS_DANKE =
{
    18176, 
    {"dup_id", "int16", "副本id"}, 
    {"kill_count", "int32", "杀怪数量"}, 
    {"special_kill", "int32", "击杀的特定怪id", "repeated"},
}
 
--- *c2s* 星数奖励领取 18177
CS_DANKE_GAIN_STAR_AWARD =
{
    18177, 
    {"id_list", "int16", "领取的id列表", "repeated"},
}
 
--- *s2c* 星数奖励领取 返回 18178
SC_DANKE_GAIN_STAR_AWARD =
{
    18178, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"id_list", "int16", "成功领取的奖励id列表", "repeated"},
}
 
--- *s2c* 水管工人面板 18179
SC_CIRCUIT_PANEL =
{
    18179, 
    {"dup_list", "int16", "已通关关卡id", "repeated"},
}
 
--- *c2s* 通关玩法 18180
CS_PASS_CIRCUIT =
{
    18180, 
    {"dup_id", "int16", "副本id"},
}
 
--- *s2c* 整理背包面板 18181
SC_PACK_BAG_PANEL =
{
    18181, 
    {"dup_list", "int16", "已通关关卡id", "repeated"},
}
 
--- *c2s* 通关整理背包玩法 18182
CS_PASS_PACK_BAG =
{
    18182, 
    {"dup_id", "int16", "副本id"},
}
 
--- *s2c* 通关整理背包玩法 18183
SC_PASS_PACK_BAG_RESULT =
{
    18183, 
    {"result", "int8", "结果0-失败1-成功"}, 
    {"dup_id", "int16", "副本id"},
}
 
--- *s2c* 农场养|种植列表 18190
SC_HAPPY_FARM_FIELD_LIST =
{
    18190, 
    {"farm_field_list", pt_farm_field, "养|种植格子列表", "repeated"},
}
 
--- *s2c* 农场订单列表 18191
SC_HAPPY_FARM_ORDER_LIST =
{
    18191, 
    {"order_ids", "int32", "完成的订单", "repeated"},
}
 
--- *c2s* 农场操作 18192
CS_FARM_OPERATE =
{
    18192, 
    {"field_id", "int16", "养|种植格子id"}, 
    {"args", "int32", "事件参数", "repeated"},
}
 
--- *c2s* 农场-提交订单 18193
CS_SUBMIT_ORDER =
{
    18193, 
    {"order_id", "int16", "订单id"},
}
 
--- *c2s* 农场-统一收获 18194
CS_UNIFY_COLLECT =
{
    18194, 
    {"seed_id", "int16", "动物id(种子)"},
}
 
--- *s2c* 羊了个羊面板 18200
SC_THREE_TILES_PANEL =
{
    18200, 
    {"dup_list", pt_three_tiles_dup, "副本列表", "repeated"}, 
    {"star_reward_list", "int16", "收集星星奖励id", "repeated"},
}
 
--- *c2s* 羊了个羊-过关 18201
CS_THREE_TILES_PASS_DUP =
{
    18201, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *s2c* 羊了个羊-过关-返回 18202
SC_THREE_TILES_PASS_DUP =
{
    18202, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *c2s* 羊了个羊-收取星星奖励 18203
CS_THREE_TILES_RECEIVE_STAR =
{
    18203, 
    {"star_reward_id", "int16", "星星收集id", "repeated"},
}
 
--- *s2c* 打砖块面板 18206
SC_BREAKOUT_PANEL =
{
    18206, 
    {"dup_list", pt_breakout_dup, "副本列表", "repeated"}, 
    {"star_reward_list", "int16", "收集星星奖励id", "repeated"},
}
 
--- *c2s* 打砖块-过关 18207
CS_BREAKOUT_PASS_DUP =
{
    18207, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *s2c* 打砖块-过关-返回 18208
SC_BREAKOUT_PASS_DUP =
{
    18208, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *c2s* 打砖块-收取星星奖励 18209
CS_BREAKOUT_RECEIVE_STAR =
{
    18209, 
    {"star_reward_id", "int16", "星星收集id", "repeated"},
}
 
--- *s2c* 拼图面板 18212
SC_JIGSAW_PUZZLE_PANEL =
{
    18212, 
    {"dup_list", "int16", "已通关关卡id", "repeated"},
}
 
--- *c2s* 拼图通关 18213
CS_PASS_JIGSAW_PUZZLE =
{
    18213, 
    {"dup_id", "int16", "副本id"},
}
 
--- *s2c* 连连看面板 18220
SC_LINKLINK_PANEL =
{
    18220, 
    {"dup_list", pt_linklink_dup, "副本列表", "repeated"}, 
    {"star_reward_list", "int16", "收集星星奖励id", "repeated"},
}
 
--- *c2s* 连连看-过关 18221
CS_LINKLINK_PASS_DUP =
{
    18221, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *s2c* 连连看-过关-返回 18222
SC_LINKLINK_PASS_DUP =
{
    18222, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *c2s* 连连看-收取星星奖励 18223
CS_LINKLINK_RECEIVE_STAR =
{
    18223, 
    {"star_reward_id", "int16", "星星收集id", "repeated"},
}
 
--- *s2c* 打地鼠面板 18226
SC_MOLE_PANEL =
{
    18226, 
    {"dup_list", pt_mole_dup, "副本列表", "repeated"}, 
    {"star_reward_list", "int16", "收集星星奖励id", "repeated"},
}
 
--- *c2s* 打地鼠-过关 18227
CS_MOLE_PASS_DUP =
{
    18227, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *s2c* 打地鼠-过关-返回 18228
SC_MOLE_PASS_DUP =
{
    18228, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *c2s* 打地鼠-收取星星奖励 18229
CS_MOLE_RECEIVE_STAR =
{
    18229, 
    {"star_reward_id", "int16", "星星收集id", "repeated"},
}
 
--- *s2c* 排位游戏面板 18230
SC_RANKING_GAME_PANEL =
{
    18230, 
    {"dup_list", pt_ranking_game_dup, "副本列表", "repeated"}, 
    {"star_reward_list", "int16", "收集星星奖励id", "repeated"},
}
 
--- *c2s* 排位游戏-过关 18231
CS_RANKING_GAME_PASS_DUP =
{
    18231, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *s2c* 排位游戏-过关-返回 18232
SC_RANKING_GAME_PASS_DUP =
{
    18232, 
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "几星过关"},
}
 
--- *c2s* 排位游戏-收取星星奖励 18233
CS_RANKING_GAME_RECEIVE_STAR =
{
    18233, 
    {"star_reward_id", "int16", "星星收集id", "repeated"},
}
 
--- *s2c* 合成大西瓜信息 18235
SC_WATERMELON_PANEL =
{
    18235, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"gained_list", "int16", "已领取奖励列表", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *c2s* 合成大西瓜事件触发通知 18236
CS_WATERMELON_EVENT =
{
    18236,
}
 
--- *s2c* 合成大西瓜任务进度更新 18237
SC_WATERMELON_TASK_UPDATE =
{
    18237, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 合成大西瓜任务领取 18238
CS_WATERMELON_TASK_GAIN =
{
    18238, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 合成大西瓜任务领取 返回 18239
SC_WATERMELON_TASK_GAIN_RETURN =
{
    18239, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关合成大西瓜玩法 18240
CS_PASS_WATERMELON =
{
    18240, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新合成大西瓜信息 18241
SC_UPDATE_WATERMELON_INFO =
{
    18241, 
    {"dup_info", pt_mini_game_dup_base, "合成大西瓜信息"},
}
 
--- *s2c* 1024信息 18248
SC_GHOST_PANEL =
{
    18248, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"gained_list", "int16", "已领取奖励列表", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *s2c* 1024任务进度更新 18242
SC_GHOST_TASK_UPDATE =
{
    18242, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 1024任务领取 18243
CS_GHOST_TASK_GAIN =
{
    18243, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 1024任务领取 返回 18244
SC_GHOST_TASK_GAIN_RETURN =
{
    18244, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关1024玩法 18245
CS_PASS_GHOST =
{
    18245, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新1024信息 18246
SC_UPDATE_GHOST_INFO =
{
    18246, 
    {"dup_info", pt_mini_game_dup_base, "1024信息"},
}
 
--- *c2s* 1024事件触发通知 18247
CS_GHOST_EVENT =
{
    18247, 
    {"event_id", "int16", "任务信息"},
}
 
--- *s2c* 俄罗斯方块信息 18250
SC_BLOCK_PANEL =
{
    18250, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"gained_list", "int16", "已领取奖励列表", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *s2c* 俄罗斯方块任务进度更新 18251
SC_BLOCK_TASK_UPDATE =
{
    18251, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 俄罗斯方块任务领取 18252
CS_BLOCK_TASK_GAIN =
{
    18252, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 俄罗斯方块任务领取 返回 18253
SC_BLOCK_TASK_GAIN_RETURN =
{
    18253, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关俄罗斯方块玩法 18254
CS_PASS_BLOCK =
{
    18254, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新俄罗斯方块信息 18255
SC_UPDATE_BLOCK_INFO =
{
    18255, 
    {"dup_info", pt_mini_game_dup_base, "俄罗斯方块信息"},
}
 
--- *s2c* 泡泡龙信息 18260
SC_BULLE_PANEL =
{
    18260, 
    {"dup_list", pt_mini_game_dup_base, "已过关卡", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *s2c* 泡泡龙任务进度更新 18261
SC_BULLE_TASK_UPDATE =
{
    18261, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 泡泡龙任务领取 18262
CS_BULLE_TASK_GAIN =
{
    18262, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 泡泡龙任务领取返回 18263
SC_BULLE_TASK_GAIN_RETURN =
{
    18263, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关泡泡龙玩法 18264
CS_PASS_BULLE =
{
    18264, 
    {"dup_id", "int32", "副本id"}, 
    {"score", "int64str", "过关分数"},
}
 
--- *s2c* 更新泡泡龙副本信息 18265
SC_UPDATE_BULLE_INFO =
{
    18265, 
    {"dup_info", pt_mini_game_dup_base, "泡泡龙副本信息"},
}
 
--- *c2s* 泡泡龙分数 18266
CS_BULLE_SCORE =
{
    18266, 
    {"score", "int64str", "分数"},
}
 
--- *s2c* 接元宝信息 18270
SC_GOLD_PANEL =
{
    18270, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *s2c* 接元宝任务进度更新 18271
SC_GOLD_TASK_UPDATE =
{
    18271, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 接元宝任务领取 18272
CS_GOLD_TASK_GAIN =
{
    18272, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 接元宝任务领取 返回 18273
SC_GOLD_TASK_GAIN_RETURN =
{
    18273, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关接元宝玩法 18274
CS_PASS_GOLD =
{
    18274, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新接元宝信息 18275
SC_UPDATE_GOLD_INFO =
{
    18275, 
    {"dup_info", pt_mini_game_dup_base, "接元宝信息"},
}
 
--- *s2c* 像素鸟信息 18280
SC_BIRD_PANEL =
{
    18280, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *s2c* 像素鸟任务进度更新 18281
SC_BIRD_TASK_UPDATE =
{
    18281, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 像素鸟任务领取 18282
CS_BIRD_TASK_GAIN =
{
    18282, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 像素鸟任务领取 返回 18283
SC_BIRD_TASK_GAIN_RETURN =
{
    18283, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关像素鸟玩法 18284
CS_PASS_BIRD =
{
    18284, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新像素鸟信息 18285
SC_UPDATE_BIRD_INFO =
{
    18285, 
    {"dup_info", pt_mini_game_dup_base, "像素鸟信息"},
}
 
--- *s2c* 饮料大作战信息 18290
SC_DRINK_PANEL =
{
    18290, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *s2c* 饮料大作战任务进度更新 18291
SC_DRINK_TASK_UPDATE =
{
    18291, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 饮料大作战任务领取 18292
CS_DRINK_TASK_GAIN =
{
    18292, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 饮料大作战任务领取 返回 18293
SC_DRINK_TASK_GAIN_RETURN =
{
    18293, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关饮料大作战玩法 18294
CS_PASS_DRINK =
{
    18294, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新饮料大作战信息 18295
SC_UPDATE_DRINK_INFO =
{
    18295, 
    {"dup_info", pt_mini_game_dup_base, "饮料大作战信息"},
}
 
--- *s2c* dessert信息 18300
SC_DESSERT_PANEL =
{
    18300, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"gained_list", "int16", "已领取奖励列表", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *s2c* dessert任务进度更新 18301
SC_DESSERT_TASK_UPDATE =
{
    18301, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* dessert任务领取 18302
CS_DESSERT_TASK_GAIN =
{
    18302, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* dessert任务领取 返回 18303
SC_DESSERT_TASK_GAIN_RETURN =
{
    18303, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关dessert玩法 18304
CS_PASS_DESSERT =
{
    18304, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新dessert信息 18305
SC_UPDATE_DESSERT_INFO =
{
    18305, 
    {"dup_info", pt_mini_game_dup_base, "dessert信息"},
}
 
--- *c2s* dessert事件触发通知 18305
CS_DESSERT_EVENT =
{
    18305, 
    {"event_id", "int16", "任务信息"},
}
 
--- *s2c* 盖楼信息 18310
SC_BUILD_PANEL =
{
    18310, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *s2c* 盖楼任务进度更新 18311
SC_BUILD_TASK_UPDATE =
{
    18311, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 盖楼任务领取 18312
CS_BUILD_TASK_GAIN =
{
    18312, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 盖楼任务领取返回 18313
SC_BUILD_TASK_GAIN_RETURN =
{
    18313, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关盖楼玩法 18314
CS_PASS_BUILD =
{
    18314, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新盖楼信息 18315
SC_UPDATE_BUILD_INFO =
{
    18315, 
    {"dup_info", pt_mini_game_dup_base, "盖楼信息"},
}
 
--- *c2s* 盖楼事件触发通知 18316
CS_BUILD_EVENT =
{
    18316, 
    {"event_id", "int16", "任务信息"},
}
 
--- *s2c* 整理小游戏信息 18320
SC_CLEAR_PANEL =
{
    18320, 
    {"dup_list", pt_mini_game_dup_base, "关卡信息", "repeated"}, 
    {"task_list", pt_task_info_base, "任务信息", "repeated"},
}
 
--- *s2c* 整理小游戏任务进度更新 18321
SC_CLEAR_TASK_UPDATE =
{
    18321, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 整理小游戏任务领取 18322
CS_CLEAR_TASK_GAIN =
{
    18322, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 整理小游戏任务领取返回 18323
SC_CLEAR_TASK_GAIN_RETURN =
{
    18323, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 通关整理小游戏玩法 18324
CS_PASS_CLEAR =
{
    18324, 
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "通关分数"},
}
 
--- *s2c* 更新整理小游戏信息 18325
SC_UPDATE_CLEAR_INFO =
{
    18325, 
    {"dup_info", pt_mini_game_dup_base, "整理小游戏信息"},
}
 
--- *c2s* 整理小游戏事件触发通知 18326
CS_CLEAR_EVENT =
{
    18326, 
    {"event_id", "int16", "任务信息"},
}
