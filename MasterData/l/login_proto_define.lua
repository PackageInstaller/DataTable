-- ============================
-- 说明
-- ret 返回值统一0为正常范围，非0值均为异常返回
-- 绝大多数消息为请求响应式即Request<->Response形式
-- 需要保证可靠性的（断线重连后不丢失）主动推送式方式，我定义为Subscribe<->Publish形式，操作上需要客户端预发一个订阅，服务端通过订阅的id进行主动推送
-- 不需要保证可靠性的（断线重连后丢失）主动推送式方式，比如其他人的聊天消息等允许断线后丢失的，后缀为Notify（只由服务器发起）
-- ============================
-- 服务器随机生成的key，为了后续校验秘钥正确性
---@class ChallengeReq


---@class ChallengeResp
---@field challenge string


-- dh秘钥交换算法
---@class KeyReq
---@field key string


---@class KeyResp
-- 1 秘钥长度不对
---@field ret integer
---@field key string


-- 检测秘钥是否生成成功
---@class VerifySecretReq
---@field hmac string


---@class VerifySecretResp
-- 1 代表校验秘钥失败
---@field ret integer


-- 登录游戏
-- 这一步由于涉及敏感信息，所以此协议最好用第一步的秘钥做des加密
---@class LoginAuthReq
---@field account string 渠道账号
---@field token string 渠道token
---@field platform integer 设备类型 Android,IOS,Editor, WebGLPlayer
---@field platformSubid integer 设备子类型 iOS_WebGL,Android_WebGL
---@field device string 标识设备id
---@field deviceInfo string 设备详情
---@field loginType integer 登录方式 official/fb/...
---@field channel integer 渠道
---@field track string json数据
---@field distinct_id string 访客id


---@class LoginAuthResp
-- 1 验证失败 5 被封账号 6被封设备 7被封ip
---@field ret integer
---@field ban_end_stamp integer
---@field phone string 是否已经绑定手机号


-- 区服列表
---@class ZoneInfo
---@field id integer
---@field name string
-- 可能后续还有在线信息，角色数量等


---@class ZoneListReq


---@class ZoneListResp
---@field ret integer
---@field zones ZoneInfo[]


-- 登录区服
---@class LoginZoneReq
---@field id integer


---@class LoginZoneResp
-- 1 登录失败
-- 2 已经登录过其他区服
---@field ret integer
---@field aid integer
---@field subid integer
---@field ip string
---@field port integer
---@field wssUri string 拼接wss连接的uri


---@class DeleteAccountReq
---@field token string


---@class DeleteAccountResp
---@field ret integer


-- 绑定手机号
---@class BindPhoneReq
---@field phone string
---@field verifyCode string
---@field password string


---@class BindPhoneResp
-- 0 成功
-- 1 操作超时
-- 2 手机号不正确
-- 3 验证码不正确
-- 4 验证码校验不正确
-- 5 绑定失败
---@field ret integer
---@field phone string


-- 登录服心跳协议
---@class HeartBeatReq


---@class HeartBeatResp
---@field ret integer

