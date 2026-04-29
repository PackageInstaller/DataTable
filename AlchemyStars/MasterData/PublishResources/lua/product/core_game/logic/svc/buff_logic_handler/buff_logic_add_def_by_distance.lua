_class("BuffLogicAddDefByDistance", BuffLogicBase)
BuffLogicAddDefByDistance = BuffLogicAddDefByDistance

function BuffLogicAddDefByDistance:Constructor(buffInstance, logicParam)
  self._mul = logicParam.mul
  self._referenceTrapID = logicParam.referenceTrapID
end

function BuffLogicAddDefByDistance:DoLogic(notify)
  local gridPos
  if "function" == type(notify.GetPos) then
    gridPos = notify:GetPos()
  elseif "function" == type(notify.GetNotifyEntity) then
    local eNotifier = notify:GetNotifyEntity()
    gridPos = eNotifier:GetGridPosition()
  end
  local trapServiceLogic = self._world:GetService("TrapLogic")
  local group = trapServiceLogic:GetTrapGroup()
  local referenceTrapCmpt, referenceTrapEntity
  local traps = group:GetEntities()
  for _, entity in ipairs(traps) do
    local cTrap = entity:Trap()
    if not entity:HasDeadMark() and cTrap:GetTrapID() == self._referenceTrapID then
      referenceTrapCmpt = cTrap
      referenceTrapEntity = entity
      break
    end
  end
  if referenceTrapCmpt then
    local gridLocation = referenceTrapEntity:GetGridPosition()
    local distance = Vector2.Distance(gridLocation, gridPos)
    local intDistance = math.floor(distance + 0.5)
    local mulVal = self._mul[intDistance]
    if not mulVal then
      return
    end
    local cAttribute = self._entity:Attributes()
    local def = cAttribute:GetAttribute("Defense")
    local buffLogicService = self._world:GetService("BuffLogic")
    local buffSeqID = self:GetBuffSeq()
    buffLogicService:RemoveBaseDefence(self._entity, buffSeqID, ModifyBaseDefenceType.DefenceConstantFix)
    local defAdded = math.floor(mulVal * def)
    buffLogicService:ChangeBaseDefence(self._entity, buffSeqID, ModifyBaseDefenceType.DefenceConstantFix, defAdded)
    if self._entity:HasPet() then
      local teamEntity = self._entity:Pet():GetOwnerTeamEntity()
      self:UpdateTeamDefenceLogic(teamEntity)
    end
    local result = {defAdded = defAdded}
  end
end

_class("BuffLogicUndoAddDefByDistance", BuffLogicBase)
BuffLogicUndoAddDefByDistance = BuffLogicUndoAddDefByDistance

function BuffLogicUndoAddDefByDistance:DoLogic()
  local buffSeqID = self:GetBuffSeq()
  local buffLogicService = self._world:GetService("BuffLogic")
  buffLogicService:RemoveBaseDefence(self._entity, buffSeqID, ModifyBaseDefenceType.DefenceConstantFix)
  if self._entity:HasPet() then
    local teamEntity = self._entity:Pet():GetOwnerTeamEntity()
    self:UpdateTeamDefenceLogic(teamEntity)
  end
end
