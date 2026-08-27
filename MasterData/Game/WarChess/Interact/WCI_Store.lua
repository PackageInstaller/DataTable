local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_Store = class("WCI_Store", base)

function WCI_Store:ctor()
  self.needWalk = true
  self.isWalk2NearBy = true
end

function WCI_Store:PlayWCActOverAudio()
  AudioManager:PlayAudioById(1244)
end

return WCI_Store
