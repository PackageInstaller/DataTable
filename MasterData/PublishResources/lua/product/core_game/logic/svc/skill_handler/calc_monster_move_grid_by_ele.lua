_class("SkillEffectCalc_MonsterMoveGridByElement", Object)
SkillEffectCalc_MonsterMoveGridByElement = SkillEffectCalc_MonsterMoveGridByElement

function SkillEffectCalc_MonsterMoveGridByElement:Constructor(world)
  self._world = world
  self._skillEffectService = self._world:GetService("SkillEffectCalc")
end

function SkillEffectCalc_MonsterMoveGridByElement:DoSkillEffectCalculator(skillEffectCalcParam)
  local casterEntity = self._world:GetEntityByID(skillEffectCalcParam:GetCasterEntityID())
  local targetIDList = skillEffectCalcParam:GetTargetEntityIDs()
  local targetID = false
  if table.count(targetIDList) >= 1 then
    targetID = targetIDList[1]
  end
  if not targetID or targetID == -1 then
    Log.fatal("Need Target SkillID", skillEffectCalcParam:GetSkillID())
  end
  local utilCalcSvc = self._world:GetService("UtilCalc")
  local sBoard = self._world:GetService("BoardLogic")
  local element = casterEntity:Element():GetPrimaryType()
  local targetEntity = self._world:GetEntityByID(targetID)
  local movePath = {}
  if not targetEntity:HasDeadMark() then
    movePath = utilCalcSvc:GetMonster2TargetNearestPathByElement(casterEntity, targetID, element)
  end
  local isCasterDead = false
  local posWalkResultList = {}
  if #movePath ~= 0 then
    local oldPosList = {}
    for i, pos in ipairs(movePath) do
      local posSelf = casterEntity:GetGridPosition()
      local walkRes = MonsterWalkResult:New()
      sBoard:UpdateEntityBlockFlag(casterEntity, posSelf, pos)
      casterEntity:SetGridPosition(pos)
      casterEntity:SetGridDirection(pos - posSelf)
      local entityID = casterEntity:GetID()
      table.insert(posWalkResultList, walkRes)
      walkRes:SetWalkPos(pos)
      self:_OnArrivePos(casterEntity, walkRes)
      table.insert(oldPosList, pos)
      if casterEntity:HasDeadMark() then
        isCasterDead = true
        break
      end
    end
  end
  local result = SkillEffectMonsterMoveGridByElementResult:New(posWalkResultList, isCasterDead)
  return {result}
end

function SkillEffectCalc_MonsterMoveGridByElement:_OnArrivePos(casterEntity, walkRes)
  local skillLogicSvc = self._world:GetService("SkillLogic")
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local pos = casterEntity:GetGridPosition()
  local listTrapWork, listTrapResult = trapServiceLogic:TriggerTrapByEntity(casterEntity, TrapTriggerOrigin.ChessMonsterGridMoveByElement)
  for i, e in ipairs(listTrapWork) do
    local trapEntity = e
    local skillEffectResultContainer = listTrapResult[i]
    local aiResult = AISkillResult:New()
    aiResult:SetResultContainer(skillEffectResultContainer)
    walkRes:AddWalkTrap(trapEntity:GetID(), aiResult)
  end
  local nTrapCount = table.count(listTrapWork)
end
