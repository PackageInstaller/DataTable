local UnionBattleScene = class("UnionBattleScene", function()
  return display.newScene("UnionBattleScene")
end)

function UnionBattleScene:ctor(params)
  self.params = params or {}
end

function UnionBattleScene:onEnter()
  EdgeMaskLayer.new(self)
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local layer = game:createView("union.UnionBattleMainLayer", self.params)
  BackManager:push(function()
    game:enterScene("MainScene")
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function UnionBattleScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return UnionBattleScene
