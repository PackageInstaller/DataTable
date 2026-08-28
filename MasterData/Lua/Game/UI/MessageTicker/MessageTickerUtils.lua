---
--- 跑马灯 Utils
--- Author: dawanfan
--- Date: 2024-3-5 17:57:36
---

local I18NModule = CS.Engine.I18N.I18NModule

---@type MessageTickerComponent
local messageTickerComponent = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.MessageTickerComponent)


---@class MessageTickerUtils
local MessageTickerUtils = {}

---@param msgId string 消息内容
---@param format table
---@param delay number
function MessageTickerUtils.ShowMessageById(msgId, format, delay)
    ---@type MessageTickerVo
    local vo =  CfUtils.GetCfVo(AutoIds.IdSetting6220, "MessageTickerVo", msgId)
    local msg = localize(vo.msg, format)
    MessageTickerUtils.ShowMessage(msg, delay, 0, vo.round, vo.roundGap, 1, vo.priority, vo.messageShowType)
end


function MessageTickerUtils.ShowServerMessage(packetData)
    if packetData == nil or packetData.data == nil then
        return
    end

    local msgContent = packetData.data.content
    if msgContent == nil then
        printError("[MessageTickerUtils][ShowServerMessage] msgContent is nil")
        return
    end
    local msg = msgContent[string.lower(string.join(string.split(I18NModule.Lang, "_"), "-"))]

    messageTickerComponent:AddMessage(msg, 0, 0, 1, 0, 1, 10, packetData.data.type)
end

---@param msg string 消息内容
---@param delay number 延迟多久播放
---@param expiredTime number 开始时间过了 expiredTime 还未播放或未播放完则不再播放
---@param loopTime number 一轮时间倍率
---@param round number 消息循环次数
---@param roundGap number 间隔时间
---@param priority number 优先级，数字越高越优先播放
---@param messageShowType Constants.MessageShowType 显示类型，3:全局、2:非战斗、1:主界面
function MessageTickerUtils.ShowMessage(msg, delay, expiredTime, round, roundGap, loopTime, priority, messageShowType)
    messageTickerComponent:AddMessage(msg, delay, expiredTime, round, roundGap, loopTime, priority, messageShowType)
end


return MessageTickerUtils
