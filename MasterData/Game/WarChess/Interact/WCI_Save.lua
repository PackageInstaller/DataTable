local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_Save = class("WCI_Switch", base)
local WarChessSeasonUtil = require("Game.WarChessSeason.WarChessSeasonUtil")

function WCI_Save:ctor()
  self.needWalk = false
  self.isWalk2NearBy = false
end

function WCI_Save:WCActPlay()
  local interactentityData = self.interactCtrl:GetCurInteractData()
  if interactentityData == nil then
    error("show info interactentityData not exist")
    base.WCActOver(self, false)
    return
  end
  WarChessSeasonUtil.OpenSeasonSaveWindow(function()
    base.WCActOver(self, true)
  end)
end

return WCI_Save
