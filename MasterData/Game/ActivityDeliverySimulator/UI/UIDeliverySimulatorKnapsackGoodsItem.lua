local base = UIBaseNode
local UIDeliverySimulatorKnapsackGoodsItem = class("UIDeliverySimulatorKnapsackGoodsItem", base)
local util = require("XLua.Common.xlua_util")
local CS_DoTween = CS.DG.Tweening.DOTween

function UIDeliverySimulatorKnapsackGoodsItem:OnInit()
  UIUtil.LuaUIBindingTable(self.transform, self.ui)
  self.__addNewGoodsDelayTime = 0.8
  self.itemWaitFrame = 5
end

function UIDeliverySimulatorKnapsackGoodsItem:InitDeliverySimulatorKnapsackGoodsItem(sprite, price, addOneCallback)
  self.count = 0
  self.addOneCallback = addOneCallback
  self:UpdateGoodsIcon(sprite)
  self:UpdateGoodsPrice(price)
end

function UIDeliverySimulatorKnapsackGoodsItem:OnShow()
  CS_DoTween.Restart(self.ui.tweenNode, "localMoveIn")
end

function UIDeliverySimulatorKnapsackGoodsItem:OnHide()
  self.count = 0
end

function UIDeliverySimulatorKnapsackGoodsItem:AddOne(needAddAnim)
  local newCount = self.count + 1
  self:UpdateGoodsCount(self.count, newCount)
  self.count = newCount
  if needAddAnim then
    self.ui.tween_AddNum:DORestart()
  end
  if self.addOneCallback ~= nil then
    self.addOneCallback()
  end
end

function UIDeliverySimulatorKnapsackGoodsItem:PlayShowAnim(delayTime, count)
  self.tweenMove = self.ui.rect_MoveRoot:DOLocalMove(Vector3.New(0, -50, 0), 0.4):SetDelay(delayTime):SetLink(self.gameObject):SetAutoKill(true):SetRecyclable(true):From()
  self.tweenFade = self.ui.canvasGroup:DOFade(1, 0.5):SetDelay(delayTime):SetLink(self.gameObject):SetAutoKill(true):SetRecyclable(true)
  
  function self.tweenFade.onComplete()
    local waitFrame = 0
    local showCount = 1
    
    local function GrowCountFunc()
      while showCount <= count do
        while 0 < waitFrame do
          waitFrame = waitFrame - 1
          coroutine.yield(nil)
        end
        self:AddOne(true)
        showCount = showCount + 1
        waitFrame = self.itemWaitFrame * 1 / (30 * Time.deltaTime)
      end
    end
    
    if self._addCoutCo ~= nil then
      GR.StopCoroutine(self._addCoutCo)
    end
    self._addCoutCo = GR.StartCoroutine(util.cs_generator(GrowCountFunc))
  end
end

function UIDeliverySimulatorKnapsackGoodsItem:PlayHideAnim()
  CS_DoTween.Restart(self.ui.tweenNode, "localMoveOut")
  self.count = 0
end

function UIDeliverySimulatorKnapsackGoodsItem:UpdateGoodsIcon(sprite)
  self.ui.img_icon.sprite = sprite
end

function UIDeliverySimulatorKnapsackGoodsItem:UpdateGoodsPrice(price)
  self.ui.tex_Price.text = tostring(price)
end

function UIDeliverySimulatorKnapsackGoodsItem:UpdateGoodsCount(oldCount, newCount)
  if self.ui.tex_oldNum ~= nil then
    self.ui.tex_oldNum.text = tostring(oldCount)
  end
  if self.ui.tex_newNum ~= nil then
    self.ui.tex_newNum.text = tostring(newCount)
  end
  if self.ui.tex_Num ~= nil then
    self.ui.tex_Num.text = tostring(newCount)
  end
end

function UIDeliverySimulatorKnapsackGoodsItem:SkipShowAnim()
  self.itemWaitFrame = 0
  self.tweenMove:Complete()
  self.tweenFade:Complete()
end

function UIDeliverySimulatorKnapsackGoodsItem:OnDelete()
  if self._addCoutCo ~= nil then
    GR.StopCoroutine(self._addCoutCo)
  end
end

return UIDeliverySimulatorKnapsackGoodsItem
