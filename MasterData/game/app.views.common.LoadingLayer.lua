local tipsCsv = require("csvdata.loadtips")
local loadRes = "ui/common/loading/"
local LoadingLayer = class("LoadingLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function LoadingLayer:ctor(params)
  params = params or {}
  self:size(display.width, display.height)
  self:setTouchEnabled(true)
  self.callback = params.callback or function()
  end
  self:enableNodeEvents()
end

function LoadingLayer:setResourceMgr(resMgr)
  self.resMgr = resMgr
  self.resMgr:setListener(function()
    self:onFinish()
  end)
  return self
end

function LoadingLayer:onEnter()
  local cx = display.cx
  if UIHelper.isiPhoneX() then
    self:setPositionX(self:getPositionX() - UIHelper.getMoveXForX())
    cx = cx + UIHelper.getMoveXForX(true)
  end
  self.up = display.newSprite(loadRes .. (UIHelper.isiPhoneX() and "up_x.png" or "up.png")):anch(0.5, 0):pos(cx, display.height + 155):addTo(self)
  self.down = display.newSprite(loadRes .. (UIHelper.isiPhoneX() and "down_x.png" or "down.png")):anch(0.5, 1):pos(cx, 0):addTo(self)
  local animat = display.newSprite(loadRes .. (UIHelper.isiPhoneX() and "circle_4_x.png" or "circle_4.png")):anch(0.5, 0.5):pos(cx, display.cy):addTo(self.up)
  animat:runAction(cc.RepeatForever:create(cc.RotateBy:create(2, 360)))
  display.newSprite(loadRes .. (UIHelper.isiPhoneX() and "circle_2_x.png" or "circle_2.png")):anch(0.5, 0.5):center(self.up):addTo(self.up)
  display.newSprite(loadRes .. (UIHelper.isiPhoneX() and "circle_1_x.png" or "circle_1.png")):anch(0.5, 0.5):center(self.up):addTo(self.up)
  self.cover = display.newSprite(loadRes .. (UIHelper.isiPhoneX() and "circle_3_x.png" or "circle_3.png")):anch(0.5, 0):pos(cx, display.cy + 475):addTo(self)
  local data = tipsCsv[math.randomInt(1, #tipsCsv)]
  display.newTTFLabel({
    text = "Tips：" .. data.words,
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(cx, 90):addTo(self.down)
  self.up:runAction(cc.EaseQuarticActionIn:create(cc.MoveBy:create(0.5, cc.p(0, -display.height - 155))))
  self.down:runAction(cc.EaseQuarticActionIn:create(cc.MoveBy:create(0.5, cc.p(0, display.height))))
  self.cover:runAction(cc.EaseQuarticActionIn:create(cc.MoveBy:create(0.5, cc.p(0, -display.cy - 475))))
  game:playMusic(1020)
  self.delay = true
  self:runAction(transition.sequence({
    cc.DelayTime:create(0.5),
    cc.CallFunc:create(function()
      if self.resMgr then
        self.resMgr:load()
      else
        self:removeSelf()
      end
    end),
    cc.DelayTime:create(2),
    cc.CallFunc:create(function()
      self:onFinish()
    end)
  }))
end

function LoadingLayer:onFinish()
  if self.delay then
    self.delay = false
    return
  end
  game:playMusic(1021)
  self.callback()
  self.up:runAction(cc.EaseQuarticActionOut:create(cc.MoveBy:create(1, cc.p(0, display.height + 155))))
  self.down:runAction(cc.EaseQuarticActionOut:create(cc.MoveBy:create(1, cc.p(0, -display.height))))
  self.cover:runAction(cc.EaseQuarticActionOut:create(cc.MoveBy:create(1, cc.p(0, display.cy + 475))))
  self:runAction(transition.sequence({
    cc.DelayTime:create(1),
    cc.CallFunc:create(function()
      self:removeSelf()
    end)
  }))
end

function LoadingLayer:onExit()
end

return LoadingLayer
