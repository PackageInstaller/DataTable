--region import

--endregion

--region defines
local checkNumber = checkNumber
local checkTable  = checkTable
--endregion

---@class HomelandTalentDojo
local HomelandTalentDojo = Class('HomelandTalentDojo')


function HomelandTalentDojo:__init()
    self._talentData = nil
    self._talentId2Data = nil
end


function HomelandTalentDojo:__delete()
    self._talentData = nil
end


---Fill
---填充数据
---@param jsonData table
function HomelandTalentDojo:Fill(jsonData)
    self._talentData    = {}
    self._talentId2Data = {}
    for key, value in pairs(jsonData) do
        self:FillTalentData(checkTable(value))
    end
    return self
end

function HomelandTalentDojo:FillTalentData(data)
    table.insert(self._talentData, data)
    self._talentId2Data[checkNumber(data.talentId)] = data
end

function HomelandTalentDojo:GetTalentDataList()
    return self._talentData
end

function HomelandTalentDojo:GetTalentId2Data()
    return self._talentId2Data
end

function HomelandTalentDojo:UpdateTalentData(talentId, level)
    local talentData = self:GetTalentData(talentId)
    if talentData == nil then
        talentData = {talentId = talentId, level = level}
        self:FillTalentData(talentData)
    else
        talentData.level = talentData.level + 1
    end
    return talentData
end

function HomelandTalentDojo:GetTalentData(talentId)
    return self._talentId2Data[checkNumber(talentId)]
end

function HomelandTalentDojo:ResetTalentData(talentIds)
    for i, id in ipairs(talentIds) do
        self._talentId2Data[checkNumber(id)] = nil
        local index = -1
        for j, td in ipairs(self._talentData) do
            if td.talentId == id then
                index = j
                break
            end
        end
        if index ~= -1 then
            table.remove(self._talentData, index)
        end
    end
end

return HomelandTalentDojo
