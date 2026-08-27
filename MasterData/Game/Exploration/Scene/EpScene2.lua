local base = require("Game.Exploration.Scene.EpSceneA")
local EpScene2 = class("EpSceneA", base)

function EpScene2:OnDelete()
  base.OnDelete(self)
end

return EpScene2
