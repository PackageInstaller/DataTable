local CheckerActivityTechBranchLevel = {}
local ActivityFrameEnum = require("Game.ActivityFrame.ActivityFrameEnum")

function CheckerActivityTechBranchLevel.LengthCheck(param)
  return 2 <= #param
end

function CheckerActivityTechBranchLevel.ParamsCheck(param)
  local branchId = param[2]
  local level = param[3]
  local techType = ConfigData.activity_tech_branch.branchToTypeMapping[branchId]
  if techType == nil then
    return false
  end
  local actFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  local treeData = actFrameCtrl:GetActivityTech(techType)
  if treeData ~= nil then
    return level <= treeData:GetTechBranchLevel(branchId)
  end
  local actTable = ConfigData.activity_tech_branch.techTypeToActMapping[techType]
  if actTable == nil then
    return false
  end
  if actTable.actCat == ActivityFrameEnum.eActivityType.Carnival then
    local carnivalCtrl = ControllerManager:GetController(ControllerTypeId.ActivityCarnival)
    if carnivalCtrl == nil then
      return false
    end
    local carnivalData = carnivalCtrl:GetCarnivalAct(actTable.actId)
    if carnivalData == nil then
      return false
    end
    return level <= carnivalData:GetCarnivalTechBranchLevel(branchId)
  end
  return false
end

function CheckerActivityTechBranchLevel.GetUnlockInfo(param)
  local branchId = param[2]
  local level = param[3]
  local techType = ConfigData.activity_tech_branch.branchToTypeMapping[branchId]
  if techType == nil then
    return ""
  end
  local branchCfg = ConfigData.activity_tech_branch[techType][branchId]
  if branchCfg == nil then
    return ""
  end
  return string.format(ConfigData:GetTipContent(7112), LanguageUtil.GetLocaleText(branchCfg.branch_name), level)
end

return CheckerActivityTechBranchLevel
