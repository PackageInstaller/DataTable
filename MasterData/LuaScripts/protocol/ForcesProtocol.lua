-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    21     
-- @Name:  forces   
-- @Desc:  势力协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *s2c* 势力面板信息 21001
SC_FORCES_PANEL =
{
    21001, 
    {"forces_id", "int8", "势力id(0为没参加势力)"}, 
    {"prestige_stage", "int16", "声望等阶"}, 
    {"prestige_exp", "int32", "声望经验"}, 
    {"remain_talent_point", "int16", "剩余天赋点数"},
}
 
--- *c2s* 提升声望等级 21002
CS_UPGRADE_PRESTIGE =
{
    21002,
}
 
--- *s2c* 提升声望等级 21003
SC_UPGRADE_PRESTIGE =
{
    21003, 
    {"result", "int8", "升级结果:0-失败，1-成功"},
}
 
--- *s2c* 研究所面板信息 21021
SC_INSTITUTE_PANEL =
{
    21021, 
    {"lv", "int16", "等级"}, 
    {"cur_lv_attr_list", pt_attr, "当前等级属性列表", "repeated"}, 
    {"next_lv_attr_list", pt_attr, "下一等级属性列表", "repeated"},
}
 
--- *c2s* 研究所升级 21022
CS_INSTITUTE_UPGRADE =
{
    21022,
}
 
--- *s2c* 研究所升级 21023
SC_INSTITUTE_UPGRADE =
{
    21023, 
    {"result", "int8", "升级结果:0-失败，1-成功"},
}
 
--- *c2s* 请求区域探险面板信息 21030
CS_AREA_EXPLORE_PANEL_INFO =
{
    21030,
}
 
--- *s2c* 区域探险面板信息 21031
SC_AREA_EXPLORE_PANEL_INFO =
{
    21031, 
    {"area_list", pt_area_explore_info, "区域信息列表", "repeated"},
}
 
--- *c2s* 开始区域探险 21032
CS_START_AREA_EXPLORE =
{
    21032, 
    {"area_id", "int32", "区域id"}, 
    {"hero_id_list", "int32", "战员列表", "repeated"},
}
 
--- *s2c* 开始区域探险结果返回 21033
SC_START_AREA_EXPLORE_RESULT =
{
    21033, 
    {"area_id", "int32", "区域id"}, 
    {"result", "int8", "结果1-成功，其他-失败原因"},
}
 
--- *c2s* 取消区域探险 21034
CS_CANCEL_AREA_EXPLORE =
{
    21034, 
    {"area_id", "int32", "区域id"},
}
 
--- *s2c* 取消区域探险结果返回 21035
SC_CANCEL_AREA_EXPLORE_RESULT =
{
    21035, 
    {"area_id", "int32", "区域id"}, 
    {"result", "int8", "结果1-成功，其他-失败原因"},
}
 
--- *c2s* 加速区域探险 21036
CS_SPEED_UP_AREA_EXPLORE =
{
    21036, 
    {"area_id", "int32", "区域id"},
}
 
--- *s2c* 加速区域探险结果返回 21037
SC_SPEED_UP_AREA_EXPLORE_RESULT =
{
    21037, 
    {"area_id", "int32", "区域id"}, 
    {"result", "int8", "结果1-成功，其他-失败原因"},
}
 
--- *c2s* 领取区域探险奖励 21038
CS_GAIN_AREA_EXPLORE_AWARD =
{
    21038, 
    {"area_id", "int32", "区域id"},
}
 
--- *s2c* 领取区域探险奖励 21039
SC_GAIN_AREA_EXPLORE_AWARD_RESULT =
{
    21039, 
    {"area_id", "int32", "区域id"}, 
    {"result", "int8", "结果1-成功，其他-失败原因"},
}
 
--- *c2s* 刷新区域探索 21040
CS_REFRESH_AREA_EVENT =
{
    21040, 
    {"area_id", "int32", "区域id"},
}
 
--- *s2c* 刷新区域探索信息 21041
SC_UPDATE_AREA_INFO =
{
    21041, 
    {"area_info", pt_area_explore_info, "区域信息"},
}
 
--- *c2s* 加工序列物 21050
CS_PROCESS_DEVICE =
{
    21050, 
    {"process_id", "int8", "加工厂id"}, 
    {"item_id_list", "int32", "道具id列表", "repeated"},
}
 
--- *s2c* 加工序列物 21051
SC_PROCESS_DEVICE =
{
    21051, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *s2c* 天赋面板信息 21060
SC_TALENT_PANEL =
{
    21060, 
    {"forces_talent_info", pt_forces_talent_info, "天赋信息", "repeated"},
}
 
--- *s2c* 天赋更新信息 21061
SC_UPDATE_TALENT =
{
    21061, 
    {"forces_talent_info", pt_forces_talent_info, "天赋信息", "repeated"},
}
 
--- *c2s* 升级天赋 21062
CS_UPGRADE_TALENT =
{
    21062, 
    {"talent_id", "int16", "天赋id"},
}
 
--- *s2c* 升级天赋结果 21063
SC_UPGRADE_TALENT_RESULT =
{
    21063, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *s2c* 任务信息面板 21070
SC_FORCES_TASK_PANEL_INFO =
{
    21070, 
    {"task_info", pt_task_info_base, "任务内容", "repeated"},
}
 
--- *c2s* 请求领取任务奖励 21071
CS_GAIN_FORCES_TASK_AWARD =
{
    21071, 
    {"task_list", "int16", "任务id列表", "repeated"},
}
 
--- *s2c* 领取任务奖励 21072
SC_GAIN_FORCES_TASK_AWARD =
{
    21072, 
    {"task_list", "int16", "任务id列表", "repeated"}, 
    {"result", "int8", "领取结果，1成功0失败"},
}
 
--- *s2c* 更新任务进度 21073
SC_UPDATE_FORCES_TASK_INFO =
{
    21073, 
    {"task_info", pt_task_info_base, "任务内容"},
}
