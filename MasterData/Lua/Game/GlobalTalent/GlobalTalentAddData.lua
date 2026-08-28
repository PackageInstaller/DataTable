--region import

--endregion

--region defines

local GlobalTalentAddType = Constants.GlobalTalentAddType
--endregion

---@class GlobalTalentAddData
local GlobalTalentAddData = Class('GlobalTalentAddData')


function GlobalTalentAddData:__init()
    -- --- 全局天赋来源
    -- ---@type Constants.GlobalTalentSource
    -- self.source = 0

    -- --- 全局天赋加成类型
    -- ---@type Constants.GlobalTalentAddType
    -- self.addType = 0

    -- --- 全局天赋加成数值
    -- self.num = 0

    self._source2NumericList = {}
    self._addType2Num = {
        [GlobalTalentAddType.BaseAdd] = 0,
        [GlobalTalentAddType.Percent] = 0,
        [GlobalTalentAddType.FinalAdd] = 0,
        [GlobalTalentAddType.FinalPercent] = 0,
    }
end


function GlobalTalentAddData:__delete()

end

---Fill
---@param source  Constants.GlobalTalentSource     全局天赋来源
---@param addType Constants.GlobalTalentAddType    全局天赋加成类型
---@param num     number                           全局天赋加成数值
---@param talentInfo table                         全局天赋信息  
---@param vo         HomelandTalentUpLvVo          需要传入与 HomelandTalentUpLvVo 类似的数据
function GlobalTalentAddData:Fill(source, addType, num, talentInfo, vo)
    self._source2NumericList[source] = self._source2NumericList[source] or {}
    talentInfo.level = talentInfo.level == 0 and 1 or talentInfo.level
    table.insert(self._source2NumericList[source], {
        addType    = addType,
        num        = num,
        talentInfo = talentInfo,
        vo         = vo,
        combat     = (vo ~= nil and vo.combat or 0),
    })

end


function GlobalTalentAddData:Update(source, addType, num, talentInfo, vo)
    talentInfo.level = talentInfo.level == 0 and 1 or talentInfo.level
    local numericList = self._source2NumericList[source]
    if numericList == nil then
        self:Fill(source, addType, num, talentInfo, vo)
    else
        local numericList = self._source2NumericList[source]
        local isUpdate = false
        ---这里全走替换逻辑 具体生效逻辑根据外部传入的条件来判断
        for index, value in ipairs(numericList) do
            local valTalentInfo = value.talentInfo
            --- 加成类型相同如果是属性天赋 则尝试合并
            if value.addType == addType then
                --- 不同天赋id合并的条件 解锁的时候正好是最大等级
                local isSame = valTalentInfo.talentId == talentInfo.talentId
                -- print("talentData replace", valTalentInfo.talentId,talentInfo.talentId, valTalentInfo.level, talentInfo.level)
                if isSame and valTalentInfo.level < talentInfo.level then
                    value.num = num
                    value.talentInfo = talentInfo
                    value.vo = vo
                    value.combat = vo.combat
                    isUpdate = true
                    break
                elseif not isSame and talentInfo.isUnlock and valTalentInfo.isAttributeTalent and valTalentInfo.isMaxLv and talentInfo.isMaxLv then
                    --- 合并后 talentInfo.talentId 会变化 不能作为条件判断
                    value.num = num + value.num
                    value.talentInfo = talentInfo
                    value.vo = vo
                    value.combat = value.combat + (vo.combat or 0)
                    isUpdate = true
                    break
                end
            end
        end
        if not isUpdate then
            self:Fill(source, addType, num, talentInfo, vo)
        end
    end
    
end

function GlobalTalentAddData:Add(source, addType, num, talentInfo, vo)
    local numericList = self._source2NumericList[source]
    if numericList == nil then
        self:Fill(source, addType, num, talentInfo, vo)
    else
        local numericList = self._source2NumericList[source]
        local isUpdate = false
        for index, value in ipairs(numericList) do
            if value.addType == addType and value.vo.param1 == vo.param1 then
                local stackType = checkNumber(value.vo.stackType)
                if stackType == 1 then
                    -- 叠加
                    value.num = value.num + num
                    value.talentInfo = talentInfo
                    value.vo = vo
                    isUpdate = true
                    break
                elseif stackType == 2 then
                    -- 覆盖
                    value.num = num
                    value.talentInfo = talentInfo
                    value.vo = vo
                    isUpdate = true
                    break
                else
                    -- 独立
                end
            end
        end
        if not isUpdate then
            self:Fill(source, addType, num, talentInfo, vo)
        end
    end
end

function GlobalTalentAddData:AddActivityData(source, addType, num, talentInfo, endTime)
    --- 对应活动类型直接替换
    self._source2NumericList[source] = self._source2NumericList[source] or {}
    local isUpdate = false
    if next(self._source2NumericList[source]) ~= nil then
        local numericList = self._source2NumericList[source]
        for index, numeric in ipairs(numericList) do
            if numeric.addType == addType and numeric.talentInfo.talentId == talentInfo.talentId then
                numeric.addType    = addType
                numeric.num        = num
                numeric.talentInfo = talentInfo
                numeric.endTime    = endTime
                isUpdate = true
                break
            end
        end
    end
    if not isUpdate then
        table.insert(self._source2NumericList[source], {
            addType    = addType,
            num        = num,
            talentInfo = talentInfo,
            endTime    = endTime,
        })
    end

end

--- 移除一种来源的加成
---@param source any
function GlobalTalentAddData:Remove(source)
    self._source2NumericList[source] = nil
end

---ResetAddType2Num
---重置 加成类型对应的数值
function GlobalTalentAddData:ResetAddType2Num()
    self._addType2Num[GlobalTalentAddType.BaseAdd]      = 0
    self._addType2Num[GlobalTalentAddType.Percent]      = 0
    self._addType2Num[GlobalTalentAddType.FinalAdd]     = 0
    self._addType2Num[GlobalTalentAddType.FinalPercent] = 0
end

function GlobalTalentAddData:GenerateParams(conditionCb)
    self:ResetAddType2Num()
    local curTime = os.time()
    for source, numericList in pairs(self._source2NumericList) do
        self:FillAddType2Num(numericList, conditionCb, curTime)
    end

    return self._addType2Num

end

function GlobalTalentAddData:GenerateParamsBySource(source, conditionCb)
    self:ResetAddType2Num()
    local numericList = self._source2NumericList[source]
    local curTime = os.time()
    self:FillAddType2Num(numericList, conditionCb, curTime)

    return self._addType2Num
end

function GlobalTalentAddData:FillAddType2Num(numericList, conditionCb, curTime)
    if numericList == nil then return end
    for index, numeric in ipairs(numericList) do
        if self:CheckEndTime(numeric, curTime) and conditionCb and conditionCb(numeric) then
            local addType = numeric.addType
            self._addType2Num[addType] = self._addType2Num[addType] + numeric.num
        end
    end
end

function GlobalTalentAddData:CheckEndTime(numeric, curTime)
    local endTime = numeric.endTime
    if endTime == nil then return true end
    return curTime < endTime
end

---GetExtraCombatEffectBySource
---通过数据源获取附加战力
---@param source Constants.GlobalTalentSource
function GlobalTalentAddData:GetExtraCombatEffectBySource(source)
    local numericList = self._source2NumericList[source]
    if numericList == nil then return 0 end
    
    local num = 0
    for index, numeric in ipairs(numericList) do
        num = num + numeric.combat
    end

    return num
end

return GlobalTalentAddData
