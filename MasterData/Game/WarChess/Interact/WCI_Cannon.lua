local base = require("Game.WarChess.Interact.Base.WCI_Base")
local WCI_Cannon = class("WCI_Cannon", base)
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local WarChessHelper = require("Game.WarChess.WarChessHelper")

function WCI_Cannon:ctor()
  self.needWalk = true
  self.isWalk2NearBy = true
  local targetGridPos = self.interactCtrl:GetInteractPos()
  local gridData = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, targetGridPos)
  if gridData ~= nil then
    local rotate = gridData:GetWCGridRotate(true)
    local shootPos = gridData.gridCfg.pms[2]
    shootPos = (shootPos + rotate) % 4
    local moveVector2 = WarChessHelper.rotate2Move[shootPos]
    self.__cannonFrontPos = targetGridPos + moveVector2
  end
end

function WCI_Cannon:__IsThisGridCouldStandInInterAct(gridData)
  if self.__cannonFrontPos ~= nil and gridData:GetGridLogicPos() == self.__cannonFrontPos then
    return false
  end
  return true
end

function WCI_Cannon:WCActPlay()
  local teamData = self.interactCtrl:GetCurTeam()
  local teamLogicPos = teamData:GetWCTeamLogicPos()
  if self.__cannonFrontPos == teamLogicPos then
    CS.MessageCommon.ShowMessageTips(ConfigData:GetTipContent(TipContent.WarChess_InFrontOfCannon))
    self:WCActOver(false)
    return
  end
  local wid, tid = self.wcCtrl.teamCtrl:GetWCTeamIdentify(teamData)
  local identify = {wid = wid, tid = tid}
  local wcPos = self.interactCtrl:GetWCPos()
  local entityCat = self.interactCtrl:GetWCEntityCat()
  local id = self.interactCtrl:GetCurInteractId()
  self.wcCtrl.wcNetworkCtrl:CS_WarChess_Interact(wid, tid, wcPos, entityCat, id, function(argList)
    if argList.Count ~= 1 then
      error("argList.Count error:" .. tostring(argList.Count))
      return
    end
    local isSucess = argList[0]
    self:WCActOver(isSucess)
  end)
end

return WCI_Cannon
