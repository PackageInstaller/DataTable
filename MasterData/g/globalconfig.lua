

GV.GlobalConfig = {
   ReleaseType = GE.ReleaseType.Formal,    -- 
   EnableChatBar = true,                   -- 是否启用聊天功能
   SkipHealthText = true,                  -- 是否跳过健康公告(测试中可跳过)                   海外:true
   LocalServerTest = false,                 -- 是否还是用本地测试ip                            海外:false
   EnableTempChapterEntry = false,          -- 是否启用调试进入章节功能(可在测试时候依旧开启)    版号:false
   VerifyPhoneCode = false,                  --手机验证码验证开启
   --VersionForTest = "1.0.0.36.1.32",
   ValidateID = false,                       --身份证验证开启（只在注册时使用）
   --websocket = "ws",                        --开启websocket 配置："ws"|"wss" 其他不开启

   WriteShuShuLog = true,                  --写数数日志
   LogServerId = GE.LogServerId.Release_3,      --数数日志区分 服务器

   UserReload = false,                      -- msgagent 里对user.lua是否每次重新reload           海外:false
   RequireDbgReload = false,                -- RequireDbg reloadScript                         海外:false
   SkillSystemLogEnabled = false,           -- 战斗计算是否开启log                             海外:false
   CheckForbiddenWord = true,             -- 是否检测屏蔽字                                   正式版/版号/海外:true
   WxPayAudit = true,                     ---是否微信支付审核版本
   AliPayAudit = false,                    ---是否支付宝支付审核版本
   PaySelectCheck = false,                ---支付选择是否使用打勾方式
   ShowMainPanelTestBtn = false,             ---显示主界面测试按钮
   CanChangeServer = false,                  ---是否能换服务器
   ValidatePassword = true,

   NetBigMsg = false,
}


-- 是否检查身份证（版号版本下也可临时配置为不检查）
function GV.GlobalConfig.CheckIdCard()
    return GV.GlobalConfig.IsInternalFormal() and GV.GlobalConfig.ValidateID
end

function GV.GlobalConfig.CheckIDNameValid(name)
    if not name or name:trim() == "" then
        return false
    end

    return true
end

function GV.GlobalConfig.CheckPasswordValid(password)
    if GV.GlobalConfig.ValidatePassword then
        return password and isstring(password) and #password >= 6 and #password <= 16 -- 还要检测是否为合法字符
    end

    return true
end

function GV.GlobalConfig.IsTempChapterEntryEnabled()
    return GV.GlobalConfig.EnableTempChapterEntry
end

function GV.GlobalConfig.IsChatBarEnabled()
    return GV.GlobalConfig.ReleaseType ~= GE.ReleaseType.Auditing or GV.GlobalConfig.EnableChatBar 
end

function GV.GlobalConfig.IsSkipHealthText()
    return (not GV.GlobalConfig.IsInternalFormal() and not GV.GlobalConfig.IsChannelTest()) or GV.GlobalConfig.SkipHealthText
end

function GV.GlobalConfig.IsLocalServerTest()
    return GV.GlobalConfig.LocalServerTest
end

-- 是否用版号ip
--function GV.GlobalConfig.UseAuditingIp()
--    return GV.GlobalConfig.IsAuditingRelease() and not GV.GlobalConfig.LocalServerTest 
--end

-- 是版号版本或国内正式版本或QA测试版
function GV.GlobalConfig.IsInternalFormal()
    return (GV.GlobalConfig.ReleaseType == GE.ReleaseType.Auditing or 
    GV.GlobalConfig.ReleaseType == GE.ReleaseType.Formal or 
    GV.GlobalConfig.ReleaseType == GE.ReleaseType.CN_Channel_QA or 
    GV.GlobalConfig.ReleaseType == GE.ReleaseType.Develop)
end

function GV.GlobalConfig.CheckPhoneVerifyCode()
    return GV.GlobalConfig.IsInternalFormal() and GV.GlobalConfig.VerifyPhoneCode
end

-- 是国内开发版本
function GV.GlobalConfig.IsDevelopDebug()
    return GV.GlobalConfig.ReleaseType == GE.ReleaseType.Develop
end

-- 是国内正式版本
function GV.GlobalConfig.IsFormalRelease()
    return GV.GlobalConfig.ReleaseType == GE.ReleaseType.Formal
end

-- 是版号版本
function GV.GlobalConfig.IsAuditingRelease()
    return GV.GlobalConfig.ReleaseType == GE.ReleaseType.Auditing
end

function GV.GlobalConfig.IsAbroadRelease()
    return GV.GlobalConfig.ReleaseType == GE.ReleaseType.Abroad
end

function GV.GlobalConfig.IsChannelQATest()
    return GV.GlobalConfig.ReleaseType == GE.ReleaseType.CN_Channel_QA
end

-- 检查屏蔽字
function GV.GlobalConfig.HasForbiddenWord(text)
    if not GV.GlobalConfig.CheckForbiddenWord then
        return false
    end

    if GV.GlobalConfig.IsInternalFormal() then
        local ForbiddenWords = require "ForbiddenWords"
        -- if not GV.IsServer then
        --     local channel = SDKMgr:getChannel()
        --     if channel == GE.Channel.Quick_4399 then
        --         return ForbiddenWords.ContainsForbiddenWord2(text)
        --     end
        -- end
        return ForbiddenWords.ContainsForbiddenWord(text)
    elseif GV.GlobalConfig.IsAbroadRelease() then
        local ForbiddenWords = require "ForbiddenWords_Abroad"
        return ForbiddenWords.ContainsForbiddenWord(text)
    end

    return false
end

-- 技能计算是否启用log
function GV.GlobalConfig.IsSkillSystemLogEnabled()
    return GV.GlobalConfig.SkillSystemLogEnabled
end

-- 名字是否只能是中文
function GV.GlobalConfig.IsNameOnlyChinese()
    return GV.GlobalConfig.NameOnlyChinese
end

-- 是否微信支付审核版本
function GV.GlobalConfig.IsWxPayAudit()
    return GV.GlobalConfig.WxPayAudit
end

-- 是否支付宝支付审核版本
function GV.GlobalConfig.IsAliPayAudit()
    return GV.GlobalConfig.AliPayAudit
end

-- 是否支付宝支付审核版本
function GV.GlobalConfig.IsPaySelectCheck()
    if GV.GlobalConfig.IsWxPayAudit() then
        return true
    end
    if GV.GlobalConfig.IsAliPayAudit() then
        return true
    end
    return GV.GlobalConfig.PaySelectCheck
end

--开启websocket
function GV.GlobalConfig.IsOpenWebSocket()
    local ws = GV.GlobalConfig.websocket
    return ws == "ws" or ws == "wss"
end

--开启wss
function GV.GlobalConfig.IsOpenWSS()
    local ws = GV.GlobalConfig.websocket
    return ws == "wss"
end