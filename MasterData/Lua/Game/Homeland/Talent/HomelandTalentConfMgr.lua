---@class HomelandTalentConfMgr
local HomelandTalentConfMgr = {}

---GetDisplayLabels
---获取天赋标签数据
function HomelandTalentConfMgr:GetDisplayLabels()
    if self._displayLabels then
        return self._displayLabels
    end
    local displayLabels = {}
    ---@type HomelandTalentVo[]
    local vos = self:GetAllHomelandTalentVo()
    local floor = 0
    for index, vo in ipairs(vos) do
        local labelType = vo.type
        displayLabels[labelType] = displayLabels[labelType] or {}

        local voFloor =  vo.floor
        if floor ~= voFloor then
            floor = voFloor
        end
        displayLabels[labelType][voFloor] = displayLabels[labelType][voFloor] or {}
        displayLabels[labelType][voFloor][vo.location] = vo

    end
    self._displayLabels = displayLabels

    return displayLabels
end

--- 获取指定天赋标签下面所有天赋的id
---@param label any
function HomelandTalentConfMgr:GetTalentIdsByDisplayLabel(label)
    local displayLabels = self:GetDisplayLabels()
    local floors = displayLabels[label]

    local talentIds = {}
    for index, locations in ipairs(floors) do
        for i, vo in ipairs(locations) do
            table.insert(talentIds, vo.talentId)
        end
    end

    return talentIds
end

--region vo

---GetAllHomelandTalentLabelVo
---获取所有 战略强化切页表 数据
---@return HomelandTalentVo[]
function HomelandTalentConfMgr:GetAllHomelandTalentLabelVo()
    return CfUtils.GetCf(AutoIds.IdSetting5053, "HomelandTalentLabelVo", true)
end

--- 获取切页表 数据
---@param label integer
---@return HomelandTalentLabelVo
function HomelandTalentConfMgr:GetHomelandTalentLabelVo(label)
    return CfUtils.GetCfVo(AutoIds.IdSetting5053, "HomelandTalentLabelVo", label)
end

---GetAllHomelandTalentVo
---获取所有 战略强化总表 数据
---@return HomelandTalentVo[]
function HomelandTalentConfMgr:GetAllHomelandTalentVo()
    return CfUtils.GetCf(AutoIds.IdSetting5052, "HomelandTalentVo", true)
end

---GetAllHomelandTalentVo
---获取 战略强化总表 数据
---@return HomelandTalentVo
function HomelandTalentConfMgr:GetHomelandTalentVoById(refId)
    return CfUtils.GetCfVo(AutoIds.IdSetting5052, "HomelandTalentVo", refId)
end

---GetHomelandTalentEnumVo
---通关表id 获取 战略强化属性枚举表 数据
---@param refId number 
---@return HomelandTalentEnumVo
function HomelandTalentConfMgr:GetHomelandTalentEnumVo(refId)
    return CfUtils.GetCfVo(AutoIds.IdSetting5051, "HomelandTalentEnumVo", refId)
end

---GetHomelandTalentUpLvVo
---通关表id 获取 战略强化升级表 数据
---@param refId number 战略强化总表 主键
---@param level number 战略强化升级表 对应的等级
---@return HomelandTalentUpLvVo
function HomelandTalentConfMgr:GetHomelandTalentUpLvVo(refId, level)
    local ids = self:GetHomelandTalentUpLvVoIds(refId)
    local id  = ids[level]
    return CfUtils.GetCfVo(AutoIds.IdSetting5050, "HomelandTalentUpLvVo", id), #ids
end

---GetHomelandTalentUpLvVo
---通过 战略强化升级表 主键 获取 战略强化升级表 数据
---@param refId number 战略强化升级表 主键
---@return HomelandTalentUpLvVo
function HomelandTalentConfMgr:GetHomelandTalentUpLvVoByRefId(refId)
    return CfUtils.GetCfVo(AutoIds.IdSetting5050, "HomelandTalentUpLvVo", refId)
end

---GetHomelandTalentUpLvVoIds
---通关表id 获取 战略强化升级表对应天赋的所有id 数据
---@param refId number
---@return HomelandTalentUpLvVo
function HomelandTalentConfMgr:GetHomelandTalentUpLvVoIds(refId)
    local ids = CardConfMgr.GetIdGroupRowData(AutoIds.IdSetting5050, refId, "ids", false, ",")
    return ids
end

--- 提取天赋表里所有的buff
function HomelandTalentConfMgr:GetHomelandTalentBuffMap()
    local buffMap = {}
    local allVo = CfUtils.GetCf(AutoIds.IdSetting5050, "HomelandTalentUpLvVo", true)
    for i, vo in ipairs(allVo) do
        if vo.status > 0 then
            local buffId = vo.buffId
            buffId = string.trim(buffId)
            if not string.isEmpty(buffId) then
                -- local arr = string.split(buffId, '_')
                -- local buffId = checkNumber(arr[1])
                buffMap[buffId] = {
                    type = vo.attAddTypeId,
                    talentId = vo.talentId,
                    addNum = vo.attAddNum,
                }
            end
        end
    end
    return buffMap
end

--endregion


return HomelandTalentConfMgr