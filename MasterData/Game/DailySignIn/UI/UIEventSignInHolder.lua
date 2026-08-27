local UIEventSignInHolder = class("UIEventSignInHolder", UIBaseWindow)
local base = UIBaseWindow
local UINEventSignIn = require("Game.DailySignIn.UI.UINEventSignIn")
local UINEventSignInWithPeriodicCard = require("Game.DailySignIn.UI.UINEventSignInWithPeriodicCard")
local EPeriodicCardType = require("Game.DailySignIn.DailySignInEnum").EPeriodicCardType
local JumpManager = require("Game.Jump.JumpManager")

function UIEventSignInHolder:OnInit()
  UIUtil.SetTopStatus(self, self.CloseEventSignin, nil, nil, nil, true)
  UIUtil.AddButtonListener(self.ui.btn_close, self, self.OnClickCloseSign)
  UIUtil.AddButtonListener(self.ui.btn_backGround, self, self.OnClickCloseSign)
  if PlayerDataCenter.dailySignInData:GetIsMonthCardUnlock(EPeriodicCardType.WeekCard) or PlayerDataCenter.dailySignInData:GetMonthCardData(EPeriodicCardType.WeekCard):GetIsHaveMonthCard() then
    self.eventSignInPage = UINEventSignInWithPeriodicCard.New()
    self.ui.obj_EventSignin:SetActive(false)
    self.ui.obj_EventSigninWithPeriodicCards:SetActive(true)
    self.eventSignInPage:Init(self.ui.obj_EventSigninWithPeriodicCards)
  else
    self.eventSignInPage = UINEventSignIn.New()
    self.ui.obj_EventSignin:SetActive(true)
    self.ui.obj_EventSigninWithPeriodicCards:SetActive(false)
    self.eventSignInPage:Init(self.ui.obj_EventSignin)
  end
  self._lastCouldUseItemJump = JumpManager.couldUseItemJump
  JumpManager.couldUseItemJump = false
end

function UIEventSignInHolder:InitEventSignin(activityId, notPickedSinginMailUIDList)
  self.isOpenInActivity = activityId ~= nil
  if self.isOpenInActivity then
    self.ui.btn_close.gameObject:SetActive(false)
    self.ui.btn_backGround.gameObject:SetActive(false)
  end
  self.eventSignInPage:InitEventSignin(activityId, notPickedSinginMailUIDList)
end

function UIEventSignInHolder:SetCloseCallback(callback)
  self.closeCallback = callback
end

function UIEventSignInHolder:OnClickCloseSign()
  if self.waitingShowReward then
    return
  end
  UIUtil.OnClickBackByUiTab(self)
end

function UIEventSignInHolder:CloseEventSignin()
  if self.closeCallback ~= nil then
    self.closeCallback()
  end
  JumpManager.couldUseItemJump = self._lastCouldUseItemJump
  self:Delete()
end

function UIEventSignInHolder:OnDelete()
  self.eventSignInPage:Delete()
end

return UIEventSignInHolder
