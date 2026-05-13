local LtyScene = class("LtyScene", function()
  return display.newScene("LtyScene")
end)

function LtyScene:ctor(params)
  self.params = params or {}
end

function LtyScene:onEnter()
  EdgeMaskLayer.new(self)
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local curBattle = game.role.ltyCurBattle:toArray("=", true)
  if curBattle[1] ~= 0 then
    local layer = game:createView("lty.LtyCarbonLayer", self.params)
    BackManager:push(function()
      self.params.goMainLayer = true
      local newLayer = game:createView("lty.LtyMainLayer", self.params)
      layer:close()
      BackManager:push(function()
        game:enterScene("MainScene")
      end)
    end)
    return
  end
  local layer = game:createView("lty.LtyMainLayer", self.params)
  BackManager:push(function()
    game.role.ltyLastCarbon = nil
    game:enterScene("MainScene")
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function LtyScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return LtyScene
