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
