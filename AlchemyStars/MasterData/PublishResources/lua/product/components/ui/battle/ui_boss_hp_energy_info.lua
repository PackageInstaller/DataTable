_class("UIBossHPEnergyInfo", UICustomWidget)
UIBossHPEnergyInfo = UIBossHPEnergyInfo

function UIBossHPEnergyInfo:OnShow()
  self.selectObjPath = self:GetUIComponent("UISelectObjectPath", "UIBossHPEnergyInfo")
  self:AttachEvent(GameEventType.UpdateHPEnergy, self.UpdateBossHPEnergy)
end

function UIBossHPEnergyInfo:SetData(entityID, current, max)
  self._entityID = entityID
  self._max = max or 0
  self._current = max or 0
  if self._max == 0 then
    self:GetGameObject():SetActive(false)
    return
  end
  self:GetGameObject():SetActive(true)
  self.selectObjPath:SpawnObjects("UIBossHPEnergyItem", max)
  self:_ToggleEnergyState(current, true)
end

function UIBossHPEnergyInfo:_ToggleEnergyState(current, init)
  self._current = current
  local items = self.selectObjPath:GetAllSpawnList()
  local reversedItems = {}
  for i = #items, 1, -1 do
    table.insert(reversedItems, items[i])
  end
  for i = 1, current do
    reversedItems[i]:DoLight(init)
  end
  for i = current + 1, self._max do
    reversedItems[i]:DoDark(init)
  end
  for i = self._max + 1, #reversedItems do
    reversedItems[i]:DoHide()
  end
end

function UIBossHPEnergyInfo:SubHPEnergy(entityID, count)
  if self._entityID ~= entityID then
    return
  end
  if self._max == 0 then
    return
  end
  self._current = self._current - count
  self:UpdateBossHPEnergy(entityID, self._current)
end

function UIBossHPEnergyInfo:UpdateBossHPEnergy(entityID, current)
  if self._entityID ~= entityID then
    return
  end
  if self._max == 0 then
    return
  end
  self:_ToggleEnergyState(current)
end
