_class("SkillEffectCalc_MarchForward", Object)
SkillEffectCalc_MarchForward = SkillEffectCalc_MarchForward

function SkillEffectCalc_MarchForward:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_MarchForward:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local param = skillEffectCalcParam:GetSkillEffectParam()
  local maxMarchStep = param:GetMaxMarchStep()
  local marchStepKey = param:GetMarchBuffValueKey()
  if self:IsArriveTargetPos(casterEntity, marchStepKey, maxMarchStep) then
    return
  end
  local step = param:GetStep()
  local dir = param:GetDir()
  local boardSvc = self._world:GetService("BoardLogic")
  local buffCmpt = casterEntity:BuffComponent()
  if not buffCmpt then
    return
  end
  local isCasterDead = false
  local isMarchEnd = false
  local posWalkResultList = {}
  for i = 1, step do
    local posSelf = casterEntity:GetGridPosition()
    local pos = posSelf + dir
    local walkRes = MarchForwardResult:New()
    boardSvc:UpdateEntityBlockFlag(casterEntity, posSelf, pos)
    casterEntity:SetGridPosition(pos)
    casterEntity:SetGridDirection(dir)
    table.insert(posWalkResultList, walkRes)
    walkRes:SetWalkPos(pos)
    self:_OnArrivePos(casterEntity, walkRes)
    if casterEntity:HasDeadMark() then
      isCasterDead = true
      break
    end
    buffCmpt:AddBuffValue(marchStepKey, 1)
    if self:IsArriveTargetPos(casterEntity, marchStepKey, maxMarchStep) then
      local triggerSvc = self._world:GetService("Trigger")
      local nt = NTMarchEnd:New()
      triggerSvc:Notify(nt)
      isMarchEnd = true
      buffCmpt:SetBuffValue(BattleConst.N34BossArriveBuffValueKey, true)
      break
    end
  end
  local result = SkillEffectMarchForwardResult:New(posWalkResultList, isCasterDead, isMarchEnd)
  return {result}
end

function SkillEffectCalc_MarchForward:_OnArrivePos(casterEntity, walkRes)
  local function filter(e)
    if e:HasDeadMark() or e:GetID() == casterEntity:GetID() then
      return false
    end
    if e:HasTeam() or e:HasMonsterID() then
      return true
    end
    return false
  end
  
  local boardEntity = self._world:GetBoardEntity()
  local boardComponent = boardEntity:Board()
  local boardSvc = self._world:GetService("BoardLogic")
  local bodyArea = casterEntity:BodyArea():GetArea()
  local dir = casterEntity:GetGridDirection()
  local curPos = casterEntity:GetGridPosition()
  for _, value in ipairs(bodyArea) do
    local pos = curPos + value
    local entityList = boardComponent:GetPieceEntities(pos, filter)
    for _, e in ipairs(entityList) do
      local posNew = pos + dir
      walkRes:AddMoveEntity(e:GetID(), pos, posNew)
      if e:HasTeam() then
        local teamEntity = e
        local pets = teamEntity:Team():GetTeamPetEntities()
        for _, entity in ipairs(pets) do
          entity:SetGridLocation(posNew, dir)
          entity:GridLocation():SetMoveLastPosition(posNew)
        end
        teamEntity:SetGridLocation(posNew, dir)
        teamEntity:GridLocation():SetMoveLastPosition(posNew)
        boardSvc:RemoveEntityBlockFlag(teamEntity, pos)
        if boardSvc:GetCanConvertGridElement(pos) then
          local tSupplyOld = boardSvc:SupplyPieceList({pos})
          local supplyOld = tSupplyOld[1]
          if supplyOld and supplyOld.color ~= PieceType.None then
            boardSvc:SetPieceTypeLogic(supplyOld.color, pos)
            walkRes:AddConvertInfo(pos, supplyOld.color)
          end
        end
        self:_TriggerTrap(teamEntity, walkRes, TrapTriggerOrigin.Hitback)
        if boardSvc:GetCanConvertGridElement(posNew) then
          boardSvc:SetPieceTypeLogic(PieceType.None, posNew)
          walkRes:AddConvertInfo(posNew, PieceType.None)
        end
        boardSvc:SetEntityBlockFlag(teamEntity, posNew)
      end
    end
  end
  self:_TriggerTrap(casterEntity, walkRes, TrapTriggerOrigin.MonsterGridMove)
end

function SkillEffectCalc_MarchForward:_TriggerTrap(casterEntity, walkRes, triggerOri)
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(casterEntity, triggerOri)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    walkRes:AddTrapSkillResult(trapEntity:GetID(), aiResult, casterEntity:GetID())
  end
end

function SkillEffectCalc_MarchForward:IsArriveTargetPos(casterEntity, buffValueKey, marchStep)
  local buffCmpt = casterEntity:BuffComponent()
  if not buffCmpt then
    return false
  end
  local step = buffCmpt:GetBuffValue(buffValueKey)
  if step and marchStep <= step then
    return true
  end
  return false
end
