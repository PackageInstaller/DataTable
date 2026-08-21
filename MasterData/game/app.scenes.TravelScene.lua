local TravelScene = class("TravelScene", function()
  return display.newScene("TravelScene")
end)

function TravelScene:ctor(params)
  self.params = params or {}
end

function TravelScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  BackManager:clear()
  local layer = game:createView("carbon.CarbonTravelLayer", {
    roomInfo = self.params.roomInfo
  })
  local touchMaskLayer = TouchMaskLayer.new()
  touchMaskLayer:addTo(self, TOUCH_MASK_ORDER)
end

function TravelScene:onCleanup()
  display.removeUnusedSpriteFrames()
end

return TravelScene
