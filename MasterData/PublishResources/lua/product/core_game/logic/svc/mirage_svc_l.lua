_class("MirageServiceLogic", BaseService)
MirageServiceLogic = MirageServiceLogic

function MirageServiceLogic:GetMirageComponent()
  local boardEntity = self._world:GetBoardEntity()
  local mirageCmpt = boardEntity:Mirage()
  return mirageCmpt
end

function MirageServiceLogic:SetMirageOver()
  local boardEntity = self._world:GetBoardEntity()
  boardEntity:ReplaceMirage()
end

function MirageServiceLogic:SetMirageOpen()
  local mirageCmpt = self:GetMirageComponent()
  mirageCmpt:SetMirageOpenState(true)
end

function MirageServiceLogic:IsMirageOpen()
  local mirageCmpt = self:GetMirageComponent()
  return mirageCmpt:IsMirageOpen()
end

function MirageServiceLogic:SetMirageForceClose()
  local mirageCmpt = self:GetMirageComponent()
  mirageCmpt:SetMirageForceClose(true)
end

function MirageServiceLogic:IsMirageForceClose()
  local mirageCmpt = self:GetMirageComponent()
  return mirageCmpt:IsMirageForceClose()
end

function MirageServiceLogic:SetTrapRefreshID(refreshID)
  local mirageCmpt = self:GetMirageComponent()
  mirageCmpt:SetTrapRefreshID(refreshID)
end

function MirageServiceLogic:SetMirageTrapInheritAttributes(attributes)
  local mirageCmpt = self:GetMirageComponent()
  mirageCmpt:SetMirageTrapInheritAttributes(attributes)
end

function MirageServiceLogic:SetMirageBossEntityID(bossEntityID)
  local mirageCmpt = self:GetMirageComponent()
  mirageCmpt:SetMirageBossEntityID(bossEntityID)
end

function MirageServiceLogic:DoMirageCreateTraps()
  local mirageCmpt = self:GetMirageComponent()
  local trapRefreshID = mirageCmpt:GetTrapRefreshID()
  local refreshParam = LevelMonsterRefreshParam:New(self._world)
  local trapInternalIDList = {}
  if 0 < trapRefreshID then
    local trapRefCfg = Cfg.cfg_refresh_trap[trapRefreshID]
    if not trapRefCfg then
      Log.fatal("MirageServiceLogic:CreateTraps Not Find Trap Refresh ID:", trapRefreshID)
    end
    trapInternalIDList = table.cloneconf(refreshParam:ParseTrapRefreshParam(trapRefCfg))
  end
  local entitySvc = self._world:GetService("LogicEntity")
  local inheritAttributes = mirageCmpt:GetMirageTrapInheritAttributes()
  local trapPosTable, eTraps = entitySvc:CreateWaveRefreshTraps(trapInternalIDList, inheritAttributes)
  return eTraps
end

function MirageServiceLogic:DoMirageCalculateTeamMove()
  local mirageCmpt = self:GetMirageComponent()
  local movePos = mirageCmpt:GetMovePos()
  local teamEntity = self._world:Player():GetCurrentTeamEntity()
  if not teamEntity then
    return
  end
  local mirageWalkRes = MirageWalkResult:New()
  local lastPos = teamEntity:GetGridPosition()
  local sBoard = self._world:GetService("BoardLogic")
  local newDirection = movePos - lastPos
  local pets = teamEntity:Team():GetTeamPetEntities()
  for _, entityPet in ipairs(pets) do
    entityPet:SetGridLocation(movePos, newDirection)
    entityPet:GridLocation():SetMoveLastPosition(movePos)
  end
  teamEntity:SetGridLocation(movePos, newDirection)
  teamEntity:GridLocation():SetMoveLastPosition(movePos)
  mirageWalkRes:SetWalkPos(movePos)
  sBoard:UpdateEntityBlockFlag(teamEntity, lastPos, movePos)
  local pieceColor = sBoard:SupplyPieceList({lastPos})[1].color
  sBoard:SetPieceTypeLogic(pieceColor, lastPos)
  mirageWalkRes:SetOldPosColor(pieceColor)
  local colorNew = sBoard:GetPieceType(movePos)
  if sBoard:GetCanConvertGridElementForTeamPos(movePos) then
    colorNew = PieceType.None
  end
  sBoard:SetPieceTypeLogic(colorNew, movePos)
  mirageWalkRes:SetNewPosColor(colorNew)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(teamEntity, TrapTriggerOrigin.Move)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    mirageWalkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
  mirageCmpt:SetWalkResult(mirageWalkRes)
  local svc = self._world:GetService("L2R")
  svc:L2RMirageWalkData(mirageWalkRes)
end

function MirageServiceLogic:DoMirageCastTrapSkill()
  local traps = {}
  local skillLogicService = self._world:GetService("SkillLogic")
  local group = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for i, e in ipairs(group:GetEntities()) do
    local trapCmpt = e:Trap()
    local trapType = trapCmpt:GetTrapType()
    if trapType == TrapType.MirageTrap and not e:HasDeadMark() then
      local skillID = trapCmpt:GetMoveSkillID()
      if skillID and 0 < skillID then
        skillLogicService:CalcSkillEffect(e, skillID)
        skillLogicService:UpdateRenderSkillRoutine(e)
        traps[#traps + 1] = e
      end
    end
  end
  return traps
end

function MirageServiceLogic:DoMirageCastTrapWarningSkill()
  local traps = {}
  local warningPosList = {}
  local skillLogicService = self._world:GetService("SkillLogic")
  local group = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for i, e in ipairs(group:GetEntities()) do
    local trapCmpt = e:Trap()
    local trapType = trapCmpt:GetTrapType()
    if trapType == TrapType.MirageTrap and not e:HasDeadMark() then
      local skillID = trapCmpt:GetWarningSkillID()
      if skillID and 0 < skillID then
        skillLogicService:CalcSkillEffect(e, skillID)
        local skillEffectResultContainer = e:SkillContext():GetResultContainer()
        local effectResult = skillEffectResultContainer:GetEffectResultByArray(SkillEffectType.ShowWarningArea)
        if effectResult then
          local posList = effectResult:GetWarningPosList()
          table.appendArray(warningPosList, posList)
        end
        skillLogicService:UpdateRenderSkillRoutine(e)
        traps[#traps + 1] = e
      end
    end
  end
  local svc = self._world:GetService("L2R")
  svc:L2RMirageWarningData(warningPosList)
  return traps
end

function MirageServiceLogic:DoMirageCastTrapDieSkill()
  local traps = {}
  local skillLogicService = self._world:GetService("SkillLogic")
  local group = self._world:GetGroup(self._world.BW_WEMatchers.TrapID)
  for i, e in ipairs(group:GetEntities()) do
    local trapCmpt = e:Trap()
    local trapType = trapCmpt:GetTrapType()
    if trapType == TrapType.MirageTrap and not e:HasDeadMark() then
      local skillID = trapCmpt:GetDieSkillID()
      if skillID and 0 < skillID then
        skillLogicService:CalcSkillEffect(e, skillID)
        skillLogicService:UpdateRenderSkillRoutine(e)
        traps[#traps + 1] = e
      end
    end
  end
  return traps
end

function MirageServiceLogic:DoMirageBossReturn()
  local skillLogicService = self._world:GetService("SkillLogic")
  local mirageCmpt = self:GetMirageComponent()
  local bossEntityID = mirageCmpt:GetMirageBossEntityID()
  local bossEntity = self._world:GetEntityByID(bossEntityID)
  if bossEntity then
    local utilDataSvc = self._world:GetService("UtilData")
    local skillID = utilDataSvc:GetMonsterBackSkill(bossEntity)
    if skillID and 0 < skillID then
      skillLogicService:CalcSkillEffect(bossEntity, skillID)
      skillLogicService:UpdateRenderSkillRoutine(bossEntity)
    end
  end
  return bossEntity
end
