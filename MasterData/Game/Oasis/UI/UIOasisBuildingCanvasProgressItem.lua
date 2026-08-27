local UIOasisBuildingCanvasProgressItem = class("UIOasisBuildingCanvasProgressItem", UIBaseNode)
local base = UIBaseNode

function UIOasisBuildingCanvasProgressItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
end

function UIOasisBuildingCanvasProgressItem:InitCanvasProcessItem(id, position, process, text)
  self.id = id
  self:UpdateProcessPos(position)
  self:UpdateProcess(process, text)
  self.transform.localScale = Vector3.one
end

function UIOasisBuildingCanvasProgressItem:Split(bgRoot, fillRoot, textRoot)
  self.ui.bg:SetParent(bgRoot)
  self.ui.fill.transform:SetParent(fillRoot)
  self.ui.text.transform:SetParent(textRoot)
end

function UIOasisBuildingCanvasProgressItem:UpdateProcess(process, text)
  self.ui.text.text = text
  self.ui.fill.fillAmount = process
end

function UIOasisBuildingCanvasProgressItem:UpdateProcessPos(position)
  self.transform.position = position
end

function UIOasisBuildingCanvasProgressItem:OnRecycle()
  self.id = nil
  self.transform.localScale = Vector3.zero
end

function UIOasisBuildingCanvasProgressItem:OnDelete()
  self.ui.bg:SetParent(self.transform)
  self.ui.fill.transform:SetParent(self.transform)
  self.ui.text.transform:SetParent(self.transform)
  base.OnDelete(self)
end

return UIOasisBuildingCanvasProgressItem
