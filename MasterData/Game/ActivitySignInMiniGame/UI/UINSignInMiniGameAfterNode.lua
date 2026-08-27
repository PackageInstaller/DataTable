local UINSignInMiniGameAfterNode = class("UINSignInMiniGameAfterNode", UIBaseNode)
local base = UIBaseNode
local UINUserHead = require("Game.CommonUI.Head.UINUserHead")
local UINAfterItem = require("Game.ActivitySignInMiniGame.UI.UINSignInMiniGameAfterItem")

function UINSignInMiniGameAfterNode:ctor(storeRoomRoot)
  self.storeRoomRoot = storeRoomRoot
end

function UINSignInMiniGameAfterNode:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.userHeadNode = UINUserHead.New()
  self.userHeadNode:Init(self.ui.obj_UINUserHead)
  self.ui.obj_afterItem:SetActive(false)
  self.afterItemPool = UIItemPool.New(UINAfterItem, self.ui.obj_afterItem)
end

function UINSignInMiniGameAfterNode:InitNode(ctrl, resLoader)
  self.siginInMiniCtrl = ctrl
  local userInfoData = PlayerDataCenter.inforData
  self.resLoader = resLoader
  self.ui.tex_Name.text = userInfoData:GetUserName()
  self.ui.tex_UID.text = "UID:" .. userInfoData:GetUserUID()
  self.userHeadNode:InitUserHeadUI(userInfoData:GetAvatarId(), userInfoData:GetAvatarFrameId(), resLoader)
  local signatureText = tostring(userInfoData:GetAvatarSignature())
  if string.IsNullOrEmpty(signatureText) then
    self.ui.tex_Signature.text = ConfigData:GetTipContent(6030)
  else
    self.ui.tex_Signature.text = tostring(signatureText)
  end
  self.afterItemPool:HideAll()
  local allSignDay = self.siginInMiniCtrl:GetTotalSignDay()
  local allSignData = ctrl:GetAllSignData()
  if allSignData ~= nil then
    for k, v in ipairs(allSignData) do
      local item = self.afterItemPool:GetOne()
      item.transform:SetParent(self.ui.groupIten_After.transform)
      item.transform:SetAsFirstSibling()
      local leftDay = ctrl:GetLeftDayWithCurTime(v.signTime)
      local range = ctrl:GetSignDataRange(k, v)
      item:InitSignInMiniGameAfterItem(ctrl, v, resLoader, k)
    end
  end
  self.ui.tween_root:DOComplete()
end

function UINSignInMiniGameAfterNode:AddNewItem(signIndex, signData)
  local item = self.afterItemPool:GetOne()
  item.transform:SetParent(self.ui.groupIten_After.transform)
  item.transform:SetAsFirstSibling()
  local leftDay = self.siginInMiniCtrl:GetLeftDayWithCurTime(signData.signTime)
  local range = self.siginInMiniCtrl:GetSignDataRange(signIndex, signData)
  local allSignDay = self.siginInMiniCtrl:GetTotalSignDay()
  item:InitSignInMiniGameAfterItem(self.siginInMiniCtrl, signData, self.resLoader, signIndex, true)
end

function UINSignInMiniGameAfterNode:PlayTweenAnim()
  self.ui.tween_root:DORestartById("root")
end

function UINSignInMiniGameAfterNode:OnShow()
  base.OnShow(self)
end

function UINSignInMiniGameAfterNode:OnHide()
  base.OnHide()
end

function UINSignInMiniGameAfterNode:OnDelete()
  base.OnDelete(self)
  self.userHeadNode:Delete()
  self.afterItemPool:DeleteAll()
end

return UINSignInMiniGameAfterNode
