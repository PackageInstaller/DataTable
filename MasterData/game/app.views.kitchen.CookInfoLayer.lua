local CookInfoLayer = class("CookInfoLayer", function()
  return UIHelper.extend(ccui.Layout:create())
end)

function CookInfoLayer:ctor(params)
  local width = display.width
  if UIHelper.isiPhoneX() then
    width = width + UIHelper.getMoveXForX() * 2
  end
  self:size(width, display.height)
  self:setBackGroundColorType(1)
  self:setBackGroundColor(cc.c3b(0, 0, 0))
  self:setTouchEnabled(true)
  self:setSwallowTouches(true)
  self:setBackGroundColorOpacity(191)
  self:addTo(display.getRunningScene(), POPUP_LAYER_ORDER)
  self:setCallback(function()
    self:removeSelf()
  end)
  local bg = UIHelper.newImageView("ui/kitchen/cook/info_bg.png"):center(self):addTo(self)
  bg:setTouchEnabled(true)
  bg:setSwallowTouches(true)
  local res = params and params.res or "ui/kitchen/cook/info.png"
  display.newSprite(res):pos(318, 135):addTo(bg)
end

return CookInfoLayer
