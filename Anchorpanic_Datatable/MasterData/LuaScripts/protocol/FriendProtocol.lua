-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    15     
-- @Name:  friend   
-- @Desc:  好友协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *c2s* 请求好友列表 15000
CS_FRIEND_LIST =
{
    15000,
}
 
--- *s2c* 返回好友列表 15001
SC_FRIEND_LIST =
{
    15001, 
    {"friend_list", pt_friend_info, "好友列表", "repeated"},
}
 
--- *c2s* 请求好友申请列表 15002
CS_FRIEND_APPLY_LIST =
{
    15002,
}
 
--- *s2c* 返回好友申请列表 15003
SC_FRIEND_APPLY_LIST =
{
    15003, 
    {"friend_apply_list", pt_friend_info, "好友申请列表", "repeated"},
}
 
--- *c2s* 请求添加玩家 15004
CS_FRIEND_ADD =
{
    15004, 
    {"id", "int64str", "玩家id"},
}
 
--- *s2c* 返回添加玩家结果 15005
SC_FRIEND_ADD =
{
    15005, 
    {"friend_add_result", "int8", "添加玩家结果"},
}
 
--- *s2c* 收到玩家的申请请求 15006
SC_FRIEND_APPLY_REQ =
{
    15006, 
    {"friend_apply_info", pt_friend_info, "玩家信息"},
}
 
--- *c2s* 发送玩家申请反馈 15007
CS_FRIEND_APPLY_REPLY =
{
    15007, 
    {"apply_reply_list", pt_friend_apply_reply, "好友申请反馈列表", "repeated"},
}
 
--- *c2s* 请求删除好友 15008
CS_FRIEND_DEL =
{
    15008, 
    {"friend_id", "int64str", "好友id"},
}
 
--- *s2c* 返回删除的好友 15009
SC_FRIEND_DEL_BACK =
{
    15009, 
    {"id", "int64str", "好友id"},
}
 
--- *c2s* 请求查询玩家 15010
CS_FRIEND_QUERY =
{
    15010, 
    {"show_id", "string", "玩家show_id"},
}
 
--- *s2c* 返回查询玩家结果 15011
SC_FRIEND_QUERY =
{
    15011, 
    {"friend_query_info", pt_friend_info, "查询玩家的信息", "repeated"},
}
 
--- *c2s* 请求好友黑名单列表 15012
CS_BLACK_LIST =
{
    15012,
}
 
--- *s2c* 返回好友黑名单列表 15013
SC_BLACK_LIST =
{
    15013, 
    {"black_list", pt_friend_info, "好友黑名单列表", "repeated"},
}
 
--- *c2s* 请求删除黑名单 15014
CS_BLACK_DEL =
{
    15014, 
    {"black_id", "int64str", "黑名单好友id列表"},
}
 
--- *c2s* 拉入黑名单 15015
CS_BLACK_ADD =
{
    15015, 
    {"player_id", "int64str", "玩家id"},
}
 
--- *c2s* 请求好友推荐列表 15016
CS_FRIEND_RECOMMEND =
{
    15016,
}
 
--- *s2c* 返回好友推荐列表 15017
SC_FRIEND_RECOMMEND =
{
    15017, 
    {"recommend_list", pt_friend_info, "推荐列表", "repeated"},
}
 
--- *c2s* 刷新好友推荐列表 15018
CS_FRIEND_RECOMMEND_REFRESH =
{
    15018,
}
 
--- *c2s* 好友聊天 15019
CS_FRIEND_CHAT =
{
    15019, 
    {"id", "int32", "消息id，用于返回，区别玩家操作结果"}, 
    {"friend_id", "int64str", "好友id"}, 
    {"content", "string", "内容"}, 
    {"content_type", "int8", "内容类型"},
}
 
--- *s2c* 好友聊天返回 15020
SC_FRIEND_CHAT =
{
    15020, 
    {"id", "int32", "消息id，用于返回，区别玩家操作结果"}, 
    {"friend_id", "int64str", "好友id"}, 
    {"content", "string", "内容"}, 
    {"time", "int32", "发送时间戳"}, 
    {"result", "int8", "返回结果1-成功，其他-错误码"}, 
    {"tid", "int32", "礼物"}, 
    {"state", "int8", "1发送 2领取"}, 
    {"content_type", "int8", "内容类型"}, 
    {"dialog_box_id", "int32", "聊天气泡"},
}
 
--- *s2c* 收到好友聊天 15021
SC_RECEIVE_FRIEND_CHAT =
{
    15021, 
    {"id", "int64str", "好友id"}, 
    {"content", "string", "内容"}, 
    {"time", "int32", "发送时间戳"}, 
    {"tid", "int32", "礼物"}, 
    {"state", "int8", "1发送 2领取"}, 
    {"content_type", "int8", "内容类型"}, 
    {"dialog_box_id", "int32", "聊天气泡"},
}
 
--- *c2s* 好友聊天记录 15022
CS_FRIEND_CHAT_LOG =
{
    15022, 
    {"friend_id", "int64str", "好友id"},
}
 
--- *s2c* 好友聊天记录返回 15023
SC_FRIEND_CHAT_LOG =
{
    15023, 
    {"friend_id", "int64str", "好友id"}, 
    {"log_list", pt_friend_chat_info, "聊天记录", "repeated"},
}
 
--- *c2s* 赠送好友礼物 15024
CS_FRIEND_GIFT_SEND =
{
    15024, 
    {"friend_id", "int64str", "0-全部好友，其他-好友id"},
}
 
--- *s2c* 赠送好友礼物结果返回 15025
SC_FRIEND_GIFT_SEND =
{
    15025, 
    {"friend_id", "int64str", "成功赠送的好友id返回", "repeated"},
}
 
--- *c2s* 领取好友礼物 15026
CS_FRIEND_GIFT_GAIN =
{
    15026, 
    {"friend_id", "int64str", "0-全部好友，其他-好友id"},
}
 
--- *s2c* 领取好友礼物结果返回 15027
SC_FRIEND_GIFT_GAIN =
{
    15027, 
    {"friend_id", "int64str", "成功领取的好友id返回", "repeated"}, 
    {"award_list", pt_prop_award, "道具奖励列表", "repeated"},
}
 
--- *s2c* 汇总好友礼物面板 15028
SC_FRIEND_GIFT_PANEL =
{
    15028, 
    {"gift_max", "int16", "每日领取上限"}, 
    {"gift_count", "int16", "已领取数目"}, 
    {"tid", "int32", "礼物"}, 
    {"can_gain_friend_id", "int64str", "待领取的有奖励的好友id列表", "repeated"},
}
 
--- *c2s* 好友备注 15030
CS_FRIEND_REMARKS =
{
    15030, 
    {"friend_id", "int64str", "好友id"}, 
    {"new_remarks", "string", "新的备注"},
}
 
--- *s2c* 好友备注返回 15031
SC_FRIEND_REMARKS =
{
    15031, 
    {"friend_id", "int64str", "好友id"}, 
    {"new_remarks", "string", "新的备注"}, 
    {"result", "int8", "备注结果1-成功，其他-错误码"},
}
 
--- *c2s* 删除好友备注 15032
CS_FRIEND_REMARKS_CLEAR =
{
    15032, 
    {"friend_id", "int64str", "好友id"},
}
 
--- *s2c* 删除好友备注返回 15033
SC_FRIEND_REMARKS_CLEAR =
{
    15033, 
    {"friend_id", "int64str", "好友id"}, 
    {"result", "int8", "备注结果1-成功，其他-错误码"},
}
