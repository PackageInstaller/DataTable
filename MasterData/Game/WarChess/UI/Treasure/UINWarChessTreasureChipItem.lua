local base = UIBaseNode
local UISelectChipItem = class("UISelectChipItem", base)
local UINChipDetailPanel = require("Game.CommonUI.Chip.UINEpChipDetail")

function UISelectChipItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._onlockClick = BindCallback(self, self._OnlockClick)
  self._onSelectClick = BindCallback(self, self._OnSelectClick)
  self.panel = UINChipDetailPanel.New()
  self.panel:Init(self.ui.uINChipItemDetail)
  self.lockState = false
end

function UISelectChipItem:InitSelectChipItem(idx, chipData, dynPlayer, resloader, __onChipItemSelectClick, __onlockClickAction, showBuyPrice)
  self.panel:InitEpChipDetail(idx, chipData, dynPlayer, resloader, nil, nil, nil)
  self.idx = idx
  self.chipId = chipData.dataId
  self._selectFunc = __onChipItemSelectClick
  self.__onlockClickAction = __onlockClickAction
  self.buttonGroup = self.panel:GetDetailButtonGroup()
  if showBuyPrice then
    self.buttonGroup:InitBtnSelByCost(true, nil, self._onSelectClick)
  else
    self.buttonGroup:InitBtnSelect(self._onSelectClick)
  end
  self.buttonGroup:SetLockCallback(self._onlockClick)
  self:ShowSelectChipItemLockBtn(false)
end

function UISelectChipItem:_OnlockClick()
  if self.__onlockClickAction ~= nil then
    self.__onlockClickAction(self)
  end
end

function UISelectChipItem:_OnSelectClick()
  if self._selectFunc ~= nil then
    self._selectFunc(self)
  end
end

function UISelectChipItem:ShowSelectChipItemLockBtn(showLockBtn)
  self.buttonGroup:SetLockGoActive(showLockBtn)
end

function UISelectChipItem:SetSelectChipItemLock(lock)
  self.lockState = lock
  self.buttonGroup:SetLockState(self.lockState)
end

function UISelectChipItem:ChangelockUi()
  self.buttonGroup:SetLockState(self.lockState)
end

function UISelectChipItem:GetChipDetailPanel()
  return self.panel
end

function UISelectChipItem:GetChipItemData()
  if self.panel ~= nil then
    return self.panel:GetChipDetailPanelData()
  end
  return nil
end

function UISelectChipItem:SetObjNewTagActive(active, showState)
  self.panel:SetObjNewTagActive(active, showState)
end

function UISelectChipItem:SetTRModifier(uiModifier)
  self.panel:SetUIModifier(uiModifier)
end

function UISelectChipItem:SetSelectChipItemSold(sold, soldGoPrefab)
  if sold and self._soldGo == nil then
    self._soldGo = soldGoPrefab:Instantiate(self.panel.transform)
    self._soldGo.transform.anchoredPosition = Vector2.zero
  end
  self.panel:EnableChipDetailPanelClick(not sold)
  if sold then
    self._soldGo:SetActive(true)
  elseif not IsNull(self._soldGo) then
    self._soldGo:SetActive(false)
  end
end

function UISelectChipItem:OnDelete()
  self.panel:OnDelete()
end

return UISelectChipItem
