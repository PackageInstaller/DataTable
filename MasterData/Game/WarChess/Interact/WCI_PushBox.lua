local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_PushBox = class("WCI_PushBox", base)

function WCI_PushBox:ctor()
  self.needWalk = true
  self.isWalk2NearBy = true
end

function WCI_PushBox:WCActPlay()
  local teamData = self.interactCtrl:GetCurTeam()
  local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
  local wcPos = self.interactCtrl:GetWCPos()
  local entityCat = self.interactCtrl:GetWCEntityCat()
  local id = self.interactCtrl:GetCurInteractId()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_Interact(wid, tid, wcPos, entityCat, id, function(argList)
    if argList.Count ~= 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local isSucess = argList[0]
    if not isSucess then
      CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(8525))
    end
    self:WCActOver(isSucess)
  end)
end

return WCI_PushBox
