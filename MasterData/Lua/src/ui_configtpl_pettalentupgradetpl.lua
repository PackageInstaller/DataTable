local this = class("petTalentUpgradeTpl")

function this:init(config)
  self.data = config
  self.attrEnumNumAndLevel2Tpl = {}
  self.attrEnumNumAndLevel2NeedExp = {}
  self.attrEnumNum2Maxlevel = {}
  for _, tpl in pairs(self.data) do
    local attrEnumNum = tpl.attrId
    self.attrEnumNumAndLevel2Tpl[attrEnumNum] = self.attrEnumNumAndLevel2Tpl[attrEnumNum] or {}
    local level = tpl.level
    self.attrEnumNumAndLevel2Tpl[attrEnumNum][level] = tpl
    self.attrEnumNumAndLevel2NeedExp[attrEnumNum] = self.attrEnumNumAndLevel2NeedExp[attrEnumNum] or {}
    if level == 1 then
      self.attrEnumNumAndLevel2NeedExp[attrEnumNum][1] = 0
    end
    self.attrEnumNumAndLevel2NeedExp[attrEnumNum][level + 1] = self.attrEnumNumAndLevel2NeedExp[attrEnumNum][level] + tpl.nextExpVal
    if tpl.nextExpVal == 0 then
      self.attrEnumNumAndLevel2NeedExp[attrEnumNum][level + 1] = nil
    end
    self.attrEnumNum2Maxlevel[attrEnumNum] = self.attrEnumNum2Maxlevel[attrEnumNum] or level
    self.attrEnumNum2Maxlevel[attrEnumNum] = math.max(self.attrEnumNum2Maxlevel[attrEnumNum], level)
  end
end

function this:getAllTpl()
  return self.data
end

function this:getTplById(id)
  return self.data[id]
end

function this:getTplByAttrEnumNumAndLevel(attrEnumNum, level)
  return self.attrEnumNumAndLevel2Tpl[attrEnumNum][level]
end

function this:getCurLevelMaxExp(tpl)
  return tpl.nextExpVal
end

function this:getLevelMaxExp(attrEnumNum)
  local maxLevel = #self.attrEnumNumAndLevel2NeedExp[attrEnumNum]
  local lastLevel = maxLevel - 1
  return self.attrEnumNumAndLevel2NeedExp[attrEnumNum][maxLevel] - self.attrEnumNumAndLevel2NeedExp[attrEnumNum][lastLevel]
end

function this:getTargetLevelByAttrEnumNumCurLevelCurExpAddExp(attrEnumNum, curLevel, curLevelExp, addExp)
  local curWholeExp = self.attrEnumNumAndLevel2NeedExp[attrEnumNum][curLevel]
  local targetExp = curWholeExp + curLevelExp + addExp
  local needExpList = self.attrEnumNumAndLevel2NeedExp[attrEnumNum]
  local targetLevel = 0
  for level, needExp in pairs(needExpList) do
    if needExp <= targetExp then
      targetLevel = level
    end
  end
  return targetLevel
end

function this:getStartValue(tpl)
  return tpl.InterA
end

function this:getAllComprehensionMaxNeedExpList()
  if self.allComprehensionMaxNeedExpList then
    return self.allComprehensionMaxNeedExpList
  end
  local allComprehensionMaxNeedExpList = {}
  for _, tpl in pairs(self.data) do
    local attrEnumNum = tpl.attrId
    local maxNeedExpOfOneComprehension = self:getMaxNeedExpOfOneComprehension(attrEnumNum)
    allComprehensionMaxNeedExpList[attrEnumNum] = maxNeedExpOfOneComprehension
  end
  self.allComprehensionMaxNeedExpList = allComprehensionMaxNeedExpList
  return self.allComprehensionMaxNeedExpList
end

function this:getMaxNeedExpOfOneComprehension(attrEnumNum)
  local level2NeedExpOfOneComprehension = self.attrEnumNumAndLevel2NeedExp[attrEnumNum]
  return level2NeedExpOfOneComprehension[#level2NeedExpOfOneComprehension]
end

function this:getNeedExpOfTargetComprehensionTargetLevel(attrEnumNum, level)
  return self.attrEnumNumAndLevel2NeedExp[attrEnumNum][level]
end

function this:getTargetComprehensionMaxLevel(attrEnumNum)
  return self.attrEnumNum2Maxlevel[attrEnumNum]
end

return this
