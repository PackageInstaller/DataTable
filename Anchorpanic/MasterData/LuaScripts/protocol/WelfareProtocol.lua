-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    24     
-- @Name:  welfare   
-- @Desc:  福利协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *c2s* 请求任务信息面板 24001
CS_TASK_PANEL_INFO =
{
    24001,
}
 
--- *s2c* 任务信息面板 24002
SC_TASK_PANEL_INFO =
{
    24002, 
    {"total_score", "int32", "积分"}, 
    {"task_info", pt_task_info, "任务内容", "repeated"}, 
    {"score_info", pt_task_score_info, "任务积分内容", "repeated"},
}
 
--- *c2s* 请求领取任务奖励 24003
CS_GAIN_TASK_AWARD =
{
    24003, 
    {"task_id", "int16", "任务id"},
}
 
--- *s2c* 领取任务奖励 24004
SC_GAIN_TASK_AWARD =
{
    24004, 
    {"task_id", "int16", "任务id"}, 
    {"result", "int8", "领取结果，1成功0失败"},
}
 
--- *c2s* 请求领取积分奖励 24005
CS_GAIN_SCORE_AWARD =
{
    24005, 
    {"score_award_id", "int16", "积分奖励id"},
}
 
--- *s2c* 领取积分奖励 24006
SC_GAIN_SCORE_AWARD =
{
    24006, 
    {"score_award_id", "int16", "积分奖励id"}, 
    {"result", "int8", "领取结果，1成功0失败"},
}
 
--- *s2c* 更新任务进度 24007
SC_UPDATE_TASK_INFO =
{
    24007, 
    {"task_info", pt_task_info, "任务内容"},
}
 
--- *c2s* 请求领取全部奖励 24008
CS_GAIN_ALL_AWARD =
{
    24008, 
    {"type", "int8", "任务类型，1日常2周常"},
}
 
--- *s2c* 领取全部奖励 24009
SC_GAIN_ALL_AWARD =
{
    24009, 
    {"type", "int8", "任务类型，1日常2周常"}, 
    {"result", "int8", "领取结果，1成功0失败"}, 
    {"task_id", "int16", "任务id", "repeated"}, 
    {"score_award_id", "int16", "积分奖励id", "repeated"},
}
 
--- *s2c* 更新积分 24010
SC_UPDATE_TASK_SCORE =
{
    24010, 
    {"total_score", "int32", "当前积分"},
}
 
--- *c2s* 成就信息面板 24020
CS_ACHIEVEMENT_PANEL_INFO =
{
    24020,
}
 
--- *s2c* 成就信息面板 24021
SC_ACHIEVEMENT_PANEL_INFO =
{
    24021, 
    {"complete_achieve_info", pt_complete_achieve_info, "已完成成就信息", "repeated"}, 
    {"achievement_info", pt_achievement_info, "成就内容", "repeated"}, 
    {"point", "int32", "拥有的点数"}, 
    {"had_gain_stage_reward_list", "int32", "已领取的点数奖励id列表", "repeated"},
}
 
--- *c2s* 领取成就奖励 24022
CS_GAIN_ACHIEVEMENT_AWARD =
{
    24022, 
    {"achievement_id", "int32", "成就id"}, 
    {"stage", "int8", "成就阶段"},
}
 
--- *s2c* 返回领取成就奖励 24023
SC_GAIN_ACHIEVEMENT_AWARD =
{
    24023, 
    {"achievement_id", "int32", "成就id"}, 
    {"stage", "int8", "成就阶段"}, 
    {"point", "int32", "拥有的点数"}, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *s2c* 更新成就进度 24024
SC_UPDATE_ACHIEVEMENT_INFO =
{
    24024, 
    {"achievement_info", pt_achievement_info, "成就内容"},
}
 
--- *c2s* 成就奖励一键领取 24025
CS_GAIN_ACHIEVEMENT_ALL =
{
    24025, 
    {"type", "int16", "页签分类"},
}
 
--- *s2c* 成就奖励一键领取返回 24026
SC_GAIN_ACHIEVEMENT_ALL =
{
    24026, 
    {"result", "int8", "结果，1成功0失败"}, 
    {"type", "int16", "页签分类"}, 
    {"point", "int32", "拥有的点数"},
}
 
--- *s2c* 已完成成就信息 24027
SC_UPDATE_COMPLETE_ACHIEVE_INFO =
{
    24027, 
    {"complete_achieve_info", pt_complete_achieve_info, "已完成成就信息", "repeated"},
}
 
--- *c2s* 请求领取点数奖励 24028
CS_GAIN_ACHIEVEMENT_STAGE_AWARD =
{
    24028, 
    {"stage_award_id", "int16", "点数奖励id"},
}
 
--- *s2c* 领取点数奖励 24029
SC_GAIN_ACHIEVEMENT_STAGE_AWARD =
{
    24029, 
    {"stage_award_id", "int16", "点数奖励id"}, 
    {"result", "int8", "领取结果，1成功0失败"},
}
 
--- *c2s* 玩家使用激活码 24030
CS_USE_PLAYER_CODE =
{
    24030, 
    {"code", "string", "激活码"},
}
 
--- *s2c* 玩家使用激活码返回 24031
SC_USE_PLAYER_CODE =
{
    24031, 
    {"result", "int8", "1-成功，其他-错误"}, 
    {"award", pt_prop_award, "奖励", "repeated"},
}
 
--- *c2s* 签到面板 24032
CS_SIGN_PANEL =
{
    24032,
}
 
--- *s2c* 签到面板 24033
SC_SIGN_PANEL =
{
    24033, 
    {"sign_days", "int8", "已签到列表", "repeated"}, 
    {"today_is_sign", "int8", "今天是否已签到"}, 
    {"sign_award_list", pt_prop_award, "签到奖励", "repeated"}, 
    {"month_card_award_list", pt_prop_award, "月卡奖励", "repeated"}, 
    {"stamina_month_card_award_list", pt_prop_award, "月卡奖励", "repeated"},
}
 
--- *c2s* 每日签到 24034
CS_DAILY_SIGN =
{
    24034,
}
 
--- *s2c* 每日签到 24035
SC_DAILY_SIGN =
{
    24035, 
    {"result", "int8", "1-成功，0-失败"}, 
    {"sign_day", "int8", "签到天数"}, 
    {"award", pt_prop_award, "奖励", "repeated"},
}
 
--- *s2c* 新手目标信息面板 24041
SC_NOVICE_TARGET_PANEL_INFO =
{
    24041, 
    {"day", "int16", "当前开启任务第几天"}, 
    {"is_finish", "int8", "是否全部完成新手目标任务1是-0否"}, 
    {"task_info", pt_task_info, "任务内容", "repeated"},
}
 
--- *c2s* 请求领取新手目标奖励 24042
CS_GAIN_NOVICE_TARGET_AWARD =
{
    24042, 
    {"task_list", "int16", "任务id列表", "repeated"},
}
 
--- *s2c* 领取新手目标奖励 24043
SC_GAIN_NOVICE_TARGET_AWARD =
{
    24043, 
    {"task_list", "int16", "任务id列表", "repeated"}, 
    {"is_finish", "int8", "是否全部完成新手目标任务1是-0否"}, 
    {"result", "int8", "领取结果，1成功0失败"},
}
 
--- *s2c* 更新任务进度 24044
SC_UPDATE_NOVICE_TARGET_INFO =
{
    24044, 
    {"task_info", pt_task_info, "任务内容"},
}
 
--- *c2s* 提交调查文件 24050
CS_SUBMIT_QUESTIONNAIRE =
{
    24050, 
    {"announce_id", "int16", "公告id"},
}
 
--- *s2c* 提交调查文件 24051
SC_SUBMIT_QUESTIONNAIRE =
{
    24051, 
    {"result", "int8", "1-成功，0-失败"},
}
 
--- *c2s* 战斗补给抽奖 24054
CS_BATTLE_SUPPLY_DRAW =
{
    24054, 
    {"type", "int16", "类型"}, 
    {"times", "int16", "次数"},
}
 
--- *s2c* 战斗补给抽奖返回 24055
SC_BATTLE_SUPPLY_DRAW =
{
    24055, 
    {"type", "int16", "类型"}, 
    {"times", "int16", "次数"}, 
    {"award", pt_prop_award, "奖励列表", "repeated"},
}
 
--- *s2c* 金币祈愿面板信息 24060
SC_GOLD_WISH_PANEL_INFO =
{
    24060, 
    {"had_wish_times", "int16", "今日已经祈愿次数"}, 
    {"acc_wish_times", "int16", "累计祈愿次数"}, 
    {"state", "int8", "0-未开始1-祈愿中2-已完成未领取"}, 
    {"wish_end_time", "int32", "祈愿完成的目标时间戳"},
}
 
--- *c2s* 开启金币祈愿 24061
CS_START_GOLD_WISH =
{
    24061,
}
 
--- *c2s* 领取金币祈愿奖励 24062
CS_GAIN_GOLD_WISH_AWARD =
{
    24062,
}
 
--- *c2s* 领取七天奖励 24065
CS_GAIN_SEVEN_DAY_REWARD =
{
    24065, 
    {"day", "int16", "领取第几天"},
}
 
--- *s2c* 已领取奖励天数 24066
SC_SEVEN_DAY_PANEL_INFO =
{
    24066, 
    {"login_day", "int16", "登录天数"}, 
    {"seven_day_reward_list", "int16", "已领取奖励天数", "repeated"},
}
 
--- *c2s* 请求宿舍面板信息 24070
CS_DORMITORY_PANEL_INFO =
{
    24070,
}
 
--- *s2c* 宿舍面板信息返回 24071
SC_DORMITORY_PANEL_INFO =
{
    24071, 
    {"dormitory_list", pt_dormitory_info, "宿舍列表", "repeated"},
}
 
--- *c2s* 摆放家具 24072
CS_PUT_FURNITURE =
{
    24072, 
    {"dormitory_id", "int16", "宿舍id"}, 
    {"furniture_list", pt_furniture_move_info, "改动的家具", "repeated"},
}
 
--- *s2c* 摆放家具返回 24073
SC_PUT_FURNITURE =
{
    24073, 
    {"dormitory_id", "int16", "宿舍id"}, 
    {"result", "int8", "摆放结果1-成功"},
}
 
--- *c2s* 入驻战员 24074
CS_SETTLED_HERO =
{
    24074, 
    {"dormitory_id", "int16", "宿舍id"}, 
    {"hero_list", pt_settled_hero_info, "战员信息列表", "repeated"},
}
 
--- *s2c* 入驻战员 24075
SC_SETTLED_HERO =
{
    24075, 
    {"result", "int8", "入驻结果0-失败，1-成功"}, 
    {"hero_list", pt_settled_hero_info, "战员信息列表", "repeated"},
}
 
--- *c2s* 请求单个宿舍信息 24076
CS_DORMITORY_INFO =
{
    24076, 
    {"dormitory_id", "int16", "宿舍id"},
}
 
--- *s2c* 宿舍信息返回 24077
SC_DORMITORY_INFO =
{
    24077, 
    {"dormitory_info", pt_dormitory_info, "宿舍列表"},
}
 
--- *c2s* 每日体力补给面板 24090
CS_DAILY_STAMINA_PANEL =
{
    24090,
}
 
--- *s2c* 每日体力补给面板 24091
SC_DAILY_STAMINA_PANEL =
{
    24091, 
    {"reward_list", "int8", "本日已领取奖励列表", "repeated"},
}
 
--- *c2s* 获取每日体力补给 24092
CS_DAILY_STAMINA_REWARD =
{
    24092, 
    {"id", "int8", "补给索引"},
}
 
--- *s2c* 获取每日体力补给返回 24093
SC_DAILY_STAMINA_REWARD =
{
    24093, 
    {"id", "int8", "补给索引"}, 
    {"result", "int8", "领取结果 1-成功 0-失败"},
}
 
--- *c2s* 月卡面板信息 24094
CS_MONTH_CARD_PANEL =
{
    24094,
}
 
--- *s2c* 月卡面板信息 24095
SC_MONTH_CARD_PANEL =
{
    24095, 
    {"buy_times", "int8", "已购买次数"}, 
    {"left_days", "int16", "剩余天数"}, 
    {"is_buy", "int8", "是否已购买月卡0-否,1-是"},
}
 
--- *c2s* 直购礼包面板信息 24096
CS_DIRECT_GIFT_PANEL =
{
    24096,
}
 
--- *s2c* 直购礼包面板信息 24097
SC_DIRECT_GIFT_PANEL =
{
    24097, 
    {"goods_list", pt_direct_gift_info, "商品列表", "repeated"}, 
    {"buy_list", pt_attr_int, "已购买列表", "repeated"}, 
    {"request_times", "int16", "今日已请求次数"},
}
 
--- *c2s* 购买直购礼包道具 24098
CS_DIRECT_GIFT_BUY =
{
    24098, 
    {"goods_id", "int32", "商品id"}, 
    {"num", "int16", "购买数量"},
}
 
--- *s2c* 购买直购礼包道具 24099
SC_DIRECT_GIFT_BUY =
{
    24099, 
    {"goods_id", "int32", "商品id"}, 
    {"num", "int16", "购买数量"}, 
    {"award_list", pt_prop_award, "奖励列表", "repeated"},
}
 
--- *s2c* 通行证面板 24101
SC_PERMIT_PANEL =
{
    24101, 
    {"exp", "int32", "经验"}, 
    {"week_exp", "int32", "本周经验"}, 
    {"lv", "int16", "等级"}, 
    {"unlock_gear", "int8", "解锁挡位,0-未解锁,1-挡位68,2-挡位98"}, 
    {"gained_primary_reward", "int16", "已获取低级奖励等级", "repeated"}, 
    {"gained_senior_reward", "int16", "已获取高级奖励等级", "repeated"},
}
 
--- *c2s* 购买通行证等级 24102
CS_BUY_PERMIT_LV =
{
    24102, 
    {"buy_lv", "int16", "购买通行证等级"},
}
 
--- *s2c* 购买通行证经验 24103
SC_BUY_PERMIT_LV =
{
    24103, 
    {"result", "int8", "够买结果 1-成功 0-失败"}, 
    {"buy_lv", "int16", "购买通行证等级"},
}
 
--- *c2s* 领取通行证奖励 24104
CS_GAIN_PERMIT_REWARD =
{
    24104, 
    {"lv", "int16", "等级"}, 
    {"is_senior", "int8", "是否高级 0-低级 1-高级"},
}
 
--- *s2c* 领取通行证奖励 24105
SC_GAIN_PERMIT_REWARD =
{
    24105, 
    {"result", "int8", "领取结果 1-成功 0-失败"}, 
    {"lv", "int16", "等级"}, 
    {"is_senior", "int8", "是否高级 0-低级 1-高级"},
}
 
--- *s2c* 累计充值数据 24106
SC_ACC_PAY_PANEL =
{
    24106, 
    {"pay_rmb", "int32", "累计充值金额"}, 
    {"award_list", "int16", "已领取奖励的档次列表", "repeated"},
}
 
--- *c2s* 领取累计充值奖励 24107
CS_ACC_PAY_AWARD =
{
    24107, 
    {"acc_id", "int16", "档次id"},
}
 
--- *s2c* 领取累计充值奖励 24108
SC_ACC_PAY_AWARD =
{
    24108, 
    {"acc_id", "int16", "档次id"}, 
    {"result", "int8", "领取结果 1-成功 0-失败"},
}
 
--- *c2s* 请求新手训练营面板 24111
CS_NOVICE_TRAINING_PANEL =
{
    24111,
}
 
--- *s2c* 返回新手训练营面板 24112
SC_NOVICE_TRAINING_PANEL =
{
    24112, 
    {"step", "int16", "任务阶段"}, 
    {"task_list", pt_task_info_base, "任务内容", "repeated"}, 
    {"is_received_all", "int8", "奖励是否全部领取 0:否 1：是 （所有阶段所有奖励领完）"},
}
 
--- *c2s* 请求领取新手训练营任务奖励 24113
CS_NOVICE_TRAINING_RECEIVE_TASK =
{
    24113, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 领取新手训练营任务奖励结果 24114
SC_NOVICE_TRAINING_RECEIVE_TASK =
{
    24114, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"}, 
    {"result", "int8", "领取结果，1成功0失败"},
}
 
--- *c2s* 请求领取新手训练营阶段奖励 24115
CS_NOVICE_TRAINING_RECEIVE_STEP =
{
    24115,
}
 
--- *s2c* 领取新手训练营阶段奖励结果 24116
SC_NOVICE_TRAINING_RECEIVE_STEP =
{
    24116, 
    {"result", "int8", "领取结果，1成功0失败"},
}
 
--- *s2c* 更新新手训练营任务进度 24117
SC_UPDATE_NOVICE_TRAINING_TASK =
{
    24117, 
    {"task_info", pt_task_info_base, "任务内容"},
}
 
--- *s2c* 皮肤商店面板 24131
SC_FASHION_SHOP_PANEL =
{
    24131, 
    {"buy_list", "int32", "已购买的商品id列表", "repeated"}, 
    {"goods_list", pt_fashion_shop_conf, "商品配置列表", "repeated"}, 
    {"combo_buy_list", "int32", "已购买的组合商品id列表", "repeated"}, 
    {"combo_goods_list", pt_combo_fashion_shop_conf, "组合商品配置列表", "repeated"},
}
 
--- *c2s* 皮肤商店购买商品 24132
CS_FASHION_SHOP_BUY =
{
    24132, 
    {"goods_id", "int16", "商品id"}, 
    {"is_use_discount", "int8", "是否使用打折卡"},
}
 
--- *s2c* 皮肤商店购买商品结果 24133
SC_FASHION_SHOP_BUY =
{
    24133, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"goods_id", "int16", "商品id"},
}
 
--- *c2s* 皮肤商店购买商品 24134
CS_FASHION_COMBO_SHOP_BUY =
{
    24134, 
    {"goods_combo_id", "int16", "商品组id"},
}
 
--- *s2c* 皮肤商店购买商品这结果 24135
SC_FASHION_COMBO_SHOP_BUY =
{
    24135, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"goods_combo_id", "int16", "商品组合id"},
}
 
--- *s2c* 等级礼包面板 24201
SC_LEVEL_GIFT_PANEL =
{
    24201, 
    {"gained_gift_list", "int16", "已领取等级礼包列表(包括两种礼包类型)", "repeated"},
}
 
--- *c2s* 领取等级礼包 24202
CS_GAIN_LEVEL_GIFT =
{
    24202, 
    {"gift_id", "int16", "礼包id"},
}
 
--- *s2c* 皮肤商店购买商品结果 24203
SC_GAIN_LEVEL_GIFT =
{
    24203, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"gift_id", "int16", "礼包id"},
}
 
--- *s2c* 基金面板 24206
SC_FUND_PANEL =
{
    24206, 
    {"gained_primary_fund_list", "int16", "已领取低级基金列表", "repeated"}, 
    {"gained_senior_fund_list", "int16", "已领取高级基金列表", "repeated"}, 
    {"whether_unlock_senior_fund", "int8", "是否解锁高级基金,0-否,1-是"},
}
 
--- *c2s* 领取基金 24207
CS_GAIN_ALL_FUND =
{
    24207,
}
 
--- *c2s* 领取基金 24208
CS_GAIN_FUND =
{
    24208, 
    {"fund_id", "int16", "基金id"}, 
    {"fund_type", "int8", "基金类型"},
}
 
--- *s2c* 领取基金返回结果 24209
SC_GAIN_FUND =
{
    24209, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"fund_id", "int16", "基金id"}, 
    {"fund_type", "int8", "基金类型"},
}
 
--- *c2s* 领取所有等级奖励 24211
CS_GAIN_ALL_PERMIT_REWARD =
{
    24211,
}
 
--- *s2c* 首充奖励面板信息 24212
SC_FIRST_PAY_PANEL =
{
    24212, 
    {"gain_state_list", pt_attr_short, "已激活天数可领取状态 0-未领取 1-已领取", "repeated"},
}
 
--- *c2s* 领取首充奖励 24213
CS_GAIN_FIRST_PAY =
{
    24213, 
    {"day", "int8", "天数"},
}
 
--- *s2c* 领取首充奖励返回结果 24214
SC_GAIN_FIRST_PAY =
{
    24214, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"day", "int8", "天数"},
}
 
--- *s2c* 关注有礼面板信息 24215
SC_CONCERN_GIFT_PANEL =
{
    24215, 
    {"is_b_open", "int8", "B站包是否开启功能"}, 
    {"last_award_time", "int32", "最后一次领取时间"}, 
    {"gain_state_list", pt_attr_short, "可领取状态 0-未关注 1-可领取 2-已领取", "repeated"},
}
 
--- *c2s* 关注有礼可领取 24216
CS_CONCERN_GIFT_CAN_GAIN =
{
    24216, 
    {"id", "int16", "奖励id"},
}
 
--- *c2s* 领取关注有礼奖励 24217
CS_GAIN_CONCERN_GIFT =
{
    24217, 
    {"id", "int16", "奖励id"},
}
 
--- *s2c* 领取关注有礼奖励返回结果 24218
SC_GAIN_CONCERN_GIFT =
{
    24218, 
    {"id", "int16", "奖励id"}, 
    {"result", "int8", "结果，1：成功 0：失败"},
}
 
--- *s2c* 新手活动-战员招募面板数据 24220
SC_ACTIVITY_NOVICE_RECRUIT_HERO_PANEL =
{
    24220, 
    {"recruit_times", "int16", "已招募次数"}, 
    {"received_list", "int16", "已领取的奖励id列表", "repeated"},
}
 
--- *c2s* 新手活动-战员招募领取奖励 24221
CS_ACTIVITY_NOVICE_RECRUIT_HERO_RECEIVE =
{
    24221, 
    {"id", "int16", "领取的id"},
}
 
--- *s2c* 新手活动-战员招募领取奖励 24222
SC_ACTIVITY_NOVICE_RECRUIT_HERO_RECEIVE =
{
    24222, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"id", "int16", "领取的id"},
}
 
--- *s2c* 新手活动-手环招募面板数据 24230
SC_ACTIVITY_NOVICE_RECRUIT_BRACELET_PANEL =
{
    24230, 
    {"recruit_times", "int16", "已招募次数"}, 
    {"received_list", "int16", "已领取的奖励id列表", "repeated"},
}
 
--- *c2s* 新手活动-手环招募领取奖励 24231
CS_ACTIVITY_NOVICE_RECRUIT_BRACELET_RECEIVE =
{
    24231, 
    {"id", "int16", "领取的id"},
}
 
--- *s2c* 新手活动-手环招募领取奖励 24232
SC_ACTIVITY_NOVICE_RECRUIT_BRACELET_RECEIVE =
{
    24232, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"id", "int16", "领取的id"},
}
 
--- *s2c* 新手活动-升格计划面板数据 24240
SC_ACTIVITY_NOVICE_UPGRADE_PANEL =
{
    24240, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"},
}
 
--- *s2c* 新手活动-升格计划任务更新 24241
SC_ACTIVITY_NOVICE_UPGRADE_UPDATE =
{
    24241, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"},
}
 
--- *c2s* 新手活动-升格计划领取奖励 24242
CS_ACTIVITY_NOVICE_UPGRADE_RECEIVE =
{
    24242, 
    {"id", "int16", "领取的id"},
}
 
--- *s2c* 新手活动-升格计划领取奖励 24243
SC_ACTIVITY_NOVICE_UPGRADE_RECEIVE =
{
    24243, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"id", "int16", "领取的id"},
}
 
--- *s2c* 新手活动-入口开启 24250
SC_ACTIVITY_NOVICE_START =
{
    24250, 
    {"end_time", "int32", "新手活动的结束时间戳 0为关闭"},
}
 
--- *c2s* 领取活动奖励 24255
CS_GAIN_ACTIVITY_SIGN_REWARD =
{
    24255, 
    {"day", "int16", "领取第几天"},
}
 
--- *s2c* 面板信息 24256
SC_ACTIVITY_SIGN_PANEL_INFO =
{
    24256, 
    {"login_day", "int16", "登录天数"}, 
    {"sign_day_reward_list", "int16", "已领取奖励天数", "repeated"},
}
 
--- *c2s* 领取活动奖励 24257
CS_GAIN_FESTIVAL_ACTIVITY_SIGN_REWARD =
{
    24257, 
    {"day", "int16", "领取第几天"},
}
 
--- *s2c* 面板信息 24258
SC_FESTIVAL_ACTIVITY_SIGN_PANEL_INFO =
{
    24258, 
    {"login_day", "int16", "登录天数"}, 
    {"sign_day_reward_list", "int16", "已领取奖励天数", "repeated"},
}
 
--- *s2c* 新手活动-成长返还面板数据 24260
SC_ACTIVITY_NOVICE_RETURN_PANEL =
{
    24260, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"},
}
 
--- *s2c* 新手活动-成长返还任务更新 24261
SC_ACTIVITY_NOVICE_RETURN_UPDATE =
{
    24261, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"},
}
 
--- *c2s* 新手活动-成长返还领取奖励 24262
CS_ACTIVITY_NOVICE_RETURN_RECEIVE =
{
    24262, 
    {"id", "int16", "领取的id"},
}
 
--- *s2c* 新手活动-成长返还领取奖励 24263
SC_ACTIVITY_NOVICE_RETURN_RECEIVE =
{
    24263, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"id", "int16", "领取的id"},
}
 
--- *c2s* 领取活动奖励 24270
CS_GAIN_OPEN_SERVER_SIGN_REWARD =
{
    24270, 
    {"day", "int16", "领取第几天"},
}
 
--- *s2c* 面板信息 24271
SC_OPEN_SERVER_SIGN_PANEL_INFO =
{
    24271, 
    {"open_day", "int16", "开服天数"}, 
    {"end_time", "int32", "活动结束时间"}, 
    {"sign_day_reward_list", "int16", "已领取奖励天数", "repeated"},
}
 
--- *s2c* 平台成就面板数据 24276
SC_PLATFORM_ACHIEVE_PANEL =
{
    24276, 
    {"achieve_list", "string", "已完成的成就列表", "repeated"},
}
 
--- *s2c* 平台成就更新 24277
SC_PLATFORM_ACHIEVE_UPDATE =
{
    24277, 
    {"achieve_id", "string", "新增完成的成就（API名称）"},
}
 
--- *s2c* 活动商店信息 24280
SC_ACTIVITY_SHOP_INFO =
{
    24280, 
    {"goods_list", pt_activity_shop, "商品列表", "repeated"},
}
 
--- *c2s* 活动商店购买商品 24281
CS_ACTIVITY_SHOP_BUY =
{
    24281, 
    {"id", "int16", "商品id"}, 
    {"buy_times", "int16", "购买次数"},
}
 
--- *s2c* 活动商店购买商品 24282
SC_ACTIVITY_SHOP_BUY =
{
    24282, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"id", "int16", "商品id"}, 
    {"buy_times", "int16", "总购买次数"},
}
 
--- *s2c* 活动任务面板 24290
SC_ACTIVITY_TASK_PANEL =
{
    24290, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"},
}
 
--- *c2s* 活动任务领取任务奖励 24291
CS_ACTIVITY_TASK_RECEIVE =
{
    24291, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 活动任务领取任务奖励 24292
SC_ACTIVITY_TASK_RECEIVE =
{
    24292, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 更新活动任务的任务进度 24293
SC_ACTIVITY_TASK_UPDATE =
{
    24293, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *s2c* 新手活动-转盘面板数据 24300
SC_ACTIVITY_NOVICE_TURNTABLE_PANEL =
{
    24300, 
    {"end_time", "int32", "结束时间"}, 
    {"gear", "int8", "档位 0：已转完"},
}
 
--- *c2s* 新手活动-转盘面板抽奖 24301
CS_ACTIVITY_NOVICE_TURNTABLE_DRAW =
{
    24301,
}
 
--- *s2c* 新手活动-转盘面板抽奖 24302
SC_ACTIVITY_NOVICE_TURNTABLE_DRAW =
{
    24302, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"gear", "int8", "最新档位 0：已转完"}, 
    {"pos", "int8", "抽奖结果"},
}
 
--- *s2c* 联动活动面板 24310
SC_LINKAGE_PANEL =
{
    24310, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"}, 
    {"is_gain_grand_prize", "int8", "是否领取了最终奖励"}, 
    {"is_b_open", "int8", "B站包是否开启功能"},
}
 
--- *c2s* 联动活动任务奖励领取 24311
CS_LINKAGE_TASK_RECEIVE =
{
    24311, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 联动活动任务奖励领取 24312
SC_LINKAGE_TASK_RECEIVE =
{
    24312, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *c2s* 联动活动任务领取最终奖励 24313
CS_LINKAGE_RECEIVE_GRAND_PRIZE =
{
    24313,
}
 
--- *s2c* 联动活动任务领取最终奖励 24314
SC_LINKAGE_RECEIVE_GRAND_PRIZE =
{
    24314, 
    {"result", "int8", "结果，1：成功 0：失败"},
}
 
--- *s2c* 更新活动任务的任务进度 24315
SC_LINKAGE_TASK_UPDATE =
{
    24315, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *s2c* 回归活动开启信息 24320
SC_RETURNED_INFO =
{
    24320, 
    {"is_open", "int8", "是否开启"}, 
    {"end_time", "int32", "结束时间"},
}
 
--- *c2s* 领取签到奖励 24321
CS_GAIN_RETURNED_SIGN_REWARD =
{
    24321, 
    {"day", "int16", "领取第几天"},
}
 
--- *s2c* 签到信息 24322
SC_RETURNED_SIGN_PANEL_INFO =
{
    24322, 
    {"login_day", "int16", "登录天数"}, 
    {"sign_day_reward_list", "int16", "已领取奖励天数", "repeated"},
}
 
--- *s2c* 任务面板 24323
SC_RETURNED_TASK_PANEL =
{
    24323, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"},
}
 
--- *c2s* 任务领取奖励 24324
CS_RETURNED_TASK_RECEIVE =
{
    24324, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 任务领取奖励 24325
SC_RETURNED_TASK_RECEIVE =
{
    24325, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 更新任务进度 24326
SC_RETURNED_TASK_UPDATE =
{
    24326, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *s2c* 时装通行证面板 24330
SC_FASHION_PERMIT_PANEL =
{
    24330, 
    {"exp", "int32", "经验"}, 
    {"lv", "int16", "等级"}, 
    {"unlock_gear", "int8", "解锁挡位,0-未解锁,1-挡位68,2-挡位98"}, 
    {"gained_primary_reward", "int16", "已获取低级奖励等级", "repeated"}, 
    {"gained_senior_reward", "int16", "已获取高级奖励等级", "repeated"}, 
    {"task_info", pt_task_info_base, "任务信息", "repeated"}, 
    {"is_unlock_fashion", "int8", "是否已解锁时装奖励"},
}
 
--- *c2s* 购买时装通行证等级 24331
CS_BUY_FASHION_PERMIT_LV =
{
    24331, 
    {"buy_lv", "int16", "购买皮肤通行证等级"},
}
 
--- *s2c* 购买时装通行证经验 24332
SC_BUY_FASHION_PERMIT_LV =
{
    24332, 
    {"result", "int8", "够买结果 1-成功 0-失败"}, 
    {"buy_lv", "int16", "购买通行证等级"},
}
 
--- *c2s* 领取时装通行证奖励 24333
CS_GAIN_FASHION_PERMIT_REWARD =
{
    24333, 
    {"lv", "int16", "等级"}, 
    {"is_senior", "int8", "是否高级 0-低级 1-高级"},
}
 
--- *s2c* 领取时装通行证奖励 24334
SC_GAIN_FASHION_PERMIT_REWARD =
{
    24334, 
    {"result", "int8", "领取结果 1-成功 0-失败"}, 
    {"lv", "int16", "等级"}, 
    {"is_senior", "int8", "是否高级 0-低级 1-高级"},
}
 
--- *c2s* 领取所有等级奖励 24335
CS_GAIN_ALL_FASHION_PERMIT_REWARD =
{
    24335,
}
 
--- *c2s* 任务领取奖励 24336
CS_FASHION_PERMIT_TASK_RECEIVE =
{
    24336, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 任务领取奖励 24337
SC_FASHION_PERMIT_TASK_RECEIVE =
{
    24337, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 更新任务进度 24338
SC_FASHION_PERMIT_TASK_UPDATE =
{
    24338, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 月卡面板信息 24350
CS_STAMINA_MONTH_CARD_PANEL =
{
    24350,
}
 
--- *s2c* 月卡面板信息 24351
SC_STAMINA_MONTH_CARD_PANEL =
{
    24351, 
    {"buy_times", "int8", "已购买次数"}, 
    {"left_days", "int16", "剩余天数"}, 
    {"is_buy", "int8", "是否已购买月卡0-否,1-是"},
}
 
--- *c2s* 下载有礼 24370
CS_DOWN_GIFT =
{
    24370,
}
 
--- *s2c* 下载有礼 24371
SC_DOWN_GIFT =
{
    24371, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *s2c* 下载有礼已领取 24372
SC_DOWN_GIFT_SHOW =
{
    24372, 
    {"down_gift_show", "int8", "下载资源礼包是否领取 0否1是"},
}
 
--- *c2s* 周年开通月卡赠礼 24373
CS_CELE_MON_CARD_GIFT =
{
    24373,
}
 
--- *s2c* 周年开通月卡赠礼 24374
SC_CELE_MON_CARD_GIFT =
{
    24374, 
    {"result", "int8", "结果，1成功0失败"},
}
 
--- *s2c* 周年开通月卡赠礼状态 24375
SC_CELE_MON_CARD_GIFT_SHOW =
{
    24375, 
    {"state", "int8", "周年开通月卡赠礼 状态 0-未解锁 1-已解锁未领取 2-已领取"},
}
 
--- *s2c* 周年活动任务面板 24376
SC_CELE_ACTIVITY_TASK_PANEL =
{
    24376, 
    {"day", "int16", "任务开启的天数"}, 
    {"target_gain_state", "int8", "任务目标奖励状态 0-未领取 1-已领取"}, 
    {"task_list", pt_task_info_base, "任务列表", "repeated"},
}
 
--- *c2s* 周年活动任务领取任务奖励 24377
CS_CELE_ACTIVITY_TASK_RECEIVE =
{
    24377, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 周年活动任务领取任务奖励 24378
SC_CELE_ACTIVITY_TASK_RECEIVE =
{
    24378, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 更新周年活动任务的任务进度 24379
SC_CELE_ACTIVITY_TASK_UPDATE =
{
    24379, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *c2s* 领取周年活动任务目标奖励 24380
CS_CELE_ACTIVITY_TASK_TARGET_GAIN =
{
    24380,
}
 
--- *s2c* 领取周年活动任务目标奖励 24381
SC_CELE_ACTIVITY_TASK_TARGET_GAIN =
{
    24381, 
    {"result", "int8", "结果，1：成功 0：失败"},
}
 
--- *s2c* 周年累充奖励面板 24382
SC_CELE_RECHARGE_PANEL =
{
    24382, 
    {"total_count", "int32", "累计充值-单位分"}, 
    {"reward_list", "int16", "已领取列表", "repeated"},
}
 
--- *c2s* 领取周年累充奖励 24383
CS_CELE_RECHARGE_RECEIVE =
{
    24383, 
    {"recharge_id", "int16", "奖励id"},
}
 
--- *s2c* 领取周年累充奖励 24384
SC_CELE_RECHARGE_RECEIVE =
{
    24384, 
    {"recharge_id", "int16", "奖励id"}, 
    {"result", "int8", "结果，1：成功 0：失败"},
}
 
--- *c2s* 限时礼包面板信息 24401
CS_LIMITED_GIFT_PANEL =
{
    24401,
}
 
--- *s2c* 限时礼包面板信息 24402
SC_LIMITED_GIFT_PANEL =
{
    24402, 
    {"goods_list", pt_limited_gift_info, "商品列表", "repeated"}, 
    {"is_new_unlock", "int8", "是否新解锁0-否,1-是"}, 
    {"panel_ids", "int32", "面板id", "repeated"},
}
 
--- *c2s* 购买限时礼包道具 24403
CS_LIMITED_GIFT_BUY =
{
    24403, 
    {"goods_id", "int32", "商品id"}, 
    {"num", "int16", "购买数量"},
}
 
--- *s2c* 购买直购礼包道具 24404
SC_LIMITED_GIFT_BUY =
{
    24404, 
    {"goods_id", "int32", "商品id"}, 
    {"num", "int16", "购买数量"}, 
    {"award_list", pt_prop_award, "奖励列表", "repeated"},
}
 
--- *c2s* 打开某个面板解锁限时礼包 24405
CS_LIMITED_GIFT_OPEN_PANEL =
{
    24405, 
    {"panel_id", "int32", "面板id"},
}
 
--- *s2c* 超值限时礼包面板信息 24410
SC_SUPER_GIFT_PANEL =
{
    24410, 
    {"goods_list", pt_super_gift_info, "商品列表", "repeated"},
}
 
--- *c2s* 购买超值限时礼包道具 24411
CS_SUPER_GIFT_BUY =
{
    24411, 
    {"goods_id", "int32", "商品id"},
}
 
--- *s2c* 购买超值限时礼包道具 24412
SC_SUPER_GIFT_BUY =
{
    24412, 
    {"goods_id", "int32", "商品id"}, 
    {"result", "int8", "购买结果 1-成功 0-失败"},
}
 
--- *s2c* 充值好礼面板 24415
SC_ACTIVITY_PAY_PANEL =
{
    24415, 
    {"gain_state", "int8", "领取状态,0-不可领取,1-可领取,2-已领取"},
}
 
--- *c2s* 充值好礼领取奖励 24416
CS_ACTIVITY_PAY_GAIN_AWARD =
{
    24416,
}
 
--- *s2c* 狂欢好礼面板 24420
SC_ACTIVITY_PAY_SIGN_PANEL =
{
    24420, 
    {"is_recharge", "int8", "是否已充值1-是,0-否"}, 
    {"diff_day", "int16", "活动开启的第几天"}, 
    {"gain_list", "int16", "已获取奖励id", "repeated"},
}
 
--- *c2s* 狂欢好礼领取奖励 24421
CS_ACTIVITY_PAY_SIGN_GAIN_AWARD =
{
    24421, 
    {"id", "int16", "奖励id"},
}
 
--- *s2c* 时装通行证面板 24430
SC_FASHION_PERMIT2_PANEL =
{
    24430, 
    {"exp", "int32", "经验"}, 
    {"lv", "int16", "等级"}, 
    {"unlock_gear", "int8", "解锁挡位,0-未解锁,1-挡位68,2-挡位98"}, 
    {"gained_primary_reward", "int16", "已获取低级奖励等级", "repeated"}, 
    {"gained_senior_reward", "int16", "已获取高级奖励等级", "repeated"}, 
    {"task_info", pt_task_info_base, "任务信息", "repeated"}, 
    {"is_unlock_fashion", "int8", "是否已解锁时装奖励"},
}
 
--- *c2s* 购买时装通行证等级 24431
CS_BUY_FASHION_PERMIT2_LV =
{
    24431, 
    {"buy_lv", "int16", "购买皮肤通行证等级"},
}
 
--- *s2c* 购买时装通行证经验 24432
SC_BUY_FASHION_PERMIT2_LV =
{
    24432, 
    {"result", "int8", "够买结果 1-成功 0-失败"}, 
    {"buy_lv", "int16", "购买通行证等级"},
}
 
--- *c2s* 领取时装通行证奖励 24433
CS_GAIN_FASHION_PERMIT2_REWARD =
{
    24433, 
    {"lv", "int16", "等级"}, 
    {"is_senior", "int8", "是否高级 0-低级 1-高级"},
}
 
--- *s2c* 领取时装通行证奖励 24434
SC_GAIN_FASHION_PERMIT2_REWARD =
{
    24434, 
    {"result", "int8", "领取结果 1-成功 0-失败"}, 
    {"lv", "int16", "等级"}, 
    {"is_senior", "int8", "是否高级 0-低级 1-高级"},
}
 
--- *c2s* 领取所有等级奖励 24435
CS_GAIN_ALL_FASHION_PERMIT2_REWARD =
{
    24435,
}
 
--- *c2s* 任务领取奖励 24436
CS_FASHION_PERMIT2_TASK_RECEIVE =
{
    24436, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 任务领取奖励 24437
SC_FASHION_PERMIT2_TASK_RECEIVE =
{
    24437, 
    {"result", "int8", "结果，1：成功 0：失败"}, 
    {"task_id_list", "int16", "领取的任务id列表", "repeated"},
}
 
--- *s2c* 更新任务进度 24438
SC_FASHION_PERMIT2_TASK_UPDATE =
{
    24438, 
    {"task_info", pt_task_info_base, "任务信息"},
}
 
--- *s2c* 投资理财活动面板 24450
SC_INVEST_PANEL =
{
    24450, 
    {"grade", "int8", "档次"}, 
    {"activity_day", "int8", "活动第几天"}, 
    {"total_count", "int32", "累计充值"}, 
    {"asset_reward_list", "int8", "已经领取的资产奖励", "repeated"}, 
    {"item_reward_list", "int8", "已经领取的道具奖励", "repeated"},
}
 
--- *c2s* 购买对应档次的返利 24451
CS_INVEST_BUY_GEAR =
{
    24451, 
    {"grade_id", "int8", "档次id"},
}
 
--- *s2c* 购买对应档次的返利返回 24452
SC_INVEST_BUY_GEAR =
{
    24452, 
    {"grade_id", "int8", "档次id"}, 
    {"result", "int8", "结果，1：成功 0：失败"},
}
 
--- *c2s* 领取奖励 24453
CS_GET_INVEST =
{
    24453, 
    {"type", "int8", "奖励类型 1为资产奖励 2为道具奖励"}, 
    {"reward_id", "int8", "奖励id 资产奖励为第几天 道具为奖励的id"},
}
 
--- *s2c* 领取奖励返回 24454
SC_GET_INVEST =
{
    24454, 
    {"type", "int8", "奖励类型 1为资产奖励 2为道具奖励"}, 
    {"reward_id", "int8", "奖励id 资产奖励为第几天 道具为奖励的id"}, 
    {"result", "int8", "结果，1：成功 0：失败"},
}
 
--- *s2c* 自选礼包信息 24460
SC_SELECT_GIFT_LIST_INFO =
{
    24460, 
    {"select_gift_list", pt_select_gift_info, "自选礼包列表", "repeated"},
}
 
--- *c2s* 自选礼包自选 24461
CS_SELECT_GIFT_SELECT =
{
    24461, 
    {"gift_id", "int8", "礼包id"}, 
    {"grid_select_list", pt_select_gift_grid_info, "格子选择", "repeated"},
}
 
--- *s2c* 活动每日礼包 24462
SC_ACTIVITY_DAY_REWARD_PANEL =
{
    24462, 
    {"activity_id", "int16", "已经领取的活动id", "repeated"},
}
 
--- *c2s* 活动每日礼包领取 24463
CS_GET_ACTIVITY_DAY_REWARD =
{
    24463, 
    {"activity_id", "int16", "礼包id"},
}
 
--- *s2c* 新年轮盘面板 24470
SC_NEW_YEAR_TURNTABLE_PANEL =
{
    24470, 
    {"unlucky_times", "int16", "未抽中目标道具次数(幸运值)"}, 
    {"acc_times", "int32", "累计抽奖次数"}, 
    {"acc_gained_list", "int32", "已领取的累计抽奖奖励", "repeated"},
}
 
--- *c2s* 新年轮盘抽奖 24471
CS_NEW_YEAR_TURNTABLE_LOTTERY =
{
    24471, 
    {"times", "int8", "1次 or 10次"},
}
 
--- *s2c* 新年轮盘抽奖 24472
SC_NEW_YEAR_TURNTABLE_LOTTERY =
{
    24472, 
    {"result", "int8", "0-失败,1-成功"}, 
    {"times", "int8", "1次 or 10次"}, 
    {"unlucky_times", "int16", "未抽中目标道具次数(幸运值)"}, 
    {"acc_times", "int32", "累计抽奖次数"}, 
    {"order_list", "int32", "抽奖顺序列表", "repeated"}, 
    {"award", pt_prop_award, "获得奖励", "repeated"},
}
 
--- *c2s* 领取累抽奖励 24473
CS_NEW_YEAR_TURNTABLE_GAIN_ACC_AWARD =
{
    24473, 
    {"times", "int32", "领取的次数档位奖励"},
}
 
--- *s2c* 领取累抽奖励 24474
SC_NEW_YEAR_TURNTABLE_GAIN_ACC_AWARD =
{
    24474, 
    {"result", "int8", "0-失败,1-成功"}, 
    {"times", "int32", "领取的次数档位奖励"},
}
 
--- *s2c* 作战储备-srr奖励-面板 24480
SC_COMBAT_PREPARE_SSR_PANEL =
{
    24480, 
    {"end_time", "int32", "结束时间戳"}, 
    {"state", "int8", "奖励状态 % 0-不可领取,1-可领取,2-已领取"},
}
 
--- *c2s* 作战储备-srr奖励-领取 24481
CS_COMBAT_PREPARE_SSR_GET =
{
    24481,
}
 
--- *s2c* 作战储备-累充奖励面板 24482
SC_COMBAT_PREPARE_RECHARGE_PANEL =
{
    24482, 
    {"end_time", "int32", "结束时间戳"}, 
    {"total_count", "int32", "累计充值-单位分"}, 
    {"reward_list", "int16", "已领取列表", "repeated"},
}
 
--- *c2s* 领取作战储备-累充奖励 24483
CS_COMBAT_PREPARE_RECHARGE_RECEIVE =
{
    24483, 
    {"recharge_id", "int16", "奖励id"},
}
 
--- *s2c* 领取作战储备-累充奖励 24484
SC_COMBAT_PREPARE_RECHARGE_RECEIVE =
{
    24484, 
    {"recharge_id", "int16", "奖励id"}, 
    {"result", "int8", "结果，1：成功 0：失败"},
}
 
--- *s2c* 往期商品 24490
SC_ACTIVITY_EXPIRED_GOODS =
{
    24490, 
    {"buy_list", "int32", "已购买商品列表", "repeated"},
}
 
--- *s2c* 新年轮盘面板 24500
SC_NEW_YEAR_TURNTABLE_PANEL2 =
{
    24500, 
    {"unlucky_times", "int16", "未抽中目标道具次数(幸运值)"}, 
    {"acc_times", "int32", "累计抽奖次数"}, 
    {"acc_gained_list", "int32", "已领取的累计抽奖奖励", "repeated"},
}
 
--- *c2s* 新年轮盘抽奖 24501
CS_NEW_YEAR_TURNTABLE_LOTTERY2 =
{
    24501, 
    {"times", "int8", "1次 or 10次"},
}
 
--- *s2c* 新年轮盘抽奖 24502
SC_NEW_YEAR_TURNTABLE_LOTTERY2 =
{
    24502, 
    {"result", "int8", "0-失败,1-成功"}, 
    {"times", "int8", "1次 or 10次"}, 
    {"unlucky_times", "int16", "未抽中目标道具次数(幸运值)"}, 
    {"acc_times", "int32", "累计抽奖次数"}, 
    {"order_list", "int32", "抽奖顺序列表", "repeated"}, 
    {"award", pt_prop_award, "获得奖励", "repeated"},
}
 
--- *c2s* 领取累抽奖励 24503
CS_NEW_YEAR_TURNTABLE_GAIN_ACC_AWARD2 =
{
    24503, 
    {"times", "int32", "领取的次数档位奖励"},
}
 
--- *s2c* 领取累抽奖励 24504
SC_NEW_YEAR_TURNTABLE_GAIN_ACC_AWARD2 =
{
    24504, 
    {"result", "int8", "0-失败,1-成功"}, 
    {"times", "int32", "领取的次数档位奖励"},
}
