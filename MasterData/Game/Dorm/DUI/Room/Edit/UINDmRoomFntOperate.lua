local UINDmRoomFntOperate = class("UINDmRoomFntOperate", UIBaseNode)
local base = UIBaseNode

function UINDmRoomFntOperate:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Recycle, self, self._OnClickRecycle)
  UIUtil.AddButtonListener(self.ui.btn_Reset, self, self._OnClickReset)
  UIUtil.AddButtonListener(self.ui.btn_Rote, self, self._OnClickRotate)
  UIUtil.AddButtonListener(self.ui.btn_Confirm, self, self._OnClickConfirm)
end

function UINDmRoomFntOperate:InitDmRoomFntOperate(dormRoomCtrl, fntName, showRotBtn, showRecycleBtn)
  self.dormRoomCtrl = dormRoomCtrl
  self:SetDmRoomFntOpFnt(fntName)
  self.ui.btn_Rote.gameObject:SetActive(showRotBtn)
  self.ui.btn_Recycle.gameObject:SetActive(showRecycleBtn)
end

function UINDmRoomFntOperate:SetDmRoomFntOpFnt(fntName)
  self.ui.tex_itemName.text = fntName
end

function UINDmRoomFntOperate:UpdDmRoomFntOpPos(transform)
  if self.active then
    local x, y = UIManager:World2UIPositionOut(transform)
    self.transform.localPosition = Vector3.New(x, y, 0)
  end
end

function UINDmRoomFntOperate:_OnClickRecycle()
  self.dormRoomCtrl:RecycleFntSelect()
end

function UINDmRoomFntOperate:_OnClickReset()
  self.dormRoomCtrl:ResetFntEntity()
end

function UINDmRoomFntOperate:_OnClickRotate()
  self.dormRoomCtrl:RotateFnt()
end

function UINDmRoomFntOperate:_OnClickConfirm()
  self.dormRoomCtrl:DeselectFntEntity()
end

function UINDmRoomFntOperate:OnDelete()
  base.OnDelete(self)
end

return UINDmRoomFntOperate
