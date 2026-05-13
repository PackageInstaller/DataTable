local MidAutumnScene = class("MidAutumnScene", function()
  return display.newScene("MidAutumnScene")
end)

function MidAutumnScene:ctor(params)
  self.params = params
end

function MidAutumnScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local layer
  if self.params.sceneType == "moon" then
    layer = game:createView("autumn.MidAutumnMainLayer", {})
  elseif self.params.sceneType == "christmas" then
    layer = game:createView("christmas.ChristmasMainLayer", {})
  elseif self.params.sceneType == "taptap" then
    layer = game:createView("taptap.TapTapMainLayer", {})
  elseif self.params.sceneType == "newyear" then
    layer = game:createView("newyear.FirstDayMainLayer", {})
  elseif self.params.sceneType == "palace" then
    layer = game:createView("palace.PalaceMainLayer", {})
  elseif self.params.sceneType == "oneyear" then
    layer = game:createView("year.YearScoreActivityLayer", {})
  elseif self.params.sceneType == "hallowmas" then
    layer = game:createView("hallowmas.HallowmasMainLayer", {})
  elseif self.params.sceneType == "general1" then
    layer = game:createView("general.GeneralCarbonLayer", {})
  elseif self.params.sceneType == "general2" then
    layer = game:createView("general.GeneralScoreLayer", {})
  elseif self.params.sceneType == "activity" then
    layer = game:createView("mission.ActivityMissionLayer", {})
  end
  BackManager:push(function()
    game:enterScene("MainScene")
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function MidAutumnScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return MidAutumnScene
