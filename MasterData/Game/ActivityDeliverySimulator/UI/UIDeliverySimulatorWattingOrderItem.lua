local base = UIBaseNode
local UIDeliverySimulatorWattingOrderItem = class("UIDeliverySimulatorWattingOrderItem", base)
local CS_DOTween = CS.DG.Tweening.DOTween
local Queue = require("Framework.Lib.Queue")
local util = require("XLua.Common.xlua_util")

function UIDeliverySimulatorWattingOrderItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self._animWattingTextChangeTime = 0
  self.isTweening = false
  self._tweenFuncQueue = Queue.New()
end

function UIDeliverySimulatorWattingOrderItem:InitDeliverySimulatorWattingOrderItem(dsCtrl)
  self.dsCtrl = dsCtrl
  self.isShowInList = false
end

function UIDeliverySimulatorWattingOrderItem:UpdateProgress()
  self:UpdateWattingText()
  if self.dsCtrl ~= nil then
    local progress = self.dsCtrl:GetNextOrderProgress()
    self:UpdateTimeProgress(progress)
  end
end

function UIDeliverySimulatorWattingOrderItem:UpdateWattingText()
  self._animWattingTextChangeTime = self._animWattingTextChangeTime + Time.deltaTime
  if self._animWattingTextChangeTime >= 3 then
    self._animWattingTextChangeTime = self._animWattingTextChangeTime - 3
  end
  local textIndex = math.floor(self._animWattingTextChangeTime)
  self.ui.text_Tip:SetIndex(textIndex)
end

function UIDeliverySimulatorWattingOrderItem:UpdateTimeProgress(rate)
  self.ui.slider.value = rate
end

function UIDeliverySimulatorWattingOrderItem:PlayShowWattingOrderItemAnim(localPosition, relativePosition, delayTime)
  self.transform.localPosition = localPosition
  self.ui.canvasGroup.alpha = 1
  self:PlayMoveTween(relativePosition, delayTime, function()
    self.isShowInList = true
  end)
end

function UIDeliverySimulatorWattingOrderItem:PlayHideWattingOrderItemAnim(localPosition, onComplete)
  self.ui.canvasGroup:DOFade(0, 0.8):SetLink(self.ui.canvasGroup.gameObject):SetAutoKill(true):SetRecyclable(true)
  self:PlayMoveTween(localPosition, 0, function()
    self.isShowInList = false
    print(tostring(self.isShowInList))
    onComplete()
  end)
end

function UIDeliverySimulatorWattingOrderItem:AddTweener(tweenFunc)
  self._tweenFuncQueue:PushBack(tweenFunc)
  
  local function _tweenChcekFunc()
    while self._tweenFuncQueue:Count() > 0 do
      if self.isTweening then
        coroutine.yield(nil)
      else
        local tweenFunc = self._tweenFuncQueue:PopFront()
        self.isTweening = true
        tweenFunc()
      end
    end
    self._tweenChcekFuncCo = nil
  end
  
  if self._tweenChcekFuncCo == nil then
    self._tweenChcekFuncCo = GR.StartCoroutine(util.cs_generator(BindCallback(self, _tweenChcekFunc)))
  end
end

function UIDeliverySimulatorWattingOrderItem:PlayMoveTween(relativePosition, delayTime, onComplete)
  local function _TweenFunc()
    self.ui.rectTransform:DOLocalMove(relativePosition, 0.8):SetDelay(delayTime):SetRelative(true):SetLink(self.gameObject):SetAutoKill(true):SetRecyclable(true).onComplete = function()
      self.isTweening = false
      
      if onComplete ~= nil then
        onComplete()
      end
    end
  end
  
  self:AddTweener(_TweenFunc)
end

function UIDeliverySimulatorWattingOrderItem:Reset()
  self._animWattingTextChangeTime = 0
  self.isShowInList = false
  self.isTweening = false
  self:UpdateProgress()
  self.ui.canvasGroup.alpha = 0
  if self._tweenChcekFuncCo ~= nil then
    GR.StopCoroutine(self._tweenChcekFuncCo)
  end
  self._tweenFuncQueue:Clear()
end

function UIDeliverySimulatorWattingOrderItem:OnDelete()
  if self._tweenChcekFuncCo ~= nil then
    GR.StopCoroutine(self._tweenChcekFuncCo)
  end
  self._tweenChcekFuncCo = nil
  self._tweenFuncQueue:Clear()
  self._tweenFuncQueue = nil
end

return UIDeliverySimulatorWattingOrderItem
