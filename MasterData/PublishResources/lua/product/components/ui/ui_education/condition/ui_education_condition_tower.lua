require("ui_education_condition")
_class("UIEducationConditionTower", UIEducationCondition)
UIEducationConditionTower = UIEducationConditionTower

function UIEducationConditionTower:Constructor(towerType, towerLevel)
  self._type = ConditionType.CT_TowerType
  self._quantity = ElementType.ElementType_Yellow
  self._towerType = towerType
  self._towerLevel = towerLevel
  if self._towerType == ElementType.ElementType_None then
    self._quantity = ElementType.ElementType_Yellow
  else
    self._quantity = towerLevel
  end
end

function UIEducationConditionTower:GetTowerType()
  return self._towerType
end

function UIEducationConditionTower:GetTowerLevel()
  return self._towerLevel
end

function UIEducationConditionTower:Test()
  self._completed = 0
  local towerModule = GameGlobal.GetModule(TowerModule)
  if self._towerType == ElementType.ElementType_None then
    for i = ElementType.ElementType_Blue, self._quantity do
      local level = towerModule:GetTowerLayer(i)
      if level >= self._towerLevel then
        self._completed = self._completed + 1
      end
    end
  elseif self._towerType == ElementType.ElementType_Any then
    for i = ElementType.ElementType_Blue, ElementType.ElementType_Yellow do
      local level = towerModule:GetTowerLayer(i)
      self._completed = math.max(self._completed, level)
    end
  else
    self._completed = towerModule:GetTowerLayer(self._towerType)
  end
  self._completed = math.min(self._completed, self._quantity)
end
