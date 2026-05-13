local ParadiseScene = class("ParadiseScene", function()
  return display.newScene("ParadiseScene")
end)

function ParadiseScene:ctor(params)
  self.params = params
end

function ParadiseScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local layer = game:createView("carbon.ParadiseBattleLayer", {
    carbonId = self.params.carbonId
  })
  BackManager:push(function()
    game:enterScene("MainScene", {
      layer = "carbon",
      carbonType = 2,
      carbonId = self.params.carbonId,
      skipMusic = true
    })
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function ParadiseScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return ParadiseScene
