-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    20     
-- @Name:  battle   
-- @Desc:  战斗协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *c2s* 战场进入请求 20100
CS_BATTLE_FIELD_ENTER =
{
    20100, 
    {"battle_type", "int8", "战斗类型"}, 
    {"battle_field_id", "int64str", "战场id"}, 
    {"multi_times", "int16", "倍数"}, 
    {"assault_type", "int8", "偷袭类型"},
}
 
--- *s2c* 战场信息 20101
SC_BATTLE_FIELD_INFO =
{
    20101, 
    {"battle_type", "int8", "战斗类型"}, 
    {"battle_field_id", "int64str", "战场id"}, 
    {"att_info", pt_battle_player, "进攻方信息"}, 
    {"def_info", pt_battle_player, "防守方信息"}, 
    {"hero_order", pt_attr_int, "双方出手顺序", "repeated"}, 
    {"max_round", "int8", "最大回合数"}, 
    {"is_auto", "int8", "是否自动战斗,1:是,0:否"}, 
    {"is_replay", "int8", "是否回放,1:是,0:否"}, 
    {"sync_word", "int32", "同步码"}, 
    {"scene_skill_id_list", "int32", "场景效果技能列表", "repeated"}, 
    {"enter_result", "int8", "进入战场是否成功 1：是 0：否"}, 
    {"forces_skill_list", "int32", "肉鸽技能解锁列表", "repeated"}, 
    {"forces_skill_energy", "int16", "肉鸽技能能量"},
}
 
--- *c2s* 战斗开始请求 20102
CS_BATTLE_START =
{
    20102,
}
 
--- *s2c* 战斗行动 20103
SC_BATTLE_ACTION =
{
    20103, 
    {"side", "int8", "行动方类型"}, 
    {"hero_id", "int32", "行动战员id"}, 
    {"skill_id", "int32", "技能id"}, 
    {"target_side", "int8", "主要目标势力"}, 
    {"target_id", "int32", "主要目标战员id"}, 
    {"target_list", pt_battle_effect_hero, "技能目标列表", "repeated"}, 
    {"is_extra_skill", "int8", "是否额外技能"}, 
    {"skill_soul", "int16", "魂玉数"}, 
    {"rage", "int16", "怒气值"}, 
    {"hero_list", pt_battle_effect_hero, "分支前影响列表", "repeated"}, 
    {"result_list", pt_battle_action_result, "行动结果列表", "repeated"}, 
    {"sync_word", "int32", "同步码"},
}
 
--- *c2s* 战斗播放结束 20104
CS_BATTLE_VIDEO_END =
{
    20104, 
    {"sync_word", "int32", "同步码"},
}
 
--- *s2c* 行动结束 20105
SC_BATTLE_ACTION_END =
{
    20105, 
    {"curl_order", pt_attr_int, "当前回合双方出手顺序", "repeated"}, 
    {"next_order", pt_attr_int, "下回合双方出手顺序", "repeated"}, 
    {"del_buff", pt_battle_del_buff, "回合结束移除buff列表", "repeated"}, 
    {"round", "int8", "当前回合数"}, 
    {"sync_word", "int32", "同步码"},
}
 
--- *s2c* 整场战斗结束 20106
SC_BATTLE_RESULT =
{
    20106, 
    {"result", "int8", "战斗结果（0:无效的战斗,1:胜利,2:失败）"}, 
    {"award", pt_prop_award, "战斗奖励", "repeated"}, 
    {"detail_item_award", pt_prop_bag_detail, "战斗奖励详细类", "repeated"}, 
    {"player_exp", "int32", "玩家经验"}, 
    {"hero_exp", "int32", "战员经验"}, 
    {"hero_relation", "int32", "每个战员加的亲密度"}, 
    {"args", "int64str", "预留参数", "repeated"}, 
    {"hero_id_list", pt_attr_int, "战员id列表 key => 战员/敌物id, value => 来源", "repeated"}, 
    {"round", "int8", "当前回合数"}, 
    {"statistic", pt_battle_statistic, "战斗统计信息", "repeated"}, 
    {"pos_effect", "int32", "战场环境", "repeated"}, 
    {"is_replay", "int8", "是否回放"},
}
 
--- *c2s* 退出战斗 20107
CS_BATTLE_QUIT =
{
    20107,
}
 
--- *c2s* 使用技能 20108
CS_BATTLE_USE_SKILL =
{
    20108, 
    {"skill_id", "int32", "技能id"},
}
 
--- *c2s* 战斗跳过 20109
CS_BATTLE_SKIP =
{
    20109,
}
 
--- *c2s* 战斗回放 20110
CS_BATTLE_REPLAY =
{
    20110, 
    {"type", "int32", "战斗类型"}, 
    {"id", "int32", "回放ID"}, 
    {"team_id", "int8", "队伍ID"},
}
 
--- *s2c* 战斗回放信息 20111
SC_BATTLE_REPLAY_INFOS =
{
    20111, 
    {"replay_list", pt_battle_replay_info, "信息列表", "repeated"},
}
 
--- *s2c* 战斗回放信息更新 20112
SC_BATTLE_REPLAY_UPDATE =
{
    20112, 
    {"type", "int32", "战斗类型"}, 
    {"update_list", pt_battle_replay_detail, "更新,添加列表", "repeated"}, 
    {"del_list", "int32", "删除列表", "repeated"},
}
 
--- *c2s* 自动战斗 20113
CS_BATTLE_AUTO =
{
    20113, 
    {"is_auto", "int8", "是否自动战斗,1:是,0:否"},
}
 
--- *s2c* 自动战斗返回 20114
SC_BATTLE_AUTO =
{
    20114, 
    {"is_auto", "int8", "是否自动战斗,1:是,0:否"},
}
 
--- *s2c* 使用技能返回 20115
SC_BATTLE_USE_SKILL =
{
    20115, 
    {"hero_id", "int32", "战员id"}, 
    {"skill_id", "int32", "技能id"}, 
    {"result", "int8", "结果,1:成功,其他:失败"}, 
    {"skill_soul", "int16", "魂玉数(只有成功才赋值)"}, 
    {"rage", "int16", "怒气值(只有成功才赋值)"}, 
    {"sync_word", "int32", "同步码"},
}
 
--- *s2c* 无战斗状态通知 20116
SC_BATTLE_NONE =
{
    20116,
}
 
--- *s2c* 战斗新波数 20117
SC_BATTLE_NEW_WAVE =
{
    20117, 
    {"def_info", pt_battle_player, "防守方信息"}, 
    {"sync_word", "int32", "同步码"},
}
 
--- *s2c* 战斗中角色加入 20118
SC_BATTLE_HERO_CHANGE =
{
    20118, 
    {"side", "int8", "目标战员势力"}, 
    {"hero_list", pt_battle_hero, "新加入的战员列表", "repeated"}, 
    {"story_id", "int16", "剧情ID"}, 
    {"talk_id", "int16", "对话ID"}, 
    {"sync_word", "int32", "同步码"},
}
 
--- *s2c* 战斗回放请求返回 20119
SC_BATTLE_REPLAY =
{
    20119, 
    {"result", "int8", "错误码"},
}
 
--- *c2s* 战斗同步请求 20120
CS_BATTLE_SYNC =
{
    20120, 
    {"sync_word", "int32", "同步码"},
}
 
--- *c2s* 战斗请求使用盟约技能 20121
CS_BATTLE_FORCES_SKILL =
{
    20121, 
    {"skill_id", "int32", "技能id"},
}
 
--- *s2c* 盟约技能能量更新 20122
SC_BATTLE_FORCES_SKILL_ENERGY =
{
    20122, 
    {"energy", "int16", "盟约技能能量"}, 
    {"sync_word", "int32", "同步码"},
}
 
--- *c2s* 战斗回放统计数据 20123
CS_BATTLE_REPLAY_STATISTIC =
{
    20123, 
    {"type", "int32", "战斗类型"}, 
    {"id", "int32", "回放ID"},
}
 
--- *s2c* 战斗回放统计数据 20124
SC_BATTLE_REPLAY_STATISTIC =
{
    20124, 
    {"result", "int8", "攻方战斗结果,1获胜2失败"}, 
    {"statistic", pt_battle_statistic, "战斗统计信息", "repeated"},
}
 
--- *s2c* 战斗效果通知 20125
SC_BATTLE_ACTION_NOTICE =
{
    20125, 
    {"hero_list", pt_battle_effect_hero, "影响列表", "repeated"}, 
    {"sync_word", "int32", "同步码"},
}
 
--- *s2c* 战斗行动顺序更新 20126
SC_BATTLE_ORDER =
{
    20126, 
    {"curl_order", pt_attr_int, "当前回合双方出手顺序", "repeated"}, 
    {"next_order", pt_attr_int, "下回合双方出手顺序", "repeated"}, 
    {"sync_word", "int32", "同步码"},
}
 
--- *c2s* 战员自动战斗规则更换 20127
CS_HERO_AUTO_RULE_CHANGE =
{
    20127, 
    {"hero_id", "int32", "战员ID"}, 
    {"rule_type", "int8", "自动战斗规则(0-顺序使用，2-优先使用1技能，3-优先使用2技能)"},
}
 
--- *s2c* 战员自动战斗规则更换返回 20128
SC_HERO_AUTO_RULE_CHANGE =
{
    20128, 
    {"hero_id", "int32", "战员ID"}, 
    {"rule_type", "int8", "自动战斗规则"}, 
    {"result", "int8", "错误码"},
}
 
--- *s2c* 战斗中行动队列修改 20129
SC_BATTLE_ORDER_CHANGE =
{
    20129, 
    {"hero_side", "int8", "战员阵型"}, 
    {"hero_id", "int32", "战员ID"}, 
    {"hero_tid", "int32", "战员tid"}, 
    {"hero_type", "int8", "战员类型"},
}
 
--- *s2c* 进入战斗失败 20130
SC_BATTLE_ENTER_FAIL =
{
    20130,
}
 
--- *s2c* 多队伍的战斗回放统计数据 20131
SC_MULTI_TEAM_REPLAY_STATISTIC =
{
    20131, 
    {"statistic", pt_team_battle_statistic, "队伍战斗统计信息", "repeated"},
}
 
--- *c2s* 战斗外跳过 20140
CS_BATTLE_OUTSIDE_SKIP =
{
    20140, 
    {"battle_type", "int8", "战斗类型"}, 
    {"battle_field_id", "int64str", "战场id"},
}
 
--- *s2c* 战斗外跳过结果 20141
SC_BATTLE_OUTSIDE_SKIP_RESULT =
{
    20141, 
    {"result", "int8", "战斗结果（0:无效的战斗,1:胜利,2:失败）"}, 
    {"award", pt_prop_award, "战斗奖励", "repeated"}, 
    {"detail_item_award", pt_prop_bag_detail, "战斗奖励详细类", "repeated"}, 
    {"player_exp", "int32", "玩家经验"}, 
    {"hero_exp", "int32", "战员经验"}, 
    {"hero_relation", "int32", "每个战员加的亲密度"}, 
    {"args", "int32", "预留参数", "repeated"}, 
    {"hero_id_list", pt_attr_int, "战员id列表 key => 战员/敌物id, value => 来源", "repeated"}, 
    {"round", "int8", "当前回合数"}, 
    {"statistic", pt_battle_statistic, "战斗统计信息", "repeated"}, 
    {"pos_effect", "int32", "战场环境", "repeated"}, 
    {"is_replay", "int8", "是否回放"},
}
 
--- *c2s* 战斗外跳过结果重新确认 20142
CS_BATTLE_OUTSIDE_SKIP_RECHECK =
{
    20142, 
    {"battle_type", "int8", "战斗类型"},
}
 
--- *s2c* 战斗外跳过结果重新确认 20143
SC_BATTLE_OUTSIDE_SKIP_RECHECK =
{
    20143, 
    {"result", "int8", "结果 0:没有跳过结果"},
}
