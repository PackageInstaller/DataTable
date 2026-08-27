local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_PickRes = class("WCI_PickRes", base)
local WarChessHelper = require("Game.WarChess.WarChessHelper")

function WCI_PickRes:ctor()
  self.needWalk = true
  if self.interactCtrl:GetCurInteractRange() == 1 then
    self.isWalk2NearBy = true
  else
    self.isWalk2NearBy = false
  end
end

function WCI_PickRes:WCActOver(isSucess)
  base.WCActOver(self, isSucess)
  local triggers = self.InteractCfg.triggers
  if triggers == nil then
    return
  end
  WarChessHelper.AcquireOutSideBoxReward(triggers, self.wcCtrl.wcGlobalData)
end

return WCI_PickRes
