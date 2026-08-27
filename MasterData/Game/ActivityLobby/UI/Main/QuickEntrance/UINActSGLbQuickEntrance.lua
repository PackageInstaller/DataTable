local base = require("Game.ActivityLobby.UI.Main.QuickEntrance.UINActLbQuickEntrance")
local UINActSGLbQuickEntrance = class("UINActSGLbQuickEntrance", base)
local UINLbSGQuickEntranceItem = require("Game.ActivityLobby.UI.Main.QuickEntrance.UINLbSGQuickEntranceItem")
local ActLbEnum = require("Game.ActivityLobby.ActLbEnum")
local UINSteinsMobileAnim = require("Game.Activity23SteinsGate.UI.MobileAnim.UINSteinsMobileAnim")

function UINActSGLbQuickEntrance:OnInit()
  base.OnInit(self)
  self._mobileAnim = UINSteinsMobileAnim.New()
  self._mobileAnim:Init(self.ui.animation)
end

function UINActSGLbQuickEntrance:AddButtonNormal()
  UIUtil.AddButtonListener(self.ui.btn_CloseBg, self, self._OnClickClose)
end

function UINActSGLbQuickEntrance:SetPoolNormal()
  self._entranceItemPool = UIItemPool.New(UINLbSGQuickEntranceItem, self.ui.item, false)
end

function UINActSGLbQuickEntrance:InitLbQuickEntrance(actionList, enterCallback)
  self.enterCallback = enterCallback
  if self.enterCallback then
    self.enterCallback(true)
  end
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl then
    actLbCtrl:SetActLbState(ActLbEnum.eActLbState.ShowQuickEntrance)
  end
  self.isShowing = true
  self:Show()
  self._mobileAnim:PlayTextureAnim(false, self.ui.obj_Phone, function()
    self.isShowing = false
  end)
  self._entranceItemDic = {}
  self._entranceItemPool:HideAll()
  for k, actionData in ipairs(actionList) do
    local item = self._entranceItemPool:GetOne()
    item:InitLbQuickEntranceItem(actionData)
    local actionId = actionData:GetLbIntrctActionId()
    self._entranceItemDic[actionId] = item
  end
  self._shareNode.transform:SetAsLastSibling()
end

function UINActSGLbQuickEntrance:_OnClickClose()
  if self.isShowing then
    return
  end
  if self.isHiding then
    return
  end
  self.isHiding = true
  if self.enterCallback then
    self.enterCallback(false)
  end
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl then
    actLbCtrl:SetActLbState(ActLbEnum.eActLbState.Normal)
  end
  self._mobileAnim:PlayTextureAnim(true, self.ui.obj_Phone, function()
    self:Hide()
    self.isHiding = false
  end)
end

function UINActSGLbQuickEntrance:OnDelete()
  base.OnDelete(self)
end

return UINActSGLbQuickEntrance
