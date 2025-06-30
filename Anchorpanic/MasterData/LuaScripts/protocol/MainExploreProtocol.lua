-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    22     
-- @Name:  main_explore   
-- @Desc:  锚点迷宫协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *c2s* 进入地图 22001
CS_ENTER_MAP =
{
    22001, 
    {"map_id", "int16", "地图id"},
}
 
--- *s2c* 进入地图返回 22002
SC_ENTER_MAP =
{
    22002, 
    {"result", "int8", "成功-1,失败-0"}, 
    {"map_id", "int16", "地图id"},
}
 
--- *c2s* 离开地图 22003
CS_LEAVE_MAP =
{
    22003,
}
 
--- *s2c* 离开地图返回 22004
SC_LEAVE_MAP =
{
    22004, 
    {"map_id", "int16", "地图id"},
}
 
--- *s2c* 地图信息 22005
SC_MAP_INFO =
{
    22005, 
    {"map_id", "int16", "地图id"}, 
    {"hero_tid", "int32", "操控的战员tid"}, 
    {"pos", pt_pos_z, "坐标"}, 
    {"now_event_list", pt_main_explore_event, "当前地图的事件列表", "repeated"}, 
    {"finish_event_list", pt_main_explore_event, "已完成的事件列表", "repeated"}, 
    {"buff_ids", "int16", "已获得的buff id列表", "repeated"}, 
    {"hero_list", pt_main_explore_hero, "战员信息（血量数据 等）", "repeated"}, 
    {"guide_event_id", "int32", "进行中的引导事件id"}, 
    {"return_effect_list", pt_main_explore_return_map_effect, "返回地图的效果表现数据列表", "repeated"}, 
    {"first_introduce_ids", "int16", "已完成的事件初始介绍id列表", "repeated"},
}
 
--- *c2s* 同步坐标 22006
CS_SYNC_POS_Z =
{
    22006, 
    {"pos", pt_pos_z, "坐标"},
}
 
--- *c2s* 触发事件 22007
CS_TRIGGER_EVENT =
{
    22007, 
    {"event_id", "int32", "事件id"}, 
    {"args_int", "int32", "参数int类型（如：战斗事件先手后手）", "repeated"},
}
 
--- *s2c* 触发事件返回 22008
SC_TRIGGER_EVENT =
{
    22008, 
    {"result", "int8", "成功-1,失败-0"}, 
    {"map_id", "int16", "地图id"}, 
    {"trigger_event_id", "int32", "触发的事件id"}, 
    {"add_event_list", pt_main_explore_event, "触发事件后新增的事件列表", "repeated"}, 
    {"del_event_ids", "int32", "触发事件后删除的事件id列表（不包括被触发的事件）", "repeated"}, 
    {"update_event_list", pt_main_explore_event, "更新的事件列表（更新动态效果参数）", "repeated"}, 
    {"award_list", pt_prop_award, "获得的奖励", "repeated"}, 
    {"other_args", "int32", "额外参数int类型", "repeated"},
}
 
--- *s2c* 通关地图 22010
SC_PASS_MAP =
{
    22010, 
    {"map_id", "int16", "地图id"}, 
    {"award_list", pt_prop_award, "奖励道具列表", "repeated"},
}
 
--- *c2s* 重置地图 22011
CS_RESET_MAP =
{
    22011, 
    {"map_id", "int16", "地图id"},
}
 
--- *s2c* 重置地图返回 22012
SC_RESET_MAP =
{
    22012, 
    {"result", "int8", "成功-1,失败-0"},
}
 
--- *c2s* 切换操作的战员 22013
CS_CHANGE_CONTROL_HERO =
{
    22013, 
    {"hero_id", "int32", "战员id"},
}
 
--- *s2c* 切换操作的战员 22014
SC_CHANGE_CONTROL_HERO =
{
    22014, 
    {"result", "int8", "成功-1,失败-0"}, 
    {"map_id", "int16", "地图id"}, 
    {"hero_tid", "int32", "战员tid"},
}
 
--- *s2c* 战斗成功推送物资数据供玩家选择 22015
SC_BATTLE_AFTER_BUFF =
{
    22015, 
    {"buff_id_list", "int16", "buff列表", "repeated"},
}
 
--- *c2s* 战斗成功选择物资 22016
CS_SELECT_BUFF =
{
    22016, 
    {"buff_id", "int16", "buff id"},
}
 
--- *s2c* 战斗成功选择物资返回 22017
SC_SELECT_BUFF =
{
    22017, 
    {"result", "int8", "成功-1,失败-0"}, 
    {"map_id", "int16", "地图id"}, 
    {"buff_id", "int16", "新获得的buff id"},
}
 
--- *s2c* 战员信息推送 22018
SC_HERO_INFO =
{
    22018, 
    {"map_id", "int16", "地图id"}, 
    {"hero_list", pt_main_explore_hero, "战员信息（血量数据 等）", "repeated"},
}
 
--- *s2c* 进行的引导推送 22019
SC_GUIDE_EVENT =
{
    22019, 
    {"map_id", "int16", "地图id"}, 
    {"guide_event_id", "int32", "进行中的引导事件id"},
}
 
--- *c2s* 触发初次介绍 22020
CS_TRIGGER_FIRST_INTRODUCE =
{
    22020, 
    {"introduce_id", "int16", "介绍id"},
}
 
--- *s2c* 触发初次介绍返回 22021
SC_TRIGGER_FIRST_INTRODUCE =
{
    22021, 
    {"result", "int8", "成功-1,失败-0"}, 
    {"map_id", "int16", "地图id"}, 
    {"introduce_id", "int16", "介绍id"},
}
