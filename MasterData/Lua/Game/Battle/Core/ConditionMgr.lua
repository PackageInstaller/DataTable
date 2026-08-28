--[[
    author:luqucheng
    time:2021-01-21 15:14:59
]]
local gameUtils = CS.GameUtils
local Condition = import('Game.Battle.Core.Condition')


local ConditionMgr = {}
ConditionMgr = Class("ConditionMgr")
ConditionMgr.conditions = nil


ConditionMgr.winConditions = nil
ConditionMgr.loseConditions = nil
--@RefType [Game.Battle.Core.Condition#Condition<>]
ConditionMgr.threeStarConditions = nil

ConditionMgr.context = nil              -- 条件跨多场战斗使用时保存的上下文
ConditionMgr.totalQuestCount = nil      -- 条件跨多场战斗使用时总共的场次数

function ConditionMgr:__init( initData )
    self.context = {
        curQuestIndex = 1,
        accumulateTurn = 0,
    }
    self.threeStarConditions = {}
    if isNull(initData.starConditions) then
        return
    end
    -- starConditions = {
    --     conditions = {
    --         {conditionId = 1, conditionNum = 1, rounds = 1, num = 0, isSucceed = false, isComplete = false}
    --     },
    --     context = {
    --         curQuestIndex = 1,
    --         accumulateTurn = 1,
    --     },
    --     totalQuestCount = 2,
    -- }

    -- 共用三星条件的关卡总数
    self.totalQuestCount = initData.starConditions.totalQuestCount or 1
    
    -- 跨关卡记录的三星条件上下文数据
    self.context = initData.starConditions.context
    if isNull(self.context) then
        self.context = {
            curQuestIndex = 0,
            accumulateTurn = 0,
        }
    end
    self.context.curQuestIndex = self.context.curQuestIndex + 1
    
    -- 初始化三星条件
    local starConditions = initData.starConditions.conditions or initData.starConditions or {}
    local setting = BattleConfig:GetSettingVo(AutoIds.IdSetting820, "QuestConditionVo")
    for i,v in ipairs(starConditions) do
        --@RefType [Game.Setting.Vo.QuestConditionVo#QuestConditionVo]
        local data = setting:Get(checkNumber(v.conditionId))
        if data then
            -- 配置数据
            ---@type Condition
            local con = Condition.New(data.type)                -- 条件类型id
            con.starConditionId = checkNumber(v.conditionId)    -- 条件预设id
            con.operator = data.comparisonOperators             -- 条件预设比较运算符
            con.conditionParam = data.otherParam                -- 条件预设其他参数
            con.targetNum = checkNumber(v.conditionNum)         -- 关卡表目标参数
            con.limitRound = checkNumber(v.rounds)              -- 关卡表限制回合
            con.refreshType = data.refreshType                  -- 条件预设刷新方式
            con:Clear()

            -- 继承前面关卡的数据
            if isNotNull(v.num) then
                con.num = checkNumber(v.num)
            end
            if isNotNull(v.isSucceed) then
                con.isSucceed = v.isSucceed
            end
            if isNotNull(v.isComplete) then
                con.isCompleted = v.isComplete
            end

            table.insert(self.threeStarConditions, con)
        end
    end
end

--- 每个波次更换胜利失败条件
function ConditionMgr:OnChangeWave()
    local waveData = BattleMgr:GetWaveData()
    print(table.toString(waveData, "waveData"))
    --判断结束条件
    local winCondition = Core:GetWaveEndConditionData(waveData and waveData.winCondition or 0)
    self.winConditions = winCondition.conditions
    local loseCondition = Core:GetWaveEndConditionData(waveData and waveData.loseCondition or -1)
    self.loseConditions = loseCondition.conditions

    for i,groups in ipairs(self.winConditions) do
        for j,condition in ipairs(groups) do
            condition:Clear()
            condition.limitRound = 0
        end
    end

    for i,groups in ipairs(self.loseConditions) do
        for j,condition in ipairs(groups) do
            condition:Clear()
            condition.limitRound = 0
        end
    end
end

--- 检查波次的胜利失败条件是否已经满足
function ConditionMgr:CheckWaveOver()
    local camp = Constants.Camp.One

    self:CheckConditions()

    if not isNull(self.loseConditions) then
        for i,cs in pairs(self.loseConditions) do
            local isMatch = true    -- 先假设条件全都满足了
            for j,c in ipairs(cs) do
                if not self:CheckOneCondition(camp, c) then
                    isMatch = false -- 有一条不满足整个group就不满足了
                    break
                else
                end
            end
            if isMatch then
                return true, Constants.Camp.Two     -- 满足了，敌方胜
            end
        end
    end
    
    -- print("IsGameOver", 2, table.toString(winCondition.conditions, "winCondition"))

    if not isNull(self.winConditions) then
        for i,cs in pairs(self.winConditions) do
            local isMatch = true
            local isIgnoreWave = false
            for j,c in ipairs(cs) do
                local match, ignoreWave = self:CheckOneCondition(camp, c)
                if not match then
                    isMatch = false
                    break
                end
                if ignoreWave then
                    isIgnoreWave = true
                end
            end
            if isMatch then
                return true, Constants.Camp.One     -- 满足了，我方胜
            end
        end
    end
    
    -- print("IsGameOver", 3)

  

    return false

end

function ConditionMgr:OnRoundStart()
    self.context.accumulateTurn = self.context.accumulateTurn + 1
end

function ConditionMgr:CompareValue(num, targetNum, operator)
    if operator == 1 then
        return num >= targetNum
    else
        return num <= targetNum
    end
end

--@condition: [Game.Battle.Core.Condition#Condition]
function ConditionMgr:ConditionCompare(condition)
    return self:CompareValue(condition.num, condition.targetNum, condition.operator)
end

--- 检查条件是否达成，达成以后设置为完成
--@condition: [Game.Battle.Core.Condition#Condition]
function ConditionMgr:CheckOneCondition(camp, condition, judgeTime)

    --条件判定成功一次后就不再判定
    if condition.isCompleted then
        return condition.isSucceed
    end

    if not judgeTime then
        judgeTime = Constants.BattleConditionJudgeTime.DataUpdate
    end

    local BattleMgr = BattleMgr

    --判定时机不满足则不进入判定
    if judgeTime ~= condition.data.judgeTime and judgeTime ~= Constants.BattleConditionJudgeTime.GameOver then--gameover时会进入所有未完成条件的判断
        return false
    end
    -- 失败时不会有judgeTime为gameover的调用进来，只有胜利时才会进来

    -- 这个限定回合只有3星条件有用。
    -- 胜利失败条件不需要限制回合，关卡最大回合数就是限制，所以胜利失败条件的limitRound都是0
    -- 回合限制不是某一个条件的内部参数，是一个所有条件都可以使用的参数，任何条件都可以加回合限制
    --条件的限制回合存在的话，限制回合数到了则判定失败
    if condition.limitRound > 0 and condition.limitRound < self.context.accumulateTurn then
        condition:SetComplete(false)
        return false
    end

    -- print("->ConditionMgr:CheckOneCondition:", camp, table.dump(condition))
    local GameOverCondition = Constants.GameOverCondition

    local switch = {
        [GameOverCondition.OverTurn] = function (  )
            -- 因为逻辑里默认超过maxTurn以后自动判负，所以如果结算条件里配了这个OverTurn，那么肯定是想要判胜
            return BattleMgr.totalTurnCount > BattleMgr.maxTurn, true
        end,
        [GameOverCondition.EnemyAllDead] = function (  )
            return BattleMgr:IsCampAllDead(BattleMgr:GetOppoCamp(camp))
        end,
        [GameOverCondition.EnemyBossDead] = function (  )
            return BattleMgr:IsCampAllBossDead(BattleMgr:GetOppoCamp(camp))
        end,
        [GameOverCondition.SpecialIdDead] = function (  )
            local rs = BattleMgr.roles--Core:GetFriendRoles(BattleMgr:GetOppoCamp(camp))
            for i,v in ipairs(rs) do
                if v:IsDead() and v.typeId == condition.conditionParam then
                    return true
                end
            end
            return false
        end,
        [GameOverCondition.SpecialIdAllDead] = function (  )
            local rs = BattleMgr:GetAliveRoles(BattleMgr:GetOppoCamp(camp))
            for i,v in ipairs(rs) do
                if v.typeId == condition.conditionParam  then
                    return false
                end
            end
            return true
        end,
        -- [GameOverCondition.MissionAllFailed] = function (  )
        --     return false
        -- end,
        -- [GameOverCondition.MissionAllSucceed] = function (  )
        --     return ConditionMgr:IsMissionAllSucceed()
        -- end,
        [GameOverCondition.SelfOneDead] = function (  )
            local rs = Core:GetFriendRoles(camp)
            for i,v in ipairs(rs) do
                if v:IsDead() then
                    return true
                end
            end
            return false
        end,
        [GameOverCondition.SelfAllDead] = function (  )
            return BattleMgr:IsCampAllDead(camp)
        end,
        [GameOverCondition.Win] = function (  )
            return true
        end,
        [GameOverCondition.AllSelfHpPerNotSmallerThan] = function (  )
            local rs = Core:GetFriendRoles(camp)
            for i,v in ipairs(rs) do
                if v.roleType ~= Constants.RoleType.SpecialSummon and (v:GetNowHPPercent() <= condition.targetNum or v:IsDead()) then
                    return false
                end
            end
            return true
        end,
        [GameOverCondition.HasElementMemberNum] = function (  )
            local roleDatas = camp == Constants.Camp.One and BattleMgr.initData.playerTeam[1] or BattleMgr.initData.enemyTeam[1]
            local count = 0
            for i,roleData in ipairs(roleDatas) do
                if roleData.attribute == condition.conditionParam then
                    count = count + 1
                end
            end
            return self:CompareValue(count, condition.targetNum, condition.operator)
        end,
        [GameOverCondition.HasMemberNum] = function (  )
            local roleDatas = camp == Constants.Camp.One and BattleMgr.initData.playerTeam[1] or BattleMgr.initData.enemyTeam[1]
            return self:CompareValue(#roleDatas, condition.targetNum, condition.operator)
        end,
        [GameOverCondition.HasCareerNum] = function (  )
            local roleDatas = camp == Constants.Camp.One and BattleMgr.initData.playerTeam[1] or BattleMgr.initData.enemyTeam[1]
            local count = 0
            for i,roleData in ipairs(roleDatas) do
                if roleData.career == condition.conditionParam then
                    count = count + 1
                end
            end
            return self:CompareValue(count, condition.targetNum, condition.operator)
        end,
        [GameOverCondition.HasSomeRareNum] = function (  )
            local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting28)
            local roleDatas = camp == Constants.Camp.One and BattleMgr.initData.playerTeam[1] or BattleMgr.initData.enemyTeam[1]
            local count = 0
            for i,roleData in ipairs(roleDatas) do
                if roleData.cardId then
                    local row = tableFile:GetByPrimaryKey(roleData.cardId)
                    if not isNull(row) then
                        local rare = row:Get("rare")
                        if checkNumber(rare) == condition.conditionParam then
                            count = count + 1
                        end
                    end
                end
            end
            return self:CompareValue(count, condition.targetNum, condition.operator)
        end,
        [GameOverCondition.HasSomeCatTypeNum] = function (  )
            local tableFile = BattleConfig:GetSetting(AutoIds.IdSetting28)
            local roleDatas = camp == Constants.Camp.One and BattleMgr.initData.playerTeam[1] or BattleMgr.initData.enemyTeam[1]
            local count = 0
            for i,roleData in ipairs(roleDatas) do
                if roleData.cardId then
                    local row = tableFile:GetByPrimaryKey(roleData.cardId)
                    if not isNull(row) then
                        local catType = row:Get("characterId")
                        if checkNumber(catType) == condition.conditionParam then
                            count = count + 1
                        end
                    end
                end
            end
            return self:CompareValue(count, condition.targetNum, condition.operator)
        end,
        [GameOverCondition.SpecialSummonHpPercent] = function (  )
            local specialSummonRole = BattleMgr:GetSpecialSummon(camp)
            if not specialSummonRole then
                return false
            end
            return self:CompareValue(specialSummonRole:GetNowHPPercent(), condition.targetNum, condition.operator)
        end,
    }

    local isSucceed = false
    if condition.data.judgeType == Constants.BattleConditionJudgeViaType.State then
        local func = switch[condition.type]
        if func then
            isSucceed = func()
        else
            printError('状态类的战斗条件判定不存在:'..condition.type)
        end
    else
        isSucceed = self:ConditionCompare(condition)
    end

    condition.isSucceed = isSucceed
    if judgeTime == Constants.BattleConditionJudgeTime.DataUpdate and condition.data.judgeType == Constants.BattleConditionJudgeViaType.Count then
        --大于等于成功，或者小于等于失败都算完成
        if (isSucceed and condition.operator == 1) or (not isSucceed and condition.operator ~= 1) then
            condition:SetComplete(isSucceed)
        end
    elseif judgeTime ~= Constants.BattleConditionJudgeTime.DataUpdate then
        --非数据更新式的条件在判断一次后都直接结束
        condition:SetComplete(isSucceed)
    end

    return isSucceed
end

--- 更新统计类型的条件的数量，对于胜利失败条件，只更新数量，对于三星条件，更新完数量以后检查是否条件是否成功，成功以后设置为完成
---@param conditionType any
---@param data any
---@param additionalValue any
function ConditionMgr:UpdateConditionData( conditionType, data, additionalValue )
    local camp = Constants.Camp.One
    if not self.winConditions or not self.loseConditions then
        return
    end
    additionalValue = additionalValue or 1
    local deal = function ( condition, conditionType, data )
        -- 现在只有判断类型是数量的条件才会更新，判断类型是状态的条件不会更新
        if condition.data.judgeType == Constants.BattleConditionJudgeViaType.Count then
            if not condition.num then
                condition.num = 0
            end

            if not condition.isCompleted and conditionType == condition.type and (condition.conditionParam == 0 or condition.conditionParam == data) then
                condition.num  = condition.num + additionalValue
                return true
            end
        end
        return false
    end

    for i,groups in ipairs(self.winConditions) do
        for j,condition in ipairs(groups) do
            local isUpdated = deal(condition, conditionType, data)
            if isUpdated then
                RecordMgr:AddRecord(RecordMgr.ConditionUpdateRecord.New(condition, Constants.BattleConditionUsedTo.WinCondition))
            end
        end
    end

    for i,groups in ipairs(self.loseConditions) do
        for j,condition in ipairs(groups) do
            local isUpdated = deal(condition, conditionType, data)
            if isUpdated then
                RecordMgr:AddRecord(RecordMgr.ConditionUpdateRecord.New(condition, Constants.BattleConditionUsedTo.LoseCondition))
            end
        end
    end

    for i,condition in ipairs(self.threeStarConditions) do
        local isUpdated = deal(condition, conditionType, data)
        if isUpdated then
            self:CheckOneCondition(camp, condition)
            RecordMgr:AddRecord(RecordMgr.ConditionUpdateRecord.New(condition, Constants.BattleConditionUsedTo.ThreeStarCondition))
        end
    end
end

function ConditionMgr:CheckConditions(conditionJudgeTime)
    -- 如果不是最后一关，不检查GameOver的条件，只在最后一关才检查GameOver的条件
    if checkNumber(conditionJudgeTime) == Constants.BattleConditionJudgeTime.GameOver
    and self.context.curQuestIndex < self.totalQuestCount then
        return
    end

    local camp = Constants.Camp.One
    for i,condition in ipairs(self.threeStarConditions) do
        if not condition.isCompleted then
            local isSucceedOld = condition.isSucceed
            local isSucceed = self:CheckOneCondition(camp, condition, conditionJudgeTime)
            if condition.isCompleted or isSucceedOld ~= isSucceed then
                RecordMgr:AddRecord(RecordMgr.ConditionUpdateRecord.New(condition, Constants.BattleConditionUsedTo.ThreeStarCondition))
            end
        end
    end
end

function ConditionMgr:RefreshCondition(refreshType)
    for i,condition in ipairs(self.threeStarConditions) do
        if not condition.isCompleted then
            if condition.refreshType == refreshType then
                condition.num = 0
                RecordMgr:AddRecord(RecordMgr.ConditionUpdateRecord.New(condition, Constants.BattleConditionUsedTo.ThreeStarCondition))
            end
        end
    end
end

-- function ConditionMgr:IsMissionAllSucceed(  )
--     if not self.conditions then
--         return false
--     end

--     for i,condition in ipairs(self.conditions) do
--         if not condition.num then
--             condition.num = 0
--         end
--         local finish = true
--         if condition.comparType == Constants.QuestConditionComparType.GreaterThan then
--             finish = condition.num >= checkNumber(condition.value)
--         elseif condition.comparType == Constants.QuestConditionComparType.LessThan then
--             finish = condition.num <= checkNumber(condition.value)
--         end

--         if finish == false then
--             return false
--         end
--     end

--     return true
-- end

return ConditionMgr