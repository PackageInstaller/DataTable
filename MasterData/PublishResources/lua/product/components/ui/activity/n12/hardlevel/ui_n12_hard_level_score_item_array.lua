_class("UIN12HardLevelScoreItemArray", UICustomWidget)
UIN12HardLevelScoreItemArray = UIN12HardLevelScoreItemArray

function UIN12HardLevelScoreItemArray:Constructor()
end

function UIN12HardLevelScoreItemArray:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12HardLevelScoreItemArray:_GetComponent()
  self._subItem = self:GetUIComponent("UISelectObjectPath", "SubItem")
  self._subItem2 = self:GetUIComponent("UISelectObjectPath", "SubItem2")
end

function UIN12HardLevelScoreItemArray:SetData(globalDelayTimeFunc, affixs, selectAffixCallBack)
  self._allWidgets = {}
  self._count = #affixs
  self._subItem:SpawnObjects("UIN12HardLevelScoreItem", 1)
  local items = self._subItem:GetAllSpawnList()
  if 1 <= #items then
    table.insert(self._allWidgets, items[1])
  end
  self._allWidgets[1]:SetData(globalDelayTimeFunc, {
    affixs[1]
  }, selectAffixCallBack, function(index)
    self:MutexCheck(index)
  end, 1, affixs)
  self._subItem2:SpawnObjects("UIN12HardLevelItem", self._count - 1)
  local items2 = self._subItem2:GetAllSpawnList()
  for i = 1, self._count - 1 do
    table.insert(self._allWidgets, items2[i])
  end
  for i = 2, self._count do
    self._allWidgets[i]:SetData(globalDelayTimeFunc, {
      affixs[i]
    }, selectAffixCallBack, function(index)
      self:MutexCheck(index)
    end, i, affixs)
  end
end

function UIN12HardLevelScoreItemArray:MutexCheck(index)
  for i = 1, self._count do
    if i ~= index then
      self._allWidgets[i]:SelectAffix(false, true)
    end
  end
end
