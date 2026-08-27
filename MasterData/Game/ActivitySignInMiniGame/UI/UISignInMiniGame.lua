local UISignInMiniGame = class("UISignInMiniGame", UIBaseWindow)
local base = UIBaseWindow
local UINSignInMiniGameBeforeNode = require("Game.ActivitySignInMiniGame.UI.UINSignInMiniGameBeforeNode")
local UINSignInMiniGameAfterNode = require("Game.ActivitySignInMiniGame.UI.UINSignInMiniGameAfterNode")

function UISignInMiniGame:OnInit()
  UIUtil.AddButtonListener(self.ui.btn_Close, self, self.OnClickBtnClose)
  UIUtil.AddButtonListener(self.ui.btn_notice, self, self.OnClickBtnNotice)
  UIUtil.AddButtonListener(self.ui.btn_square, self, self.OnClickBtnSquare)
  self.resloader = CS.ResLoader.Create()
  self.beforeNode = UINSignInMiniGameBeforeNode.New(self)
  self.beforeNode:Init(self.ui.obj_before)
  self.afterNode = UINSignInMiniGameAfterNode.New(self)
  self.afterNode:Init(self.ui.obj_after)
end

function UISignInMiniGame:InitSignInMiniGame(actId, isShowCloseBtn)
  self.signInMiniGameCtrl = ControllerManager:GetController(ControllerTypeId.ActivitySignInMiniGame, true)
  if actId ~= self.signInMiniGameCtrl:GetActId() then
    return
  end
  self.ui.obj_bg:SetActive(isShowCloseBtn or false)
  self.ui.btn_Close.gameObject:SetActive(isShowCloseBtn or false)
  self.beforeNode:InitNode(self.signInMiniGameCtrl, self.resloader)
  self.afterNode:InitNode(self.signInMiniGameCtrl, self.resloader)
  self:RefreshIsCanSign()
  self:OnClickBtnNotice()
end

function UISignInMiniGame:RefreshIsCanSign()
  self.isCanSign = self.signInMiniGameCtrl:IsCanSignToDay()
  self.ui.obj_Icon:SetActive(self.isCanSign)
end

function UISignInMiniGame:OnSwitchTogChanged(index, value)
  self.ui.img_togs[index]:SetIndex(value and 0 or 1)
  if value == true then
    if index == 1 then
      self.beforeNode:Show()
      self.afterNode:Hide()
    elseif index == 2 then
      self.beforeNode:Hide()
      self.afterNode:Show()
      self.ui.obj_Icon:SetActive(false)
    end
  end
end

function UISignInMiniGame:RefreshBtnImg()
  self.ui.img_notice:SetIndex(self.curNode == 1 and 0 or 1)
  self.ui.img_square:SetIndex(self.curNode == 2 and 0 or 1)
end

function UISignInMiniGame:OnClickBtnNotice()
  self.curNode = 1
  self.beforeNode:Show()
  self.afterNode:Hide()
  self:RefreshBtnImg()
end

function UISignInMiniGame:OnClickBtnSquare()
  if self.isCanSign then
    local cfg = ConfigData.sign_minigame_text[15]
    if cfg ~= nil then
      CS.MessageCommon.ShowMessageTips(LanguageUtil.GetLocaleText(cfg.content))
    end
    return
  end
  self.curNode = 2
  self.beforeNode:Hide()
  self.afterNode:Show()
  self.ui.obj_Icon:SetActive(false)
  self:RefreshBtnImg()
end

function UISignInMiniGame:OnEmojiWindowClose()
  local index, signData = self.signInMiniGameCtrl:GetNewSignInDay()
  self.beforeNode:RefreshNode()
  self.afterNode:AddNewItem(index, signData)
  self:RefreshIsCanSign()
  self:OnClickBtnSquare()
  self.afterNode:PlayTweenAnim()
end

function UISignInMiniGame:SetCloseCallback(callback)
  self.__closeCallback = callback
end

function UISignInMiniGame:OnClickBtnClose()
  self:Delete()
  if self.__closeCallback ~= nil then
    local action = self.__closeCallback
    self.__closeCallback = nil
    action()
  end
end

function UISignInMiniGame:OnDelete()
  self.resloader:Put2Pool()
  self.resloader = nil
  self.beforeNode:Delete()
  self.afterNode:Delete()
  base.OnDelete(self)
end

return UISignInMiniGame
