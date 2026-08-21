local MainScene = class("MainScene", function()
  return display.newScene("MainScene")
end)

function MainScene:ctor(params)
  self.params = params or {}
end

function MainScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  BackManager:clear()
  if game.role.homeType ~= nil and game.role.homeType == 2 and globalCsv.newHomeOpen == 1 then
    TopBar = game:createView("global.TopBar_2")
  else
    TopBar = game:createView("global.TopBar")
  end
  TopBar:hide()
  if game.role.majorGuideStep == 9 and not SKIP_GUIDE then
    NewGuideLayer.new({
      step = 9,
      callback = function()
        self:showUI()
      end
    })
  else
    self:showUI()
  end
  local touchMaskLayer = TouchMaskLayer.new()
  touchMaskLayer:addTo(self, TOUCH_MASK_ORDER)
  if self.params.callback then
    self.params.callback()
  end
end

function MainScene:showUI()
  local homeName = game.role.homeType ~= nil and game.role.homeType == 2 and globalCsv.newHomeOpen == 1 and "home.HomeNewLayer" or "home.HomeLayer"
  local layer = game:createView(homeName, self.params)
  layer:addTo(self)
end

function MainScene:onCleanup()
  display.removeUnusedSpriteFrames()
  TopBar:close()
end

return MainScene
