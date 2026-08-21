require("action_is_base")
_class("ActionIs_ValidHitBackPos", ActionIsBase)
ActionIs_ValidHitBackPos = ActionIs_ValidHitBackPos

function ActionIs_ValidHitBackPos:Constructor()
end

function ActionIs_ValidHitBackPos:OnUpdate(dtTime)
  local nSkillID = self:GetLogicData(1)
  local aiCmpt = self.m_entityOwn:AI()
  local posSelf = self.m_entityOwn:GetGridPosition()
  local entityPlayer = aiCmpt:GetTargetDefault()
  local posPlayer = entityPlayer:GetGridPosition()
  local nIsValid = 0
  local entityTarget = aiCmpt:GetTargetEntity()
  local posHitTarget = self:_CalHitTargetPos(posSelf, entityTarget, nSkillID)
  if entityTarget == entityPlayer then
    local posDir = GameHelper.ComputeLogicDir(posPlayer - posSelf)
    local trapServiceLogic = self._world:GetService("TrapLogic")
    local utilSvc = self._world:GetService("UtilData")
    local posTrapPlan = posHitTarget + posDir
    if trapServiceLogic:HasLiveBomb(posTrapPlan) then
      local trapBomb = utilSvc:FindTrapByTypeAndPos(TrapType.BombByHitBack, posTrapPlan)
      if trapBomb and 0 < table.count(trapBomb) then
        self:PrintLog("skillID = ", nSkillID, ", 有效击退点<玩家>", self:_MakePosString(posHitTarget))
        nIsValid = AINewNodeStatus.Success
      else
        self:PrintLog("skillID = ", nSkillID, ", 无效击退点<玩家>", self:_MakePosString(posHitTarget))
        nIsValid = AINewNodeStatus.Failure
      end
    else
      self:PrintLog("skillID = ", nSkillID, ", 有效击退点<玩家>", self:_MakePosString(posHitTarget))
      nIsValid = AINewNodeStatus.Success
    end
  else
    local posBomb = entityTarget:GetGridPosition()
    local bValidPos = self:_IsCanHitBombToPlayer(posSelf, posBomb, posPlayer, self:GetLogicData(-1))
    if bValidPos then
      self:PrintLog("skillID = ", nSkillID, ", 有效击退点<炸弹>", self:_MakePosString(posHitTarget))
      nIsValid = AINewNodeStatus.Success
    else
      self:PrintLog("skillID = ", nSkillID, ", 无效击退点<炸弹>", self:_MakePosString(posHitTarget))
      nIsValid = AINewNodeStatus.Failure
    end
  end
  return nIsValid
end

function ActionIs_ValidHitBackPos:_CalHitTargetPos(posAttacker, entityBomb, nSkillID)
  local posDefender = entityBomb:GetGridPosition()
  local bodyDefender = entityBomb:BodyArea()
  local dir = GameHelper.ComputeLogicDir(posDefender - posAttacker)
  local nHitDistance
  local ignorePlayerBlock = false
  local svcCfgDeco = self._world:GetService("ConfigDecoration")
  local skillEffectArray = svcCfgDeco:GetLatestEffectParamArray(entityBomb:GetID(), nSkillID)
  for i = 1, #skillEffectArray do
    local effectType = skillEffectArray[i]:GetEffectType()
    if effectType == SkillEffectType.HitBack then
      nHitDistance = skillEffectArray[i]:GetDistance()
      break
    end
  end
  nHitDistance = nHitDistance or 9
  local skillEffectService = self._world:GetService("SkillEffectCalc")
  local targetPos = skillEffectService:CalHitbackPosByEntityDir(posDefender, bodyDefender, dir, nHitDistance, {}, ignorePlayerBlock, entityBomb)
  return targetPos
end
