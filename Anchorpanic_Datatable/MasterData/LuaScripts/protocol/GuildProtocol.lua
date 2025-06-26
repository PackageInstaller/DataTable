-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    23     
-- @Name:  guild   
-- @Desc:  公会协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *c2s* 公会面板信息 23001
CS_GUILD_PANEL =
{
    23001,
}
 
--- *s2c* 公会面板信息 23002
SC_GUILD_PANEL =
{
    23002, 
    {"guild_info", pt_guild_detail_info, "公会信息"}, 
    {"leave_time", "int32", "离开公会时间戳"},
}
 
--- *c2s* 创建公会 23003
CS_CREATE_GUILD =
{
    23003, 
    {"name", "string", "公会名字"}, 
    {"notice", "string", "公会公告"}, 
    {"icon_id", "int16", "图标id"},
}
 
--- *s2c* 创建公会 23004
SC_CREATE_GUILD =
{
    23004, 
    {"guild_info", pt_guild_detail_info, "公会信息"}, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 申请公会 23005
CS_APPLY_GUILD =
{
    23005, 
    {"uid", "int64str", "公会唯一id"},
}
 
--- *c2s* 刷新推荐公会 23007
CS_REFRESH_RECOMMEND_GUILDS =
{
    23007, 
    {"uid", "string", "公会唯一id"}, 
    {"is_refresh_all", "int8", "是否刷新全部"},
}
 
--- *s2c* 刷新公会列表 23008
SC_REFRESH_RECOMMEND_GUILDS =
{
    23008, 
    {"guild_list", pt_guild_detail_info, "公会信息", "repeated"}, 
    {"result", "int8", "结果:0-失败,1-成功,2-等级不满足,3-禁止加入,4-满员"}, 
    {"uid", "int64str", "公会唯一id"},
}
 
--- *c2s* 修改公会名字 23009
CS_GUILD_RENAME =
{
    23009, 
    {"name", "string", "公会名字"},
}
 
--- *s2c* 修改公会名字 23010
SC_GUILD_RENAME =
{
    23010, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 修改公会公告 23011
CS_GUILD_RENOTICE =
{
    23011, 
    {"notice", "string", "公会公告"},
}
 
--- *s2c* 修改公会名字 23012
SC_GUILD_RENOTICE =
{
    23012, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 同意申请 23013
CS_AGREE_APPLY =
{
    23013, 
    {"apply_player_id", "int64str", "申请人id"},
}
 
--- *s2c* 同意申请结果返回 23014
SC_AGREE_APPLY =
{
    23014, 
    {"guild_info", pt_guild_detail_info, "公会信息"}, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 拒绝申请 23015
CS_REJECT_APPLY =
{
    23015, 
    {"apply_player_id", "int64str", "申请人id"},
}
 
--- *s2c* 拒绝申请 23016
SC_REJECT_APPLY =
{
    23016, 
    {"guild_info", pt_guild_detail_info, "公会信息"}, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 移除成员 23017
CS_REMOVE_MEMBER =
{
    23017, 
    {"member_player_id", "int64str", "申请人id"},
}
 
--- *s2c* 移除成员 23018
SC_REMOVE_MEMBER =
{
    23018, 
    {"guild_info", pt_guild_detail_info, "公会信息"}, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 转让会长 23019
CS_TRANSFER_LEADER =
{
    23019, 
    {"transfer_player_id", "int64str", "申请人id"},
}
 
--- *s2c* 转让会长 23020
SC_TRANSFER_LEADER =
{
    23020, 
    {"guild_info", pt_guild_detail_info, "公会信息"}, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 离开公会 23021
CS_LEAVE_GUILD =
{
    23021,
}
 
--- *s2c* 离开公会 23022
SC_LEAVE_GUILD =
{
    23022, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 设置申请条件 23023
CS_SET_APPLY_COND =
{
    23023, 
    {"apply_type", "int8", "公会申请设置类型1-无需审批|2-需要审批|3-禁止加入"}, 
    {"player_lv", "int16", "玩家等级"},
}
 
--- *s2c* 设置申请条件 23024
SC_SET_APPLY_COND =
{
    23024, 
    {"guild_info", pt_guild_detail_info, "公会信息"}, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *s2c* 公会奖励面板信息 23025
SC_AWARD_PANEL =
{
    23025, 
    {"award_panel", pt_guild_award_panel, "奖励面板信息"},
}
 
--- *c2s* 签到筹备 23026
CS_DO_PREPARE =
{
    23026, 
    {"prepare_type", "int8", "1-普通|2-紧急"},
}
 
--- *s2c* 签到筹备 23027
SC_DO_PREPARE =
{
    23027, 
    {"result", "int8", "结果:1-成功|0-失败"}, 
    {"guild_info", pt_guild_detail_info, "公会信息"},
}
 
--- *c2s* 领取签到奖励 23028
CS_GAIN_PREPARE_AWARD =
{
    23028, 
    {"id", "int16", "领取id"},
}
 
--- *s2c* 签到筹备 23029
SC_GAIN_PREPARE_AWARD =
{
    23029, 
    {"result", "int8", "结果:1-成功|0-失败"}, 
    {"id", "int16", "领取id"},
}
 
--- *c2s* 开启签到奖励 23030
CS_OPEN_SUPPLY =
{
    23030,
}
 
--- *s2c* 开启签到奖励 23031
SC_OPEN_SUPPLY =
{
    23031, 
    {"result", "int8", "结果:1-成功|0-失败"}, 
    {"guild_info", pt_guild_detail_info, "公会信息"},
}
 
--- *c2s* 领取补给奖励 23032
CS_GAIN_SUPPLY =
{
    23032,
}
 
--- *s2c* 领取补给奖励 23033
SC_GAIN_SUPPLY =
{
    23033, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *s2c* 科技面板 23035
SC_SCIENCE_PANEL =
{
    23035, 
    {"science_info_list", pt_guild_science_info, "科技面板数据", "repeated"},
}
 
--- *c2s* 升级科技 23036
CS_UPGRADE_SCIENCE =
{
    23036, 
    {"id", "int16", "升级科技id"},
}
 
--- *s2c* 升级科技结果返回 23037
SC_UPGRADE_SCIENCE =
{
    23037, 
    {"result", "int8", "结果:1-成功|0-失败"}, 
    {"science_info", pt_guild_science_info, "科技更新数据"},
}
 
--- *c2s* 弹劾会长 23038
CS_IMPEACH_LEADER =
{
    23038,
}
 
--- *s2c* 更新弹劾状态 23039
SC_IMPEACH_LEADER =
{
    23039, 
    {"result", "int8", "是否弹劾成功 1-是|0-否"}, 
    {"leader_impeach_time", "int32", "弹劾时间戳"},
}
 
--- *c2s* 任命职位 23040
CS_COMMISSION_JOB =
{
    23040, 
    {"member_player_id", "int64str", "成员id"}, 
    {"job", "int8", "0-普通会员|2-副会长"},
}
 
--- *s2c* 任命职位结果返回 23041
SC_COMMISSION_JOB =
{
    23041, 
    {"result", "int8", "结果:1-成功|0-失败"}, 
    {"member_info", pt_member_info, "成员信息"},
}
 
--- *c2s* 领取昨日签到奖励 23042
CS_GAIN_OLD_PREPARE_AWARD =
{
    23042,
}
 
--- *s2c* 领取昨日签到奖励结果 23043
SC_GAIN_OLD_PREPARE_AWARD =
{
    23043, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 展示人员情报 23044
CS_GUILD_WAR_DEF_FORMATION =
{
    23044, 
    {"player_id", "int64str", "玩家id"},
}
 
--- *s2c* 展示人员情报 23045
SC_GUILD_WAR_DEF_FORMATION =
{
    23045, 
    {"player_id", "int64str", "玩家id"}, 
    {"def_formation", pt_guild_war_def_formation, "防守阵型展示", "repeated"},
}
 
--- *c2s* 联盟团战报名 23046
CS_GUILD_WAR_SIGN_UP =
{
    23046, 
    {"sign_up_info", pt_guild_war_sign_up_info, "报名信息", "repeated"},
}
 
--- *s2c* 联盟团战报名 23047
SC_GUILD_WAR_SIGN_UP =
{
    23047, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 联盟历史排行榜 23048
CS_GUILD_WAR_HISTORY_RANK =
{
    23048, 
    {"season_id", "int16", "赛季id"},
}
 
--- *s2c* 联盟历史排行榜 23049
SC_GUILD_WAR_RANK =
{
    23049, 
    {"my_rank", "int16", "排名"}, 
    {"my_point", "int32", "分数"}, 
    {"guild_name", "string", "公会名"}, 
    {"rank_list", pt_guild_war_rank, "排名信息", "repeated"}, 
    {"leader_name", "string", "会长名"},
}
 
--- *c2s* 联盟团战日志 23050
CS_GUILD_WAR_DAY_LOG =
{
    23050, 
    {"page", "int16", "[起始条数，结束条数]", "repeated"},
}
 
--- *s2c* 联盟团战日志 23051
SC_GUILD_WAR_DAY_LOG =
{
    23051, 
    {"log_list", pt_guild_war_day_log, "日志", "repeated"}, 
    {"log_num", "int16", "日志总数量"},
}
 
--- *c2s* 联盟团战玩家日志 23052
CS_GUILD_WAR_BATTLE_LOG =
{
    23052, 
    {"build_id", "int16", "建筑id,0-发送全部"}, 
    {"page", "int16", "[起始条数，结束条数]", "repeated"}, 
    {"is_atk", "int8", "2-发全部,1-进攻,0-防守"},
}
 
--- *s2c* 联盟团战玩家日志 23053
SC_GUILD_WAR_BATTLE_LOG =
{
    23053, 
    {"log_list", pt_guild_war_battle_log, "战斗日志", "repeated"}, 
    {"log_num", "int16", "日志总数量"},
}
 
--- *s2c* 赛季信息 23054
SC_GUILD_WAR_SEASON_INFO =
{
    23054, 
    {"season_info", pt_guild_war_season_info, "赛季信息"}, 
    {"sync_def_formation_state", "int8", "同步防守阵型状态0-同步,1-不同步"},
}
 
--- *c2s* 敌人公会面板信息 23056
CS_ENEMY_GUILD_PANEL =
{
    23056,
}
 
--- *s2c* 敌人公会面板信息 23057
SC_ENEMY_GUILD_PANEL =
{
    23057, 
    {"guild_info", pt_guild_detail_info, "公会信息"},
}
 
--- *c2s* 正在被挑战的建筑信息 23058
CS_GUILD_WAR_CHALLENGE_INFO =
{
    23058, 
    {"build_id", "int16", "建筑id"},
}
 
--- *s2c* 正在被挑战的建筑信息 23059
SC_GUILD_WAR_CHALLENGE_INFO =
{
    23059, 
    {"build_id", "int16", "建筑id"}, 
    {"result", "int8", "1-挑战中,0-否"},
}
 
--- *c2s* 切换防守阵型同步状态 23060
CS_GUILD_WAR_SWITCH_DEF_FORMATION_STATE =
{
    23060,
}
 
--- *s2c* 切换防守阵型同步状态结果 23061
SC_GUILD_WAR_SWITCH_DEF_FORMATION_STATE =
{
    23061, 
    {"result", "int8", "同步防守阵型状态0-同步,1-不同步"},
}
 
--- *c2s* 修改公会icon 23062
CS_GUILD_CHANGE_COIN =
{
    23062, 
    {"icon_id", "int16", "icon id"},
}
 
--- *s2c* 修改公会icon 23063
SC_GUILD_CHANGE_COIN =
{
    23063, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
 
--- *c2s* 切换防守阵型同步状态 23064
CS_GUILD_WAR_CURRENT_DAY_LOG =
{
    23064,
}
 
--- *s2c* 最近一次战斗日志 23065
SC_GUILD_WAR_CURRENT_DAY_LOG =
{
    23065, 
    {"log", pt_guild_war_day_log, "日志"}, 
    {"is_send_guild_war_battle_result", "int8", "结果:1-已发送|0-未发送"},
}
 
--- *c2s* 自动配置 23066
CS_GUILD_WAR_AUTO_SIGN_UP =
{
    23066,
}
 
--- *s2c* 自动配置 23067
SC_GUILD_WAR_AUTO_SIGN_UP =
{
    23067, 
    {"result", "int8", "结果:1-成功|0-失败"},
}
