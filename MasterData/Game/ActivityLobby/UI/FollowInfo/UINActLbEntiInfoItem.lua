local base = UIBaseNode
local UINActLbEntiInfoItem = class("UINActLbEntiInfoItem", base)
local UINActLbEntiInfoTagNode = require("Game.ActivityLobby.UI.FollowInfo.ExAdd.UINActLbEntiInfoTagNode")

function UINActLbEntiInfoItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  UIUtil.AddButtonListener(self.ui.btn_Root, self, self._OnClickRoot)
  self.ui.time:SetActive(false)
  self._nameColorDefault = self.ui.tex_Name.color
  if not IsNull(self.ui.actLbEntityInfo_Tag) then
    self.tagNode = UINActLbEntiInfoTagNode.New()
    self.tagNode:Init(self.ui.actLbEntityInfo_Tag)
  end
end

function UINActLbEntiInfoItem:InitActLbEntiInfoItem(intrctEntity)
  if self._actTimerNode then
    self._actTimerNode:Hide()
  end
  self._intrctEntity = intrctEntity
  local intrctData = intrctEntity:GetLbIntrctEntData()
  local actionList = intrctData:GetLbIntrctObjActions()
  local actionData = actionList[1]
  if actionData == nil then
    error("actionData == nil")
    return
  end
  self._actionData = actionData
  self.ui.tex_Name.text = actionData:GetLbIntrctActionName()
  self.ui.tex_Des.text = actionData:GetLbIntrctActionSubName()
  self:UpdActLbEntiInfoItemLock()
  self:UpdActLbEntiInfoItemBlueDot()
  self:ExternalShowUI()
end

function UINActLbEntiInfoItem:UpdActLbEntiInfoItemLock()
  local isUnlock = self._actionData:IsLbIntrctEntiUnlock()
  self.ui.obj_Lock:SetActive(false)
  if self.ui.obj_UnlockDes ~= nil then
    self.ui.obj_UnlockDes:SetActive(false)
  end
  if not isUnlock then
    local specialTips = self._actionData:GetLbIntrctActionLockClickTip()
    if string.IsNullOrEmpty(specialTips) or self.ui.obj_UnlockDes == nil then
      self.ui.tex_Lock:SetIndex(self._actionData:GetLbIntrctActionLockStateDes())
      self.ui.obj_Lock:SetActive(true)
    elseif self.ui.tex_UnlockDes ~= nil then
      self.ui.tex_UnlockDes.text = specialTips
      self.ui.obj_UnlockDes:SetActive(true)
    else
      error("self.ui.tex_UnlockDes ~= nil")
    end
  end
  self.ui.img_Bg.color = isUnlock and Color.white or self.ui.color_LockBg
  local textColor = isUnlock and Color.white or self.ui.color_LockTex
  self.ui.tex_Name.color = isUnlock and self._nameColorDefault or self.ui.color_LockTex
  self.ui.tex_Des.color = textColor
end

function UINActLbEntiInfoItem:UpdActLbEntiInfoItemBlueDot()
  self.ui.blueDot:SetActive(self._actionData:IsShowLbIntrctActionBluedot())
end

function UINActLbEntiInfoItem:UpdActLbEntiInfoItemActTimer(tile, timer, days)
  if self._actTimerNode == nil then
    local UINActivityTimer = require("Game.ActivityFrame.UI.UINActivityTimer")
    self._actTimerNode = UINActivityTimer.New()
    self._actTimerNode:Init(self.ui.time)
  end
  self._actTimerNode:Show()
  self._actTimerNode:UpdActTimer(tile, timer, days)
end

function UINActLbEntiInfoItem:UpdActLbEntiInfoTag(tagId)
  if IsNull(self.tagNode) then
    return
  end
  if tagId == 0 then
    self.tagNode:Hide()
    return
  end
  self.tagNode:Show()
  self.tagNode:InitActLbEntiInfoTagNode(tagId)
end

function UINActLbEntiInfoItem:GetEntiUI()
  return self.ui
end

function UINActLbEntiInfoItem:ExternalShowUI()
  self._actionData:ExternalOpeActionUI(self)
end

function UINActLbEntiInfoItem:_OnClickRoot()
  local actLbCtrl = ControllerManager:GetController(ControllerTypeId.ActivityLobbyCtrl)
  if actLbCtrl == nil then
    return
  end
  actLbCtrl.actLbCmderCtrl:LbCmdMove2Entt(self._intrctEntity)
end

function UINActLbEntiInfoItem:OnHide()
  self._actionData:ExternalHideActionUI(self)
end

function UINActLbEntiInfoItem:OnDelete()
  base.OnDelete(self)
end

return UINActLbEntiInfoItem
