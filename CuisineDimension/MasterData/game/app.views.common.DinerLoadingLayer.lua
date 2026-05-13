local tipsCsv = require("csvdata.loadtips")
local loadRes = "ui/common/loading/"
local DinerLoadingLayer = class("DinerLoadingLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function DinerLoadingLayer:ctor(params)
  params = params or {}
  self:size(display.width, display.height)
  self:setTouchEnabled(true)
  self.callback = params.callback or function()
  end
  self:enableNodeEvents()
end

function DinerLoadingLayer:setResourceMgr(resMgr)
  self.resMgr = resMgr
  self.resMgr:setListener(function()
    self:onFinish()
  end)
  return self
end

function DinerLoadingLayer:onEnter()
  local res = "ui/login/main_bg.png"
  if math.random(1, 100) > 50 then
    res = "ui/login/main_bg_1.png"
  end
  local bg = display.newSprite(res):pos(display.cx, display.cy):addTo(self)
  UIHelper.fitForiPhoneX(bg)
  display.newSprite(loadRes .. "tip_bg.png"):pos(display.cx, 90):addTo(self)
  local data = tipsCsv[math.randomInt(1, #tipsCsv)]
  display.newTTFLabel({
    text = "Tips：" .. data.words,
    size = 22,
    color = UIHelper.hex2rgb("#ffffff")
  }):pos(display.cx, 90):addTo(self)
  self.resMgr:load()
end

function DinerLoadingLayer:onFinish()
  self.callback()
  self:removeSelf()
end

function DinerLoadingLayer:onExit()
end

return DinerLoadingLayer
