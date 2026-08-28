---
--- Created by Eric.
--- DateTime: 2022/10/8 14:21
---

------------ import ------------
local ECSComponent = import("Frame.ECS.ECSComponent")

------------ import ------------

------------ define ------------

------------ define ------------


---@class AdvancedTrainingComponent
local AdvancedTrainingComponent = Class("AdvancedTrainingComponent", ECSComponent)
function AdvancedTrainingComponent:__init()
    self.seniorDungeonInfo = {}--key 关卡类型 value (int) 当前通关最高难度Id

    self.name = "AdvancedTrainingComponent"
end

function AdvancedTrainingComponent:__delete()
    self.seniorDungeonInfo = nil

    self.name = nil
end

function AdvancedTrainingComponent:InitHomeData(data)
    self.seniorDungeonInfo = checkTable(data.seniorDungeonQuestInfo)

end

function AdvancedTrainingComponent:GetQuestIdsByType(type)
    return string.split(CfUtils.GetIdGroupData(AutoIds.IdSetting2745, checkString(type), "ids")[1], ";")
end

function AdvancedTrainingComponent:IsAllPassByType(type)
    local isAllPass = false
    local passedId = self.seniorDungeonInfo[checkString(type)]
    if checkNumber(passedId) ~= 0 then
        local passedVo = QuestConfMgr:GetInstance():GetQuestVoById(passedId)
        if checkNumber(passedVo.isEnd) == 1 then
            isAllPass = true
        end
    end
    return isAllPass
end


function AdvancedTrainingComponent:IsPassLevelById(levelId)
    local isPass = false
    if checkNumber(levelId) == 0 then
        return true
    end
    local vo = QuestConfMgr:GetInstance():GetQuestVoById(levelId)
    local passedId = self.seniorDungeonInfo[checkString(vo.type)]
    if checkNumber(passedId) ~= 0 then
        local passedVo = QuestConfMgr:GetInstance():GetQuestVoById(passedId)
        if checkNumber(passedVo.regionLevel) >= checkNumber(vo.regionLevel) then
            isPass = true
        end
    end
    return isPass
end

function AdvancedTrainingComponent:GetMaxPassLevelByType(type)
    local level = 0
    local passedId = self.seniorDungeonInfo[checkString(type)]
    if checkNumber(passedId) ~= 0 then
        local passedVo = QuestConfMgr:GetInstance():GetQuestVoById(passedId)
        level = passedVo.regionLevel
    end
    return level
end

return AdvancedTrainingComponent