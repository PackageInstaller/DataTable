local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_Battle = class("WCI_Battle", base)

function WCI_Battle:ctor()
  self.needWalk = not self:WCIsTeamOnPoint()
  self.isWalk2NearBy = true
end

function WCI_Battle:WCActPlay()
  local teamData = self.interactCtrl:GetCurTeam()
  local entityData = self.interactCtrl:GetCurInteractData()
  local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
  local wcPos = self.interactCtrl:GetWCPos()
  local entityCat = self.interactCtrl:GetWCEntityCat()
  local id = self.interactCtrl:GetCurInteractId()
  self.wcCtrl.mapCtrl:GetMonsterCouldSecKill(entityData, teamData, function(isSeckill)
    local battleInteract = {canSecKill = isSeckill}
    self.wcCtrl.wcNetworkCtrl:CS_WarChess_Interact(wid, tid, wcPos, entityCat, id, function(argList)
      if argList.Count ~= 1 then
        error("argList.Count error:" .. tostring(argList.Count))
        return
      end
      local isSucess = argList[0]
      self:WCActOver(isSucess)
    end, battleInteract)
  end)
end

function WCI_Battle:PlayWCActOverAudio()
  AudioManager:PlayAudioById(1237)
end

return WCI_Battle
