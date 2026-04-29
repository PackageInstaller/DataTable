require("ai_node_new")
_class("ActionIsEntityInTargetRange", AINewNode)
ActionIsEntityInTargetRange = ActionIsEntityInTargetRange

function ActionIsEntityInTargetRange:OnBegin()
  self._trapID = self:GetLogicData(-1)
  self._monsterClassID = self:GetLogicData(-2)
  self._targetType = self:GetLogicData(-3)
  self._targetTypeParam = self:GetLogicData(-4)
  self._scopeCenterType = self:GetLogicData(-5)
  self._scopeType = self:GetLogicData(-6)
  self._scopeTypeParam = self:GetLogicData(-7)
end

function ActionIsEntityInTargetRange:OnUpdate()
  local aiComponent = self.m_entityOwn:AI()
  local petEntity = aiComponent:GetTargetEntity()
  local petDir = petEntity:GridLocation():GetGridDir()
  local petBodyArea = petEntity:BodyArea():GetArea()
  local petPos = petEntity:GetGridPosition()
  local utilScopeSvc = self._world:GetService("UtilScopeCalc")
  local skillCalc = utilScopeSvc:GetSkillScopeCalc()
  local centerPos, bodyArea = skillCalc._gridFilter:CalcCenterPosAndBodyArea(self._scopeCenterType, petPos, petBodyArea, self._scopeTypeParam)
  local skillScopeResult = skillCalc:ComputeScopeRange(self._scopeType, self._scopeTypeParam, centerPos, bodyArea, petDir, self._targetType, petPos, petEntity)
  local targetEntityIDList = utilScopeSvc:SelectSkillTarget(self.m_entityOwn, self._targetType, skillScopeResult, nil, self._targetTypeParam)
  local trapEntityIDs = {}
  for _, entityID in ipairs(targetEntityIDList) do
    local entity = self._world:GetEntityByID(entityID)
    if entity:HasTrapID() and entity:TrapID():GetTrapID() == self._trapID then
      table.insert(trapEntityIDs, entity:GetID())
      if entity:HasRide() and entity:Ride():GetRiderID() == self.m_entityOwn:GetID() then
        return AINewNodeStatus.Other + AIEntityInTargetRangeType.RideOnTrapInRange
      end
    end
    if entity:HasMonsterID() and entity:MonsterID():GetMonsterClassID() == self._monsterClassID and entity:HasRide() and entity:Ride():GetRiderID() == self.m_entityOwn:GetID() then
      return AINewNodeStatus.Other + AIEntityInTargetRangeType.RideOnMonsterInRange
    end
  end
  if 0 < #trapEntityIDs then
    return AINewNodeStatus.Other + AIEntityInTargetRangeType.NoRideInRange
  end
  return AINewNodeStatus.Other + AIEntityInTargetRangeType.NotInRange
end
