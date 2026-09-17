local module = class("moduleAreaLevelExpInfo", G_UIModuleBase)
local _areaLeveTpl = L_GameTpl:getKiboDuelAreaLevelTpl()

function module:ctor(...)
  module.super.ctor(self, ...)
  self.curExp = 0
  self.maxExp = 1
  self.isMax = false
  self.hexColor = nil
end

function module.bind()
  return {
    txtExpValue = "",
    sldExp = 0,
    maxObj = false,
    fillObj = true
  }
end

function module:open()
  self:refreshInfo()
end

function module:refreshInfo()
  if self.bind.maxObj ~= nil then
    self.bind.maxObj = self.isMax
  end
  if self.bind.fillObj ~= nil then
    self.bind.fillObj = not self.isMax
  end
  if self.isMax then
    self.bind.txtExpValue = "Max"
    self.bind.sldExp = 1
    return
  end
  if self.hexColor then
    self.bind.txtExpValue = string.format("<color=%s>%d</color>/%d", self.hexColor, self.curExp, self.maxExp)
  else
    self.bind.txtExpValue = string.format("%d/%d", self.curExp, self.maxExp)
  end
  self.bind.sldExp = self.curExp / self.maxExp
end

function module:setExpData(curExp, maxExp, isMax)
  self.curExp = curExp
  self.maxExp = maxExp
  self.isMax = isMax
  self:refreshInfo()
end

function module:setAreaLevelData(areaType, level, hexColor)
  local areaInfo = L_PetDuelStore:getAreaInfo(areaType)
  if not areaInfo then
    return
  end
  local maxLevel = _areaLeveTpl:getMaxLevel(areaType)
  local isMaxLevel = level >= maxLevel
  local curExp = areaInfo:getExp()
  local preLevel = math.max(level - 1, 1)
  local tpl = _areaLeveTpl:getTpl(areaType, preLevel)
  local maxExp = _areaLeveTpl:getExp(tpl)
  self.hexColor = hexColor
  self:setExpData(curExp, maxExp, isMaxLevel)
end

return module
