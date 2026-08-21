local MonsterCsv = require("csvdata.monster")
local ChapterBattleCsv = require("csvdata.chapter_battle")
local AutoBattleCsv = require("csvdata.auto_battle")
local CarbonScene = class("CarbonScene", function()
  return display.newScene("CarbonScene")
end)

function CarbonScene:ctor(params)
  self.params = params
end

function CarbonScene:onEnter()
  if not UIHelper.isiPhoneX() then
    EdgeMaskLayer.new(self)
  end
  BackManager:clear()
  TopBar = game:createView("global.TopBar")
  local layer = game:createView("carbon.CarbonBattleLayer", {
    carbonId = self.params.carbonId,
    modeType = self.params.modeType
  })
  BackManager:push(function()
    game:enterScene("MainScene", {
      layer = "carbon",
      carbonId = self.params.carbonId,
      skipMusic = true
    })
  end)
  TouchMaskLayer.new():addTo(self, TOUCH_MASK_ORDER)
end

function CarbonScene:onCleanup()
  display.removeUnusedSpriteFrames()
  if TopBar and TopBar.close then
    TopBar:close()
  end
end

return CarbonScene
