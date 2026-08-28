---
--- 跑马灯Component
--- Author: dawanfan
--- Date: 2024-3-5 18:05:33
---

------------ import ------------
local ECSComponent = import("Frame.ECS.ECSComponent")
local ChapterUtils = import('Game.Chapter.ChapterUtils')
local ParseUtils = CS.ParseUtils
local KTool = CS.Engine.Lib.KTool
local PriorityQueue = import("Game.Utils.PriorityQueue")
local Queue = import("Game.DreamSpace.Tools.Queue")
local cs_coroutine = import("XLua.cs_coroutine")
local UIModule = CS.Engine.UI.UIModule
local ResourceModule = CS.Engine.Modules.ResourceModule

--[[
    1. 各系统自行判断，到时间了调用接口播放
    2. 各系统预先将消息加入到队列中，由该模块判断对应消息是否需要播放，满足条件时直接播放

    ** 新增显示类型的时候，修改 CheckShowType 即可
]]


---@class MessageTickerData
---@field playTime number 播放时间
---@field expiredTime number 过期时间
---@field msg string 消息内容
---@field round number 循环次数
---@field priority number 优先级
---@field loopTime number 一轮时间倍率
---@field messageShowType number
---@field roundGap number 间隔时间


---@param a MessageTickerData
---@param b MessageTickerData
local function MessageTickerDataCmp(a, b)
    return a.priority > b.priority
end


local DialogOpenStage = {
    None = 1,
    InLoading = 2,
    LoadFinish = 3
}


---@class MessageTickerComponent
---@field messageQueue Queue
---@field dialog CommonUpLampDialog
---@field pendingList PriorityQueue
local MessageTickerComponent = Class("MessageTickerComponent", ECSComponent)
function MessageTickerComponent:__init()

    self.messageQueue = Queue.New(100)
    self._messageWaitList = Queue.New(100)

    self.loadStage = DialogOpenStage.None
    self.dialog = nil


    self.pendingList = PriorityQueue.New(MessageTickerDataCmp)
end

function MessageTickerComponent:__delete()

    if self.dialog ~= nil then
        self.dialog:Destroy()
        CS.UnityEngine.GameObject.Destroy(self.dialog.controller.gameObject)
    end

    self.messageQueue = nil
    self.messageList = nil
    self.pendingList = nil

    self.loadStage = DialogOpenStage.None

    -- if self._timer ~= nil then
    --     cs_coroutine.stop(self._timer)
    -- end
end

---@param msg string 消息内容
---@param delay number 延迟多久播放
---@param expiredTime number 开始时间过了 expiredTime 还未播放或未播放完则不再播放
---@param loopTime number 一轮时间倍率
---@param round number 消息循环次数
---@param roundGap number 间隔时间
---@param priority number 优先级，数字越高越优先播放
---@param messageShowType Constants.MessageShowType 显示类型，3:全局、2:非战斗、1:主界面
function MessageTickerComponent:AddMessage(msg, delay, expiredTime, round, roundGap, loopTime, priority, messageShowType)
    if msg == nil then
        printError("[MessageTickerComponent][AddMessage] msg is nil")
        return
    end

    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local current = comp:GetPlayerDojo():GetServerTimeWithTimeZone()
    local playTime = current + checkNumber(delay)
    expiredTime = (checkNumber(expiredTime) <= 0) and -1 or checkNumber(expiredTime)
    loopTime = (checkNumber(loopTime) > 0) and checkNumber(loopTime) or 1
    round = (checkNumber(round) == 0) and 2 or checkNumber(round)
    messageShowType = (checkNumber(messageShowType) == 0) and Constants.MessageShowType.OnlyMain or checkNumber(messageShowType)
    roundGap = math.max(checkNumber(roundGap), 0)

    ---@type MessageTickerData
    local message = {
        msg = msg,
        playTime = playTime,
        expiredTime = expiredTime,
        loopTime = loopTime,
        round = round,
        priority = checkNumber(priority),
        messageShowType = messageShowType,
        roundGap = roundGap
    }

    print("[MessageTickerComponent][AddMessage] add message, data: " .. table.dump(message))

    self._messageWaitList:AddLast(message)
end

-- function MessageTickerComponent:PlayMessageImmediately(msg, round, priority, loopTime)

--     if msg == nil then
--         printError("[MessageTickerComponent][AddMessage] msg is nil")
--         return
--     end

--     local data = {
--         msg=msg, 
--         round = (checkNumber(round) == 0) and 2 or checkNumber(round), 
--         priority = checkNumber(priority),
--         loopTime = checkNumber(loopTime)
--     }
--     self.pendingList:Enqueue(data, data)

--     if self.loadStage == DialogOpenStage.None then
--         self:LoadUpLandDialog(true)
--     else
--         self.dialog:PlayMessage()
--     end

-- end

function MessageTickerComponent:LoadUpLandDialog(playOnLoad)
    if self.loadStage ~= DialogOpenStage.None then
        return
    else
        local path = GameUtils.GetUIModulePrefabsPath(Constants.UIModulePrefabsIds.CommonUpLampDialog)
        self.loadStage = DialogOpenStage.InLoading
        -- 异步加载对象
        ResourceModule.LoadGameObjectAsync(path, function(go)
            go.name = "CommonUpLampDialog"
            self.dialog = CfUtils.GetLuaScr(go, "Game.UI.Common.CommonUpLampDialog")

            if self.pendingList:Size() > 0 or playOnLoad then
                self.dialog:PlayMessage()
            end
            self.loadStage = DialogOpenStage.LoadFinish
        end, true, UIModule.RootCanvas.transform)
    end
end

function MessageTickerComponent:AddMessageToPendlingList()
    local comp = GameUtils.GetOrAddEntityCompByType(ECSComponentType.Constants.PlayerComponent)
    local current = comp:GetPlayerDojo():GetServerTimeWithTimeZone()
    self:UpdateMessageQueue()
    
    local count = self.messageQueue:Count()
    for i = 1, count do
        ---@type MessageTickerData
        local value = self.messageQueue:RemoveFirst()
        if value.playTime <= current and self:CheckShowType(value.messageShowType) then
            local expiredTime = value.expiredTime
            if expiredTime == -1 or expiredTime + value.playTime > current then
                self.pendingList:Enqueue(value, value)
            end
        else
            self.messageQueue:AddLast(value)
        end
    end

    return self.pendingList:Size() > 0
end

function MessageTickerComponent:CheckShowType(messageShowType)
    if messageShowType == Constants.MessageShowType.Global then
        return true
    elseif messageShowType == Constants.MessageShowType.NotInBattle then
        return CfUtils.IsInBattle() == false
    elseif messageShowType == Constants.MessageShowType.OnlyMain then
        if UIModule.CurrentScreen == nil then
            return false
        end
        
        local mainDialog = UIModule.CurrentScreen:GetDialog(Constants.UITypeIds.UIHomeView)
        return mainDialog ~= nil
    end
end

function MessageTickerComponent:UpdateMessageQueue()

    local count = self._messageWaitList:Count()
    if count == 0 then
        return
    end

    for i = 1, count do
        ---@type MessageTickerData
        local data = self._messageWaitList:RemoveFirst()
        self.messageQueue:AddLast(data)
    end
end


return MessageTickerComponent
