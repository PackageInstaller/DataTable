_class("UIWidgetUnscaledCountDownUI", UICustomWidget)
UIWidgetUnscaledCountDownUI = UIWidgetUnscaledCountDownUI

function UIWidgetUnscaledCountDownUI:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetUnscaledCountDownUI:InitWidget()
  self._countDownObj = self:GetGameObject("CountDown")
  self._countDownTimeText = self:GetUIComponent("UILocalizationText", "CountDownTime")
  self:OnReset()
  self:RegisterEvent()
end

function UIWidgetUnscaledCountDownUI:OnReset()
  self._countDownNum = 30
  local strNum = tostring(self._countDownNum) .. "s"
  self._countDownTimeText:SetText(strNum)
  self._countDownMs = self._countDownNum * 1000
  self._enableCountDown = false
end

function UIWidgetUnscaledCountDownUI:RegisterEvent()
  self:AttachEvent(GameEventType.UIShowUnscaledCountDown, self.UIShowUnscaledCountDown)
  self:AttachEvent(GameEventType.UIEnableUnscaledCountDown, self.UIEnableUnscaledCountDown)
end

function UIWidgetUnscaledCountDownUI:IsAutoFighting()
  return GameGlobal.GetUIModule(MatchModule):IsAutoFighting()
end

function UIWidgetUnscaledCountDownUI:ShowAutoFightForbiddenMsg()
  return GameGlobal.GetUIModule(MatchModule):ShowAutoFightForbiddenMsg()
end

function UIWidgetUnscaledCountDownUI:UIShowUnscaledCountDown(show)
  self._countDownObj:SetActive(show)
  if not show then
    self:OnReset()
  end
end

function UIWidgetUnscaledCountDownUI:UIEnableUnscaledCountDown(bEnable)
  self._enableCountDown = bEnable
end

function UIWidgetUnscaledCountDownUI:OnUpdate(deltaTimeMS)
  if self._enableCountDown and self._countDownObj.activeSelf then
    local restTimeMs = InnerGameHelperRender.UIGetCurGlobalUnscaledCoundDownTime()
    self._countDownMs = restTimeMs
    self:RefreshCountDownNum()
  end
end

function UIWidgetUnscaledCountDownUI:RefreshCountDownNum()
  local refreshNumSec = 0
  if 0 > self._countDownMs then
    refreshNumSec = 0
  else
    refreshNumSec = math.ceil(self._countDownMs / 1000)
  end
  if self._countDownNum ~= refreshNumSec then
    self._countDownNum = refreshNumSec
    local timeNumStr = tostring(self._countDownNum) .. "s"
    self._countDownTimeText:SetText(timeNumStr)
  end
end
