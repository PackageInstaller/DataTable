local base = require("Game.Exploration.Scene.EpSceneA")
local EpScene3 = class("EpSceneA", base)

function EpScene3:OnDelete()
  base.OnDelete(self)
end

return EpScene3
