local GlobalRes = "ui/global/"
local TapCsv = require("csvdata.tap_effect")
local TouchMaskLayer = class("TouchMaskLayer", function()
  return display.newLayer()
end)

function TouchMaskLayer:ctor(params)
  params = params or {}
  self:size(display.width, display.height)
  local eventDispatcher = self:getEventDispatcher()
  local listener = cc.EventListenerTouchOneByOne:create()
  listener:registerScriptHandler(handler(self, self.onTouchBegan), cc.Handler.EVENT_TOUCH_BEGAN)
  listener:registerScriptHandler(handler(self, self.onTouchMove), cc.Handler.EVENT_TOUCH_MOVED)
  listener:registerScriptHandler(handler(self, self.onTouchEnd), cc.Handler.EVENT_TOUCH_ENDED)
  listener:registerScriptHandler(handler(self, self.onTouchEnd), cc.Handler.EVENT_TOUCH_CANCELLED)
  eventDispatcher:addEventListenerWithSceneGraphPriority(listener, self)
  self.listener = listener
  self.touchHander = nil
  _G.touchMaskEnabled = true
  display.addSpriteFrames(GlobalRes .. "tap_effect.plist", GlobalRes .. "tap_effect.png")
  display.addSpriteFrames(GlobalRes .. "tap_star.plist", GlobalRes .. "tap_star.png")
end

function TouchMaskLayer:onTouchBegan(touch, event)
  if not _G.touchMaskEnabled then
    self.listener:setSwallowTouches(false)
    return true
  end
  if not self.touchHander then
    self.listener:setSwallowTouches(false)
    self.touchHander = touch
    local touchPos = touch:getLocation()
    if not UserData.tapTag or UserData.tapTag == 1 then
      local effect = UIHelper.loadAnimation(GlobalRes, "tap_effect", 22, 30, true)
      effect.sprite:pos(touchPos.x, touchPos.y):addTo(self)
      effect.sprite:setBlendFunc(cc.blendFunc(gl.SRC_ALPHA, gl.ONE))
      effect.sprite:playAnimationOnce(effect.animation, true)
      local star = UIHelper.loadAnimation(GlobalRes, "tap_star", 22, 30, true)
      star.sprite:pos(touchPos.x, touchPos.y):addTo(self)
      star.sprite:setBlendFunc(cc.blendFunc(gl.SRC_ALPHA, gl.ONE))
      star.sprite:playAnimationOnce(star.animation, true)
    else
      local spine = UIHelper.createCommonSpine({
        res = "tap_effect/" .. TapCsv[UserData.tapTag].effectRes
      })
      spine:pos(touchPos.x, touchPos.y):addTo(self)
      spine:setToSetupPose()
      spine:setAnimation(1, "click", false)
      spine:runAction(transition.sequence({
        cc.DelayTime:create(1),
        cc.CallFunc:create(function()
          spine:removeSelf()
        end)
      }))
    end
  else
    self.listener:setSwallowTouches(true)
  end
  return true
end

function TouchMaskLayer:onTouchMove(touch, event)
  if not _G.touchMaskEnabled then
    self.listener:setSwallowTouches(false)
    return
  end
  if self.touchHander and self.touchHander == touch then
    self.listener:setSwallowTouches(false)
  else
    self.listener:setSwallowTouches(true)
  end
end

function TouchMaskLayer:onTouchEnd(touch, event)
  if not _G.touchMaskEnabled then
    self.listener:setSwallowTouches(false)
    return
  end
  if self.touchHander and self.touchHander == touch then
    self.listener:setSwallowTouches(false)
    self.touchHander = nil
  else
    self.listener:setSwallowTouches(true)
  end
end

function TouchMaskLayer:onExit()
end

return TouchMaskLayer
