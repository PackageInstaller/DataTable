local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_Born = class("WCI_Born", base)

function WCI_Born:ctor()
  self.needWalk = false
end

function WCI_Born:WCActConfirm()
  base.WCActWalkTo(self)
end

function WCI_Born:WCActPlay()
  local teamData = self.interactCtrl:GetCurTeam()
  local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
  local wcPos = self.interactCtrl:GetWCPos()
  local entityCat = self.interactCtrl:GetWCEntityCat()
  local id = self.interactCtrl:GetCurInteractId()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_Deploy(wid, tid, wcPos, entityCat, id, function(argList)
    if argList.Count ~= 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local isSucess = argList[0]
    self:WCActOver(isSucess)
  end)
end

return WCI_Born
