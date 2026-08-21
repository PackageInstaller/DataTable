local HallowmasScene = class("HallowmasScene", function()
  return display.newScene("HallowmasScene")
end)

function HallowmasScene:ctor(params)
  self.params = params
end

function HallowmasScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local layer = game:createView("hallowmas.HallowmasMainLayer", {})
  BackManager:push(function()
    game:enterScene("MainScene", {layer = "carbon"})
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function HallowmasScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return HallowmasScene
