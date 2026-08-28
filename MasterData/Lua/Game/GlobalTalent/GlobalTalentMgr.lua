
local import = import
local GlobalTalentAddData = import('Game.GlobalTalent.GlobalTalentAddData')

local Singleton        = import('Frame.Singleton')
---@class GlobalTalentMgr
---@field GetInstance fun(self:GlobalTalentMgr):GlobalTalentMgr
local GlobalTalentMgr  = Class("GlobalTalentMgr", Singleton)

function GlobalTalentMgr:__init()
    self._globalTalent = {
        -- [Constants.GlobalTalentEffectId] = GlobalTalentAddData
    }

    --- 属性天赋map
    self._attributeTalentIdMap = {}
end

function GlobalTalentMgr:__delete()
    self._globalTalent = nil
end

---CalcNum
---计算全局天赋数值
---@param base                number 基础数值
---@param talentEffectId      Constants.GlobalTalentEffectId 基础数值
---@param isFloat             boolean 要计算的值是否是浮点数
---@param conditionCb         function 用于提取数值
---@param isCeil              boolean 整数是否向上取整
---@return number 全局天赋数值
function GlobalTalentMgr:CalcNum(baseNum, talentEffectId, isFloat, conditionCb, isCeil)
    local globalTalent        = self:GetGlobalTalent()
    return self:CalcNumByGlobalTalent(globalTalent, baseNum, talentEffectId, isFloat, conditionCb, isCeil)
end

---CalcNumByGlobalTalent
---计算全局天赋数值
---@param globalTalent        table 自定义全局天赋
---@param base                number 基础数值
---@param talentEffectId      Constants.GlobalTalentEffectId 基础数值
---@param isFloat             boolean 要计算的值是否是浮点数
---@param conditionCb         function 用于提取数值
---@param isCeil              boolean 整数是否向上取整
---@return number 全局天赋数值
function GlobalTalentMgr:CalcNumByGlobalTalent(globalTalent, baseNum, talentEffectId, isFloat, conditionCb, isCeil)
    ---@type GlobalTalentAddData
    local globalTalentAddData = globalTalent[talentEffectId]
    return globalTalentAddData == nil and baseNum or self:CalcFinalNum(baseNum, globalTalentAddData, isFloat, conditionCb, isCeil)
end

---CalcFinalNum
---计算全局天赋最终数值
---@param base                number 基础数值
---@param talentEffectId      Constants.GlobalTalentEffectId 基础数值
---@param globalTalentAddData GlobalTalentAddData 全局属性加成数据
---@param isFloat             boolean 要计算的值是否是浮点数
---@param conditionCb         function 用于提取数值
---@param isCeil              boolean 整数是否向上取整
---@return number 全局天赋数值
function GlobalTalentMgr:CalcFinalNum(base, globalTalentAddData, isFloat, conditionCb, isCeil)
    local addType2Num = globalTalentAddData:GenerateParams(conditionCb)
    
    return self:GenerateFinalNum(base, addType2Num, isFloat, isCeil)
end

---CalcNumBySource
---计算对应全局天赋来源的全局天赋数值
---@param source              Constants.GlobalTalentSource 全局天赋来源
---@param base                number 基础数值
---@param talentEffectId      Constants.GlobalTalentEffectId 基础数值
---@param isFloat             boolean 要计算的值是否是浮点数
---@param conditionCb         function 用于提取数值
---@param isCeil              boolean 整数是否向上取整
---@return number 对应全局天赋来源的全局天赋数值
function GlobalTalentMgr:CalcNumBySource(source, baseNum, talentEffectId, isFloat, conditionCb, isCeil)
    local globalTalent = self:GetGlobalTalent()
    return self:CalcNumByGlobalTalentAndSource(globalTalent, source, baseNum, talentEffectId, isFloat, conditionCb, isCeil)
end

---CalcNumByGlobalTalentAndSource
---计算对应全局天赋来源的全局天赋数值
---@param source              Constants.GlobalTalentSource 全局天赋来源
---@param base                number 基础数值
---@param talentEffectId      Constants.GlobalTalentEffectId 基础数值
---@param isFloat             boolean 要计算的值是否是浮点数
---@param conditionCb         function 用于提取数值
---@param isCeil              boolean 整数是否向上取整
---@return number 对应全局天赋来源的全局天赋数值
function GlobalTalentMgr:CalcNumByGlobalTalentAndSource(globalTalent, source, baseNum, talentEffectId, isFloat, conditionCb, isCeil)
    local globalTalentAddData  = globalTalent[talentEffectId]
    return globalTalentAddData == nil and baseNum or self:CalcFinalNumBySource(source, baseNum, globalTalentAddData, isFloat, conditionCb, isCeil)
end

---计算对应全局天赋来源的全局天赋最终数值
---@param source              Constants.GlobalTalentSource 全局天赋来源
---@param base                number 基础数值
---@param globalTalentAddData GlobalTalentAddData 全局属性加成数据
---@param isFloat             boolean 要计算的值是否是浮点数
---@param isCeil              boolean 整数是否向上取整
---@return number 对应全局天赋来源的全局天赋数值
function GlobalTalentMgr:CalcFinalNumBySource(source, base, globalTalentAddData, isFloat, conditionCb, isCeil)
    local addType2Num = globalTalentAddData:GenerateParamsBySource(source, conditionCb, isCeil)
    return self:GenerateFinalNum(base, addType2Num, isFloat, isCeil)

end

---GenerateFinalNum
---生成最终数值
---@param base                number 基础数值
---@param addType2Num         table 
---@param isFloat             boolean 要计算的值是否是浮点数
---@param isCeil              boolean 整数是否向上取整
function GlobalTalentMgr:GenerateFinalNum(base, addType2Num, isFloat, isCeil)
    local GlobalTalentAddType = Constants.GlobalTalentAddType
    local Factor      = 100000
    local baseAdd     = addType2Num[GlobalTalentAddType.BaseAdd]
    local percent     = addType2Num[GlobalTalentAddType.Percent]
    local finalAdd     = addType2Num[GlobalTalentAddType.FinalAdd]
    local finalPercent = addType2Num[GlobalTalentAddType.FinalPercent]

    local finalBasePercent = (Factor + percent * Factor) / Factor
    local finalBaseNum = (base + baseAdd) * finalBasePercent
    -- print("finalBaseNum", finalBaseNum, percent)
    local realFinalPercent = (Factor + finalPercent * Factor) / Factor
    local final        = (finalBaseNum + finalAdd) * realFinalPercent
    -- print("final", final)
    if isCeil and not isFloat then
        return math.ceil(final)
    end
    return isFloat and final or math.floor(final)
end

---RegisterTalent
---@param talentEffectId   Constants.GlobalTalentEffectId 
function GlobalTalentMgr:RegisterTalent(talentEffectId, ...)
    local globalTalent = self:GetGlobalTalent()
    ---@type GlobalTalentAddData
    local globalTalentAddData = globalTalent[talentEffectId]
    if globalTalentAddData == nil then
        globalTalentAddData = self:GenerateGlobalTalentAddData(...)
        globalTalent[talentEffectId] = globalTalentAddData
    else
        globalTalentAddData:Update(...)
    end

    if self:IsAttributeTalent(talentEffectId) then
        self._attributeTalentIdMap[talentEffectId] = true
    end

end

--- 添加加成
---@param talentEffectId any
function GlobalTalentMgr:AppendTalent(talentEffectId, ...)
    local globalTalent = self:GetGlobalTalent()
    ---@type GlobalTalentAddData
    local globalTalentAddData = globalTalent[talentEffectId]
    if globalTalentAddData == nil then
        globalTalentAddData = self:GenerateGlobalTalentAddData(...)
        globalTalent[talentEffectId] = globalTalentAddData
    else
        globalTalentAddData:Add(...)
    end

    if self:IsAttributeTalent(talentEffectId) then
        self._attributeTalentIdMap[talentEffectId] = true
    end
end

--- 删除加成
---@param talentEffectId any
function GlobalTalentMgr:RemoveTalentBySource(source, talentEffectId)
    local globalTalent = self:GetGlobalTalent()

    if talentEffectId == nil then
        for k, globalTalentAddData in pairs(globalTalent) do
            globalTalentAddData:Remove(source)
        end
    else
        ---@type GlobalTalentAddData
        local globalTalentAddData = globalTalent[talentEffectId]
        if globalTalentAddData ~= nil then
            globalTalentAddData:Remove(source)
        end
    end
end

--- 添加活动天赋加成
---@param talentEffectId any
function GlobalTalentMgr:AddActivityTalentData(talentEffectId, ...)
    local globalTalent = self:GetGlobalTalent()
    ---@type GlobalTalentAddData
    local globalTalentAddData = globalTalent[talentEffectId]
    if globalTalentAddData == nil then
        ---@type GlobalTalentAddData
        globalTalentAddData = self:CreateGlobalTalentAddData()
        globalTalent[talentEffectId] = globalTalentAddData
    end
    globalTalentAddData:AddActivityData(...)

    if self:IsAttributeTalent(talentEffectId) then
        self._attributeTalentIdMap[talentEffectId] = true
    end


end

function GlobalTalentMgr:CreateGlobalTalentAddData()
    ---@type GlobalTalentAddData
    local data = GlobalTalentAddData.New()
    return data
end

function GlobalTalentMgr:GenerateGlobalTalentAddData(...)
    ---@type GlobalTalentAddData
    local data = self:CreateGlobalTalentAddData()
    data:Fill(...)
    return data
end

function GlobalTalentMgr:CalcExtraCombatEffectBySource(source, globalTalent)
    local num = 0
    for effectId, talentAddData in pairs(globalTalent) do
        num = num + talentAddData:GetExtraCombatEffectBySource(source)
    end
    return num
end

function GlobalTalentMgr:GetGlobalTalent()
    return self._globalTalent
end

function GlobalTalentMgr:GetAttributeTalentIdMap()
    return self._attributeTalentIdMap
end

function GlobalTalentMgr:IsAttributeTalent(id)
    return id >= 10000 and id <= 19999
end

return GlobalTalentMgr