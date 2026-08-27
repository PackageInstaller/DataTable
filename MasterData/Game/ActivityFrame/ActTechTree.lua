local ActTechTree = class("ActTechTree")
local ActTechData = require("Game.ActivitySectorII.Tech.Data.ActTechData")

function ActTechTree:InitTechTree(treeId, activityBase)
  self._treeId = treeId
  self._actFrameId = activityBase:GetActFrameId()
  self._techDataDic = {}
  self._techRowDic = {}
  local actType = activityBase:GetActivityFrameCat()
  local actId = activityBase:GetActId()
  local techTypeListCfg = ConfigData.activity_tech.actTechTypeList[self._treeId]
  if techTypeListCfg == nil then
    error("activity tech type is NIL,type is " .. tostring(self._treeId))
    return
  end
  self._allTechLvDirty = true
  local IsTechAllLevelTargetCallback = BindCallback(self, self.__IsTechAllLevelTarget)
  for _, techId in ipairs(techTypeListCfg.techIds) do
    local techCfg = ConfigData.activity_tech[techId]
    local branchDic = self._techDataDic[techCfg.branch]
    if branchDic == nil then
      branchDic = {}
      self._techDataDic[techCfg.branch] = branchDic
    end
    local tech = ActTechData.CreatAWTechData(techId, actType, actId)
    tech:SetActTechExtraUnlockConfitionFunc(IsTechAllLevelTargetCallback)
    branchDic[techId] = tech
    if not tech:IsActTechAutoUnlock() then
      local rowId = techCfg.row
      self._techRowDic[rowId] = true
    end
  end
  for branchId, branchDic in pairs(self._techDataDic) do
    for techId, techData in pairs(branchDic) do
      local previousTechId = techData:GetPreTechId()
      if previousTechId ~= nil then
        local previousTech = self._techDataDic[branchId][previousTechId]
        techData:SetPreTechData(previousTech)
        previousTech:SetRearTechData(techData)
      end
    end
  end
  self._techTypeCfg = ConfigData.activity_tech_type[self._treeId]
end

function ActTechTree:UpdateActTechTree(msg)
  for techId, singleMsg in pairs(msg.techData) do
    local techCfg = ConfigData.activity_tech[techId]
    local techData = self._techDataDic[techCfg.branch][techId]
    techData:UpdateWATechByMsg(singleMsg)
  end
  self._allTechLvDirty = true
end

function ActTechTree:BindActTechUpdateFunc(func)
  self._techUpdateFunc = func
end

function ActTechTree:BindActTechAllResetFunc(func)
  self._techAllResetFunc = func
end

function ActTechTree:__ResetActTechTree()
  local levelMsg = {level = 0}
  for _, branchDic in pairs(self._techDataDic) do
    for _, techData in pairs(branchDic) do
      techData:UpdateWATechByMsg(levelMsg)
    end
  end
end

function ActTechTree:__IsTechAllLevelTarget(techData)
  local prelevel = techData:GetActTechPrfeTotleLevel()
  return prelevel <= self:GetTechBranchLevel(0)
end

function ActTechTree:ReqTechUp(techId, callback)
  local techData = self:GetTechByTechId(techId)
  if techData == nil then
    error("tech is NIL , id:" .. tostring(techId))
    return
  end
  local flag, noEnoughItemId = techData:IsLeveUpResEnough()
  if not flag then
    return
  end
  if not techData:IsCouldLevelUp() then
    return
  end
  local activityFrameNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNetwork:CS_ActivityTech_Upgrade(self._actFrameId, techData:GetTechId(), function(args)
    if args.Count == 0 then
      error("args.Count == 0")
      return
    end
    local upgradedTechElement = args[0]
    for i, elemt in ipairs(upgradedTechElement) do
      local techDataElemt = self:GetTechByTechId(elemt.id)
      if techDataElemt ~= nil then
        techDataElemt:UpdateWATechByMsg(elemt)
      end
    end
    if self._techUpdateFunc ~= nil then
      self._techUpdateFunc()
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function ActTechTree:ReqTechAllReset(callback)
  local flag, resetCost = self:GetTreeResetCost()
  if not flag then
    return
  end
  for k, v in pairs(resetCost) do
    if v > PlayerDataCenter:GetItemCount(k) then
      return
    end
  end
  if self:GetTechBranchLevel(0) <= 0 then
    return
  end
  local activityFrameNetwork = NetworkManager:GetNetwork(NetworkTypeID.ActivityFrame)
  activityFrameNetwork:CS_ActivityTech_ResetAll(self._actFrameId, function(args)
    self:__ResetActTechTree()
    if self._techAllResetFunc ~= nil then
      self._techAllResetFunc()
    end
    if callback ~= nil then
      callback()
    end
  end)
end

function ActTechTree:IsExsitCouldLvUpTechInBranch(branchId)
  local branchDic = self._techDataDic[branchId]
  if branchDic == nil then
    return false
  end
  for k, techData in pairs(branchDic) do
    if techData:IsCouldLevelUp() then
      return true
    end
  end
  return false
end

function ActTechTree:IsExsitCouldLvUpTechInTree()
  for k, v in pairs(self._techDataDic) do
    if self:IsExsitCouldLvUpTechInBranch(k) then
      return true
    end
  end
  return false
end

function ActTechTree:GetTreeId()
  return self._treeId
end

function ActTechTree:GetTechDataDic()
  return self._techDataDic
end

function ActTechTree:GetTechTypeCostDic()
  return ConfigData.activity_tech.techTypeCostIdDic[self._treeId]
end

function ActTechTree:GetTechRow(rowIndex)
  local rowCfg = ConfigData.activity_tech_line[rowIndex]
  if rowCfg == nil then
    return 0
  end
  return rowCfg.num
end

function ActTechTree:GetTechBranchLevel(branchId)
  if (branchId or 0) == 0 then
    if self._allTechLvDirty then
      local level = 0
      local maxLevel = 0
      local techDic = self:GetTechDataDic()
      for k, branchDic in pairs(techDic) do
        for k, tech in pairs(branchDic) do
          level = level + tech:GetCurLevel()
          maxLevel = maxLevel + tech:GetMaxLevel()
        end
      end
      self._techAllLevel = level
      self._techAllLevelMax = maxLevel
    end
    return self._techAllLevel, self._techAllLevelMax
  end
  local level = 0
  local maxLevel = 0
  local branchTechDic = self._techDataDic[branchId]
  if branchTechDic == nil then
    return 0, 0
  end
  for k, tech in pairs(branchTechDic) do
    level = level + tech:GetCurLevel()
    maxLevel = maxLevel + tech:GetMaxLevel()
  end
  return level, maxLevel
end

function ActTechTree:GetTreeResetReturnItemId()
  if self._techTypeCfg == nil then
    return false, nil
  end
  return true, self._techTypeCfg.activity_tech_item
end

function ActTechTree:GetTreeResetCost()
  if self._techTypeCfg == nil then
    return false, nil
  end
  return true, self._techTypeCfg.return_tech_item
end

function ActTechTree:GetTechByTechId(techId)
  local tempTechCfg = ConfigData.activity_tech[techId]
  if tempTechCfg == nil then
    return nil
  end
  local techBranch = self._techDataDic[tempTechCfg.branch]
  if techBranch == nil then
    return nil
  end
  return techBranch[techId]
end

function ActTechTree:GetTechActFrameId()
  return self._actFrameId
end

return ActTechTree
