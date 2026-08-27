local UINAthTableGridState = class("UINAthTableGridState", UIBaseNode)
local base = UIBaseNode
local cs_MessageCommon = CS.MessageCommon

function UINAthTableGridState:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
end

function UINAthTableGridState:InitAthGridState(position, stateIndex, gridState)
  self.transform.anchoredPosition = position
  self.ui.img_State:SetIndex(stateIndex)
  self.ui.img_State.image.raycastTarget = true
  self._gridState = gridState
end

function UINAthTableGridState:BindAthGridClickCallback(callback)
  self._clickCallback = callback
end

function UINAthTableGridState:_OnClickRoot()
  if self._clickCallback ~= nil then
    self._clickCallback(self._gridState)
  end
end

function UINAthTableGridState:OnDelete()
  base.OnDelete(self)
end

return UINAthTableGridState
