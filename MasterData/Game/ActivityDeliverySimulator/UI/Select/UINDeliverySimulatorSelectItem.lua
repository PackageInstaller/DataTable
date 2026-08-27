local base = UIBaseNode
local UINDeliverySimulatorSelectItem = class("UINDeliverySimulatorSelectItem", base)

function UINDeliverySimulatorSelectItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_item, self, self.OnClickItem)
end

function UINDeliverySimulatorSelectItem:InitDeliverySimulatorSelectItem(index, lockData, selectCallback)
  self.index = index
  self.isSelect = false
  self.selectCallback = selectCallback
  self.lockData = lockData
  self:RefreshItemShow()
end

function UINDeliverySimulatorSelectItem:RefreshItemShow()
  self.ui.obj_Lock:SetActive(self.lockData.isLock)
  self.ui.tex_Level.gameObject:SetActive(not self.lockData.isLock)
  if self.lockData.isLock then
    self.ui.tex_Des.text = self.lockData.lockDes
    return
  end
  local idDes = string.format("%02d", self.index)
  self.ui.tex_Level:SetIndex(0, idDes)
  self.ui.obj_Select:SetActive(self.isSelect)
end

function UINDeliverySimulatorSelectItem:RefreshBlueDot(bool)
  self.ui.blueDot:SetActive(bool)
end

function UINDeliverySimulatorSelectItem:RefreshSelect(isSelect)
  if self.lockData.isLock then
    return
  end
  self.ui.obj_Select:SetActive(isSelect)
end

function UINDeliverySimulatorSelectItem:OnClickItem()
  if self.selectCallback ~= nil then
    self.selectCallback(self.index, self)
  end
end

function UINDeliverySimulatorSelectItem:OnDelete()
end

return UINDeliverySimulatorSelectItem
