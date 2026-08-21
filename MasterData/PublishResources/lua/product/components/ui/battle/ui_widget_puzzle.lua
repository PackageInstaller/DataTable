_class("UIWidgetPuzzle", UICustomWidget)
UIWidgetPuzzle = UIWidgetPuzzle

function UIWidgetPuzzle:OnShow(uiParams)
  self:InitWidget()
end

function UIWidgetPuzzle:InitWidget()
  self._countDownObj = self:GetGameObject("CountDown")
  self._countDownObj:SetActive(false)
  self._txtCountdownTime = self:GetUIComponent("UILocalizationText", "CountDownTime")
  self._isGuide = false
  self:RegisterEvent()
end

function UIWidgetPuzzle:OnReset(countdownTime)
  self._countDownMs = countdownTime
  self._countDownNum = math.ceil(self._countDownMs / 1000)
  local strNum = tostring(self._countDownNum) .. "s"
  self._txtCountdownTime:SetText(strNum)
end

function UIWidgetPuzzle:RegisterEvent()
  self:AttachEvent(GameEventType.ShowPuzzleUI, self.ShowPuzzleUI)
  self:AttachEvent(GameEventType.GuidePuzzleCountdown, self.GuidePuzzleCountdown)
end

function UIWidgetPuzzle:ShowPuzzleUI(show, countdownTime)
  self._countDownObj:SetActive(show)
  if show and countdownTime then
    self:OnReset(countdownTime)
  end
end

function UIWidgetPuzzle:GuidePuzzleCountdown(guideState)
  if not guideState then
    self._isGuide = false
  end
  self._isGuide = guideState[1] == 1
end

function UIWidgetPuzzle:OnUpdate(deltaTimeMS)
  if self._isGuide then
    return
  end
  if self._countDownObj.activeSelf and self._countDownMs > 0 then
    local deltaTime = GameGlobal:GetInstance():GetUnscaledDeltaTime()
    self._countDownMs = self._countDownMs - deltaTime
    self:RefreshCountDownNum()
    if self._countDownMs <= 0 then
      GameGlobal.EventDispatcher():Dispatch(GameEventType.PuzzleUICountDownOver)
    end
  end
end

function UIWidgetPuzzle:RefreshCountDownNum()
  local refreshNumSec = 0
  if 0 > self._countDownMs then
    refreshNumSec = 0
  else
    refreshNumSec = math.ceil(self._countDownMs / 1000)
  end
  if self._countDownNum ~= refreshNumSec then
    self._countDownNum = refreshNumSec
    local timeNumStr = tostring(self._countDownNum) .. "s"
    self._txtCountdownTime:SetText(timeNumStr)
  end
end
