_class("UIN12HardLevelItemArray", UICustomWidget)
UIN12HardLevelItemArray = UIN12HardLevelItemArray

function UIN12HardLevelItemArray:Constructor()
end

function UIN12HardLevelItemArray:OnShow(uiParams)
  self:_GetComponent()
end

function UIN12HardLevelItemArray:_GetComponent()
  self._subItem = self:GetUIComponent("UISelectObjectPath", "SubItem")
end

function UIN12HardLevelItemArray:SetData(globalDelayTimeFunc, affixs, selectAffixCallBack)
  self._count = #affixs
  self._allWidgets = {}
  self._subItem:SpawnObjects("UIN12HardLevelItem", self._count)
  self._allWidgets = self._subItem:GetAllSpawnList()
  for i = 1, self._count do
    self._allWidgets[i]:SetData(globalDelayTimeFunc, {
      affixs[i]
    }, selectAffixCallBack, function(index)
      self:MutexCheck(index)
    end, i, affixs)
  end
end

function UIN12HardLevelItemArray:MutexCheck(index)
  for i = 1, self._count do
    if i ~= index then
      self._allWidgets[i]:SelectAffix(false, true)
    end
  end
end
