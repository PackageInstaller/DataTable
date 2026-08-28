--[[
    author:luqucheng
    time:2022-06-15 16:48:01
]]
local gameUtils = CS.GameUtils
---@class Condition
local Condition = {}
Condition = Class("Condition")

Condition.type = 0              -- 条件类型id
Condition.operator = 0          -- 条件预设比较运算符
Condition.conditionParam = 0    -- 条件预设其他参数
Condition.targetNum = 0         -- 关卡表目标参数

Condition.limitRound = 0        -- 关卡表限制回合
Condition.refreshType = 0       -- 条件预设刷新方式

--@RefType [Game.Setting.Vo.WaveEndConditionTypeVo#WaveEndConditionTypeVo]

---@type WaveEndConditionTypeVo
Condition.data = nil--对应WaveEndConditionTypeVo    -- 条件类型表数据

Condition.num = 0

Condition.starConditionId = 0 --三星条件id，对应关卡条件表

Condition.isCompleted = false

Condition.isSucceed = false

function Condition:__init(type)
    self.type = type
    self.data = Core:GetBattleConditionData(type)   -- 条件类型表数据
    -- print("Condition", type, table.toString(self.data, "data"))

    self:Clear()
end

function Condition:Clear()
    self.num = 0
    self.isCompleted = false
    self.isSucceed = false
end

function Condition:SetComplete(isSucceed)
    self.isSucceed = isSucceed
    self.isCompleted = true
end

function Condition:GetConditionState()
    if not self.isCompleted then
        return Constants.BattleConditionState.Process
    end

    if self.isSucceed then
        return Constants.BattleConditionState.Succeed
    end

    return Constants.BattleConditionState.Fail
end

return Condition