--[[ 
-----------------------------------------------------
@filename       : ActitvityExtraManager
@Description    : 额外活动管理器
@date           : 2023
@Author         : tonn  
@copyright      : (LY) 2023 雷焰网络
-----------------------------------------------------
]]
module('game.activity.manager.ActitvityExtraManager', Class.impl(Manager))

--内部事件  网络协议更新 
UPDATE_SUBCTRIBE_MSG = "UPDATE_SUBCTRIBE_MSG"

--构造
function ctor(self)
    super.ctor(self)
    self:__init()
end

--析构
function dtor(self)
end

-- Override 重置数据
function resetData(self)
    super.resetData(self)
    self:__init()
end

--初始化
function __init(self)
    self.subscribeConfigDic = {}
    self.subscribeMsgDic = {}
    self.allReceived = true
    self.lastAwardTime = 0
    self.isBiliOpen = 0
end

--------------------------Config-----------------------------
-- 解析配置表数据
function parseConfig(self)
    self.mBillboardList = {}
    local baseData = RefMgr:getData("concern_gift_data")
    for key, data in pairs(baseData) do
        local vo = LuaPoolMgr:poolGet(activity.ActivitySubscribeVo)
        vo:parseData(key, data)
        self.subscribeConfigDic[key] = vo
    end
end


--------------------------MSG-----------------------------
-- Msg
function parsenMsg(self, msg)
    self.isBiliOpen = msg.is_b_open --B站包是否开启功能
    self.lastAwardTime = msg.last_award_time --最后一次领取时间

    if msg and msg.gain_state_list then
        --可领取状态 0-未关注 1-可领取 2-已领取 
        for _, msgVo in pairs(msg.gain_state_list) do
            self.subscribeMsgDic[msgVo.key] = msgVo.value
        end
    else
        logInfo("msg  not_award_list 为空, 后端协议问题 ")
        if not    self.subscribeMsgDic then
            self.subscribeMsgDic = {}
        end
    end
    self:dispatchEvent(self.UPDATE_SUBCTRIBE_MSG)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    self:checkIsAllReceived()
end

-- 更新Msg
function updateMsg(self, msg)
    if msg and msg.id then
        if msg.result == 1 then
            if self.subscribeMsgDic[msg.id] ~= 2 then
                self.subscribeMsgDic[msg.id] = 2  --领取成功
            end
        end
    else
        logInfo("msg  not_award_list 为空, 后端协议问题 ")
        if not    self.subscribeMsgDic then
            self.subscribeMsgDic = {}
        end
    end
    self:dispatchEvent(self.UPDATE_SUBCTRIBE_MSG)
    GameDispatcher:dispatchEvent(EventName.UPDATE_ACTIVITY_RED)
    self:checkIsAllReceived()
end

--------------------------function-----------------------------

--  请求领取 
--  写在管理器里 不放在控制器里了 好拿数据 
function sendReceiveRequest(self, id)
    if id ~= nil then
        if self:getConfigVoById(id) ~= nil then
            local state = self.subscribeMsgDic[id]
            if state == 1 then
                SOCKET_SEND(Protocol.CS_GAIN_CONCERN_GIFT, { id = id })
            elseif state == 2 then
                gs.Message.Show("重复领取")
            elseif state == 0 then
                gs.Message.Show("请先关注")
            end
        else
            logError("此Id不在配置表里，找策划")
        end
    else
        gs.Message.Show("无效Id")
    end
end



--  关注请求
--  
function sendSubscribeRequest(self, id)
    if id ~= nil then
        if self:getConfigVoById(id) ~= nil then
            -- 0 未关注
            if self.subscribeMsgDic[id] then
                if self.subscribeMsgDic[id] == 0 then
                    SOCKET_SEND(Protocol.CS_CONCERN_GIFT_CAN_GAIN, { id = id })
                else
                    gs.Message.Show("已经关注")
                end
            else
                logError("后端数据问题 ,Id 不在后端MSG中")
            end
        else
            gs.Message.Show("此Id不在配置表里")
        end
    else
        gs.Message.Show("无效Id")
    end
end


function getConfigVoById(self, id)
    if next(self.subscribeConfigDic) == nil then
        self:parseConfig()
    end
    return self.subscribeConfigDic[id]
end

function getMsgVoById(self, id)
    return self.subscribeMsgDic[id]
end

function checkIsOpen(self)
    local channelId, channelName = sdk.SdkManager:getChannelData()
    if channelId == sdk.AndroidChannelId.BILI and self.isBiliOpen == 0 then
        -- bilibili包后端控制开放
        return false
    end
    local funcIsOpen = funcopen.FuncOpenManager:isOpen(funcopen.FuncOpenConst.FUNC_ID_ACTIVITY_SUBSCRIBE, false)
    if funcIsOpen then
        if self:checkIsAllReceived() then
            local clientTime = GameManager:getClientTime()
            local remaidTime = clientTime - self.lastAwardTime
            if remaidTime > 8 * 60 * 60 then
                -- 8小时后关闭
                return false
            end
        end
        return true
    else
        return false
    end
end

-- 是否全部已领取
function checkIsAllReceived(self)
    for _, state in pairs(self.subscribeMsgDic) do
        if state < 2 then
            return false
        end
    end
    return true
end

-- 红点判断
function checkBubble(self)
    if not self:checkIsOpen() then
        return false
    end
    if next(self.subscribeMsgDic) then
        for _, state in pairs(self.subscribeMsgDic) do
            if state == 1 then
                return true
            end
        end
    end
    return false
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]