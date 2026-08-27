local base = UIBaseNode
local UIDeliverySimulatorOrderItem = class("UIDeliverySimulatorOrderItem", base)
local UIDeliverySimulatorOrderGoodsItem = require("Game.ActivityDeliverySimulator.UI.UIDeliverySimulatorOrderGoodsItem")
local Queue = require("Framework.Lib.Queue")
local util = require("XLua.Common.xlua_util")

function UIDeliverySimulatorOrderItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.orderGoodsItemPool = UIItemPool.New(UIDeliverySimulatorOrderGoodsItem, self.ui.obj_orderGoodsItem, false)
  self._tweenFuncQueue = Queue.New()
  self.isTweening = false
end

function UIDeliverySimulatorOrderItem:InitDeliverySimulatorOrderItem(order)
  self.order = order
  self:Refresh(order)
end

function UIDeliverySimulatorOrderItem:Refresh(order)
  local orderCfg = order.cfg
  self:RefreshOrderGoodsList(order)
  self:RefreshReward(orderCfg.reward_num)
  self:UpdateTimeProgress(order:GetRemainingTimeRatio())
end

function UIDeliverySimulatorOrderItem:RefreshOrderGoodsList(order)
  self.orderGoodsItemPool:HideAll()
  for index, orderId in pairs(order.cfg.good_id_list) do
    local goodsItem = self.orderGoodsItemPool:GetOne()
    goodsItem:InitDeliverySimulatorOrderGoodsItem(order, index)
  end
end

function UIDeliverySimulatorOrderItem:RefreshReward(price)
  self.ui.tex_reward.text = price
end

function UIDeliverySimulatorOrderItem:UpdateTimeProgress(rate)
  self.ui.slider.value = rate
end

function UIDeliverySimulatorOrderItem:UpdateProgress()
  self:UpdateTimeProgress(self.order:GetRemainingTimeRatio())
end

function UIDeliverySimulatorOrderItem:AddTweener(tweenFunc)
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

function UIDeliverySimulatorOrderItem:PlayMoveTween(relativePosition, onComplete)
  local function _TweenFunc()
    self.ui.rectTransform:DOLocalMove(relativePosition, 0.8):SetRelative(true):SetLink(self.gameObject):SetAutoKill(true):SetRecyclable(true).onComplete = function()
      self.isTweening = false
      
      if onComplete ~= nil then
        onComplete()
      end
    end
  end
  
  self:AddTweener(_TweenFunc)
end

function UIDeliverySimulatorOrderItem:PlayFailAnim(onComplete)
  local function _TweenFunc()
    self.ui.tween_redBlink:DORestart()
    
    self.ui.tween_shake:DORestart()
    
    function self.ui.tween_hide.tween.onComplete()
      self.isTweening = false
      if onComplete ~= nil then
        onComplete()
      end
    end
    
    self.ui.tween_hide:DORestart()
  end
  
  self:AddTweener(_TweenFunc)
end

function UIDeliverySimulatorOrderItem:OnShow()
  self.ui.canvasGroup.alpha = 1
end

function UIDeliverySimulatorOrderItem:OnHide()
  self.order = nil
  self.isTweening = false
  if self._tweenChcekFuncCo ~= nil then
    GR.StopCoroutine(self._tweenChcekFuncCo)
  end
  self._tweenChcekFuncCo = nil
  self._tweenFuncQueue:Clear()
  self.orderGoodsItemPool:HideAll()
end

function UIDeliverySimulatorOrderItem:OnDelete()
  self.order = nil
  self.orderGoodsItemPool:DeleteAll()
  self.orderGoodsItemPool = nil
  if self._tweenChcekFuncCo ~= nil then
    GR.StopCoroutine(self._tweenChcekFuncCo)
    self._tweenChcekFuncCo = nil
  end
  self._tweenFuncQueue:Clear()
  self._tweenFuncQueue = nil
end

return UIDeliverySimulatorOrderItem
