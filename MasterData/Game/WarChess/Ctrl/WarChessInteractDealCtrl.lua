local base = require("Game.WarChess.Ctrl.Base.WarChessCtrlBase")
local WarChessInteractDealCtrl = class("WarChessInteractDealCtrl", base)
local WCInteractClassDic = require("Game.WarChess.Interact.Base.WCInteractClassDic")
local WarChessHelper = require("Game.WarChess.WarChessHelper")
local WarChessConditionCheck = require("Game.WarChess.ConditionCheck.WarChessConditionCheck")

function WarChessInteractDealCtrl:ctor(wcCtrl)
  self.__interactOverCallback = nil
  self.__curInteractCfg = nil
  self.__curInteractIndex = nil
  self.__curAct = nil
  self.__curTeam = nil
  self.__isGrid = true
  self.__targetGridData = nil
  self.__targetEntityData = nil
  self.__isNotReturnYet = false
  self.__hasColoseInteract = true
  self.__isSucess = nil
end

function WarChessInteractDealCtrl:WCDealGridInteract(gridData, teamData, interactCfg, interactOverCallback)
  self.__interactOverCallback = interactOverCallback
  local interactCfg = interactCfg
  if interactCfg == nil then
    self:OnInteractOver(false)
    return false
  end
  if not WarChessConditionCheck.CheckGridConditionTree(gridData:GetGridUnit(), interactCfg) then
    self:OnInteractOver(false)
    return false
  end
  local actClass = WCInteractClassDic[interactCfg.cat]
  if actClass == nil then
    self:OnInteractOver(false)
    return false
  end
  self.__isGrid = true
  self.__targetGridData = gridData
  self.__curTeam = teamData
  self.__curInteractCfg = interactCfg
  self.__curInteractIndex = interactCfg.id
  self.__curAct = actClass.New(self.wcCtrl, self)
  return self.__curAct:IsWCActCouldRun()
end

function WarChessInteractDealCtrl:WCDealEntityInteract(entityData, teamData, interactCfg, interactOverCallback)
  self.__interactOverCallback = interactOverCallback
  local interactCfg = interactCfg
  if interactCfg == nil then
    self:OnInteractOver(false)
    return false
  end
  if not WarChessConditionCheck.CheckGridConditionTree(entityData:GetEntityUnit(), interactCfg) then
    self:OnInteractOver(false)
    return false
  end
  local actClass = WCInteractClassDic[interactCfg.cat]
  if actClass == nil then
    self:OnInteractOver(false)
    return false
  end
  self.__isGrid = false
  self.__targetEntityData = entityData
  self.__curTeam = teamData
  self.__curInteractCfg = interactCfg
  self.__curInteractIndex = interactCfg.id
  self.__curAct = actClass.New(self.wcCtrl, self)
  self.__isNotReturnYet = true
  self.__hasColoseInteract = false
  self.__isSucess = nil
  local isOK = self.__curAct:IsWCActCouldRun()
  self.__isNotReturnYet = false
  if self.__hasColoseInteract then
    return self.__isSucess
  end
  return isOK
end

function WarChessInteractDealCtrl:OnInteractOver(isSucess)
  local interactOverCallback = self.__interactOverCallback
  self.__interactOverCallback = nil
  self.__curInteractCfg = nil
  self.__curAct = nil
  self.__curTeam = nil
  if self.__isNotReturnYet then
    self.__isSucess = isSucess
    self.__hasColoseInteract = true
  end
  if interactOverCallback ~= nil then
    interactOverCallback(isSucess)
  end
end

function WarChessInteractDealCtrl:GetCurInteractId()
  return self.__curInteractIndex
end

function WarChessInteractDealCtrl:GetCurInteractCfg()
  return self.__curInteractCfg
end

function WarChessInteractDealCtrl:GetCurTeam()
  return self.__curTeam
end

function WarChessInteractDealCtrl:GetTeamPos()
  return self:GetCurTeam():GetWCTeamLogicPos()
end

function WarChessInteractDealCtrl:GetInteractPos()
  if self.__isGrid then
    return self.__targetGridData:GetGridLogicPos()
  else
    return self.__targetEntityData:GetEntityLogicPos()
  end
  error("can't get Interact point Pos")
end

function WarChessInteractDealCtrl:GetInteractBFId()
  if self.__isGrid then
    return self.__targetGridData:GetWCGridBFId()
  else
    return self.__targetEntityData:GetWCEntityBFId()
  end
  error("can't get Interact BFId")
end

function WarChessInteractDealCtrl:GetWCPos()
  local BFId = self:GetInteractBFId()
  local pointPos = self:GetInteractPos()
  return {
    gid = BFId,
    pos = WarChessHelper.Pos2Coordination(pointPos)
  }
end

function WarChessInteractDealCtrl:GetWCEntityCat()
  if self.__isGrid then
    return self.__targetGridData:GetGridUnit().entityCat or 1
  else
    return self.__targetEntityData:GetEntityUnit().entityCat or 2
  end
end

function WarChessInteractDealCtrl:GetWCIneractionAPCost(interactCfg)
  local costNum = 0
  for key, trigger in pairs(interactCfg.triggers) do
    if trigger.cat == 5 and trigger.pms[2] == 1 then
      costNum = costNum + trigger.pms[3]
    end
  end
  return costNum
end

function WarChessInteractDealCtrl:GetCurInteractPMS()
  return self.__curInteractCfg.pms
end

function WarChessInteractDealCtrl:GetCurInteractRange()
  if self.__isGrid then
    return self.__targetGridData:GetGridInteractionRange()
  else
    return self.__targetEntityData:GetEntityInteractionRange()
  end
end

function WarChessInteractDealCtrl:GetCurIsGrid()
  return self.__isGrid
end

function WarChessInteractDealCtrl:GetCurInteractData()
  if self.__isGrid then
    return self.__targetGridData
  else
    return self.__targetEntityData
  end
end

function WarChessInteractDealCtrl:GetCurInteractPos()
  if self.__isGrid then
    return self.__targetGridData:GetGridShowPos()
  else
    return self.__targetEntityData.pos
  end
end

function WarChessInteractDealCtrl:GetWcInteraSuccessAudio()
  if self.__isGrid then
    if self.__targetGridData ~= nil then
      return self.__targetGridData:GetWcGridSuccessAudio()
    end
  elseif self.__targetEntityData ~= nil then
    return self.__targetEntityData:GetWcEntitySuccessAudio()
  end
  return 0
end

function WarChessInteractDealCtrl:Delete()
end

return WarChessInteractDealCtrl
