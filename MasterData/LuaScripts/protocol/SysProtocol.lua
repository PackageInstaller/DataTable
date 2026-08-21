-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    10     
-- @Name:  sys   
-- @Desc:  系统协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *c2s* 心跳协议c2s 10000
CS_SYS_PING =
{
    10000, 
    {"time", "int32", "服务器时间戳"},
}
 
--- *s2c* 心跳协议s2c 10001
SC_SYS_PING =
{
    10001, 
    {"time", "int32", "服务器时间戳"},
}
 
--- *s2c* 服务器时间 10002
SC_SYS_DATE =
{
    10002, 
    {"time", "int32", "当前时间戳"}, 
    {"open_date", "int32", "开服时间戳"}, 
    {"merge_date", "int32", "合服时间戳"},
}
 
--- *s2c* 被踢下线 10003
SC_SYS_KICK =
{
    10003, 
    {"reason", "int8", "原因：0-未知，1-顶号，2-防沉迷, 3-客户端更新，4-服务端维护, 5-封号,6-未开服"},
}
 
--- *c2s* 请求gm指令列表 10004
CS_GM_LIST =
{
    10004,
}
 
--- *s2c* 返回gm指令列表 10005
SC_GM_LIST =
{
    10005, 
    {"cmd_list", pt_gm_command, "gm指令列表", "repeated"},
}
 
--- *c2s* 使用gm指令 10006
CS_GM_COMMAND =
{
    10006, 
    {"command", "string", "指令内容"},
}
 
--- *s2c* gm指令结果 10007
SC_GM_COMMAND =
{
    10007, 
    {"result", "string", "使用结果"},
}
 
--- *s2c* 系统飘字提示 10008
SC_SYS_HINT =
{
    10008, 
    {"lang_id", "int32", "语言包id"}, 
    {"place", "int8", "飘字位置：0-左下角，1-跟随鼠标"}, 
    {"color", "int8", "飘字颜色：0-成功绿色，1-其他"}, 
    {"params", "string", "参数列表", "repeated"},
}
 
--- *s2c* 系统零点重置 10009
SC_SYS_RESET =
{
    10009,
}
 
--- *s2c* 系统五点重置 10010
SC_SYS_5_RESET =
{
    10010,
}
 
--- *c2s* 请求充值数据 10020
CS_PAY_DATA =
{
    10020,
}
 
--- *s2c* 充值数据 10021
SC_PAY_DATA =
{
    10021, 
    {"pay_cfg", pt_pay_info, "充值配置信息", "repeated"}, 
    {"pay_list", "string", "已充值id列表", "repeated"},
}
 
--- *s2c* 系统广播 10030
SC_SYSTEM_HEARSAY =
{
    10030, 
    {"channel", "int8", "聊天频道（0-不显示 1-系统频道）"}, 
    {"msg", "string", "系统消息"}, 
    {"location", "int8", "显示位置(1-聊天框；2-主ui；3-都显示)"}, 
    {"is_cross", "int8", "是否跨服(0本服 1跨服 2全服)"}, 
    {"min_lv", "int16", "最小等级"}, 
    {"max_lv", "int16", "最大等级"}, 
    {"params", pt_hearsay_param, "聊天相关参数列表", "repeated"}, 
    {"target_id", "int64str", "玩家id,没有发0"}, 
    {"end_time", "int32", "广播结束时间戳"},
}
 
--- *c2s* 系统公告 10031
CS_SYSTEM_ANNOUNCE =
{
    10031,
}
 
--- *s2c* 系统公告 10032
SC_SYSTEM_ANNOUNCE =
{
    10032, 
    {"announce_list", pt_announce_info, "公告列表", "repeated"},
}
 
--- *s2c* 聊天刷屏禁言时间戳 10048
SC_CHAT_BAN_TIME =
{
    10048, 
    {"channel", "int8", "频道"}, 
    {"ban_time", "int32", "禁言结束时间戳"},
}
 
--- *c2s* 关闭公共聊天面板 10049
CS_CLOSE_PUBLIC_CHAT =
{
    10049, 
    {"channel", "int8", "频道"},
}
 
--- *c2s* 公共聊天 10050
CS_PUBLIC_CHAT =
{
    10050, 
    {"channel", "int8", "频道"}, 
    {"room", "int32", "房间号"}, 
    {"content_type", "int8", "内容类型"}, 
    {"content", "string", "内容"},
}
 
--- *s2c* 返回聊天信息 10051
SC_PUBLIC_CHAT =
{
    10051, 
    {"channel", "int8", "频道"}, 
    {"room", "int32", "房间号"}, 
    {"content_type", "int8", "内容类型"}, 
    {"content", "string", "内容"}, 
    {"sender_id", "int64str", "发送人id"}, 
    {"sender_name", "string", "发送人名称"}, 
    {"sender_avatar", "int32", "发送人头像"}, 
    {"sender_frame", "int32", "发送人头像框"}, 
    {"sender_title_id", "int32", "发送人称号id"}, 
    {"time", "int32", "发送时间戳"}, 
    {"dialog_box_id", "int32", "聊天气泡"},
}
 
--- *c2s* 修改聊天房间号 10052
CS_CHANGE_CHAT_ROOM =
{
    10052, 
    {"channel", "int8", "频道"}, 
    {"room", "int32", "房间号"},
}
 
--- *s2c* 修改聊天房间号 10053
SC_CHANGE_CHAT_ROOM =
{
    10053, 
    {"channel", "int8", "频道"}, 
    {"room", "int32", "房间号"}, 
    {"people_count", "int32", "房间人数"}, 
    {"result", "int8", "返回结果1-成功，其他-错误码"},
}
 
--- *c2s* 公共聊天面板设置 10054
CS_PUBLIC_CHAT_SETTING =
{
    10054, 
    {"channel", "int8", "频道"},
}
 
--- *s2c* 公共列表 10055
SC_PUBLIC_CHAT_SETTING =
{
    10055, 
    {"channel", "int8", "频道"}, 
    {"room_now", "int32", "房间号"}, 
    {"people_count", "int32", "房间人数"}, 
    {"room_list", "int32", "可选择房间列表", "repeated"},
}
 
--- *s2c* 推送的所有类型的未读和已读的id列表 10056
SC_RES_ALL_MODULE_READ =
{
    10056, 
    {"all_module_read_list", pt_module_read_info, "所有未读和已读类型的id列表", "repeated"},
}
 
--- *c2s* 通知服务器模块id已读 10057
CS_REQ_MODULE_READ =
{
    10057, 
    {"type", "int32", "类型"}, 
    {"id", "int32", "id"},
}
 
--- *s2c* 服务器返回已读模块id 10058
SC_RES_MODULE_READ =
{
    10058, 
    {"type", "int32", "类型"}, 
    {"id", "int32", "id"},
}
 
--- *s2c* 新的未读类型的id 10059
SC_NEW_UNREAD =
{
    10059, 
    {"type", "int32", "类型"}, 
    {"id_list", "int32", "id列表", "repeated"},
}
 
--- *c2s* 获取服务器是否提审服 10070
CS_GET_SERVER_STATE =
{
    10070,
}
 
--- *s2c* 获取服务器是否提审服 10071
SC_GET_SERVER_STATE =
{
    10071, 
    {"state", "int8", "是否提审服 0否 1是"},
}
 
--- *c2s* 系统设置 10100
CS_SETTING =
{
    10100, 
    {"key", "int16", "类型"}, 
    {"val", "int8", "值"},
}
 
--- *s2c* 系统设置 10101
SC_SETTING =
{
    10101, 
    {"setting_list", pt_attr_short, "设置列表", "repeated"},
}
