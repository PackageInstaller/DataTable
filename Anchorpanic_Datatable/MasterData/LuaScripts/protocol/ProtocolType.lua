-- ---------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Name:  ProtocolType
-- @Desc:  协议自定义类型结构
-- ---------------------------------------
-- module(..., package.seeall);


--- gm指令
pt_gm_command =
{    
    {"module", "string", "模块"}, 
    {"cmd", "string", "命令"}, 
    {"desc", "string", "描述"}, 
    {"example", "string", "例子"},
}

--- 坐标
pt_pos =
{    
    {"x", "int16", "x坐标"}, 
    {"y", "int16", "y坐标"},
}

--- 三维坐标
pt_pos_z =
{    
    {"x", "string", "x坐标"}, 
    {"y", "string", "y坐标"}, 
    {"z", "string", "z坐标"},
}

--- int16,int16
pt_int_int =
{    
    {"key", "int16", "键"}, 
    {"value", "int16", "值"},
}

--- 属性key,int8
pt_bigint_short =
{    
    {"key", "int32", "键"}, 
    {"value", "int8", "值"},
}

--- 属性
pt_attr =
{    
    {"key", "int16", "键"}, 
    {"value", "int32", "值"},
}

--- 改造属性
pt_remake_attr =
{    
    {"remake_pos", "int16", "改造部位"}, 
    {"key", "int16", "键"}, 
    {"value", "int32", "值"}, 
    {"max_value", "int32", "最大值"}, 
    {"min_value", "int32", "最小值"},
}

--- 烙痕改造属性
pt_bracelet_remake_attr =
{    
    {"remake_pos", "int16", "改造部位"}, 
    {"key", "int16", "键"}, 
    {"value", "int32", "值"}, 
    {"level", "int16", "等级"}, 
    {"max_level", "int16", "最大等级"}, 
    {"is_lock", "int8", "是否上锁，1是0否"},
}

--- 突破附加属性
pt_break_add_attr =
{    
    {"key", "int16", "键"}, 
    {"value", "int32", "值"}, 
    {"is_active", "int8", "是否激活:0-未激活,1-激活"}, 
    {"breakup_rank", "int32", "突破阶段"},
}

--- 效果值列表
pt_effect_values =
{    
    {"effect_id", "int32", "效果 id"}, 
    {"value", "int32", "效果值"},
}

--- 技能效果值
pt_skill_effect_value =
{    
    {"skill_id", "int32", "技能id"}, 
    {"skill_lv", "int32", "技能等级"}, 
    {"effect_values", pt_effect_values, "效果列表", "repeated"},
}

--- 属性key,int8
pt_attr_short =
{    
    {"key", "int16", "键"}, 
    {"value", "int8", "值"},
}

--- 属性key,int32
pt_attr_int =
{    
    {"key", "int16", "键"}, 
    {"value", "int32", "值"},
}

--- 属性key,int64
pt_attr_bigint =
{    
    {"key", "int16", "键"}, 
    {"value", "int64str", "值"},
}

--- 属性key,string
pt_attr_string =
{    
    {"key", "int16", "键"}, 
    {"value", "string", "值"},
}

--- 属性key,string
pt_attr_int_list =
{    
    {"key", "int16", "键"}, 
    {"value", "int64str", "值", "repeated"},
}

--- 战斗元素信息
pt_battle_element =
{    
    {"id", "int32", "战斗元素id"}, 
    {"side", "int8", "势力 1-攻方 2-守方"}, 
    {"int8", pt_type, "类型 1-战员 2-神器"}, 
    {"pos", "int8", "位置"}, 
    {"tid", "int32", "模板id"}, 
    {"lv", "int16", "等级"}, 
    {"star", "int16", "星级"}, 
    {"hurt", "int64str", "伤害总量"}, 
    {"cure", "int64str", "治疗总量"}, 
    {"be_hurt", "int64str", "受伤总量"}, 
    {"hp", "int64str", "当前血量"}, 
    {"max_hp", "int64str", "最大血量"}, 
    {"cloth_id", "int16", "时装id"},
}

--- 战斗日志信息
pt_battle_log =
{    
    {"id", "int32", "攻击者id"}, 
    {"skill_id", "int32", "技能id"}, 
    {"round", "int8", "回合数"}, 
    {"hurt_list", pt_battle_hurt, "战斗伤害列表", "repeated"},
}

--- 战斗伤害信息
pt_battle_hurt =
{    
    {"id", "int32", "被攻击者id"}, 
    {"type", "int8", "伤害类型 1-普攻 2-闪避 3-暴击 4-回血 5-真伤 6-加buff 7-减buff"}, 
    {"value", "int64str", "效果值"}, 
    {"update", "int8", "更新类型 1-不更新血量 2-更新目标血量 3-更新攻击者血量"}, 
    {"hp", "int64str", "目标血量"}, 
    {"params", "int64str", "动态参数", "repeated"},
}

--- 通用道具信息
pt_prop_bag =
{    
    {"id", "int32", "道具id"}, 
    {"tid", "int32", "模版id"}, 
    {"count", "int32", "数量"}, 
    {"createdTime", "int32", "生成时间，时间戳（s）"}, 
    {"expiredTime", "int32", "过期时间，时间戳（s）"}, 
    {"color", "int8", "颜色"}, 
    {"is_lock", "int8", "是否上锁，1是0否"}, 
    {"hero_id", "int32", "战员id"}, 
    {"strength_lv", "int32", "强化等级"}, 
    {"strength_exp", "int32", "强化经验"}, 
    {"breakup_rank", "int32", "突破阶段"}, 
    {"refine_lv", "int32", "精炼等级"}, 
    {"remake_attr", pt_remake_attr, "改造属性", "repeated"}, 
    {"bracelet_remake_attr", pt_bracelet_remake_attr, "烙痕改造属性", "repeated"}, 
    {"filter_base_attr", pt_attr, "筛选用基础属性", "repeated"}, 
    {"filter_subjoin_attr", pt_attr, "筛选用附加属性", "repeated"},
}

--- 通用道具详细信息
pt_prop_bag_detail =
{    
    {"id", "int32", "道具id"}, 
    {"tid", "int32", "模版id"}, 
    {"count", "int32", "数量"}, 
    {"createdTime", "int32", "生成时间，时间戳（s）"}, 
    {"expiredTime", "int32", "过期时间，时间戳（s）"}, 
    {"color", "int8", "颜色"}, 
    {"is_lock", "int8", "是否上锁，1是0否"}, 
    {"hero_id", "int32", "战员id"}, 
    {"strength_lv", "int32", "强化等级"}, 
    {"strength_exp", "int32", "强化经验"}, 
    {"breakup_rank", "int32", "突破阶段"}, 
    {"remake_num", "int32", "改造条数"}, 
    {"equip_id", "int32", "装备唯一id"}, 
    {"refine_lv", "int32", "精炼等级"}, 
    {"nuclear_attr", pt_attr, "核能技能属性", "repeated"}, 
    {"remake_attr", pt_remake_attr, "改造属性", "repeated"}, 
    {"bracelet_remake_attr", pt_bracelet_remake_attr, "烙痕改造属性", "repeated"}, 
    {"total_attr", pt_attr, "总属性", "repeated"}, 
    {"strength_pre_attr", pt_attr, "下一强化预览属性列表", "repeated"}, 
    {"break_pre_attr", pt_attr, "下一突破预览属性列表", "repeated"}, 
    {"skill_effect", pt_skill_effect_value, "技能效果", "repeated"}, 
    {"break_add_attr", pt_break_add_attr, "突破属性附加属性", "repeated"}, 
    {"pre_bracelet_refine_skill_attr", pt_skill_effect_value, "手环下一突破精炼预览属性", "repeated"},
}

--- 邮件信息
pt_mail_info =
{    
    {"id", "int32", "唯一id"}, 
    {"type", "int8", "邮件种类"}, 
    {"title", "string", "标题"}, 
    {"date", "int32", "日期（秒）"}, 
    {"expired_time", "int32", "过期时间（秒）"}, 
    {"state", "int8", "状态"}, 
    {"content", "string", "内容"}, 
    {"send_name", "string", "发件人"}, 
    {"award_list", pt_prop_bag_detail, "道具奖励列表", "repeated"}, 
    {"call", "string", "称呼"}, 
    {"is_collection", "int8", "是否可收藏0-否,1-是"},
}

--- 奖励道具信息
pt_prop_award =
{    
    {"tid", "int32", "模版id"}, 
    {"id", "int32", "道具id"}, 
    {"is_lock", "int8", "是否上锁，1是0否"}, 
    {"count", "int32", "数量"}, 
    {"color", "int8", "颜色"}, 
    {"expiredOddTime", "int32", "限时多久（秒），多久之后就会过期"}, 
    {"expiredTime", "int32", "过期时间，时间戳（s）"}, 
    {"refine_lv", "int32", "精炼等级"}, 
    {"total_attr", pt_attr, "芯片类的总属性", "repeated"}, 
    {"break_add_attr", pt_break_add_attr, "突破属性附加属性", "repeated"}, 
    {"skill_effect", pt_skill_effect_value, "芯片类的技能效果", "repeated"},
}

--- 道具数量
pt_item_num =
{    
    {"item_id", "int32", "道具id"}, 
    {"num", "int32", "道具数量"},
}

--- 公告参数
pt_hearsay_param =
{    
    {"type", "int8", "类型"}, 
    {"value", "string", "值"}, 
    {"item", pt_prop_bag, "展示道具", "repeated"},
}

--- 任务结构（基础版）
pt_task_info_base =
{    
    {"id", "int16", "任务id"}, 
    {"count", "int32", "当前值"}, 
    {"state", "int8", "任务状态，1:未完成，0:已完成未领奖，2：已领取奖励"},
}

--- 任务结构
pt_task_info =
{    
    {"id", "int16", "任务id"}, 
    {"type", "int8", "任务类型，1日常2周常"}, 
    {"count", "int32", "当前值"}, 
    {"state", "int8", "任务状态，1:未完成，0:已完成未领奖，2：已领取奖励"}, 
    {"task_award", pt_prop_award, "任务奖励", "repeated"},
}

--- 积分结构
pt_task_score_info =
{    
    {"id", "int16", "积分奖励id"}, 
    {"score", "int16", "积分值"}, 
    {"state", "int8", "状态，1:未完成，0:已完成未领奖，2：已领取奖励"}, 
    {"task_award", pt_prop_award, "积分奖励", "repeated"},
}

--- 成就完成信息
pt_stage_finish_info =
{    
    {"stage", "int8", "成就阶段"}, 
    {"time", "int32", "成就完成时间戳，未完成为0"},
}

--- 成就结构
pt_achievement_info =
{    
    {"id", "int32", "成就id"}, 
    {"stage", "int8", "成就阶段"}, 
    {"count", "int32", "当前值"}, 
    {"state", "int8", "状态，2:已完成已领奖1:未完成，0:已完成未领奖"}, 
    {"finish_info", pt_stage_finish_info, "成就完成信息", "repeated"},
}

--- 玩家信息
pt_friend_info =
{    
    {"id", "int64str", "玩家id"}, 
    {"show_id", "string", "玩家展示id"}, 
    {"name", "string", "玩家名"}, 
    {"lvl", "int16", "玩家等级"}, 
    {"avatar_id", "int32", "玩家头像id"}, 
    {"is_online", "int16", "0离线1在线"}, 
    {"offline_time", "int32", "离线或上线时间"}, 
    {"last_chat_info", "string", "最近的一条聊天记录"}, 
    {"last_chat_time", "int32", "最近的一条聊天时间戳"}, 
    {"last_chat_type", "int8", "内容类型"}, 
    {"common_friend_num", "int32", "共同好友数量:只在推荐列表里面赋值"}, 
    {"player_signature", "string", "玩家签名"}, 
    {"avatar_frame", "int32", "头像框"}, 
    {"designation", "int32", "称号"}, 
    {"remarks_name", "string", "备注名称"},
}

--- 好友聊天信息
pt_friend_chat_info =
{    
    {"send_id", "int64str", "玩家id"}, 
    {"target_id", "int64str", "玩家id"}, 
    {"content", "string", "聊天内容"}, 
    {"time", "int32", "时间"}, 
    {"tid", "int32", "礼物"}, 
    {"state", "int8", "1发送 2领取"}, 
    {"content_type", "int8", "内容类型"}, 
    {"dialog_box_id", "int32", "聊天气泡"},
}

--- 玩家申请反馈
pt_friend_apply_reply =
{    
    {"friend_id", "int64str", "玩家id"}, 
    {"result", "int16", "结果0拒绝1同意"},
}

--- 技能信息
pt_skill_info =
{    
    {"id", "int32", "技能id"}, 
    {"lv", "int16", "等级"}, 
    {"extra_lv", "int16", "额外等级"},
}

--- 出战技能信息
pt_fight_skill_info =
{    
    {"id", "int32", "技能id"}, 
    {"pos", "int8", "位置"}, 
    {"is_unlock", "int8", "是否解锁 0：否 1：是"},
}

--- 装备位置和装备的道具id
pt_equip_pos =
{    
    {"pos", "int32", "装备所在的位置"}, 
    {"equip_id", "int32", "装备（芯片）的唯一id"},
}

--- 战员已装备的id列表
pt_hero_equip =
{    
    {"hero_id", "int32", "战员id"}, 
    {"equip_list", pt_equip_pos, "战员已装备的列表", "repeated"},
}

--- 战员基础数据
pt_hero_info =
{    
    {"id", "int32", "唯一id"}, 
    {"tid", "int32", "战员模板id"}, 
    {"level", "int16", "战员等级"}, 
    {"exp", "int32", "经验"}, 
    {"exp_max", "int32", "经验上限"}, 
    {"military_rank", "int16", "战员军阶"}, 
    {"evolution", "int16", "进化等级"}, 
    {"power", "int32", "战员实力"}, 
    {"is_lock", "int8", "是否上锁，1是0否"}, 
    {"is_like", "int8", "是否喜欢，1是0否"}, 
    {"color", "int16", "英雄品质"}, 
    {"relation_level", "int16", "战员亲密等级"}, 
    {"relation_exp", "int32", "亲密经验"}, 
    {"increases_lv", "int16", "战员增幅等级"}, 
    {"equip_list", pt_equip_pos, "已装备列表", "repeated"}, 
    {"attr_list", pt_attr, "属性列表", "repeated"}, 
    {"equip_attr_list", pt_attr, "装备属性列表", "repeated"}, 
    {"active_skill_list", pt_skill_info, "已激活主动技能列表", "repeated"}, 
    {"passive_skill_list", pt_skill_info, "已激活被动技能列表", "repeated"}, 
    {"fight_skill_list", pt_fight_skill_info, "当前出战技能列表", "repeated"}, 
    {"resonance_id_list", "int16", "已共鸣位置列表", "repeated"}, 
    {"egg_form", "int16", "战员蛋形态"}, 
    {"egg_id", "int32", "战员蛋品质id"}, 
    {"egg_lv", "int16", "战员蛋等级"}, 
    {"egg_attr_cal", "int16", "战员蛋属性关闭列表，列表内的属性为不计算", "repeated"},
}

--- 其他玩家战员基础数据
pt_other_hero_info =
{    
    {"id", "int32", "唯一id"}, 
    {"tid", "int32", "战员模板id"}, 
    {"level", "int16", "战员等级"}, 
    {"exp", "int32", "经验"}, 
    {"exp_max", "int32", "经验上限"}, 
    {"military_rank", "int16", "战员军阶"}, 
    {"evolution", "int16", "进化等级"}, 
    {"power", "int32", "战员实力"}, 
    {"is_lock", "int8", "是否上锁，1是0否"}, 
    {"is_like", "int8", "是否喜欢，1是0否"}, 
    {"pos", "int8", "展示战员位置"}, 
    {"color", "int16", "战员品质"}, 
    {"relation_level", "int16", "战员亲密等级"}, 
    {"relation_exp", "int32", "亲密经验"}, 
    {"increases_lv", "int16", "战员增幅等级"}, 
    {"fashion_body_id", "int32", "衣服时装id"}, 
    {"equip_list", pt_prop_bag_detail, "已装备列表", "repeated"}, 
    {"attr_list", pt_attr, "属性列表", "repeated"}, 
    {"equip_attr_list", pt_attr, "装备属性列表", "repeated"}, 
    {"active_skill_list", pt_skill_info, "已激活主动技能列表", "repeated"}, 
    {"passive_skill_list", pt_skill_info, "已激活被动技能列表", "repeated"}, 
    {"fight_skill_list", pt_fight_skill_info, "当前出战技能列表", "repeated"}, 
    {"resonance_id_list", "int16", "已共鸣位置列表", "repeated"},
}

--- 技能时间轴
pt_battle_skill_procedure =
{   
}

--- 指令时间轴
pt_battle_cmd_procedure =
{   
}

--- 战斗结束时守方概况
pt_battle_result =
{   
}

--- 副本信息
pt_dup_info =
{    
    {"type", "int8", "副本类型"}, 
    {"curl_dup", "int16", "当前副本id 0表示全通关"}, 
    {"max_dup", "int16", "最高通关副本id"}, 
    {"pass_times", "int8", "剩余通关次数"}, 
    {"buy_times", "int8", "已购买次数"}, 
    {"pass_dup", "int16", "通关副本", "repeated"},
}

--- 战斗战员技能栏
pt_battle_hero_skill =
{    
    {"pos", "int8", "技能位置"}, 
    {"id", "int32", "技能id"},
}

--- 战斗战员数据
pt_battle_hero =
{    
    {"id", "int32", "战员id"}, 
    {"tid", "int32", "战员模板id"}, 
    {"type", "int8", "战斗对象类型"}, 
    {"pos", pt_pos, "站位"}, 
    {"max_hp", "int64str", "最大血量"}, 
    {"hp", "int64str", "血量"}, 
    {"rage", "int32", "怒气值"}, 
    {"skill_soul", "int8", "魂玉"}, 
    {"lv", "int16", "等级"}, 
    {"evolution", "int16", "星级"}, 
    {"color", "int16", "颜色品质"}, 
    {"skill_list", pt_battle_hero_skill, "技能列表", "repeated"}, 
    {"body_fashion_id", "int16", "衣服时装id"}, 
    {"hit_stun", "int16", "硬直"}, 
    {"max_hit_stun", "int16", "硬直最大值"}, 
    {"auto_battle_rule", "int16", "战员自动战斗规则"}, 
    {"body_fashion_color_id", "int16", "衣服时装炫彩id"},
}

--- 战斗助战数据
pt_battle_assist_fight =
{    
    {"hero_tid", "int32", "战员模板id"}, 
    {"hero_lv", "int16", "战员等级"}, 
    {"hero_evolution", "int16", "战员星级"}, 
    {"skill_id_list", "int32", "技能id列表", "repeated"},
}

--- 战斗玩家数据
pt_battle_player =
{    
    {"player_id", "int64str", "玩家id"}, 
    {"player_name", "string", "玩家名字"}, 
    {"player_lv", "int16", "玩家等级"}, 
    {"total_hp", "int64str", "队伍总血量"}, 
    {"avatar", "int16", "玩家头像"}, 
    {"hero_list", pt_battle_hero, "战员列表", "repeated"}, 
    {"qte_energy", "int16", "力场值"}, 
    {"assist_fight_list", pt_battle_assist_fight, "助战技能列表", "repeated"},
}

--- 战中效果数据
pt_battle_effect_info =
{    
    {"type", "int8", "效果类型 1-伤害 2-加buff 3-治疗"}, 
    {"priority", "int8", "优先级"}, 
    {"count", "int64str", "效果值"}, 
    {"count_list", "int64str", "额外效果值", "repeated"},
}

--- 战中战员影响数据
pt_battle_effect_hero =
{    
    {"side", "int8", "目标战员势力"}, 
    {"hero_id", "int32", "目标战员id"}, 
    {"effect_list", pt_battle_effect_info, "效果列表", "repeated"},
}

--- 战中行动结果
pt_battle_action_result =
{    
    {"qte_val", "int8", "QTE触发值, 没有时为0"}, 
    {"hero_list", pt_battle_effect_hero, "战员影响列表", "repeated"}, 
    {"has_extra_call", "int8", "是否有额外技能要释放"}, 
    {"is_final_hit", "int8", "是否战斗最后一击"},
}

--- 回合结束移除buff列表内容
pt_battle_del_buff_detail =
{    
    {"buff_id", "int32", "buff id"}, 
    {"layer", "int8", "移除层数"}, 
    {"round", "int8", "剩余回合数"},
}

--- 回合结束移除buff列表
pt_battle_del_buff =
{    
    {"side", "int8", "目标战员势力"}, 
    {"hero_id", "int32", "目标战员id"}, 
    {"buff_list", pt_battle_del_buff_detail, "被移除buff id列表", "repeated"},
}

--- 战斗统计信息
pt_battle_statistic =
{    
    {"side", "int8", "目标战员势力"}, 
    {"hero_id", "int32", "目标战员id"}, 
    {"tid", "int32", "模板ID"}, 
    {"is_mon", "int8", "是否怪物"}, 
    {"evolution", "int16", "星级"}, 
    {"lv", "int16", "等级"}, 
    {"is_call", "int8", "是否召唤物"}, 
    {"info", pt_attr_int_list, "统计条目", "repeated"},
}

--- 商店物品数据
pt_shop_data =
{    
    {"id", "int32", "id"}, 
    {"type", "int8", "商店类型标签"}, 
    {"item_tid", "int32", "道具模板id"}, 
    {"item_num", "int32", "道具数量"}, 
    {"pay_type", "int8", "支付类型"}, 
    {"pay_tid", "int32", "兑换道具tid"}, 
    {"price", "int32", "销售价格"}, 
    {"old_price", "int32", "原价"}, 
    {"discount", "int32", "折扣"}, 
    {"player_lv", "int16", "玩家等级：下限"}, 
    {"hide_lvl", "int16", "玩家等级：上限"}, 
    {"limit_num", "int16", "限制购买次数"}, 
    {"limit_type", "int16", "限购类型"}, 
    {"buy_times", "int16", "已购买次数"}, 
    {"sort", "int16", "排序"}, 
    {"resume", "int32", "前端描述语言包"}, 
    {"stage", "int16", "盟约势力等级限制"}, 
    {"lock", "int16", "是否已锁定 1是 0否"}, 
    {"tag", "int8", "角标（1-免费，2-折扣，3-热销）"}, 
    {"drop_id", "int32", "掉落包id"}, 
    {"value", "int16", "价值"}, 
    {"guild_lv", "int16", "联盟等级限制"}, 
    {"begin_time", "int32", "开始时间"}, 
    {"end_time", "int32", "结束时间"},
}

--- 剧情战斗自选支援战员列表
pt_battle_support_hero_list =
{    
    {"team_index", "int8", "小队序号"}, 
    {"support_id_list", "int32", "怪物id列表", "repeated"},
}

--- 阵型中的战员
pt_formation_hero_info =
{    
    {"pos", "int8", "战员位置"}, 
    {"is_captain", "int8", "是否队长"}, 
    {"hero_id", "int32", "战员id"}, 
    {"tid", "int32", "战员tid"}, 
    {"hero_source", "int8", "战员来源：1、玩家自己的战员 2、主线关卡剧情外援 3、竞技场敌方玩家或机器人"},
}

--- 阵型中的助战战员
pt_formation_assist_fight =
{    
    {"pos", "int8", "战员位置"}, 
    {"hero_id", "int32", "战员id"},
}

--- 战员阵型数据
pt_hero_formation =
{    
    {"team_id", "int16", "队列id"}, 
    {"formation_id", "int16", "阵型id"}, 
    {"is_ready", "int8", "是否出战"}, 
    {"name", "string", "队列名字"}, 
    {"formation_hero_list", pt_formation_hero_info, "战员列表", "repeated"}, 
    {"assist_fight_list", pt_formation_assist_fight, "助战战员列表", "repeated"}, 
    {"pet_id", "int32", "锚驴id"},
}

--- 呐源限定结束时间
pt_select_plus =
{    
    {"act_tid", "int32", "激活tid"}, 
    {"end_time", "int32", "结束时间"},
}

--- 招募数据
pt_recruit_info =
{    
    {"recruit_id", "int16", "招募id"}, 
    {"recruit_daily_times", "int32", "今日招募已抽次数"}, 
    {"recruit_activity_times", "int32", "活动期间累计招募已抽次数"}, 
    {"guaranteed_times", "int32", "保底已抽次数"}, 
    {"guaranteed_limit", "int32", "保底最大次数"}, 
    {"is_guaranteed_award", "int8", "大保底奖励是否已领取 1是0否"}, 
    {"free_times", "int16", "已免费次数"}, 
    {"select_tid", "int16", "自选tid"}, 
    {"first_week", "int8", "呐源首周标记"}, 
    {"select_plus_list", pt_select_plus, "呐源限定结束时间", "repeated"},
}

--- 招募日志
pt_recruit_log =
{    
    {"time", "int64str", "时间戳"}, 
    {"item_tid", "int32", "战员模板id"},
}

--- 单次招募获得的数据
pt_recruit_once =
{    
    {"tid", "int32", "战员tid"}, 
    {"item_list", pt_prop_award, "转换的道具列表（战员转化为碎片）", "repeated"},
}

--- 战员预览数据
pt_hero_pre_info =
{    
    {"id", "int32", "唯一id"}, 
    {"tid", "int32", "战员模板id"}, 
    {"level", "int16", "战员等级"}, 
    {"exp", "int32", "经验"}, 
    {"military_rank", "int16", "战员军阶"}, 
    {"evolution", "int16", "进化等级"}, 
    {"color", "int16", "战员品质"}, 
    {"is_lock", "int8", "是否上锁，1是0否"}, 
    {"is_like", "int8", "是否喜欢，1是0否"}, 
    {"relation_level", "int16", "战员亲密等级"}, 
    {"relation_exp", "int32", "亲密经验"}, 
    {"increases_lv", "int16", "战员增幅等级"}, 
    {"power", "int32", "战员实力"}, 
    {"active_skill_list", pt_skill_info, "已激活主动技能列表", "repeated"}, 
    {"empty_equip_pos_list", "int8", "装备的空槽部位列表", "repeated"}, 
    {"resonance_id_list", "int16", "共鸣位置列表", "repeated"},
}

--- 无法删除的战员
pt_cannot_del_hero =
{    
    {"hero_id", "int32", "战员id"}, 
    {"reason", "int8", "原因，1出战中,2竞技场,3展示面板,4上锁,5导力中"},
}

--- 竞技场战员数据
pt_arena_hero_info =
{    
    {"tid", "int32", "战员模板id"}, 
    {"level", "int16", "战员等级"}, 
    {"type", "int16", "战员定位"}, 
    {"evolution", "int16", "战员星级"}, 
    {"power", "int32", "战员战力"}, 
    {"body_fashion_id", "int16", "衣服时装id"}, 
    {"resonance_id_list", "int16", "共鸣位置列表", "repeated"},
}

--- 竞技场敌人
pt_arena_enemy =
{    
    {"id", "int64str", "玩家id"}, 
    {"rank", "int16", "排名"}, 
    {"is_robot", "int8", "是否机器人，1是0否"}, 
    {"score", "int32", "积分"}, 
    {"lv", "int16", "等级"}, 
    {"avatar", "int16", "头像"}, 
    {"avatar_frame", "int16", "头像框"}, 
    {"power", "int32", "战力"}, 
    {"name", "string", "玩家名字"}, 
    {"segment", "int16", "段位"}, 
    {"hero_list", pt_arena_hero_info, "竞技场战员列表", "repeated"},
}

--- 竞技场战员位置
pt_arena_hero_pos =
{    
    {"hero_tid", "int32", "战员tid"}, 
    {"lv", "int16", "战员等级"}, 
    {"evolution", "int16", "战员星级"}, 
    {"pos", pt_pos, "站位"}, 
    {"body_fashion_id", "int16", "衣服时装id"},
}

--- 竞技场日志
pt_arena_log =
{    
    {"id", "int64str", "敌方玩家id"}, 
    {"name", "string", "敌方玩家名字"}, 
    {"avatar", "int16", "敌方玩家头像"}, 
    {"avatar_frame", "int16", "敌方玩家头像框"}, 
    {"lv", "int16", "敌方玩家等级"}, 
    {"is_robot", "int8", "敌方是否机器人"}, 
    {"result", "int8", "战斗结果,1获胜0失败"}, 
    {"is_self_attack", "int8", "是否玩家自己进攻,1是0否"}, 
    {"old_score", "int16", "我方旧积分"}, 
    {"new_score", "int16", "我方新积分"}, 
    {"battle_id", "int64str", "战斗id"}, 
    {"time", "int64str", "时间"}, 
    {"self_segment", "int16", "我方段位"}, 
    {"enemy_segment", "int16", "敌方段位"}, 
    {"self_formation_tid", "int16", "我方阵型tid"}, 
    {"enemy_formation_tid", "int16", "敌方阵型tid"}, 
    {"can_replay", "int8", "是否有回放"}, 
    {"self_pos", pt_arena_hero_pos, "我方战员位置", "repeated"}, 
    {"enemy_pos", pt_arena_hero_pos, "敌方战员位置", "repeated"}, 
    {"show_id", "string", "战报展示id"},
}

--- 战员回忆录
pt_hero_biography =
{    
    {"biography_id", "int32", "回忆录id"}, 
    {"hero_tid", "int32", "战员tid"}, 
    {"is_follow", "int8", "是否关注"}, 
    {"pass_dup", "int32", "已通关副本列表", "repeated"}, 
    {"history_pass_dup", "int32", "历史已通关副本列表", "repeated"}, 
    {"challenge_times", "int16", "剩余挑战次数"},
}

--- 战斗回放具体信息
pt_battle_replay_detail =
{    
    {"id", "int32", "回放ID"}, 
    {"field_id", "int16", "战场ID"}, 
    {"result", "int8", "战斗结果"},
}

--- 战斗回放信息
pt_battle_replay_info =
{    
    {"type", "int32", "战斗类型"}, 
    {"replay_list", pt_battle_replay_detail, "战斗回放具体信息", "repeated"},
}

--- 头像信息
pt_avatar_info =
{    
    {"avatar_id", "int32", "头像id"}, 
    {"expired_time", "int32", "过期时间，时间戳（s）"}, 
    {"is_like", "int8", "是否喜欢，1是0否"},
}

--- 头像框信息
pt_avatar_frame_info =
{    
    {"avatar_frame_id", "int32", "头像框id"}, 
    {"expired_time", "int32", "过期时间，时间戳（s）"}, 
    {"is_like", "int8", "是否喜欢，1是0否"},
}

--- 聊天气泡信息
pt_dialog_box_info =
{    
    {"dialog_box_id", "int32", "头像框id"}, 
    {"expired_time", "int32", "过期时间，时间戳（s）"}, 
    {"is_like", "int8", "是否喜欢，1是0否"},
}

--- 称号信息
pt_designation_info =
{    
    {"designation_id", "int32", "称号id"}, 
    {"expired_time", "int32", "过期时间，时间戳（s）"}, 
    {"is_like", "int8", "是否喜欢，1是0否"},
}

--- 表情信息
pt_emoji_info =
{    
    {"emoji_id", "int32", "表情id"}, 
    {"expired_time", "int32", "过期时间，时间戳（s）"},
}

--- 公告信息
pt_announce_info =
{    
    {"id", "int32", "公告id"}, 
    {"type", "int8", "页签类型"}, 
    {"name", "string", "公告名称"}, 
    {"illustration", "string", "插画资源"}, 
    {"title", "string", "标题"}, 
    {"content", "string", "内容"}, 
    {"web_url", "string", "问卷url"}, 
    {"uicode", "int32", "跳转id"}, 
    {"sort", "int16", "排序id"},
}

--- 服务器已读模块信息
pt_module_read_info =
{    
    {"type", "int32", "类型"}, 
    {"id_list", "int32", "已读id列表", "repeated"},
}

--- 批量使用tid结构
pt_use_tid_info =
{    
    {"tid", "int32", "道具模版id"}, 
    {"target", "int32", "作用对象：0-玩家，其余：战员id"}, 
    {"count", "int16", "物品数量"},
}

--- 展示战员结构
pt_show_hero_info =
{    
    {"pos", "int8", "位置"}, 
    {"hero_id", "int32", "战员id"},
}

--- 充值配置信息
pt_pay_info =
{    
    {"item_id", "string", "充值id"}, 
    {"item_type", "int8", "充值类型"}, 
    {"amount", "int32", "人民币/分"}, 
    {"gold", "int32", "元宝"}, 
    {"plus_gold", "int32", "赠送元宝数"}, 
    {"detail_id", "string", "详细ID"},
}

--- 剧情信息
pt_story_info =
{    
    {"line_id", "int16", "分线ID"}, 
    {"story_id", "int32", "剧情ID"},
}

--- 引导信息
pt_guide_info =
{    
    {"line_id", "int16", "分线ID"}, 
    {"guide_id", "int16", "引导ID"},
}

--- 活动结构
pt_activity_info =
{    
    {"id", "int16", "id"}, 
    {"begin_time", "int32", "开始时间"}, 
    {"end_time", "int32", "结束时间"}, 
    {"remove_time", "int32", "活动移除时间"}, 
    {"function_id", "int32", "功能id"},
}

--- 代号希望关卡信息
pt_code_hope_city_info =
{    
    {"city_id", "int16", "城池id"}, 
    {"round_pass_time", "int32", "本轮通关时间"}, 
    {"first_pass_flag", "int8", "首通标识0-从未通过1-之前通过过"}, 
    {"history_pass_time", "int32", "历史最短通关时间"},
}

--- 代号希望战员信息
pt_code_hope_hero_info =
{    
    {"hero_id", "int32", "战员id"}, 
    {"had_cost_stamina", "int16", "已经消耗耐力值"},
}

--- 代号希望章节信息
pt_code_hope_chapter_info =
{    
    {"chapter_id", "int16", "城池id"}, 
    {"city_list", pt_code_hope_city_info, "城池信息", "repeated"}, 
    {"hero_list", pt_code_hope_hero_info, "战员信息列表", "repeated"}, 
    {"active_buff", "int32", "激活的buffId", "repeated"}, 
    {"gain_state", "int8", "通关奖励状态 0-未满足 1-可领取 2-已完成"}, 
    {"is_open", "int8", "是否开启挑战 1-是 0-否"}, 
    {"round_fast_pass", "int32", "本轮整章最短通关时间"},
}

--- 区域探险区域信息
pt_area_explore_info =
{    
    {"area_id", "int32", "区域id"}, 
    {"today_explore_times", "int16", "今日已探险次数"}, 
    {"rand_event_id", "int32", "随机出来的事件id"}, 
    {"state", "int8", "状态0-未开始1-进行中2-已完成未领取"}, 
    {"end_time", "int32", "结束探险的时间戳"}, 
    {"need_time", "int32", "探索所需秒数"}, 
    {"hero_id_list", "int32", "探险战员id列表", "repeated"},
}

--- 战员时装信息
pt_fashion_info =
{    
    {"fashion_id", "int16", "时装id"}, 
    {"is_wear", "int8", "是否穿戴"}, 
    {"fashion_type", "int8", "1-衣服时装 | 2-武器时装"},
}

--- 战员时装列表
pt_hero_fashion_info =
{    
    {"hero_id", "int32", "战员id"}, 
    {"fashion_info", pt_fashion_info, "时装信息", "repeated"},
}

--- 默示之塔城池信息
pt_implied_city_data =
{    
    {"city_id", "int16", "城池id"}, 
    {"round_pass_time", "int32", "本轮通关时间"}, 
    {"first_pass_flag", "int8", "首通标识0-从未通过1-之前通过过"}, 
    {"history_pass_time", "int32", "历史最短通关时间"}, 
    {"pass_select_buff", "int32", "buff_id 0-放弃"},
}

--- 默示之塔章节信息
pt_implied_chapter_info =
{    
    {"chapter_id", "int16", "章节id"}, 
    {"abnormal_id_list", "int32", "异常列表", "repeated"},
}

--- 家具放置信息
pt_dormitory_put_info =
{    
    {"row", "int16", "中心点行的位置"}, 
    {"columns", "int16", "中心点列位置"}, 
    {"location", "int16", "位置1-地板，2-左边的墙等等"}, 
    {"direction", "int16", "家具摆放的方向"},
}

--- 家具摆放信息
pt_furniture_info =
{    
    {"id", "int32", "家具唯一id"}, 
    {"tid", "int32", "家具tid"}, 
    {"put_info", pt_dormitory_put_info, "摆放位置信息"},
}

--- 家具挪动信息
pt_furniture_move_info =
{    
    {"id", "int32", "家具唯一id"}, 
    {"tid", "int32", "家具tid"}, 
    {"move", "int8", "挪动信息 0-宿舍里面自己挪动，1-从宿舍到包，2-从包到宿舍"}, 
    {"put_info", pt_dormitory_put_info, "摆放位置信息"},
}

--- 简单迷宫信息
pt_maze_info =
{    
    {"maze_id", "int16", "迷宫id"}, 
    {"pass_time", "int32", "通过时间"}, 
    {"left_gorgeous_box", "int32", "剩余华丽箱子数量"}, 
    {"left_normal_box", "int32", "剩余普通箱子数量"}, 
    {"left_boss", "int32", "剩余boss数量"}, 
    {"box_total_num", "int32", "宝箱总数量(包括通关箱子)"}, 
    {"enter_flag", "int8", "本轮开启后是否进入过的标识，0-未进入1-进入过"},
}

--- 迷宫事件信息
pt_maze_event_info =
{    
    {"id", "int32", "位置id"}, 
    {"event_id", "int32", "事件id"}, 
    {"state", "int16", "事件状态"}, 
    {"direction", "int8", "方向", "repeated"}, 
    {"event_effect", "int32", "事件参数", "repeated"},
}

--- 迷宫战员信息
pt_maze_hero_info =
{    
    {"hero_id", "int32", "战员id"}, 
    {"mon_id", "int32", "怪物Id(怪物表id)"}, 
    {"hp_now", "int64str", "当前血量"}, 
    {"hp_max", "int64str", "最大血量"}, 
    {"type", "int8", "类型1-自己2-支援3-对方"},
}

--- 迷宫格子更新信息
pt_grid_info =
{    
    {"id", "int32", "位置id(格子id)"}, 
    {"base_event_id", "int32", "基础事件id"}, 
    {"state", "int16", "0-删除，1-新增"},
}

--- 宿舍战员入驻信息
pt_settled_hero_info =
{    
    {"id", "int32", "战员id"}, 
    {"pos", "int8", "战员位置"},
}

--- 宿舍信息
pt_dormitory_info =
{    
    {"dormitory_id", "int16", "宿舍id"}, 
    {"furniture_list", pt_furniture_info, "家具列表", "repeated"}, 
    {"comfort", "int16", "舒适度"}, 
    {"add_hero_stamina_speed", "int8", "加成的战员疲劳恢复速度"},
}

--- 战术训练具体信息
pt_tactics_training_info =
{    
    {"chapter", "int32", "副本类型"}, 
    {"now_stage_list", "int32", "当前开启的关卡id", "repeated"}, 
    {"pass_stage_list", "int32", "已通关关卡id", "repeated"},
}

--- 战场异闻
pt_branch_story_info =
{    
    {"chapter", "int32", "副本类型"}, 
    {"now_stage_list", "int32", "当前开启的关卡id", "repeated"}, 
    {"pass_stage_list", "int32", "已通关关卡id", "repeated"},
}

--- 完成成就统计
pt_complete_achieve_info =
{    
    {"gain_point", "int32", "已领取的奖励中获得的点数"}, 
    {"draw_times", "int16", "可领取奖励次数"}, 
    {"type", "int16", "页签分类"},
}

--- 直购礼包商品信息
pt_direct_gift_info =
{    
    {"id", "int32", "id"}, 
    {"type", "int8", "商店类型标签"}, 
    {"item_tid", "int32", "道具tid"}, 
    {"item_num", "int16", "道具数量"}, 
    {"pay_type", "int16", "支付类型"}, 
    {"price", "int32", "销售价格"}, 
    {"discount", "int32", "折扣"}, 
    {"limit_num", "int16", "限制购买次数"}, 
    {"limit_type", "int16", "限购类型"}, 
    {"end_time", "int32", "结束时间"}, 
    {"sort", "int16", "排序"}, 
    {"tag", "int8", "角标（1-免费，2-折扣，3-热销）"}, 
    {"drop_id", "int32", "掉落包id"}, 
    {"value", "int16", "价值"}, 
    {"color", "int8", "颜色"},
}

--- 副本列表
pt_dup_buff_list =
{    
    {"buff_id", "int32", "buff id"}, 
    {"improve_efficiency", "int32", "提升效率保留一位小数,最后一位是小数"},
}

--- 多条预览属性
pt_attr_preview_all =
{    
    {"lv", "int32", "预览等级"}, 
    {"attr_list", pt_attr, "属性显示", "repeated"},
}

--- 等级奖励
pt_lv_reward =
{    
    {"hero_tid", "int32", "战员tid"}, 
    {"received_ids", "int16", "已领取的奖励id", "repeated"},
}

--- 亲密度奖励
pt_relation_reward =
{    
    {"hero_tid", "int32", "战员tid"}, 
    {"received_ids", "int16", "已领取的奖励id", "repeated"}, 
    {"received_story_lvs", "int16", "已领取心语集奖励lv列表", "repeated"},
}

--- 战员的助战信息
pt_hero_assist_fight =
{    
    {"hero_id", "int32", "战员id"}, 
    {"skill_id_list", "int32", "助战技能id列表", "repeated"},
}

--- 加工厂单个生产模块信息
pt_factory_module =
{    
    {"module_id", "int16", "模块id 1：原料 2：物资 3：芯片 4：礼物 5：盟约"}, 
    {"formula_id", "int32", "生产的订单id 0：未生产"}, 
    {"formula_num", "int32", "生产的订单数量"}, 
    {"need_time", "int32", "生产结束的时间戳（秒）"},
}

--- 加工厂产能信息
pt_factory_speed_material =
{    
    {"speed_material", "int32", "当前产能值"}, 
    {"next_add_time", "int32", "下一次自然增加产能的时间戳（秒） 0：不增加"}, 
    {"all_add_time", "int32", "恢复所有产能的时间戳（秒） 0：不增加"}, 
    {"buy_times", "int8", "产能已购买次数"},
}

--- 势力天赋信息
pt_forces_talent_info =
{    
    {"id", "int16", "天赋id"}, 
    {"level", "int16", "天赋等级"}, 
    {"pre_show_value", "int32", "当前效果值列表", "repeated"}, 
    {"next_show_value", "int32", "下一效果值列表", "repeated"},
}

--- 锚点空间事件信息
pt_main_explore_event =
{    
    {"event_id", "int16", "事件id"}, 
    {"event_effect", "int32", "事件效果（动态效果，如：营地回血剩余次数）", "repeated"},
}

--- 锚点空间战员信息
pt_main_explore_hero =
{    
    {"type", "int8", "类型 0：自己 1：支援"}, 
    {"hero_id", "int32", "战员id"}, 
    {"now_hp_ratio", "int8", "剩余血量百分比 0-100"},
}

--- 锚点空间返回地图的效果表现数据
pt_main_explore_return_map_effect =
{    
    {"event_id", "int32", "事件id"}, 
    {"args_int", "int32", "效果参数（如：战斗结束后返回地图获得/损失的血量）", "repeated"},
}

--- 使徒之战2 Boss难度数据
pt_apostles2_dup =
{    
    {"dup_id", "int16", "副本id"}, 
    {"completed_target", "int16", "已完成的关卡目标id列表", "repeated"}, 
    {"is_unlock", "int8", "是否解锁 0：否 1：是"},
}

--- 使徒之战2 Boss数据
pt_apostles2_boss =
{    
    {"id", "int16", "Boss id"}, 
    {"dup_list", pt_apostles2_dup, "boss难度列表", "repeated"}, 
    {"lock_hero_list", "int32", "锁定的战员id列表", "repeated"},
}

--- 战员动作
pt_hero_action =
{    
    {"model_id", "int32", "模型id"}, 
    {"action_list", "int16", "动作id列表", "repeated"},
}

--- 元素塔关卡信息
pt_element_tower_info =
{    
    {"id", "int16", "副本id"}, 
    {"cur_dup", "int16", "当前副本id 0表示全通关"}, 
    {"max_dup", "int16", "最大关卡"}, 
    {"times", "int8", "剩余挑战次数"},
}

--- 战舰技能
pt_war_ship_skill =
{    
    {"skill_id", "int16", "技能id"}, 
    {"skill_lv", "int8", "技能等级"},
}

--- 战舰建筑
pt_war_ship_building =
{    
    {"building_id", "int16", "建筑id"}, 
    {"lv", "int8", "建筑等级"}, 
    {"hero_list", "int32", "入驻战员tid列表", "repeated"}, 
    {"item_tid", "int32", "生产道具tid"}, 
    {"produce_num", "int16", "仓库资源数量"}, 
    {"max_num", "int16", "仓库最大数量"}, 
    {"speed", "int8", "生产速率（效率加成后）"}, 
    {"start_time", "int32", "生产开始时间"}, 
    {"produce_time", "int32", "下一次生产完成时间"}, 
    {"full_time", "int32", "生产满的时间"}, 
    {"skill_list", pt_war_ship_skill, "建筑加成的技能id列表", "repeated"},
}

--- 战舰战员位置
pt_war_ship_hero_pos =
{    
    {"hero_tid", "int32", "战员tid"}, 
    {"pos", "int8", "入驻位置"},
}

--- 战舰战员
pt_war_ship_hero =
{    
    {"hero_tid", "int32", "战员tid"}, 
    {"building_id", "int16", "入驻建筑id"}, 
    {"pos", "int8", "入驻位置"}, 
    {"stamina", "int16", "剩余疲劳值"}, 
    {"stamina_time", "int32", "疲劳清零/回满的时间戳"}, 
    {"speed", "int16", "疲劳值消耗/恢复速率"}, 
    {"skill_list", pt_war_ship_skill, "解锁的技能列表", "repeated"},
}

--- 战舰派遣邬
pt_war_ship_explore =
{    
    {"explore_id", "int16", "区域id"}, 
    {"task_id", "int16", "任务id"}, 
    {"state", "int8", "状态 1：待派遣 2：派遣中 3：已完成 4：等待刷新"}, 
    {"end_time", "int32", "派遣结束时间戳"}, 
    {"hero_list", "int32", "派遣战员列表", "repeated"},
}

--- 战舰派遣邬区域一键探索
pt_war_ship_explore_begin_one_key =
{    
    {"building_id", "int16", "建筑id"}, 
    {"explore_id", "int16", "区域id"}, 
    {"hero_list", pt_war_ship_hero_pos, "派遣的战员列表", "repeated"},
}

--- 建筑区域信息
pt_war_ship_explore_info =
{    
    {"building_id", "int16", "建筑id"}, 
    {"explore_info", pt_war_ship_explore, "区域信息"},
}

--- 战斗格子参数
pt_event_cycle_postwar_args =
{    
    {"args", "int32", "参数 {1-招募, 招募券id} or {2-收藏品, 收藏品id} or {3-货币, 数量}", "repeated"}, 
    {"is_used", "int8", "是否已使用"},
}

--- 选项事件参数
pt_event_cycle_option_args =
{    
    {"event_id", "int32", "事件id"}, 
    {"times", "int8", "次数"}, 
    {"args", "int32", "参数", "repeated"},
}

--- 地图格子信息
pt_event_cycle_cell_info =
{    
    {"id", "int16", "格子id"}, 
    {"event_id", "int32", "事件id"}, 
    {"original_event_id", "int32", "原始事件id(用来展示事件名)"}, 
    {"normal_args", "int32", "普通格子参数", "repeated"}, 
    {"option_args", pt_event_cycle_option_args, "选项事件参数", "repeated"}, 
    {"postwar_args", pt_event_cycle_postwar_args, "战斗后格子参数", "repeated"},
}

--- 地图线路信息
pt_event_cycle_line_info =
{    
    {"id", "int16", "线路id"}, 
    {"layer", "int8", "当前层"}, 
    {"cur_cell", "int16", "当前所在格子"}, 
    {"hero_list", "int32", "已招募战员列表", "repeated"}, 
    {"pass_cell", "int16", "已行走格子", "repeated"}, 
    {"cell_info", pt_event_cycle_cell_info, "格子信息", "repeated"},
}

--- 历史信息
pt_event_cycle_history_info =
{    
    {"exp", "int16", "经验"}, 
    {"lv", "int16", "等级"}, 
    {"max_difficulty", "int8", "通关最大难度"}, 
    {"pass_times", "int32", "通关次数"}, 
    {"collage_list", "int32", "收藏品列表", "repeated"}, 
    {"unlock_strategy", "int8", "解锁策略id", "repeated"}, 
    {"gained_lv_reward_list", "int16", "已领取等级奖励列表", "repeated"}, 
    {"gained_collage_reward_list", "int16", "已领取收藏品奖励列表", "repeated"}, 
    {"gained_showroom_reward_list", "int16", "已领取陈列室奖励列表", "repeated"},
}

--- 招募券
pt_event_cycle_ticket_info =
{    
    {"pos", "int8", "位置id"}, 
    {"ticket_id", "int8", "招募券id"}, 
    {"hero_id", "int32", "战员id"}, 
    {"is_used", "int8", "1-已使用"},
}

--- 事影循回战前信息
pt_event_cycle_prewar_info =
{    
    {"difficulty", "int8", "难度"}, 
    {"step", "int8", "当前步骤"}, 
    {"strategy", "int8", "策略id"}, 
    {"cur_ticket", "int16", "当前选中招募券id"}, 
    {"ticket_info", pt_event_cycle_ticket_info, "可使用招募券列表", "repeated"},
}

--- 事影循回资源信息
pt_event_cycle_resource_info =
{    
    {"reason_point", "int16", "理智值"}, 
    {"reason_point_limit", "int16", "理智值上限"}, 
    {"hope_point", "int16", "希望值"}, 
    {"coin", "int16", "玩法货币"}, 
    {"lv", "int16", "玩法等级"}, 
    {"exp", "int16", "玩法经验"},
}

--- 事影循回商品信息
pt_event_cycle_goods_info =
{    
    {"id", "int32", "商品id"}, 
    {"type", "int8", "1-收藏品,2-招募券"}, 
    {"price", "int16", "商品价格"}, 
    {"is_buy", "int8", "是否已购买"},
}

--- 事影循回商店信息
pt_event_cycle_normal_shop =
{    
    {"goods_list", pt_event_cycle_goods_info, "商品列表", "repeated"}, 
    {"cur_ticket", "int16", "当前招募券id,id不为0时要进入招募界面"},
}

--- 事影循回投资信息
pt_event_cycle_invest_shop =
{    
    {"lv", "int16", "等级"}, 
    {"exp", "int16", "经验"}, 
    {"use_coin", "int16", "可使用资产"}, 
    {"all_coin", "int16", "总投资硬币数"}, 
    {"deposit_coin_limit", "int16", "当前投资数量限制"}, 
    {"withdraw_coin_limit", "int16", "当前取出数量限制"}, 
    {"can_withdraw", "int16", "是否可以取款"}, 
    {"refresh_times", "int16", "当前刷新次数"},
}

--- 结算统计
pt_event_cycle_settle_stats =
{    
    {"id", "int16", "结算id"}, 
    {"count", "int16", "次数"},
}

--- 天赋信息
pt_event_cycle_talent_info =
{    
    {"talent_point", "int16", "天赋点数"}, 
    {"talent_list", "int16", "已解锁的天赋列表", "repeated"}, 
    {"play_exp_rate", "int32", "玩法级经验转换率(万分比)"}, 
    {"battle_exp_rate", "int32", "战斗经验转换率(万分比)"}, 
    {"add_init_coin", "int16", "初始增加玩法币数量"}, 
    {"add_init_reason", "int16", "初始增加理智值数量"}, 
    {"unlock_collage", "int32", "已解锁的收藏品列表", "repeated"},
}

--- 招募战员品质希望值
pt_event_cycle_recruit_color_cost =
{    
    {"color", "int8", "战员品质"}, 
    {"hope", "int16", "消耗希望值"},
}

--- 招募战员属性希望值
pt_event_cycle_recruit_ele_cost =
{    
    {"ele", "int8", "战员属性"}, 
    {"type", "int8", "1-减少消耗希望值,2-增加消耗希望值"}, 
    {"hope", "int16", "额外消耗值"},
}

--- 对话段落信息
pt_dialogue_part =
{    
    {"part_id", "int32", "段落id"}, 
    {"talk_list", "int16", "已对话的id列表", "repeated"},
}

--- 目标对话信息
pt_dialogue_target =
{    
    {"target_id", "int32", "目标id"}, 
    {"part_list", pt_dialogue_part, "段落列表", "repeated"},
}

--- 排行榜数据结构
pt_rank_info =
{    
    {"rank", "int32", "排名"}, 
    {"player_id", "int64str", "玩家id"}, 
    {"player_name", "string", "名字"}, 
    {"avatar_id", "int32", "头像"}, 
    {"avatar_frame", "int32", "头像框"}, 
    {"designation", "int32", "称号"}, 
    {"rank_val", "int32", "排行值"}, 
    {"guild_name", "string", "公会名称"},
}

--- 支线副本章节信息
pt_branch_plot_chapter =
{    
    {"chapter_id", "int16", "章节id"}, 
    {"pass_list", "int16", "已通关的副本id", "repeated"},
}

--- 商店物品数据
pt_activity_shop =
{    
    {"id", "int16", "商品id"}, 
    {"buy_times", "int16", "已购买次数"},
}

--- 保护刁民通关信息
pt_protect_people_dup =
{    
    {"dup_id", "int16", "副本id"}, 
    {"star_list", "int16", "已获得星星", "repeated"},
}

--- 跑酷玩法信息
pt_parkour_info =
{    
    {"id", "int16", "关卡id"}, 
    {"point", "int16", "分数(胜利或失败都有分数)"},
}

--- 小游戏玩法信息
pt_mini_game_dup_base =
{    
    {"id", "int16", "关卡id"}, 
    {"point", "int32", "分数(胜利或失败都有分数)"},
}

--- 综合对抗赛分队角色信息
pt_competition_team_hero =
{    
    {"hero_tid", "int32", "战员tid"}, 
    {"lv", "int16", "战员等级"}, 
    {"evolution", "int16", "战员星级"}, 
    {"body_fashion_id", "int16", "衣服时装id"}, 
    {"resonance_id_list", "int16", "共鸣位置列表", "repeated"},
}

--- 综合对抗赛分队信息
pt_competition_team =
{    
    {"team_id", "int8", "分队id"}, 
    {"is_hidden", "int8", "是否遮挡"}, 
    {"hero_list", pt_competition_team_hero, "分队信息", "repeated"},
}

--- 综合对抗赛对手数据
pt_competition_enemy =
{    
    {"player_id", "int64str", "玩家id"}, 
    {"player_name", "string", "名字"}, 
    {"avatar_id", "int32", "头像"}, 
    {"avatar_frame", "int16", "玩家头像框"}, 
    {"lv", "int16", "敌方玩家等级"}, 
    {"is_robot", "int8", "敌方是否机器人"}, 
    {"rank", "int32", "赛季排名"}, 
    {"win_count", "int32", "胜利数"}, 
    {"score", "int32", "积分"}, 
    {"segment", "int16", "段位"}, 
    {"team_list", pt_competition_team, "分队信息", "repeated"},
}

--- 综合对抗赛排行
pt_competition_rank =
{    
    {"id", "int64str", "玩家id"}, 
    {"rank", "int16", "排名"}, 
    {"is_robot", "int8", "是否机器人，1是0否"}, 
    {"score", "int32", "积分"}, 
    {"lv", "int16", "等级"}, 
    {"name", "string", "玩家名字"}, 
    {"avatar", "int16", "头像"}, 
    {"avatar_frame", "int16", "头像框"}, 
    {"win_count", "int32", "胜利数"},
}

--- 战斗日志队伍信息
pt_battle_log_team =
{    
    {"team_id", "int8", "队伍id"}, 
    {"result", "int8", "攻方战斗结果,1获胜2失败"}, 
    {"self_formation_tid", "int16", "我方阵型tid"}, 
    {"enemy_formation_tid", "int16", "敌方阵型tid"}, 
    {"can_replay", "int8", "是否有回放"}, 
    {"self_pos", pt_arena_hero_pos, "我方战员位置", "repeated"}, 
    {"enemy_pos", pt_arena_hero_pos, "敌方战员位置", "repeated"},
}

--- 综合对抗赛日志
pt_competition_log =
{    
    {"id", "int64str", "敌方玩家id"}, 
    {"name", "string", "敌方玩家名字"}, 
    {"avatar", "int16", "敌方玩家头像"}, 
    {"avatar_frame", "int16", "敌方玩家头像框"}, 
    {"lv", "int16", "敌方玩家等级"}, 
    {"is_robot", "int8", "敌方是否机器人"}, 
    {"result", "int8", "战斗结果,1获胜0失败"}, 
    {"is_self_attack", "int8", "是否玩家自己进攻,1是0否"}, 
    {"old_score", "int16", "我方旧积分"}, 
    {"new_score", "int16", "我方新积分"}, 
    {"battle_id", "int64str", "战斗id"}, 
    {"time", "int64str", "时间"}, 
    {"self_segment", "int16", "我方段位"}, 
    {"enemy_segment", "int16", "敌方段位"}, 
    {"team_list", pt_battle_log_team, "队伍列表", "repeated"}, 
    {"show_id", "string", "战报展示id"},
}

--- 队伍战斗统计信息
pt_team_battle_statistic =
{    
    {"team_id", "int8", "队伍id"}, 
    {"result", "int8", "攻方战斗结果,1获胜2失败"}, 
    {"statistic", pt_battle_statistic, "战斗统计信息", "repeated"},
}

--- 战斗结果
pt_guild_war_battle_result =
{    
    {"result", "int8", "1-进攻胜利,2-进攻失败,3-进攻平局,4-防守胜利,5-防守失败,6-防守平局"}, 
    {"times", "int8", "次数"},
}

--- 联盟团战建筑信息
pt_guild_war_build_info =
{    
    {"build_id", "int16", "建筑id"}, 
    {"now_hp", "int16", "当前血量"}, 
    {"max_hp", "int16", "最大血量"}, 
    {"point", "int32", "建筑分数"}, 
    {"challenge_times", "int8", "挑战次数"}, 
    {"battle_result", pt_guild_war_battle_result, "战斗统计信息", "repeated"},
}

--- 公会信息
pt_member_info =
{    
    {"player_id", "int64str", "玩家id"}, 
    {"player_lv", "int16", "玩家等级"}, 
    {"player_name", "string", "玩家名"}, 
    {"avatar_id", "int32", "玩家头像id"}, 
    {"avatar_frame_id", "int32", "头像框"}, 
    {"job", "int8", "0-普通会员|1-会长|2-副会长"}, 
    {"activation", "int32", "个人活跃度"}, 
    {"is_online", "int32", "0离线1在线"}, 
    {"offline_time", "int32", "离线或上线时间"}, 
    {"build_info", pt_guild_war_build_info, "建筑信息"}, 
    {"is_robot", "int8", "是否是机器人0-否，1-是"},
}

--- 公会信息
pt_apply_info =
{    
    {"player_id", "int64str", "玩家id"}, 
    {"player_lv", "int16", "玩家等级"}, 
    {"player_name", "string", "玩家名"}, 
    {"avatar_id", "int32", "玩家头像id"}, 
    {"avatar_frame_id", "int32", "头像框"},
}

--- 公会信息
pt_guild_detail_info =
{    
    {"uid", "int64str", "公会唯一id"}, 
    {"show_id", "string", "公会展示id"}, 
    {"leader_id", "int64str", "会长id"}, 
    {"leader_name", "string", "会长名"}, 
    {"name", "string", "公会名"}, 
    {"notice", "string", "公会公告"}, 
    {"lv", "int16", "公会等级"}, 
    {"award_lv", "int16", "领奖等级"}, 
    {"exp", "int32", "公会经验"}, 
    {"coin", "int32", "公会货币"}, 
    {"apply_type", "int8", "公会申请设置类型1-无需审批|2-需要审批|3-禁止加入"}, 
    {"apply_lv_cond", "int16", "申请等级限制"}, 
    {"prepare_times", "int16", "筹备次数"}, 
    {"activation", "int32", "公会活跃度"}, 
    {"is_open_supply", "int8", "是否开启补给 1-是|0-否"}, 
    {"members", pt_member_info, "成员信息", "repeated"}, 
    {"apply_list", pt_apply_info, "玩家申请列表", "repeated"}, 
    {"leader_impeach", "int8", "是否弹劾中 1-是|0-否"}, 
    {"leader_impeach_time", "int32", "弹劾时间戳"}, 
    {"is_join_guild_war", "int8", "是否参加公会团战中 1-是|0-否"}, 
    {"icon", "int16", "公会图标"}, 
    {"robot_members", pt_member_info, "机器人成员信息", "repeated"},
}

--- 公会基础信息
pt_guild_simple_info =
{    
    {"uid", "int64str", "公会唯一id"}, 
    {"show_id", "string", "公会展示id"}, 
    {"leader_id", "int64str", "会长id"}, 
    {"leader_name", "string", "会长名"}, 
    {"name", "string", "公会名"}, 
    {"notice", "string", "公会公告"}, 
    {"lv", "int16", "公会等级"}, 
    {"exp", "int32", "公会经验"}, 
    {"apply_type", "int8", "公会申请设置类型1-无需审批|2-需要审批|3-禁止加入"}, 
    {"apply_lv_cond", "int16", "申请等级限制"}, 
    {"activation", "int32", "公会活跃度"}, 
    {"member_num", "int32", "会员数量"}, 
    {"icon", "int16", "图标id"},
}

--- 奖励信息面板
pt_guild_award_panel =
{    
    {"gained_supply", "int8", "这周是否领取补给"}, 
    {"can_gain_old_award", "int8", "是否能领取旧奖励"}, 
    {"today_is_prepare", "int8", "今天是否筹备", "repeated"}, 
    {"gained_prepare_award_list", "int16", "已领取筹备奖励", "repeated"}, 
    {"can_gained_old_prepare_award_list", "int16", "可领取筹备奖励", "repeated"},
}

--- 公会战(联合围剿)战斗记录
pt_guild_fight_record =
{    
    {"player_name", "string", "玩家名称"}, 
    {"round", "int8", "阶段"}, 
    {"boss_name", "string", "boss名称"}, 
    {"damage", "int64str", "伤害"}, 
    {"time", "int32", "时间"},
}

--- 公会战(联合围剿)排行榜
pt_guild_fight_rank =
{    
    {"guild_name", "string", "公会名称"}, 
    {"rank", "int16", "排名"}, 
    {"damage", "int64str", "伤害"},
}

--- 公会战(联合围剿)公会排行榜
pt_guild_member_rank =
{    
    {"rank", "int16", "排名"}, 
    {"name", "string", "名称"}, 
    {"time", "int16", "挑战次数"}, 
    {"damage", "int64str", "伤害"},
}

--- 公会战(联合围剿)可攻打的boss
pt_guild_fight_boss =
{    
    {"id", "int16", "boss副本id"}, 
    {"now_hp", "int64str", "当前血量"}, 
    {"max_hp", "int64str", "最大血量"}, 
    {"can_fight", "int8", "是否可以挑战：1-可以，0-不可以"},
}

--- 科技信息
pt_guild_science_info =
{    
    {"id", "int16", "科技id"}, 
    {"lv", "int16", "科技等级"}, 
    {"cur_lv_attr_list", pt_attr, "当前等级属性", "repeated"}, 
    {"next_lv_attr_list", pt_attr, "下一等级属性", "repeated"},
}

--- 联盟团战报名信息
pt_guild_war_sign_up_info =
{    
    {"player_id", "int64str", "玩家id"}, 
    {"build_id", "int16", "建筑id"},
}

--- 公会战团战排行榜
pt_guild_war_rank =
{    
    {"name", "string", "公会名称"}, 
    {"leader_name", "string", "会长名称"}, 
    {"rank", "int16", "排名"}, 
    {"point", "int32", "分数"},
}

--- 公会战团每日日志
pt_guild_war_day_log =
{    
    {"self_uid", "int64str", "公会唯一id"}, 
    {"self_name", "string", "公会名称"}, 
    {"self_icon", "int16", "公会图标"}, 
    {"self_lv", "int16", "公会等级"}, 
    {"self_day_point", "int32", "当天破坏分(未经过转化)"}, 
    {"enemy_uid", "int64str", "公会唯一id"}, 
    {"enemy_name", "string", "公会名称"}, 
    {"enemy_icon", "int16", "公会图标"}, 
    {"enemy_lv", "int16", "公会等级"}, 
    {"enemy_day_point", "int32", "当天破坏分(未经过转化)"}, 
    {"old_point", "int32", "旧总积分"}, 
    {"add_point", "int32", "添加的积分(由破坏分转化成的积分)"}, 
    {"result", "int8", "1-胜利,2-失败,3-平局"}, 
    {"time", "int32", "记录事件戳"}, 
    {"rank", "int16", "排名"},
}

--- 团战战斗日志
pt_guild_war_battle_log =
{    
    {"is_atk", "int8", "是否进攻方1-进攻方，0-防守方"}, 
    {"atk_id", "int64str", "进攻联盟玩家id"}, 
    {"atk_name", "string", "进攻联盟玩家名字"}, 
    {"atk_avatar", "int16", "进攻联盟玩家头像"}, 
    {"atk_avatar_frame", "int16", "进攻联盟玩家头像框"}, 
    {"atk_lv", "int16", "进攻联盟玩家等级"}, 
    {"def_id", "int64str", "防守联盟id"}, 
    {"def_name", "string", "防守联盟玩家名字"}, 
    {"def_avatar", "int16", "防守联盟玩家头像"}, 
    {"def_avatar_frame", "int16", "防守联盟玩家头像框"}, 
    {"def_lv", "int16", "防守联盟玩家等级"}, 
    {"result", "int8", "战斗结果,1获胜2失败3平局,456"}, 
    {"atk_old_point", "int16", "进攻联盟玩家旧积分"}, 
    {"atk_new_point", "int16", "进攻联盟玩家新积分"}, 
    {"def_old_point", "int16", "防守联盟玩家旧积分"}, 
    {"def_new_point", "int16", "防守联盟玩家新积分"}, 
    {"build_id", "int16", "建筑id"}, 
    {"battle_id", "int64str", "战斗id"}, 
    {"time", "int64str", "时间"}, 
    {"team_list", pt_battle_log_team, "队伍列表", "repeated"}, 
    {"show_id", "string", "战报展示id"},
}

--- 赛季信息
pt_guild_war_season_info =
{    
    {"season_id", "int16", "赛季id"}, 
    {"next_step_start_time", "int32", "下一阶段阶段开启时间"}, 
    {"end_time", "int32", "活动结束时间"}, 
    {"start_time", "int32", "活动开启时间"}, 
    {"state", "int8", "赛季状态"},
}

--- 阵型中的战员
pt_guild_war_formation_hero =
{    
    {"pos", pt_pos, "站位"}, 
    {"is_captain", "int8", "是否队长"}, 
    {"hero_id", "int32", "战员id"}, 
    {"tid", "int32", "战员tid"}, 
    {"hero_source", "int8", "战员来源：1、玩家自己的战员 2、主线关卡剧情外援 3、竞技场敌方玩家或机器人"}, 
    {"lv", "int16", "战员等级"}, 
    {"evolution", "int16", "战员星级"}, 
    {"body_fashion_id", "int16", "衣服时装id"},
}

--- 战员阵型数据
pt_guild_war_def_formation =
{    
    {"team_id", "int16", "队列id 1 or 2"}, 
    {"formation_tid", "int16", "阵型id"}, 
    {"is_ready", "int8", "是否出战"}, 
    {"name", "string", "队列名字"}, 
    {"hero_list", pt_guild_war_formation_hero, "战员列表", "repeated"}, 
    {"assist_fight_list", pt_formation_assist_fight, "助战战员列表", "repeated"}, 
    {"pet_id", "int32", "锚驴id"},
}

--- 无限城分数数据
pt_boundless_city_history_info =
{    
    {"dup_id", "int32", "副本id"}, 
    {"point", "int32", "分数"},
}

--- 无限城玩家数据
pt_boundless_city_player_info =
{    
    {"rank", "int32", "排名"}, 
    {"player_id", "int64str", "玩家id"}, 
    {"player_name", "string", "名字"}, 
    {"avatar_id", "int32", "头像"}, 
    {"avatar_frame_id", "int32", "头像框"}, 
    {"designation", "int32", "称号"}, 
    {"point", "int32", "排行值"}, 
    {"dup_id", "int32", "当前最大副本id"}, 
    {"guild_name", "string", "公会名"}, 
    {"history_point", pt_boundless_city_history_info, "玩家每层信息", "repeated"},
}

--- 模组方案
pt_chip_plan =
{    
    {"id", "int32", "方案编号"}, 
    {"name", "string", "方案名称"}, 
    {"chip_list", pt_equip_pos, "模组方案列表", "repeated"},
}

--- 钓鱼信息
pt_fish_info =
{    
    {"fish_id", "int16", "鱼id"}, 
    {"amount", "int16", "数量"}, 
    {"min_size", "int16", "最小长度"}, 
    {"max_size", "int16", "最大长度"},
}

--- 时装商店配置折扣时间信息
pt_fashionshop_discount_data =
{    
    {"begin_time", "int32", "开启时间"}, 
    {"end_time", "int32", "结束时间"}, 
    {"cost", "int16", "消耗氪金石数量"}, 
    {"discount", "int16", "折扣"},
}

--- 时装商店配置信息
pt_fashion_shop_conf =
{    
    {"id", "int16", "商品id"}, 
    {"skin_id", "int16", "解锁时装 [战员tid, 时装id]", "repeated"}, 
    {"pay_type", "int16", "购买所需的货币tid"}, 
    {"sort", "int16", "sort"}, 
    {"type", "int8", "type"}, 
    {"discount_time", pt_fashionshop_discount_data, "折扣时间", "repeated"}, 
    {"discount_cost", "int32", "折扣价格"}, 
    {"item_id", "int32", "道具id"},
}

--- 时装组合包商店配置信息
pt_combo_fashion_shop_conf =
{    
    {"id", "int32", "商品组合id"}, 
    {"goods_list", "int16", "包含的商品列表", "repeated"}, 
    {"pay_type", "int16", "支付类型"}, 
    {"cost", "int32", "消耗道具数量"},
}

--- 沙盒地图信息
pt_sandplay_event_info =
{    
    {"npc_id", "int32", "npc_id"}, 
    {"event_id", "int32", "事件id"},
}

--- 沙盒地图信息
pt_sandplay_map_info =
{    
    {"map_id", "int16", "地图Id"}, 
    {"npc_event_list", pt_sandplay_event_info, "触发过的事件列表", "repeated"},
}

--- 联合扫荡成员战斗记录
pt_guild_sweep_member_rank =
{    
    {"rank", "int32", "排名"}, 
    {"player_id", "int64str", "玩家id"}, 
    {"player_name", "string", "名字"}, 
    {"avatar_id", "int32", "头像"}, 
    {"avatar_frame_id", "int32", "头像框"}, 
    {"time", "int16", "挑战次数"}, 
    {"damage", "int64str", "伤害"},
}

--- 怪物信息
pt_disaster_boss_info =
{    
    {"id", "int32", "怪物id"}, 
    {"now_hp", "int64str", "当前血量"}, 
    {"max_hp", "int64str", "最大血量"},
}

--- 主界面简易信息
pt_disaster_simple_info =
{    
    {"id", "int8", "难度id"}, 
    {"is_pass", "int8", "是否通关0-否,1-是"}, 
    {"boss_info", pt_disaster_boss_info, "boss血量信息"},
}

--- 阵型详细信息
pt_disaster_formation_info =
{    
    {"id", "int16", "阵型id"}, 
    {"is_pass", "int8", "是否已使用"}, 
    {"damage", "int64str", "本次挑战造成伤害"}, 
    {"hero_list", "int32", "已使用战员id列表", "repeated"},
}

--- 主面板信息
pt_disaster_main_panel =
{    
    {"all_damage", "int64str", "累计总伤害"}, 
    {"infinite_damage", "int64str", "无限模式最高伤害"}, 
    {"today_times", "int8", "今日挑战次数"}, 
    {"war_id", "int8", "2-低级战区,3-中级战区,4-高级战区"}, 
    {"had_reward_list", "int16", "已经领取的奖励列表", "repeated"}, 
    {"disaster_list", pt_disaster_simple_info, "难度信息", "repeated"},
}

--- 阵型面板信息
pt_disaster_formation_panel =
{    
    {"cur_damage", "int64str", "本次挑战累计伤害"}, 
    {"challenging_difficulty", "int8", "正在挑战的难度"}, 
    {"boss_info", pt_disaster_boss_info, "boss血量信息"}, 
    {"hero_list", "int32", "已使用战员id列表", "repeated"}, 
    {"formation_list", pt_disaster_formation_info, "阵型信息", "repeated"},
}

--- 怪物信息
pt_disaster_rank_info =
{    
    {"rank", "int32", "排名"}, 
    {"id", "int64str", "玩家id"}, 
    {"name", "string", "名字"}, 
    {"avatar_id", "int32", "头像"}, 
    {"avatar_frame", "int32", "头像框"}, 
    {"designation", "int32", "称号"}, 
    {"rank_val", "int64str", "排行值"},
}

--- 联盟训练联盟成员排行榜
pt_guild_train_rank_info =
{    
    {"rank", "int32", "排名"}, 
    {"player_id", "int64str", "玩家id"}, 
    {"player_name", "string", "名字"}, 
    {"avatar_id", "int32", "头像"}, 
    {"avatar_frame_id", "int32", "头像框"}, 
    {"damage", "int64str", "伤害"},
}

--- 蛋壳关卡信息
pt_danke_dup_info =
{    
    {"dup_id", "int16", "副本id"}, 
    {"star_list", "int16", "已完成的星星条件列表", "repeated"},
}

--- 地图格子信息
pt_seabed_cell_info =
{    
    {"id", "int16", "格子id"}, 
    {"event_id", "int32", "事件id"}, 
    {"option_args", "int32", "选项事件参数", "repeated"},
}

--- 地图线路信息
pt_seabed_line_info =
{    
    {"id", "int16", "线路id"}, 
    {"layer", "int8", "当前层"}, 
    {"cell_list", pt_seabed_cell_info, "格子信息", "repeated"},
}

--- 海底深层战前信息
pt_seabed_prewar_info =
{    
    {"step", "int8", "当前步骤"}, 
    {"difficulty", "int8", "难度"}, 
    {"teaser_id", "int8", "难题id"}, 
    {"skill_type", "int32", "技能id"},
}

--- 天赋信息
pt_seabed_hero_info =
{    
    {"hero_id", "int32", "天赋点数"}, 
    {"hp_radio", "int16", "血量比例"},
}

--- 战斗信息
pt_seabed_battle_info =
{    
    {"battle_step", "int8", "战斗步骤"}, 
    {"battle_dup_id", "int32", "战斗副本id"}, 
    {"free_reset_buff_times", "int8", "免费刷新次数"}, 
    {"cost_coin", "int16", "刷新消耗货币"}, 
    {"postwar_buff_reset", "int8", "是否已刷新战后buff"}, 
    {"postwar_args", "int32", "战斗后格子参数", "repeated"}, 
    {"hero_list", pt_seabed_hero_info, "战员信息", "repeated"},
}

--- 海底深层资源信息
pt_seabed_resource_info =
{    
    {"coin", "int16", "玩法币"}, 
    {"action_point", "int16", "行动点"},
}

--- 结算统计
pt_seabed_stats_detail =
{    
    {"id", "int16", "结算id"}, 
    {"count", "int16", "次数"},
}

--- 历史信息
pt_seabed_history_info =
{    
    {"max_difficulty", "int8", "通关最大难度"}, 
    {"collage_list", "int32", "收藏品列表", "repeated"}, 
    {"buff_list", "int32", "收藏品列表", "repeated"}, 
    {"story_list", "int32", "故事列表", "repeated"}, 
    {"gain_collage_or_buff_reward_list", "int16", "收藏品buff奖励列表", "repeated"}, 
    {"gained_showroom_reward_list", "int16", "陈列室奖励列表", "repeated"},
}

--- 事影循回商品信息
pt_seabed_goods_info =
{    
    {"id", "int32", "商品id"}, 
    {"type", "int8", "1-收藏品,2-buff"}, 
    {"price", "int16", "商品价格"}, 
    {"is_buy", "int8", "是否已购买"},
}

--- 商店信息
pt_seabed_shop_info =
{    
    {"goods_list", pt_seabed_goods_info, "商店信息", "repeated"},
}

--- 天赋信息
pt_seabed_talent_info =
{    
    {"talent_point", "int16", "天赋点数"}, 
    {"talent_list", "int16", "已解锁的天赋列表", "repeated"},
}

--- 战员时装列表
pt_hero_fashion_color_info =
{    
    {"hero_id", "int32", "战员唯一id"}, 
    {"fashion_id", "int32", "战员服装id"}, 
    {"color_id", "int32", "战员服装炫彩id"},
}

--- 限时礼包商品信息
pt_limited_gift_info =
{    
    {"id", "int32", "礼包id"}, 
    {"buy_times", "int16", "已购买次数"}, 
    {"end_time", "int32", "结束时间戳"},
}

--- 超值限时礼包商品信息
pt_super_gift_info =
{    
    {"id", "int32", "礼包id"}, 
    {"is_buy", "int8", "是否已购买0-否,1-是"},
}

--- 农场地块信息
pt_farm_field =
{    
    {"field_id", "int16", "格子id"}, 
    {"field_state", "int16", "格子状态"}, 
    {"crop_id", "int16", "作物id"}, 
    {"start_time", "int32", "开始的时间点"}, 
    {"reap_count", "int8", "已经收获次数"},
}

--- 自选礼包的自选格子信息
pt_select_gift_grid_info =
{    
    {"grid_id", "int32", "格子id"}, 
    {"select_id", "int32", "选择id"},
}

--- 自选礼包信息
pt_select_gift_info =
{    
    {"id", "int32", "礼包id"}, 
    {"is_buy", "int8", "是否购买"}, 
    {"grid_select_list", pt_select_gift_grid_info, "格子选择情况", "repeated"},
}

--- 战员拥有皮肤
pt_hero_have_fashion_info =
{    
    {"hero_tid", "int32", "战员tid"}, 
    {"have_fashion_id_list", "int32", "拥有时装id列表", "repeated"},
}

--- 羊了个羊副本
pt_three_tiles_dup =
{    
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "过关星星数"},
}

--- 限定up池招募大保底信息
pt_recruit_debug_up_detail =
{    
    {"id", "int16", "池子id"}, 
    {"up_tid", "int16", "uptid"}, 
    {"up_ratio", "int16", "up概率"}, 
    {"other_ratio", pt_int_int, "其他SSR概率", "repeated"},
}

--- 打砖块副本
pt_breakout_dup =
{    
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "过关星星数"},
}

--- 连连看副本
pt_linklink_dup =
{    
    {"dup_id", "int16", "副本id"}, 
    {"star", "int8", "过关星星数"},
}

--- 战员时装场景信息
pt_fashion_scene_info =
{    
    {"hero_tid", "int16", "战员tid"}, 
    {"scene_list", "int16", "解锁的全部场景", "repeated"},
}
