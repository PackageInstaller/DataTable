local WCI_Base = class("WCI_Base")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")

function WCI_Base:ctor(wcCtrl, interactCtrl)
  self.wcCtrl = wcCtrl
  self.interactCtrl = interactCtrl
  local InteractCfg = interactCtrl:GetCurInteractCfg()
  self.InteractCfg = InteractCfg
  self.interactCat = InteractCfg.cat
  self.pms = InteractCfg.pms
  self.needWalk = nil
  self.needWalk2Grid = nil
  self.isWalk2NearBy = false
  self.isNotAutoWalk = false
  self.preparePmsCallback = nil
  self.onCSSuccessCallback = nil
end

function WCI_Base:IsWCActCouldRun()
  if self.needWalk then
    local teamData = self.interactCtrl:GetCurTeam()
    local teamPos = self.interactCtrl:GetTeamPos()
    local startGrid = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, teamPos)
    local pointPos = self.interactCtrl:GetInteractPos()
    local endGird
    local isOK, passGridList = false
    self.needWalk2Grid = nil
    if not self.isWalk2NearBy then
      endGird = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, pointPos)
      if endGird ~= nil then
        isOK, passGridList = WarChessHelper.AStrarPathFind(self.wcCtrl.mapCtrl, startGrid, endGird, false, teamData)
      end
      if isOK then
        self.needWalk2Grid = endGird
      else
        self.interactCtrl:OnInteractOver(false)
        return
      end
    else
      local costNum = math.maxinteger
      for _, way in pairs(WarChessHelper.AStarSearchOrder) do
        local gridPos = pointPos + way
        endGird = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, gridPos)
        if teamPos == gridPos then
          costNum = 0
          self.needWalk2Grid = endGird
          break
        end
        if endGird ~= nil and endGird:GetCouldStand() and self:__IsThisGridCouldStandInInterAct(endGird) then
          isOK, passGridList = WarChessHelper.AStrarPathFind(self.wcCtrl.mapCtrl, startGrid, endGird, false, teamData)
        end
        if isOK and costNum > #passGridList then
          costNum = #passGridList
          self.needWalk2Grid = endGird
        end
      end
      if self.needWalk2Grid ~= nil then
        isOK = true
      else
        self.interactCtrl:OnInteractOver(false)
        return
      end
    end
    if isOK then
      self:WCActConfirm()
      return true
    end
  else
    self:WCActConfirm()
    return true
  end
end

function WCI_Base:__IsThisGridCouldStandInInterAct(gridData)
  return true
end

function WCI_Base:WCActConfirm()
  self:WCActWalkTo()
end

function WCI_Base:WCActWalkTo()
  local function ReachPointOver()
    if self.wcCtrl:IsWCInSubSystem() then
      self:WCActOver(false)
      
      return
    end
    self:WCActPlay()
  end
  
  if self.needWalk and self.needWalk2Grid ~= nil then
    if self.needWalk2Grid:GetGridLogicPos() == self.interactCtrl:GetTeamPos() and self.isWalk2NearBy then
      local pointPos = self.interactCtrl:GetInteractPos()
      local targetGird = self.wcCtrl.mapCtrl:GetGridDataByLogicPos(nil, pointPos)
      self.wcCtrl.curState:Turn2Grid(targetGird, ReachPointOver)
      return
    end
    self.wcCtrl.curState:Walk2Grid(self.needWalk2Grid, ReachPointOver)
    return
  end
  ReachPointOver()
end

function WCI_Base:WCActPlay()
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
    self:WCActOver(isSucess)
  end)
end

function WCI_Base:PlayWCActOverAudio()
  local successAudio = self.interactCtrl:GetWcInteraSuccessAudio()
  if 0 < successAudio then
    AudioManager:PlayAudioById(successAudio)
    return
  end
  AudioManager:PlayAudioById(1234)
end

function WCI_Base:WCActOver(isSucess)
  self.interactCtrl:OnInteractOver(isSucess)
  if isSucess then
    self:PlayWCActOverAudio()
  end
end

function WCI_Base:WCIsTeamOnPoint()
  local teamPos = self.interactCtrl:GetTeamPos()
  local pointPos = self.interactCtrl:GetInteractPos()
  return teamPos == pointPos
end

function WCI_Base:WCIsTeamNearPoint()
  local teamPos = self.interactCtrl:GetTeamPos()
  local pointPos = self.interactCtrl:GetInteractPos()
  local dis = Vector2.Distance(teamPos, pointPos)
  return dis <= 1.1 and 0.1 < dis
end

return WCI_Base
