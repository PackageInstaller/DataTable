_class("BuffLogicChangeSkillFinalByTargetEdgeDistance", BuffLogicBase)
BuffLogicChangeSkillFinalByTargetEdgeDistance = BuffLogicChangeSkillFinalByTargetEdgeDistance

function BuffLogicChangeSkillFinalByTargetEdgeDistance:Constructor(buffInstance, logicParam)
  self._distanceRateMap = logicParam.distanceRateMap
  self._effectList = logicParam.effectList
  self._buffInstance.BuffLogicChangeSkillFinalByTargetEdgeDistance_RunCount = 0
end

function BuffLogicChangeSkillFinalByTargetEdgeDistance:DoLogic(notify)
  self._buffInstance.BuffLogicChangeSkillFinalByTargetEdgeDistance_RunCount = self._buffInstance.BuffLogicChangeSkillFinalByTargetEdgeDistance_RunCount + 1
  self._buffInstance._effectList = self._effectList
  if not notify then
    Log.error(self._className, "notify required. ")
    return false
  end
  local def = notify:GetDefenderEntity()
  local eDef
  if type(def) == "number" then
    eDef = self._world:GetEntityByID(def)
  elseif Entity:IsInstanceOfType(def) then
    eDef = def
  end
  local pos = notify:GetTargetPos()
  local boardEntity = self._world:GetBoardEntity()
  local cBoard = boardEntity:Board()
  Log.info(self._className, "targetPos: ", tostring(pos))
  local disX, disY = cBoard:GetGridEdgeDistance(pos)
  if not disX or not disY then
    Log.warn(self._className, "targetPos grid edge distance failed: ", tostring(disX), " ", tostring(disY))
    return false
  end
  local a = disX + disY + 1
  local rate = self._distanceRateMap[a]
  if not rate then
    Log.info(self._className, "empty rate: distanceX = ", disX, " distanceY = ", disY)
    return false
  end
  rate = rate * 0.01
  Log.info(self._className, "rate: ", rate, "distanceX = ", disX, " distanceY = ", disY)
  local val = rate * self._buffInstance.BuffLogicChangeSkillFinalByTargetEdgeDistance_RunCount
  for _, paramType in ipairs(self._effectList) do
    self._buffLogicService:ChangeSkillFinalParam(self._entity, self:GetBuffSeq(), paramType, val)
  end
  local result = BuffResultChangeSkillFinalByTargetEdgeDistance:New(rate, self._effectList, val)
  return result
end

_class("BuffLogicRevertSkillFinalByTargetEdgeDistance", BuffLogicBase)
BuffLogicRevertSkillFinalByTargetEdgeDistance = BuffLogicRevertSkillFinalByTargetEdgeDistance

function BuffLogicRevertSkillFinalByTargetEdgeDistance:DoLogic()
  self._buffInstance.BuffLogicChangeSkillFinalByTargetEdgeDistance_RunCount = 0
  if not self._buffInstance or not self._buffInstance._effectList then
    Log.error(self._className, "unexcepted buff instance data")
  end
  self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), ModifySkillParamType.NormalSkill)
  self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), ModifySkillParamType.ChainSkill)
  self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), ModifySkillParamType.ActiveSkill)
  self._buffLogicService:RemoveSkillFinalParam(self._entity, self:GetBuffSeq(), ModifySkillParamType.MonsterDamage)
end
