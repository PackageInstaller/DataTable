local UINAthEfccQuickSelect = class("UINAthEfccQuickSelect", UIBaseNode)
local base = UIBaseNode
local UINAthEfccQuickSelectItem = require("Game.Arithmetic.AthEfficiency.UINAthEfccQuickSelectItem")
local AthEnum = require("Game.Arithmetic.ArthmeticEnum")

function UINAthEfccQuickSelect:ctor()
end

function UINAthEfccQuickSelect:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.__OnClickClose)
  self._OnSelectItemFunc = BindCallback(self, self._OnSelectItem)
  self.ui.sortKindItem:SetActive(false)
  self.selectItemPool = UIItemPool.New(UINAthEfccQuickSelectItem, self.ui.sortKindItem)
  for index = 1, AthEnum.AthEfccQuickSelectEnumNum do
    local selectItem = self.selectItemPool:GetOne()
    selectItem:InitAthEfccQuickSelectItem(index, self._OnSelectItemFunc)
  end
end

function UINAthEfccQuickSelect:InitAthEfccQuickSelect(quickSelectFunc, withoutMat)
  self.quickSelectFunc = quickSelectFunc
  if withoutMat then
    self.selectItemPool.listItem[AthEnum.AthEfccQuickSelectEnum.Material]:Hide()
  end
end

function UINAthEfccQuickSelect:OnShow()
  self._cancelSelect = false
end

function UINAthEfccQuickSelect:_OnSelectItem(isOn)
  if isOn then
    self:__OnClickClose()
  else
    self._cancelSelect = true
  end
end

function UINAthEfccQuickSelect:__OnClickClose()
  local selectId
  for k, item in ipairs(self.selectItemPool.listItem) do
    if item.ui.tog_Root.isOn then
      selectId = item.index
      break
    end
  end
  if self.quickSelectFunc ~= nil and (selectId ~= nil or self._cancelSelect) then
    self.quickSelectFunc(selectId)
  end
  self:Hide()
end

function UINAthEfccQuickSelect:OnDelete()
  self.selectItemPool:DeleteAll()
  base.OnDelete(self)
end

return UINAthEfccQuickSelect
