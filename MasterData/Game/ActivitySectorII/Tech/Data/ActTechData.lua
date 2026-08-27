local ActTechData = class("ActTechData")
local CommonLogicUtil = require("Game.Common.CommonLogicUtil.CommonLogicUtil")

function ActTechData.CreatAWTechData(techId, actType, actId)
  local data = ActTechData.New()
  data.techId = techId
  data.actType = actType
  data.actId = actId
  local cfg = ConfigData.activity_tech[techId]
  if cfg == nil then
    error("can't get activity_tech cfg with techId:" .. tostring(techId))
    return
  end
  data.techCfg = cfg
  data.techLevelCfg = ConfigData.activity_tech_level[techId]
  data.rowIndex = cfg.row
  data.colIndex = cfg.col
  data.previousTech = cfg.pre_tech
  data.maxLevel = #data.techLevelCfg
  return data
end

function ActTechData:ctor()
  self.actType = nil
  self.actId = nil
  self.techId = nil
  self.rowIndex = nil
  self.colIndex = nil
  self.techCfg = nil
  self.techLevelCfg = nil
  self.level = nil
  self.maxLevel = nil
  self.previousTech = nil
  self.previousTechData = nil
end

function ActTechData:UpdateWATechByMsg(activityTechElem)
  self.level = activityTechElem.level
end

function ActTechData:GetIsTechUnlocked()
  return self:GetCurLevel() > 0
end

function ActTechData:GetTechLogic(level)
  local levelCfg = self.techLevelCfg[level]
  if levelCfg == nil then
    error(string.format("can't get tech(id:%s) level cfg with level:%s", self.techId, level))
    return nil
  end
  local logicArray = levelCfg.logic
  local para1Array = levelCfg.para1
  local para2Array = levelCfg.para2
  local para3Array = levelCfg.para3
  return logicArray, para1Array, para2Array, para3Array
end

function ActTechData:GetTechDescription(level, moduleType)
  if level == nil then
    level = self:GetCurLevel() == 0 and 1 or self.level
  end
  local logicArray, para1Array, para2Array, para3Array = self:GetTechLogic(level)
  local desStr = CommonLogicUtil.GetLogicDesStrMultiLine(logicArray, para1Array, para2Array, para3Array, moduleType)
  return desStr
end

function ActTechData:GetTechDescriptionFirst(level, moduleType)
  if level == nil then
    level = self:GetCurLevel() == 0 and 1 or self.level
  end
  local logicArray, para1Array, para2Array, para3Array = self:GetTechLogic(level)
  if #logicArray <= 0 then
    return
  end
  local logic, para1, para2, para3 = logicArray[1], para1Array[1], para2Array[1], para3Array[1]
  local longDes, shortDes, valueDes = CommonLogicUtil.GetDesString(logic, para1, para2, para3, moduleType)
  return longDes, shortDes, valueDes
end

function ActTechData:GetUnlockPreTechCondition()
  return self.techCfg.pre_tech_level
end

function ActTechData:GetLevelCost(targetLevel)
  local targetLevelCfg = self.techLevelCfg[targetLevel]
  return targetLevelCfg.cost
end

function ActTechData:GetUnlockCfg()
  local levelCfg = self.techLevelCfg[1]
  return levelCfg
end

function ActTechData:GetIsUnlock()
  local preTechData = self:GetPreTechData()
  if preTechData ~= nil and preTechData:GetCurLevel() < self:GetUnlockPreTechCondition() then
    return false
  end
  if self._extraUnlockFunc ~= nil and not self._extraUnlockFunc(self) then
    return false
  end
  local levelCfg = self.techLevelCfg[1]
  local isUnlock = CheckCondition.CheckLua(levelCfg.pre_condition, levelCfg.pre_para1, levelCfg.pre_para2)
  return isUnlock
end

function ActTechData:IsCouldLevelUp()
  local targetLevel = self:GetCurLevel() + 1
  local preTechData = self:GetPreTechData()
  if preTechData ~= nil and preTechData:GetCurLevel() < self:GetUnlockPreTechCondition() then
    return false, string.format(ConfigData:GetTipContent(7105), self:GetUnlockPreTechCondition(), preTechData:GetAWTechName())
  end
  if self._extraUnlockFunc ~= nil and not self._extraUnlockFunc(self) then
    return false
  end
  local levelCfg = self.techLevelCfg[targetLevel]
  if levelCfg == nil then
    return false
  end
  local isUnlock = CheckCondition.CheckLua(levelCfg.pre_condition, levelCfg.pre_para1, levelCfg.pre_para2)
  if not isUnlock then
    return false, CheckCondition.GetUnlockInfoLua(levelCfg.pre_condition, levelCfg.pre_para1, levelCfg.pre_para2)
  end
  local costDic = self:GetLevelCost(targetLevel)
  for costItemId, costNum in pairs(costDic) do
    local backPackNum = PlayerDataCenter:GetItemCount(costItemId)
    if costNum > backPackNum then
      local itemCfg = ConfigData.item[costItemId]
      local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
      return false, string.format(ConfigData:GetTipContent(7110), itemName, itemName)
    end
  end
  return true
end

function ActTechData:IsLeveUpResEnough()
  local targetLevel = self:GetCurLevel() + 1
  local levelCfg = self.techLevelCfg[targetLevel]
  if levelCfg == nil then
    return false, nil
  end
  local costDic = self:GetLevelCost(targetLevel)
  for costItemId, costNum in pairs(costDic) do
    local backPackNum = PlayerDataCenter:GetItemCount(costItemId)
    if costNum > backPackNum then
      local itemCfg = ConfigData.item[costItemId]
      local itemName = LanguageUtil.GetLocaleText(itemCfg.name)
      return false, costItemId
    end
  end
  return true, nil
end

function ActTechData:GetAWTechName()
  return LanguageUtil.GetLocaleText(self.techCfg.name)
end

function ActTechData:GetAWTechUnlockParam(level)
  local levelCfg = self.techLevelCfg[level]
  return levelCfg.pre_condition, levelCfg.pre_para1, levelCfg.pre_para2
end

function ActTechData:GetAWTechUnlockInfo(level)
  local levelCfg = self.techLevelCfg[level]
  local preConditionList = CheckCondition.GetUnlockAndInfoList(levelCfg.pre_condition, levelCfg.pre_para1, levelCfg.pre_para2)
  return preConditionList
end

function ActTechData:GetTechCol()
  return self.colIndex
end

function ActTechData:GetTechId()
  return self.techId
end

function ActTechData:GetPreTechId()
  if self.previousTech == 0 then
    return nil
  end
  return self.previousTech
end

function ActTechData:SetPreTechData(techData)
  self.previousTechData = techData
end

function ActTechData:GetPreTechData()
  return self.previousTechData
end

function ActTechData:SetRearTechData(techData)
  self._rearTechData = techData
end

function ActTechData:GetRearTechData()
  return self._rearTechData
end

function ActTechData:GetWATechIcon()
  return self.techCfg.icon
end

function ActTechData:GetCurLevel()
  return self.level or 0
end

function ActTechData:GetMaxLevel()
  return self.maxLevel
end

function ActTechData:IsActTechLevelLoop()
  return self.techCfg.refresh_type == proto_csmsg_TechRefreshType.Loop
end

function ActTechData:IsActTechSpecial()
  return self.techCfg.refresh_type == proto_csmsg_TechRefreshType.Every
end

function ActTechData:IsMaxLvel()
  return self:GetMaxLevel() <= self:GetCurLevel()
end

function ActTechData:GetTechActId()
  return self.actId
end

function ActTechData:GetActFrameId()
  local activityFrameCtrl = ControllerManager:GetController(ControllerTypeId.ActivityFrame)
  return activityFrameCtrl:GetIdByActTypeAndActId(self.actType, self.actId)
end

function ActTechData:IsActTechAutoUnlock()
  local levelCfg = self.techLevelCfg[1]
  return levelCfg.auto_unlock
end

function ActTechData:GetActTechCfg()
  return self.techCfg
end

function ActTechData:GetActTechPrfeTotleLevel()
  return self.techCfg.pre_total_level
end

function ActTechData:GetActTechBranch()
  return self.techCfg.branch
end

function ActTechData:GetActTechRowCol()
  local lineCfg = ConfigData.activity_tech_line[self.techCfg.row]
  if lineCfg == nil then
    error("cant get activity_tech_line,id = " .. tostring(self.techCfg.row))
    return 1, 1
  end
  return lineCfg.num, self.techCfg.col
end

function ActTechData:GetActTechUIFrameId()
  return self.techCfg.frame
end

function ActTechData:GetActTechBranchCfg()
  local branchId = self:GetActTechBranch()
  local branchType = ConfigData.activity_tech_branch.branchToTypeMapping[branchId]
  local branchCfg = ConfigData.activity_tech_branch[branchType][branchId]
  return branchCfg
end

function ActTechData:SetActTechExtraUnlockConfitionFunc(func)
  self._extraUnlockFunc = func
end

function ActTechData:GetTechIconColor()
  local branchCfg = self:GetActTechBranchCfg()
  if branchCfg ~= nil and not string.IsNullOrEmpty(branchCfg.icon_color) then
    local color = Color.Temp(table.unpack(branchCfg.icon_color)) / 255
    return color
  end
  return Color.white
end

function ActTechData:GetTechBgIndex()
  local techCfg = self.techCfg
  if techCfg ~= nil then
    return techCfg.icon_base
  end
  return 1
end

return ActTechData
