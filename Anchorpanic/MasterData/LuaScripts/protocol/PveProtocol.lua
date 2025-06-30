-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    19     
-- @Name:  pve   
-- @Desc:  玩法协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *c2s* 请求学院委派大厅信息 19001
CS_COLLEGE_DELEGATION_HALL_INFO =
{
    19001,
}
 
--- *s2c* 学院委派大厅信息 19002
SC_COLLEGE_DELEGATION_HALL_INFO =
{
    19002, 
    {"doing_list", "int32", "进行中列表", "repeated"}, 
    {"done_list", "int32", "已完成列表", "repeated"},
}
 
--- *c2s* 竞技场面板内容 19020
CS_ARENA_INFO =
{
    19020,
}
 
--- *s2c* 竞技场面板内容 19021
SC_ARENA_INFO =
{
    19021, 
    {"normal_arena_season", "int32", "竞技场赛季"}, 
    {"season_end_time", "int64str", "赛季结束时间戳"},
}
 
--- *c2s* 竞技场面板内容 19022
CS_ARENA_PANEL =
{
    19022,
}
 
--- *s2c* 竞技场面板内容 19023
SC_ARENA_PANEL =
{
    19023, 
    {"my_daily_rank", "int32", "我的每日排名"}, 
    {"my_season_rank", "int32", "我的赛季排名"}, 
    {"zone_player_num", "int32", "竞技区总人数"}, 
    {"my_score", "int32", "我的分数"}, 
    {"power", "int32", "我的战力"}, 
    {"remain_free_times", "int8", "剩余免费次数"}, 
    {"enemy_list", pt_arena_enemy, "随机推荐的对手榜", "repeated"}, 
    {"my_segment", "int16", "我的段位"}, 
    {"sync_def_formation_state", "int8", "同步防守阵型状态0-同步,1-不同步"}, 
    {"war_id", "int8", "2-低级战区,3-中级战区,4-高级战区"},
}
 
--- *c2s* 查看前100名 19024
CS_SHOW_TOP_100_PLAYER =
{
    19024,
}
 
--- *s2c* 查看前100名 19025
SC_SHOW_TOP_100_PLAYER =
{
    19025, 
    {"top_enemy_list", pt_arena_enemy, "玩家列表", "repeated"},
}
 
--- *c2s* 刷新对手 19026
CS_REFRESH_ENEMY =
{
    19026,
}
 
--- *s2c* 刷新对手 19027
SC_REFRESH_ENEMY =
{
    19027, 
    {"enemy_list", pt_arena_enemy, "随机推荐的对手榜", "repeated"},
}
 
--- *c2s* 查看日志 19028
CS_SHOW_ARENA_LOG =
{
    19028,
}
 
--- *s2c* 查看日志 19029
SC_SHOW_ARENA_LOG =
{
    19029, 
    {"arena_log_list", pt_arena_log, "竞技场日志", "repeated"},
}
 
--- *c2s* 查看玩家防守阵容 19030
CS_SHOW_PLAYER_DEFEND =
{
    19030, 
    {"player_id", "int64str", "玩家id"},
}
 
--- *s2c* 查看玩家防守阵容 19031
SC_SHOW_PLAYER_DEFEND =
{
    19031, 
    {"enemy_info", pt_arena_enemy, "玩家的信息"}, 
    {"defend_formation", pt_hero_formation, "玩家防守阵容"},
}
 
--- *c2s* 是否赛季重置期间 19032
CS_IS_ARENA_RESET =
{
    19032,
}
 
--- *s2c* 是否赛季重置期间 19033
SC_IS_ARENA_RESET =
{
    19033, 
    {"is_reset", "int8", "是否赛季重置 1是 0否"},
}
 
--- *c2s* 切换防守阵型同步状态 19034
CS_ARENA_SWITCH_DEF_FORMATION_STATE =
{
    19034,
}
 
--- *s2c* 切换防守阵型同步状态结果 19035
SC_ARENA_SWITCH_DEF_FORMATION_STATE =
{
    19035, 
    {"result", "int8", "同步防守阵型状态0-同步,1-不同步"},
}
 
--- *s2c* 活动开关信息 19050
SC_ACTIVITY_OPEN_INFO =
{
    19050, 
    {"open_list", pt_activity_info, "开启列表", "repeated"},
}
 
--- *s2c* 活动开关信息 19051
SC_ACTIVITY_OVER_INFO =
{
    19051, 
    {"over_id_list", "int16", "关闭列表", "repeated"},
}
 
--- *c2s* 请求默示之塔面板信息 19120
CS_IMPLIED_PANEL_INFO =
{
    19120,
}
 
--- *s2c* 默示之塔面板信息返回 19121
SC_IMPLIED_PANEL_INFO =
{
    19121, 
    {"difficulty", "int16", "难度"}, 
    {"tower_list", pt_implied_city_data, "城池的数据", "repeated"}, 
    {"chapter_list", pt_implied_chapter_info, "章节信息", "repeated"},
}
 
--- *c2s* 默示之塔重置章节 19122
CS_IMPLIED_RESET =
{
    19122, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *s2c* 默示之塔重置返回 19123
SC_IMPLIED_RESET =
{
    19123, 
    {"chapter_id", "int16", "章节id"}, 
    {"result", "int8", "返回结果"},
}
 
--- *s2c* 默示之塔挑战通过后选择buff 19124
SC_IMPLIED_PASS_CITY =
{
    19124, 
    {"city_id", "int16", "城池id"}, 
    {"buff_list", pt_dup_buff_list, "buff列表", "repeated"},
}
 
--- *c2s* 默示之塔选择的buff 19125
CS_IMPLIED_SELLECT_BUFF =
{
    19125, 
    {"city_id", "int16", "城池id"}, 
    {"buff_id", "int32", "buff_id 0-放弃"},
}
 
--- *s2c* 默示之塔章节结束 19126
SC_IMPLIED_CHAPTER_END =
{
    19126, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *c2s* 默示之塔难度选择 19127
CS_IMPLIED_DIFFICULTY_SELECT =
{
    19127, 
    {"difficulty", "int16", "难度"},
}
 
--- *s2c* 默示之塔难度选择结果返回 19128
SC_IMPLIED_DIFFICULTY_SELECT =
{
    19128, 
    {"result", "int8", "返回结果"},
}
 
--- *c2s* 模拟训练面板信息 19131
CS_TRAINING_PANEL_INFO =
{
    19131,
}
 
--- *s2c* 返回模拟训练面板信息 19132
SC_TRAINING_PANEL_INFO =
{
    19132, 
    {"start_time", "int32", "开始的时间戳"}, 
    {"score", "int32", "精英值"}, 
    {"step_id", "int16", "当前阶段"}, 
    {"dup_id", "int32", "副本id"}, 
    {"businessman_times", "int16", "已经触发的商人次数"}, 
    {"businessman_state", "int8", "商人的状态0-未触发1-触发了未购买"}, 
    {"award_list", pt_prop_award, "已经产出的奖励列表", "repeated"}, 
    {"is_one_end", "int8", "是否完成一次训练"}, 
    {"last_event_id", "int8", "完成一次训练随出来的事件id"}, 
    {"last_step_id", "int8", "完成一次训练随出事件的所处阶段"},
}
 
--- *c2s* 领取模拟训练奖励 19133
CS_GAIN_TRAINING_AWARD =
{
    19133,
}
 
--- *s2c* 领取模拟训练奖励返回 19134
SC_GAIN_TRAINING_AWARD =
{
    19134, 
    {"award", pt_prop_award, "奖励", "repeated"},
}
 
--- *c2s* 数据商人购买 19135
CS_TRAINING_BUSINESSMAN_BUY =
{
    19135,
}
 
--- *c2s* 请求代号希望副本信息 19140
CS_CODE_HOPE_PANEL_INFO =
{
    19140,
}
 
--- *s2c* 返回代号希望副本信息 19141
SC_CODE_HOPE_PANEL_INFO =
{
    19141, 
    {"chapter_list", pt_code_hope_chapter_info, "章节信息", "repeated"},
}
 
--- *c2s* 请求领取代号希望章节奖励 19142
CS_GAIN_CODE_HOPE_CHAPTER_AWARD =
{
    19142, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *s2c* 返回领取代号希望章节奖励结果 19143
SC_GAIN_CODE_HOPE_CHAPTER_AWARD =
{
    19143, 
    {"chapter_id", "int16", "章节id"}, 
    {"result", "int8", "结果0-失败1-成功"},
}
 
--- *c2s* 重置某个章节 19144
CS_RESET_CODE_HOPE_CHAPTER =
{
    19144, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *s2c* 重置某个章节结果返回 19145
SC_RESET_CODE_HOPE_CHAPTER =
{
    19145, 
    {"chapter_id", "int16", "章节id"}, 
    {"result", "int8", "结果0-失败1-成功"},
}
 
--- *c2s* 代号希望战员信息 19146
CS_CODE_HOPE_HERO_INFO =
{
    19146, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *s2c* 代号希望战员信息返回 19147
SC_CODE_HOPE_HERO_INFO =
{
    19147, 
    {"chapter_id", "int16", "章节id"}, 
    {"hero_list", pt_code_hope_hero_info, "战员信息列表", "repeated"},
}
 
--- *s2c* 代号希望激活某个buff 19148
SC_CODE_HOPE_ACTIVE_BUFF =
{
    19148, 
    {"buff_id", "int16", "激活的buffId"},
}
 
--- *s2c* 代号希望完成某个章节 19149
SC_CODE_HOPE_CHAPTER_END =
{
    19149, 
    {"chapter_id", "int16", "章节id"},
}
 
--- *c2s* 请求迷宫面板信息 19159
CS_MAZE_PANEL_INFO =
{
    19159,
}
 
--- *s2c* 返回迷宫面板信息 19160
SC_MAZE_PANEL_INFO =
{
    19160, 
    {"maze_list", pt_maze_info, "简单迷宫列表", "repeated"},
}
 
--- *c2s* 请求进入迷宫地图 19161
CS_ENTER_MAZE_MAP =
{
    19161, 
    {"maze_id", "int16", "迷宫id"},
}
 
--- *c2s* 请求离开迷宫地图 19162
CS_LEAVE_MAZE_MAP =
{
    19162, 
    {"maze_id", "int16", "迷宫id"},
}
 
--- *s2c* 迷宫进出地图 19163
SC_MAZE_MAP_ENTER_LEAVE =
{
    19163, 
    {"maze_id", "int16", "迷宫id"}, 
    {"maze_map_state", "int8", "状态：0-退出 1-进入"},
}
 
--- *s2c* 迷宫详细信息 19164
SC_MAZE_MAP_INFO =
{
    19164, 
    {"maze_id", "int16", "迷宫id"}, 
    {"had_gain_matrix", "int32", "已经激活的物资", "repeated"}, 
    {"pos_id", "int32", "当前位置id"}, 
    {"event_list", pt_maze_event_info, "迷宫事件列表", "repeated"}, 
    {"update_grid_info", pt_grid_info, "更新格子信息", "repeated"},
}
 
--- *c2s* 迷宫是否可以移动 19165
CS_CHECK_MAZE_MOVE =
{
    19165, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "目标位置id"},
}
 
--- *s2c* 迷宫是否可以移动返回 19166
SC_CHECK_MAZE_MOVE =
{
    19166, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "目标位置id"}, 
    {"result", "int8", "返回结果"},
}
 
--- *c2s* 迷宫开始移动 19167
CS_MAZE_MOVE =
{
    19167, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "目标位置id"},
}
 
--- *s2c* 迷宫移动结果返回 19168
SC_MAZE_MOVE =
{
    19168, 
    {"maze_id", "int16", "迷宫id"}, 
    {"new_pos", "int32", "新的位置id"}, 
    {"result", "int8", "返回结果"}, 
    {"active_event_pos_list", pt_maze_event_info, "需要手动触发的事件列表", "repeated"}, 
    {"auto_event_pos_list", pt_maze_event_info, "自动触发的事件列表", "repeated"},
}
 
--- *c2s* 请求迷宫战员信息 19171
CS_MAZE_HERO_INFO =
{
    19171, 
    {"maze_id", "int16", "迷宫id"},
}
 
--- *s2c* 返回迷宫战员信息 19172
SC_MAZE_HERO_INFO =
{
    19172, 
    {"maze_id", "int16", "迷宫id"}, 
    {"hero_info", pt_maze_hero_info, "战员信息", "repeated"},
}
 
--- *s2c* 迷宫挑战通过后选择buff 19173
SC_MAZE_PASS_CITY =
{
    19173, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "位置id"}, 
    {"buff_list", pt_dup_buff_list, "buff列表", "repeated"},
}
 
--- *c2s* 迷宫挑战成功后选择的buff 19174
CS_MAZE_SELLECT_BUFF =
{
    19174, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "位置id"}, 
    {"buff_id", "int32", "buff_id 0-放弃"},
}
 
--- *c2s* 迷宫重置地图 19175
CS_MAZE_RESET_MAP =
{
    19175, 
    {"maze_id", "int16", "迷宫id"},
}
 
--- *s2c* 迷宫重置地图 19176
SC_MAZE_RESET_MAP =
{
    19176, 
    {"maze_id", "int16", "迷宫id"}, 
    {"result", "int8", "返回结果"},
}
 
--- *s2c* 迷宫所有boss关卡挑战通过 19177
SC_MAZE_BOSS_ALL_PASS =
{
    19177, 
    {"maze_id", "int16", "迷宫id"}, 
    {"award", pt_prop_award, "奖励(第二次通过为空)", "repeated"},
}
 
--- *c2s* 迷宫确认触发事件 19178
CS_MAZE_CONFIRM_TRIGGER =
{
    19178, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "位置id"}, 
    {"active_event_id", "int32", "触发的事件id"}, 
    {"other_args", "int32", "额外参数", "repeated"},
}
 
--- *s2c* 通用触发返回 19179
SC_MAZE_CONFIRM_TRIGGER =
{
    19179, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "位置id"}, 
    {"active_event_id", "int32", "触发的事件id"}, 
    {"other_args", "int32", "额外参数", "repeated"}, 
    {"del_event_list", pt_maze_event_info, "删除事件列表", "repeated"}, 
    {"add_event_list", pt_maze_event_info, "新增事件列表", "repeated"}, 
    {"update_event_list", pt_maze_event_info, "更新事件列表", "repeated"}, 
    {"update_grid_info", pt_grid_info, "更新格子信息", "repeated"},
}
 
--- *s2c* 通用奖励触发返回 19180
SC_MAZE_AWARD_GET =
{
    19180, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "位置id"}, 
    {"active_event_id", "int32", "触发的事件id"}, 
    {"del_event_list", pt_maze_event_info, "删除事件列表", "repeated"}, 
    {"add_event_list", pt_maze_event_info, "新增事件列表", "repeated"}, 
    {"award", pt_prop_award, "奖励", "repeated"},
}
 
--- *c2s* 请求副本怪物信息 19181
CS_MAZE_DUP_MON_INFO =
{
    19181, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "位置id"},
}
 
--- *s2c* 请求副本怪物信息 19182
SC_MAZE_DUP_MON_INFO =
{
    19182, 
    {"maze_id", "int16", "迷宫id"}, 
    {"target_pos", "int32", "位置id"}, 
    {"mon_info", pt_maze_hero_info, "怪物信息", "repeated"},
}
 
--- *c2s* 额外获得物资 19183
CS_MATERIALS_ID =
{
    19183, 
    {"maze_id", "int16", "迷宫id"},
}
 
--- *s2c* 额外获得物资 19184
SC_MATERIALS_ID =
{
    19184, 
    {"sp_id", "int32", "物资id"},
}
 
--- *s2c* 可触发的事件列表 19185
SC_TRIGGER_EVENT_LIST =
{
    19185, 
    {"trigger_event_list", "int32", "可触发的事件列表", "repeated"},
}
 
--- *c2s* 迷宫请求检查触发 19186
CS_MAZE_CHECK_TRIGGER =
{
    19186, 
    {"maze_id", "int16", "迷宫id"},
}
 
--- *s2c* 迷宫迷雾格子 19187
SC_HAD_PASS_GRIDS =
{
    19187, 
    {"maze_id", "int16", "迷宫id"}, 
    {"is_update", "int8", "是否新增0-否，1-是"}, 
    {"grid_list", "int32", "格子id", "repeated"},
}
 
--- *c2s* 跳过怪物事件 19188
CS_SKIP_MON_EVENT =
{
    19188, 
    {"maze_id", "int16", "迷宫id"}, 
    {"pos_id", "int32", "当前位置id"},
}
 
--- *s2c* 已通关的怪物格子id 19189
SC_DEFEAT_MON_GRIDS =
{
    19189, 
    {"maze_id", "int16", "迷宫id"}, 
    {"grid_list", "int32", "格子id", "repeated"},
}
 
--- *c2s* 请求面板信息 19200
CS_APOSTLES_PANEL_INFO =
{
    19200,
}
 
--- *s2c* 返回面板信息 19201
SC_APOSTLES_PANEL_INFO =
{
    19201, 
    {"boss_id", "int32", "BossId"}, 
    {"skill_list", "int32", "随机被动技能", "repeated"}, 
    {"min_pass_time", "int32", "最短通关时间"}, 
    {"goal_reward", pt_bigint_short, "1:未完成，0:已完成未领奖，2：已领取奖励", "repeated"},
}
 
--- *c2s* 请求副本信息 19202
CS_APOSTLES_GOAL_REWARD =
{
    19202, 
    {"goal_id", "int32", "目标id"},
}
 
--- *s2c* 返回副本信息 19203
SC_APOSTLES_GOAL_REWARD =
{
    19203, 
    {"goal_id", "int32", "目标id"}, 
    {"result", "int8", "结果0-失败1-成功"},
}
 
--- *c2s* 排行榜数据 19210
CS_RANK_PANEL =
{
    19210, 
    {"rank_id", "int16", "排行榜id"},
}
 
--- *s2c* 排行榜返回 19211
SC_RANK_PANEL =
{
    19211, 
    {"rank_id", "int16", "排行榜类型"}, 
    {"my_rank", "int32", "我的排名"}, 
    {"my_rank_val", "int32", "我的排行值"}, 
    {"rank_list", pt_rank_info, "排行榜列表", "repeated"},
}
 
--- *c2s* 请求加工厂信息 19400
CS_FACTORY_INFO =
{
    19400,
}
 
--- *s2c* 返回加工厂信息 19401
SC_FACTORY_INFO =
{
    19401, 
    {"speed_material_info", pt_factory_speed_material, "产能信息"}, 
    {"module_list", pt_factory_module, "加工厂每个生产模块的信息", "repeated"},
}
 
--- *c2s* 加工厂购买产能值 19402
CS_FACTORY_BUY_SM =
{
    19402, 
    {"times", "int8", "购买次数"},
}
 
--- *s2c* 购买产能结果 19403
SC_FACTORY_BUY_SM =
{
    19403, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"speed_material_info", pt_factory_speed_material, "产能信息"},
}
 
--- *c2s* 加工厂生产订单 19404
CS_FACTORY_PRODUCE =
{
    19404, 
    {"module_id", "int16", "模块id"}, 
    {"formula_id", "int16", "订单id"}, 
    {"formula_num", "int16", "订单数量"}, 
    {"is_now_complete", "int8", "是否立即完成 0：否 1：是"},
}
 
--- *s2c* 加工厂生产订单结果 19405
SC_FACTORY_PRODUCE =
{
    19405, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"module_info", pt_factory_module, "操作生产订单模块的信息"}, 
    {"speed_material_info", pt_factory_speed_material, "产能信息"},
}
 
--- *c2s* 加工厂领取订单 19406
CS_FACTORY_RECEIVE =
{
    19406, 
    {"module_id", "int16", "模块id"}, 
    {"is_now_complete", "int8", "是否立即完成 0：否 1：是"},
}
 
--- *s2c* 加工厂领取订单返回 19407
SC_FACTORY_RECEIVE =
{
    19407, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"module_id", "int16", "模块id"}, 
    {"speed_material_info", pt_factory_speed_material, "产能信息"},
}
 
--- *c2s* 加工厂一键领取已完成的订单 19408
CS_FACTORY_ONE_KEY_RECEIVE =
{
    19408,
}
 
--- *s2c* 加工厂一键领取订单返回 19409
SC_FACTORY_ONE_KEY_RECEIVE =
{
    19409, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"module_list", "int16", "被领取的模块id列表", "repeated"},
}
 
--- *c2s* 加工厂终止订单 19410
CS_FACTORY_STOP =
{
    19410, 
    {"module_id", "int16", "模块id"},
}
 
--- *s2c* 加工厂终止订单返回 19411
SC_FACTORY_STOP =
{
    19411, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"module_id", "int16", "模块id"},
}
 
--- *s2c* 加工厂订单完成 19412
SC_FACTORY_COMPLETE =
{
    19412, 
    {"module_id", "int16", "模块id"},
}
 
--- *s2c* 产能信息更新 19413
SC_SPEED_MATERIAL_UPDATE =
{
    19413, 
    {"speed_material_info", pt_factory_speed_material, "产能信息"},
}
 
--- *c2s* 请求使徒之战2面板信息 19420
CS_APOSTLES2_PANEL_INFO =
{
    19420,
}
 
--- *s2c* 返回使徒之战2面板信息 19421
SC_APOSTLES2_PANEL_INFO =
{
    19421, 
    {"id", "int16", "等级难度id"}, 
    {"challenge_times", "int8", "今日已挑战次数"}, 
    {"star_num", "int16", "当前拥有的星星数量"}, 
    {"received_star_id", "int16", "已领取的星星奖励id列表", "repeated"}, 
    {"boss_list", pt_apostles2_boss, "Boss列表", "repeated"}, 
    {"end_time", "int32", "结束时间"},
}
 
--- *c2s* 领取星星奖励 19422
CS_RECEIVE_STAR_AWARD =
{
    19422, 
    {"receive_id", "int16", "领取的星星奖励id"},
}
 
--- *s2c* 领取星星奖励结果 19423
SC_RECEIVE_STAR_AWARD =
{
    19423, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"receive_id", "int16", "领取的星星奖励id"},
}
 
--- *c2s* 进入训练模式 19424
CS_INTO_TRAINING_MODE =
{
    19424, 
    {"boss_id", "int16", "Boss id"}, 
    {"dup_id", "int16", "副本id"},
}
 
--- *s2c* 进入训练模式结果 19425
SC_INTO_TRAINING_MODE =
{
    19425, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"boss_id", "int16", "Boss id"}, 
    {"dup_id", "int16", "副本id"},
}
 
--- *s2c* 元素塔面板信息 19440
SC_ELEMENT_TOWER_PANEL =
{
    19440, 
    {"tower_info_list", pt_element_tower_info, "元素塔的数据", "repeated"},
}
 
--- *s2c* 更新元素塔信息 19441
SC_UPDATE_ELEMENT_TOWER =
{
    19441, 
    {"tower_info", pt_element_tower_info, "元素塔的数据"},
}
 
--- *s2c* 战舰面板信息 19450
SC_WAR_SHIP_PANEL =
{
    19450, 
    {"building_list", pt_war_ship_building, "建筑列表", "repeated"}, 
    {"hero_list", pt_war_ship_hero, "战员列表", "repeated"},
}
 
--- *c2s* 战舰建筑升级 19451
CS_WAR_SHIP_BUILDING_LV_UP =
{
    19451, 
    {"building_id", "int16", "建筑id"},
}
 
--- *c2s* 战舰入驻战员 19452
CS_WAR_SHIP_HERO_WORK =
{
    19452, 
    {"building_id", "int16", "建筑id"}, 
    {"hero_list", pt_war_ship_hero_pos, "入驻战员列表", "repeated"},
}
 
--- *c2s* 战舰领取生产奖励 19453
CS_WAR_SHIP_RECEIVE_PRODUCE =
{
    19453, 
    {"building_id", "int16", "领取的建筑id"},
}
 
--- *c2s* 战舰一键领取生产奖励 19454
CS_WAR_SHIP_RECEIVE_PRODUCE_AUTO =
{
    19454,
}
 
--- *c2s* 战舰购买生产资源 19455
CS_WAR_SHIP_BUY_PRODUCE =
{
    19455, 
    {"buy_count", "int8", "购买的组数"},
}
 
--- *s2c* 战舰更新战员信息 19456
SC_WAR_SHIP_UPDATE_HERO =
{
    19456, 
    {"hero_list", pt_war_ship_hero, "更新的战员列表", "repeated"},
}
 
--- *s2c* 战舰更新建筑信息 19457
SC_WAR_SHIP_UPDATE_BUILDING =
{
    19457, 
    {"building_list", pt_war_ship_building, "更新的建筑列表", "repeated"},
}
 
--- *c2s* 战舰加工厂信息 19458
CS_WAR_SHIP_FACTORY_INFO =
{
    19458, 
    {"building_id", "int16", "建筑id"},
}
 
--- *s2c* 返回战舰加工厂信息 19459
SC_WAR_SHIP_FACTORY_INFO =
{
    19459, 
    {"building_id", "int16", "建筑id"}, 
    {"order_type", "int16", "订单类型"}, 
    {"order_id", "int16", "订单id"}, 
    {"count", "int16", "剩余订单数"},
}
 
--- *c2s* 战舰加工厂生产订单 19460
CS_WAR_SHIP_FACTORY_PRODUCE =
{
    19460, 
    {"building_id", "int16", "建筑id"}, 
    {"order_type", "int16", "订单类型"}, 
    {"order_id", "int16", "订单id"}, 
    {"count", "int8", "生产份数"},
}
 
--- *c2s* 战舰加速生产 19461
CS_WAR_SHIP_SPEED_UP =
{
    19461, 
    {"building_id", "int16", "建筑id"}, 
    {"cost_num", "int16", "消耗道具个数"},
}
 
--- *s2c* 返回战舰加速生产 19462
SC_WAR_SHIP_SPEED_UP =
{
    19462, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"building_id", "int16", "建筑id"},
}
 
--- *c2s* 战舰派遣邬信息 19463
CS_WAR_SHIP_EXPLORE_INFO =
{
    19463, 
    {"building_id", "int16", "建筑id"},
}
 
--- *s2c* 返回战舰派遣邬信息 19464
SC_WAR_SHIP_EXPLORE_INFO =
{
    19464, 
    {"building_id", "int16", "建筑id"}, 
    {"explore_list", pt_war_ship_explore, "区域列表", "repeated"},
}
 
--- *c2s* 战舰派遣邬区域探索 19465
CS_WAR_SHIP_EXPLORE_BEGIN =
{
    19465, 
    {"building_id", "int16", "建筑id"}, 
    {"explore_id", "int16", "区域id"}, 
    {"hero_list", pt_war_ship_hero_pos, "派遣的战员列表", "repeated"},
}
 
--- *s2c* 返回战舰派遣邬区域探索 19466
SC_WAR_SHIP_EXPLORE_BEGIN =
{
    19466, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"building_id", "int16", "建筑id"}, 
    {"explore_info", pt_war_ship_explore, "区域信息"},
}
 
--- *c2s* 战舰派遣邬探索召回 19467
CS_WAR_SHIP_EXPLORE_STOP =
{
    19467, 
    {"building_id", "int16", "建筑id"}, 
    {"explore_id", "int16", "区域id"},
}
 
--- *s2c* 返回战舰派遣邬探索召回 19468
SC_WAR_SHIP_EXPLORE_STOP =
{
    19468, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"building_id", "int16", "建筑id"}, 
    {"explore_info", pt_war_ship_explore, "区域信息"},
}
 
--- *c2s* 战舰派遣邬区域加速 19469
CS_WAR_SHIP_EXPLORE_SPEED_UP =
{
    19469, 
    {"building_id", "int16", "建筑id"}, 
    {"explore_id", "int16", "区域id"}, 
    {"cost_num", "int16", "消耗道具个数"},
}
 
--- *s2c* 返回战舰派遣邬区域加速 19470
SC_WAR_SHIP_EXPLORE_SPEED_UP =
{
    19470, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"building_id", "int16", "建筑id"}, 
    {"explore_info", pt_war_ship_explore, "区域信息"},
}
 
--- *c2s* 战舰派遣邬探索领奖 19471
CS_WAR_SHIP_EXPLORE_RECEIVE =
{
    19471, 
    {"building_id", "int16", "建筑id"}, 
    {"explore_id", "int16", "区域id"},
}
 
--- *s2c* 返回战舰派遣邬探索领奖 19472
SC_WAR_SHIP_EXPLORE_RECEIVE =
{
    19472, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"building_id", "int16", "建筑id"}, 
    {"explore_info", pt_war_ship_explore, "区域信息"},
}
 
--- *c2s* 战舰派遣邬区域一键探索 19473
CS_WAR_SHIP_EXPLORE_BEGIN_ONE_KEY =
{
    19473, 
    {"explore_one_key_list", pt_war_ship_explore_begin_one_key, "一键探索列表", "repeated"},
}
 
--- *s2c* 返回战舰派遣邬区域一键探索 19474
SC_WAR_SHIP_EXPLORE_BEGIN_ONE_KEY =
{
    19474, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"war_ship_explore_list", pt_war_ship_explore_info, "建筑区域信息", "repeated"},
}
 
--- *c2s* 战舰派遣邬探索一键领奖 19475
CS_WAR_SHIP_EXPLORE_RECEIVE_ONE_KEY =
{
    19475,
}
 
--- *s2c* 返回战舰派遣邬探索一键领奖 19476
SC_WAR_SHIP_EXPLORE_RECEIVE_ONE_KEY =
{
    19476, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"war_ship_explore_list", pt_war_ship_explore_info, "建筑区域信息", "repeated"},
}
 
--- *c2s* 地图进入准备 19500
CS_PREPARE_ENTER_EVENT_CYCLE =
{
    19500, 
    {"step", "int8", "进入步骤"}, 
    {"args", "int16", "参数", "repeated"},
}
 
--- *s2c* 战前准备基础信息 19501
SC_EVENT_CYCLE_PREWAR_INFO =
{
    19501, 
    {"open_panel", "int8", "1-通知前端需要主动打开界面"}, 
    {"prewar_info", pt_event_cycle_prewar_info, "准备信息"}, 
    {"abandon_time", "int32", "放弃时间戳记录"},
}
 
--- *s2c* 资源信息 19502
SC_EVENT_CYCLE_RESOURCE_INFO =
{
    19502, 
    {"resource_info", pt_event_cycle_resource_info, "资源信息"},
}
 
--- *s2c* 地图线路信息 19503
SC_EVENT_CYCLE_LINE_INFO =
{
    19503, 
    {"line_info", pt_event_cycle_line_info, "线路信息"},
}
 
--- *s2c* 历史信息 19504
SC_EVENT_CYCLE_HISTORY_INFO =
{
    19504, 
    {"history_info", pt_event_cycle_history_info, "历史数据信息"},
}
 
--- *c2s* 触发事件 19505
CS_EVENT_CYCLE_TRIGGER_EVENT =
{
    19505, 
    {"cell_id", "int16", "格子id"},
}
 
--- *c2s* 确认触发事件 19506
CS_EVENT_CYCLE_TRIGGER_CONFIRM =
{
    19506, 
    {"cell_id", "int16", "格子id"}, 
    {"args", "int32", "触发参数", "repeated"},
}
 
--- *s2c* 更新格子信息 19507
SC_EVENT_CYCLE_UPDATE_CELL_INFO =
{
    19507, 
    {"cur_cell", "int16", "0-当前无触发格子(格子id)"}, 
    {"cell_info", pt_event_cycle_cell_info, "格子信息"}, 
    {"pass_cell", "int16", "已走过格子", "repeated"},
}
 
--- *c2s* 放弃探索 19508
CS_EVENT_CYCLE_ABANDON_EXPLORE =
{
    19508,
}
 
--- *s2c* 英雄列表 19509
SC_EVENT_CYCLE_HERO_LIST =
{
    19509, 
    {"hero_list", "int32", "已招募战员列表", "repeated"},
}
 
--- *s2c* 更新收藏品列表 19510
SC_EVENT_CYCLE_COLLAGE_INFO =
{
    19510, 
    {"collage_list", "int32", "收藏品信息", "repeated"}, 
    {"color_cost", pt_event_cycle_recruit_color_cost, "招募战员品质消耗", "repeated"}, 
    {"ele_cost", pt_event_cycle_recruit_ele_cost, "招募战员属性消耗", "repeated"}, 
    {"show_windows", "int8", "是否弹窗展示0-否,1-是"},
}
 
--- *c2s* 购买商品 19511
CS_EVENT_CYCLE_BUY_GOODS =
{
    19511, 
    {"goods_id", "int32", "商品id"},
}
 
--- *c2s* 刷新商品 19512
CS_EVENT_CYCLE_REFRESH_GOODS =
{
    19512,
}
 
--- *c2s* 商店招募英雄 19513
CS_EVENT_CYCLE_SHOP_RECRUIT_HERO =
{
    19513, 
    {"hero_id", "int32", "战员id"},
}
 
--- *c2s* 投资商店存钱 19514
CS_EVENT_CYCLE_DEPOSIT_COIN =
{
    19514, 
    {"coin", "int16", "玩法币数量"},
}
 
--- *c2s* 投资商店取钱 19515
CS_EVENT_CYCLE_WITHDRAW_COIN =
{
    19515, 
    {"coin", "int16", "玩法币数量"},
}
 
--- *s2c* 购买商品 19516
SC_EVENT_CYCLE_BUY_GOODS_RESULT =
{
    19516, 
    {"goods_id", "int32", "商品id"}, 
    {"cur_ticket", "int16", "当前招募券id,id不为0时要进入招募界面"}, 
    {"result", "int8", "返回结果"},
}
 
--- *s2c* 普通商店信息 19517
SC_EVENT_CYCLE_NORMAL_SHOP =
{
    19517, 
    {"shop_info", pt_event_cycle_normal_shop, "普通商店信息"},
}
 
--- *s2c* 投资商店信息 19518
SC_EVENT_CYCLE_INVEST_SHOP =
{
    19518, 
    {"shop_info", pt_event_cycle_invest_shop, "投资商店信息"},
}
 
--- *s2c* 结算统计 19519
SC_EVENT_CYCLE_SETTLE_STATS =
{
    19519, 
    {"old_lv", "int16", "旧等级"}, 
    {"new_lv", "int16", "新等级"}, 
    {"add_talent_point", "int16", "添加的天赋点数"}, 
    {"is_pass", "int8", "是否通关"}, 
    {"point", "int32", "结算总分"}, 
    {"add_exp", "int32", "添加得经验值"}, 
    {"stats_info", pt_event_cycle_settle_stats, "统计信息", "repeated"},
}
 
--- *c2s* 解锁天赋 19520
CS_EVENT_CYCLE_UNLOCK_TALENT =
{
    19520, 
    {"talent_id", "int16", "天赋id"},
}
 
--- *s2c* 解锁天赋结果 19521
SC_EVENT_CYCLE_UNLOCK_TALENT =
{
    19521, 
    {"talent_id", "int16", "天赋id"}, 
    {"result", "int8", "结果0-失败,1-成功"},
}
 
--- *s2c* 天赋面板信息 19522
SC_EVENT_CYCLE_TALENT_INFO =
{
    19522, 
    {"talent_info", pt_event_cycle_talent_info, "天赋信息"}, 
    {"talent_attr", pt_attr, "天赋属性", "repeated"},
}
 
--- *s2c* 更新天赋点数 19523
SC_EVENT_CYCLE_UPDATE_TALENT_POINT =
{
    19523, 
    {"talent_point", "int16", "天赋点数"},
}
 
--- *c2s* 刷新任务 19524
CS_EVENT_CYCLE_REFRESH_TASK =
{
    19524, 
    {"task_id", "int16", "任务id"},
}
 
--- *s2c* 任务信息面板 19525
SC_EVENT_CYCLE_TASK_PANEL =
{
    19525, 
    {"refresh_times", "int8", "剩余刷新次数"}, 
    {"task_info", pt_task_info_base, "任务内容", "repeated"}, 
    {"reset_time", "int32", "任务重置时间戳"},
}
 
--- *s2c* 更新任务进度 19526
SC_UPDATE_EVENT_CYCLE_TASK_INFO =
{
    19526, 
    {"task_info", pt_task_info_base, "任务内容"}, 
    {"refresh_times", "int8", "剩余刷新次数"},
}
 
--- *c2s* 等级奖励 19527
CS_EVENT_CYCLE_GAIN_LV_REWARD =
{
    19527, 
    {"lv", "int16", "等级"},
}
 
--- *s2c* 等级奖励结果返回 19528
SC_EVENT_CYCLE_GAIN_LV_REWARD =
{
    19528, 
    {"lv", "int16", "等级"}, 
    {"result", "int8", "返回结果"},
}
 
--- *c2s* 领取所有等级奖励 19529
CS_EVENT_CYCLE_GAIN_ALL_LV_REWARD =
{
    19529,
}
 
--- *s2c* 已解锁剧情对话 19530
SC_EVENT_CYCLE_STORY_LIST =
{
    19530, 
    {"story_list", "int32", "对话id列表", "repeated"},
}
 
--- *c2s* 收藏品奖励 19531
CS_EVENT_CYCLE_GAIN_COLLAGE_REWARD =
{
    19531, 
    {"id", "int16", "奖励id"},
}
 
--- *s2c* 收藏品奖励结果返回 19532
SC_EVENT_CYCLE_GAIN_COLLAGE_REWARD =
{
    19532, 
    {"id", "int16", "奖励id"}, 
    {"result", "int8", "返回结果"},
}
 
--- *c2s* 陈列室奖励 19533
CS_EVENT_CYCLE_GAIN_SHOWROOM_REWARD =
{
    19533, 
    {"id", "int16", "奖励id"},
}
 
--- *s2c* 陈列室奖励结果返回 19534
SC_EVENT_CYCLE_GAIN_SHOWROOM_REWARD =
{
    19534, 
    {"id", "int16", "奖励id"}, 
    {"result", "int8", "返回结果"},
}
 
--- *c2s* 自走棋面板信息 19550
CS_AUTO_CHESS_PANEL =
{
    19550,
}
 
--- *s2c* 自走棋面板信息 19551
SC_AUTO_CHESS_PANEL =
{
    19551, 
    {"score", "int32", "积分"}, 
    {"rank", "int8", "段位"}, 
    {"coin", "int32", "已拥有的自走棋币"}, 
    {"week_get_assets", "int16", "本周已获得的自走棋货币"}, 
    {"dlc_hero_list", "int32", "扩展战员tid列表", "repeated"}, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"}, 
    {"is_in_room", "int8", "是否在房间内 0：否 1：是"},
}
 
--- *c2s* 自走棋开始匹配 19552
CS_AUTO_CHESS_MATCHING =
{
    19552,
}
 
--- *s2c* 自走棋开始匹配 19553
SC_AUTO_CHESS_MATCHING =
{
    19553, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *c2s* 自走棋取消匹配 19554
CS_AUTO_CHESS_MATCHING_CANCEL =
{
    19554,
}
 
--- *s2c* 自走棋取消匹配 19555
SC_AUTO_CHESS_MATCHING_CANCEL =
{
    19555, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *s2c* 自走棋匹配成功 19556
SC_AUTO_CHESS_MATCHING_SUCCESS =
{
    19556, 
    {"player_list", pt_auto_chess_matching_player, "匹配玩家列表", "repeated"},
}
 
--- *c2s* 自走棋房间加载进度 19557
CS_AUTO_CHESS_ROOM_LOADING =
{
    19557, 
    {"progress", "int8", "进度（100为加载完成）"},
}
 
--- *s2c* 自走棋房间加载进度 19558
SC_AUTO_CHESS_ROOM_LOADING =
{
    19558, 
    {"player_id", "int32", "玩家id"}, 
    {"progress", "int8", "进度（100为加载完成）"},
}
 
--- *s2c* 自走棋进入房间 19559
SC_AUTO_CHESS_ENTER_ROOM =
{
    19559,
}
 
--- *s2c* 自走棋进入准备阶段 19560
SC_AUTO_CHESS_STAGE_READY =
{
    19560, 
    {"base_info", pt_auto_chess_base, "基础信息"}, 
    {"base_gold", "int16", "固定金币"}, 
    {"win_gold", "int16", "连胜金币"}, 
    {"fail_gold", "int16", "连败金币"}, 
    {"interest_gold", "int16", "利息金币"},
}
 
--- *s2c* 自走棋房间进入战斗阶段 19561
SC_AUTO_CHESS_STAGE_BATTLE =
{
    19561, 
    {"remaining_time", "int16", "剩余时间"}, 
    {"battle_player_id", "int32", "对战玩家id"}, 
    {"battle_player_lineup", pt_auto_chess_lineup_hero, "对战玩家阵容", "repeated"},
}
 
--- *s2c* 自走棋房间进入等待阶段 19562
SC_AUTO_CHESS_STAGE_WAIT =
{
    19562, 
    {"remaining_time", "int16", "剩余时间"}, 
    {"gold", "int16", "拥有的金币"}, 
    {"hp", "int8", "生命值"}, 
    {"battle_result_info", pt_auto_chess_battle_result, "战斗结果信息"},
}
 
--- *s2c* 自走棋结算信息 19563
SC_AUTO_CHESS_ROOM_RESULT =
{
    19563, 
    {"add_score", "int32", "获得积分"}, 
    {"rank_list", pt_auto_chess_player_result, "排行列表", "repeated"},
}
 
--- *c2s* 自走棋购买战员 19564
CS_AUTO_CHESS_BUY_HERO =
{
    19564, 
    {"pos", "int8", "招募池位置"},
}
 
--- *s2c* 自走棋购买战员 19565
SC_AUTO_CHESS_BUY_HERO =
{
    19565, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"gold", "int16", "拥有的金币"}, 
    {"reserve_hero", pt_auto_chess_lineup_hero, "购买的战员在备战区的信息"}, 
    {"pool_hero_list", pt_auto_chess_pool_hero, "招募池列表", "repeated"},
}
 
--- *c2s* 自走棋出售战员 19566
CS_AUTO_CHESS_SELL_HERO =
{
    19566, 
    {"lineup_pos", pt_auto_chess_lineup_pos, "选定位置"},
}
 
--- *s2c* 自走棋出售战员 19567
SC_AUTO_CHESS_SELL_HERO =
{
    19567, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"gold", "int16", "拥有的金币"}, 
    {"lineup_pos", pt_auto_chess_lineup_pos, "出售的位置"},
}
 
--- *c2s* 自走棋修改阵容 19568
CS_AUTO_CHESS_LINEUP_CHANGE =
{
    19568, 
    {"from_pos", pt_auto_chess_lineup_pos, "选定位置"}, 
    {"to_pos", pt_auto_chess_lineup_pos, "目标位置"},
}
 
--- *s2c* 自走棋修改阵容 19569
SC_AUTO_CHESS_LINEUP_CHANGE =
{
    19569, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"change_list", pt_auto_chess_lineup_hero, "修改的战员阵容列表", "repeated"},
}
 
--- *c2s* 自走棋锁定/解锁招募池 19570
CS_AUTO_CHESS_LOCK_POOL =
{
    19570, 
    {"is_lock", "int8", "是否锁定 0：是 1：否"},
}
 
--- *s2c* 自走棋锁定/解锁招募池 19571
SC_AUTO_CHESS_LOCK_POOL =
{
    19571, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"is_lock", "int8", "是否锁定 0：是 1：否"},
}
 
--- *c2s* 自走棋刷新招募池 19572
CS_AUTO_CHESS_REFRESH_POOL =
{
    19572,
}
 
--- *s2c* 自走棋刷新招募池 19573
SC_AUTO_CHESS_REFRESH_POOL =
{
    19573, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"gold", "int16", "拥有的金币"}, 
    {"is_lock", "int8", "是否锁定 0：是 1：否"}, 
    {"pool_hero_list", pt_auto_chess_pool_hero, "招募池列表", "repeated"},
}
 
--- *c2s* 自走棋战员升星 19574
CS_AUTO_CHESS_STAR =
{
    19574, 
    {"source_pos", pt_auto_chess_lineup_pos, "素材战员位置", "repeated"}, 
    {"to_pos", pt_auto_chess_lineup_pos, "目标位置"},
}
 
--- *s2c* 自走棋战员升星 19575
SC_AUTO_CHESS_STAR =
{
    19575, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"source_pos", pt_auto_chess_lineup_pos, "素材战员位置", "repeated"}, 
    {"star_hero", pt_auto_chess_lineup_hero, "升星战员"},
}
 
--- *c2s* 自走棋增加队伍经验 19576
CS_AUTO_CHESS_ADD_EXP =
{
    19576,
}
 
--- *s2c* 自走棋增加队伍经验 19577
SC_AUTO_CHESS_ADD_EXP =
{
    19577, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"gold", "int16", "拥有的金币"}, 
    {"team_lv", "int8", "队伍等级"}, 
    {"team_exp", "int16", "队伍经验值"},
}
 
--- *c2s* 自走棋查看房间内所有玩家信息 19578
CS_AUTO_CHESS_ROOM_ALL_PLAYER =
{
    19578,
}
 
--- *s2c* 自走棋查看房间内所有玩家信息 19579
SC_AUTO_CHESS_ROOM_ALL_PLAYER =
{
    19579, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"player_list", pt_auto_chess_player_base, "玩家基本信息列表", "repeated"},
}
 
--- *s2c* 自走棋重新进入房间 19580
SC_AUTO_CHESS_ROOM_REENTER =
{
    19580, 
    {"base_info", pt_auto_chess_base, "基础信息"},
}
 
--- *s2c* 自走棋上次房间的结算结果（加载资源过程中被淘汰 加载完成后会发这个） 19581
SC_AUTO_CHESS_ROOM_LAST_RESULT =
{
    19581, 
    {"rank_list", pt_auto_chess_player_result, "排行列表", "repeated"},
}
 
--- *c2s* 自走棋退出房间 19582
CS_AUTO_CHESS_ROOM_EXIT =
{
    19582,
}
 
--- *c2s* 自走棋领取任务奖励 19583
CS_AUTO_CHESS_RECEIVE_TASK_AWARD =
{
    19583, 
    {"task_id", "int16", "任务id"},
}
 
--- *s2c* 自走棋领取任务奖励 19584
SC_AUTO_CHESS_RECEIVE_TASK_AWARD =
{
    19584, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"}, 
    {"coin", "int32", "已拥有的自走棋币"},
}
 
--- *s2c* 战员试玩信息 19601
SC_HERO_TRY_INFO =
{
    19601, 
    {"pass_dup", "int16", "已通关副本id", "repeated"},
}
 
--- *s2c* 保护刁民面板信息 19610
SC_PROTECT_PEOPLE_PANEL_INFO =
{
    19610, 
    {"dup_info", pt_protect_people_dup, "保护刁民副本信息", "repeated"}, 
    {"received_star_id", "int16", "已领取的阶段奖励id", "repeated"},
}
 
--- *c2s* 保护刁民领取星级奖励 19613
CS_PROTECT_PEOPLE_RECEIVE_STAR_AWARD =
{
    19613, 
    {"receive_id", "int8", "奖励id"},
}
 
--- *s2c* 保护刁民领取星级奖励 19614
SC_PROTECT_PEOPLE_RECEIVE_STAR_AWARD =
{
    19614, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"receive_id", "int16", "领取的阶段奖励id"},
}
 
--- *s2c* 战斗结算界面星星展示 19615
SC_PROTECT_PEOPLE_BATTLE_STAR =
{
    19615, 
    {"battle_end_dup", pt_protect_people_dup, "战斗结算达成星星数"},
}
 
--- *c2s* 保护刁民一键领取星级奖励 19616
CS_PROTECT_PEOPLE_RECEIVE_STAR_AWARD_ONE_KEY =
{
    19616,
}
 
--- *s2c* 保护刁民一键领取星级奖励 19617
SC_PROTECT_PEOPLE_RECEIVE_STAR_AWARD_ONE_KEY =
{
    19617, 
    {"result", "int8", "结果 0：失败 1：成功"}, 
    {"receive_id", "int16", "领取的阶段奖励id", "repeated"},
}
 
--- *c2s* 综合对抗赛面板内容 19700
CS_COMPETITION_INFO =
{
    19700,
}
 
--- *s2c* 综合对抗赛面板内容 19701
SC_COMPETITION_INFO =
{
    19701, 
    {"season", "int32", "赛季"}, 
    {"season_end_time", "int64str", "赛季结束时间戳"}, 
    {"is_reset", "int8", "是否赛季重置 1是 0否"},
}
 
--- *c2s* 综合对抗赛面板内容 19702
CS_COMPETITION_PANEL =
{
    19702,
}
 
--- *s2c* 综合对抗赛面板内容 19703
SC_COMPETITION_PANEL =
{
    19703, 
    {"my_season_rank", "int32", "我的赛季排名"}, 
    {"my_score", "int32", "我的分数"}, 
    {"my_segment", "int16", "我的段位"}, 
    {"win_count", "int32", "胜利数"}, 
    {"remain_free_times", "int8", "剩余免费次数"}, 
    {"enemy_list", pt_competition_enemy, "随机推荐的对手榜", "repeated"}, 
    {"refresh_time", "int64str", "刷新时间戳"}, 
    {"buy_times", "int8", "付费次数"}, 
    {"bought_times", "int8", "已购买次数"}, 
    {"sync_def_formation_state", "int8", "同步防守阵型状态0-同步,1-不同步"}, 
    {"war_id", "int8", "2-低级战区,3-中级战区,4-高级战区"},
}
 
--- *c2s* 综合对抗赛查看前100名 19704
CS_SHOW_TOP_COMPETITION_PLAYER =
{
    19704,
}
 
--- *s2c* 综合对抗赛查看前100名 19705
SC_SHOW_TOP_COMPETITION_PLAYER =
{
    19705, 
    {"top_enemy_list", pt_competition_rank, "玩家列表", "repeated"},
}
 
--- *c2s* 综合对抗赛刷新对手 19706
CS_REFRESH_COMPETITION_ENEMY =
{
    19706,
}
 
--- *s2c* 综合对抗赛刷新对手 19707
SC_REFRESH_COMPETITION_ENEMY =
{
    19707, 
    {"enemy_list", pt_competition_enemy, "随机推荐的对手榜", "repeated"}, 
    {"refresh_time", "int64str", "刷新时间戳"},
}
 
--- *c2s* 综合对抗赛查看日志 19708
CS_SHOW_COMPETITION_LOG =
{
    19708,
}
 
--- *s2c* 查看日志 19709
SC_SHOW_COMPETITION_LOG =
{
    19709, 
    {"log_list", pt_competition_log, "综合对抗赛日志", "repeated"},
}
 
--- *s2c* 是否赛季重置期间 19710
SC_IS_COMPETITION_RESET =
{
    19710, 
    {"is_reset", "int8", "是否赛季重置 1是 0否"},
}
 
--- *s2c* 综合对抗赛请求战斗失败 19712
SC_COMPETITION_BATTLE_FAIL =
{
    19712,
}
 
--- *c2s* 综合对抗赛购买次数 19713
CS_COMPETITION_BUY_TIMES =
{
    19713, 
    {"times", "int8", "次数"},
}
 
--- *c2s* 切换防守阵型同步状态 19714
CS_COMPETITION_SWITCH_DEF_FORMATION_STATE =
{
    19714,
}
 
--- *s2c* 切换防守阵型同步状态结果 19715
SC_COMPETITION_SWITCH_DEF_FORMATION_STATE =
{
    19715, 
    {"result", "int8", "同步防守阵型状态0-同步,1-不同步"},
}
 
--- *c2s* 公会战(联合围剿)时间信息 19731
CS_GUILD_FIGHT_TIME_INFO =
{
    19731,
}
 
--- *s2c* 公会战(联合围剿)时间信息 19732
SC_GUILD_FIGHT_TIME_INFO =
{
    19732, 
    {"state", "int8", "状态：0- 未开始，1-赛季初始化， 2-开始，3-锁定，4-结算中"}, 
    {"season_start_time", "int64str", "赛季开始时间戳"}, 
    {"season_end_time", "int64str", "赛季结束时间戳"}, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *c2s* 公会战(联合围剿)面板信息 19733
CS_GUILD_FIGHT_PANEL_INFO =
{
    19733,
}
 
--- *s2c* 公会战(联合围剿)面板信息 19734
SC_GUILD_FIGHT_PANEL_INFO =
{
    19734, 
    {"challenge_time", "int16", "剩余挑战次数"}, 
    {"round", "int16", "当前轮次"}, 
    {"guild_rank", "int16", "公会排名"}, 
    {"boss_list", pt_guild_fight_boss, "当前开放boss", "repeated"}, 
    {"lock_hero_list", "int32", "锁定的战员id列表", "repeated"}, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *c2s* 公会战(联合围剿)boss战斗记录 19735
CS_GUILD_FIGHT_BOSS_RECORD =
{
    19735, 
    {"round", "int16", "轮次"}, 
    {"order", "int16", "怪物序号"}, 
    {"page", "int8", "页数"},
}
 
--- *s2c* 公会战(联合围剿)boss战斗记录 19736
SC_GUILD_FIGHT_BOSS_RECORD =
{
    19736, 
    {"round", "int16", "轮次"}, 
    {"order", "int16", "怪物序号"}, 
    {"page", "int8", "页数"}, 
    {"max_page", "int8", "最大页数"}, 
    {"record", pt_guild_fight_record, "战斗记录", "repeated"}, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *c2s* 公会战(联合围剿)战斗记录 19737
CS_GUILD_FIGHT_BATTLE_RECORD =
{
    19737, 
    {"page", "int8", "页数"},
}
 
--- *s2c* 公会战(联合围剿)战斗记录 19738
SC_GUILD_FIGHT_BATTLE_RECORD =
{
    19738, 
    {"page", "int8", "页数"}, 
    {"max_page", "int8", "最大页数"}, 
    {"record", pt_guild_fight_record, "战斗记录", "repeated"}, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *c2s* 公会战(联合围剿)排行榜 19739
CS_GUILD_FIGHT_RANK =
{
    19739,
}
 
--- *s2c* 公会战(联合围剿)排行榜 19740
SC_GUILD_FIGHT_RANK =
{
    19740, 
    {"guild_rank", pt_guild_fight_rank, "本公会排行"}, 
    {"all_guild_tank", pt_guild_fight_rank, "当前排名", "repeated"}, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *c2s* 公会战当前在挑战的人数 19741
CS_GUILD_FIGHT_NOW_CHALLENGE_NUMBER =
{
    19741, 
    {"dup_id", "int16", "boss战关卡id"},
}
 
--- *s2c* 公会战当前在挑战的人数 19742
SC_GUILD_FIGHT_NOW_CHALLENGE_NUMBER =
{
    19742, 
    {"dup_id", "int16", "boss战关卡id"}, 
    {"number", "int8", "当前正在挑战的数量"}, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *c2s* 公会战(联合围剿)工会成员战斗记录 19743
CS_GUILD_FIGHT_MEMBER_RECORD =
{
    19743,
}
 
--- *s2c* 公会战(联合围剿)战斗记录 19744
SC_GUILD_FIGHT_MEMBER_RECORD =
{
    19744, 
    {"record", pt_guild_member_rank, "工会成员战斗记录", "repeated"},
}
 
--- *c2s* 无限城面板信息 19751
CS_BOUNDLESS_CITY_PANEL =
{
    19751,
}
 
--- *s2c* 无限城面板信息 19752
SC_BOUNDLESS_CITY_PANEL =
{
    19752, 
    {"city_id", "int8", "1-下城区,2-中城区,3-上城区"}, 
    {"war_id", "int16", "战区"}, 
    {"disturbance_id", "int32", "扰动id"}, 
    {"round_skill_id", "int32", "环境指数"}, 
    {"round_id", "int32", "轮次id"}, 
    {"max_dup", "int32", "最大副本id"}, 
    {"can_open", "int8", "是否能打开面板"}, 
    {"rank", "int32", "排名"}, 
    {"point", "int32", "排行值"}, 
    {"settle_state", "int8", "晋级状态,1-晋级,2-保级,3-降级"}, 
    {"boundless_city_history_list", pt_boundless_city_history_info, "玩家每层信息", "repeated"}, 
    {"boundless_city_player_list", pt_boundless_city_player_info, "城区玩家信息", "repeated"}, 
    {"dup_list", "int32", "关卡列表", "repeated"},
}
 
--- *s2c* 结算面板 19753
SC_BOUNDLESS_CITY_SETTLE_PANEL =
{
    19753, 
    {"battle_round", "int16", "战斗回合数"}, 
    {"hero_die_num", "int16", "战员死亡数量"}, 
    {"final_point", "int32", "最终评分"}, 
    {"finish_target_list", "int16", "已完成的目标列表", "repeated"},
}
 
--- *s2c* 无限城红点 19754
SC_BOUNDLESS_CITY_RED =
{
    19754, 
    {"is_red", "int8", "0-不显示红点,1-显示红点"},
}
 
--- *c2s* 无限城面刷新板信息 19755
CS_BOUNDLESS_CITY_UPDATE_PANEL =
{
    19755,
}
 
--- *s2c* 无限城面刷新板信息 19756
SC_BOUNDLESS_CITY_UPDATE_PANEL =
{
    19756, 
    {"rank", "int32", "排名"}, 
    {"point", "int32", "排行值"}, 
    {"settle_state", "int8", "晋级状态,1-晋级,2-保级,3-降级"}, 
    {"boundless_city_history_list", pt_boundless_city_history_info, "玩家每层信息", "repeated"}, 
    {"boundless_city_player_list", pt_boundless_city_player_info, "城区玩家信息", "repeated"},
}
 
--- *s2c* 联合扫荡时间信息 19781
SC_GUILD_SWEEP_INFO =
{
    19781, 
    {"state", "int8", "状态：0- 开启状态，1-锁定状态"}, 
    {"change_time", "int64str", "下次状态改变的时间"}, 
    {"now_level", "int16", "当前选择的难度"}, 
    {"max_level", "int16", "可选择的最高难度"}, 
    {"round_id", "int16", "本周的轮换id"}, 
    {"hp_rate", "int16", "剩余血量百分比"}, 
    {"challenge_time", "int16", "剩余挑战次数"}, 
    {"had_reward_list", "int16", "已经领取的奖励列表", "repeated"},
}
 
--- *c2s* 联合扫荡选择难度 19782
CS_GUILD_SWEEP_SELECT_LEVEL =
{
    19782, 
    {"now_level", "int16", "选择难度"},
}
 
--- *c2s* 联合扫荡面板信息 19783
CS_GUILD_SWEEP_PANEL_INFO =
{
    19783,
}
 
--- *s2c* 联合扫荡面板信息 19784
SC_GUILD_SWEEP_PANEL_INFO =
{
    19784, 
    {"challenge_time", "int16", "剩余挑战次数"}, 
    {"hp_rate", "int16", "剩余血量百分比"}, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *c2s* 联合扫荡领奖 19785
CS_GUILD_SWEEP_REWARD =
{
    19785, 
    {"id", "int16", "奖励序号"},
}
 
--- *s2c* 联合扫荡领奖 19786
SC_GUILD_SWEEP_REWARD =
{
    19786, 
    {"id", "int16", "奖励序号"}, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *c2s* 联合扫荡公会成员战斗信息 19787
CS_GUILD_SWEEP_MEMBER_RECORD =
{
    19787,
}
 
--- *s2c* 联合扫荡公会成员战斗信息 19788
SC_GUILD_SWEEP_MEMBER_RECORD =
{
    19788, 
    {"record", pt_guild_sweep_member_rank, "工会成员战斗记录", "repeated"}, 
    {"result", "int8", "结果 0：失败 1：成功"},
}
 
--- *s2c* 界面信息 19801
SC_DISASTER_PANEL =
{
    19801, 
    {"disaster_main_panel", pt_disaster_main_panel, "主界面信息"}, 
    {"disaster_formation_panel", pt_disaster_formation_panel, "阵型界面信息"},
}
 
--- *c2s* 挑战狂厄之灾 19802
CS_CHALLENGE_DISASTER =
{
    19802, 
    {"difficulty", "int8", "挑战难度"},
}
 
--- *s2c* 挑战狂厄之灾 19803
SC_CHALLENGE_DISASTER =
{
    19803, 
    {"result", "int8", "结果0-失败,1-成功"},
}
 
--- *c2s* 放弃挑战狂厄之灾 19804
CS_ABANDON_DISASTER =
{
    19804,
}
 
--- *s2c* 放弃挑战狂厄之灾 19805
SC_ABANDON_DISASTER =
{
    19805, 
    {"result", "int8", "结果0-失败,1-成功"},
}
 
--- *c2s* 领取累计伤害奖励 19806
CS_GAIN_DAMAGE_REWARD =
{
    19806, 
    {"reward_id", "int16", "奖励id"},
}
 
--- *s2c* 领取累计伤害奖励 19807
SC_GAIN_DAMAGE_REWARD =
{
    19807, 
    {"reward_id", "int16", "奖励id"}, 
    {"result", "int8", "结果0-失败,1-成功"},
}
 
--- *c2s* 排行榜数据 19808
CS_DISASTER_RANK_PANEL =
{
    19808,
}
 
--- *s2c* 排行榜返回 19809
SC_DISASTER_RANK_PANEL =
{
    19809, 
    {"my_rank", "int32", "我的排名"}, 
    {"my_rank_val", "int64str", "我的排行值"}, 
    {"rank_list", pt_disaster_rank_info, "排行榜列表", "repeated"},
}
 
--- *c2s* 挑战联盟训练副本界面 19831
CS_GUILD_TRAIN_DUP_PANEL =
{
    19831, 
    {"dup_id", "int16", "挑战副本id"},
}
 
--- *s2c* 界面信息 19832
SC_GUILD_TRAIN_DUP_PANEL =
{
    19832, 
    {"dup_id", "int16", "挑战副本id"}, 
    {"my_rank", "int32", "我的排名"}, 
    {"my_rank_val", "int64str", "我的排行值"},
}
 
--- *c2s* 排行榜数据 19834
CS_GUILD_TRAIN_RANK =
{
    19834, 
    {"dup_id", "int16", "挑战副本id"},
}
 
--- *s2c* 排行榜返回 19835
SC_GUILD_TRAIN_RANK =
{
    19835, 
    {"dup_id", "int16", "挑战副本id"}, 
    {"my_rank", "int32", "我的排名"}, 
    {"my_rank_val", "int64str", "我的排行值"}, 
    {"rank_list", pt_guild_train_rank_info, "排行榜列表", "repeated"},
}
 
--- *c2s* 地图进入准备 19851
CS_PREPARE_ENTER_SEABED =
{
    19851, 
    {"step", "int8", "进入步骤"}, 
    {"args", "int16", "参数", "repeated"},
}
 
--- *s2c* 战前准备基础信息 19852
SC_SEABED_PREWAR_INFO =
{
    19852, 
    {"prewar_info", pt_seabed_prewar_info, "准备信息"}, 
    {"abandon_time", "int32", "放弃时间戳记录"}, 
    {"is_login", "int8", "1-登录,0-否"}, 
    {"collage_list", "int32", "收藏品列表", "repeated"}, 
    {"buff_list", "int32", "buff列表", "repeated"},
}
 
--- *s2c* 资源信息 19853
SC_SEABED_RESOURCE_INFO =
{
    19853, 
    {"resource_info", pt_seabed_resource_info, "资源信息"},
}
 
--- *s2c* 地图线路信息 19854
SC_SEABED_LINE_INFO =
{
    19854, 
    {"line_info", pt_seabed_line_info, "线路信息"},
}
 
--- *c2s* 触发事件 19855
CS_SEABED_TRIGGER_EVENT =
{
    19855, 
    {"cell_id", "int16", "格子id"}, 
    {"option_event", "int32", "选择事件id"},
}
 
--- *s2c* 更新格子信息 19856
SC_SEABED_UPDATE_CELL_INFO =
{
    19856, 
    {"cur_cell", "int16", "0-当前无触发格子(格子id)"}, 
    {"event_type", "int8", "0-普通,1-循环,2-战斗,3-商店,4-收藏品选buff"}, 
    {"history_event_type", "int8", "0-普通,1-循环,2-战斗,3-商店,4-收藏品选buff"}, 
    {"cell_info", pt_seabed_cell_info, "格子信息"}, 
    {"battle_info", pt_seabed_battle_info, "战斗信息"}, 
    {"shop_info", pt_seabed_shop_info, "商店信息"}, 
    {"event_select_buff", "int32", "触发事件后开始选buff", "repeated"}, 
    {"pass_cell", "int16", "已走过格子", "repeated"}, 
    {"pass_branch_cell", "int16", "已走过分支格子", "repeated"},
}
 
--- *c2s* 战后选择 19857
CS_SEABED_POSTWAR_SELECT =
{
    19857, 
    {"select_type", "int8", "选择类型1-收藏品选择,2-buff选择,3-事件buff选择"}, 
    {"select_id", "int32", "选择的id"},
}
 
--- *s2c* 新增buff 19858
SC_SEABED_ADD_BUFF =
{
    19858, 
    {"buff_list", "int32", "buff列表", "repeated"},
}
 
--- *s2c* 删除buff列表 19859
SC_SEABED_DEC_BUFF =
{
    19859, 
    {"buff_list", "int32", "buff列表", "repeated"},
}
 
--- *s2c* 新增收藏品 19860
SC_SEABED_ADD_COLLAGE =
{
    19860, 
    {"collage_list", "int32", "收藏品列表", "repeated"},
}
 
--- *s2c* 删除收藏品 19861
SC_SEABED_DEC_COLLAGE =
{
    19861, 
    {"collage_list", "int32", "收藏品列表", "repeated"},
}
 
--- *c2s* 战后刷新buff 19862
CS_SEABED_POSTWAR_REFRESH_BUFF =
{
    19862,
}
 
--- *c2s* 主动结算 19863
CS_SEABED_SETTLE =
{
    19863,
}
 
--- *s2c* 结算统计 19864
SC_SEABED_SETTLE_INFO =
{
    19864, 
    {"is_pass", "int8", "是否通关"}, 
    {"point", "int32", "结算总分"}, 
    {"talent_point", "int32", "天赋点"}, 
    {"stats_list", pt_seabed_stats_detail, "统计信息", "repeated"}, 
    {"point_multiple", "int32", "积分倍率"}, 
    {"difficulty", "int8", "通关难度"},
}
 
--- *s2c* 历史信息 19865
SC_SEABED_HISTORY_INFO =
{
    19865, 
    {"history_info", pt_seabed_history_info, "历史数据信息"},
}
 
--- *c2s* 购买商品 19866
CS_SEABED_BUY_GOODS =
{
    19866, 
    {"goods_id", "int32", "商品id"},
}
 
--- *s2c* 购买商品 19867
SC_SEABED_BUY_GOODS =
{
    19867, 
    {"goods_id", "int32", "商品id"}, 
    {"result", "int8", "返回结果"},
}
 
--- *c2s* 离开商店 19868
CS_SEABED_LEAVE_SHOP =
{
    19868,
}
 
--- *c2s* 解锁天赋 19869
CS_SEABED_UNLOCK_TALENT =
{
    19869, 
    {"talent_id", "int16", "天赋id"},
}
 
--- *s2c* 解锁天赋结果 19870
SC_SEABED_UNLOCK_TALENT =
{
    19870, 
    {"talent_id", "int16", "天赋id"}, 
    {"result", "int8", "结果0-失败,1-成功"},
}
 
--- *s2c* 天赋面板信息 19871
SC_SEABED_TALENT_INFO =
{
    19871, 
    {"talent_info", pt_seabed_talent_info, "天赋信息"}, 
    {"talent_attr", pt_attr, "天赋属性", "repeated"},
}
 
--- *s2c* 更新天赋点数 19872
SC_SEABED_UPDATE_TALENT_POINT =
{
    19872, 
    {"talent_point", "int16", "天赋点数"},
}
 
--- *s2c* 任务信息面板 19873
SC_SEABED_TASK_INFO =
{
    19873, 
    {"task_info", pt_task_info_base, "任务内容", "repeated"},
}
 
--- *s2c* 更新任务进度 19874
SC_UPDATE_SEABED_TASK_INFO =
{
    19874, 
    {"task_info", pt_task_info_base, "任务内容"},
}
 
--- *c2s* 领取任务奖励 19875
CS_SEABED_TASK_REWARD =
{
    19875, 
    {"task_ids", "int32", "任务id", "repeated"},
}
 
--- *s2c* 领取任务奖励 19876
SC_SEABED_TASK_REWARD =
{
    19876, 
    {"result", "int8", "0-失败,1-成功"}, 
    {"task_ids", "int32", "任务id", "repeated"},
}
 
--- *s2c* 已解锁剧情对话 19877
SC_SEABED_STORY_LIST =
{
    19877, 
    {"story_list", "int32", "对话id列表", "repeated"},
}
 
--- *c2s* 收藏品奖励 19878
CS_SEABED_GAIN_COLLAGE_OR_BUFF_REWARD =
{
    19878, 
    {"id", "int16", "奖励id"},
}
 
--- *s2c* 收藏品奖励结果返回 19879
SC_SEABED_GAIN_COLLAGE_OR_BUFF_REWARD =
{
    19879, 
    {"id", "int16", "奖励id"}, 
    {"result", "int8", "返回结果"},
}
 
--- *c2s* 陈列室奖励 19880
CS_SEABED_GAIN_SHOWROOM_REWARD =
{
    19880, 
    {"id", "int16", "奖励id"},
}
 
--- *s2c* 陈列室奖励结果返回 19881
SC_SEABED_GAIN_SHOWROOM_REWARD =
{
    19881, 
    {"id", "int16", "奖励id"}, 
    {"result", "int8", "返回结果"},
}
 
--- *c2s* 排行榜数据 19882
CS_SEABED_RANK_PANEL =
{
    19882,
}
 
--- *s2c* 排行榜返回 19883
SC_SEABED_RANK_PANEL =
{
    19883, 
    {"rank_id", "int16", "排行榜类型"}, 
    {"my_rank", "int32", "我的排名"}, 
    {"my_rank_val", "int32", "我的排行值"}, 
    {"rank_list", pt_rank_info, "排行榜列表", "repeated"},
}
