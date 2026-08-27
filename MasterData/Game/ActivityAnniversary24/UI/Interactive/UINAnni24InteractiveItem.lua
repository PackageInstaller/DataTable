local UINAnni24InteractiveItem = class("UINAnni24InteractiveItem", UIBaseNode)
local base = UIBaseNode

function UINAnni24InteractiveItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_root, self, self._OnClickRoot)
end

function UINAnni24InteractiveItem:SetSpring24InteractiveItemEntt(actLbEntt)
  self._actLbEntt = actLbEntt
end

function UINAnni24InteractiveItem:RefreshSpring24InteractiveItem()
  self.ui.img_type:SetIndex(2)
end

function UINAnni24InteractiveItem:SetArrowOpen(arrowDir)
  self.ui.img_Arrow_trans.gameObject:SetActive(true)
  local angle = Vector3.Angle(Vector3.up, arrowDir)
  local norDir = Vector3.Cross(Vector3.up, arrowDir)
  if norDir.z > 0 then
    angle = angle * -1
  end
  angle = angle + 45
  self.ui.img_Arrow_trans.rotation = Quaternion.AngleAxis(angle, Vector3.back)
end

function UINAnni24InteractiveItem:SetArrowClose()
  self.ui.img_Arrow_trans.gameObject:SetActive(false)
end

function UINAnni24InteractiveItem:_OnClickRoot()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return
  end
  actLbCtrl.actLbCmderCtrl:LbCmdMove2Entt(self._actLbEntt)
end

function UINAnni24InteractiveItem:GetInteractiveItemWidth()
  return 100
end

function UINAnni24InteractiveItem:OnDelete()
  base.OnDelete(self)
end

return UINAnni24InteractiveItem
