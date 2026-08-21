require("pick_up_policy_base")
_class("PickUpPolicy_PetJocelyn", PickUpPolicy_Base)
PickUpPolicy_PetJocelyn = PickUpPolicy_PetJocelyn

function PickUpPolicy_PetJocelyn:CalcAutoFightPickUpPolicy(calcParam)
  self._petEntity = calcParam.petEntity
  local activeSkillID = calcParam.activeSkillID
  local dirCount = calcParam.policyParam[1]
  local buffEffectID = calcParam.policyParam[2]
  local casterPos = self._petEntity:GetGridPosition()
  local offSets
  if dirCount == 4 then
    offSets = Offset4
  elseif dirCount == 8 then
    offSets = Offset8
  else
    Log.fatal("AutoFight Invalid dirCount,activeSkillID", activeSkillID)
  end
  local boardSvc = self._world:GetService("BoardLogic")
  local maxLen = math.max(boardSvc:GetCurBoardMaxX(), boardSvc:GetCurBoardMaxY())
  self._battleSvc = self._world:GetService("Battle")
  local buffLogicSvc = self._world:GetService("BuffLogic")
  local maxBuffLayerCount = 0
  local pickUpPos, targetID
  for _, offset in ipairs(offSets) do
    local newPos = Vector2(casterPos.x + offset[1], casterPos.y + offset[2])
    for i = 1, maxLen do
      local monsterPos = Vector2(casterPos.x + offset[1] * i, casterPos.y + offset[2] * i)
      local monsterEntityIDList = self:FindMonsterEntityInPos(monsterPos)
      if 0 < #monsterEntityIDList then
        local entity
        if 1 < #monsterEntityIDList then
          entity = self._world:GetEntityByID(monsterEntityIDList[2])
        else
          entity = self._world:GetEntityByID(monsterEntityIDList[1])
        end
        if entity then
          local buffLayerCount = buffLogicSvc:GetBuffLayer(entity, buffEffectID)
          if maxBuffLayerCount <= buffLayerCount then
            maxBuffLayerCount = buffLayerCount
            pickUpPos = newPos
            targetID = monsterEntityIDList[1]
          end
        end
      end
      if boardSvc:IsPosBlock(monsterPos, BlockFlag.LinkLine) then
        break
      end
    end
  end
  if not pickUpPos then
    return {}, {}, {}
  end
  return {pickUpPos}, {pickUpPos}, {targetID}
end

function PickUpPolicy_PetJocelyn:FindMonsterEntityInPos(pos)
  if self._world:MatchType() == MatchType.MT_BlackFist then
    local enemyEntity = self._petEntity:Pet():GetOwnerTeamEntity():Team():GetEnemyTeamEntity()
    if enemyEntity:GetGridPosition() == pos then
      return {
        enemyEntity:GetID()
      }
    else
      return {}
    end
  else
    return self._battleSvc:FindMonsterEntityInPos(pos)
  end
end
