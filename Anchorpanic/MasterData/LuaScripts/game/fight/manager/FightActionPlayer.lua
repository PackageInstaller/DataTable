module('fight.FightActionPlayer', Class.impl('game/fight/utils/TimeoutExecuter'))

--构造函数
function ctor(self)
    super.ctor(self)
    self.m_actionData = nil
    -- 记录当前播放的优先级标志ID
    self.m_curPriorityID = nil
    self.curBeforePriority = nil
    self.m_liveID = nil
    self.m_liveVo = nil
    -- 记录在延时中 但未播放的优先级标志ID
    self.m_delayPriorityIDDict = {}

    self.m_lastTargetList1 = nil
    self.m_lastTargetList2 = nil
end

function setActionData(self, actionData, liveID, liveVo)
    self.m_actionData = actionData
    self.m_liveID = liveID
    self.m_liveVo = liveVo
    self.m_curPriorityID = nil
    self.curBeforePriority = nil
    self.m_delayPriorityIDDict = {}
    self.mDelayFrame = 1
end

function getPriorityTargets(self)
    -- local targetData = fight.FightManager:getPriorityTargets1(self.m_actionData.actionID)
    -- if targetData then
    --     local targetLst = {}
    --     for k,td in pairs(targetData) do
    --         if td[1] then
    --             for _,v in ipairs(td[1]) do
    --                 targetLst[v] = true
    --             end
    --         end
    --     end
    --     self.m_lastTargetList1 = table.keys(targetLst)
    -- end
    local targetData = fight.FightManager:getPriorityTargets1(self.m_actionData.actionID)
    if targetData then
        self.m_lastTargetList1 = targetData
    end
    return self.m_lastTargetList1
end
function getPriorityTargets2(self)
    local targetData = fight.FightManager:getPriorityTargets1(self.m_actionData.actionID)
    if targetData then
        local targetLst = {}
        for k, td in pairs(targetData) do
            if td[2] then
                for _, v in ipairs(td[2]) do
                    targetLst[v] = true
                end
            end
        end
        self.m_lastTargetList2 = table.keys(targetLst)
    end
    return self.m_lastTargetList2
end

function playRemain(self)
    if self.m_actionData then
        local delayFrame = 1
        local playCount = 0
        self.mDelayFrame = 1
        local maxPriorityID = fight.FightManager:getMaxPriorityID(self.m_actionData)
        if self.m_curPriorityID == nil then
            self.m_curPriorityID = fight.FightManager:getInitPriorityID(self.m_actionData)
            if self.m_curPriorityID then
                for i = self.m_curPriorityID, maxPriorityID do
                    delayFrame = self:playEftAction(i, nil, nil, delayFrame)
                    playCount = playCount + 1
                end
            end
        else
            for priorityID, _ in pairs(self.m_delayPriorityIDDict) do
                delayFrame = self:playEftAction(priorityID, nil, nil, delayFrame)
                playCount = playCount + 1
            end
            if self.m_curPriorityID > 0 then
                for i = self.m_curPriorityID, maxPriorityID do
                    delayFrame = self:playEftAction(i, nil, nil, delayFrame)
                    playCount = playCount + 1
                end
            end
        end

    end
    self.m_curPriorityID = nil
    self.m_delayPriorityIDDict = {}
end

-- function playEftSectionBefore(self)
--     if self.m_actionData then
--         local eftDict = fight.FightManager:getBeforePriorityVoList(self.m_actionData.actionID)
--         for heroID, pDict in pairs(eftDict) do
--             for _, vList in pairs(pDict) do
--                 for _, pVo in ipairs(vList) do
--                     pVo:action(self.m_liveID, heroID)
--                 end
--             end
--         end
--     end
-- end


-- 播放一段action效果数据
function playEftSection(self, hitData, skillRo)
    if self.m_actionData == nil then
        return
    end

    if self.m_curPriorityID == nil then
        self.m_curPriorityID = fight.FightManager:getInitPriorityID(self.m_actionData)
    end
    -- 未有数据可以播放
    if self.m_curPriorityID == -1 or self.m_curPriorityID == nil then
        return
    end

    self:playHitChromaticTween(hitData)

    -- 延迟帧数
    local delayFrame = 1
    self.mDelayFrame = 1

    -- 播放最后一个了
    local maxPriorityID = fight.FightManager:getMaxPriorityID(self.m_actionData)
    if self.m_curPriorityID > maxPriorityID then
        delayFrame = self:playEftAction(maxPriorityID, hitData, skillRo, delayFrame)
        self.m_curPriorityID = -1

        -- GameDispatcher:dispatchEvent(EventName.LAST_HIT_ACTION)
        LoopManager:dispatchEventDelayFrame(GameDispatcher, delayFrame, EventName.LAST_HIT_ACTION)
        return
    end

    delayFrame = self:playEftAction(self.m_curPriorityID, hitData, skillRo, delayFrame)

    -- 找出下一个
    local toGetNext = false
    local nextID = nil
    local priorityList = fight.FightManager:getPriorityList(self.m_actionData)
    if priorityList then
        for _, v in ipairs(priorityList) do
            if toGetNext then
                nextID = v
                break
            end
            if v == self.m_curPriorityID then
                toGetNext = true
            end
        end
    end

    -- 有下一个的情况下 尝试播放中间段的数据
    if toGetNext == true and nextID then
        for i = self.m_curPriorityID + 1, nextID - 1 do
            self.m_delayPriorityIDDict[i] = true
            delayFrame = self:playEftAction(i, hitData, skillRo, delayFrame)
        end
        self.m_curPriorityID = nextID
        return
    else
        for i = self.m_curPriorityID + 1, maxPriorityID do
            self.m_delayPriorityIDDict[i] = true
            delayFrame = self:playEftAction(i, hitData, skillRo, delayFrame)
        end
        self.m_curPriorityID = -1
        -- GameDispatcher:dispatchEvent(EventName.LAST_HIT_ACTION)
        LoopManager:dispatchEventDelayFrame(GameDispatcher, delayFrame, EventName.LAST_HIT_ACTION)
    end
end

function playHitChromaticTween(self, hitData)
    -- 受击色散后处理
    if hitData then
        if hitData.hitActHash == fight.FightDef.ACT_HIT_1 then
            PostHandler:chromaticTween(0.045, 1, 0, 0.1)
        elseif hitData.hitActHash == fight.FightDef.ACT_HIT_2 then
            PostHandler:chromaticTween(0.045, 1, 0, 0.1)
        elseif hitData.hitActHash == fight.FightDef.ACT_HIT_3 then
            PostHandler:chromaticTween(0.03, 1, 0, 0.1)
        elseif hitData.hitActHash == fight.FightDef.ACT_HIT_4 then
            PostHandler:chromaticTween(0.03, 1, 0, 0.1)
        elseif hitData.hitActHash == fight.FightDef.ACT_HIT_5 then
            PostHandler:chromaticTween(0.06, 1, 0, 0.2)
        elseif hitData.hitActHash == fight.FightDef.ACT_HIT_6 then
            PostHandler:chromaticTween(0.1, 1, 0, 0.2)
        end
    end
end

-- 播放一个action效果数据
function playEftAction(self, priorityID, hitData, skillRo, delayFrame)
    self.m_delayPriorityIDDict[priorityID] = nil
    if self.m_actionData then
        local hero_list = fight.FightManager:actionResultHeroList(self.m_actionData)
        if hero_list then
            for _, v in ipairs(hero_list) do
                local pVoList = fight.FightManager:getPriorityVoList(self.m_actionData.actionID, v.hero_id, priorityID)
                if pVoList then
                    for _, pVo in ipairs(pVoList) do
                        local liveID = self.m_liveID
                        local heroID = v.hero_id
                        self:setFrameout(delayFrame, self, function()
                            pVo:action(liveID, heroID, hitData, skillRo)
                        end)
                        -- 优化为一帧5条分摊，否则一帧一条会导致时间太长，影响后面的数据播报
                        delayFrame = 1 + math.floor(self.mDelayFrame / 5)
                        self.mDelayFrame = self.mDelayFrame + 1
                    end
                end
            end
        end
    end
    return delayFrame
end

-- 播放QTE前的效果
function playEftSectionBefore(self, finishCall)
    if finishCall then
        self.playAllFinishCall = finishCall
    end
    if self.m_actionData then
        self.eftDict = fight.FightManager:getBeforePriorityVoList(self.m_actionData.actionID)
        self:nextPriority()
    else
        if self.playAllFinishCall then
            self.playAllFinishCall()
        end
    end
end

-- 进入下一个优先级
function nextPriority(self)
    self.curBeforePriority = self.curBeforePriority or 1
    local vList = self.eftDict[self.curBeforePriority]
    self.curBeforePriority = self.curBeforePriority + 1
    if vList then
        self:playEftActionList(vList)
    else
        -- 所有优先级处理完成，大回调
        self.curBeforePriority = nil
        if self.playAllFinishCall then
            self.playAllFinishCall()
        end
    end
end

-- 同一优先级一起处理
function playEftActionList(self, list)
    local num = 1
    local function finishCall()
        if num >= #list then
            self:nextPriority()
        else
            num = num + 1
        end
    end
    for i, pVo in ipairs(list) do
        pVo:action(self.m_liveID, pVo:getTargetLiveID(), nil, nil, finishCall)
    end
end

-- 播放回合中间的所有效果（非技能效果）
function playAll(self, finishCall)
    self.playAllFinishCall = finishCall

    local delayTime = 0

    -- 正常是走这里结束，回合之间系列buff的处理
    self:playEftSectionBefore()

    if self.m_actionData then
        -- 一般不会有这部分权重信息走，做容错处理
        local priorityList = fight.FightManager:getPriorityList(self.m_actionData)
        if priorityList then
            for _, priorityID in ipairs(priorityList) do
                if delayTime == 0 then
                    self:playEftSection()
                else
                    self:setLiveTimeout(self.m_liveID, self:getActionTime(delayTime), self, self.playEftSection)
                end
                delayTime = delayTime + 1
            end
        end
    end
    -- if self.playAllFinishCall and self.isCanFinishCall ~= false then
    --     self:setLiveTimeout(self.m_liveID, self:getActionTime(delayTime), self, self.playAllFinishCall)
    --     self.isCanFinishCall = nil
    -- end
end

-- 设置是否可回调
function setFinishCallState(self, state)
    self.isCanFinishCall = state
end

-- 开始回调
function startFinishCall(self)
    self.playAllFinishCall()
end

-- 行动时间，预留
function getActionTime(self, cusTime)
    return cusTime
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]