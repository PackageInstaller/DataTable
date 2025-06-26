-- -----------------------------------------------
-- ***** 协议文件，自动生成，请勿编辑！*****
-- @Id:    11     
-- @Name:  account   
-- @Desc:  账号协议   
-- -----------------------------------------------
module(..., package.seeall);

 
--- *c2s* 请求登录 11000
CS_ACCOUNT_LOGIN =
{
    11000, 
    {"acc_name", "string", "账号名"}, 
    {"login_time", "int32", "登录时间"}, 
    {"login_token", "string", "登录验证字符串"}, 
    {"infant", "int8", "防沉迷"}, 
    {"pf", "int16", "平台id"}, 
    {"channel_id", "int16", "渠道id"}, 
    {"sub_channel_id", "int16", "子渠道"}, 
    {"srv_id", "int32", "服务器id"}, 
    {"dev_platform_type", "int8", "设备运行平台类型 1-Android 2-ios 3-pc"}, 
    {"dev_code", "string", "设备码"}, 
    {"dev_model", "string", "设备型号"}, 
    {"dev_token", "string", "消息推送设备标识"},
}
 
--- *s2c* 登录结果 11001
SC_ACCOUNT_LOGIN =
{
    11001, 
    {"result", "int8", "结果：0-成功，1-用户名为空，2-IP被封，3-服务器ID非法，4-人数已满，5-用户被封，6-防沉迷，7-设备非法，8-IP登录上限，9-渠道非法，10-子渠道非法，11-服务器初始化，12-创角失败"}, 
    {"acc_id", "int64str", "账号id"}, 
    {"player_id", "int64str", "玩家id"}, 
    {"is_new", "int8", "是否新号创角 1-是 0-否"}, 
    {"session", "string", "会话索引"}, 
    {"create_time", "int32", "创角时间"},
}
 
--- *c2s* 登录成功进入主界面 11005
CS_ENTER_WORLD =
{
    11005, 
    {"battle_sync_word", "int32", "战斗同步码"},
}
 
--- *c2s* 请求重连 11007
CS_ACCOUNT_RELOGIN =
{
    11007, 
    {"acc_id", "int64str", "账号id"}, 
    {"player_id", "int64str", "玩家id"}, 
    {"session", "string", "session"}, 
    {"dev_platform_type", "int8", "设备运行平台类型 1-Android 2-ios 3-pc"},
}
 
--- *s2c* 重连结果 11008
SC_ACCOUNT_RELOGIN =
{
    11008, 
    {"result", "int8", "重连结果 1成功 0失败"}, 
    {"session", "string", "会话索引"},
}
