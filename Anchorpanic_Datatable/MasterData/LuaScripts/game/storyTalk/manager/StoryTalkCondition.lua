module('storyTalk.StoryTalkCondition', Class.impl(Manager))

function ctor(self)
    self.m_happenTypes = {}
end

-- 0.首次进入游戏触发（终身触发1次）
function condition00(self, finishCall)
    self.m_happenTypes[0] = finishCall
    return self:tryToStartStory(0, self:_condition(0))
end
-- 1.进入副本前触发（未进入战斗副本）
function condition01(self, finishCall)
    self.m_happenTypes[1] = finishCall
    return self:tryToStartStory(1, self:_condition(1))
end
-- 2.进入副本后触发（战斗开始前触发，战斗暂停）
function condition02(self, finishCall)
    self.m_happenTypes[2] = finishCall
    return self:tryToStartStory(2, self:_condition(2))
end
-- 3.副本战斗第x回合后触发（大回合）
function condition03(self, roundIdx, finishCall)
    self.m_happenTypes[3] = finishCall
    local function _conditionJudgeCall(ro)
        local arr = ro:getHappenArg()
        if arr[1] and arr[1] == roundIdx then
            return true
        end
    end
    return self:tryToStartStory(3, self:_condition(3, _conditionJudgeCall))
end
-- 4.进入副本并己方单位全部死亡后后触发（结算前触发）
function condition04(self, finishCall)
    self.m_happenTypes[4] = finishCall
    return self:tryToStartStory(4, self:_condition(4))
end
-- 5.进入副本并怪物全部死亡后后触发（结算前触发）
function condition05(self, finishCall)
    self.m_happenTypes[5] = finishCall
    return self:tryToStartStory(5, self:_condition(5))
end
-- 6.进入副本胜利后后触发（结算后触发）
function condition06(self, finishCall)
    self.m_happenTypes[6] = finishCall
    return self:tryToStartStory(6, self:_condition(6))
end
-- 7.进副本战斗第x波后触发
function condition07(self, waveIdx, finishCall)
    self.m_happenTypes[7] = finishCall
    local function _conditionJudgeCall(ro)
        local arr = ro:getHappenArg()
        if arr[1] and arr[1] == waveIdx then
            return true
        end
    end
    return self:tryToStartStory(7, self:_condition(7, _conditionJudgeCall))
end

-- 8.走完某个新手引导id后触发
-- 指定引导ID
function condition08(self, guideID, finishCall)
    self.m_happenTypes[8] = finishCall
    local function _conditionJudgeCall(ro)
        local arr = ro:getHappenArg()
        if arr[1] and arr[1] == guideID then
            return true
        end
    end
    return self:tryToStartStory(8, self:_condition(8, _conditionJudgeCall))
end
-- 9.进入副本选人前触发（未进入战斗副本）
function condition09(self, battleType, battleFieldID, finishCall)
    self.m_happenTypes[9] = finishCall
    local lastBattleType = fight.FightManager:getLatestBattleType()
    local lastBattleFieldID = fight.FightManager:getLatestBattleFieldID()
    fight.FightManager:setLatestBattleData(battleType, battleFieldID)
    local ro = self:tryToStartStory(9, self:_condition(9))
    fight.FightManager:setLatestBattleData(lastBattleType, lastBattleFieldID)
    return ro
end

-- 10.其他系统剧情触发(系统类型,系统参数1,系统参数2,系统参数2)
function condition10(self, finishCall, functType, functArg1, functArg2, functArg3)
    self.m_happenTypes[10] = finishCall
    local function _conditionJudgeCall(ro)
        local arr = ro:getHappenArg()
        if functType == arr[1] then
            if arr[2] and arr[2] ~= functArg1 then
                return false
            elseif arr[3] and arr[3] ~= functArg2 then
                return false
            elseif arr[4] and arr[4] ~= functArg3 then
                return false
            end
            return true
        end
    end
    return self:tryToStartStory(10, self:_conditionWithoutBattle(10, _conditionJudgeCall))
end

-- 10.其他系统剧情触发(系统类型,系统参数数组)
function condition10_2(self, finishCall, functType, argTable)
    self.m_happenTypes[10] = finishCall
    local function _conditionJudgeCall(ro)
        local arr = ro:getHappenArg()
        if functType == arr[1] then
            local len = #arr
            for i = 2, len do
                if not argTable[i - 1] or arr[i] ~= argTable[i - 1] then
                    return false
                end
            end
            return true
        end
    end
    return self:tryToStartStory(10, self:_conditionWithoutBattle(10, _conditionJudgeCall))
end

-- 11.进入副本胜利后后触发（退出前触发）
function condition11(self)
    self.m_happenTypes[11] = nil

    if self:_condition(11) and storyTalk.StoryTalkManager:setCurStoryID(self:_condition(11):getRefID()) then
       cusLog(self:_condition(11):getRefID())
        GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL)
        return true
    else
        -- self:storyCallback(11, false)
        self:callAlwayCallback()
        return false
    end
    -- return self:tryToStartStory(11, self:_condition(11))
end

--打开某界面时触发
function condition12(self,linkId)
    --self.m_happenTypes[12] = nil
    local ros = storyTalk.StoryTalkManager:storyRos()
    for refID, v in pairs(ros) do
        if storyTalk.StoryTalkManager:canPlayStory(refID) and v:getHappenType() == 12 and v:getHappenArg()[1]~=nil and  v:getHappenArg()[1]== linkId then
            storyTalk.StoryTalkManager:setCurStoryID(refID)
            GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL)
        end
    end

end

function setAlwayCallback(self, call)
    self.alwayCall = call
end

function callAlwayCallback(self)
    if self.alwayCall then
        self.alwayCall()
        self.alwayCall = nil
    end
end

-- 剧情的触发条件判断 (通用)
-- 条件成立返回唯一的剧情数据
-- conditionJudgeCall 为额外参数作判断的方法调用
function _condition(self, conditionType, conditionJudgeCall)
    local battleType = fight.FightManager:getLatestBattleType() or 0
    local battleFieldID = fight.FightManager:getLatestBattleFieldID() or 0
    -- print("_condition====", type(battleType), battleType, type(battleFieldID), battleFieldID, conditionType)
    local ros = storyTalk.StoryTalkManager:storyRos()
    for refID, v in pairs(ros) do
        if v:getHappenType() == conditionType and storyTalk.StoryTalkManager:canPlayStory(refID) then
            if v:getBattleType() == battleType and v:getBattleFieldId() == battleFieldID or (conditionType == 0) then
                -- table.print(v)
                if conditionJudgeCall then
                    if conditionJudgeCall(v) then
                        return v
                    end
                else
                    return v
                end
            end
        end
    end
end

-- 剧情的触发条件判断 (通用, 不跟战斗关卡数据挂钩)
-- 条件成立返回唯一的剧情数据
-- conditionJudgeCall 为额外参数作判断的方法调用
function _conditionWithoutBattle(self, conditionType, conditionJudgeCall)
    if not conditionJudgeCall then
        return
    end
    -- print("_condition====", type(battleType), battleType, type(battleFieldID), battleFieldID, conditionType)
    local ros = storyTalk.StoryTalkManager:storyRos()
    for refID, v in pairs(ros) do
        if (v:getHappenType() == conditionType) then
            if (storyTalk.StoryTalkManager:canPlayStory(refID)) then
                if conditionJudgeCall(v) then
                    return v
                end
            end
        end
    end
end

function tryToStartStory(self, happenType, storyRo)
    if storyRo and storyTalk.StoryTalkManager:setCurStoryID(storyRo:getRefID()) then
        -- print("tryToStartStory ", storyRo:getRefID())
        if happenType == 1 or happenType == 0 then
            self.needWait = true
        else
            self.needWait = false
        end
        GameDispatcher:dispatchEvent(EventName.OPEN_STORY_TALK_PANEL)
        return true
    else
        self:storyCallback(happenType, false)
    end
    return false
end

function cunNeedWait(self)
    return self.needWait
end

function resetCanNeedWait(self)
    self.needWait = false
end

function setStoryCallback(self, happenType, finishCall)
    self.m_happenTypes[happenType] = finishCall
end

function storyCallback(self, happenType, beSuccess, storyRo)
    local gcall = self.m_happenTypes[happenType]
    if gcall then
        self.m_happenTypes[happenType] = nil
        gcall(beSuccess, storyRo)
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
