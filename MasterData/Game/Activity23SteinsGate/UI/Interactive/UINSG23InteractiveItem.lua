local UINSG23InteractiveItem = class("UINAthItem", UIBaseNode)
local base = UIBaseNode

function UINSG23InteractiveItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Group, self, self._OnClickRoot)
end

function UINSG23InteractiveItem:SetSG23InteractiveItemEntt(actLbEntt)
  self._actLbEntt = actLbEntt
end

function UINSG23InteractiveItem:SetIsHeroInteractItem(bool)
  self.isHero = bool
  self:RefreshSG23NeedShowItem()
end

function UINSG23InteractiveItem:RefreshSG23NeedShowItem()
  self.ui.btn_InteractiveNpc:SetActive(self.isHero)
  self.ui.btn_InteractiveItem:SetActive(not self.isHero)
end

function UINSG23InteractiveItem:RefreshSG23InteractiveItem(interactCfg, CloseAni)
end

function UINSG23InteractiveItem:_StartSEAni()
  if self.isHero then
  end
end

function UINSG23InteractiveItem:CloseAllAni()
end

function UINSG23InteractiveItem:SetArrowOpen(arrowDir)
  self.ui.img_Arrow_trans.gameObject:SetActive(true)
  local angle = Vector3.Angle(Vector3.up, arrowDir)
  local norDir = Vector3.Cross(Vector3.up, arrowDir)
  if norDir.z > 0 then
    angle = angle * -1
  end
  angle = angle + 45
  self.ui.img_Arrow_trans.rotation = Quaternion.AngleAxis(angle, Vector3.back)
end

function UINSG23InteractiveItem:SetArrowClose()
  self.ui.img_Arrow_trans.gameObject:SetActive(false)
end

function UINSG23InteractiveItem:_OnClickRoot()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return
  end
  actLbCtrl.actLbCmderCtrl:LbCmdMove2Entt(self._actLbEntt)
end

function UINSG23InteractiveItem:GetInteractiveItemWidth()
  return 100
end

function UINSG23InteractiveItem:OnHide()
end

function UINSG23InteractiveItem:OnDelete()
  base.OnDelete(self)
end

return UINSG23InteractiveItem
