local WarChessGridData = class("WarChessGridData")
local eWarChessEnum = require("Game.WarChess.eWarChessEnum")
local eWCInteractType = require("Game.WarChess.Interact.Base.eWCInteractType")
local WarChessConditionCheck = require("Game.WarChess.ConditionCheck.WarChessConditionCheck")
local WarChessHelper = require("Game.WarChess.WarChessHelper")

function WarChessGridData:ctor(BFId, worldLogicPos, gridCfg, areaCoordination)
  self.gridCfg = gridCfg
  self.BFId = BFId
  self.worldLogicPos = worldLogicPos
  self.pos = Vector3.New(worldLogicPos.x, 0, worldLogicPos.y)
  self.areaCoordination = areaCoordination
  self.isInFog = true
  self.isBornPoint = false
  self.__isStandTeam = false
  self.__FXDataDic = {}
  self.searchValue = nil
  self.parentGrid = nil
  self.isHaveDTeamData = nil
  self:GenIsBornPoint()
  local gridResCfg = ConfigData.warchess_grid_res[gridCfg.resId]
  if gridResCfg == nil then
    error(string.format("Cant get warchess_grid_res, id = %s", gridCfg.resId))
    return
  end
  self._gridResCfg = gridResCfg
end

function WarChessGridData:GetWCGridBFId()
  return self.BFId
end

function WarChessGridData:GetIsBornPoint()
  return self.isBornPoint
end

function WarChessGridData:GetGridLogicPos()
  return self.worldLogicPos
end

function WarChessGridData:GetGridShowPos()
  return self.pos
end

function WarChessGridData:SetWCGridUnitCfg(unit)
  self.gridCfg = unit
  self:GenIsBornPoint()
end

function WarChessGridData:SetWCGridIsInFog(bool)
  self.isInFog = bool
end

function WarChessGridData:SetWCGridIsStandTeam(bool)
  self.__isStandTeam = bool
end

function WarChessGridData:GetWCGridIsInFog()
  return self.isInFog
end

function WarChessGridData:IsWCUnitMonster()
  return false
end

function WarChessGridData:GetCouldStand()
  return self.gridCfg.moveFlag == 0 and not self.__isStandTeam and not self:GetWCGridIsInFog()
end

function WarChessGridData:GetCouldPass(isMonster)
  if isMonster then
    return self.gridCfg.moveFlag == 0 and not self.__isStandTeam and not self:GetWCGridIsInFog()
  end
  return self.gridCfg.moveFlag == 0 and not self:GetWCGridIsInFog()
end

function WarChessGridData:GetCouldPatrol()
  return self.gridCfg.moveFlag == 0 and not self:GetWCGridIsInFog()
end

function WarChessGridData:GetGridUnit()
  return self.gridCfg
end

function WarChessGridData:GetGridInteractions()
  return self.gridCfg.interactions
end

function WarChessGridData:GetGridInteractionRange()
  return self.gridCfg.opRange
end

function WarChessGridData:SaveGridAnimArg(nameHash, animaId)
  self.__saveAnimData = {nameHash = nameHash, animaId = animaId}
end

function WarChessGridData:GetGridAnimArg()
  return self.__saveAnimData
end

function WarChessGridData:GetFirstGridInertactWithCat(specificCat)
  for _, interactCfg in pairs(self.gridCfg.interactions) do
    if interactCfg.cat == specificCat then
      return interactCfg
    end
  end
  return nil
end

function WarChessGridData:GetGridCouldInteract()
  if #self:GetGridInteractions() < 1 then
    return false
  end
  local isHaveCouldUseOne = false
  for _, interaction in pairs(self:GetGridInteractions()) do
    if WarChessConditionCheck.CheckGridConditionTree(self:GetGridUnit(), interaction) then
      isHaveCouldUseOne = true
      break
    end
  end
  return isHaveCouldUseOne
end

function WarChessGridData:GetCouldInteract(specificCat)
  local interactCfg = self:GetFirstGridInertactWithCat(specificCat)
  if interactCfg == nil then
    return false
  end
  return WarChessConditionCheck.CheckGridConditionTree(self:GetGridUnit(), interactCfg)
end

function WarChessGridData:GetGridUseItemConsume(specificCat, itemId)
  local interactCfg = self:GetFirstGridInertactWithCat(specificCat)
  local costNum = 0
  for key, trigger in pairs(interactCfg.triggers) do
    if trigger.cat == 16 and trigger.pms[1] == 1 and trigger.pms[2] == itemId then
      costNum = costNum + trigger.pms[3]
    end
  end
  return costNum
end

function WarChessGridData:GetWcGridAreaCoordination()
  return self.areaCoordination
end

function WarChessGridData:GetCouldShowBornFX()
  return self:GetIsBornPoint() and not self.isHaveDTeamData
end

function WarChessGridData:GenIsBornPoint()
  local isBornPoint = false
  for index, interactCfg in pairs(self.gridCfg.interactions) do
    if interactCfg.cat == eWCInteractType.born then
      isBornPoint = self.gridCfg.pms ~= nil and 0 < (self.gridCfg.pms[1] or 0)
    end
  end
  self.isBornPoint = isBornPoint
end

function WarChessGridData:GetInteractShowOffset()
  return self._gridResCfg.height
end

function WarChessGridData:GetFxDataDic()
  return self.__FXDataDic
end

function WarChessGridData:GetWCUnitInterActIcon()
  local iconId = self._gridResCfg.icon
  local iconCfg = ConfigData.warchess_Interact_icon[iconId]
  if iconCfg == nil then
    return nil
  end
  return iconCfg.icon_name
end

function WarChessGridData:GetWcGridSuccessAudio()
  return self._gridResCfg.successAudio
end

function WarChessGridData:GetWcGridAniAudioDic()
  return self._gridResCfg.aniAudioDic
end

function WarChessGridData:GetWCGridRotate(isNum)
  if self.gridCfg == nil then
    return
  end
  local gridCatCfg = ConfigData.warchess_grid_cat[self.gridCfg.cat]
  if gridCatCfg ~= nil and gridCatCfg.rotate then
    local p = self.gridCfg.pms[gridCatCfg.rotate_index + 1]
    if p == nil then
      return
    end
    if isNum then
      return p
    end
    local rotate = WarChessHelper.rotateValue[p]
    return rotate
  end
end

function WarChessGridData:GetFxCount()
  return nil
end

return WarChessGridData
